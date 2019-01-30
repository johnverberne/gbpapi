/*
 * ae_line_to_point_sources
 * ------------------------
 * Functie voor het opdelen van een lijnbron in puntbronnen.
 * Splitst de lijn in even grote segmenten waarbij de segmentgrootte niet groter wordt dan de opgegeven maximale segmentgrootte.
 * @param geom De invoer line geometry, moet een LINESTRING zijn (een MULTILINESTRING wordt getracht te mergen).
 * @param maxsegmentsize Maximale segmentgrootte.
 */
CREATE OR REPLACE FUNCTION ae_line_to_point_sources(geom geometry, maxsegmentsize float)
	RETURNS SETOF geometry AS
$BODY$
DECLARE
	line geometry;
	linelength float;
	numsegments float;
	segmentsize float;
	fractionstep float;
	startfraction float;
	endfraction float;
	segment integer;
BEGIN
	line := geom;
	IF GeometryType(line) = 'MULTILINESTRING' THEN
		line := ST_LineMerge(line); -- Might not do anything if it can't merge.
	END IF;
	IF GeometryType(line) <> 'LINESTRING' THEN
		RAISE EXCEPTION 'Only LINESTRING geometry supported';
	END IF;

	linelength := ST_Length(line);
	numsegments := ceil(linelength / maxsegmentsize);
	segmentsize := linelength / numsegments;
	fractionstep := segmentsize / linelength;

	startfraction := 0.0;
	FOR segment IN 1..(numsegments::integer) LOOP
		IF segment = numsegments THEN
			endfraction := 1.0;
		ELSE
			endfraction := startfraction + fractionstep;
		END IF;
		RETURN NEXT ST_Line_Interpolate_Point(ST_Line_Substring(line, startfraction, endfraction), 0.5);
		startfraction := endfraction;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_polygon_to_point_sources
 * ---------------------------
 * Functie voor het opdelen van een vlakbron in puntbronnen.
 * Het midden van de opgegeven polygon wordt genomen, van hieruit wordt de polygon verrasterd.
 * Het midden van de polygon is ook het midden van het middelste raster-vierkant. De "resolutie" van
 * dit raster wordt opgegeven via 'squaresize'. Van elk raster-vierkant wordt het zwaartepunt van de intersectie
 * tussen het raster-vierkant en de polygon bepaald; de locatie van de puntbron. Er is een bijbehorend gewichtsfactor bij een bron,
 * dit is de mate van overlapping van het vierkant over de polygon. Een vierkant welke volledig in de polygon ligt heeft dus
 * een gewicht van 1.0.
 * @param geom De invoer polygon geometry, moet een POLYGON of MULTIPOLYGON zijn.
 * @param squaresize De grootte van de zijden van de vierkanten in het raster (resolutie).
 * @return Een collectie puntgeometrieen met bijbehorend gewichten.
 */
CREATE OR REPLACE FUNCTION ae_polygon_to_point_sources(geom geometry, squaresize float)
	RETURNS SETOF point_weight AS
$BODY$
DECLARE
	boundingbox box2d;
	center geometry;
	square geometry;
	intersection geometry;
	diameter float;
	start_x float;
	end_x float;
	start_y float;
	end_y float;
	x float;
	y float;
	pw point_weight;
BEGIN
	IF GeometryType(geom) <> 'POLYGON' AND GeometryType(geom) <> 'MULTIPOLYGON' THEN
		RAISE EXCEPTION 'Only (MULTI)POLYGON geometry supported';
	END IF;
	boundingbox := Box2D(geom);
	center := ST_Centroid(geom);
	diameter := squaresize * 0.5;

	start_x := ROUND(ST_X(center) - ROUND((ST_X(center) - ST_XMin(boundingbox)) / squaresize) * squaresize);
	end_x := ROUND(ST_X(center) + ROUND((ST_XMax(boundingbox) - ST_X(center)) / squaresize) * squaresize);
	start_y := ROUND(ST_Y(center) - ROUND((ST_Y(center) - ST_YMin(boundingbox)) / squaresize) * squaresize);
	end_y := ROUND(ST_Y(center) + ROUND((ST_YMax(boundingbox) - ST_Y(center)) / squaresize) * squaresize);

	y := start_y;
	WHILE y <= end_y LOOP
		x := start_x;
		WHILE x <= end_x LOOP
			square := ST_SetSRID(ST_MakeBox2D(
					ST_SetSRID(ST_MakePoint(x - diameter, y + diameter), ae_get_srid()),
					ST_SetSRID(ST_MakePoint(x + diameter, y - diameter), ae_get_srid())
				)::geometry, ae_get_srid());

			IF ST_Intersects(square, geom) THEN
				intersection := ST_Intersection(square, geom);
				pw.point := ST_Centroid(intersection);
				pw.weight := ST_Area(intersection) / (squaresize * squaresize);
				IF pw.weight > 0.0 THEN
					RETURN NEXT pw;
				END IF;
			END IF;

			x := x + squaresize;
		END LOOP;
		y := y + squaresize;
	END LOOP;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;
