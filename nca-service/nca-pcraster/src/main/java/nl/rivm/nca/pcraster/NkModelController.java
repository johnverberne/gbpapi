package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.Layer;

/*
 * Run the model with a TIFF Source file
 * 
 * 
 */
public class NkModelController extends BaseController implements ControllerInterface {

  private static final Logger LOGGER = LoggerFactory.getLogger(NkModelController.class);

  public NkModelController(File path, boolean directFile) throws IOException, InterruptedException {
    super(path, directFile);
  }

  @Override
  public List<AssessmentResultResponse> run(String correlationId, AssessmentRequest assessmentRequest)
      throws IOException, ConfigurationException, InterruptedException {
    final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();
    final File outputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS)).toFile();
    final Map<Layer, String> layerFiles = rasterLayers.getLayerFiles(assessmentRequest.getEcoSystemService());
    final File first = copyInputToWorkingMap(layerFiles, workingPath, assessmentRequest.getLayers(), GEOTIFF_DOT_EXT, "");
    final Envelope2D extend = calculateExtend(first);
    cookieCutOtherLayersToWorkingPath(workingPath, layerFiles, assessmentRequest.getLayers(), extend, null);
    final File projectFile = ProjectIniFile.generateIniFile(workingPath.getAbsolutePath(), outputPath.getAbsolutePath());

    LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
    runPcRaster(correlationId, assessmentRequest.getEcoSystemService(), projectFile, projectFile, outputPath);
    convertOutput(outputPath, null);
    List<AssessmentResultResponse> assessmentResultlist = importJsonResult(correlationId, outputPath);
    publishFiles(correlationId, outputPath, null);
    cleanUp(workingPath, false);
    return assessmentResultlist;
  }

  @Override
  public String getDownloadFileUrl() {
    return "";
  };

}
