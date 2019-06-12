package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

/**
 * Convert a geotiff image to a pcraster file.
 */
public class Geotiff2PcRaster {

	private static final String GDAL_TRANSLATE = "gdal_translate";

	// The source raster is a raster with land cover classes. This corresponds
	// with the PCRaster nominal values scale. That information can be passed
	// to gdal_translate as a metadata item.
	// gdal_translate -of PCRaster -ot Int32 \
	// -mo "PCRASTER_VALUESCALE=VS_NOMINAL" LCEU_ini.tif LCEU_ini.map
	public static void geoTiff2PcRaster(File geotiffFile, File mapFile) throws IOException {
		final String[] args = { "-of", "PCRaster", "-ot", "Float32" /* "Int32" */, "-mo",
				"PCRASTER_VALUESCALE=VS_NOMINAL", "-b", "1", geotiffFile.getAbsolutePath(), mapFile.getAbsolutePath() };
		final ExecParameters execParams = new ExecParameters(GDAL_TRANSLATE, args);
		final Exec exec = new Exec(execParams, "");
		try {
			exec.run(new File(geotiffFile.getParent()));
		} catch (final InterruptedException e) {
			e.printStackTrace();
			Thread.currentThread().interrupt();
		}
	}

	public static void pcRaster2GeoTiff(File mapFile, File geotiffFile, java.util.logging.Logger jobLogger) throws IOException {
		final String[] args = { "-a_srs", "EPSG:28992", mapFile.getAbsolutePath(), geotiffFile.getAbsolutePath() };
		final ExecParameters execParams = new ExecParameters(GDAL_TRANSLATE, args);
		final Exec exec = new Exec(execParams, "");
		exec.setJobLogger(jobLogger);
		try {
			exec.run(new File(geotiffFile.getParent()));
		} catch (final InterruptedException e) {
			e.printStackTrace();
			Thread.currentThread().interrupt();
		}
	}
}
