/*
 * ae_validate_all
 * ---------------
 * Alle validaties uitvoeren. Kan aangeroepen worden vanuit het buildscript.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_all()
	RETURNS TABLE (validaton_result_id integer, validation_run_id integer, name regproc, result setup.validation_result_type) AS
$BODY$
DECLARE
	num_errors integer;
	num_warnings integer;
BEGIN
	RAISE NOTICE '** Validating all...';

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_tables_not_empty');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_incorrect_imports');
	--PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_geometries');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_sector_source_characteristics');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_shipping_source_characteristics');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_plan_source_characteristics');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_road_emission_factors');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_shipping_emission_factors');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_farm_completeness');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_system_sectors');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_system_habitat_colors');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_habitat_type_critical_level');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_relevant_habitats');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_all_relevant_receptors_in_pas_assessment_areas');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_authorities');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_permit_review_against_development_space_rules');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_development_space_receptor_completeness');

	num_errors := (SELECT COUNT(*) FROM setup.validation_results WHERE validation_results.result = 'error' AND validation_results.validation_run_id = setup.ae_current_validation_run_id());
	num_warnings := (SELECT COUNT(*) FROM setup.validation_results WHERE validation_results.result = 'warning' AND validation_results.validation_run_id = setup.ae_current_validation_run_id());
	RAISE NOTICE '** Validation complete: % error(s), % warning(s).', num_errors, num_warnings;

	RETURN QUERY (SELECT * FROM setup.validation_results WHERE validation_results.validation_run_id = setup.ae_current_validation_run_id() ORDER BY validation_results.result DESC, validation_results.name);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_validate_authorities
 * -----------------------
 * Valideert de e-mail adressen behorende bij de bevoegde gezagen: alle(en) provincies moeten e-mail adressen hebben en er mogen alleen dummy waarden staan.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_authorities()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating authorities ...';

	FOR rec IN SELECT * FROM register_authorities_view
	LOOP
		IF rec.email_address IS NULL AND rec.type = 'province' THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'authority_email_addresses',
				format('authority %s (%s) is a province but has no associated e-mail address', rec.authority_id, rec.name));
		ELSIF rec.email_address IS NOT NULL AND rec.type <> 'province' THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'authority_email_addresses',
				format('authority %s (%s) should not have an associated e-mail address (%s) because it is not a province', rec.authority_id, rec.name, rec.email_address));
		ELSIF rec.email_address IS NOT NULL AND position('aeriusmail' in rec.email_address) = 0 THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'authority_email_addresses',
				format('authority %s (%s) does not seem to have a dummy e-mail address (%s)', rec.authority_id, rec.name, rec.email_address));
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_permit_review_against_development_space_rules
 * ---------------------------------------------------------
 * Valideert dat de uitkomst van {@link permit_assessment_area_review_info_view}, welke wordt getoond op het Toetsing-tabblad, overeenkomt met
 * {@link ae_development_rule_request_checks}, welke getoond wordt op het OR-tabblad.
 * Er worden twee representatieve test-permits genomen. De ene heeft één situatieberekening, de andere twee.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_permit_review_against_development_space_rules()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	v_request_id integer;
	rec record;
BEGIN
	RAISE NOTICE '* Validating permit review against development space rules ...';

	FOR v_request_id IN SELECT unnest(ARRAY[1, 8]) AS request_id
	LOOP
		FOR rec IN
			WITH review_tab AS (
				SELECT
					assessment_area_id,
					shortage_count_inclusive AS shortage

					FROM permit_assessment_area_review_info_view

					WHERE request_id = v_request_id AND NOT only_exceeding
			),
			development_space_tab AS (
				SELECT
					assessment_area_id,
					COUNT(*) AS shortage

					FROM ae_development_rule_request_checks(v_request_id, 'projects')
						INNER JOIN receptors_to_assessment_areas USING (receptor_id)
						INNER JOIN pas_assessment_areas USING (assessment_area_id)

					WHERE NOT passed

					GROUP BY assessment_area_id
			)
			SELECT
				assessment_area_id,
				review_tab.shortage AS shortage_review,
				development_space_tab.shortage AS shortage_development_space

				FROM review_tab
					FULL OUTER JOIN development_space_tab USING (assessment_area_id)

				WHERE COALESCE(review_tab.shortage, 0) <> COALESCE(development_space_tab.shortage, 0)
		LOOP
			RETURN NEXT setup.ae_to_validation_result('error', 'permit_assessment_area_review_info_view',
				format('mismatch between shortage count of permit_assessment_area_review_info_view (%s) compared to ae_development_rule_request_checks (%s) in assessment area %s', rec.shortage_review, rec.shortage_development_space, rec.assessment_area_id));
		END LOOP;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_development_space_receptor_completeness
 * ---------------------------------------------------
 * Validates that all development space receptor tables have the same number of receptors per segment (and status).
 * This is to ensure we can always do INNER JOINs between such tables.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_development_space_receptor_completeness()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	v_expected_num_receptors integer;
	v_segment segment_type;
BEGIN
	RAISE NOTICE '* Validating completeness of receptors in development space tables...';

	v_expected_num_receptors := (SELECT COUNT(receptor_id) FROM reserved_development_spaces WHERE segment = 'projects');

	FOR v_segment IN (SELECT DISTINCT segment FROM reserved_development_spaces)
	LOOP
		IF v_expected_num_receptors <> (SELECT COUNT(receptor_id) FROM reserved_development_spaces WHERE segment = v_segment) THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'reserved_development_spaces',
				format('expected amount of receptors (%s) for segment "%s" not present', v_expected_num_receptors, v_segment));
		END IF;
		IF v_expected_num_receptors <> (SELECT COUNT(receptor_id) FROM initial_available_development_spaces WHERE segment = v_segment) THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'initial_available_development_spaces',
				format('expected amount of receptors (%s) for segment "%s" not present', v_expected_num_receptors, v_segment));
		END IF;
		IF v_expected_num_receptors <> (SELECT COUNT(receptor_id) FROM development_spaces WHERE segment = v_segment AND status = 'assigned') THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'development_spaces',
				format('expected amount of receptors (%s) for segment "%s" and status "assigned" not present', v_expected_num_receptors, v_segment));
		END IF;
		IF v_segment = 'projects' THEN
			IF v_expected_num_receptors <> (SELECT COUNT(receptor_id) FROM development_spaces WHERE segment = v_segment AND status = 'pending_with_space') THEN
				RETURN NEXT setup.ae_to_validation_result('error', 'development_spaces',
					format('expected amount of receptors (%s) for segment "%s" and status "pending_with_space" not present', v_expected_num_receptors, v_segment));
			END IF;
			IF v_expected_num_receptors <> (SELECT COUNT(receptor_id) FROM development_spaces WHERE segment = v_segment AND status = 'pending_without_space') THEN
				RETURN NEXT setup.ae_to_validation_result('error', 'development_spaces',
					format('expected amount of receptors (%s) for segment "%s" and status "pending_without_space" not present', v_expected_num_receptors, v_segment));
			END IF;
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;

