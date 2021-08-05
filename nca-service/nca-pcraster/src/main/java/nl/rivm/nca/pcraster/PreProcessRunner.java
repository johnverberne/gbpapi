package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

class PreProcessRunner {

  private static final Logger LOGGER = LoggerFactory.getLogger(PreProcessRunner.class);

  final static String RUNNER = RunnerEnum.NCA_PREPROCESS.getRunner();
  
  /**
   * create a new map (edit_map) file from current map file mutated with the
   * values from tiff posible converted to map file file.
   * 
   * @param correlationId
   * @param tiffFile 
   * @param mapFile
   * @param jobLogger 
   * @throws IOException
   * @throws InterruptedException
   */
  public void runPreProcessorTiffToMap(String correlationId, File mapFile, File editMapFilePath, String PREFIX, java.util.logging.Logger jobLogger)
      throws IOException, InterruptedException {
    String mapFilePath = mapFile.getAbsolutePath().replace(PREFIX, ""); // remove the org_
    // this file show intermediate difference can be removed in future
    String newMapFilePath = new File(editMapFilePath.getAbsolutePath().replace(".map", "_new.map")).getAbsolutePath(); 
    // parse as parameter string
    String mapFileParameter = paramString(mapFilePath.replaceAll("\\/", "\\\\"));
    String editMapFileParameter = paramString(editMapFilePath.getAbsolutePath().replaceAll("\\/", "\\\\"));
    String newMapFileParameter = paramString(newMapFilePath.replaceAll("\\/", "\\\\"));
    final String[] args = {editMapFileParameter, mapFileParameter, newMapFileParameter};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false); // run as batch file
    exec.setJobLogger(jobLogger);
    exec.run(correlationId, new File(mapFile.getParent()));
  }

  private String paramString(String parma) {
    return "\"" + parma + "\"";
  }
}
