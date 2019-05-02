package nl.rivm.nca.pcraster;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.zip.ZipOutputStream;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FilenameUtils;
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.factory.Hints;
import org.geotools.gce.geotiff.GeoTiffFormat;
import org.geotools.gce.geotiff.GeoTiffReader;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.DataType;
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
    LOGGER.info("AssessmentRequest {}", assessmentRequest.toString());
    LOGGER.info("extend {}",assessmentRequest.getExtent());
    LOGGER.info("extend x {}, y {}, maxx {}, maxy {}",
        assessmentRequest.getExtent().get(0).get(0), assessmentRequest.getExtent().get(0).get(1),
        assessmentRequest.getExtent().get(1).get(0), assessmentRequest.getExtent().get(1).get(1));
    final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();

    final File baseLinePath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE)).toFile();
    final File baseLineOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), BASELINE_OUTPUTS)).toFile();
    final File scenarioPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO)).toFile();
    final File scenarioOutputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), SCENARIO_OUTPUTS)).toFile();
    final File diffPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), DIFF)).toFile();

    final Map<Layer, String> layerFiles = rasterLayers.getLayerFiles(assessmentRequest.getEcoSystemService());
    copyInputToWorkingMap(layerFiles, scenarioPath, assessmentRequest.getLayers(), PREFIX);
    final Envelope2D extend = new Envelope2D();
    extend.include( assessmentRequest.getExtent().get(0).get(0), assessmentRequest.getExtent().get(0).get(1));
    extend.include( assessmentRequest.getExtent().get(1).get(0), assessmentRequest.getExtent().get(1).get(1));
    LOGGER.info("extend {}",extend);
    cookieCutOtherLayersToWorkingPath(scenarioPath, layerFiles, assessmentRequest.getLayers(), extend);
    cookieCutAllLayersToBaseLinePath(baseLinePath, layerFiles, assessmentRequest.getLayers(), extend);
    prePrepocessSenarioMap(layerFiles, scenarioPath, assessmentRequest.getLayers(), PREFIX);

    // create ini files for scenario and baseline
    final File projectFileScenario = ProjectIniFile.generateIniFile(scenarioPath.getAbsolutePath(), scenarioOutputPath.getAbsolutePath());
    final File projectFileBaseLine = ProjectIniFile.generateIniFile(baseLinePath.getAbsolutePath(), baseLineOutputPath.getAbsolutePath());

    LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
    runPcRaster2(correlationId, assessmentRequest.getEcoSystemService(), projectFileScenario, projectFileBaseLine, scenarioOutputPath,
        baseLineOutputPath, diffPath);
    
    convertOutput(diffPath);
    List<AssessmentResultResponse> assessmentResultlist = importJsonResult(correlationId, diffPath);
    publishFiles(correlationId, diffPath);

    // create zip file
   ZipOutputStream content = zipResult(correlationId, workingPath);
    
    cleanUp(workingPath, false);
    return assessmentResultlist;
  }
  
  private ZipOutputStream zipResult(String correlationId, File workingPath) {
    FileOutputStream fos;
    ZipOutputStream zipOut = null;
    try {
      fos = new FileOutputStream("resultset_" + correlationId +".zip");
      zipOut = new ZipOutputStream(fos);
      File fileToZip = new File(workingPath.getAbsolutePath());
      ZipDirectory.zipFile(fileToZip, fileToZip.getName(), zipOut);
      zipOut.close();
      
    } catch (IOException e) {
      // eat error
     LOGGER.error("Problem with zipping content {}", e.getLocalizedMessage());
    }
    return zipOut;
  }

  protected void runPcRaster2(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine,
      File workingPathScenario, File workingPathBaseLine, File projectPathDiff)
      throws IOException, InterruptedException {
    pcRasterRunner2.runPcRaster(correlationId, ecoSystemService, projectFileScenario, projectFileBaseLine, workingPathScenario, workingPathBaseLine,
        projectPathDiff);
  }

  protected void cookieCutAllLayersToBaseLinePath(File workingPath, Map<Layer, String> layerFiles,
      List<LayerObject> userLayers, Envelope2D extend) throws IOException {
    final CookieCut cc = new CookieCut(workingPath.getAbsolutePath());
    // create all source files
    layerFiles.entrySet().stream().forEach(e -> {
      try {
        final String sourceFile = e.getValue();

        cc.run(rasterLayers.mapOriginalFilePath(sourceFile), rasterLayers.mapFilePath(workingPath, sourceFile), extend);
      } catch (IOException | InterruptedException e1) {
        e1.printStackTrace();
      }
    });
  }

  protected void copyInputToWorkingMap(Map<Layer, String> layerFiles, File workingPath, List<LayerObject> userLayers, String prefix) {
    userLayers.stream().map(ul -> writeToXYZFile(layerFiles, workingPath, ul, prefix))
        .collect(Collectors.toList());
    return;
  }

  private File writeToXYZFile(Map<Layer, String> layerFiles, File workingPath, LayerObject layerObject, String prefix) {
    File file = writeToFile(layerFiles, workingPath, layerObject, XYZ_DOT_EXT, prefix);
    return file;
  }


  protected void prePrepocessSenarioMap(Map<Layer, String> layerFiles, File workingPath, List<LayerObject> userLayers, String prefix) {
    for (LayerObject layer : userLayers) {
      File xyzFile = new File(workingPath, prefix + layerFiles.get(Layer.fromValue(layer.getClassType().toUpperCase())) + XYZ_DOT_EXT);
      final File mapFile = new File(FilenameUtils.removeExtension(xyzFile.getAbsolutePath()) + MAP_DOT_EXT);
      try {
        preProcessRunner.runPreProcessor("", xyzFile, mapFile, prefix);
      } catch (final IOException | InterruptedException e) {
        e.printStackTrace();
      }
    }
  }

}
