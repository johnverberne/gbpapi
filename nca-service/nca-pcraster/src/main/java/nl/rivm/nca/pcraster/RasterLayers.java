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

  /**
   * List of enum for map to charts that must be included in the model
   * the name for the file is case sensitive 
   */
  private static void hardCodeTmp(Map<String, Map<Layer, String>> layers) {
    final Map<Layer, String> arLayers = new HashMap<>();
    arLayers.put(Layer.LAND_COVER, "LCEU_ini");
    arLayers.put(Layer.PM_10, "conc_pm10_2016");
    arLayers.put(Layer.POPULATION, "Inwoners");
    arLayers.put(Layer.TREES, "bomenkaart");
    arLayers.put(Layer.SHRUBS, "struikenkaart");
    arLayers.put(Layer.GRASS, "graskaart");
    arLayers.put(Layer.MASK, "Mask"); // reference to a file that is in uppercase
    arLayers.put(Layer.CROP, "Gewas");
    arLayers.put(Layer.TREE_HEIGHT, "boomhoogte");
    arLayers.put(Layer.WINDFORCE, "windkaart");
    arLayers.put(Layer.WOZ, "WOZ_buurt");
    arLayers.put(Layer.WATER, "Meer_plas_zee");
    
    // addition chart layers
    
    arLayers.put(Layer.WETFOREST, "BT_NatBos_OppFract");
    arLayers.put(Layer.PRODFOREST, "BT_ProdBos_OppFract");
    arLayers.put(Layer.GHG, "GHG");
    arLayers.put(Layer.GLG, "GLG");
    arLayers.put(Layer.GWT, "GWT");
    arLayers.put(Layer.POPULATION2018, "InwAantal2018");
    arLayers.put(Layer.SBU, "SBU");
    arLayers.put(Layer.WOZ2018, "WOZ_2018");
    
    layers.put("air_regulation", arLayers);

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
