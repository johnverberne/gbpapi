package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;
import nl.rivm.nca.runner.OSUtils;

/**
 * Convert a geotiff image to a pcraster file.
 */
public class Xyz2Geotiff {

  private static final String GDAL_TRANSLATE = "gdal_translate";
  private static final String GDAL_TRANSLATE_WIN = "d:/opt/nkmodel/nca_gdal_translate.bat";
  private static final String RUNNER = OSUtils.isWindows() ? GDAL_TRANSLATE_WIN : GDAL_TRANSLATE;

  public static final String GEOTIFF_EXT = "tiff";
  public static final String GEOTIFF_DOT_EXT = '.' + GEOTIFF_EXT;

  // gdal_translate -a_srs EPSG:28992 bomen.xyz bomen_xyz.tif
  public static void xyz2geoTiff(File xyzFile, File tifFile) throws IOException {
    final String[] args = {"-a_srs", "EPSG:28992", xyzFile.getAbsolutePath(), tifFile.getAbsolutePath()};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false);
    try {
      exec.run(new File(xyzFile.getParent()));
    } catch (final InterruptedException e) {
      e.printStackTrace();
      Thread.currentThread().interrupt();
    }
  }

  public static void xyz2gmap(File xyzFile, File mapFile) throws IOException {
    final String[] args = {xyzFile.getAbsolutePath(), mapFile.getAbsolutePath()};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false);

    try {
      exec.run(new File(xyzFile.getParent()));
    } catch (final InterruptedException e) {
      e.printStackTrace();
      Thread.currentThread().interrupt();
    }
  }

}
