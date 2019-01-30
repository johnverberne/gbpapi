/*
 * ae_shipping_inland_calculate_lineparts
 * --------------------------------------
 * Bepaal de lijndelen die voor binnenvaart gebruikt moeten worden voor een route.
 * De opgegeven bron wordt opgedeelt in stukken aan de hand van intersecties met sluizen.
 * Voor elk gedeelte wordt aangegeven welke sluisfactor erbij hoort.
 * @param line de opgegeven lijnbron
 * @return [Een lijngedeelte, De sluis factor]
 */
CREATE OR REPLACE FUNCTION ae_shipping_inland_calculate_lineparts(line geometry)
	RETURNS TABLE(geometry geometry, lock_factor posreal) AS
$BODY$
DECLARE
BEGIN
	-- First get the intersecting part(s) with locks (if any)
	-- Second, get all the parts that don't intersect with the locks.
	RETURN QUERY
		SELECT (ST_Dump(ST_Intersection(line, shipping_inland_locks.geometry))).geom AS linegeom,
						shipping_inland_locks.lock_factor
						FROM shipping_inland_locks
						WHERE ST_Intersects(line, shipping_inland_locks.geometry)
		UNION ALL
		SELECT (ST_Dump(Coalesce(ST_Difference(line, (SELECT ST_UNION(shipping_inland_locks.geometry) FROM shipping_inland_locks)), line))).geom AS linegeom,
						1::posreal;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;

/*
 * ae_shipping_inland_determine_direction
 * --------------------------------------
 * Bepaal of een route van een schip voor een vaarweg met de stroom meegaat of er juist tegenin.
 * @param flowing boolean of er stroming is op het punt van de route
 * @param route_point is het punt van de route om de vaarrichting te bepalen
 * @param next_route_point is het volgende punt op de route, benodigd om de vaarrichting te bepalen.
 * @param waterway is de geometrie van de vaargeul.
 * @return de vaarrichting van het schip (stroomafwaarts, stroomopwaarts, nvt)
 */
CREATE OR REPLACE FUNCTION ae_shipping_inland_determine_direction(flowing boolean, route_point geometry, next_route_point geometry, waterway geometry)
	RETURNS shipping_inland_ship_direction_type AS
$BODY$
		SELECT CASE WHEN NOT flowing THEN
			--if the waterway isn't flowing, the direction is irrelevant.
			'irrelevant'::shipping_inland_ship_direction_type

	--try to determine direction by projecting the route point and the next point on the route on the waterway.
	--ST_LineLocatePoint will return the fraction of the length from start to the closest point on the line to the supplied point compared to the total line length of the waterway.
	--if this fraction is lower for the route point than the fraction for the next point, the vessel is going with the flow.
	--if it's higher for the route point than the fraction for the next point, the vessel is going against the flow.
	--if it's the same, it means they are projected on the same point and we use another way to determine the direction.
		WHEN ST_LineLocatePoint(waterway, route_point) < ST_LineLocatePoint(waterway, next_route_point) THEN
			-- The vessel goes with the flow.
			'downstream'::shipping_inland_ship_direction_type
		WHEN ST_LineLocatePoint(waterway, route_point) < ST_LineLocatePoint(waterway, next_route_point) THEN
			 -- The vessel goes against the flow.
			'upstream'::shipping_inland_ship_direction_type

	-- If the projected points on the lines are the same, try the backup-plan:
	-- If the distance between the route_point of the linesegment and start_point of the waterway
	-- is lower than the distance between the next_route_point and start_point of the waterway
	-- then the vessel is going with the flow.
	-- Otherwise it is going against the flow.
		WHEN ST_Distance(route_point, ST_StartPoint(waterway)) <
				ST_Distance(next_route_point, ST_StartPoint(waterway)) THEN
			-- The vessel goes with the flow.
			'downstream'::shipping_inland_ship_direction_type
		ELSE
			 -- The vessel goes against the flow. Even if distances are the same, we have no other way to determine the direction, and it's better to pick worst-case.
			'upstream'::shipping_inland_ship_direction_type
		END;
$BODY$
LANGUAGE SQL IMMUTABLE RETURNS NULL ON NULL INPUT;

/*
 * ae_shipping_inland_determine_closest_waterway
 * ---------------------------------------------
 * Bepaal de dichtsbijzijnde (binnenvaart) vaarweg voor een punt geometry.
 *
 * Eerst worden de 20 dichtsbijzijnde vaarwegen geselecteerd aan de hand van boundingboxes van die vaarwegen.
 * Van die 20 wordt precieser de afstand bepaald tot de puntbron, waarna degene met de laagste afstand wordt teruggegeven.
 * @param point de opgegeven puntbron
 * @return De dichtsbijzijnde vaarweg.
 */
CREATE OR REPLACE FUNCTION ae_shipping_inland_determine_closest_waterway(point geometry)
	RETURNS TABLE(shipping_inland_waterway_id integer, shipping_inland_waterway_category_id integer, geometry geometry) AS
$BODY$
	WITH index_query AS (
		SELECT
			ST_Distance(geometry, point) AS distance,
			shipping_inland_waterway_id
		FROM shipping_inland_waterways
		ORDER BY geometry <#> point
		LIMIT 20
	)
	SELECT 
		shipping_inland_waterways.shipping_inland_waterway_id,
		shipping_inland_waterways.shipping_inland_waterway_category_id,
		shipping_inland_waterways.geometry

	FROM index_query
		INNER JOIN shipping_inland_waterways USING (shipping_inland_waterway_id)

	ORDER BY distance
	LIMIT 1;
$BODY$
LANGUAGE sql STABLE;

/*
 * ae_shipping_inland_calculate_points
 * -----------------------------------
 * Bepaal de punten die voor binnenvaart gebruikt moeten worden voor een route.
 * Voor elk punt is bepaald welke lengte deze voorstelt en welke sluis factor geldt.
 * @param line de opgegeven lijnbron
 * @return [Het punt van uitstoot, de lengte die de punt voorstelt, de sluis factor]
 */
CREATE OR REPLACE FUNCTION ae_shipping_inland_calculate_points(line geometry)
	RETURNS TABLE(point_geometry geometry, segment_length posreal, lock_factor posreal) AS
$BODY$
DECLARE
	max_segment_size double precision := ae_constant('CONVERT_INLAND_SHIPPING_LINE_TO_POINTS_SEGMENT_SIZE')::double precision;
	linepart_rec RECORD;
	actual_segment_size posreal;
BEGIN
	--linepart_rec consists of geometry (linestring), lock_factor.
	FOR linepart_rec IN SELECT * FROM ae_shipping_inland_calculate_lineparts(line) LOOP
		actual_segment_size := ST_Length(linepart_rec.geometry) / (SELECT count(*) FROM ae_line_to_point_sources(linepart_rec.geometry, max_segment_size));

		RETURN QUERY SELECT 
				ae_line_to_point_sources.geometry AS route_point,
				actual_segment_size,
				linepart_rec.lock_factor
				
				FROM ae_line_to_point_sources(linepart_rec.geometry, max_segment_size);
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

/*
 * ae_shipping_inland_calculate_points_with_waterway
 * -------------------------------------------------
 * Bepaal de punten die voor binnenvaart gebruikt moeten worden voor een route.
 * Voor elk punt is bepaald welke lengte deze voorstelt, welke sluis factor geldt, bij welke waterweg deze hoort,
 * wat voor type die waterweg is en of voor de waterweg rekening gehouden moet worden met stroming..
 * 
 * Deze functie is de oude manier van route bepalen. Hierdoor maakt deze expres geen gebruik van ae_shipping_inland_calculate_points: 
 * het toepassen daarvan kan emissies wijzigen (net een ander vaarweg voor een punt opleveren bijvoorbeeld).
 * 
 * @param line de opgegeven lijnbron
 * @return [Het punt van uitstoot, de lengte die de punt voorstelt, de sluis factor, het waterweg ID, het type waterweg, richting van het schip]
 */
CREATE OR REPLACE FUNCTION ae_shipping_inland_calculate_points_with_waterway(line geometry)
	RETURNS TABLE(point_geometry geometry, segment_length posreal, lock_factor posreal, shipping_inland_waterway_category_id integer, direction_type shipping_inland_ship_direction_type) AS
$BODY$
DECLARE
	max_segment_size double precision := ae_constant('CONVERT_INLAND_SHIPPING_LINE_TO_POINTS_SEGMENT_SIZE')::double precision;
	linepart_rec RECORD;
	actual_segment_size posreal;
BEGIN
	--linepart_rec consists of geometry (linestring), lock_factor.
	FOR linepart_rec IN SELECT * FROM ae_shipping_inland_calculate_lineparts(line) LOOP
		actual_segment_size := ST_Length(linepart_rec.geometry) / (SELECT count(*) FROM ae_line_to_point_sources(linepart_rec.geometry, max_segment_size));

		-- create a temporary table containing all routepoints and their next neighbour on the route.
		CREATE TEMPORARY TABLE tmp_shipping_emission_points (rnum integer, route_point geometry, next_route_point geometry, waterway_category_id integer, flowing boolean, geometry geometry) ON COMMIT DROP;
		INSERT INTO tmp_shipping_emission_points
		SELECT rnum, route_point, next_route_point, intermediate_query.shipping_inland_waterway_category_id, flowing, geometry FROM (
			SELECT rnum, route_point, next_route_point, (ae_shipping_inland_determine_closest_waterway(route_point)).*
					FROM (
						SELECT row_number() OVER () as rnum, ae_line_to_point_sources.geometry AS route_point
							FROM ae_line_to_point_sources(linepart_rec.geometry, max_segment_size)
					) AS route_points
					LEFT JOIN (
						SELECT (row_number() OVER ()) - 1 as rnum, ae_line_to_point_sources.geometry AS next_route_point
							FROM ae_line_to_point_sources(linepart_rec.geometry, max_segment_size)
					) AS next_route_points USING (rnum)
			) AS intermediate_query
				INNER JOIN shipping_inland_waterway_categories USING (shipping_inland_waterway_category_id);

		IF (SELECT count(*) FROM tmp_shipping_emission_points) = 1 THEN
			--not enough points to do the next_point thing, use the start-/end-point of the route for determining direction.
			RETURN QUERY
				SELECT route_point,
					actual_segment_size,
					linepart_rec.lock_factor,
					points.waterway_category_id,
					ae_shipping_inland_determine_direction(points.flowing, ST_StartPoint(line), ST_EndPoint(line), points.geometry) AS direction_type
				FROM tmp_shipping_emission_points AS points;
		ELSE
			--first return all points that have a next_point
			RETURN QUERY
				SELECT route_point,
					actual_segment_size,
					linepart_rec.lock_factor,
					points.waterway_category_id,
					ae_shipping_inland_determine_direction(points.flowing, route_point, next_route_point, points.geometry) AS direction_type
				FROM tmp_shipping_emission_points AS points 
					WHERE next_route_point IS NOT NULL;

			--return the last point: it doesn't have a next point, so use the previous point to determine the proper direction.
			--first return all points that have a next_point. Be sure to use the last_point.route_point for all but determining the direction.
			RETURN QUERY
				SELECT last_point.route_point,
					actual_segment_size,
					linepart_rec.lock_factor,
					last_point.waterway_category_id,
					ae_shipping_inland_determine_direction(last_point.flowing, previous_points.route_point, previous_points.next_route_point, last_point.geometry) AS direction_type
				FROM tmp_shipping_emission_points AS last_point
					INNER JOIN tmp_shipping_emission_points AS previous_points ON ((last_point.rnum - 1) = previous_points.rnum)
					WHERE last_point.next_route_point IS NULL;

		END IF;
		DROP TABLE tmp_shipping_emission_points;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

/*
 * ae_shipping_inland_suggest_waterway
 * -----------------------------------
 * Maak een inschatting welke (binnenvaart) vaarweg type geldt voor een lijn geometry.
 * Dit vaarweg type kan gebruikt worden als suggestie om de gebruiker op de goede weg te helpen bij het aanmaken van een vaar route voor binnenvaart.
 * 
 * @return De vaarweg die waarschijnlijk het beste past bij de opgegeven lijn.
 */
CREATE OR REPLACE FUNCTION ae_shipping_inland_suggest_waterway(line geometry)
	RETURNS TABLE(shipping_inland_waterway_category_id integer, code text, direction_type shipping_inland_ship_direction_type) AS
$BODY$
	SELECT
		shipping_inland_waterway_category_id,
		code,
		direction_type

		FROM ae_shipping_inland_calculate_points_with_waterway(line)
			INNER JOIN shipping_inland_waterway_categories USING (shipping_inland_waterway_category_id)

		GROUP BY shipping_inland_waterway_category_id, code, direction_type

		ORDER BY COUNT(shipping_inland_waterway_category_id) DESC
$BODY$
LANGUAGE sql STABLE;
