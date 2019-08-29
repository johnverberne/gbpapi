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
   * values from xyz file.
   * 
   * @param correlationId
   * @param xyzFile 
   * @param mapFile
   * @param jobLogger 
   * @throws IOException
   * @throws InterruptedException
   */
  public void runPreProcessor(String correlationId, File xyzFile, File mapFile, String PREFIX, java.util.logging.Logger jobLogger)
      throws IOException, InterruptedException {
    String xyzFilePath = xyzFile.getAbsolutePath();
    String mapFilePath = mapFile.getAbsolutePath().replace(PREFIX, "");
    // new file will be created in batch file
    String editMapFilePath = new File(mapFilePath.replace(".map", "_edit.map")).getAbsolutePath();
    String newMapFilePath = new File(mapFilePath.replace(".map", "_new.map")).getAbsolutePath();
    // parse as parameter string
    String mapFileParameter = paramString(mapFilePath.replaceAll("\\/", "\\\\"));
    String editMapFileParameter = paramString(editMapFilePath.replaceAll("\\/", "\\\\"));
    String newMapFileParameter = paramString(newMapFilePath.replaceAll("\\/", "\\\\"));
    final String[] args = {xyzFilePath, editMapFilePath, mapFilePath, editMapFileParameter, mapFileParameter, newMapFileParameter};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false); // run as batch file
    exec.setJobLogger(jobLogger);
    exec.run(correlationId, new File(xyzFile.getParent()));
  }

  private String paramString(String parma) {
    return "\"" + parma + "\"";
  }
}
