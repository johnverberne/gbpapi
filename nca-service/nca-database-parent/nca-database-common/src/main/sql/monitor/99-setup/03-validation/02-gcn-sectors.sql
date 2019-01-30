/*
 * ae_validate_gcn_sector_years
 * ----------------------------
 * Valideert of de GCN sector (schaal- en groeifactoren) tabellen met een jaar erin, de exact juiste set van jaren bevatten. (Bijv. alleen toekomst)
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_gcn_sector_years()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	table_name regclass;
BEGIN
	RAISE NOTICE '* Validating GCN sector years...';

	FOREACH table_name IN ARRAY
		ARRAY['setup.gcn_sector_economic_scale_factors']
	LOOP
		RETURN QUERY SELECT * FROM setup.ae_validate_year_set(table_name, (SELECT array_agg(year::smallint) FROM years WHERE year_category IN ('base', 'last')));
	END LOOP;

	FOREACH table_name IN ARRAY
		ARRAY['setup.gcn_sector_economic_scale_factors_no_economy', 'setup.gcn_sector_economic_growth_factors', 'setup.gcn_sector_economic_growth_factor_corrections']
	LOOP
		RETURN QUERY SELECT * FROM setup.ae_validate_year_set(table_name, (SELECT array_agg(year::smallint) FROM years WHERE year_category = 'future'));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_gcn_sector_completeness_economic
 * --------------------------------------------
 * Valideert of alle economische groei schaalfactoren en groeifactoren aanwezig zijn.
 * De GCN-sectoren per stof in setup.gcn_sector_economic_scale_factors zijn hierbij leidend voor de andere tabellen.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_gcn_sector_completeness_economic()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of GCN-sector economic scale factors...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.gcn_sector_economic_scale_factors', 'years, substances',
			$$ (substance_id = 11 OR substance_id = 17) AND year_category IN ('base', 'last') $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.gcn_sector_economic_scale_factors',
			format('year %s, substance %s, has no scale factor', rec.year, rec.substance_id));
	END LOOP;

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.gcn_sector_economic_scale_factors_no_economy', 'years, gcn_sectors, substances',
			$$ year_category = 'future'
				AND (substance_id, gcn_sector_id) IN (SELECT DISTINCT substance_id, gcn_sector_id FROM setup.gcn_sector_economic_scale_factors) $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.gcn_sector_economic_scale_factors_no_economy',
			format('year %s, GCN-sector %s, substance %s, has no scale factor', rec.year, rec.gcn_sector_id, rec.substance_id));
	END LOOP;

	RAISE NOTICE '* Validating completeness of GCN-sector economic growth factors...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.gcn_sector_economic_growth_factors', 'years, gcn_sectors, substances',
			$$ year_category = 'future'
				AND (substance_id, gcn_sector_id) IN (SELECT DISTINCT substance_id, gcn_sector_id FROM setup.gcn_sector_economic_scale_factors) $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.gcn_sector_economic_growth_factors',
			format('year %s, GCN-sector %s, substance %s, has no growth factor', rec.year, rec.gcn_sector_id, rec.substance_id));
	END LOOP;

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.gcn_sector_economic_growth_factor_corrections', 'years, gcn_sectors, substances',
			$$ year_category = 'future'
				AND (substance_id, gcn_sector_id) IN (SELECT DISTINCT substance_id, gcn_sector_id FROM setup.gcn_sector_economic_growth_factors) $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.gcn_sector_economic_growth_factor_corrections',
			format('year %s, GCN-sector %s, substance %s, has no growth factor correction', rec.year, rec.gcn_sector_id, rec.substance_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
