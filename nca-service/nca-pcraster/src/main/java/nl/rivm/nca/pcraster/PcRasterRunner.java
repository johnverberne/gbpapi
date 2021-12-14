package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

class PcRasterRunner {

  private static final Logger LOGGER = LoggerFactory.getLogger(PcRasterRunner.class);
  private static final String RUNNER = RunnerEnum.NCA.getRunner();
  private static final String RUNNER_BASELINE = RunnerEnum.NCA_BASELINE.getRunner();
  private static final String RUNNER_SCENARIO = RunnerEnum.NCA_SCENARIO.getRunner();

  enum RunnerType {
    // run the model only for baseline
    RUNNER_BASELINE,
    // run the complete model
    RUNNER,
    // run the model only for scenario
    RUNNER_SCENARIO;
  }

  public void runPcRaster(final String correlationId, final String ecoSystemService, final File projectFileScenario, final File projectFileBaseLine,
      final File workingPathScenario, final File workingFileBaseLine, final File projectFileDiff, final RunnerType runnerType, 
      final java.util.logging.Logger jobLogger)
      throws IOException, InterruptedException {
    final String[] args = {ecoSystemService, projectFileScenario.getAbsolutePath(), projectFileBaseLine.getAbsolutePath(),
        workingPathScenario.getAbsolutePath(), workingFileBaseLine.getAbsolutePath(), projectFileDiff.getAbsolutePath()};
    String actualRunner = "";
    switch (runnerType) {
    case RUNNER:
      actualRunner = RUNNER;
      break;
    case RUNNER_BASELINE:
     actualRunner = RUNNER_BASELINE;
     break;
    case RUNNER_SCENARIO:
      actualRunner = RUNNER_SCENARIO;
      break;
    default:
      actualRunner = RUNNER;
    }
    final ExecParameters execParams = new ExecParameters(actualRunner, args);
    final Exec exec = new Exec(execParams, "", false); // run as batch file
    LOGGER.debug("Execute: ({}) with parameters: {}", actualRunner, args);
    jobLogger.info("Execute: (" + actualRunner + ") with parameters: " + args);
    jobLogger.info(String.format("Execute (%s) with parameters: %s", actualRunner, Arrays.toString(args)));
    exec.setJobLogger(jobLogger);
    exec.run(correlationId, new File(projectFileScenario.getParent()));
  }

}
