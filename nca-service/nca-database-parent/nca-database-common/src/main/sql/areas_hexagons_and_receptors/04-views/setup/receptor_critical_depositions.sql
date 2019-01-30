/*
 * build_critical_depositions
 * --------------------------
 * View om de critical_depositions tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_critical_depositions AS
SELECT
	receptor_id,
	MIN(critical_deposition) AS critical_deposition

	FROM receptors_to_critical_deposition_areas
		INNER JOIN critical_deposition_areas_view USING (assessment_area_id, type, critical_deposition_area_id)

	WHERE type = 'relevant_habitat'

	GROUP BY receptor_id
;
