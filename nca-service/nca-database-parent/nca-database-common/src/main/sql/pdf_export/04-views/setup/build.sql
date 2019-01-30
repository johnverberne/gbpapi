/*
 * build_pdf_export_receptors_to_assessment_areas_view
 * ---------------------------------------------------
 * View om de pdf_export_receptors_to_assessment_areas tabel te vullen. Deze bevat de relevante pdf receptoren per natuurgebied.
 *
 */
CREATE OR REPLACE VIEW setup.build_pdf_export_receptors_to_assessment_areas_view AS
SELECT
	receptor_id,
	assessment_area_id,
	TRUE AS pas_area,
	non_exceeding_receptors.receptor_id IS NULL AS exceeding

	FROM (SELECT DISTINCT receptor_id FROM reserved_development_spaces) AS receptors
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		INNER JOIN pas_assessment_areas USING (assessment_area_id)
		LEFT JOIN non_exceeding_receptors USING (receptor_id)
UNION ALL
SELECT
	receptor_id,
	assessment_area_id,
	FALSE AS pas_area,
	FALSE AS exceeding

	FROM included_receptors
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		LEFT JOIN pas_assessment_areas USING (assessment_area_id)

	WHERE pas_assessment_areas.assessment_area_id IS NULL
;