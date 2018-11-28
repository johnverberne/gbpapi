package nl.rivm.nca.runner;

/**
 * Util class for OS related functionality.
 */
public final class OSUtils {

  /**
   * Windows newline characters.
   */
  public static final String WNL = "\r\n";
  /**
   * Linux newline character.
   */
  public static final String LNL = "\n";
  /**
   * New line based on current OS running.
   */
  public static final String NL = OSUtils.isWindows() ? OSUtils.WNL : OSUtils.LNL;

  private OSUtils() {
  }

  /**
   * Returns true if the current OS is windows.
   *
   * @return true if os is Windows
   */
  public static boolean isWindows() {
    return System.getProperty("os.name").startsWith("Windows");
  }
}