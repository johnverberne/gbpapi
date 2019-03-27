package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.commons.io.FilenameUtils;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentRequest.ModelEnum;
import nl.rivm.nca.api.domain.DataType;
import nl.rivm.nca.api.domain.LayerObject;

/**
 * Performs a single run
 */
public class SingleRun {

  public static final String GEOTIFF_EXT = "tiff";
  public static final String XYZ_EXT = "xyz";

  /**
   * build a ar object for a singel run
   *
   * @param name user defined name
   * @param ecoSystemService model to run
   * @param inputDirectory directory with geotiff images to use as input
   * @return
   * @throws IOException
   */
	public AssessmentRequest singleRun(String name, String ecoSystemService, final String inputDirectory,
			String inputType, ModelEnum model) throws IOException {
		final Path inputFile = Paths.get(inputDirectory);
		verifyInput(inputFile);
		final AssessmentRequest ar = new AssessmentRequest();

		if (inputType.equals(GEOTIFF_EXT) || inputType.equals(XYZ_EXT)) {
			ar.setModel(model);
			ar.setName(name);
			ar.setEcoSystemService(ecoSystemService);
			Files.list(inputFile).filter(f -> inputType.equals(FilenameUtils.getExtension(f.toFile().getName())))
					.forEach(f -> append(ar, f, inputType.equals(GEOTIFF_EXT) ? DataType.GEOTIFF : DataType.XYZ));
		} else {
			throw new IllegalArgumentException("input type should be '" + GEOTIFF_EXT + " or " + XYZ_EXT + "'.");
		}
		return ar;
	}

  private void append(AssessmentRequest ar, Path file, DataType dataType) {
    try {
      final LayerObject lo = new LayerObject();

      lo.setClassType(FilenameUtils.removeExtension(file.toFile().getName()));
      lo.setDataType(dataType);
      lo.setData(Files.readAllBytes(file));
      ar.addLayersItem(lo);
    } catch (final IOException e) {
      throw new RuntimeException(e);
    }
  }

  private void verifyInput(final Path inputFile) {
    final File directory = inputFile.toFile();
    if (!directory.exists()) {
      throw new IllegalArgumentException("Directory '" + inputFile + "' doesn't exist.");
    }
    if (!directory.isDirectory()) {
      throw new IllegalArgumentException("'" + inputFile + "' is not a directory.");
    }
  }
}
