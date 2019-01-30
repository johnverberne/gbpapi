--Temp mock data. Easier to have this temporary data in here like this during development.
--TODO: remove when there's some actual implementation...

/*
 * Randomly generating some requests:
 * - multiple per province
 * - more then one notice/sector per province.
 * - random points for the locations within the province.
 */

BEGIN;

	/*
	 * Random point in geometry generator
	 */
	CREATE OR REPLACE FUNCTION ae_tmp_random_point (geom geometry, maxiter integer DEFAULT 1000)
		RETURNS geometry AS
	$BODY$
	DECLARE
		i integer := 0;
		x0 double precision;
		dx double precision;
		y0 double precision;
		dy double precision;
		rpoint geometry;
	BEGIN
		-- find envelope
		x0 = ST_XMin(geom);
		dx = (ST_XMax(geom) - x0);
		y0 = ST_YMin(geom);
		dy = (ST_YMax(geom) - y0);

		WHILE i < maxiter LOOP
			i = i + 1;
			rpoint = ST_SetSRID( ST_MakePoint( x0 + dx * random(), y0 + dy * random() ), ST_SRID(geom) );
			EXIT WHEN ST_Within( rpoint, geom );
		END LOOP;

		IF i >= maxiter THEN
			RAISE EXCEPTION 'ae_tmp_random_point: number of interations exceeded %', maxiter;
		END IF;

		RETURN rpoint;
	END;
	$BODY$
	LANGUAGE plpgsql VOLATILE;

	/*
	 * Insert file-as-bytea function
	 */
	CREATE OR REPLACE FUNCTION ae_tmp_bytea_import(stupid_sync_script_var text, p_path text)
		RETURNS bytea AS
	$BODY$
	DECLARE
		l_oid oid;
		p_result bytea;
		r record;
	BEGIN
		p_result := '';
		SELECT lo_import(p_path) INTO l_oid;
		FOR r IN (SELECT data
			FROM pg_largeobject
			WHERE loid = l_oid
			ORDER BY pageno )
		LOOP
			p_result = p_result || r.data;
		END loop;
		PERFORM lo_unlink(l_oid);
		RETURN p_result;
	END;
	$BODY$
	LANGUAGE plpgsql VOLATILE;

	CREATE OR REPLACE TEMPORARY VIEW tmp_request_provinces_authorities_sectors_view AS
	SELECT *, row_number % 3 = 0 AS has_multiple_sectors FROM
		(SELECT
			row_number() OVER (ORDER BY province_areas.name),
			authority_id,
			authorities.name AS authority_name,
			province_area_id,
			province_areas.name AS province_area_name,
			province_areas.geometry AS province_area_geometry

			FROM province_areas
				INNER JOIN authorities USING (authority_id)
		) AS provinces_and_authorities
		INNER JOIN
			(SELECT
				row_number() OVER (ORDER BY sector_id),
				sector_id

				FROM (SELECT sector_id, row_number() OVER (ORDER BY sector_id) AS rownr FROM sectors) AS numbered_sectors

				WHERE rownr % 3 = 0
				LIMIT 12
			) AS sectors USING (row_number)
--For more requests, use:
--		FROM (SELECT
--				authority_id,
--				authorities.name AS authority_name,
--				province_area_id,
--				province_areas.name AS province_area_name,
--				province_areas.geometry AS province_area_geometry,
--				sector_id
--
--				FROM province_areas
--					INNER JOIN authorities USING (authority_id)
--					CROSS JOIN sectors
--			) AS province_areas_authorities_sectors
	;

	CREATE OR REPLACE TEMPORARY VIEW tmp_request_dossiers_view AS
	SELECT request_id, segment, user_id, reference, authorities.authority_id
		FROM requests
			INNER JOIN (
				SELECT request_id, MIN(COALESCE(user_id, 1)) AS user_id FROM requests LEFT JOIN users_view USING (authority_id) GROUP BY request_id
				) AS handlers USING (request_id)
			INNER JOIN authorities USING (authority_id)
			INNER JOIN users_view USING (user_id)
	;
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;
	/*
	 * Permits part, all authority/sector combinations get one, half of the permits get a current situation as well as a proposed, rest just the proposed.
	 */
	INSERT INTO requests (segment, status, authority_id, sector_id, has_multiple_sectors, reference, start_year, temporary_period, province_area_id, corporation, project_name, description, insert_date, last_modified, geometry)
	SELECT
		'projects'::segment_type AS segment,
		'queued'::request_status_type AS status,
		authority_id,
		sector_id,
		has_multiple_sectors,
		'project_' || province_area_name || '_' || authority_id || '_' || sector_id AS reference,
		2020 AS start_year,
		NULL AS temporary_period,
		province_area_id,
		authority_name AS corporation,
		'Test permit' || sector_id || ' voor ' || province_area_name AS project_name,
		'Een of andere toelichting voor deze test vergunningsaanvraag.' AS description,
		now() AS insert_date,
		now() AS last_modified,
		ae_tmp_random_point(province_area_geometry)

		FROM tmp_request_provinces_authorities_sectors_view
	;

	INSERT INTO permits (request_id, handler_id, received_date, dossier_id, remarks)
	SELECT
		request_id,
		user_id AS handler_id,
		now() - interval '45 days' - ('' || request_id % 60 || ' days')::interval AS received_date,
		reference AS dossier_id,
		NULL AS remarks

		FROM tmp_request_dossiers_view

		WHERE segment = 'projects'
	;

	UPDATE requests SET authority_id = user_details.authority_id

		FROM permits
			INNER JOIN users ON (handler_id = user_id)
			INNER JOIN user_details USING (user_id)

		WHERE requests.request_id = permits.request_id
	;

	INSERT INTO request_situation_properties (request_id, situation, name)
	SELECT
		request_id,
		situation,
		situation || ' situatie ' || request_id

		FROM permits
			CROSS JOIN (SELECT unnest(enum_range(NULL::situation_type)) AS situation) AS situations

		WHERE request_id % 2 = 0 OR (request_id % 2 = 1 AND situation = 'proposed')
	;

	INSERT INTO request_situation_emissions (request_id, situation, substance_id, total_emission)
	SELECT
		request_id,
		situation,
		substance_id,
		100000 * random() AS total_emission

		FROM permits
			CROSS JOIN (SELECT unnest(enum_range(NULL::situation_type)) AS situation) AS situations
			CROSS JOIN (SELECT substance_id from substances where name = 'nox' OR name = 'nh3') AS substances

		WHERE request_id % 2 = 0 OR (request_id % 2 = 1 AND situation = 'proposed')
	;
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;

	/*
	 * Pronouncements part, all authority/sector combinations get one, half of the pronouncements are checked, rest isn't.
	 */
	INSERT INTO requests (segment, status, authority_id, sector_id, has_multiple_sectors, reference, start_year, temporary_period, province_area_id, corporation, project_name, description, insert_date, last_modified, geometry)
	SELECT
		'permit_threshold'::segment_type AS segment,
		'assigned'::request_status_type AS status,
		authority_id,
		sector_id,
		has_multiple_sectors,
		'melding_' || province_area_name || '_' || sector_id || '_' || authority_id AS reference,
		2020 AS start_year,
		NULL AS temporary_period,
		province_area_id,
		authority_name AS corporation,
		'Test melding' || sector_id || ' voor ' || province_area_name AS project_name,
		'Een of andere toelichting voor deze test melding.' AS description,
		now() AS insert_date,
		now() AS last_modified,
		ae_tmp_random_point(province_area_geometry)

		FROM tmp_request_provinces_authorities_sectors_view
	;

	INSERT INTO pronouncements (request_id, checked)
	SELECT
		request_id,
		authority_id >= 10 AS checked

		FROM requests

		WHERE requests.segment = 'permit_threshold'
	;

COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;
	/*
	 * Priority projects part, all authority/sector combinations get one, half of the projects get a current situation as well as a proposed, rest just the proposed.
	 */
	INSERT INTO requests (segment, status, authority_id, sector_id, has_multiple_sectors, reference, start_year, temporary_period, province_area_id, corporation, project_name, description, insert_date, last_modified, geometry)
	SELECT
		'priority_projects'::segment_type AS segment,
		'assigned'::request_status_type AS status,
		CASE WHEN authority_id % 2 = 0 THEN min_authority_id ELSE authority_id END AS authority_id,
		sector_id,
		has_multiple_sectors,
		'pp_' || province_area_name || '_' || authority_id || '_' || sector_id AS reference,
		2020 AS start_year,
		NULL AS temporary_period,
		province_area_id,
		authority_name AS corporation,
		'Test PP ' || sector_id || ' voor ' || province_area_name AS project_name,
		'Een of andere toelichting voor dit test prioritaire project.' AS description,
		now() - interval '2 days' - ('' || authority_id || ' days')::interval AS insert_date,
		now() AS last_modified,
		ae_tmp_random_point(province_area_geometry)

		FROM tmp_request_provinces_authorities_sectors_view
			CROSS JOIN (SELECT MIN(authority_id) AS min_authority_id FROM authorities) AS authorities
	;

	INSERT INTO priority_projects (request_id, dossier_id, remarks, assign_completed, fraction_assigned)
	SELECT
		request_id,
		reference AS dossier_id,
		NULL AS remarks,
		request_id % 4 = 0 AS assign_completed,
		0 AS fraction_assigned

		FROM tmp_request_dossiers_view

		WHERE segment = 'priority_projects'
	;

	INSERT INTO request_situation_properties (request_id, situation, name)
	SELECT
		request_id,
		situation,
		situation || ' situatie ' || request_id

		FROM priority_projects
			CROSS JOIN (SELECT unnest(enum_range(NULL::situation_type)) AS situation) AS situations

		WHERE request_id % 2 = 0 OR (request_id % 2 = 1 AND situation = 'proposed')
	;

	INSERT INTO request_situation_emissions (request_id, situation, substance_id, total_emission)
	SELECT
		request_id,
		situation,
		substance_id,
		100000 * random() AS total_emission

		FROM priority_projects
			CROSS JOIN (SELECT unnest(enum_range(NULL::situation_type)) AS situation) AS situations
			CROSS JOIN (SELECT substance_id from substances where name = 'nox' OR name = 'nh3') AS substances

		WHERE request_id % 2 = 0 OR (request_id % 2 = 1 AND situation = 'proposed')
	;
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;
	/*
	 * Priority subprojects part, all authority/sector combinations get one, half of the projects get a current situation as well as a proposed, rest just the proposed.
	 */
	INSERT INTO requests (segment, status, authority_id, sector_id, has_multiple_sectors, reference, start_year, temporary_period, province_area_id, corporation, project_name, description, insert_date, last_modified, geometry)
	SELECT
		'priority_subprojects'::segment_type AS segment,
		(CASE WHEN authority_id % 3 = 0 THEN 'queued' ELSE 'assigned' END)::request_status_type AS status,
		authority_id,
		sector_id,
		has_multiple_sectors,
		'pdp_' || province_area_name || '_' || authority_id || '_' || sector_id AS reference,
		2020 AS start_year,
		NULL AS temporary_period,
		province_area_id,
		authority_name AS corporation,
		'Test PDP ' || sector_id || ' voor ' || province_area_name AS project_name,
		'Een of andere toelichting voor dit test prioritaire deelproject.' AS description,
		now() AS insert_date,
		now() AS last_modified,
		ae_tmp_random_point(province_area_geometry)

		FROM tmp_request_provinces_authorities_sectors_view
	;

	INSERT INTO priority_subprojects (request_id, priority_project_request_id)
	SELECT
		request_id,
		(array_agg(priority_project_request_id))[request_id % 5 + 1] AS priority_project_request_id

		FROM requests
			CROSS JOIN (SELECT request_id AS priority_project_request_id FROM priority_projects ORDER BY request_id LIMIT 5) AS subsetpp

		WHERE segment = 'priority_subprojects'

		GROUP BY request_id
	;

	--update subprojects to have same authority as it's 'koepel' project.
	UPDATE requests SET authority_id = pp.authority_id
		FROM priority_subprojects
			JOIN requests pp ON (priority_subprojects.priority_project_request_id = pp.request_id)
			WHERE requests.request_id = priority_subprojects.request_id;

	INSERT INTO request_situation_properties (request_id, situation, name)
	SELECT
		request_id,
		situation,
		situation || ' situatie ' || request_id

		FROM priority_subprojects
			CROSS JOIN (SELECT unnest(enum_range(NULL::situation_type)) AS situation) AS situations

		WHERE request_id % 2 = 0 OR (request_id % 2 = 1 AND situation = 'proposed')
	;

	INSERT INTO request_situation_emissions (request_id, situation, substance_id, total_emission)
	SELECT
		request_id,
		situation,
		substance_id,
		100000 * random() AS total_emission

		FROM priority_subprojects
			CROSS JOIN (SELECT unnest(enum_range(NULL::situation_type)) AS situation) AS situations
			CROSS JOIN (SELECT substance_id from substances where name = 'nox' OR name = 'nh3') AS substances

		WHERE request_id % 2 = 0 OR (request_id % 2 = 1 AND situation = 'proposed')
	;
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;
	/*
	 * Creating a calculation with a specific deposition value for all included_receptors.
	 * All depositions will be added for substance_id 17 (NH3).
	 */
	CREATE OR REPLACE FUNCTION ae_tmp_create_calculation(v_deposition posreal)
		RETURNS integer AS $$
	DECLARE
		created_calculation_id INTEGER;
		created_calculation_result_set_id INTEGER;
	BEGIN
		INSERT INTO calculations (year, state) VALUES (2015, 'completed') RETURNING calculation_id INTO created_calculation_id;

		INSERT INTO calculation_result_sets (calculation_id, result_set_type, result_set_type_key, result_type, substance_id)
			VALUES (created_calculation_id, 'total', 0, 'deposition', 17) RETURNING calculation_result_set_id INTO created_calculation_result_set_id;

		INSERT INTO calculation_results (calculation_result_set_id, receptor_id, result)
			SELECT created_calculation_result_set_id, receptor_id, v_deposition
				FROM included_receptors;

		RETURN created_calculation_id;
	END;
	$$ LANGUAGE plpgsql VOLATILE;
COMMIT;

BEGIN;
	--calculations for permits and priority subprojects
	--even request_id's get 1 situation, deposition around 1.5 (some are actually below the 1.0 threshold, but meh)
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'proposed', ae_tmp_create_calculation((0.5 + random() * 2.0)::posreal)
		FROM requests
		WHERE request_id % 2 = 0 AND (segment = 'projects' OR (segment = 'priority_subprojects' AND status <> 'queued'));
COMMIT;

BEGIN;
	--but for the 1-situation queued subprojects, make then NOT FIT. for review info
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'proposed', ae_tmp_create_calculation((50 + random() * 20.0)::posreal)
		FROM requests
		WHERE request_id % 2 = 0 AND segment = 'priority_subprojects' AND status = 'queued';
COMMIT;

BEGIN;
	--odd request_id's get 2 situations, deposition for proposed always being > current (technical minimum of 0.5, maximum of 4.0)
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'proposed', ae_tmp_create_calculation((2.0 + random() * 2.0)::posreal)
		FROM requests
		WHERE request_id % 2 = 1 AND segment IN ('projects', 'priority_subprojects');
COMMIT;

BEGIN;
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'current', ae_tmp_create_calculation((random() * 1.5)::posreal)
		FROM requests
		WHERE request_id % 2 = 1 AND segment IN ('projects', 'priority_subprojects');
COMMIT;

BEGIN;
	--calculations for pronouncements
	--even request_id's get 1 situation, deposition around 0.1
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'proposed', ae_tmp_create_calculation((0.05 + random() * 0.025)::posreal)
		FROM pronouncements
		WHERE request_id % 2 = 0;
COMMIT;

BEGIN;
	--odd request_id's get 2 situations, deposition for proposed always being > current (technical minimum of 0.05, maximum of 0.225)
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'proposed', ae_tmp_create_calculation((0.2 + random() * 0.025)::posreal)
		FROM pronouncements
		WHERE request_id % 2 = 1;
COMMIT;

BEGIN;
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'current', ae_tmp_create_calculation((random() * 0.15)::posreal)
		FROM pronouncements
		WHERE request_id % 2 = 1;
COMMIT;

BEGIN;
	--calculations for priority projects
	INSERT INTO request_situation_calculations (request_id, situation, calculation_id)
	SELECT request_id, 'proposed', ae_tmp_create_calculation((5 + random() * 20.0)::posreal)
		FROM requests
		WHERE segment IN ('priority_projects');
COMMIT;

BEGIN;
	-- projects and pronouncements use PDFs as application files
	INSERT INTO request_files (request_id, file_type, file_format_type, file_name, content)
	SELECT
		request_id,
		'application'::request_file_type,
		'pdf',
		'AERIUS_test_pdf_20151021.pdf',
		ae_tmp_bytea_import('request_files', '{data_folder}/temp/AERIUS_test_pdf_20151021.txt')

		FROM requests
			WHERE segment IN ('projects', 'permit_threshold');
COMMIT;

BEGIN;
	-- priority (sub)projects use GMLs (or ZIP files containing GMLs I imagine).
	INSERT INTO request_files (request_id, file_type, file_format_type, file_name, content)
	SELECT
		request_id,
		(CASE WHEN segment = 'priority_projects'
			THEN (CASE WHEN request_id % 2 = 0 THEN unnest(ARRAY['priority_project_reservation', 'priority_project_actualisation']) ELSE 'priority_project_reservation' END)
			ELSE 'application'
		END)::request_file_type,
		'zip',
		'AERIUS_test_zip_gmls_with_results_20151021.zip',
		ae_tmp_bytea_import('request_files', '{data_folder}/temp/AERIUS_test_zip_gmls_with_results_20151021.txt')

		FROM requests
			WHERE segment IN ('priority_projects', 'priority_subprojects');
COMMIT;

BEGIN;
	-- priority subprojects which are assigned can have a fake decree/detail decree (else decree generator will try to do it, which doesn't always work for this test data).
	INSERT INTO request_files (request_id, file_type, file_format_type, file_name, content)
	SELECT
		request_id,
		file_type,
		'pdf',
		'AERIUS_test_pdf_20151021.pdf',
		ae_tmp_bytea_import('request_files', '{data_folder}/temp/AERIUS_test_pdf_20151021.txt')

		FROM unnest(ARRAY['decree', 'detail_decree']::request_file_type[]) AS file_type
		CROSS JOIN requests
			WHERE segment = 'priority_subprojects'
				AND status = 'assigned';
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;
	--add some correct references to 'Meldingen' for the selenium tests. Only works as long as we generate 1 request per province...
	UPDATE requests SET reference = '12JWr4AxnS' WHERE segment = 'permit_threshold' AND province_area_id = 1;
	UPDATE requests SET reference = '1W21yi5oU' WHERE segment = 'permit_threshold' AND province_area_id = 2;
	UPDATE requests SET reference = '12CPy1gBGK' WHERE segment = 'permit_threshold' AND province_area_id = 4;
	UPDATE requests SET reference = '122exRfQP1' WHERE segment = 'permit_threshold' AND province_area_id = 8;
	UPDATE requests SET reference = '12Avg1pjbd' WHERE segment = 'permit_threshold' AND province_area_id = 10;
	UPDATE requests SET reference = '12FpqpvRQr' WHERE segment = 'permit_threshold' AND province_area_id = 11;
	UPDATE requests SET reference = '12oqKYcdYV' WHERE segment = 'permit_threshold' AND province_area_id = 12;
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;
	--clean up test-data functions
	DROP FUNCTION ae_tmp_create_calculation(v_deposition posreal);
	DROP FUNCTION ae_tmp_bytea_import(stupid_sync_script_var text, p_path text);
	DROP FUNCTION ae_tmp_random_point (geom Geometry, maxiter INTEGER);
	DROP VIEW tmp_request_provinces_authorities_sectors_view;
	DROP VIEW tmp_request_dossiers_view;
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN;
	INSERT INTO development_spaces (segment, status, receptor_id, space) 
	SELECT
		segment,
		'assigned'::development_space_state, receptor_id,
		(reserved_development_spaces.space * random()) AS space

		FROM reserved_development_spaces 
			LEFT JOIN
				(SELECT * 
					FROM development_spaces 
					WHERE status = 'assigned'
				) AS development_spaces USING (segment, receptor_id)

		WHERE
			development_spaces.receptor_id IS NULL
			AND segment IN ('priority_subprojects', 'permit_threshold', 'priority_projects')
	;

	INSERT INTO development_spaces (segment, status, receptor_id, space) 
	SELECT
		segment,
		'pending_with_space'::development_space_state,
		receptor_id,
		((reserved_development_spaces.space - COALESCE(development_spaces.space, 0)) * random()) AS space

		FROM reserved_development_spaces 
			LEFT JOIN
				(SELECT *
					FROM development_spaces
					WHERE status = 'pending_with_space'
				) AS development_spaces USING (segment, receptor_id)

		WHERE
			development_spaces.receptor_id IS NULL
			AND segment = 'projects'
	;

	INSERT INTO development_spaces (segment, status, receptor_id, space) 
	SELECT
		segment,
		'pending_without_space'::development_space_state,
		receptor_id,
		((reserved_development_spaces.space - COALESCE(development_spaces.space, 0)) * random()) AS space

		FROM reserved_development_spaces 
			LEFT JOIN
				(SELECT *
					FROM development_spaces
					WHERE status = 'pending_without_space'
				) AS development_spaces USING (segment, receptor_id)

		WHERE
			development_spaces.receptor_id IS NULL
			AND segment = 'projects'
	;
COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Fill priority project reserved spaces
BEGIN;
	TRUNCATE TABLE priority_project_development_spaces;

	INSERT INTO priority_project_development_spaces(request_id, receptor_id, reserved_space, assigned_space)
	SELECT
		request_id,
		receptor_id,
		development_space_demand AS reserved_space,
		0 AS assigned_space

		FROM request_demands_view
			INNER JOIN priority_projects USING (request_id)
	;
COMMIT;

-- Make priority project specific assigned development spaces. This uses the actual sum of the calculations associated with the subprojects.
-- We need to collect these one subproject at a time and aggregate them later, because request_demands_view (and the views/functions using it) will not
-- perform at all when querying for multiple request_id's at once.
BEGIN;
	DO $BODY$
	DECLARE
		v_priority_project_request_id integer;
		v_request_id integer;
		v_currently_assigned real;
	BEGIN
		FOR v_priority_project_request_id IN (SELECT request_id FROM priority_projects)
		LOOP
			RAISE NOTICE 'Determining assigned space for priority project %', v_priority_project_request_id;

			DROP TABLE IF EXISTS tmp_pp_assigned_development_spaces;
			CREATE TEMPORARY TABLE tmp_pp_assigned_development_spaces (receptor_id integer, space real) ON COMMIT DROP;
			CREATE INDEX idx_tmp_pp_assigned_development_spaces ON tmp_pp_assigned_development_spaces (receptor_id);

			FOR v_request_id IN (SELECT request_id FROM priority_subprojects INNER JOIN requests USING (request_id) WHERE priority_project_request_id = v_priority_project_request_id AND status = 'assigned')
			LOOP
				RAISE NOTICE 'Collecting assigned space for priority subproject %', v_request_id;

				INSERT INTO tmp_pp_assigned_development_spaces(receptor_id, space)
				SELECT
					receptor_id,
					development_space_demand AS space

					FROM request_demands_view

					WHERE request_id = v_request_id
				;
			END LOOP;

			RAISE NOTICE 'Updating assigned space for priority project %', v_priority_project_request_id;

			UPDATE priority_project_development_spaces

				SET assigned_space = space

				FROM
					(SELECT
						receptor_id,
						SUM(space) AS space

						FROM tmp_pp_assigned_development_spaces

						GROUP BY receptor_id
					) AS summed_development_spaces

				WHERE
					priority_project_development_spaces.request_id = v_priority_project_request_id
					AND priority_project_development_spaces.receptor_id = summed_development_spaces.receptor_id
			;

			RAISE NOTICE 'Updating assigned space fraction for priority project %', v_priority_project_request_id;

			v_currently_assigned := (
				SELECT COALESCE(SUM(assigned_space) / NULLIF(SUM(reserved_space), 0), 0)::real
				FROM priority_project_available_development_spaces_view
				WHERE request_id = v_priority_project_request_id
			);
			UPDATE priority_projects SET fraction_assigned = v_currently_assigned WHERE request_id = v_priority_project_request_id;
		END LOOP;
	END;
	$BODY$;

COMMIT;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

BEGIN; SELECT ae_update_permit_threshold_values(); COMMIT;