package nl.rivm.nca.pcraster;

import java.io.File;
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
    arLayers.put(Layer.BGT_LAND_COVER, "bgt");
    arLayers.put(Layer.TREES, "bomenkaart");
    arLayers.put(Layer.TREE_HEIGHT, "boomhoogte");
    arLayers.put(Layer.WETFOREST, "bt_natbos_oppfract");
    arLayers.put(Layer.PRODFOREST, "bt_prodbos_oppfract");
    arLayers.put(Layer.PM_10, "conc_pm10");
    arLayers.put(Layer.CROP, "gewas");
    arLayers.put(Layer.GHG, "ghg");
    arLayers.put(Layer.GLG, "glg");
    arLayers.put(Layer.GRASS, "graskaart");
    arLayers.put(Layer.GWT, "gwt");
    arLayers.put(Layer.POPULATION, "inwonerkaart");
    arLayers.put(Layer.LGN8, "lgn8_10m");
    arLayers.put(Layer.MASK, "mask");
    arLayers.put(Layer.WATER, "meer_plas_zee");
    arLayers.put(Layer.SBU, "sbu");
    arLayers.put(Layer.SHRUBS, "struikenkaart");
    arLayers.put(Layer.WINDFORCE, "windkaart");
    arLayers.put(Layer.WOZINWONER, "woz_inwoner");    
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
