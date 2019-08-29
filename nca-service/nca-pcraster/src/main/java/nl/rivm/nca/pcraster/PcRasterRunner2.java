package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

class PcRasterRunner2 {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(PcRasterRunner2.class);
  private static final String RUNNER = RunnerEnum.NCA2.getRunner();

	public void runPcRaster(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine, File workingPathScenario, File workingFileBaseLine, File projectFileDiff, java.util.logging.Logger jobLogger )
			throws IOException, InterruptedException {
		final String[] args = { ecoSystemService, projectFileScenario.getAbsolutePath(), projectFileBaseLine.getAbsolutePath(), workingPathScenario.getAbsolutePath(), workingFileBaseLine.getAbsolutePath(), projectFileDiff.getAbsolutePath() };
		final ExecParameters execParams = new ExecParameters(RUNNER, args);
		final Exec exec = new Exec(execParams, "", false); // run as batch file
		LOGGER.debug("Execute: ({}) with parameters: {}", RUNNER, args);
		jobLogger.info("Execute: (" + RUNNER + ") with parameters: " + args );
		jobLogger.info(String.format("Execute (%s) with parameters: %s", RUNNER, Arrays.toString(args)));
		exec.setJobLogger(jobLogger);
		exec.run(correlationId, new File(projectFileScenario.getParent()));
	}
	
}
