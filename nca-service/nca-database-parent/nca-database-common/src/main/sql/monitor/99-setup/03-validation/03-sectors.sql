/*
 * ae_validate_sector_years
 * ------------------------
 * Valideert of de sector (economische groei en ontwikkelbehoefte) tabellen met een jaar erin, de exact juiste set van jaren bevatten.
 * (Bijv. alleen toekomst)
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_sector_years()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	table_name regclass;
BEGIN
	RAISE NOTICE '* Validating sector years...';

	FOREACH table_name IN ARRAY
		ARRAY['setup.sector_economic_growths', 'sector_economic_desires']
	LOOP
		RETURN QUERY SELECT * FROM setup.ae_validate_year_set(table_name, (SELECT array_agg(year::smallint) FROM years WHERE year_category = 'future'));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_setup_sectorgroups
 * ------------------------------
 * List setup sectorgroups which are not listed in the system enum.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_setup_sectorgroups()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating sectorgroups...';

	-- Determine which setup sectorgroup values are NOT present in the system enum.
	FOR rec IN
		SELECT * FROM unnest(enum_range(NULL::setup.sectorgroup)) AS setupsectorgroup
			LEFT JOIN unnest(enum_range(NULL::system.sectorgroup)) AS systemsectorgroup ON (setupsectorgroup::text = systemsectorgroup::text)
	LOOP
		IF rec.systemsectorgroup IS NULL THEN
			RETURN NEXT setup.ae_to_validation_result('error', NULL,
				format('Setup sectorgroup enum value "%s" was not found in the system sectorgroup enum', rec.setupsectorgroup));
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_sector_completeness
 * -------------------------------
 * Valideert of alle data op sectorniveau aanwezig zijn (dwz alle sectoren etc. staan er in).
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_sector_completeness()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of sector priority project economic desire limiter factor irt development demands...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.sector_priority_project_economic_growth_limiter_factors', 'years, sectors, substances',
			$$ year_category = 'future'
				AND (substance_id, sector_id) IN (SELECT DISTINCT substance_id, sector_id FROM setup.sector_priority_project_demands_growth) $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.sector_priority_project_economic_growth_limiter_factors',
			format('year %s, sector %s, substance %s, has no limiter factor (but does have development demands)', rec.year, rec.sector_id, rec.substance_id));
	END LOOP;

	RAISE NOTICE '* Validating completeness of sector economic growths...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.sector_economic_growths', 'years, sectors',
				$$ year_category = 'future' AND sector_id IN (SELECT DISTINCT sector_id FROM gcn_sectors) $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.sector_economic_growths',
			format('year %s, sector %s, has no values', rec.year, rec.sector_id));
	END LOOP;

	RAISE NOTICE '* Validating completeness of sector economic desires...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('sector_economic_desires', 'years, sectors',
				$$ year_category = 'future' AND sector_id IN (SELECT DISTINCT sector_id FROM gcn_sectors) $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'sector_economic_desires',
			format('year %s, sector %s, has no values', rec.year, rec.sector_id));
	END LOOP;

	RAISE NOTICE '* Validating completeness of sector deposition space segmentations...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.sector_deposition_space_segmentations', 'sectors')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.sector_deposition_space_segmentations',
			format('sector %s, has no value', rec.sector_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
