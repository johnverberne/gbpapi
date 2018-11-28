package nl.rivm.nca.pcraster;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.UUID;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.junit.Test;

/**
 * Test class for {@link ProjectIniFile}.
 */
public class ProjectIniFileTest {

  @Test
  public void testGenerateFile() throws ConfigurationException, IOException {
    final String workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile().getAbsolutePath();
    final File projectFile = ProjectIniFile.generateIniFile(workingPath, workingPath);
    assertTrue("Project ini file should exist", projectFile.exists());
  }
}
