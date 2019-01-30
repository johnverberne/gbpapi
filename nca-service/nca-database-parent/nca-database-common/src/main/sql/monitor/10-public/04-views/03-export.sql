/*
 * export_assessment_areas_view
 * ----------------------------
 * Geeft de IDs en namen van de gebieden terug waarvoor geexporteerd mag worden.
 */
CREATE OR REPLACE VIEW export_assessment_areas_view AS
SELECT
	assessment_area_id,
	name AS assessment_area_name

	FROM natura2000_areas
;


/*
 * receptors_to_assessment_areas_export_view
 * -----------------------------------------
 * Geeft de koppeling tussen toetsgebieden en receptors terug.
 */
CREATE OR REPLACE VIEW receptors_to_assessment_areas_export_view AS
SELECT
	assessment_area_id,
	receptor_id,
	(included_receptors.receptor_id IS NOT NULL) AS included,
	critical_deposition

	FROM receptors_to_assessment_areas
		LEFT JOIN included_receptors USING (receptor_id)
		LEFT JOIN critical_depositions USING (receptor_id)
;


/*
 * receptors_to_province_assessment_areas_export_view
 * --------------------------------------------------
 * Geeft de koppeling tussen provincies en receptors terug.
 */
CREATE OR REPLACE VIEW receptors_to_province_assessment_areas_export_view AS
SELECT
	province_area_id,
	assessment_area_id,
	receptor_id,
	included,
	critical_deposition

	FROM receptors_to_assessment_areas_export_view
		INNER JOIN assessment_areas_to_province_areas_view USING (assessment_area_id)
;


/*
 * critical_deposition_areas_goal_habitat_type_view
 * ------------------------------------------------
 * Geeft de koppeling tussen critical deposition areas en hun parent weer.
 */
CREATE OR REPLACE VIEW critical_deposition_areas_goal_habitat_type_view AS
SELECT
	habitat_type_id AS critical_deposition_area_id,
	unnest(ARRAY['habitat', 'relevant_habitat']::critical_deposition_area_type[]) AS type,
	goal_habitat_type_id,
	name AS goal_habitat_type_name,
	description AS goal_habitat_type_description

	FROM goal_habitat_types_view
;


/*
 * critical_deposition_areas_to_assessment_areas_export_view
 * ---------------------------------------------------------
 * Geeft de koppeling tussen toetsgebieden en kdw-gebieden terug.
 */
CREATE OR REPLACE VIEW critical_deposition_areas_to_assessment_areas_export_view AS
SELECT
	critical_deposition_areas_view.assessment_area_id,
	type,
	critical_deposition_area_id,
	name,
	description,
	critical_deposition,
	designated_habitats_view.habitat_type_id IS NOT NULL AS designated,
	relevant,
	sensitive,
	goal_habitat_type_id,
	goal_habitat_type_name,
	goal_habitat_type_description,
	geometry

	FROM critical_deposition_areas_view
		INNER JOIN critical_deposition_areas_goal_habitat_type_view USING (type, critical_deposition_area_id)
		LEFT JOIN designated_habitats_view ON critical_deposition_areas_view.assessment_area_id = designated_habitats_view.assessment_area_id
				AND critical_deposition_areas_view.critical_deposition_area_id = designated_habitats_view.habitat_type_id
;

/*
 * critical_deposition_areas_to_province_areas_export_view
 * -------------------------------------------------------
 * Geeft de koppeling tussen provincies en kdw-gebieden terug.
 */
CREATE OR REPLACE VIEW critical_deposition_areas_to_province_areas_export_view AS
SELECT
	province_area_id,
	assessment_area_id,
	type,
	critical_deposition_area_id,
	name,
	description,
	critical_deposition,
	designated,
	relevant,
	sensitive,
	goal_habitat_type_id,
	goal_habitat_type_name,
	goal_habitat_type_description,
	geometry

	FROM critical_deposition_areas_to_assessment_areas_export_view
		INNER JOIN assessment_areas_to_province_areas_view USING (assessment_area_id)
;
