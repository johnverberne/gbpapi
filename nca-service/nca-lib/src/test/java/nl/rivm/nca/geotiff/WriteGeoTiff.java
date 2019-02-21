package nl.rivm.nca.geotiff;

import java.awt.geom.Rectangle2D;
import java.awt.image.ColorModel;
import java.awt.image.ComponentSampleModel;
import java.awt.image.DataBuffer;
import java.awt.image.SampleModel;
import java.io.File;
import java.io.IOException;

import javax.media.jai.TiledImage;

import org.geotools.coverage.CoverageFactoryFinder;
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.coverage.grid.GridCoverageFactory;
import org.geotools.coverage.grid.io.AbstractGridCoverage2DReader;
import org.geotools.coverage.grid.io.AbstractGridFormat;
import org.geotools.coverage.grid.io.GridFormatFinder;
import org.geotools.coverage.grid.io.imageio.GeoToolsWriteParams;
import org.geotools.gce.geotiff.GeoTiffFormat;
import org.geotools.gce.geotiff.GeoTiffWriter;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.opengis.geometry.MismatchedDimensionException;
import org.opengis.parameter.GeneralParameterValue;
import org.opengis.parameter.ParameterValue;
import org.opengis.referencing.FactoryException;

public class WriteGeoTiff {
	
	//final static CoordinateReferenceSystem CRS = DefaultEngineeringCRS.GENERIC_2D;
	
	public WriteGeoTiff() {	
	}
	
	public static void main(String[] args) throws IOException {
		System.out.println("uitvoeren gestart");

		// read
		AbstractGridFormat format = GridFormatFinder.findFormat("d:/nkmodel/input/bomenkaart.tiff");
		AbstractGridCoverage2DReader reader = format.getReader("d:/nkmodel/input/bomenkaart.tiff");
		GridCoverage2D gc = reader.read(new GeneralParameterValue[0]);

		System.out.println("reading done");
		
		System.out.println(gc.toString());
		
		System.out.println("start write");
		
		// write
		GeoTiffWriter writer = new GeoTiffWriter(new File("d:/nkmodel/output/bomenkaart.tiff"));
	    ParameterValue<GeoToolsWriteParams> value = GeoTiffFormat.GEOTOOLS_WRITE_PARAMS.createValue();
		writer.write(gc, new GeneralParameterValue[] { value });
		writer.dispose();
		
		System.out.println("write done");
				
		WriteGeoTiff tiffWriter = new WriteGeoTiff();
		tiffWriter.writeGeotiffExample(new File("d:/nkmodel/output/walls.tiff"));
		
		// read
		AbstractGridFormat format2 = GridFormatFinder.findFormat("d:/nkmodel/output/walls.tiff");
		AbstractGridCoverage2DReader reader2 = format.getReader("d:/nkmodel/output/walls.tiff");
		GridCoverage2D gc2 = reader2.read(new GeneralParameterValue[0]);

		System.out.println("reading of wall done");
		
		System.out.println(gc2.toString());
		
	}

	public void writeGeotiffExample(File file) throws IOException {
		int[][] data = new int[1000][1000];

		// create some walls (assume data is in row-major order
		int y = 200;
		for (int x = 200; x < 800; x++) {
			data[y][x] = 1;
		}

		y = 500;
		for (int x = 200; x < 600; x++) {
			data[y][x] = 1;
		}

		y = 800;
		for (int x = 400; x < 800; x++) {
			data[y][x] = 1;
		}

		
		GridCoverage2D cov = makeBinaryCoverage(data);
		GeoTiffWriter writer = new GeoTiffWriter(file);
		writer.write(cov, null);
		
	}

	/**
	 * Create a new coverage from the given data array. All non-zero array
	 * values are written to the coverage as 1; zero values as 0.
	 */
	public GridCoverage2D makeBinaryCoverage(int[][] data) {
		GridCoverageFactory gcf = CoverageFactoryFinder.getGridCoverageFactory(null);

		// Assume data array is in row-major order
		final int dataW = data[0].length;
		final int dataH = data.length;
		final int imgTileW = 128;

		// image tile sample model
		SampleModel sm = new ComponentSampleModel(DataBuffer.TYPE_BYTE, imgTileW, imgTileW, 1, imgTileW, new int[] { 0 });

		ColorModel cm = TiledImage.createColorModel(sm);

		TiledImage img = new TiledImage(0, 0, dataW, dataH, 0, 0, sm, cm);

		for (int y = 0; y < dataH; y++) {
			for (int x = 0; x < dataW; x++) {
				if (data[y][x] != 0) {
					img.setSample(x, y, 0, 1);
				}
			}
		}


		// Set world coords as 1:1 with image coords for this example
		ReferencedEnvelope env = null;
		//ReferencedEnvelope env = new ReferencedEnvelope(0, 100, 0, 100, CRS.decode("EPSG:28992"));
		try {
			env = new ReferencedEnvelope(new Rectangle2D.Double(0, 0, dataW, dataH), CRS.decode("EPSG:28992"));
		} catch (MismatchedDimensionException | FactoryException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    

		return gcf.create("coverage", img, env);
	}
	

	
}
