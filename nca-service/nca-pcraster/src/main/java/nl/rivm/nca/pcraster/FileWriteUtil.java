package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.attribute.PosixFilePermission;
import java.util.HashSet;
import java.util.Set;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileWriteUtil {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(FileWriteUtil.class);

  static public void createScenarioFile(File workingPath, String request, String fileName) {
    FileWriter fileWriter = null;

    try {
      fileWriter = new FileWriter(workingPath + "/" + fileName);
      fileWriter.write(request);

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
  
  static public void copyRunnerFiles(File workingPath, java.util.logging.Logger jobLogger) {
    try {
      for (RunnerEnum runner : RunnerEnum.values()) {
        String script = runner.getRunner();
        File newFile = new File(workingPath.getAbsolutePath() + script.substring(script.lastIndexOf("/")));
        FileUtils.copyFile(new File(script), newFile);
        adjustRights(newFile);
      }

    } catch (IOException e) {
      // eat error
      LOGGER.error("Problem with copy runner files {}", e.getLocalizedMessage());
      jobLogger.info("Problem with copy runner files " + e.getLocalizedMessage());
    }

  }
  
  static public void writeMeasureCollectionToFile(final String measureCollection, final String fileName, final File workingPath, final java.util.logging.Logger jobLogger) {
    FileWriter fileWriter = null;

    try {
      fileWriter = new FileWriter(workingPath + "/" + fileName);
      fileWriter.write(measureCollection);

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
  
  static public String zipResult(String correlationId, File workingPath) {
    String downloadPath = EnvironmentEnum.NCA_DOWNLOAD_PATH.getEnv();
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
  
  static public void deleteDirectoryRecursively(File dir) throws IOException {
    if (dir.isDirectory() == false) {
      System.out.println("Not a directory. Do nothing");
      return;
    }
    File[] listFiles = dir.listFiles();
    for (File file : listFiles) {
      if (file.isDirectory()) {
        deleteDirectoryRecursively(file);
      } else {
        boolean success = file.delete();
        LOGGER.info("Deleting {} Success = {}", file.getName(), success);
      }

    }
    // now directory is empty, so we can delete it
    LOGGER.info("Deleting Directory. Success = {}", dir.delete());
  }
  
  static public void adjustRights(File inputFile) throws IOException {
    Set<PosixFilePermission> perms = new HashSet<>();
    perms.add(PosixFilePermission.OWNER_READ);
    perms.add(PosixFilePermission.OWNER_WRITE);
    perms.add(PosixFilePermission.OWNER_EXECUTE);

    perms.add(PosixFilePermission.OTHERS_READ);
    perms.add(PosixFilePermission.OTHERS_WRITE);
    perms.add(PosixFilePermission.OTHERS_EXECUTE);

    perms.add(PosixFilePermission.GROUP_READ);
    perms.add(PosixFilePermission.GROUP_WRITE);
    perms.add(PosixFilePermission.GROUP_EXECUTE);

    Files.setPosixFilePermissions(inputFile.toPath(), perms);
  }
  
}
