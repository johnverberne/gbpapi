/*
 * build_development_spaces_view
 * -----------------------------
 * View om de development_spaces tabel te vullen (met alle waarden op 0).
 */
CREATE OR REPLACE VIEW setup.build_development_spaces_view AS
SELECT
	segment,
	(CASE WHEN segment = 'permit_threshold' OR segment = 'priority_projects' THEN 'assigned'::development_space_state ELSE unnest(enum_range(NULL::development_space_state)) END) AS status,
	receptor_id,
	0 AS space

	FROM reserved_development_spaces
;


/*
 * build_initial_available_development_spaces_view
 * -----------------------------------------------
 * View om de initial_available_development_spaces tabel te vullen.
 * Hiervoor wordt dezelfde methodiek gebruikt als de update trigger die dit per receptor doet.
 *
 * @see calc_initial_available_development_spaces_view
 * @see ae_update_initial_available_development_spaces
 */
CREATE OR REPLACE VIEW setup.build_initial_available_development_spaces_view AS
SELECT
	segment,
	receptor_id,
	space

	FROM calc_initial_available_development_spaces_view
;


/*
 * build_permit_threshold_values_view
 * ----------------------------------
 * View om de permit_threshold_values tabel te vullen.
 * Vul met waarde 1.0 voor ieder PAS-gebied.
 */
CREATE OR REPLACE VIEW setup.build_permit_threshold_values_view AS
SELECT
	assessment_area_id,
	ae_constant('DEFAULT_PERMIT_THRESHOLD_VALUE')::posreal AS value

	FROM pas_assessment_areas
;
