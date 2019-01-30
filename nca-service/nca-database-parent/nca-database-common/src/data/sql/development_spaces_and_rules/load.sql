BEGIN; SELECT setup.ae_load_table('reserved_development_spaces', '{data_folder}/temp/temp_reserved_development_spaces_20181008.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('non_exceeding_receptors', '{data_folder}/public/non_exceeding_receptors_20181008.txt'); COMMIT;


SELECT ae_raise_notice('Build: development_rules_constants @ ' || timeofday());
BEGIN;
	INSERT INTO development_rules_constants
		SELECT 'max_development_space_demand_check'::development_rule_type, assessment_area_id, 3.0
			FROM natura2000_areas
				INNER JOIN authorities_view USING (authority_id)
			WHERE foreign_authority IS FALSE
	;
COMMIT;


SELECT ae_raise_notice('Build: development_spaces @ ' || timeofday());
BEGIN;
	INSERT INTO development_spaces(segment, status, receptor_id, space)
		SELECT segment, status, receptor_id, space
		FROM setup.build_development_spaces_view;
COMMIT;


SELECT ae_raise_notice('Build: permit_threshold_values @ ' || timeofday());
BEGIN;
	INSERT INTO permit_threshold_values(assessment_area_id, value)
		SELECT assessment_area_id, value
		FROM setup.build_permit_threshold_values_view;
COMMIT;
