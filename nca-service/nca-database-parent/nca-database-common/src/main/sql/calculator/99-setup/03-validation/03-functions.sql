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

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_background_cells');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_receptor_completeness');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_all_imaer_data');

	num_errors := (SELECT COUNT(*) FROM setup.validation_results WHERE validation_results.result = 'error' AND validation_results.validation_run_id = setup.ae_current_validation_run_id());
	num_warnings := (SELECT COUNT(*) FROM setup.validation_results WHERE validation_results.result = 'warning' AND validation_results.validation_run_id = setup.ae_current_validation_run_id());
	RAISE NOTICE '** Validation complete: % error(s), % warning(s).', num_errors, num_warnings;

	RETURN QUERY (SELECT * FROM setup.validation_results WHERE validation_results.validation_run_id = setup.ae_current_validation_run_id() ORDER BY validation_results.result DESC, validation_results.name);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_validate_farm_completeness
 * -----------------------------
 * Valideert de emissiefactoren van stalsystemen. Exceptie als er geen factor is bij een stalsysteem.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_completeness()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of farm lodging type emission factors...';

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_lodging_type_emission_factors', 'substances, farm_lodging_types', $$ substance_id = 17 $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_lodging_type_emission_factors',
			format('substance %s, farm lodging type %s has no emission factors', rec.substance_id, rec.farm_lodging_types));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_background_cells
 * ----------------------------
 * Valideert de deposities en concentraties van achtergrondcellen.
 * Exceptie als niet alle jaren of stoffen aanwezig zijn, of als voor de aanwezige jaren/stoffen niet alle achtergrondcellen aanwezig zijn.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_background_cells()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	v_expected_num_cells integer;
BEGIN
	RAISE NOTICE '* Validating completeness of background cells data...';

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('background_cell_depositions', 'setup.system_years_view', NULL, 'year')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'background_cell_depositions',
			format('year %s has no depositions', rec.year));
	END LOOP;
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('background_cell_concentrations', 'setup.system_years_view, substances', $$ substance_id IN (7, 10, 11, 14, 15) $$, 'year, substance_id')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('warning', 'background_cell_concentrations',
			format('year %s, substance %s has no concentrations', rec.year, rec.substance_id));
	END LOOP;

	v_expected_num_cells := (SELECT COUNT(background_cell_id) FROM background_cells);

	FOR rec IN
	SELECT
		year,
		COUNT(background_cell_id) AS num_cells

		FROM background_cell_depositions

		GROUP BY year
		ORDER BY year
	LOOP
		IF rec.num_cells <> v_expected_num_cells THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'background_cell_depositions',
				format('Incorrect background cell count within (background_cell_depositions) for year=%s; found %s, expected %s', rec.year, rec.num_cells, v_expected_num_cells));
		END IF;
	END LOOP;
	
	FOR rec IN
	SELECT
		ARRAY[substance_id, year]::text[] AS key_values,
		COUNT(background_cell_id) AS num_cells

		FROM background_cell_concentrations

		GROUP BY substance_id, year
		ORDER BY substance_id, year
	LOOP
		IF rec.num_cells <> v_expected_num_cells THEN
			RETURN NEXT setup.ae_to_validation_result('warning', 'background_cell_concentrations',
				format('Incorrect background cell count within background_cell_concentrations for keys (substance_id, year)=%s; found %s, expected %s', rec.key_values, rec.num_cells, v_expected_num_cells));
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_receptor_completeness
 * ---------------------------------
 * Valideert de achtergronddepositie. Exceptie als niet alle jaren aanwezig zijn, of als voor de aanwezige jaren niet alle receptoren aanwezig zijn.
 * @todo er zijn te weinig receptoren omdat er geen achtergronddepositie voor buitenlandse gebieden is.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_receptor_completeness()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	v_expected_num_receptors integer;
BEGIN
	RAISE NOTICE '* Validating completeness of depositions jurisdiction policies...';

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('depositions_jurisdiction_policies', 'setup.system_years_view', NULL, 'year')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'depositions_jurisdiction_policies',
			format('year %s has no depositions', rec.year));
	END LOOP;

	RETURN QUERY SELECT * FROM setup.ae_validate_completeness_receptors('depositions_jurisdiction_policies', TRUE);
END;
$BODY$
LANGUAGE plpgsql STABLE;



/*
 * ae_validate_imaer_data
 * ----------------------
 * Validate the data for a specific IMAER domain table. These should not have spaces in the code column.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_imaer_data(table_to_validate regclass)
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	FOR rec IN
		EXECUTE 'SELECT code FROM ' || table_to_validate || ' WHERE code ilike ''% %'''
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', table_to_validate,
			format('Code (%s) contained a space.', rec.code));
	END LOOP;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_all_imaer_data
 * --------------------------
 * Validate the data for all IMAER domain tables. These should not have spaces in the code column.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_all_imaer_data()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('farm_lodging_types');
	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('farm_lodging_system_definitions');
	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('farm_additional_lodging_systems');
	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('farm_reductive_lodging_systems');
	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('farm_lodging_fodder_measures');

	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('mobile_source_off_road_categories');

	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('plan_categories');

	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('mobile_source_on_road_categories');

	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('shipping_inland_categories');
	RETURN QUERY SELECT * FROM setup.ae_validate_imaer_data('shipping_maritime_categories');
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
