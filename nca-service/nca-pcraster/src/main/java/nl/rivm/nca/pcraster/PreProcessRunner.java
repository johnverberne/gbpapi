package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;
import nl.rivm.nca.runner.OSUtils;

class PreProcessRunner {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(PreProcessRunner.class);
  
    // TODO we want a version in the executed string parsed from the api
	private static final String NCA_PREPROCESS = "/opt/nkmodel/nca_preprocess_scenario_map.sh"; //{NKMODEL_PATH}/bin/nca_preprocess_scenario_map.sh
	private static final String NCA_WIN_PREPROCESS = "/opt/nkmodel/nca_preprocess_scenario_map.bat"; //{NKMODEL_PATH}/nca_preprocess_scenario_map.bat

	/*
	 * create a new map (edit_map) file from current map file mutated with the values from xyz file.
	 * 
	 * input xyz
	 * output map
	 * output edit_map
	 */
	public void runPreProcessor(String correlationId, File xyzFile, File mapFile)
			throws IOException, InterruptedException {
		final String RUNNER = OSUtils.isWindows() ? NCA_WIN_PREPROCESS : NCA_PREPROCESS;
		String xyzFilePath = xyzFile.getAbsolutePath();
		String editMapFilePath = new File(mapFile.getAbsolutePath().replace(".map", "_edit.map")).getAbsolutePath();
		String mapFilePath = mapFile.getAbsolutePath();
		String pcrCalcParameter = "\""+ mapFilePath + "=cover\\(" + mapFilePath + "," + editMapFilePath + "\\)\""; 
		final String[] args = {xyzFilePath,  editMapFilePath, mapFilePath, pcrCalcParameter};
		final ExecParameters execParams = new ExecParameters(RUNNER, args);
		final Exec exec = new Exec(execParams, "", false); // run as batch file

		LOGGER.debug("Execute: ({}) with parameters: {}", RUNNER, args);
		exec.run(correlationId, new File(xyzFile.getParent())); //new File(projectFileScenario.getParent())
	}
}
