SELECT ae_raise_notice('Build: receptors_to_critical_deposition_areas @ ' || timeofday());
BEGIN;
	INSERT INTO receptors_to_critical_deposition_areas(assessment_area_id, type, critical_deposition_area_id, receptor_id, surface, coverage)
		SELECT assessment_area_id, type, critical_deposition_area_id, receptor_id, surface, coverage
		FROM setup.build_receptors_to_critical_deposition_areas_view;
COMMIT;
