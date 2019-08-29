package nl.rivm.nca.pcraster;

import java.awt.Rectangle;
import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;

import org.geotools.geometry.Envelope2D;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

/**
 * Cuts the project map out of the global map.
 */
public class CookieCut {

  private static final String RUNNER = RunnerEnum.GDAL_TRANSLATE.getRunner();

  public CookieCut(String ncmPath) {
  }

  //[--indices] <source> <x_min> <y_max> <x_max> <y_min> <destination>
  //gdal_translate -q -of {format} -{method} {x_min} {y_max} {x_max} {y_min} {source} {destination}".format(
  //      method="projwin" if not use_indices else "srcwin",

  public void run(File source, File destination, Envelope2D extend, Logger jobLogger) throws IOException, InterruptedException {
    final String method = "-projwin"; // bounding box in actual coordinates given
    final Rectangle b = extend.getBounds();
    final String[] args = {"-q", "-of", "PCRaster", method,
        s(b.getMinX()), s(b.getMaxY()), s(b.getMaxX()), s(b.getMinY()),
        source.getAbsolutePath(), destination.getAbsolutePath()};
    final ExecParameters execParams = new ExecParameters(RUNNER, args);
    final Exec exec = new Exec(execParams, "", false);
    exec.setJobLogger(jobLogger);
    exec.run(new File(destination.getParent()));
  }

  private String s(double d) {
    return String.valueOf(d);
  }
}
