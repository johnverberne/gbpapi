/*
 * build_receptors_to_assessment_areas_view
 * ----------------------------------------
 * View om de receptors_to_assessment_areas tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_receptors_to_assessment_areas_view AS
SELECT 
	assessment_area_id, 
	(setup.ae_determine_hexagon_intersections(geometry)).receptor_id, 
	(setup.ae_determine_hexagon_intersections(geometry)).surface 

	FROM assessment_areas
	
	WHERE assessment_areas.type = 'natura2000_area'
;


/*
 * build_included_receptors_view
 * -----------------------------
 * View om de included_receptors tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_included_receptors_view AS
SELECT DISTINCT
	receptor_id

	FROM receptors_to_critical_deposition_areas

	WHERE type = 'relevant_habitat'
;


/*
 * build_receptors_to_critical_deposition_areas_view
 * -------------------------------------------------
 * View om de receptors_to_critical_deposition_areas tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_receptors_to_critical_deposition_areas_view AS
SELECT
	assessment_area_id,
	type,
	critical_deposition_area_id,
	(setup.ae_determine_hexagon_intersections(geometry)).receptor_id,
	(setup.ae_determine_hexagon_intersections(geometry)).surface,
	coverage -- overnemen van critical_deposition_areas

	FROM critical_deposition_areas_view
;
