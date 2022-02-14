package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.FileHandler;
import java.util.stream.Collectors;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.swagger.util.Json;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.FeatureCollection;
import nl.rivm.nca.api.domain.Features;
import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.LayerObject;
import nl.rivm.nca.api.domain.Measure;
import nl.rivm.nca.api.domain.MeasureCollection;
import nl.rivm.nca.api.domain.MeasureLayer;
import nl.rivm.nca.api.domain.MeasureLayerFile;
import nl.rivm.nca.api.domain.MeasureType;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.pcraster.PcRasterRunner.RunnerType;
import nl.rivm.nca.shared.exception.AeriusException;

/*
 * Run the model with a GEOJson input Source file
 * Use external defined measures for the layers
 */
public class NkModelController {

  private static final int UPSIZE_IN_METERS = 500;
  private static final String JOBLOGGER_TXT = "joblogger.txt";
  private static final Logger LOGGER = LoggerFactory.getLogger(NkModelController.class);

  private static final String SOURCE = "complete_determine_boundingbox";
  private static final String GEOJSON_DOT_EXT = ".geojson";
  private static final String JSON_EXT = "json";
  private static final String CORRECTED = "_corrected_crc";
  private static final String MAP_DOT_EXT = ".map";
  private static final String MEASURE_FILENAME = "measure_";

  private final RasterLayers rasterLayers;
  private final ObjectMapper mapper = new ObjectMapper();
  private final PcRasterRunner pcRasterRunner = new PcRasterRunner();
  private final PreProcessRunner preProcessRunner = new PreProcessRunner();
  private String downloadFileUrl;

  protected static final String PREFIX = "org_";
  protected static final String BASELINE = "baseline";
  protected static final String BASELINE_OUTPUTS = "baseline/outputs";
  protected static final String SCENARIO = "scenario";
  protected static final String SCENARIO_OUTPUTS = "scenario/outputs";
  protected static final String DIFF = "diff";
  protected static final String NKMODEL_MEASURE_EXPORT = "_measures.json";
  protected static final String NKMODEL_SCENARIO_EXPORT = "_scenario.json";
  protected static final String NKMODEL_RESULT_EXPORT = "_result.json";

  public NkModelController(File path) throws IOException, InterruptedException {
    rasterLayers = RasterLayers.loadRasterLayers(path);
  }

  public List<AssessmentResultResponse> run(final String correlationId, final MeasureCollection measureCollection, final Boolean jobRerun, 
      final FeatureCollection features, final List<ValidationMessage> warnings)
      throws IOException, ConfigurationException, InterruptedException, AeriusException {
    
    final Path path = Paths.get("/tmp/" + correlationId);
    final File workingPath;
    if (jobRerun) {
      workingPath = path.toFile();
    } else {
      workingPath = Files.createDirectory(path).toFile();
    }   
    FileWriteUtil.adjustRights(workingPath); // want to access with docker change rights

    long start = System.currentTimeMillis();
    long lastTime = start;
    final FileHandler jobLoggerFile = new FileHandler(workingPath + "/" + JOBLOGGER_TXT, true);
    java.util.logging.Logger jobLogger = LoggerUtil.createJobLogger(jobLoggerFile, start);
    LOGGER.info(jobRerun ? "=== Run the model by resusing the files. ===" : "=== Run new model. ===");
    
    // write input geojson to temp directory and copy runner files
    FileWriteUtil.createScenarioFile(workingPath, Json.pretty(features), NKMODEL_SCENARIO_EXPORT);
    FileWriteUtil.copyRunnerFiles(workingPath, jobLogger);
    FileWriteUtil.writeMeasureCollectionToFile(Json.pretty(measureCollection), NKMODEL_MEASURE_EXPORT, workingPath, jobLogger);
   
    lastTime = LoggerUtil.writeTimeToJobLogger("Time to prepaire workingdiretory and copy used model data", start, jobLogger);
     
    final HashMap<MeasureType, ArrayList<Features>> measures = groupFeaturesOnMeasureAndExport(features, measureCollection, workingPath, jobLogger);

    // load first exported and corrected crc file to determine bounding box and UPSIZE_IN_METERS
    LOGGER.info("=== Create extend and upsize. ===");
    exportFeatureForBoudingBox(features, measureCollection,  workingPath, jobLogger);
    final Envelope2D extend = determineBoundingBoxForFileName(SOURCE, workingPath, jobLogger);
    LoggerUtil.info("working with exted " + extend, jobLogger);
    
    final Map<Layer, String> layerFiles = rasterLayers.getLayerFiles("air_regulation"); // get all files voor eco system    
    final Map<Layer, String> userLayers = determineUsedLayers(measureCollection, layerFiles);
    
    lastTime = LoggerUtil.writeTimeToJobLogger("Time to group measures determine exstend", lastTime, jobLogger);

    File scenarioPath;
    File baseLinePath;
    File baseLineOutputPath;
    File scenarioOutputPath;
    File diffPath;
    
    if (jobRerun) {
      scenarioPath = Paths.get(workingPath.getAbsolutePath(), SCENARIO).toFile();
      baseLinePath = Paths.get(workingPath.getAbsolutePath(), BASELINE).toFile();
      baseLineOutputPath = Paths.get(workingPath.getAbsolutePath(), BASELINE_OUTPUTS).toFile();
      scenarioOutputPath = Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS).toFile();
      diffPath = Paths.get(workingPath.getAbsolutePath(), DIFF).toFile();
    } else {
      scenarioPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO)).toFile();
      baseLinePath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE)).toFile();
      baseLineOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE_OUTPUTS)).toFile();
      scenarioOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS)).toFile();
      diffPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), DIFF)).toFile();
    }

    List<AssessmentResultResponse> assessmentResultlist = new ArrayList<AssessmentResultResponse>();

    if (!jobRerun) {
      LoggerUtil.info("Cut out the charts for baseline", jobLogger);
      cookieCutAllLayersToBaseLinePath(baseLinePath, layerFiles, extend, jobLogger);
      lastTime =LoggerUtil.writeTimeToJobLogger("Time new model cut out baseline", lastTime, jobLogger);
      LoggerUtil.info("Copy files from baseline to scenario", jobLogger);
      FileUtils.copyDirectory(baseLinePath, scenarioPath);
      lastTime = LoggerUtil.writeTimeToJobLogger("Time to copy to scenario", lastTime, jobLogger);
      
    } else {
      LoggerUtil.info("Copy file from baseline to scenario for rerun of the model", jobLogger);
      cleanUp(scenarioPath, true);
      cleanUp(diffPath, true);
      FileUtils.copyDirectory(baseLinePath, scenarioPath);
      cleanUp(scenarioOutputPath, true);
      scenarioOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS)).toFile();
      diffPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), DIFF)).toFile();
      lastTime = LoggerUtil.writeTimeToJobLogger("Time model rerun clean scenario and copy baseline", lastTime, jobLogger);
      
    }

    float totalSeconds;
    final File projectFileScenario = ProjectIniFile.generateIniFile(scenarioPath.getAbsolutePath(), scenarioOutputPath.getAbsolutePath());
    final File projectFileBaseLine = ProjectIniFile.generateIniFile(baseLinePath.getAbsolutePath(), baseLineOutputPath.getAbsolutePath());
    if (!measures.isEmpty() ) {
      LoggerUtil.info("Overlay the corrected json onto the map file " + extend, jobLogger);
      overlayGeoJsonOnMap(workingPath, scenarioPath, measureCollection, measures, userLayers, extend, jobLogger);
      lastTime = LoggerUtil.writeTimeToJobLogger("Time to overlay the corrected json onto the map file ", lastTime, jobLogger);
      
      LOGGER.info("=== Run the actual model nkmodel with pcRaster batch file. ===");
      runPcRaster(correlationId, "air_regulation", projectFileScenario, projectFileBaseLine, scenarioOutputPath,
          baseLineOutputPath, diffPath, jobRerun ? RunnerType.RUNNER_SCENARIO : RunnerType.RUNNER, jobLogger);
      lastTime = LoggerUtil.writeTimeToJobLogger("Time run the model", lastTime, jobLogger);
      
      LOGGER.info("=== Load the generated json result files ===");
      assessmentResultlist = importJsonResult(correlationId, diffPath, jobLogger);
      createScenarioFile(workingPath, Json.pretty(assessmentResultlist), NKMODEL_RESULT_EXPORT);
      LoggerUtil.info("Show json result", jobLogger);
      LoggerUtil.info(Json.pretty(assessmentResultlist), jobLogger);
      lastTime = LoggerUtil.writeTimeToJobLogger("Time run determine json results", lastTime, jobLogger);
      
      // close jobLogger
      totalSeconds = LoggerUtil.closeJobLogger(jobLogger, jobLoggerFile, start);
  
      // create zip file in server environment for download 
      LoggerUtil.info("Zip content and move to download location", jobLogger);
      String fileName = FileWriteUtil.zipResult(correlationId, workingPath);
      setDownloadFileUrl(EnvironmentEnum.NCA_DOWNLOAD_URL.getEnv() + "/" + fileName);
  
      cleanUp(workingPath, false);
      
    } else {
      LOGGER.info("=== Run the actual model nkmodel with pcRaster batch file only for baseline. ===");
      runPcRaster(correlationId, "air_regulation", projectFileScenario, projectFileBaseLine, scenarioOutputPath,
          baseLineOutputPath, diffPath, RunnerType.RUNNER_BASELINE, jobLogger);
      lastTime = LoggerUtil.writeTimeToJobLogger("Time run the model", lastTime, jobLogger);
      
      // close jobLogger
      lastTime = LoggerUtil.writeTimeToJobLogger("Time it took with no model run", lastTime, jobLogger);
      totalSeconds = LoggerUtil.closeJobLogger(jobLogger, jobLoggerFile, start);
      warnings.add(new ValidationMessage().code(3).message("Rerun of model jobKey " + correlationId));
    }

    warnings.add(new ValidationMessage().code(3).message("Total excecution time " + totalSeconds + " seconds"));
    warnings.add(new ValidationMessage().code(4).message("api-version=" + EnvironmentEnum.APIVERSION.getEnv()));
    warnings.add(new ValidationMessage().code(5).message("nkm-version=" + EnvironmentEnum.NKMVERSION.getEnv()));
    return assessmentResultlist;
  }

  private void overlayGeoJsonOnMap(final File workingPath, final File scenarioPath, MeasureCollection measuresLayers,
      HashMap<MeasureType, ArrayList<Features>> measures, final Map<Layer, String> layerFiles, final Envelope2D extend,
      java.util.logging.Logger jobLogger)
      throws IOException {

    // create a object that burns the measure in correct order over the map files
    jobLogger.info("=== Overlay the corrected json onto the map file ===");
    File projectlayer = null;
    ArrayList<LayerObject> suppliedLayers = new ArrayList<LayerObject>();
    applyProjectAndMeasureOnLayers(layerFiles, projectlayer, suppliedLayers, measures, measuresLayers, extend, workingPath, scenarioPath, jobLogger);

  }

  /** 
   * Get a list of used layers from the measures
   * 
   * @param measuresLayers
   * @param layerFiles 
   * @return
   */
  private Map<Layer, String> determineUsedLayers(MeasureCollection measuresLayers, Map<Layer, String> layerFiles) {
    final Map<Layer, String> usedLayers = new HashMap<>();
    for (Measure mlayer : measuresLayers.getMeasures()) {
      for (MeasureLayer layer : mlayer.getLayers()) {
        if (layer.getLayer() != null && !usedLayers.containsValue(layer.getLayer())) {
          usedLayers.put(layer.getLayer(), layerFiles.get(Layer.fromValue(layer.getLayer().toString())));
        }
      }
    }
    return usedLayers;
  }
  
  private Envelope2D determineBoundingBoxForFileName(final String source, final File workingPath, final java.util.logging.Logger jobLogger)
      throws IOException {
    Envelope2D extend = new Envelope2D();
    final String inputFileName = MEASURE_FILENAME + source + CORRECTED + GEOJSON_DOT_EXT;
    final File geoJsonFile = new File(workingPath, inputFileName);
    FileReader fr = new FileReader(geoJsonFile.getAbsolutePath());
    int i;
    String body = "";
    while ((i = fr.read()) != -1)
      body += (char) i;
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    FeatureCollection geojson = mapper.readValue(body, FeatureCollection.class);
    List<BigDecimal> bbox = geojson.getBbox();
    jobLogger.info("bbox from geosjon [" + bbox.get(0) + " ," + bbox.get(1) + "] [" + bbox.get(2) + " ," + bbox.get(3) + "] ");
    extend.include(extendBbox(bbox.get(0).doubleValue(), -UPSIZE_IN_METERS), extendBbox(bbox.get(1).doubleValue(), +UPSIZE_IN_METERS));
    extend.include(extendBbox(bbox.get(2).doubleValue(), +UPSIZE_IN_METERS), extendBbox(bbox.get(3).doubleValue(), -UPSIZE_IN_METERS));
    return extend;
  }

  private double extendBbox(double value, int enlarge) {
    return (Math.round(value / 10) * 10) + enlarge;
  }

  private void createScenarioFile(File workingPath, String request, String fileName) {
    FileWriter fileWriter = null;

    try {
      fileWriter = new FileWriter(workingPath + "/" + fileName);
      fileWriter.write(request);

    } catch (IOException e) {
      LOGGER.warn("Writing to the file failure " + e.getMessage());
    } finally {
      if (fileWriter != null) {
        try {
          fileWriter.close();
        } catch (IOException e) {
          LOGGER.warn("Closing the file failure");
        }
      }
    }
  }

  /**
   * Get the corrected GeoJson and burn it over the map file with the given parameter
   */
  private void applyProjectAndMeasureOnLayers(Map<Layer, String> layerFiles, File projectlayer, ArrayList<LayerObject> suppliedLayers,
      HashMap<MeasureType, ArrayList<Features>> measures, MeasureCollection measuresLayers, Envelope2D extend,
      File workingPath, File scenarioPath, java.util.logging.Logger jobLogger) throws IOException {

    for (Map.Entry<MeasureType, ArrayList<Features>> m : measures.entrySet()) {
      LOGGER.debug("process measure {} {}", m.getKey());
      final String ouputfileName = MEASURE_FILENAME + m.getKey().toString() + CORRECTED + GEOJSON_DOT_EXT;
      final File geoJsonFileOutput = new File(workingPath, ouputfileName);

      // find out how many layers must be created for this measure 
      List<MeasureLayer> measureLayers = new ArrayList<MeasureLayer>();
      Measure currentMeasure = null;
      for (Measure am : measuresLayers.getMeasures()) {
        if (am.getCode() == m.getKey()) {
          currentMeasure = am;
          measureLayers = am.getLayers();
          break;
        }
      }

      if (currentMeasure != null && currentMeasure.isRunmodel()) {
        LOGGER.debug("measure {} layer values {}", m.getKey(), measureLayers);

        // we need to sort on value low to high
        jobLogger.info("unsorted :");
        jobLogger.info(measureLayers.toString());

        // the order for this list must be determined the value low to high
        // we burn in this order and highest value must is leading when overlapping
        measureLayers.sort(new Comparator<MeasureLayer>() {

          @Override
          public int compare(MeasureLayer o1, MeasureLayer o2) {
            return (int) o1.getValue().compareTo(o2.getValue());

          }
        });

        jobLogger.info("sorted :");
        jobLogger.info(measureLayers.toString());

        for (MeasureLayer ml : measureLayers) {
          if (ml.getValue() != null) {
            String layerFileName = layerFiles.get(Layer.fromValue(ml.getLayer().toString()));
            final String outputfileName = layerFileName;
            File mapFileToBurn = new File(scenarioPath, outputfileName + MAP_DOT_EXT);
            // burn geosjon onto the map outputFileName
            jobLogger.info("burn geojson " + geoJsonFileOutput + " on the map file " + mapFileToBurn);
            BurnGeoJsonOnMap.run(geoJsonFileOutput, mapFileToBurn, ml.getValue(), extend, jobLogger);
          }
        }
      } else {
        jobLogger.info("we skipped measure " + currentMeasure);
      }
    }
  }

  private HashMap<MeasureType, ArrayList<Features>> groupFeaturesOnMeasureAndExport(FeatureCollection features, MeasureCollection measuresLayers,
      File workingPath, java.util.logging.Logger jobLogger) {
    jobLogger.info("=== Group features on measure and export ===");
    HashMap<MeasureType, ArrayList<Features>> measures = groupFeaturesonMeasure(features, measuresLayers);
    FeatureUtil.exportGroupedFeatures(measures, features, workingPath, jobLogger);
    jobLogger.info("=== Convert the json to corrected crc Amersfoort ===");
    correctAllCrc(measures, workingPath, jobLogger);
    return measures;
  }
  
  private void exportFeatureForBoudingBox(FeatureCollection features, MeasureCollection measuresLayers,
      File workingPath, java.util.logging.Logger jobLogger) throws IOException {
    jobLogger.info("=== Group features on measure and export ===");
    final String fileName = MEASURE_FILENAME + SOURCE + GEOJSON_DOT_EXT;
    ArrayList<Features> featuresAsArray = new ArrayList<Features>() ; //(ArrayList<Features>) features.getFeatures();

    // add dummy feature polygon based on geometry of bbox
    Features f = new Features();
    BigDecimal x1 = features.getBbox().get(0);
    BigDecimal y1 = features.getBbox().get(1);
    BigDecimal x2 = features.getBbox().get(2);
    BigDecimal y2 = features.getBbox().get(3);
    String geoTxt = "{\"id\": \"0\", \"type\": \"Feature\", \"properties\" : { \"measure\": \"PROJECT\", \"isProjectArea\": true }," +
        "\"geometry\": {\"type\": \"Polygon\", \"coordinates\": [["
        + "[" + x1.toString() + "," + y2.toString() + "],"
        + "[" + x2.toString() + "," + y2.toString() + "],"
        + "[" + x2.toString() + "," + y1.toString() + "],"
        + "[" + x1.toString() + "," + y1.toString() + "],"
        + "[" + x1.toString() + "," + y2.toString() + "]"
        + "]]}}";
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    mapper.configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
    Features geojson = mapper.readValue(geoTxt, Features.class);
    featuresAsArray.add(geojson);
      
    FeatureUtil.exportFeatures(fileName, featuresAsArray, features, workingPath, jobLogger);
    correctCrc(SOURCE, workingPath, jobLogger);
  }

  private void correctAllCrc(final HashMap<MeasureType, ArrayList<Features>> measures, final File workingPath, 
      java.util.logging.Logger jobLogger) {
    for (Map.Entry m : measures.entrySet()) {
      correctCrc(m.getKey().toString(), workingPath, jobLogger);
    }
  }
  
  private void correctCrc(final String key, final File workingPath, java.util.logging.Logger jobLogger) {
    final String inputfileName = MEASURE_FILENAME + key + GEOJSON_DOT_EXT;
    final String ouputfileName = MEASURE_FILENAME + key + CORRECTED + GEOJSON_DOT_EXT;
    final File geoJsonFileInput = new File(workingPath, inputfileName);
    final File geoJsonFileOutput = new File(workingPath, ouputfileName);
    // convert geojson to correct crs keep original
    jobLogger.info("convert to crs " + geoJsonFileInput + " " + geoJsonFileOutput);
    try {
      GeoJson2CorrectCRS.geoJsonConvert(geoJsonFileInput, geoJsonFileOutput, jobLogger, workingPath.toString());
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  private HashMap<MeasureType, ArrayList<Features>> groupFeaturesonMeasure(FeatureCollection features, MeasureCollection measuresLayers) {
    HashMap<MeasureType, ArrayList<Features>> measures = new HashMap<MeasureType, ArrayList<Features>>();
    if (features.getFeatures() != null) {
      for (Features feature : features.getFeatures()) {
        // backward compatible use measureid or measure
        MeasureType measure = null;
        if (feature.getProperties().getMeasureId() != null) {
          for (Measure m : measuresLayers.getMeasures()) {
            if (m.getId() != null && m.getId().equals(feature.getProperties().getMeasureId())) {
              measure = m.getCode();
              break;
            }
          }
        } else {
          measure = feature.getProperties().getMeasure() == null
              || feature.getProperties().getMeasure().equals("PROJECT")
                  ? MeasureType.PROJECT
                  : feature.getProperties().getMeasure();
        }

        if (measure != null) {
          ArrayList<Features> measureValue = measures.get(measure);
          LOGGER.debug("add measure {} value {}", measureValue, feature.getGeometry().getType());
          if (measureValue == null) {
            ArrayList<Features> list = new ArrayList<Features>();
            list.add(feature);
            measures.put(measure, list);
          } else {
            measureValue.add(feature);
          }
        } else {
          LOGGER.info("skipping " + feature);
        }
      }
    }
    return measures;
  }

  /**
   * loop through the user supplied measure layers and overlay them
   * in the input layer map.
   * We can apply more than one measure to the scenario map file
   * It is possible that they overlap last in will determine values
   *     
   */
  protected void prePrepocessSenarioMap(Map<Layer, String> layerFiles, File workingPath, List<MeasureLayerFile> measureLayerFiles, String prefix,
      java.util.logging.Logger jobLogger) throws IOException {

    jobLogger.info("unsorted :");
    jobLogger.info(measureLayerFiles.toString());

    // the order for this list must be determined the Layer + measureLayerValue low to high
    measureLayerFiles.sort(new Comparator<MeasureLayerFile>() {

      @Override
      public int compare(MeasureLayerFile o1, MeasureLayerFile o2) {
        return (int) o1.getLayer().toString().compareTo(o2.getLayer().toString()) +
            (int) o1.getMeasureLayerValue().compareTo(o2.getMeasureLayerValue());

      }
    });

    jobLogger.info("sorted :");
    jobLogger.info(measureLayerFiles.toString());

    for (MeasureLayerFile measureLayerFile : measureLayerFiles) {
      Layer layer = measureLayerFile.getLayer();
      File tiffFile = new File(measureLayerFile.getFile());

      // create extra file
      final File mapFile = new File(workingPath, prefix + layerFiles.get(layer) + MAP_DOT_EXT); // original to overwrite
      final File editMapFilePath = new File(tiffFile.getAbsolutePath().replace(".tif", "_edit.map").replace("org_", ""));
      jobLogger.info("Create overlay map file from " + layer + " from file " + tiffFile.getAbsolutePath() + " to map " + editMapFilePath);
      Geotiff2PcRaster.geoTiff2PcRaster(tiffFile, editMapFilePath, jobLogger); // create map file from tiff

      try {
        // overlay multiple changes to the scenario map
        preProcessRunner.runPreProcessorTiffToMap("", mapFile, editMapFilePath, prefix, jobLogger);
      } catch (final IOException | InterruptedException e) {
        e.printStackTrace();
      }

    }
  }

  protected void runPcRaster(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine,
      File workingPathScenario, File workingPathBaseLine, File projectPathDiff, RunnerType runnerType, java.util.logging.Logger jobLogger)
      throws IOException, InterruptedException {
    pcRasterRunner.runPcRaster(correlationId, ecoSystemService, projectFileScenario, projectFileBaseLine, workingPathScenario, workingPathBaseLine,
        projectPathDiff, runnerType, jobLogger);
  }

  protected void cookieCutAllLayersToBaseLinePath(File workingPath, Map<Layer, String> layerFiles,
      Envelope2D extend, java.util.logging.Logger jobLogger) throws IOException {
    final CookieCut cc = new CookieCut(workingPath.getAbsolutePath());
    // create all source files
    layerFiles.entrySet().stream().forEach(e -> {
      try {
        final String sourceFile = e.getValue();

        cc.run(rasterLayers.mapOriginalFilePath(sourceFile), rasterLayers.mapFilePath(workingPath, sourceFile), extend, jobLogger);
      } catch (IOException | InterruptedException e1) {
        e1.printStackTrace();
      }
    });
  }

  protected void cookieCutOtherLayersToWorkingPath(File workingPath, Map<Layer, String> layerFiles,
      List<LayerObject> userLayers, Envelope2D extend, java.util.logging.Logger jobLogger) throws IOException {
    final CookieCut cc = new CookieCut(workingPath.getAbsolutePath());
    final Set<String> userDefinedClasses = userLayers.stream().map(ul -> ul.getClassType())
        .collect(Collectors.toSet());
    // create all source files, including supplied
    layerFiles.entrySet().stream().filter(e -> !userDefinedClasses.contains(e.getKey())).forEach(e -> {
      try {
        final String sourceFile = e.getValue();

        cc.run(rasterLayers.mapOriginalFilePath(sourceFile), rasterLayers.mapFilePath(workingPath, sourceFile), extend, jobLogger);
      } catch (IOException | InterruptedException e1) {
        e1.printStackTrace();
      }
    });
  }

  protected List<AssessmentResultResponse> importJsonResult(String correlationId, File outputPath, java.util.logging.Logger jobLogger)
      throws IOException {
    List<AssessmentResultResponse> returnList = new ArrayList<AssessmentResultResponse>();
    Files.list(outputPath.toPath()).forEach(System.out::println);
    // for each name in the path array
    Files.list(outputPath.toPath()).filter(f -> JSON_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
        .forEach(f -> {
          try {
            LOGGER.info("read result file {} {}", f.toFile().getAbsolutePath(), f.getFileName());
            if (jobLogger != null) {
              jobLogger.info("Read json result path: " + f.toFile().getAbsolutePath() + " file: " + f.getFileName());
            }
            @SuppressWarnings("resource")
            FileReader fr = new FileReader(f.toFile().getAbsolutePath());
            int i;
            String body = "";
            while ((i = fr.read()) != -1)
              body += (char) i;
            body = body.replace("nan", "0");
            mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            AssessmentResultResponse result = mapper.readValue(body, AssessmentResultResponse.class);
            filterResult(result);
            returnList.add(result);
            LOGGER.info("content of file for correlationId {} content {}", correlationId, result.toString());
            if (jobLogger != null) {
              jobLogger.info("Content of result file " + result.toString());
            }

          } catch (final Exception e) {
            // eat error
            LOGGER.warn("Reading and parsing of json failed {}", e.getMessage());
          }
        });
    return returnList;
  }

  private void filterResult(AssessmentResultResponse result) {
    result.name(result.getName().replaceAll("\\[.*\\]", ""));
    result.units(result.getUnits().replace("[", "").replace("]", "").replace("Euros", "Euro/jaar"));
  }

  protected void cleanUp(File dir, Boolean remove) throws IOException {
    if (remove) {
      FileWriteUtil.deleteDirectoryRecursively(dir);
    }
  }

  public String getDownloadFileUrl() {
    return downloadFileUrl;
  }

  public void setDownloadFileUrl(String url) {
    this.downloadFileUrl = url;
  }
}
