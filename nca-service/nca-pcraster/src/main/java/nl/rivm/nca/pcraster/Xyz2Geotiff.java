package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.runner.Exec;
import nl.rivm.nca.runner.ExecParameters;

/**
 * Convert a geotiff image to a pcraster file.
 */
public class Xyz2Geotiff {

	private static final Logger LOGGER = LoggerFactory.getLogger(BaseController.class);

	private static final String GDAL_TRANSLATE = "gdal_translate";
	private static final String COL2MAP = "col2map";
	private static final String PCRCALC = "pcrcalc";
	public static final String GEOTIFF_EXT = "tiff";
	public static final String GEOTIFF_DOT_EXT = '.' + GEOTIFF_EXT;
	private static final String XYZ_EXT = "XYZ";
	private static final String XYZ_DOT_EXT = "." + XYZ_EXT;

	// gdal_translate -a_srs EPSG:28992 bomen.xyz bomen_xyz.tif
	public static void xyz2geoTiff(File xyzFile, File tifFile) throws IOException {
		final String[] args = { "-a_srs", "EPSG:28992", xyzFile.getAbsolutePath(), tifFile.getAbsolutePath() };
		final ExecParameters execParams = new ExecParameters(GDAL_TRANSLATE, args);
		final Exec exec = new Exec(execParams, "");
		try {
			exec.run(new File(xyzFile.getParent()));
		} catch (final InterruptedException e) {
			e.printStackTrace();
			Thread.currentThread().interrupt();
		}
	}

	/*
	 * col2map -S bomenkaart.xyz bomenkaart_edit.map --clone bomenkaart.map
	 * pcrcalc bomenkaart.map=cover^(bomenkaart_edit.map,bomenkaart.map^)
	 */
	public static void xyz2gmap(File xyzFile, File mapFile) throws IOException {
		final String[] args = { "-S", xyzFile.getAbsolutePath(), mapFile.getAbsolutePath() , "-clone" , mapFile.getAbsolutePath()};
		final ExecParameters execParams = new ExecParameters(GDAL_TRANSLATE, args);
		final Exec exec = new Exec(execParams, "");
		
		try {
			exec.run(new File(xyzFile.getParent()));
		} catch (final InterruptedException e) {
			e.printStackTrace();
			Thread.currentThread().interrupt();
		}
	}

}
