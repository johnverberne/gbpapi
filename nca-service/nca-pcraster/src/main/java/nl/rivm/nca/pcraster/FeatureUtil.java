package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

import nl.rivm.nca.api.domain.FeatureCollection;
import nl.rivm.nca.api.domain.Features;
import nl.rivm.nca.api.domain.MeasureType;
import nl.rivm.nca.api.domain.FeatureCollection.TypeEnum;

public class FeatureUtil {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(FeatureUtil.class);

  
  @SuppressWarnings("unchecked")
  static public void exportGroupedFeatures(HashMap<MeasureType, ArrayList<Features>> measures, FeatureCollection features, File workingPath,
      java.util.logging.Logger jobLogger) {
    // export for the geomety of every measure with measure settings
    for (Map.Entry m : measures.entrySet()) {
      exportFeatures("measure_" + m.getKey().toString() + ".geojson", (ArrayList<Features>) m.getValue(), features, workingPath, jobLogger);
    }
  }
  
  static public void exportFeatures(String fileName, ArrayList<Features> value, final FeatureCollection features, final File workingPath,
      final java.util.logging.Logger jobLogger) {
    LOGGER.debug("measure {} has {} entries", fileName, value == null ? 0 : value.size());
    // write to geojson file as features
    FeatureCollection f = new FeatureCollection();
    f.setType(TypeEnum.FEATURECOLLECTION);
    f.setBbox(features.getBbox()); // add the boudingbox
    f.setFeatures(value);
    final Gson gson = new Gson();
    String jsonToSend = gson.toJson(f);
    // correct the conversion 
    jsonToSend = jsonToSend.replace("FEATURECOLLECTION", TypeEnum.FEATURECOLLECTION.toString());
    LOGGER.debug("writing file ({})", workingPath + "/" + fileName);
    jobLogger.info("Meausure " + fileName + " Creating file " + workingPath + "/" + fileName);
    try (FileWriter file = new FileWriter(workingPath + "/" + fileName)) {
      file.write(jsonToSend);
      file.flush();
      file.close(); // autoclose ?
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

}
