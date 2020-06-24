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

import nl.rivm.nca.api.domain.AssessmentTKSResultResponse;
import nl.rivm.nca.api.domain.FeatureCollection;
import nl.rivm.nca.api.domain.FeatureCollection.TypeEnum;
import nl.rivm.nca.api.domain.Features;
import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.LayerObject;
import nl.rivm.nca.api.domain.Measure;

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
  private static final String MAP_DOT_EXT = ".map";
  private static final String MEASURE_FILENAME = "measure_";
  private static final String OUTPUTS = "outputs";
  private final RasterLayers rasterLayers;
  private final ObjectMapper mapper = new ObjectMapper();
  private final PcRasterRunner2 pcRasterRunner2 = new PcRasterRunner2();
  private final PreProcessRunner preProcessRunner = new PreProcessRunner();
  protected static final String PREFIX = "org_";
  protected static final String BASELINE = "baseline";
  protected static final String BASELINE_OUTPUTS = "baseline/outputs";
  protected static final String SCENARIO = "scenario";
  protected static final String SCENARIO_OUTPUTS = "scenario/outputs";
  protected static final String DIFF = "diff";
  protected static final String NKMODEL_SCENARIO_EXPORT = "nkmodel_scenarion.json";

  public NkModelTKSController(File path, boolean directFile) throws IOException, InterruptedException {
    rasterLayers = RasterLayers.loadRasterLayers(path);
  }

  public List<AssessmentTKSResultResponse> run(String correlationId, FeatureCollection features)
      throws IOException, ConfigurationException, InterruptedException {
    final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();
    final File outputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS)).toFile();

    //create jobLogger for the job
    FileHandler jobLoggerFile = new FileHandler(workingPath + "/" + JOBLOGGER_TXT, true);
    java.util.logging.Logger jobLogger = createJobLogger(jobLoggerFile);
    long start = System.currentTimeMillis();
    jobLogger.entering(NkModel2Controller.class.toString(), "run");
    jobLogger.info("Start at :" + start);

    LOGGER.debug("{}", features);

    // arrange the measures 
    HashMap<Measure, ArrayList<Features>> measures = new HashMap<Measure, ArrayList<Features>>();
    //features.getFeatures().forEach(feature -> {
    for (Features feature : features.getFeatures()) {
      Measure measure = feature.getProperties().getMeasure() == null ? Measure.PROJECT : feature.getProperties().getMeasure();
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

    // execute the conversion for every measure and the layers for that measure

    /*
     *  exstend van het gebied van de scenarios 0 = no-op
     *  bomen plaatsen 42 = {GRAS:0,SCRUBS:0,TREES:90,LAND_COVER:23,POLPULATION:0,PM_10:0}
     *  groene daken 40 =  {GRAS:90,SCRUBS:0,TREES:0,LAND_COVER:23,POLPULATION:0,PM_10:0}
     */

    /*
     * start a batch file with parameters
     * measure_input_filename_geojson measure_output_filename_tiff value
     * 
     * Batch file will execute
     * gdal_rasterize -burn <value> -ts 10 10 <measure_input_filename_geojson> <measure_output_filename_tiff> 
     * 
     */

    final Map<Layer, String> layerFiles = rasterLayers.getLayerFiles("air_regulation"); // get all files voor eco system
    final File scenarioPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO)).toFile();

    File projectlayer = null;
    ArrayList<LayerObject> suppliedLayers = new ArrayList<LayerObject>();
    for (Map.Entry m : measures.entrySet()) {
      final String inputfileName = MEASURE_FILENAME + m.getKey().toString() + GEOJSON_DOT_EXT;
      Measures availableMeasures = Measures.loadMeasureLayers(0d);
      LOGGER.debug("process measure {} {}", m.getKey());
      Map<Layer, Number> measureLayers = availableMeasures.getMeasureValue((Measure) m.getKey());
      LOGGER.debug("measure {} layer values {}", m.getKey(), measureLayers);

      // create measureDirectory so we can output layer filenames
      final File measureOutputPath = Files
          .createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS + "/" + MEASURE_FILENAME + m.getKey().toString())).toFile();

      for (Map.Entry ml : measureLayers.entrySet()) {
        //LOGGER.debug(" key {} value {}", ml.getKey(), ml.getValue());
        //lookup filename for layer
        String layerFileName = layerFiles.get(Layer.fromValue(ml.getKey().toString()));
        final String outputfileName = layerFileName;
        LOGGER.debug("run_gdal_rasterize {} {} {}", ml.getValue(), inputfileName, outputfileName);

        final File geoJsonFile = new File(workingPath, inputfileName);
        final File tiffFile = new File(measureOutputPath, outputfileName + TIF_DOT_EXT);
        //final File mapFile = new File(outputPath, outputfileName + MAP_DOT_EXT);
        GeoJson2Geotiff.geoJson2geoTiff(geoJsonFile, tiffFile, (double) ml.getValue());

        //Geotiff2PcRaster.geoTiff2PcRaster(tiffFile, mapFile);

        // find project layout for the exstend and add collect other per 
        if (Measure.fromValue(m.getKey().toString()) == Measure.PROJECT) {
          projectlayer = tiffFile;
        } else if (Measure.fromValue(m.getKey().toString()) == Measure.GREEN_ROOF) {
          // happy flow only green roof  
          LayerObject layer = new LayerObject();
          layer.setClassType(m.getKey().toString());
          suppliedLayers.add(layer);
          // also write to scenario path
          final File orgtiffFile = new File(scenarioPath, PREFIX + layerFileName + TIF_DOT_EXT);
          GeoJson2Geotiff.geoJson2geoTiff(geoJsonFile, orgtiffFile, (double) ml.getValue());
        }
      }
    }

    // merge the map files with 

    // copy created map files to scenario directory as layer filename

    // run the model for the measure but run it for every measure
    final File baseLinePath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE)).toFile();
    final File baseLineOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE_OUTPUTS)).toFile();
    final File scenarioOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS)).toFile();
    final File diffPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), DIFF)).toFile();

    boolean skip = false;
    List<AssessmentTKSResultResponse> assessmentResultlist = new ArrayList<AssessmentTKSResultResponse>();

    if (!skip) {

      final Envelope2D extend = new Envelope2D();
      extend.include(85790, 444328);
      extend.include(86091, 444885); 

      // final Envelope2D extend = calculateExtend(projectlayer);
      cookieCutOtherLayersToWorkingPath(scenarioPath, layerFiles, suppliedLayers, extend, jobLogger);
      cookieCutAllLayersToBaseLinePath(baseLinePath, layerFiles, suppliedLayers, extend, jobLogger);

      // do not need this. or do we ...
      prePrepocessSenarioMap(layerFiles, scenarioPath, suppliedLayers, PREFIX, jobLogger);

      //final File projectFile = ProjectIniFile.generateIniFile(workingPath.getAbsolutePath(), outputPath.getAbsolutePath());
      final File projectFileScenario = ProjectIniFile.generateIniFile(scenarioPath.getAbsolutePath(), scenarioOutputPath.getAbsolutePath());
      final File projectFileBaseLine = ProjectIniFile.generateIniFile(baseLinePath.getAbsolutePath(), baseLineOutputPath.getAbsolutePath());
      LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
      runPcRaster2(correlationId, "air_regulation", projectFileScenario, projectFileBaseLine, scenarioOutputPath,
          baseLineOutputPath, diffPath, jobLogger);

      // collect the results
      // result should be matched with the supplied areas some result to more dan one area!
      assessmentResultlist = importJsonResult(correlationId, diffPath, jobLogger);

      //cleanUp(workingPath, false);
    }

    return assessmentResultlist;
  }

  protected void prePrepocessSenarioMap(Map<Layer, String> layerFiles, File workingPath, List<LayerObject> userLayers, String prefix,
      java.util.logging.Logger jobLogger) {
    for (LayerObject layer : userLayers) {
      final File tiffFile = new File(workingPath, prefix + layerFiles.get(Layer.fromValue(layer.getClassType().toUpperCase())) + TIF_DOT_EXT);
      final File mapFile = new File(FilenameUtils.removeExtension(tiffFile.getAbsolutePath()) + MAP_DOT_EXT);
      try {
        preProcessRunner.runPreProcessorTiffToMap("", tiffFile, mapFile, prefix, jobLogger);
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
      List<LayerObject> userLayers, Envelope2D extend, java.util.logging.Logger jobLogger) throws IOException {
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

  private java.util.logging.Logger createJobLogger(FileHandler jobLoggerFile) {
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
    return jobLogger;
  }

}
