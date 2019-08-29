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
  
  private static final String RUNNER = RunnerEnum.NCA.getRunner();
  private static final String PYTHON = "python";

	public void sanityCheck() throws IOException, InterruptedException {
		final String[] args = { "-c", "\"import pcraster\"" };
		final ExecParameters execParams = new ExecParameters(PYTHON, args);
		final Exec exec = new Exec(execParams, "", false);
		exec.run(new File(""));
	}

	public void runPcRaster(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine, File workingPath)
			throws IOException, InterruptedException {
		String absoluteScenarioPathOnly = projectFileScenario.getAbsolutePath().replace("project.ini", "outputs\\");
		final String[] args = { ecoSystemService, projectFileScenario.getAbsolutePath(), absoluteScenarioPathOnly, absoluteScenarioPathOnly};
		final ExecParameters execParams = new ExecParameters(RUNNER, args);
		final Exec exec = new Exec(execParams, "", false); // run as batch file
		LOGGER.debug("Execute: ({}) with parameters: {}", RUNNER, args);
		exec.run(correlationId, new File(projectFileScenario.getParent()));
	}
}
