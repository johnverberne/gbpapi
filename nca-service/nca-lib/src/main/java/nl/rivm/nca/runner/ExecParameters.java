package nl.rivm.nca.runner;

/**
 * Contains the various calculation methods that we can use in the worker.
 */
public class ExecParameters {

  /**
   * Windows Executable extension.
   */
  private static final String WINDOWS_EXE_EXT = ".exe";

  // Executable file name, without the executable extension if present.
  private final String executeableFilename;
  // Optional args that are placed before the final arg, which is the settingsfile/ID of project and such to calculate.
  private final String[] args;

  public ExecParameters(final String executeableFilename, final String ... args) {
    this.executeableFilename = executeableFilename;
    this.args = args;
  }

  public String getExecuteableFilename() {
    return executeableFilename;
  }

  /**
   * Get the executable filename.
   * @param windowsBinary Whether the binary is the Windows one, if so append the Windows executable extension to the filename.
   * @return executable filename
   */
  public String getExecuteableFilename(final boolean windowsBinary) {
    return executeableFilename + (windowsBinary ? WINDOWS_EXE_EXT : "");
  }

  public String[] getArgs() {
    return args;
  }
}
