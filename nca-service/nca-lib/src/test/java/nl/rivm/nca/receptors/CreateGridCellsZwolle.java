package nl.rivm.nca.receptors;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class CreateGridCellsZwolle {

	static final BigInteger ONE = BigInteger.ONE;

	public static void main(String[] args) {

		String fileIn = "d:/nkmodel/GridPolyUtrecht/receptors.csv";
		String fileOut = "d:/nkmodel/GridPolyZwolle/grids_polygon.txt";
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";

		List<GridSource> list = new ArrayList<GridSource>();
		boolean firstRow = true;
		int count = 0;
		try {
			br = new BufferedReader(new FileReader(fileIn));
			PrintWriter writer = new PrintWriter(fileOut, "UTF-8");
			while ((line = br.readLine()) != null) {
				String[] row = line.split(cvsSplitBy);
				if (!firstRow) {
					// System.out.println(row[0] + row[1] + row[2] + row[4]);
					GridSource source = new GridSource();
					source.setX(Integer.parseInt(row[0]) + 66380);
					source.setY(Integer.parseInt(row[1]) + 47610);
					source.setXB(Integer.parseInt(row[2]) + 66380);
					source.setYB(Integer.parseInt(row[3]) + 47610);
					source.setSrid(Integer.parseInt(row[4]) + 756800);
					list.add(source);
					
					// build a poly
					String poly = "POLYGON((" 
					        + source.getX() + " " + source.getY() + "," + source.getXB() + " "
							+ source.getY() + "," + source.getXB() + " " + source.getYB() + "," + source.getX() + " "
							+ source.getYB() + "," + source.getX() + " " + source.getY() + "))";
					System.out.println(String.format("%d", source.getSrid()) + "\t" + poly);
					writer.println(String.format("%d", source.getSrid())+ "\t" + poly); //tab column seperator
//					if (count > 10) {
//						break;
//					}

				}
				firstRow = false;
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
 *  Use Qgis to export the dbf to csv export with databasemanager
 *  

CREATE TABLE gridstemp (grid_id integer NOT NULL, geo text, CONSTRAINT gridstemp_pkey PRIMARY KEY (grid_id));
delete from gridstemp;
select * from gridstemp limit 100;
BEGIN; SELECT setup.ae_load_table('gridstemp', 'd:/nkmodel/GridPolyZwolle/grids_polygon.txt', false); COMMIT;
CREATE OR REPLACE VIEW gridstemp_view AS SELECT grid_id, ST_GeomFromText(geo, 28992) AS result FROM gridstemp;
select * from gridstemp_view limit 2
Select * from gridstemp_view BEGIN; COPY (SELECT * FROM gridstemp_view) TO 'd:/nkmodel/GridPolyZwolle/grids.geo_20190327.txt' DELIMITER E'\t' CSV; COMMIT;
BEGIN; SELECT setup.ae_load_table('grids', 'd:/nkmodel/GridPolyZwolle/grids.geo_20190327.txt'); COMMIT;
*/