package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import nl.rivm.nca.api.domain.LayerFile;
import nl.rivm.nca.api.domain.MapLayers;


/**
 * 
 * 
 * Fueture implementation for get the map layers from a json file.
 *
 */
public class ModelMapLayers {

  final static String MAPLAYERS = EnvironmentEnum.NCA_MODEL_RUNNER.getEnv() + "/" + "map_layers.json"; //EnvironmentEnum.NCA_MAP_LAYERS.getEnv();
  final static ObjectMapper mapper = new ObjectMapper();
  
  public static MapLayers load() throws IOException {
    final File mapLayersFile = new File(MAPLAYERS);
    @SuppressWarnings("resource")
    FileReader fr = new FileReader(mapLayersFile.getAbsolutePath());
    int i;
    String body = "";
    while ((i = fr.read()) != -1)
      body += (char) i;
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    return mapper.readValue(body, MapLayers.class);
  }
  
  public static List<LayerFile> loadRunable() throws IOException {
    return load().getLayerFiles();  
  }
  
  public static String getEnvironment() {
    return MAPLAYERS;
  }

}
