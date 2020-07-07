package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.logging.Logger;

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

  // gdal_rasterize -burn <value> -ts 10 10 -a_srs EPSG:28992 <measure_input_filename_geojson> <measure_output_filename_tiff> 
  // find out if -te 130.827 24.8857 140.357 26.8057 could work
  public static void geoJson2geoTiff(File geoJson, File tifFile, BigDecimal burnValue, Logger jobLogger) throws IOException {
    final String[] args = {"-burn", burnValue.toString(), geoJson.getAbsolutePath(), tifFile.getAbsolutePath()};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false);
    exec.setJobLogger(jobLogger);
    try {
      exec.run(new File(geoJson.getParent()));
    } catch (final InterruptedException e) {
      e.printStackTrace();
      Thread.currentThread().interrupt();
    }
  }

}
