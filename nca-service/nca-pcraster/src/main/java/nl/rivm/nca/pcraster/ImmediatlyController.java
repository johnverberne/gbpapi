package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;

public class ImmediatlyController extends Controller implements ControllerInterface {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ImmediatlyController.class);

	public ImmediatlyController(File path, boolean directFile) throws IOException, InterruptedException {
		super(path, directFile);
	}

	@Override
	public List<AssessmentResultResponse> run(String correlationId, AssessmentRequest assessmentRequest)
			throws IOException, ConfigurationException, InterruptedException {
		final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();
		final File outputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS)).toFile();
		/*
		final Map<String, String> layerFiles = rasterLayers.getLayerFiles(assessmentRequest.getEcoSystemService());
		final File first = copyInputRastersToWorkingMap(layerFiles, workingPath, assessmentRequest.getLayers());
		final Envelope2D extend = calculateExtend(first);
		cookieCutOtherLayersToWorkingPath(workingPath, layerFiles, assessmentRequest.getLayers(), extend);
		*/
		final File projectFile = ProjectIniFile.generateIniFile(workingPath.getAbsolutePath(), outputPath.getAbsolutePath());
		LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
		runPcRaster(correlationId, assessmentRequest.getEcoSystemService(), projectFile);
		//convertOutput(outputPath);
		List<AssessmentResultResponse> assessmentResultlist = importOutputToDatabase(correlationId, outputPath);
		//publishFiles(correlationId, outputPath);
		cleanUp(workingPath);
		return assessmentResultlist;
	
	}
	
}
