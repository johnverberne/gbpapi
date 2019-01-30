SELECT ae_raise_notice('Build: assessment_areas_to_province_areas @ ' || timeofday());
BEGIN;
	INSERT INTO assessment_areas_to_province_areas(province_area_id, assessment_area_id, distance)
		SELECT province_area_id, assessment_area_id, distance
		FROM setup.build_assessment_areas_to_province_areas_view;
COMMIT;