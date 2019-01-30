/*
 * ae_generate_receptor_file
 * -------------------------
 * Functie voor het genereren van een receptor-file (gegeven een receptor-set en zoom_level).
 */
CREATE OR REPLACE FUNCTION setup.ae_generate_receptor_file(v_receptor_list integer[], v_zoom_level integer, v_filespec text, client_encoding text = 'UTF8')
	RETURNS void AS
$BODY$
DECLARE
	sql text;
	current_encoding text;
BEGIN
	-- Set encoding
	EXECUTE 'SHOW client_encoding' INTO current_encoding;
	EXECUTE 'SET client_encoding TO ' || client_encoding;

	-- Generate receptor-file
	v_filespec := replace(v_filespec, '{datesuffix}', to_char(current_timestamp, 'YYYYMMDD'));

	CREATE TEMPORARY TABLE tmp_terrain_properties AS
	SELECT
		receptor_id,
		COALESCE(receptors.geometry, ae_determine_coordinates_from_receptor_id(receptor_id)) AS geometry,
		average_roughness,
		dominant_land_use,
		land_uses

		FROM (SELECT unnest(v_receptor_list) AS receptor_id) AS selected_receptors
			LEFT JOIN receptors USING (receptor_id)
			INNER JOIN terrain_properties USING (receptor_id)

		WHERE zoom_level = v_zoom_level
	;

	sql := E'COPY
		(SELECT
			0 AS Nr,
			receptor_id AS Name,
			round(ST_X(geometry)) AS X_coor,
			round(ST_Y(geometry)) AS Y_coor,
			round(average_roughness::numeric, 6) AS AVG_z0, --not entirely sure rounding is needed here, but its what we use in Java. Default value = 0.1
			dominant_land_use::integer AS DOM_LU, --Default value is 8 (other_nature)
			land_uses[1] AS LU1, -- Default value would be 100 for the dominant_land_use, 0 for rest
			land_uses[2] AS LU2,
			land_uses[3] AS LU3,
			land_uses[4] AS LU4,
			land_uses[5] AS LU5,
			land_uses[6] AS LU6,
			land_uses[7] AS LU7,
			land_uses[8] AS LU8,
			land_uses[9] AS LU9

			FROM tmp_terrain_properties

			ORDER BY receptor_id)

		TO ''' || v_filespec || E''' CSV HEADER DELIMITER '' ''';

	EXECUTE sql;

	-- Reset encoding
	EXECUTE 'SET client_encoding TO ' || current_encoding;

	-- Cleanup
	DROP TABLE tmp_terrain_properties;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_generate_receptor_files
 * --------------------------
 * Functie voor het genereren van alle receptor-files.
 * @v_filepath Het opgegeven path moet eindigen met een /.
 */
CREATE OR REPLACE FUNCTION setup.ae_generate_receptor_files(v_filepath text)
	RETURNS void AS
$BODY$
DECLARE
	v_zoom_level integer = 1;
	v_abroad_zoom_level integer = 3;
	v_assessment_area_id integer;
BEGIN
	--
	-- Rekengebied nederland
	--
	CREATE TEMPORARY TABLE tmp_national_receptors AS
	SELECT assessment_area_id, receptor_id, zoom_level
		FROM setup.geometry_of_interests
			INNER JOIN assessment_areas USING (assessment_area_id)
			INNER JOIN authorities_view USING (authority_id)
			INNER JOIN receptors ON ST_Within(receptors.geometry, geometry_of_interests.geometry)
			INNER JOIN hexagons USING (receptor_id)

		WHERE
			foreign_authority IS FALSE
			AND zoom_level = v_zoom_level
	;

	-- File voor heel nederland
	FOR v_assessment_area_id IN
		(SELECT DISTINCT assessment_area_id FROM tmp_national_receptors)
	LOOP
		PERFORM setup.ae_generate_receptor_file(
					(SELECT array_agg(receptor_id) FROM tmp_national_receptors WHERE assessment_area_id = v_assessment_area_id),
					v_zoom_level,
					v_filepath || 'area-' || v_assessment_area_id || '_receptors_{datesuffix}.rcp');
	END LOOP;



	-- File per natuurgebied in nederland
	EXECUTE setup.ae_generate_receptor_file(
				(SELECT array_agg(DISTINCT receptor_id) FROM tmp_national_receptors),
				v_zoom_level,
				v_filepath || 'all_receptors_{datesuffix}.rcp');

	--
	-- Rekengrid buitenland (zoom_level 3)
	--
	CREATE TEMPORARY TABLE tmp_abroad_receptors AS
	SELECT assessment_area_id, receptor_id, zoom_level
		FROM setup.geometry_of_interests
			INNER JOIN assessment_areas USING (assessment_area_id)
			INNER JOIN authorities_view USING (authority_id)
			INNER JOIN receptors ON ST_Within(receptors.geometry, geometry_of_interests.geometry)
			INNER JOIN hexagons USING (receptor_id)

		WHERE
			foreign_authority IS TRUE
			AND zoom_level = v_abroad_zoom_level
	;

	-- File voor heel nederland
	FOR v_assessment_area_id IN
		(SELECT DISTINCT assessment_area_id FROM tmp_abroad_receptors)
	LOOP
		PERFORM setup.ae_generate_receptor_file(
					(SELECT array_agg(receptor_id) FROM tmp_abroad_receptors WHERE assessment_area_id = v_assessment_area_id),
					v_abroad_zoom_level,
					v_filepath || 'area-' || v_assessment_area_id || '_receptors_abroad_{datesuffix}.rcp');
	END LOOP;

	-- File per natuurgebied in nederland
	PERFORM setup.ae_generate_receptor_file(
				(SELECT array_agg(DISTINCT receptor_id) FROM tmp_abroad_receptors),
				v_abroad_zoom_level,
				v_filepath || 'all_receptors_abroad_{datesuffix}.rcp');


	DROP TABLE tmp_national_receptors;
	DROP TABLE tmp_abroad_receptors;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
