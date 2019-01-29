package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

class PcRasterRunner {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(PcRasterRunner.class);

	private static final String PYTHON = "python";
	private static final String NCA = "/opt/nkmodel/nca.sh";

	public void sanityCheck() throws IOException, InterruptedException {
		final String[] args = { "-c", "\"import pcraster\"" };
		final ExecParameters execParams = new ExecParameters(PYTHON, args);
		final Exec exec = new Exec(execParams, "");
		exec.run(new File(""));
	}

	public void runPcRaster(String correlationId, String ecoSystemService, File projectFile)
			throws IOException, InterruptedException {
		final String[] args = { ecoSystemService, projectFile.getAbsolutePath() };
		final ExecParameters execParams = new ExecParameters(NCA, args);
		final Exec exec = new Exec(execParams, "");

		LOGGER.debug("Execute: ({}) with parameters: {}", NCA, args);
		exec.run(correlationId, new File(projectFile.getParent()));
	}
}
