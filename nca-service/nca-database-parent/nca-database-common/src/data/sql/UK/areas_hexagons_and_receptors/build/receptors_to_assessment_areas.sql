SELECT ae_raise_notice('Build: receptors_to_assessment_areas @ ' || timeofday());
BEGIN;
	INSERT INTO receptors_to_assessment_areas(receptor_id, assessment_area_id, surface)
		SELECT receptor_id, assessment_area_id, surface
		FROM setup.build_receptors_to_assessment_areas_view;
COMMIT;