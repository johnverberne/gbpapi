/*
 * ae_union_geometries_with_buffer
 * -------------------------------
 * Retourneert een samengestelde geometrie (union) aan de hand van de opgegeven geometrie(en) en radius.
 * Meerdere geometrieen kunnen opgegeven worden, dit kan doormiddel van een | als scheidingsteken.
 *
 * Voor de samengestelde geometry elke geometry kan een buffer worden opgegeven doormiddel van de radius.
 * Deze wordt voor elke geometry afzonderlijk bepaalt, waarna alle gebufferde geometrieen worden samengevoegd.
 */
CREATE OR REPLACE FUNCTION ae_union_geometries_with_buffer(geometries_as_text text, radius float)
	RETURNS geometry AS
$BODY$
DECLARE
	geometryParts text[];
	geometries geometry[];
	result geometry;
BEGIN
	geometryParts := regexp_split_to_array(geometries_as_text, E'\\|');
	FOR i IN array_lower(geometryParts, 1)..array_upper(geometryParts, 1) LOOP
		geometries[i] := ST_Buffer(ST_Force_2D(ST_GeomFromText(geometryParts[i], ae_get_srid())), radius);
	END LOOP;

	result := ST_Union(geometries);

	RETURN result;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_create_square
 * ----------------
 * Creeer een vierkant geometry op basis van een middelpunt en een rib-grootte.
 * Geinspireerd op http://dimensionaledge.com/intro-vector-tiling-map-reduce-postgis/
 */
CREATE OR REPLACE FUNCTION ae_create_square(centerpoint geometry, side double precision)
	RETURNS geometry AS 
$BODY$
SELECT ST_SetSRID(ST_MakePolygon(ST_MakeLine(
	ARRAY[
		ST_MakePoint(ST_X(centerpoint) - 0.5 * side, ST_Y(centerpoint) + 0.5 * side),
		ST_MakePoint(ST_X(centerpoint) + 0.5 * side, ST_Y(centerpoint) + 0.5 * side), 
		ST_MakePoint(ST_X(centerpoint) + 0.5 * side, ST_Y(centerpoint) - 0.5 * side), 
		ST_MakePoint(ST_X(centerpoint) - 0.5 * side, ST_Y(centerpoint) - 0.5 * side),
		ST_MakePoint(ST_X(centerpoint) - 0.5 * side, ST_Y(centerpoint) + 0.5 * side)
		]
	)), ST_SRID(centerpoint));
$BODY$
LANGUAGE sql IMMUTABLE STRICT;

/*
 * ae_create_regular_grid
 * ----------------------
 * Maak een standaard grid op basis van een geometrie, waarbij elk vak in het grid dezelfde grootte heeft (via side, de rib-grootte).
 * Geinspireerd op http://dimensionaledge.com/intro-vector-tiling-map-reduce-postgis/
 */
CREATE OR REPLACE FUNCTION ae_create_regular_grid(extent geometry, side double precision)
	RETURNS setof geometry AS
$BODY$
DECLARE
	x_min double precision;
	x_max double precision;
	y_min double precision;
	y_max double precision;
	x_value double precision;
	y_value double precision;
	x_count integer;
	y_count integer DEFAULT 1;
	srid integer;
	centerpoint geometry;
BEGIN
	srid := ST_SRID(extent);
	x_min := ST_XMin(extent);
	y_min := ST_YMin(extent);
	x_max := ST_XMax(extent);
	y_value := ST_YMax(extent);

	WHILE y_value  + 0.5 * side > y_min LOOP -- for each y value, reset x to x_min and subloop through the x values
		x_count := 1;
		x_value := x_min;
		WHILE x_value - 0.5 * side < x_max LOOP
			centerpoint := ST_SetSRID(ST_MakePoint(x_value, y_value), srid);
			x_count := x_count + 1; 
			x_value := x_value + side;
			RETURN QUERY SELECT ST_SnapToGrid(ae_create_square(centerpoint, side), 0.000001);
		END LOOP;  -- after exiting the subloop, increment the y count and y value
		y_count := y_count + 1;
		y_value := y_value - side;
	END LOOP;
	RETURN;
END
$BODY$
LANGUAGE plpgsql IMMUTABLE;
