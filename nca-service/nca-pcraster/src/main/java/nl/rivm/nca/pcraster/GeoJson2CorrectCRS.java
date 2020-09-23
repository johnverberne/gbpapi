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

  static String RUNNER = RunnerEnum.OGR2OGR.getRunner();
  /*
   * ogr2ogr -s_srs EPSG:4326 -t_srs EPSG:28992 -f GEOJSON reprojectedfile.geojson originalfile.geojson
   */
  public static void geoJsonConvert(File geoJsonInput, File geoJsonOutput, java.util.logging.Logger jobLogger, String path) throws IOException {
    final String[] args = {"-skipfailures", "-s_srs", "EPSG:4326", "-t_srs", "EPSG:28992", "-f", "GEOJSON", geoJsonOutput.getAbsolutePath(),
        geoJsonInput.getAbsolutePath()};
    //RUNNER = RunnerEnum.OGR2OGR.getRunner(path);
    File f = new File(RUNNER);
    f.setExecutable(true);
    jobLogger.info(f.getAbsolutePath() + " " + f.getCanonicalPath() + f );
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false);
    exec.setJobLogger(jobLogger);
    try {
      //exec.run(new File(geoJsonInput.getParent()));
      exec.run(null);
    } catch (final InterruptedException e) {
      e.printStackTrace();
      Thread.currentThread().interrupt();
    }
  }
}
