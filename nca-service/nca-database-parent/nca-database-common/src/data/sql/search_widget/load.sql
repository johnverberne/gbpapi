BEGIN; SELECT setup.ae_load_table('municipality_areas', '{data_folder}/public/municipality_areas_20180420.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('town_areas', '{data_folder}/public/town_areas_20140910.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('zip_code_areas', '{data_folder}/public/zip_code_areas_20130424.txt'); COMMIT;


/* Linking assessment areas with search widget areas like province or zip code can be done on the fly, but takes a long time.

SELECT ae_raise_notice('Build: assessment_areas_to_municipality_areas @ ' || timeofday());
BEGIN;
	INSERT INTO assessment_areas_to_municipality_areas(municipality_area_id, assessment_area_id, distance)
		SELECT municipality_area_id, assessment_area_id, distance
		FROM setup.build_assessment_areas_to_municipality_areas_view;
COMMIT;

SELECT ae_raise_notice('Build: assessment_areas_to_town_areas @ ' || timeofday());
BEGIN;
	INSERT INTO assessment_areas_to_town_areas(town_area_id, assessment_area_id, distance)
		SELECT town_area_id, assessment_area_id, distance
		FROM setup.build_assessment_areas_to_town_areas_view;
COMMIT;

SELECT ae_raise_notice('Build: assessment_areas_to_zip_code_areas @ ' || timeofday());
BEGIN;
	INSERT INTO assessment_areas_to_zip_code_areas(zip_code_area_id, assessment_area_id, distance)
		SELECT zip_code_area_id, assessment_area_id, distance
		FROM setup.build_assessment_areas_to_zip_code_areas_view;
COMMIT;

*/

BEGIN; SELECT setup.ae_load_table('assessment_areas_to_municipality_areas', '{data_folder}/public/assessment_areas_to_municipality_areas_20180722.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('assessment_areas_to_town_areas', '{data_folder}/public/assessment_areas_to_town_areas_20180722.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('assessment_areas_to_zip_code_areas', '{data_folder}/public/assessment_areas_to_zip_code_areas_20180722.txt'); COMMIT;