/*
 * ae_maritime_mooring_inland_shipping_route
 * -----------------------------------------
 * Functie voor het bepalen van de route die een schip vaart binnen de haven,
 * uitgaande van een transfer route naar de havenmond.
 * Deze route wordt direct omgezet naar punten die gebruikt kunnen worden voor emissiebronnen.
 * @param v_category_id Het ID van de scheepscategorie waarvoor de route bepaalt moet worden (inclusief bepalen van het manoeuvreer gedeelte).
 * @param transfer_route De route die het schip vaart om bij de havenmond te komen.
 * @param v_max_segment_size De maximale lengte die een punt mag representeren.
 * @return De verzameling punten die de route moet voorstellen. Elk punt krijgt mee welke afstand deze in de route representeert.
 * en of het een stukje van de route representeert waar gemanouvreerd wordt voor de meegegeven scheepscategorie.
 */
CREATE OR REPLACE FUNCTION ae_maritime_mooring_inland_shipping_route(v_category_id int, transfer_route geometry, v_max_segment_size double precision)
	RETURNS TABLE(point_geometry geometry, length posreal, maneuver_factor posreal) AS
$BODY$
DECLARE
	normal_part geometry;
	maneuver_part geometry;
	maneuver_fraction posreal;
	length_per_normal_point posreal;
	length_per_maneuver_point posreal;

BEGIN
	SELECT CASE WHEN category.maneuver_factor = 1 THEN 0 ELSE category.maneuver_length / ST_Length(transfer_route) END INTO maneuver_fraction
			FROM shipping_maritime_category_maneuver_properties AS category
			WHERE category.shipping_maritime_category_id = v_category_id;
	
	IF maneuver_fraction = 0 THEN
			SELECT transfer_route INTO normal_part;
	ELSEIF maneuver_fraction > 1 THEN
			SELECT transfer_route INTO maneuver_part;
	ELSE
			SELECT ST_Line_Substring(transfer_route, 0, maneuver_fraction) INTO maneuver_part;
			SELECT ST_Line_Substring(transfer_route, maneuver_fraction, 1) INTO normal_part;
	END IF;

	IF maneuver_part IS NOT NULL THEN
			CREATE TEMPORARY TABLE tmp_shipping_emission_points_maneuver (point geometry) ON COMMIT DROP;
			INSERT INTO tmp_shipping_emission_points_maneuver SELECT ae_line_to_point_sources(maneuver_part, v_max_segment_size);
			-- length per point = total length / # points
			SELECT ST_Length(maneuver_part) / COUNT(*) INTO length_per_maneuver_point FROM tmp_shipping_emission_points_maneuver;
			RETURN QUERY SELECT
							points.*,
							length_per_maneuver_point,
							GREATEST(category_properties.maneuver_factor, COALESCE(maneuver_area.maneuver_factor, 0::posreal))
					FROM tmp_shipping_emission_points_maneuver AS points
							CROSS JOIN shipping_maritime_categories AS category
							INNER JOIN shipping_maritime_category_maneuver_properties AS category_properties USING (shipping_maritime_category_id)
							LEFT JOIN shipping_maritime_maneuver_areas AS maneuver_area ON ST_Intersects(points.point, maneuver_area.geometry)
					WHERE category.shipping_maritime_category_id = v_category_id;

			DROP TABLE tmp_shipping_emission_points_maneuver;
	END IF;
	
	IF normal_part IS NOT NULL THEN
			CREATE TEMPORARY TABLE tmp_shipping_emission_points_normal (point geometry) ON COMMIT DROP;
			INSERT INTO tmp_shipping_emission_points_normal SELECT ae_line_to_point_sources(normal_part, v_max_segment_size);
			-- length per point = total length / # points
			SELECT ST_Length(normal_part) / COUNT(*) INTO length_per_normal_point FROM tmp_shipping_emission_points_normal;

			RETURN QUERY SELECT points.*, length_per_normal_point, COALESCE(maneuver_area.maneuver_factor, 1::posreal)
					FROM tmp_shipping_emission_points_normal AS points
							LEFT JOIN shipping_maritime_maneuver_areas AS maneuver_area ON ST_Intersects(points.point, maneuver_area.geometry);

			DROP TABLE tmp_shipping_emission_points_normal;
	END IF;
	
	RETURN;
	END;
$BODY$
LANGUAGE plpgsql VOLATILE;

/*
 * ae_standalone_maritime_shipping_route
 * -------------------------------------
 * Functie voor het bepalen van de punten voor een route voor zeescheepvaart, zowel binnenvaart als op zee.
 * @param v_route De route die het schip vaart
 * @param v_max_segment_size De maximale lengte die een punt mag representeren.
 * @return De verzameling punten die de route moet voorstellen. Elk punt krijgt mee welke afstand deze in de route representeert.
 * en of het een stukje van de route representeert waar gemanouvreerd wordt voor de meegegeven scheepscategorie (zo ja, welke factor).
 */
CREATE OR REPLACE FUNCTION ae_standalone_maritime_shipping_route(v_route geometry, v_max_segment_size double precision)
	RETURNS TABLE(point_geometry geometry, length posreal, maneuver_factor posreal) AS
$BODY$
DECLARE
	length_per_point posreal;

BEGIN
	CREATE TEMPORARY TABLE tmp_shipping_emission_points (point geometry) ON COMMIT DROP;
	INSERT INTO tmp_shipping_emission_points SELECT ae_line_to_point_sources(v_route, v_max_segment_size);
	-- length per point = total length / # points
	SELECT ST_Length(v_route) / COUNT(*) INTO length_per_point FROM tmp_shipping_emission_points;

	RETURN QUERY SELECT points.*, length_per_point, COALESCE(maneuver_area.maneuver_factor, 1::posreal)
					FROM tmp_shipping_emission_points AS points
							LEFT JOIN shipping_maritime_maneuver_areas AS maneuver_area ON ST_Intersects(points.point, maneuver_area.geometry);

	DROP TABLE tmp_shipping_emission_points;
	RETURN;
	END;
$BODY$
LANGUAGE plpgsql VOLATILE;
