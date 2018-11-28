package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.apache.commons.configuration2.INIConfiguration;
import org.apache.commons.configuration2.ex.ConfigurationException;

/**
 *
 */
public class ProjectIniFile {

  private static final String PROJECT_INI = "project.ini";
  private static final String OUTPUT_DIRECTORY = "output.directory";
  private static final String INPUT_RASTER = "input.raster";

  public static File generateIniFile(String workingPath, String outputPath) throws ConfigurationException, IOException {
    final INIConfiguration ini = new INIConfiguration();

    ini.addProperty(INPUT_RASTER, workingPath);
    ini.addProperty(OUTPUT_DIRECTORY, outputPath);
    final File projectFile = new File(workingPath, PROJECT_INI);

    ini.write(new FileWriter(projectFile));
    return projectFile;
  }
}
