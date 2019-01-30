/*
 * ae_validate_all
 * ---------------
 * Alle validatie functies draaien.
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
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_system_sectors');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_system_habitat_colors');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_habitat_type_critical_level');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_relevant_habitats');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_years');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_gcn_sector_years');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_gcn_sector_completeness_economic');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_farm_years');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_farm_emission_formal_ceilings');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_farm_lodgings');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_farm_completeness_other');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_farm_nema_tables');
	--PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_farm_emissions');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_setup_sectorgroups');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_sector_years');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_sector_completeness');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_deposition_space');
	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_receptor_data_completeness');

	PERFORM setup.ae_perform_and_report_validation('setup.ae_validate_rehabilitation_strategies');

	num_errors := (SELECT COUNT(*) FROM setup.validation_results WHERE validation_results.result = 'error' AND validation_results.validation_run_id = setup.ae_current_validation_run_id());
	num_warnings := (SELECT COUNT(*) FROM setup.validation_results WHERE validation_results.result = 'warning' AND validation_results.validation_run_id = setup.ae_current_validation_run_id());
	RAISE NOTICE '** Validation complete: % error(s), % warning(s).', num_errors, num_warnings;

	RETURN QUERY (SELECT * FROM setup.validation_results WHERE validation_results.validation_run_id = setup.ae_current_validation_run_id() ORDER BY validation_results.result DESC, validation_results.name);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_validate_years
 * -----------------
 * Valideert de jaren-tabel; het juiste aantal jaren per jaartype moet hier in staan. Bronjaar, landbouwbronjaar, en basisjaar mogen maar 1x voorkomen.
 * De jaren-tabel is de basis voor heel validaties.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_years()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating table years...';

	FOR rec IN
	SELECT
		year_category,
		COUNT(year) AS num_years

		FROM unnest(enum_range(NULL::year_category_type)) AS year_category
			LEFT JOIN years USING (year_category)

		WHERE year_category IN ('source', 'farm_source', 'base', 'last')

		GROUP BY year_category
		HAVING COUNT(year) <> 1
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'years',
			format('Year category %s must be present exactly one time, but is now present %s times.', rec.year_category, rec.num_years));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_rehabilitation_strategies
 * -------------------------------------
 * Valideert herstelmaatregelen. Deze moeten gekoppeld zijn aan een habitat en in een beheerplanperiode vallen.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_rehabilitation_strategies()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating rehabilitation strategies...';

	FOR rec IN
		SELECT DISTINCT rehabilitation_strategy_id FROM rehabilitation_strategies
		EXCEPT
		SELECT DISTINCT rehabilitation_strategy_id FROM rehabilitation_strategy_habitat_types
		ORDER BY rehabilitation_strategy_id
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'rehabilitation_strategy_habitat_types',
			format('rehabilitation strategy id %s has no habitat type', rec.rehabilitation_strategy_id));
	END LOOP;

	FOR rec IN
		SELECT DISTINCT rehabilitation_strategy_id FROM rehabilitation_strategies
		EXCEPT
		SELECT DISTINCT rehabilitation_strategy_id FROM rehabilitation_strategy_management_periods
		ORDER BY rehabilitation_strategy_id
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'rehabilitation_strategy_management_periods',
			format('rehabilitation strategy id %s has no management period', rec.rehabilitation_strategy_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
