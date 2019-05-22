package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.SimpleFormatter;
import java.util.stream.Collectors;
import java.util.zip.ZipOutputStream;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FilenameUtils;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.swagger.util.Json;
import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
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
  protected static final int EXTEND_DISTANCE_METERS = 1000;

  public NkModel2Controller(File path, boolean directFile) throws IOException, InterruptedException {
    super(path, directFile);
  }

  @Override
  public List<AssessmentResultResponse> run(String correlationId, AssessmentRequest assessmentRequest)
      throws IOException, ConfigurationException, InterruptedException {

    final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();

    //create jobLogger for the job
    FileHandler jobLoggerFile = new FileHandler(workingPath + "/" + JOBLOGGER_TXT, true);
    java.util.logging.Logger jobLogger = createJobLogger(jobLoggerFile);
    long start = System.currentTimeMillis();
    jobLogger.entering(NkModel2Controller.class.toString(), "run");
    jobLogger.info("Start at :" + start);

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
    prePrepocessSenarioMap(layerFiles, scenarioPath, assessmentRequest.getLayers(), PREFIX, jobLogger);

    // create ini files for scenario and baseline
    final File projectFileScenario = ProjectIniFile.generateIniFile(scenarioPath.getAbsolutePath(), scenarioOutputPath.getAbsolutePath());
    final File projectFileBaseLine = ProjectIniFile.generateIniFile(baseLinePath.getAbsolutePath(), baseLineOutputPath.getAbsolutePath());

    LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
    runPcRaster2(correlationId, assessmentRequest.getEcoSystemService(), projectFileScenario, projectFileBaseLine, scenarioOutputPath,
        baseLineOutputPath, diffPath, jobLogger);

    convertOutput(diffPath);
    List<AssessmentResultResponse> assessmentResultlist = importJsonResult(correlationId, diffPath);
    publishFiles(correlationId, diffPath);

    // close logger
    jobLogger.info("List<AssessmentResultResponse>");
    jobLogger.info(Json.pretty(assessmentResultlist));
    long end = System.currentTimeMillis();
    jobLogger.info("Execute time " + (end - start) / 1000F + " seconds");
    jobLogger.removeHandler(jobLoggerFile);
    jobLoggerFile.close();

    // create zip file in server environment for download 
    String fileName = zipResult(correlationId, workingPath);
    String downloadFileUrl = System.getenv(EnvironmentConstants.NCA_DOWNLOAD_URL) + "/" + fileName;
    LOGGER.info("download resultset {}", downloadFileUrl);

    // cleanup
    cleanUp(workingPath, false);

    return assessmentResultlist;
  }

  private java.util.logging.Logger createJobLogger(FileHandler jobLoggerFile) {
    java.util.logging.Logger jobLogger = java.util.logging.Logger.getLogger("JobLogger");
    jobLogger.setLevel(Level.ALL);
    //jobLoggerFile.setLevel(Level.WARNING);
    jobLoggerFile.setFormatter(new SimpleFormatter());
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

}
