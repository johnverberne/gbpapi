package nl.rivm.nca.pcraster;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.FileHandler;
import java.util.logging.Formatter;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.logging.Logger;

public class LoggerUtil {
  
  static public float closeJobLogger(Logger jobLogger, FileHandler jobLoggerFile, long start) {
    long end = System.currentTimeMillis();
    float endsec = (end - start) / 1000F;
    jobLogger.info("Total execute time " + end + " seconds");
    jobLogger.removeHandler(jobLoggerFile);
    jobLoggerFile.close();
    return endsec;
  }

 static public Logger createJobLogger(FileHandler jobLoggerFile, long start) {
    java.util.logging.Logger jobLogger = java.util.logging.Logger.getLogger("JobLogger");
    jobLogger.setLevel(Level.ALL);
    jobLoggerFile.setFormatter(new Formatter() {

      @Override
      public String format(LogRecord record) {
        SimpleDateFormat logTime = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
        Calendar cal = new GregorianCalendar();
        cal.setTimeInMillis(record.getMillis());
        return record.getMessage() + "\n\n";
      }

    });
    jobLogger.addHandler(jobLoggerFile);
    jobLogger.info("Start at :" + start);
    return jobLogger;
  }
 
  static public Long writeTimeToJobLogger(final String string, final long start, final Logger jobLogger) {
    long currentTime = System.currentTimeMillis();
    jobLogger.info("");
    jobLogger.info("[" + string + " : " + (currentTime - start) / 1000F + " seconds]");
    jobLogger.info("");
    return currentTime;
  }

  public static void info(String string, Logger jobLogger) {
    jobLogger.info("=== " + string + " ===");
    
  }

}
