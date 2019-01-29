package nl.rivm.nca.pcraster;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class HelloLogger {
  private static final Logger LOGGER = LogManager.getLogger(HelloLogger.class.getName());
  
  public static void main(String[] args)
  {
    LOGGER.error("this is a error {}","-error-");
      LOGGER.debug("Debug Message Logged !!!");
      LOGGER.info("Info Message Logged !!!");
      LOGGER.warn("Warn Message Logged !!!");
      LOGGER.error("Error Message Logged !!!", new NullPointerException("NullError"));
  }
}
