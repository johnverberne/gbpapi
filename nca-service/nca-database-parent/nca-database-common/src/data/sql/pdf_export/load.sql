SELECT ae_raise_notice('Build: pdf_export_receptors_to_assessment_areas @ ' || timeofday());
BEGIN;
	INSERT INTO pdf_export_receptors_to_assessment_areas(receptor_id, assessment_area_id, pas_area, exceeding)
		SELECT receptor_id, assessment_area_id, pas_area, exceeding
		FROM setup.build_pdf_export_receptors_to_assessment_areas_view;
COMMIT;