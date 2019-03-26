package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FilenameUtils;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.DataType;
import nl.rivm.nca.api.domain.LayerObject;

public class NKModel2Controller extends Controller implements ControllerInterface {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(NKModel2Controller.class);
	
	private static final String XYZ_EXT = "xyz";
	private static final String XYZ_DOT_EXT = "." + XYZ_EXT;

	public NKModel2Controller(File path, boolean directFile) throws IOException, InterruptedException {
		super(path, directFile);
	}

	
	/*
	 * This version of the code expects a special layer
	 * 
	 * Create 3 directories
	 * WorkingMap
	 * BaseLineMap
	 * ResultMap
	 * 
	 * Run the model 
	 * Collect the results
	 */
	
	
	@Override
	public List<AssessmentResultResponse> run(String correlationId, AssessmentRequest assessmentRequest)
			throws IOException, ConfigurationException, InterruptedException {
		final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();
		final File outputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS)).toFile();
		final Map<String, String> layerFiles = rasterLayers.getLayerFiles(assessmentRequest.getEcoSystemService());
		final File first = copyInputRastersToWorkingMap(layerFiles, workingPath, assessmentRequest.getLayers());
		final Envelope2D extend = calculateExtend(first);
		cookieCutOtherLayersToWorkingPath(workingPath, layerFiles, assessmentRequest.getLayers(), extend);
		// create baseline workingMap
		copyInputRasterToBaseLineMap(layerFiles, workingPath, assessmentRequest.getLayers());
		final File projectFile = ProjectIniFile.generateIniFile(workingPath.getAbsolutePath(),outputPath.getAbsolutePath());
		
		LOGGER.info("Run the actual model nkmodel with pcRaster batch file.");
		runPcRaster(correlationId, assessmentRequest.getEcoSystemService(), projectFile);
		convertOutput(outputPath);
		List<AssessmentResultResponse> assessmentResultlist = importOutputToDatabase(correlationId, outputPath);
		publishFiles(correlationId, outputPath);
		cleanUp(workingPath);
		return assessmentResultlist;
	}

	private void copyInputRasterToBaseLineMap(Map<String, String> layerFiles, File workingPath, List<LayerObject> layers) {
		
	}
	

	private File writeToFileConvertToTiff(Map<String, String> layerFiles, File workingPath, LayerObject layerObject) {
		File file = writeToFile(layerFiles, workingPath, layerObject);
		if (layerObject.getDataType() == DataType.GEOTIFF) {
			return file;
		} else {
			return convertXyzInput2GeoTiff(file);
		}
	}

	private File convertXyzInput2GeoTiff(File xyzFile) {
		final int indexOf = xyzFile.getName().indexOf(XYZ_DOT_EXT);

		if (indexOf < 0) {
			throw new RuntimeException("no xyz file");
		}

		final File geotiffFile = new File(FilenameUtils.removeExtension(xyzFile.getAbsolutePath()) + GEOTIFF_DOT_EXT);
		final File mapFile = new File(FilenameUtils.removeExtension(xyzFile.getAbsolutePath()) + MAP_DOT_EXT);

		try {
			// convert input xyz to tiff
			Xyz2Geotiff.xyz2geoTiff(xyzFile, geotiffFile);
			// convert input xyz to map file
			Xyz2Geotiff.xyz2gmap(xyzFile, mapFile);
			
		} catch (final IOException e) {
			e.printStackTrace();
		}
		return geotiffFile;
	}
	
	private File userGeotiffFile(Map<String, String> layerFiles, File workingPath, LayerObject layerObject) {
		return new File(workingPath, layerFiles.get(layerObject.getClassType()) + GEOTIFF_DOT_EXT);
	}

	private File userXyzFile(Map<String, String> layerFiles, File workingPath, LayerObject layerObject) {
		return new File(workingPath, layerFiles.get(layerObject.getClassType()) + XYZ_DOT_EXT);
	}

}
