package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;
import nl.rivm.nca.runner.OSUtils;

class PcRasterRunner {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(PcRasterRunner.class);
  
    // TODO we want a version in the executed string parsed from the api
	private static final String PYTHON = "python";
	private static final String NCA = "/opt/nkmodel/nca.sh"; //{NKMODEL_PATH}/bin/nca.sh
	private static final String NCA_WIN = "/opt/nkmodel/nca.bat"; //{NKMODEL_PATH}/bin/nca.bat

	public void sanityCheck() throws IOException, InterruptedException {
		final String[] args = { "-c", "\"import pcraster\"" };
		final ExecParameters execParams = new ExecParameters(PYTHON, args);
		final Exec exec = new Exec(execParams, "", false); // run as batch file
		exec.run(new File(""));
	}

	public void runPcRaster(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine, File workingPath)
			throws IOException, InterruptedException {
		final String RUNNER = OSUtils.isWindows() ? NCA_WIN : NCA;
		String absoluteScenarioPathOnly = projectFileScenario.getAbsolutePath().replace("project.ini", "outputs\\");
		final String[] args = { ecoSystemService, projectFileScenario.getAbsolutePath(), absoluteScenarioPathOnly, absoluteScenarioPathOnly};
		final ExecParameters execParams = new ExecParameters(RUNNER, args);
		final Exec exec = new Exec(execParams, "", false); // run as batch file

		LOGGER.debug("Execute: ({}) with parameters: {}", RUNNER, args);
		exec.run(correlationId, new File(projectFileScenario.getParent()));
	}
}
