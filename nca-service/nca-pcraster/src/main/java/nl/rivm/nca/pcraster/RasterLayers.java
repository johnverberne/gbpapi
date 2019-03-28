package nl.rivm.nca.pcraster;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class RasterLayers {

  private final Map<String, Map<String, String>> layers = new HashMap<>();
  private final File path;

  public RasterLayers() {
	  this.path = null;
  }
  
  public RasterLayers(File path) {
    this.path = path;
  }

  public static RasterLayers loadRasterLayers(File path) {
    final RasterLayers layers = new RasterLayers(path);
    hardCodeTmp(layers.layers);
    return layers;
  }

  private static void hardCodeTmp(Map<String, Map<String, String>> layers) {
    final Map<String, String> arLayers = new HashMap<>();
    arLayers.put("land_cover", "LCEU_ini");
    arLayers.put("pm_10", "conc_pm10_2016");
    arLayers.put("population", "Inwoners");
    arLayers.put("trees", "bomenkaart");
    arLayers.put("shrubs", "struikenkaart");
    arLayers.put("grass", "graskaart");
    layers.put("air_regulation", arLayers);

    final Map<String, String> ciuaLayers = new HashMap<>();
    ciuaLayers.put("land_cover", "LCEU_ini");
    ciuaLayers.put("roughness_length", "Ruwheidslengte_LU");
    ciuaLayers.put("wind_speed", "windkaart");
    ciuaLayers.put("wind_class", "Windklasse");
    ciuaLayers.put("population", "Inwoners");
    ciuaLayers.put("built_up", "Verhard");
    ciuaLayers.put("uhi_reduction_lut", "UHIreductie");
    ciuaLayers.put("trees", "bomenkaart");
    ciuaLayers.put("shrubs", "struikenkaart");
    ciuaLayers.put("grass", "graskaart");
    layers.put("cooling_in_urban_areas", ciuaLayers);

    final Map<String, String> esbstLayers = new HashMap<>();
    esbstLayers.put("land_cover", "LCEU_ini");
    esbstLayers.put("population", "Inwoners");
    esbstLayers.put("tree_height", "boomhoogte");
    layers.put("energy_savings_by_shelter_trees", esbstLayers);

  }

  public File mapOriginalFilePath(String name) {
    return mapFilePath(path, name);
  }

  public File mapFilePath(File path, String name) {
    return new File(path, name + ".map");
  }

  public Map<String, String> getLayerFiles(String ecoSystemService) {
    return new HashMap<>(layers.get(ecoSystemService));
  }
}
