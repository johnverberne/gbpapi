package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

class PreProcessTKSRunner {

  private static final Logger LOGGER = LoggerFactory.getLogger(PreProcessTKSRunner.class);

  final static String RUNNER = RunnerEnum.NCA_TKS_PREPROCESS.getRunner();
  
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
  public void runPreProcessorTiffToMap(String correlationId, File tiffFile, File mapFile, String PREFIX, java.util.logging.Logger jobLogger)
      throws IOException, InterruptedException {
    String tifFilePath = tiffFile.getAbsolutePath();
    String mapFilePath = mapFile.getAbsolutePath().replace(PREFIX, ""); // remove the org_
    // new file will be created with batch file
    String editMapFilePath = new File(mapFilePath.replace(".map", "_edit.map")).getAbsolutePath();
    String newMapFilePath = new File(mapFilePath.replace(".map", "_new.map")).getAbsolutePath();
    // parse as parameter string
    String mapFileParameter = paramString(mapFilePath.replaceAll("\\/", "\\\\"));
    String editMapFileParameter = paramString(editMapFilePath.replaceAll("\\/", "\\\\"));
    String newMapFileParameter = paramString(newMapFilePath.replaceAll("\\/", "\\\\"));
    final String[] args = {tifFilePath, editMapFilePath, mapFilePath, editMapFileParameter, mapFileParameter, newMapFileParameter};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false); // run as batch file
    exec.setJobLogger(jobLogger);
    exec.run(correlationId, new File(tiffFile.getParent()));
  }

  private String paramString(String parma) {
    return "\"" + parma + "\"";
  }
}
