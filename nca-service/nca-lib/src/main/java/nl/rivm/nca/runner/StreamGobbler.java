package nl.rivm.nca.runner;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Utility class to correctly use output stream of a invoked process. Can be
 * needed for process to end gracefully
 *
 * @see http://www.javaworld.com/javaworld/jw-12-2000/jw-1229-traps.html
 */
public class StreamGobbler extends Thread {
  private static final Logger LOGGER = LoggerFactory.getLogger(StreamGobbler.class);
  

  /**
   * Some calculation methods give some useless error messages, because it tries to execute a clear command that isn't present,
   *  tries to use a UI object while running via the console (wine) etc. It results in clobbering the error stream.
   * Here are the complete strings of those error messages so they can be filtered out.
   */
  private static final List<String> IGNORE_ERROR_LINES = Arrays.asList(new String[] {
  });
  private final String type;
  private final String parentId;
  private InputStream is;
  private java.util.logging.Logger jobLogger;

  /**
   * Constructor of the stream gobbler.
   *
   * @param type type of stream, ERROR, or OUTPUT
   * @param level error level to report on
   * @param parentId id of the process using the StreamGobbler, used for reference
   */
  public StreamGobbler(final String type, final String parentId) {
    this.type = type;
    this.parentId = parentId;
  }
  
  /**
   * Constructor of the stream gobbler.
   *
   * @param type type of stream, ERROR, or OUTPUT
   * @param level error level to report on
   * @param parentId id of the process using the StreamGobbler, used for reference
   * @param jobLogger logger object for log of a run
   */
  public StreamGobbler(final String type, final String parentId, java.util.logging.Logger jobLogger) {
    this.type = type;
    this.parentId = parentId;
    this.jobLogger = jobLogger;
  }

  protected InputStream getInputStream() {
    return is;
  }

  /**
   * Set the input steam.
   * @param is inputSteam of data
   */
  public void setInputStream(final InputStream is) {
    this.is = is;
  }

  /**
   * Start the thread dealing with the stream output.
   */
  @Override
  public void run() {
    try (final BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
      String line = "";
      while ((line = br.readLine()) != null) { // eof
        if (!line.isEmpty() && containsError(line)) {
          logLine(line);
        }
      }
    } catch (final IOException ioe) {
      LOGGER.error("Error gobbling stream", ioe);
      if (jobLogger != null) {
        jobLogger.info("Error gobbling stream " + ioe);
      }
    }
  }

  private void logLine(final String line) {
    if (line.indexOf("ERROR") > -1) {
      LOGGER.error("{}:{}>{}", parentId, type, line);
      if (jobLogger != null) {
        //jobLogger.info(parentId + ":" + type + ">" + line);
        jobLogger.info(type + " > " + line);
        
      }
    } else {
      LOGGER.info("{}:{}>{}", parentId, type, line);
      if (jobLogger != null) {
        //jobLogger.info(parentId + ":" + type + ">" + line);
        jobLogger.info(line);
        
      }
    }
  }

  /**
   * Returns true if the line contains an error message
   * @param line line to check
   * @return true if line contains error.
   */
  protected boolean containsError(final String line) {
    return !IGNORE_ERROR_LINES.contains(line);
  }
}
