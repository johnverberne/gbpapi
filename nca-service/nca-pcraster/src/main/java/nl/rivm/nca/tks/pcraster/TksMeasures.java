package nl.rivm.nca.tks.pcraster;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import nl.rivm.nca.api.domain.MeasureCollection;
import nl.rivm.nca.pcraster.EnvironmentEnum;

class TksMeasures {

  final static String TKSMEASURES = EnvironmentEnum.NCA_MODEL_TKS_RUNNER.getEnv() + "/" + EnvironmentEnum.NCA_TKS_MEASURES.getEnv();
  final static ObjectMapper mapper = new ObjectMapper();
  
  public static MeasureCollection load() throws IOException {
    final File measureModelsFile = new File(TKSMEASURES);
    @SuppressWarnings("resource")
    FileReader fr = new FileReader(measureModelsFile.getAbsolutePath());
    int i;
    String body = "";
    while ((i = fr.read()) != -1)
      body += (char) i;
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    return mapper.readValue(body, MeasureCollection.class);
  }

}
