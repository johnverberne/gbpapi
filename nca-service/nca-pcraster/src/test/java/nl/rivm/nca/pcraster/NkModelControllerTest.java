package nl.rivm.nca.pcraster;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.junit.Test;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import nl.rivm.nca.api.domain.MeasureCollection;

/**
 * Test class for {@link ProjectIniFile}.
 */
public class NkModelControllerTest {

  @Test
  public void testLoadMeasureJson() throws ConfigurationException, IOException {

    final ObjectMapper mapper = new ObjectMapper();
    
    final File measureModelsFile = new File("d:/opt/nkmodel/tks_measures.json");
    @SuppressWarnings("resource")
    FileReader fr = new FileReader(measureModelsFile.getAbsolutePath());
    int i;
    String body = "";
    while ((i = fr.read()) != -1)
      body += (char) i;
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    MeasureCollection measureLayers1 = mapper.readValue(body, MeasureCollection.class);
    
    assertTrue( measureLayers1.getMeasures().size() > 0);
  }
}
