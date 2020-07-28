package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.logging.FileHandler;
import java.util.logging.Formatter;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.stream.Collectors;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.factory.Hints;
import org.geotools.gce.geotiff.GeoTiffFormat;
import org.geotools.gce.geotiff.GeoTiffReader;
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
import nl.rivm.nca.api.domain.MeasureType;

/*
 * Run the model with a TIFF Source file
 * 
 * 
 */
public class NkModelTKSController {

  private static final String JOBLOGGER_TXT = "joblogger.txt";
  private static final Logger LOGGER = LoggerFactory.getLogger(NkModelTKSController.class);

  private static final String GEOJSON_DOT_EXT = ".geojson";
  private static final String JSON_EXT = "json";
  private static final String TIF_DOT_EXT = ".tif";
  private static final String CORRECTED = "_corrected_crc";
  private static final String MAP_DOT_EXT = ".map";
  private static final String MEASURE_FILENAME = "measure_";
  private static final String OUTPUTS = "outputs";
  private final RasterLayers rasterLayers;
  private final ObjectMapper mapper = new ObjectMapper();
  private final PcRasterRunner2 pcRasterRunner2 = new PcRasterRunner2();
  private final PreProcessTKSRunner preProcessRunner = new PreProcessTKSRunner();
  protected static final String PREFIX = "org_";
  protected static final String BASELINE = "baseline";
  protected static final String BASELINE_OUTPUTS = "baseline/outputs";
  protected static final String SCENARIO = "scenario";
  protected static final String SCENARIO_OUTPUTS = "scenario/outputs";
  protected static final String DIFF = "diff";
  protected static final String NKMODEL_SCENARIO_EXPORT = "tks_scenarion.json";


  public NkModelTKSController(File path, boolean directFile) throws IOException, InterruptedException {
    rasterLayers = RasterLayers.loadRasterLayers(path);
  }

  public List<AssessmentTKSResultResponse> run(String correlationId, FeatureCollection features)
      throws IOException, ConfigurationException, InterruptedException {
    final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();
    //final File outputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS)).toFile();
   
    long start = System.currentTimeMillis();
    FileHandler jobLoggerFile = new FileHandler(workingPath + "/" + JOBLOGGER_TXT, true);
    java.util.logging.Logger jobLogger = createJobLogger(jobLoggerFile, start);
    
    // write input geojson to temp directory and copy runner files
    createScenarionFile(workingPath, features);
    copyRunnerFiles(workingPath, jobLogger);
        
    MeasureCollection measuresLayers = loadTksMeasures(); 
    HashMap<MeasureType, ArrayList<Features>> measures = groupFeaturesOnMeasureAndExport(features, measuresLayers, workingPath);
      
    final Map<Layer, String> layerFiles = rasterLayers.getLayerFiles("air_regulation"); // get all files voor eco system
    final File scenarioPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO)).toFile();

    final Envelope2D extend = new Envelope2D();
    // hard coded get from input geojson
    extend.include(85790, 444328); // (134660,455850)
    extend.include(86091, 444885); // (136620,453800)  
    
    File projectlayer = null;
    ArrayList<LayerObject> suppliedLayers = new ArrayList<LayerObject>();
    Map<Layer, File> measureLayerFiles = determineProjectAndMeasureLayers(layerFiles, projectlayer, suppliedLayers, measures, measuresLayers, extend, workingPath, scenarioPath, jobLogger);
  
    // do not run if suppliedLayers is empty 
    
    final File baseLinePath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE)).toFile();
    final File baseLineOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE_OUTPUTS)).toFile();
    final File scenarioOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS)).toFile();
    final File diffPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), DIFF)).toFile();

    List<AssessmentTKSResultResponse> assessmentResultlist = new ArrayList<AssessmentTKSResultResponse>();

    // final Envelope2D extend = calculateExtend(projectlayer);
    cookieCutOtherLayersToWorkingPath(scenarioPath, layerFiles, suppliedLayers, extend, jobLogger);
    cookieCutAllLayersToBaseLinePath(baseLinePath, layerFiles, extend, jobLogger);

    // overlay the input tiff onto the cut scenario map to apply the change
    prePrepocessSenarioMap(layerFiles, scenarioPath, measureLayerFiles, PREFIX, jobLogger);

    final File projectFileScenario = ProjectIniFile.generateIniFile(scenarioPath.getAbsolutePath(), scenarioOutputPath.getAbsolutePath());
    final File projectFileBaseLine = ProjectIniFile.generateIniFile(baseLinePath.getAbsolutePath(), baseLineOutputPath.getAbsolutePath());
    LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
    runPcRaster2(correlationId, "air_regulation", projectFileScenario, projectFileBaseLine, scenarioOutputPath,
        baseLineOutputPath, diffPath, jobLogger);

    assessmentResultlist = importJsonResult(correlationId, diffPath, jobLogger);
    //cleanUp(workingPath, false);
    
    jobLogger.info("List<AssessmentResultResponse>");
    jobLogger.info(Json.pretty(assessmentResultlist));
    closeJobLogger(jobLogger, jobLoggerFile, start);

    return assessmentResultlist;
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
          FileUtils.copyFile(new File(script), new File(workingPath.getAbsolutePath() + script.substring(script.lastIndexOf("/"))));
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
  private Map<Layer, File> determineProjectAndMeasureLayers(Map<Layer, String> layerFiles, File projectlayer, ArrayList<LayerObject> suppliedLayers,
      HashMap<MeasureType, ArrayList<Features>> measures, MeasureCollection measuresLayers, Envelope2D extend,
      File workingPath, File scenarioPath, java.util.logging.Logger jobLogger) throws IOException {
    
    final File outputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS)).toFile();
    Map<Layer, File> measureLayerFiles = new HashMap<Layer, File>();
    
    for (Map.Entry<MeasureType, ArrayList<Features>> m : measures.entrySet()) {
      LOGGER.debug("process measure {} {}", m.getKey());
      
      final String inputfileName = MEASURE_FILENAME + m.getKey().toString() + GEOJSON_DOT_EXT;      
      final String ouputfileName = MEASURE_FILENAME + m.getKey().toString() + CORRECTED + GEOJSON_DOT_EXT;      
      final File geoJsonFileInput = new File(workingPath, inputfileName);
      final File geoJsonFileOutput = new File(workingPath, ouputfileName);
      // convert geojson to correct crs keep original
      GeoJson2CorrectCRS.geoJsonConvert(geoJsonFileInput, geoJsonFileOutput, jobLogger);
      
      // find out how many layers must be created for this measure
      List<MeasureLayer> measureLayers = new ArrayList<MeasureLayer>();
      Measure currentMeasure = null;
      for (Measure am : measuresLayers.getMeasures()) {
        if (am.getCode() == m.getKey()) {
          currentMeasure = am;
          measureLayers = am.getLayers();
        }
      }
      LOGGER.debug("measure {} layer values {}", m.getKey(), measureLayers);

      if (currentMeasure != null && currentMeasure.isRunmodel()) {
        // create measureDirectory so we can output layer filenames    
        String measureName =  m.getKey().toString();
        final File measureOutputPath = Files.createDirectory(Paths.get(outputPath.getAbsolutePath(), MEASURE_FILENAME + measureName)).toFile();

        for (MeasureLayer ml : measureLayers) {
          // only create tiff files for layers with values
          if (ml.getValue() != null) {
            String layerFileName = layerFiles.get(Layer.fromValue(ml.getLayer().toString()));
            final String outputfileName = layerFileName;

            jobLogger.info("run_gdal_rasterize: " + ml.getValue() + " " + inputfileName + " " + outputfileName);
            LOGGER.debug("run_gdal_rasterize {} {} {}", ml.getValue(), inputfileName, outputfileName);

            //final File geoJsonFile = new File(workingPath, inputfileName);
            
            // convert from geojson to geotiff
            final File tiffFile = new File(measureOutputPath, outputfileName + TIF_DOT_EXT);
            GeoJson2Geotiff.run(geoJsonFileOutput, tiffFile, ml.getValue(), extend, jobLogger);

            // find project layout for the exstend and add to collect that are supplied 
            if (MeasureType.fromValue(m.getKey().toString()) == MeasureType.PROJECT) {
              projectlayer = tiffFile; 
              // want to use for exstend
            } else {
              
              LayerObject layer = new LayerObject();
              layer.setClassType(ml.getLayer().toString());
              //suppliedLayers.add(layer);
              
              // also write to scenario path
              final File orgtiffFile = new File(scenarioPath, PREFIX + measureName + "_" + layerFileName + TIF_DOT_EXT);
              GeoJson2Geotiff.run(geoJsonFileOutput, orgtiffFile, ml.getValue(), extend, jobLogger);
//              // from tiff to map
//              final File mapFile = new File(outputPath, outputfileName + MAP_DOT_EXT);
//              Geotiff2PcRaster.geoTiff2PcRaster(orgtiffFile, mapFile);
//              
              // want a list of filenames and target layer to merge with
              measureLayerFiles.put(Layer.fromValue(ml.getLayer().toString()), orgtiffFile);
            }
          }
        }
      }
    }
    return measureLayerFiles;
  }

  private HashMap<MeasureType, ArrayList<Features>> groupFeaturesOnMeasureAndExport(FeatureCollection features, MeasureCollection measuresLayers,
      File workingPath) {
    HashMap<MeasureType, ArrayList<Features>> measures = groupFeaturesonMeasure(features, measuresLayers);
    exportGroupedFeatures(measures, workingPath);
    return measures;
  }

  @SuppressWarnings("unchecked")
  private void exportGroupedFeatures(HashMap<MeasureType, ArrayList<Features>> measures, File workingPath) {
    // export for the geomety of every measure with measure settings
    for (Map.Entry m : measures.entrySet()) {
      LOGGER.debug("measure {} has {} entries", m.getKey(), ((ArrayList<Features>) m.getValue()).size());

      // write to geojson file as features
      FeatureCollection f = new FeatureCollection();
      f.setType(TypeEnum.FEATURECOLLECTION);
      f.setFeatures((ArrayList<Features>) m.getValue());
      final Gson gson = new Gson();
      String jsonToSend = gson.toJson(f);
      // correct the conversion 
      jsonToSend = jsonToSend.replace("FEATURECOLLECTION", TypeEnum.FEATURECOLLECTION.toString());
      // TODO convert line and point to valid geojson

      final String fileName = MEASURE_FILENAME + m.getKey().toString() + GEOJSON_DOT_EXT;
      //LOGGER.debug("file ({}) data {}", fileName, jsonToSend);
      //Write JSON file
      LOGGER.debug("writing file ({})", workingPath + "/" + fileName);
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
          if (m.getId().equals(feature.getProperties().getMeasureId())) {
            measure = m.getCode();
          }
        }
      } else {
        measure = feature.getProperties().getMeasure() == null ? MeasureType.PROJECT : feature.getProperties().getMeasure();
      }

      ArrayList<Features> measureValue = measures.get(measure);
      LOGGER.debug("add measure {} value {}", measureValue, feature);
      LOGGER.debug("add measure {} value {}", measureValue, feature.getGeometry().getType());
      if (measureValue == null) {
        ArrayList<Features> list = new ArrayList<Features>();
        list.add(feature);
        measures.put(measure, list);
      } else {
        measureValue.add(feature);
      }
    }

    return measures;
  }

  private MeasureCollection loadTksMeasures() throws IOException {
    final File measureModelsFile = new File(EnvironmentEnum.NCA_TKS_MEASURES.getEnv());
    @SuppressWarnings("resource")
    FileReader fr = new FileReader(measureModelsFile.getAbsolutePath());
    int i;
    String body = "";
    while ((i = fr.read()) != -1)
      body += (char) i;
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    return mapper.readValue(body, MeasureCollection.class);
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
  protected void prePrepocessSenarioMap(Map<Layer, String> layerFiles, File workingPath, Map<Layer, File> measureLayerFiles, String prefix,
      java.util.logging.Logger jobLogger) throws IOException {

    for (Map.Entry<Layer, File> measureLayer : measureLayerFiles.entrySet()) {
      Layer layer = (Layer) measureLayer.getKey();
      File tiffFile = (File) measureLayer.getValue();
      // create extra file
      final File mapFile = new File(workingPath, prefix + layerFiles.get(layer) + MAP_DOT_EXT); // original to overwrite
      final File editMapFilePath = new File(mapFile.getAbsolutePath().replace(".map", "_edit.map").replace("org_", ""));
      Geotiff2PcRaster.geoTiff2PcRaster(tiffFile, editMapFilePath); // create map file from tiff
      try {
        preProcessRunner.runPreProcessorTiffToMap("", mapFile, editMapFilePath, prefix, jobLogger);
      } catch (final IOException | InterruptedException e) {
        e.printStackTrace();
      }
    }
  }

  protected void runPcRaster2(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine,
      File workingPathScenario, File workingPathBaseLine, File projectPathDiff, java.util.logging.Logger jobLogger)
      throws IOException, InterruptedException {
    pcRasterRunner2.runPcRaster(correlationId, ecoSystemService, projectFileScenario, projectFileBaseLine, workingPathScenario, workingPathBaseLine,
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

  public Envelope2D calculateExtend(File geoTiffFile) throws IOException {
    final GeoTiffFormat format = new GeoTiffFormat();
    final Hints hint = new Hints();
    // hint.put(Hints.FORCE_LONGITUDE_FIRST_AXIS_ORDER, Boolean.TRUE);
    final GeoTiffReader tiffReader = format.getReader(geoTiffFile, hint);
    final GridCoverage2D coverage = tiffReader.read(null);

    // final CoordinateReferenceSystem crs =
    // coverage.getCoordinateReferenceSystem();
    // check crs == RDNew?

    return coverage.getEnvelope2D();
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
            mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            AssessmentTKSResultResponse result = mapper.readValue(body, AssessmentTKSResultResponse.class);
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
  

  private void closeJobLogger(java.util.logging.Logger jobLogger, FileHandler jobLoggerFile, long start) {
    // close joblogger
    long end = System.currentTimeMillis();
    jobLogger.info("Total execute time " + (end - start) / 1000F + " seconds");
    jobLogger.removeHandler(jobLoggerFile);
    jobLoggerFile.close();
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
        return
        /*record.getLevel()
        + " "
        + logTime.format(cal.getTime())
        + " || "
        + record.getSourceClassName().substring(
            record.getSourceClassName().lastIndexOf(".") + 1,
            record.getSourceClassName().length())
        + "."
        + record.getSourceMethodName()
        + "() : "
        + record.getMessage() + "\n\n";
        */
        record.getMessage() + "\n\n";
      }

    });
    jobLogger.addHandler(jobLoggerFile);
    // add the start 
   
    jobLogger.entering(this.toString(), "run");
    jobLogger.info("Start at :" + start);
    return jobLogger;
  }

}
