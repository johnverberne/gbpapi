/*
 * build_assessment_areas_to_province_areas_view
 * ---------------------------------------------
 * View om de assessment_areas_to_province_areas tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_assessment_areas_to_province_areas_view AS
SELECT
	province_area_id,
	assessment_area_id,
	ST_Distance(assessment_areas.geometry, province_areas.geometry)::posreal AS distance

	FROM assessment_areas
		INNER JOIN province_areas ON ST_DWithin(assessment_areas.geometry, province_areas.geometry, 30000)

	WHERE assessment_areas.type = 'natura2000_area'
;