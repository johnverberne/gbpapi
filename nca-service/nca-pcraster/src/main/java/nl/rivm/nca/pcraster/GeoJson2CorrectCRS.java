package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

/**
 * Convert a geotiff from one projection to other projection
 * from EPSG:4326 to EPSG:28992
 * Input and output should be the same
 */
public class GeoJson2CorrectCRS {

  private static final String RUNNER = RunnerEnum.OGR2OGR.getRunner();
  /*
   * ogr2ogr -s_srs EPSG:4326 -t_srs EPSG:28992 -f GEOJSON reprojectedfile.geojson originalfile.geojson
   */
  public static void geoJsonConvert(File geoJsonInput, File geoJsonOutput, java.util.logging.Logger jobLogger) throws IOException {
    final String[] args = {"-s_srs", "EPSG:4326", "-t_srs", "EPSG:28992", "-f", "GEOJSON", geoJsonOutput.getAbsolutePath(),
        geoJsonInput.getAbsolutePath()};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false);
    exec.setJobLogger(jobLogger);
    try {
      exec.run(new File(geoJsonInput.getParent()));
    } catch (final InterruptedException e) {
      e.printStackTrace();
      Thread.currentThread().interrupt();
    }
  }
}
