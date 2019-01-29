package nl.rivm.nca.pcraster;

import java.io.IOException;
import java.util.concurrent.TimeoutException;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * -Dlog4j.configurationFile=/opt/nkmodel/log4j.properties
 * -Dorg.apache.logging.log4j.simplelog.StatusLogger.level=INFO
 * -Dlog4j.debug
 */

public class MainTest {

	private static final Logger LOGGER = LoggerFactory.getLogger(Main.class);

	@Test
	public void main(final String[] args) throws IOException, TimeoutException, InterruptedException {

	  
 try {

      
   LOGGER.error("******** app started with {}", args.length);
   LOGGER.trace("argument amount {} ", args.length);
   LOGGER.info("value 0", args[0]);
   LOGGER.warn("message show");
   LOGGER.error("Nog niet gezien");

    
    } catch (final Exception e) {
      LOGGER.error("Program stopped with error: '{}', see log file for details.", e.getMessage());
      LOGGER.debug("Main failed with error:", e.getMessage(), e);
      System.exit(1);
    }
    System.exit(0);
	  


	}

}
