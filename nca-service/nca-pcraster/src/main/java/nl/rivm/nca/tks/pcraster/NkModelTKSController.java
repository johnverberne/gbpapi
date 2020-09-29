package nl.rivm.nca.tks.pcraster;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.logging.FileHandler;
import java.util.logging.Formatter;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.stream.Collectors;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import io.swagger.util.Json;
import nl.rivm.nca.api.domain.AssessmentTKSResultResponse;
import nl.rivm.nca.api.domain.FeatureCollection;
import nl.rivm.nca.api.domain.FeatureCollection.TypeEnum;
import nl.rivm.nca.api.domain.Features;
import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.LayerObject;
import nl.rivm.nca.api.domain.Measure;
import nl.rivm.nca.api.domain.MeasureCollection;
import nl.rivm.nca.api.domain.MeasureLayer;
import nl.rivm.nca.api.domain.MeasureLayerFile;
import nl.rivm.nca.api.domain.MeasureType;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.pcraster.BurnGeoJsonOnTiff;
import nl.rivm.nca.pcraster.CookieCut;
import nl.rivm.nca.pcraster.GeoJson2CorrectCRS;
import nl.rivm.nca.pcraster.Geotiff2PcRaster;
import nl.rivm.nca.pcraster.ProjectIniFile;
import nl.rivm.nca.pcraster.RasterLayers;
import nl.rivm.nca.pcraster.RunnerEnum;
import nl.rivm.nca.shared.exception.AeriusException;

/*
 * Run the model with a GEOJson input Source file
 * Use external defined measures for the layers
 */
public class NkModelTKSController {

  private static final int UPSIZE_IN_METERS = 500;
  private static final String JOBLOGGER_TXT = "joblogger.txt";
  private static final Logger LOGGER = LoggerFactory.getLogger(NkModelTKSController.class);

  private static final String GEOJSON_DOT_EXT = ".geojson";
  private static final String JSON_EXT = "json";
  private static final String TIF_DOT_EXT = ".tif";
  private static final String CORRECTED = "_corrected_crc";
  private static final String MAP_DOT_EXT = ".map";
  private static final String MEASURE_FILENAME = "measure_";
  
  private final RasterLayers rasterLayers;
  private final ObjectMapper mapper = new ObjectMapper();
  private final PcRasterRunnerTKS pcRasterRunner = new PcRasterRunnerTKS();
  private final PreProcessTKSRunner preProcessRunner = new PreProcessTKSRunner();
  
  protected static final String PREFIX = "org_";
  protected static final String BASELINE = "baseline";
  protected static final String BASELINE_OUTPUTS = "baseline/outputs";
  protected static final String SCENARIO = "scenario";
  protected static final String SCENARIO_OUTPUTS = "scenario/outputs";
  protected static final String DIFF = "diff";
  protected static final String NKMODEL_SCENARIO_EXPORT = "tks_scenarion.json";

  public NkModelTKSController(File path) throws IOException, InterruptedException {
    rasterLayers = RasterLayers.loadRasterLayers(path);
  }

  public List<AssessmentTKSResultResponse> run(String correlationId, FeatureCollection features, List<ValidationMessage> warnings)
      throws IOException, ConfigurationException, InterruptedException, AeriusException {
    final File workingPath = Files.createTempDirectory(correlationId).toFile(); // UUID.randomUUID().toString()
    adjustRights(workingPath); // want to access with docker change rights

    long start = System.currentTimeMillis();
    FileHandler jobLoggerFile = new FileHandler(workingPath + "/" + JOBLOGGER_TXT, true);
    java.util.logging.Logger jobLogger = createJobLogger(jobLoggerFile, start);

    // write input geojson to temp directory and copy runner files
    createScenarionFile(workingPath, features);
    copyRunnerFiles(workingPath, jobLogger);

    MeasureCollection measuresLayers = TksMeasures.load();
    HashMap<MeasureType, ArrayList<Features>> measures = groupFeaturesOnMeasureAndExport(features, measuresLayers, workingPath, jobLogger);
  
    // load first exported and corrected crc file to determine bounding box and add 1000 meter
    Envelope2D extend = determineBoundingBox(measures, workingPath, jobLogger);

    final Map<Layer, String> layerFiles = rasterLayers.getLayerFiles("air_regulation"); // get all files voor eco system
    final File scenarioPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO)).toFile();
    final Map<Layer, String> usedLayers = determineUsedLayers(measuresLayers, layerFiles);

    jobLogger.info("working with exted " + extend);

    final File baseLinePath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE)).toFile();
    final File baseLineOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE_OUTPUTS)).toFile();
    final File scenarioOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS)).toFile();
    final File diffPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), DIFF)).toFile();

    List<AssessmentTKSResultResponse> assessmentResultlist = new ArrayList<AssessmentTKSResultResponse>();

    jobLogger.info("=== Cut out the charts for scenario ===");
    cookieCutOtherLayersToWorkingPath(scenarioPath, layerFiles, new ArrayList<LayerObject>(), extend, jobLogger);
    jobLogger.info("=== Cut out the charts for baseline ===");
    cookieCutAllLayersToBaseLinePath(baseLinePath, layerFiles, extend, jobLogger);

    jobLogger.info("=== Overlay the corrected json onto the tiff  ===");
    overlayGeoJsonOnTiff(workingPath, scenarioPath, measuresLayers, measures, usedLayers, extend, jobLogger);

    final File projectFileScenario = ProjectIniFile.generateIniFile(scenarioPath.getAbsolutePath(), scenarioOutputPath.getAbsolutePath());
    final File projectFileBaseLine = ProjectIniFile.generateIniFile(baseLinePath.getAbsolutePath(), baseLineOutputPath.getAbsolutePath());
    
    LOGGER.info("=== Run the actual model nkmodel with pcRaster batch file. ===");
    runPcRaster2(correlationId, "air_regulation", projectFileScenario, projectFileBaseLine, scenarioOutputPath,
        baseLineOutputPath, diffPath, jobLogger);

    LOGGER.info("=== Load the generated json result files ===");
    assessmentResultlist = importJsonResult(correlationId, diffPath, jobLogger);
    
    cleanUp(workingPath, false);

    jobLogger.info("=== Show json result ===");
    jobLogger.info(Json.pretty(assessmentResultlist));
    float totSec = closeJobLogger(jobLogger, jobLoggerFile, start);
    warnings.add(new ValidationMessage().code(3).message("Total excecution time " + totSec + " seconds"));
    return assessmentResultlist;
  }

  private void overlayGeoJsonOnTiff(final File workingPath, final File scenarioPath, MeasureCollection measuresLayers,
      HashMap<MeasureType, ArrayList<Features>> measures, final Map<Layer, String> layerFiles, final Envelope2D extend,
      java.util.logging.Logger jobLogger)
      throws IOException {
    
    // create tiff from map layer files
    jobLogger.info("=== convert map files to tiff file ===");
    for (Entry<Layer, String> layer : layerFiles.entrySet()) {
      try {
        String inputFile = scenarioPath.getAbsolutePath() + "/" + layer.getValue() + MAP_DOT_EXT;
        String outputFile = scenarioPath.getAbsolutePath() + "/" + "measure_" + layer.getValue() + TIF_DOT_EXT;
        jobLogger.info("map " + inputFile + " to tif" + outputFile);
        Geotiff2PcRaster.pcRaster2GeoTiff(new File(inputFile), new File(outputFile), jobLogger);
      } catch (final IOException e) {
        throw new RuntimeException(e);
      }
    }

    jobLogger.info("=== temporay create extra version from map files to tiff file called org_ ===");
    for (Entry<Layer, String> layer : layerFiles.entrySet()) {
      try {
        String inputFile = scenarioPath.getAbsolutePath() + "/" + layer.getValue() + MAP_DOT_EXT;
        String outputFile = scenarioPath.getAbsolutePath() + "/" + "org_" + layer.getValue() + TIF_DOT_EXT;
        jobLogger.info("map " + inputFile + " to tif" + outputFile);
        Geotiff2PcRaster.pcRaster2GeoTiff(new File(inputFile), new File(outputFile), jobLogger);
      } catch (final IOException e) {
        throw new RuntimeException(e);
      }
    }
    
    // create a object that burns the measure in correct order over the layers
        
    
    // burn the json onto the tiff file
    jobLogger.info("=== Overlay the corrected json onto the tiff map ===");
    File projectlayer = null;
    ArrayList<LayerObject> suppliedLayers = new ArrayList<LayerObject>();
    applyProjectAndMeasureOnLayers(layerFiles, projectlayer, suppliedLayers, measures, measuresLayers, extend, workingPath, scenarioPath, jobLogger);

    // convert the tif file to map file for model.
    jobLogger.info("=== convert the overlayed tiff files to map file for input of the model ===");
    for (Entry<Layer, String> layer : layerFiles.entrySet()) {
      try {
        String outputFile = scenarioPath.getAbsolutePath() + "/" + "" + layer.getValue() + MAP_DOT_EXT;
        String inputFile = scenarioPath.getAbsolutePath() + "/" + "measure_" + layer.getValue() + TIF_DOT_EXT;
        jobLogger.info("map " + inputFile + " to tif" + outputFile);
        Geotiff2PcRaster.geoTiff2PcRaster(new File(inputFile), new File(outputFile), jobLogger);
      } catch (final IOException e) {
        throw new RuntimeException(e);
      }
    }
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
        if (!usedLayers.containsValue(layer.getLayer())) {
          usedLayers.put(layer.getLayer(), layerFiles.get(Layer.fromValue(layer.getLayer().toString())));
        }
      }
    }
    return usedLayers;
  }

  private Envelope2D determineBoundingBox(HashMap<MeasureType, ArrayList<Features>> measures, File workingPath, java.util.logging.Logger jobLogger)
      throws IOException {
    Envelope2D extend = new Envelope2D();
    for (Map.Entry m : measures.entrySet()) {
      final String inputFileName = MEASURE_FILENAME + m.getKey().toString() + CORRECTED + GEOJSON_DOT_EXT;
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
      extend.include(extendBbox(bbox.get(0).doubleValue(), - UPSIZE_IN_METERS), extendBbox(bbox.get(1).doubleValue(), + UPSIZE_IN_METERS));
      extend.include(extendBbox(bbox.get(2).doubleValue(), + UPSIZE_IN_METERS), extendBbox(bbox.get(3).doubleValue(), - UPSIZE_IN_METERS));
      break;
    }

    return extend;
  }

  private double extendBbox(double value, int enlarge) {
    return (Math.round(value / 10) * 10) + enlarge;
  }

  private void createScenarionFile(File workingPath, FeatureCollection request) {
    FileWriter fileWriter = null;

    try {
      fileWriter = new FileWriter(workingPath + "/" + NKMODEL_SCENARIO_EXPORT);
      fileWriter.write(Json.pretty(request));

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

  private void copyRunnerFiles(File workingPath, java.util.logging.Logger jobLogger) {
    try {
      for (RunnerEnum runner : RunnerEnum.values()) {
        String script = runner.getRunner();
        File newFile = new File(workingPath.getAbsolutePath() + script.substring(script.lastIndexOf("/")));
        FileUtils.copyFile(new File(script), newFile);
        adjustRights(newFile);
      }

    } catch (IOException e) {
      // eat error
      LOGGER.error("Problem with copy runner files {}", e.getLocalizedMessage());
      jobLogger.info("roblem with copy runner files " + e.getLocalizedMessage());
    }

  }

  /**
   *  convert export json to geotiff
   *  gdal_rasterize -burn <value> -ts 10 10 <measure_input_filename_geojson> <measure_output_filename_tiff> 
   * 
   * @param layerFiles
   * @param projectlayer
   * @param suppliedLayers
   * @param measures
   * @param measuresLayers
   * @param workingPath
   * @param scenarioPath
   * @param jobLogger
   * @return 
   * @throws IOException
   */
  private void applyProjectAndMeasureOnLayers(Map<Layer, String> layerFiles, File projectlayer, ArrayList<LayerObject> suppliedLayers,
      HashMap<MeasureType, ArrayList<Features>> measures, MeasureCollection measuresLayers, Envelope2D extend,
      File workingPath, File scenarioPath, java.util.logging.Logger jobLogger) throws IOException {

    jobLogger.info(measuresLayers.toString());
    
    for (Map.Entry<MeasureType, ArrayList<Features>> m : measures.entrySet()) {
      LOGGER.debug("process measure {} {}", m.getKey());

      //final String inputfileName = MEASURE_FILENAME + m.getKey().toString() + GEOJSON_DOT_EXT;
      final String ouputfileName = MEASURE_FILENAME + m.getKey().toString() + CORRECTED + GEOJSON_DOT_EXT;
      //final File geoJsonFileInput = new File(workingPath, inputfileName);
      final File geoJsonFileOutput = new File(workingPath, ouputfileName);

      // convert geojson to correct crs keep original
      //jobLogger.info("convert to crs " + geoJsonFileInput + " " + geoJsonFileOutput);
      //GeoJson2CorrectCRS.geoJsonConvert(geoJsonFileInput, geoJsonFileOutput, jobLogger, workingPath.toString());

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
          // only create tiff files for layers with values
          if (ml.getValue() != null) {
            String layerFileName = layerFiles.get(Layer.fromValue(ml.getLayer().toString()));
            final String outputfileName = layerFileName;
            File tiffFileToBurn = new File(scenarioPath, "measure_" + outputfileName + TIF_DOT_EXT);
            // burn geosjon onto the outputFileName
            jobLogger.info("burn geojson " + tiffFileToBurn + "on the tiff file " + tiffFileToBurn);
            BurnGeoJsonOnTiff.run(geoJsonFileOutput, tiffFileToBurn, ml.getValue(), extend, jobLogger);
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
    exportGroupedFeatures(measures, features, workingPath, jobLogger);
    jobLogger.info("=== Convert the json to corrected crc Amersfoort ===");
    correctCrc(measures, workingPath, jobLogger);
    return measures;
  }

  private void correctCrc(HashMap<MeasureType, ArrayList<Features>> measures, File workingPath, java.util.logging.Logger jobLogger) {
    for (Map.Entry m : measures.entrySet()) {
      final String inputfileName = MEASURE_FILENAME + m.getKey().toString() + GEOJSON_DOT_EXT;
      final String ouputfileName = MEASURE_FILENAME + m.getKey().toString() + CORRECTED + GEOJSON_DOT_EXT;
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

  }

  @SuppressWarnings("unchecked")
  private void exportGroupedFeatures(HashMap<MeasureType, ArrayList<Features>> measures, FeatureCollection features, File workingPath,
      java.util.logging.Logger jobLogger) {
    // export for the geomety of every measure with measure settings
    for (Map.Entry m : measures.entrySet()) {
      LOGGER.debug("measure {} has {} entries", m.getKey(), ((ArrayList<Features>) m.getValue()).size());
      LOGGER.debug("measure {} ", m);
      // write to geojson file as features
      FeatureCollection f = new FeatureCollection();
      f.setType(TypeEnum.FEATURECOLLECTION);
      f.setBbox(features.getBbox()); // add the boudingbox
      f.setFeatures((ArrayList<Features>) m.getValue());
      final Gson gson = new Gson();
      String jsonToSend = gson.toJson(f);
      // correct the conversion 
      jsonToSend = jsonToSend.replace("FEATURECOLLECTION", TypeEnum.FEATURECOLLECTION.toString());
      final String fileName = MEASURE_FILENAME + m.getKey().toString() + GEOJSON_DOT_EXT;
      LOGGER.debug("writing file ({})", workingPath + "/" + fileName);
      jobLogger.info("Meausure " + m.getKey() + " Creating file " + workingPath + "/" + fileName);
      try (FileWriter file = new FileWriter(workingPath + "/" + fileName)) {
        file.write(jsonToSend);
        file.flush();
        file.close(); // autoclose ?
      } catch (IOException e) {
        e.printStackTrace();
      }

    }
  }

  private HashMap<MeasureType, ArrayList<Features>> groupFeaturesonMeasure(FeatureCollection features, MeasureCollection measuresLayers) {
    HashMap<MeasureType, ArrayList<Features>> measures = new HashMap<MeasureType, ArrayList<Features>>();
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
        measure = feature.getProperties().getMeasure() == null || feature.getProperties().getMeasure().equals("PROJECT") ?  
            MeasureType.PROJECT : feature.getProperties().getMeasure();
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

    return measures;
  }



  /**
   * loop through the user supplied measure layers and overlay them
   * in the input layer map.
   * We can apply more than one measure to the scenario map file
   * It is possible that they overlap last in will determine values
   *     
   * @param layerFiles
   * @param workingPath
   * @param measureLayerFiles
   * @param prefix
   * @param jobLogger
   * @throws IOException 
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

  protected void runPcRaster2(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine,
      File workingPathScenario, File workingPathBaseLine, File projectPathDiff, java.util.logging.Logger jobLogger)
      throws IOException, InterruptedException {
    pcRasterRunner.runPcRaster(correlationId, ecoSystemService, projectFileScenario, projectFileBaseLine, workingPathScenario, workingPathBaseLine,
        projectPathDiff, jobLogger);
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

  protected List<AssessmentTKSResultResponse> importJsonResult(String correlationId, File outputPath, java.util.logging.Logger jobLogger)
      throws IOException {
    List<AssessmentTKSResultResponse> returnList = new ArrayList<AssessmentTKSResultResponse>();
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
            AssessmentTKSResultResponse result = mapper.readValue(body, AssessmentTKSResultResponse.class);
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

  private void filterResult(AssessmentTKSResultResponse result) {
    result.name(result.getName().replaceAll("\\[.*\\]", ""));
    result.units(result.getUnits().replace("[", "").replace("]", "").replace("Euros", "Euro/jaar"));
  }

  protected void cleanUp(File dir, Boolean remove) throws IOException {
    if (remove) {
      deleteDirectoryRecursively(dir);
    }
  }

  private void deleteDirectoryRecursively(File dir) throws IOException {
    if (dir.isDirectory() == false) {
      System.out.println("Not a directory. Do nothing");
      return;
    }
    File[] listFiles = dir.listFiles();
    for (File file : listFiles) {
      if (file.isDirectory()) {
        deleteDirectoryRecursively(file);
      } else {
        boolean success = file.delete();
        LOGGER.info("Deleting {} Success = {}", file.getName(), success);
      }

    }
    // now directory is empty, so we can delete it
    LOGGER.info("Deleting Directory. Success = {}", dir.delete());
  }

  private float closeJobLogger(java.util.logging.Logger jobLogger, FileHandler jobLoggerFile, long start) {
    long end = System.currentTimeMillis();
    float endsec = (end - start) / 1000F;
    jobLogger.info("Total execute time " + end + " seconds");
    jobLogger.removeHandler(jobLoggerFile);
    jobLoggerFile.close();
    return endsec;
  }

  private java.util.logging.Logger createJobLogger(FileHandler jobLoggerFile, long start) {
    java.util.logging.Logger jobLogger = java.util.logging.Logger.getLogger("JobLogger");
    jobLogger.setLevel(Level.ALL);
    jobLoggerFile.setFormatter(new Formatter() {

      @Override
      public String format(LogRecord record) {
        SimpleDateFormat logTime = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
        Calendar cal = new GregorianCalendar();
        cal.setTimeInMillis(record.getMillis());
        return record.getMessage() + "\n\n";
      }

    });
    jobLogger.addHandler(jobLoggerFile);
    jobLogger.entering(this.toString(), "start");
    jobLogger.info("Start at :" + start);
    return jobLogger;
  }
  
  private void adjustRights(File inputFile) throws IOException {
    Set<PosixFilePermission> perms = new HashSet<>();
    perms.add(PosixFilePermission.OWNER_READ);
    perms.add(PosixFilePermission.OWNER_WRITE);
    perms.add(PosixFilePermission.OWNER_EXECUTE);

    perms.add(PosixFilePermission.OTHERS_READ);
    perms.add(PosixFilePermission.OTHERS_WRITE);
    perms.add(PosixFilePermission.OTHERS_EXECUTE);

    perms.add(PosixFilePermission.GROUP_READ);
    perms.add(PosixFilePermission.GROUP_WRITE);
    perms.add(PosixFilePermission.GROUP_EXECUTE);

    Files.setPosixFilePermissions(inputFile.toPath(), perms);
  }

}
