/*
 * ae_determine_hexagon_intersections
 * ----------------------------------
 * Bepaald de intersecties van onze hexagonen (op zoomlevel 1) met een specifieke geometrie.
 * Gaat uit van de hexagonen in de hexagons tabel, niet alle mogelijke hexagonen.
 * Geinspireerd op http://dimensionaledge.com/intro-vector-tiling-map-reduce-postgis/
 * @param v_geometry de geometrie om intersecties te laten bepalen.
 * @param v_gridsize de grootte van de gebruikte grids in kilometer.
 */
CREATE OR REPLACE FUNCTION setup.ae_determine_hexagon_intersections(v_geometry geometry(MultiPolygon), v_gridsize integer = 1)
	RETURNS TABLE(receptor_id integer, surface double precision, geometry geometry) AS
$BODY$
	WITH
	split_geometry AS (
		SELECT (ST_Dump(v_geometry)).geom AS geometry
	),
	regular_grid AS (
		SELECT ae_create_regular_grid(ST_Envelope(v_geometry), v_gridsize * 1000)::geometry(Polygon) AS geometry
	),
	intersected AS (
		SELECT
			CASE 
				WHEN ST_Within(regular_grid.geometry, split_geometry.geometry) 
				THEN regular_grid.geometry
				ELSE ST_Intersection(regular_grid.geometry, split_geometry.geometry) END AS geometry
			FROM regular_grid
				INNER JOIN split_geometry ON ST_Intersects(regular_grid.geometry, split_geometry.geometry) AND regular_grid.geometry && split_geometry.geometry
	),
	vector_tiles AS (
		SELECT (ST_Dump(intersected.geometry)).geom AS geometry	FROM intersected WHERE intersected.geometry IS NOT NULL
	),
	intersected_areas AS (
		SELECT
			hexagons.receptor_id,
			ST_Intersection(vector_tiles.geometry, hexagons.geometry) AS geometry

			FROM vector_tiles
				INNER JOIN hexagons ON ST_Intersects(vector_tiles.geometry, hexagons.geometry)

			WHERE zoom_level = 1
	),
	unioned_intersected_areas AS (
		SELECT
			intersected_areas.receptor_id,
			ST_Union(intersected_areas.geometry) AS geometry

			FROM intersected_areas
			GROUP BY intersected_areas.receptor_id
	)
	SELECT
		unioned_intersected_areas.receptor_id,
		ST_Area(unioned_intersected_areas.geometry) AS surface,
		unioned_intersected_areas.geometry

		FROM unioned_intersected_areas

		WHERE ST_Area(unioned_intersected_areas.geometry) > 0;
$BODY$
LANGUAGE sql VOLATILE;
