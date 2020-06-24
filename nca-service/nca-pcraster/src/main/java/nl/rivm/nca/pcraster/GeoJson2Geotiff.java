package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;
import nl.rivm.nca.runner.OSUtils;

/**
 * Convert a geotiff image to a pcraster file.
 */
public class GeoJson2Geotiff {

  private static final String RUNNER = RunnerEnum.GDAL_RASTERIZE.getRunner();

  public static final String GEOTIFF_EXT = "tiff";
  public static final String GEOTIFF_DOT_EXT = '.' + GEOTIFF_EXT;

  // gdal_rasterize -burn <value> -ts 10 10 <measure_input_filename_geojson> <measure_output_filename_tiff> 
  public static void geoJson2geoTiff(File geoJson, File tifFile, double value) throws IOException {
    final String[] args = {"-burn", Double.toString(value), geoJson.getAbsolutePath(), tifFile.getAbsolutePath()};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false);
    try {
      exec.run(new File(geoJson.getParent()));
    } catch (final InterruptedException e) {
      e.printStackTrace();
      Thread.currentThread().interrupt();
    }
  }

}
