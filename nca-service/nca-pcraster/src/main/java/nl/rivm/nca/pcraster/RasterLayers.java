package nl.rivm.nca.pcraster;

import java.io.File;
import java.util.EnumMap;
import java.util.HashMap;
import java.util.Map;

import nl.rivm.nca.api.domain.Layer;

public class RasterLayers {

  private final Map<String, Map<Layer, String>> layers = new HashMap<>();
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

  private static void hardCodeTmp(Map<String, Map<Layer, String>> layers) {
    final Map<Layer, String> arLayers = new HashMap<>();
    arLayers.put(Layer.LAND_COVER, "LCEU_ini");
    arLayers.put(Layer.PM_10, "conc_pm10_2016");
    arLayers.put(Layer.POPULATION, "Inwoners");
    arLayers.put(Layer.TREES, "bomenkaart");
    arLayers.put(Layer.SHRUBS, "struikenkaart");
    arLayers.put(Layer.GRASS, "graskaart");
    arLayers.put(Layer.MASK, "mask");
    arLayers.put(Layer.CROP, "gewas");
    arLayers.put(Layer.TREE_HEIGHT, "boomhoogte");
    
    layers.put("air_regulation", arLayers);

//    final Map<String, String> ciuaLayers = new HashMap<>();
//    ciuaLayers.put("land_cover", "LCEU_ini");
//    ciuaLayers.put("roughness_length", "Ruwheidslengte_LU");
//    ciuaLayers.put("wind_speed", "windkaart");
//    ciuaLayers.put("wind_class", "Windklasse");
//    ciuaLayers.put("population", "Inwoners");
//    ciuaLayers.put("built_up", "Verhard");
//    ciuaLayers.put("uhi_reduction_lut", "UHIreductie");
//    ciuaLayers.put("trees", "bomenkaart");
//    ciuaLayers.put("shrubs", "struikenkaart");
//    ciuaLayers.put("grass", "graskaart");
//    layers.put("cooling_in_urban_areas", ciuaLayers);
//
//    final Map<String, String> esbstLayers = new HashMap<>();
//    esbstLayers.put("land_cover", "LCEU_ini");
//    esbstLayers.put("population", "Inwoners");
//    esbstLayers.put("tree_height", "boomhoogte");
//    layers.put("energy_savings_by_shelter_trees", esbstLayers);

  }

  public File mapOriginalFilePath(String name) {
    return mapFilePath(path, name);
  }

  public File mapFilePath(File path, String name) {
    return new File(path, name + ".map");
  }

  public Map<Layer, String> getLayerFiles(String ecoSystemService) {
    return new HashMap<>(layers.get(ecoSystemService));
  }
}
