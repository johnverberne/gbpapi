package nl.rivm.nca.pcraster;

import java.io.File;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.HashMap;
import java.util.Map;

import nl.rivm.nca.api.domain.Features;
import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.Measure;

public class Measures {

  private final Map<Measure, Map<Layer, Double>> layerMeasure = new HashMap<>();
  private final double value;

  public Measures() {
	  this.value = 0;
  }
  
  public Measures(double value) {
    this.value = value;
  }
  
  public static Measures loadMeasureLayers(Double measureLayerValue) {
    final Measures measure = new Measures(measureLayerValue);
    hardCodeTmp(measure.layerMeasure);
    return measure;
  }

  /**
   * List of enum for measures that contains the differt values voor the individual measure
   * that is assiosated with 
   */
  private static void hardCodeTmp(Map<Measure, Map<Layer, Double>> layerMeasure) {
    final Map<Layer, Double> measures_green_roof = new HashMap<>();
    measures_green_roof.put(Layer.TREES, 0d);
    measures_green_roof.put(Layer.SHRUBS, 0d);
    measures_green_roof.put(Layer.GRASS, 0.9);
    layerMeasure.put(Measure.GREEN_ROOF, measures_green_roof);
    
    final Map<Layer, Double> measures_extra_trees = new HashMap<>();
    measures_extra_trees.put(Layer.TREES, 0.9);
    measures_extra_trees.put(Layer.SHRUBS, 0d);
    measures_extra_trees.put(Layer.GRASS, 0d);
    layerMeasure.put(Measure.EXTRA_TREES, measures_extra_trees);

    final Map<Layer, Double> measures_land_use_trees = new HashMap<>();
    measures_land_use_trees.put(Layer.LAND_COVER, 11d);
    layerMeasure.put(Measure.LAND_USE_TREES, measures_land_use_trees);

    layerMeasure.put(Measure.PROJECT, new HashMap<>()); // add empty
    
  }

  public Map<Layer, Number> getMeasureValue(Measure measure) {
    return new HashMap<>(layerMeasure.get(measure));
  }

}
