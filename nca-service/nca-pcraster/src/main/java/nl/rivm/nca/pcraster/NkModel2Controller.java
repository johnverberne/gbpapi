package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.ConsoleHandler;
import java.util.logging.FileHandler;
import java.util.logging.Formatter;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.stream.Collectors;
import java.util.zip.ZipOutputStream;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.swagger.util.Json;
import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.AssessmentScenarioRequest;
import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.LayerObject;

/*
 * Run the model with a XYZ Source file.
 * 
 * Create root temp directory with 3 extra directories including ini files
 * ScenarioDirectory
 * BaseLineDirectory
 * ResultDirectory
 * 
 * convert xyz to tiff
 * prepair files
 * determine extend
 * cut other files
 * Run the model 
 * Collect the results
 */

public class NkModel2Controller extends BaseController implements ControllerInterface {

  private static final String JOBLOGGER_TXT = "joblogger.txt";
  private static final Logger LOGGER = LoggerFactory.getLogger(NkModel2Controller.class);

  private static final String XYZ_EXT = "xyz";
  private static final String XYZ_DOT_EXT = "." + XYZ_EXT;
  private final PcRasterRunner2 pcRasterRunner2 = new PcRasterRunner2();
  private final PreProcessRunner preProcessRunner = new PreProcessRunner();
  protected static final String PREFIX = "org_";
  protected static final String BASELINE = "baseline";
  protected static final String BASELINE_OUTPUTS = "baseline/outputs";
  protected static final String SCENARIO = "scenario";
  protected static final String SCENARIO_OUTPUTS = "scenario/outputs";
  protected static final String DIFF = "diff";
  protected static final String NKMODEL_SCENARIO_EXPORT = "nkmodel_scenarion.json";
  protected static final int EXTEND_DISTANCE_METERS = 1000;

  private String downloadFileUrl;

  public NkModel2Controller(File path, boolean directFile) throws IOException, InterruptedException {
    super(path, directFile);
  }

  @Override
  public List<AssessmentResultResponse> run(String correlationId, AssessmentRequest assessmentRequest)
      throws IOException, ConfigurationException, InterruptedException {
    long startMeasure;
    final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();

    //create jobLogger for the job
    FileHandler jobLoggerFile = new FileHandler(workingPath + "/" + JOBLOGGER_TXT, true);
    java.util.logging.Logger jobLogger = createJobLogger(jobLoggerFile);
    long start = System.currentTimeMillis();
    jobLogger.entering(NkModel2Controller.class.toString(), "run");
    jobLogger.info("Start at :" + start);

    // write input json to temp directory and copy runner files
    createScenarionFile(workingPath, assessmentRequest);
    copyRunnerFiles(workingPath, jobLogger);

    LOGGER.info("AssessmentRequest {}", assessmentRequest.toString());
    LOGGER.info("extend {}", assessmentRequest.getExtent());
    LOGGER.info("extend x {}, y {}, maxx {}, maxy {}",
        assessmentRequest.getExtent().get(0).get(0), assessmentRequest.getExtent().get(0).get(1),
        assessmentRequest.getExtent().get(1).get(0), assessmentRequest.getExtent().get(1).get(1));
    jobLogger.info("AssessmentRequest");
    jobLogger.info(Json.pretty(assessmentRequest));
    jobLogger.info("extend " + assessmentRequest.getExtent());
    jobLogger.info("extend x " + assessmentRequest.getExtent().get(0).get(0) +
        ", y " + assessmentRequest.getExtent().get(0).get(1) +
        ", maxx " + assessmentRequest.getExtent().get(1).get(0) +
        ", maxy " + assessmentRequest.getExtent().get(1).get(1));

    startMeasure = System.currentTimeMillis();
    final File baseLinePath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE)).toFile();
    final File baseLineOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE_OUTPUTS)).toFile();
    final File scenarioPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO)).toFile();
    final File scenarioOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS)).toFile();
    final File diffPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), DIFF)).toFile();

    final Map<Layer, String> layerFiles = rasterLayers.getLayerFiles(assessmentRequest.getEcoSystemService());
    copyInputToWorkingMap(layerFiles, scenarioPath, assessmentRequest.getLayers(), PREFIX);
    final Envelope2D extend = new Envelope2D();
    extend.include(assessmentRequest.getExtent().get(0).get(0), assessmentRequest.getExtent().get(0).get(1));
    extend.include(assessmentRequest.getExtent().get(1).get(0), assessmentRequest.getExtent().get(1).get(1));
    LOGGER.info("extend {}", extend);
    jobLogger.info("extend " + extend);

    cookieCutOtherLayersToWorkingPath(scenarioPath, layerFiles, assessmentRequest.getLayers(), extend, jobLogger);
    cookieCutAllLayersToBaseLinePath(baseLinePath, layerFiles, assessmentRequest.getLayers(), extend, jobLogger);
    jobLogger.info("Time to prepaire files :" + (System.currentTimeMillis() - startMeasure) / 1000F + " seconds");

    // create map files from input with extend
    startMeasure = System.currentTimeMillis();
    prePrepocessSenarioMap(layerFiles, scenarioPath, assessmentRequest.getLayers(), PREFIX, jobLogger);
    jobLogger.info("Duration of PrepocessSenarioMap :" + (System.currentTimeMillis() - startMeasure) / 1000F + " seconds");

    // create ini files for scenario and baseline
    startMeasure = System.currentTimeMillis();
    final File projectFileScenario = ProjectIniFile.generateIniFile(scenarioPath.getAbsolutePath(), scenarioOutputPath.getAbsolutePath());
    final File projectFileBaseLine = ProjectIniFile.generateIniFile(baseLinePath.getAbsolutePath(), baseLineOutputPath.getAbsolutePath());
    LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
    runPcRaster2(correlationId, assessmentRequest.getEcoSystemService(), projectFileScenario, projectFileBaseLine, scenarioOutputPath,
        baseLineOutputPath, diffPath, jobLogger);
    jobLogger.info("Durration of PCRaster models :" + (System.currentTimeMillis() - startMeasure) / 1000F + " seconds");

    // convert to geotiff and publish to geo server
    startMeasure = System.currentTimeMillis();
    convertOutput(diffPath);
    List<AssessmentResultResponse> assessmentResultlist = importJsonResult(correlationId, diffPath);
    publishFiles(correlationId, diffPath);
    jobLogger.info("Durration of publisching to GEO Server :" + (System.currentTimeMillis() - startMeasure) / 1000F + " seconds");

    // close joblogger
    jobLogger.info("List<AssessmentResultResponse>");
    jobLogger.info(Json.pretty(assessmentResultlist));
    long end = System.currentTimeMillis();
    jobLogger.info("Execute time " + (end - start) / 1000F + " seconds");
    jobLogger.removeHandler(jobLoggerFile);
    jobLoggerFile.close();

    // create zip file in server environment for download 
    startMeasure = System.currentTimeMillis();
    String fileName = zipResult(correlationId, workingPath);
    setDownloadFileUrl(System.getenv(EnvironmentConstants.NCA_DOWNLOAD_URL) + "/" + fileName);
    LOGGER.info("Duration of zipping temp output diretory : {} ", (System.currentTimeMillis() - startMeasure) / 1000F + " seconds");
    LOGGER.info("download resultset {}", getDownloadFileUrl());

    // cleanup
    cleanUp(workingPath, false);
    return assessmentResultlist;
  }

  @Override
  public String getDownloadFileUrl() {
    return downloadFileUrl;
  }

  private void createScenarionFile(File workingPath, AssessmentRequest assessmentRequest) {
    FileWriter fileWriter = null;

    // convert to make it possible to import again
    AssessmentScenarioRequest request = new AssessmentScenarioRequest();
    request.addMeasuresItem(assessmentRequest);

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
      // write batch files to temp directory
      FileUtils.copyFile(new File("/opt/nkmodel/nca2.sh"), new File(workingPath.getAbsolutePath() + "/" + "nca2.sh"));
      FileUtils.copyFile(new File("/opt/nkmodel/nca_preprocess_scenario_map.sh"), new File(workingPath.getAbsolutePath() + "/"  + "nca_preprocess_scenario_map.sh"));
    } catch (IOException e) {
      // eat error
      LOGGER.error("Problem with copy runner files {}", e.getLocalizedMessage());
      jobLogger.info("roblem with copy runner files " + e.getLocalizedMessage());
    }

  }

  private java.util.logging.Logger createJobLogger(FileHandler jobLoggerFile) {
    java.util.logging.Logger jobLogger = java.util.logging.Logger.getLogger("JobLogger");
    // suppress the logging output to the console
//    java.util.logging.Logger rootLogger = java.util.logging.Logger.getLogger("");
//    Handler[] handlers = rootLogger.getHandlers();
//    if (handlers[0] instanceof ConsoleHandler) {
//      rootLogger.removeHandler(handlers[0]);
//    }
    jobLogger.setLevel(Level.ALL);
    jobLoggerFile.setFormatter(new Formatter() {

      @Override
      public String format(LogRecord record) {
        SimpleDateFormat logTime = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
        Calendar cal = new GregorianCalendar();
        cal.setTimeInMillis(record.getMillis());
        return record.getLevel()
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
      }

    });
    jobLogger.addHandler(jobLoggerFile);
    return jobLogger;
  }

  private String zipResult(String correlationId, File workingPath) {
    String downloadPath = System.getenv(EnvironmentConstants.NCA_DOWNLOAD_PATH);
    String fileName = "" + correlationId + ".zip";
    FileOutputStream fos;
    ZipOutputStream zipOut = null;
    try {
      fos = new FileOutputStream(downloadPath + "/" + fileName);
      zipOut = new ZipOutputStream(fos);
      File fileToZip = new File(workingPath.getAbsolutePath());
      ZipDirectory.zipFile(fileToZip, fileToZip.getName(), zipOut);
      zipOut.close();
      LOGGER.info("download resultset writen to {}", downloadPath + "/" + fileName);
    } catch (IOException e) {
      // eat error
      LOGGER.error("Problem with zipping content {}", e.getLocalizedMessage());
    }
    return fileName;
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

  protected void copyInputToWorkingMap(Map<Layer, String> layerFiles, File workingPath, List<LayerObject> userLayers, String prefix) {
    userLayers.stream().map(ul -> writeToXYZFile(layerFiles, workingPath, ul, prefix)).collect(Collectors.toList());
    return;
  }

  private File writeToXYZFile(Map<Layer, String> layerFiles, File workingPath, LayerObject layerObject, String prefix) {
    return writeToFile(layerFiles, workingPath, layerObject, XYZ_DOT_EXT, prefix);
  }

  protected void prePrepocessSenarioMap(Map<Layer, String> layerFiles, File workingPath, List<LayerObject> userLayers, String prefix,
      java.util.logging.Logger jobLogger) {
    for (LayerObject layer : userLayers) {
      File xyzFile = new File(workingPath, prefix + layerFiles.get(Layer.fromValue(layer.getClassType().toUpperCase())) + XYZ_DOT_EXT);
      final File mapFile = new File(FilenameUtils.removeExtension(xyzFile.getAbsolutePath()) + MAP_DOT_EXT);
      try {
        preProcessRunner.runPreProcessor("", xyzFile, mapFile, prefix, jobLogger);
      } catch (final IOException | InterruptedException e) {
        e.printStackTrace();
      }
    }
  }

  public void setDownloadFileUrl(String url) {
    this.downloadFileUrl = url;
  }

}
