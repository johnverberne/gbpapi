/*
 * build_assessment_areas_to_municipality_areas_view
 * -------------------------------------------------
 * View om de assessment_areas_to_municipality_areas tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_assessment_areas_to_municipality_areas_view AS
SELECT
	municipality_area_id,
	assessment_area_id,
	ST_Distance(assessment_areas.geometry, municipality_areas.geometry)::posreal AS distance

	FROM assessment_areas
		INNER JOIN authorities_view USING (authority_id)
		INNER JOIN municipality_areas ON ST_DWithin(assessment_areas.geometry, municipality_areas.geometry, 30000)

	WHERE
		assessment_areas.type = 'natura2000_area'
		AND foreign_authority IS FALSE
;


/*
 * build_assessment_areas_to_town_areas_view
 * -----------------------------------------
 * View om de assessment_areas_to_town_areas tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_assessment_areas_to_town_areas_view AS
SELECT
	town_area_id,
	assessment_area_id,
	ST_Distance(assessment_areas.geometry, town_areas.geometry)::posreal AS distance

	FROM assessment_areas
		INNER JOIN authorities_view USING (authority_id)
		INNER JOIN town_areas ON ST_DWithin(assessment_areas.geometry, town_areas.geometry, 30000)

	WHERE
		assessment_areas.type = 'natura2000_area'
		AND foreign_authority IS FALSE
;



/*
 * build_assessment_areas_to_zip_code_areas_view
 * ---------------------------------------------
 * View om de assessment_areas_to_zip_code_areas tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_assessment_areas_to_zip_code_areas_view AS
SELECT
	zip_code_area_id,
	assessment_area_id,
	ST_Distance(assessment_areas.geometry, zip_code_areas.geometry)::posreal AS distance

	FROM assessment_areas
		INNER JOIN authorities_view USING (authority_id)
		INNER JOIN zip_code_areas ON ST_DWithin(assessment_areas.geometry, zip_code_areas.geometry, 30000)

	WHERE
		assessment_areas.type = 'natura2000_area'
		AND foreign_authority IS FALSE
;
