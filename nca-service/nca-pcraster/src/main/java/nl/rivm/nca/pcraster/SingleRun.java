package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.commons.io.FilenameUtils;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.DataType;
import nl.rivm.nca.api.domain.LayerObject;

/**
 * Performs a single run
 */
public class SingleRun {

  public static final String GEOTIFF_EXT = "tiff";

  /**
   *
   * @param name user defined name
   * @param ecoSystemService model to run
   * @param inputDirectory directory with geotiff images to use as input
   * @return
   * @throws IOException
   */
  public AssessmentRequest singleRun(String name, String ecoSystemService, final String inputDirectory) throws IOException {
    final Path inputFile = Paths.get(inputDirectory);

    verifyInput(inputFile);
    final AssessmentRequest ar = new AssessmentRequest();

    ar.setName(name);
    ar.setEcoSystemService(ecoSystemService);
    Files.list(inputFile)
      .filter(f -> GEOTIFF_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
      .forEach(f -> append(ar, f));

    return ar;
  }

  private void append(AssessmentRequest ar, Path file) {
    try {
      final LayerObject lo = new LayerObject();

      lo.setClassType(FilenameUtils.removeExtension(file.toFile().getName()));
      lo.setDataType(DataType.GEOTIFF);
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
