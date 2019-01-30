/*
 * ae_delete_calculation
 * ---------------------
 * Gebruik deze functie om een berekening + resultaten te verwijderen.
 */
CREATE OR REPLACE FUNCTION ae_delete_calculation(v_calculation_id integer)
	RETURNS void AS
$BODY$
DECLARE
	only_calculation_in_set boolean;
	v_calculation_point_set_id integer;
BEGIN
	v_calculation_point_set_id := calculation_point_set_id FROM calculations WHERE calculation_id = v_calculation_id;

	only_calculation_in_set := COUNT(*) = 1 FROM calculations WHERE calculation_point_set_id = v_calculation_point_set_id;

	DELETE FROM development_space_demands WHERE proposed_calculation_id = v_calculation_id;
	DELETE FROM development_space_demands WHERE current_calculation_id <> 0 AND current_calculation_id = v_calculation_id;

	DELETE FROM calculation_point_results WHERE calculation_result_set_id IN (SELECT calculation_result_set_id FROM calculation_result_sets WHERE calculation_id = v_calculation_id);
	DELETE FROM calculation_results WHERE calculation_result_set_id IN (SELECT calculation_result_set_id FROM calculation_result_sets WHERE calculation_id = v_calculation_id);
	DELETE FROM calculation_result_sets WHERE calculation_id = v_calculation_id;
	DELETE FROM calculation_batch_options WHERE calculation_id = v_calculation_id;
	DELETE FROM calculations WHERE calculation_id = v_calculation_id;

	IF only_calculation_in_set THEN
		DELETE FROM calculation_points WHERE calculation_point_set_id = v_calculation_point_set_id;
		DELETE FROM calculation_point_sets WHERE calculation_point_set_id = v_calculation_point_set_id;
	END IF;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_delete_low_calculation_results
 * ---------------------------------
 * Verwijder alle resultaten van een berekening die kleiner dan of gelijk aan 0 of de drempelwaarde zijn.
 *
 * Hierbij wordt alleen gekeken naar de 'deposition' resultaten in de 'total' resultset. De receptoren worden vervolgens wel uit alle
 * resultsets verwijderd (dus ook uit de 'sector' resultsets en andere resulttypes zoals 'concentration').
 *
 * De beide situaties van een berekening worden tegelijkertijd beschouwd; het resultaat wordt alleen (uit beide situaties) verwijderd als
 * beide situaties onder de drempel liggen.
 *
 * @param v_delete_results_under_threshold Alleen als deze TRUE is worden alle resultaten kleiner dan of gelijk aan de drempelwaarde verwijderd. Bij
 *   FALSE worden alleen resultaten kleiner dan of gelijk aan 0 verwijderd.
 */
CREATE OR REPLACE FUNCTION ae_delete_low_calculation_results(v_proposed_calculation_id integer, v_current_calculation_id integer, v_delete_results_under_threshold boolean)
	RETURNS void AS
$BODY$
DECLARE
	v_threshold posreal = (CASE WHEN v_delete_results_under_threshold THEN ae_constant('PRONOUNCEMENT_THRESHOLD_VALUE')::posreal ELSE 0 END);
BEGIN
	DELETE FROM calculation_results

	USING calculation_result_sets

	WHERE
		calculation_results.calculation_result_set_id = calculation_result_sets.calculation_result_set_id
		AND calculation_id IN (v_proposed_calculation_id, v_current_calculation_id)
		AND receptor_id IN
			(SELECT
				DISTINCT receptor_id

				FROM
					(SELECT *
						FROM calculation_summed_deposition_results_view
						WHERE calculation_id = v_proposed_calculation_id
					) AS proposed

					LEFT JOIN
						(SELECT *
							FROM calculation_summed_deposition_results_view
							WHERE calculation_id = v_current_calculation_id
						) AS current USING (receptor_id)

				WHERE
					NOT (proposed.deposition > v_threshold)
					AND (current.deposition IS NULL OR NOT (current.deposition > v_threshold))
			) -- receptors_to_delete
	;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_determine_calculation_receptor_ids
 * -------------------------------------
 * Functie voor het bepalen van een aantal receptoren vanaf een bepaalde receptor op ringen rondom een andere receptor met of zonder intersect met n2k gebieden.
 */
CREATE OR REPLACE FUNCTION ae_determine_calculation_receptor_ids(midpoint_receptor_id int, outer_receptor_id int, func_limit int, calculation_type calculation_type = 'nature_area', zoomlevel int = 1)
	RETURNS TABLE (receptor_id int, geometry geometry) AS
$BODY$
DECLARE
	radius int;
	offset_on_ring int;
	nrs_done int;
BEGIN
	-- Function starts with determining the radius and offset on the ring on which the second receptor is located
	SELECT output[1], output[2] INTO radius, offset_on_ring
		FROM ae_determine_radius_and_offset_of_outer_receptor_from_midpoint_receptor(midpoint_receptor_id, outer_receptor_id, zoomlevel) AS output;

	-- A table with all receptors on the ring starting from the offset
	CREATE TEMPORARY TABLE tmp_receptors_on_ring_with_offset ON COMMIT DROP AS SELECT receptor_id_intern,
											ae_determine_coordinates_from_receptor_id(receptor_id_intern) AS geometry_intern
											FROM ae_determine_receptor_ids_from_receptor_with_radius(midpoint_receptor_id, radius) AS receptor_id_intern
											WHERE ae_is_receptor_id_available_on_zoomlevel(receptor_id_intern,zoomlevel)
											OFFSET offset_on_ring;
	-- Next create a table with the receptors on the given ring within the n2k areas
	IF calculation_type = 'nature_area' THEN
		CREATE TEMPORARY TABLE tmp_receptors_on_rings ON COMMIT DROP AS
			SELECT receptor_id_intern, geometry_intern
				FROM tmp_receptors_on_ring_with_offset
					INNER JOIN receptors ON (receptors.receptor_id = receptor_id_intern);

	ELSIF calculation_type = 'permit' THEN
		CREATE TEMPORARY TABLE tmp_receptors_on_rings ON COMMIT DROP AS
			SELECT receptor_id_intern, geometry_intern
				FROM tmp_receptors_on_ring_with_offset
					INNER JOIN included_receptors ON (included_receptors.receptor_id = receptor_id_intern);

	ELSE
		CREATE TEMPORARY TABLE tmp_receptors_on_rings ON COMMIT DROP AS
			SELECT receptor_id_intern, geometry_intern
				FROM tmp_receptors_on_ring_with_offset;

	END IF;
	nrs_done := count (*) FROM tmp_receptors_on_rings;

	-- When there are still receptors to go, but the maximum of rings hasn't been reached, do another ring
	WHILE (nrs_done < func_limit AND radius < 4621) LOOP
		radius = radius + 1;
		IF calculation_type = 'nature_area' THEN
			INSERT INTO tmp_receptors_on_rings SELECT receptor_id_intern, ae_determine_coordinates_from_receptor_id(receptor_id_intern) AS geometry_intern
									FROM ae_determine_receptor_ids_from_receptor_with_radius(midpoint_receptor_id, radius) AS receptor_id_intern
										INNER JOIN receptors ON (receptors.receptor_id = receptor_id_intern)
									WHERE ae_is_receptor_id_available_on_zoomlevel(receptor_id_intern,zoomlevel);

		ELSIF calculation_type = 'permit' THEN
			INSERT INTO tmp_receptors_on_rings SELECT receptor_id_intern, ae_determine_coordinates_from_receptor_id(receptor_id_intern) AS geometry_intern
									FROM ae_determine_receptor_ids_from_receptor_with_radius(midpoint_receptor_id, radius) AS receptor_id_intern
										INNER JOIN included_receptors ON (included_receptors.receptor_id = receptor_id_intern)
									WHERE ae_is_receptor_id_available_on_zoomlevel(receptor_id_intern,zoomlevel);

		ELSE
			INSERT INTO tmp_receptors_on_rings SELECT receptor_id_intern, ae_determine_coordinates_from_receptor_id(receptor_id_intern) AS geometry_intern
								FROM ae_determine_receptor_ids_from_receptor_with_radius(midpoint_receptor_id, radius) AS receptor_id_intern
								WHERE ae_is_receptor_id_available_on_zoomlevel(receptor_id_intern,zoomlevel);

		END IF;
		nrs_done := count (*) FROM tmp_receptors_on_rings;
	END LOOP;
	RETURN QUERY (SELECT * FROM tmp_receptors_on_rings LIMIT func_limit);

	DROP TABLE tmp_receptors_on_rings;
	DROP TABLE tmp_receptors_on_ring_with_offset;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_determine_receptor_terrain_properties
 * ----------------------------------------
 * Functie voor het bepalen van een set receptoren en hun terrein eigenschappen
 * vanaf een bepaalde receptor op ringen rondom een andere receptor met of zonder intersect met n2k gebieden op een bepaalde zoomlevel.
 *
 * Retourneert average_roughness 0.1 en dominant_land_use, overige natuur indien er geen terrein eigenschappen bij de receptor gevonden kan worden.
 */
CREATE OR REPLACE FUNCTION ae_determine_receptor_terrain_properties(midpoint_receptor_id integer, outer_receptor_id integer, result_size integer, calculation_type calculation_type = 'nature_area', zoomlevel integer = 1)
	RETURNS SETOF terrain_properties AS
$BODY$
	SELECT
		receptor_id,
		zoom_level,
		COALESCE(average_roughness, 0.1::real),
		COALESCE(dominant_land_use, 'overige natuur'::land_use_classification),
		COALESCE(land_uses, ARRAY[0, 0, 0, 0, 0, 0, 0, 100, 0]::integer[])

		FROM ae_determine_calculation_receptor_ids($1, $2, $3, $4, $5) AS receptor_id
			LEFT JOIN terrain_properties_view USING (receptor_id);
$BODY$
LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_determine_permit_authority
 * -----------------------------
 * Functie om het bevoegd gezag voor een berekening te bepalen, waarbij de berekening een vergunning voorstelt.
 *
 * Dit door te kijken waar de receptor met de hoogste behoefte ligt. De volgorde is:
 * - Bevoegd gezag van het gebied waar de hoogste projectbijdrage is.
 * - Indien meerdere gebieden: grootste relevante oppervlakte binnen het hexagon, of daarna korste afstand zwaartepunt bronnen en hexagon.
 * - Indien geen projectbijdrage in een Nederlands gebied (en wel in een buitenlands-gebied): Provincie waar het zwaartepunt van de bronnen ligt of
 * daarna korste afstand zwaartepunt bronnen en provincie.
 *
 * Let op, er wordt niet meer gebruik gemaakt van rank(), alleen nog maar één ORDER BY. Maar er zijn wel twee manieren waarop er meerdere gebieden
 * kunnen zijn. Beide gevallen worden nu uniform opgepakt in de ORDER BY:
 * - De receptor met hoogste development_space_demand kan in meerdere gebieden tegelijk liggen, dan krijg je duplicatie door de INNER JOIN.
 * - De hoogste development_space_demand kan gelijk zijn voor verschillende receptors, wat weer meerdere gebieden kan betekenen.
 *
 * Deze functie gaat waarschijnlijk aangeroepen worden vanuit Calculator waarbij er nog geen vergunnings-id beschikbaar is. Vandaar de de benodigde
 * informatie los wordt meegegeven:
 *
 * @column v_proposed_calculation_id Id van de berekening met voorgestelde situatie.
 * @column v_current_calculation_id Id van de berekening met huidige situatie (mag NULL zijn).
 * @column v_centroid Middelpunt van de bronnen van de vergunning.
 * @returns Id van bevoegd gezag (authority_id).
 *
 * @todo Not used anymore. Clean up?
 */
CREATE OR REPLACE FUNCTION ae_determine_permit_authority(v_proposed_calculation_id integer, v_current_calculation_id integer, v_centroid geometry)
	RETURNS integer AS
$BODY$
DECLARE
	v_authority_id integer := NULL;
BEGIN
	v_authority_id := authority_id FROM
		(SELECT
			authority_id,
			assessment_area_id,
			receptor_id

			FROM development_space_demands
				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id) -- A receptor can be in multiple areas
				INNER JOIN assessment_areas USING (assessment_area_id)
				INNER JOIN receptors USING (receptor_id)
				INNER JOIN authorities_view USING (authority_id)

			WHERE
				proposed_calculation_id = v_proposed_calculation_id
				AND current_calculation_id = COALESCE(v_current_calculation_id, 0)
				AND assessment_areas.type = 'natura2000_area'
				AND foreign_authority IS FALSE

			ORDER BY development_space_demand DESC, surface DESC, ST_Distance(receptors.geometry, v_centroid) ASC

			LIMIT 1
		) AS best_authority
	;

	IF v_authority_id IS NULL THEN
		-- Nothing found can really only mean there is no deposition in Dutch areas. Maybe it's abroad or there's nothing relevant, in either case we
		-- then simply take the province closest to the sources centroid point.
		SELECT authority_id INTO STRICT v_authority_id FROM ae_determine_nearest_province(v_centroid) AS province_area_id INNER JOIN province_areas USING (province_area_id);
	END IF;

	RETURN v_authority_id;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_calculation_results_bounding_box
 * -----------------------------------
 * Functie berekent en retouneert een tabel met de coordinaten die gebruikt kunnen worden
 * voor een bounding box voor calculation results van 1 calculation.
 * De coordinaten zijn voor het linker-beneden punt en het rechter-boven punt van de bounding box.
 * Zoomlevel wordt gebruikt om de grootte van de hexagonen aan de randen mee te nemen.
 */
CREATE OR REPLACE FUNCTION ae_calculation_results_bounding_box(v_calculation_id int, zoom_level int)
	RETURNS TABLE(min_x double precision, min_y double precision, max_x double precision, max_y double precision) AS
$BODY$
DECLARE
	scaling_factor posint;
	hexagon_side_size double precision;
	hexagon_width double precision;
	hexagon_height double precision;
BEGIN
	scaling_factor = 2^(zoom_level-1)::posint;
	hexagon_side_size = sqrt((2/(3*sqrt(3))*10000));		--10000 is a hectare
	hexagon_width = (hexagon_side_size * 2)::double precision;
	hexagon_height = (hexagon_side_size * sqrt(3))::double precision;

	RETURN QUERY
		SELECT MIN(ST_X(ae_determine_coordinates_from_receptor_id(receptor_id))) - hexagon_width,
			MIN(ST_Y(ae_determine_coordinates_from_receptor_id(receptor_id))) - hexagon_height,
			MAX(ST_X(ae_determine_coordinates_from_receptor_id(receptor_id))) + hexagon_width,
			MAX(ST_Y(ae_determine_coordinates_from_receptor_id(receptor_id))) + hexagon_height

			FROM calculation_results results
				INNER JOIN calculation_result_sets USING (calculation_result_set_id)

			WHERE calculation_result_sets.calculation_id = v_calculation_id;
END;
$BODY$
LANGUAGE plpgsql STABLE;
