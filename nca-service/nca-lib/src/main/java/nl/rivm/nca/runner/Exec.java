package nl.rivm.nca.runner;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.UUID;

import org.apache.logging.log4j.util.Strings;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Performs the actual execution of the CalculationMethod executable and wraps the output to be directed correctly.
 */
public final class Exec {

  private static final Logger LOGGER = LoggerFactory.getLogger(Exec.class);
  private java.util.logging.Logger jobLogger;

  private static final String ERROR_LOGGING_PREFIX = "ERROR";
  private static final String OUTPUT_LOGGING_PREFIX = "OUTPUT";

  private final ExecParameters executeParameters;
  private final String binDir;
  private final boolean runAsWindows;

  /**
   * Initializes.
   *
   * @param execParameters the exec parameters to use for this execution.
   * @param binDir directory to the executable
   */
  public Exec(final ExecParameters execParameters, final String binDir) {
    this.executeParameters = execParameters;
    this.binDir = binDir;
    this.runAsWindows = OSUtils.isWindows();
  }

  /**
   * Initializes.
   *
   * @param execParameters the exec parameters to use for this execution.
   * @param binDir directory to the executable
   * @param boolean to indicate to add .exe for windows envirorment
   */
  public Exec(final ExecParameters execParameters, final String binDir, final boolean runAsWindows) {
    this.executeParameters = execParameters;
    this.binDir = binDir;
    this.runAsWindows = runAsWindows;
  }

  public String run(final File currentWorkingDirectory) throws IOException, InterruptedException {
    final String uuid = UUID.randomUUID().toString();

    run(uuid, currentWorkingDirectory);
    return uuid;
  }

  /**
   * Run with default stream gobblers.
   * @param runId the ID that is only used when logging, so the process running can be identified
   * @param runArgument the argument that is needed for the calculation method to run, like the id of the project or path to a file.
   * @param currentWorkingDirectory The current working directory to use (optional). If null, the current working directory of
   *  the process executing it will be used.
   * @throws IOException on I/O errors
   * @throws InterruptedException on interrupted streams
   */
  public void run(final String runId, final File currentWorkingDirectory) throws IOException, InterruptedException {
    run(currentWorkingDirectory,
        new StreamGobbler(OUTPUT_LOGGING_PREFIX, executeParameters.getExecuteableFilename() + "-" + runId, jobLogger),
        new StreamGobbler(OUTPUT_LOGGING_PREFIX, "", jobLogger));  //log all stdout
  }

  /**
   *
   * @param runArgument the argument that is needed for the calculation method to run, like the id of the project or path to a file.
   * @param currentWorkingDirectory The current working directory to use (optional). If null, the current working directory of
   *  the process executing it will be used.
   * @param errorGobbler error stream handler
   * @param outputGobbler error stream handler
   * @throws IOException on I/O errors
   * @throws InterruptedException on interrupted streams
   */
  public void run(final File currentWorkingDirectory,
      final StreamGobbler errorGobbler, final StreamGobbler outputGobbler) throws IOException, InterruptedException {
    try {
      final String executeString = Paths.get(binDir, executeParameters.getExecuteableFilename(runAsWindows)).toString();

      final String[] executeArray = new String[executeParameters.getArgs().length + 1];
      executeArray[0] = executeString;
      System.arraycopy(executeParameters.getArgs(), 0, executeArray, 1, executeParameters.getArgs().length);

      if (LOGGER.isDebugEnabled()) {
        LOGGER.debug("Executing: {}", Strings.join(Arrays.asList(executeArray), ' '));
        if (jobLogger != null) {
          jobLogger.info("Executing: " + Strings.join(Arrays.asList(executeArray), ' '));
        }
      }
      final Process process = Runtime.getRuntime().exec(executeArray, null, currentWorkingDirectory);

      // redirect streams to the gobbler to be able to let process.waitFor
      // function correctly
      errorGobbler.setInputStream(process.getErrorStream());
      outputGobbler.setInputStream(process.getInputStream());
      errorGobbler.start();
      outputGobbler.start();
      process.waitFor();
    } finally {
      try {
        if (errorGobbler != null && errorGobbler.isAlive()) {
          errorGobbler.interrupt();
        }
      } catch (final Exception e) {
        LOGGER.error("Error reading error gobbler.", e);
      }
      try {
        if (outputGobbler != null && outputGobbler.isAlive()) {
          outputGobbler.interrupt();
        }
      } catch (final Exception e) {
        LOGGER.error("Error reading output gobbler.", e);
      }
    }
  }

  public void setJobLogger(java.util.logging.Logger jobLogger) {
    this.jobLogger = jobLogger;
  }
}
