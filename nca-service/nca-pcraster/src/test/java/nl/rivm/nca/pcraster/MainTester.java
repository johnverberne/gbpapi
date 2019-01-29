package nl.rivm.nca.pcraster;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MainTester {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(MainTester.class);

  public static void main(final String[] args) throws InterruptedException {

    try {

      
      LOGGER.error("Current isDebugEnabled: {}", LOGGER.isDebugEnabled());

      LOGGER.debug("start");
      LOGGER.info("info");
      LOGGER.warn("warn");
      LOGGER.error("error");

    
    } catch (final Exception e) {
      LOGGER.error("Program stopped with error: '{}', see log file for details.", e.getMessage());
      LOGGER.debug("Main failed with error:", e.getMessage(), e);
      System.exit(1);
    }
    System.exit(0);
  }
  
}