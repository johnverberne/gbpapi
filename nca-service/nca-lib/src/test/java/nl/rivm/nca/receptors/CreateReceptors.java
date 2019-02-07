package nl.rivm.nca.receptors;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class CreateReceptors {

	static final BigInteger ONE = BigInteger.ONE;

	public static void main(String[] args) {

		String fileIn = "d:/nkmodel/receptors100x100.csv";
		String fileOut = "d:/nkmodel/grids_polygon.txt";
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";

		List<GridSource> list = new ArrayList<GridSource>();
		boolean fistSkip = true;
		int count = 10;
		try {
			br = new BufferedReader(new FileReader(fileIn));
			PrintWriter writer = new PrintWriter(fileOut, "UTF-8");
			while ((line = br.readLine()) != null) {
				String[] row = line.split(cvsSplitBy);
				if (!fistSkip) {
					// use comma as separator
					// System.out.println(row[0] + row[1] + row[2] + row[4]);
					GridSource source = new GridSource();
					source.setX(Integer.parseInt(row[0]));
					source.setY(Integer.parseInt(row[1]));
					source.setXB(Integer.parseInt(row[2]));
					source.setYB(Integer.parseInt(row[3]));
					source.setSrid(Integer.parseInt(row[4]));
					list.add(source);

					// build a poly
					String poly = "POLYGON((" + source.getX() + " " + source.getY() + "," + source.getXB() + " "
							+ source.getY() + "," + source.getXB() + " " + source.getYB() + "," + source.getX() + " "
							+ source.getYB() + "," + source.getX() + " " + source.getY() + "))";
					// System.out.println(row[4] + "\t" + poly);
					writer.println(row[4] + "\t" + poly);

					if (count > 250) {
						// break;
					}

				}
				fistSkip = false;
				count++;
			}

			System.out.println(list.size());
			writer.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}

}

/*
 * 
 * drop table grids;
 * 
 * delete from grids;
 * 
 * 
 * CREATE TABLE grids ( grid_id integer NOT NULL, geometry geometry(Polygon),
 * CONSTRAINT grids_pkey PRIMARY KEY (grid_id) );
 * 
 * select * from grids; BEGIN; SELECT setup.ae_load_table('grids',
 * 'd:/nkmodel/grids.geo_20190207.txt', false); COMMIT;
 * 
 * CREATE OR REPLACE VIEW wms_grids_view AS SELECT
 *
 * FROM grids ;
 * 
 * 
 * CREATE TABLE gridstemp ( grid_id integer NOT NULL, geo text, CONSTRAINT
 * gridstemp_pkey PRIMARY KEY (grid_id)
 * 
 * );
 * 
 * 
 * 
 * BEGIN; SELECT setup.ae_load_table('gridstemp',
 * 'd:/nkmodel/grids_polygon.txt', false); COMMIT;
 * 
 * 
 * delete from gridstemp
 * 
 * select * from gridstemp select *, ST_GeomFromText(geo) from gridstemp where
 * grid_id = 202
 * 
 * 
 * BEGIN; COPY gridstemp TO 'd:/nkmodel/grids_polygon.txt' DELIMITER E'\t' CSV;
 * COMMIT;
 * 
 * 
 * 
 * CREATE OR REPLACE VIEW gridstemp_view AS SELECT grid_id, ST_GeomFromText(geo,
 * 28992) AS result
 * 
 * FROM gridstemp ;
 * 
 * 
 * select * from gridstemp_view BEGIN; COPY (SELECT * FROM gridstemp_view) TO
 * 'd:/nkmodel/grids.geo_20190207.txt' DELIMITER E'\t' CSV; COMMIT;
 * 
 */
