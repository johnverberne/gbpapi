/*
 * ae_validate_farm_nema_tables
 * ----------------------------
 * Valideert of alle nema-clusters (farm_nema_clusters) gekoppeld zijn aan een nema-diercategorie (farm_nema_categories) en een RAV (farm_lodging_types).
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_nema_tables()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	v_expected_num_cells integer;
	v_num_cells integer;
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of nema table data...';

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_lodging_types', 'farm_nema_clusters')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_lodging_types',
			format('farm nema cluster id %s has no farm lodging type', rec.farm_nema_cluster_id));
	END LOOP;

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_nema_categories', 'farm_nema_clusters')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_nema_categories',
			format('farm nema cluster id %s has no farm nema category', rec.farm_nema_cluster_id));
	END LOOP;

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_nema_category_emissions', 'farm_nema_categories')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_nema_category_emissions',
			format('farm nema category id %s has no farm nema category emission', rec.farm_nema_category_id));
	END LOOP;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_farm_years
 * ----------------------
 * Valideert of de landbouw tabellen met een jaar erin, de exact juiste set van jaren bevatten. (Bijv. alleen toekomst)
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_years()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	table_name regclass;
BEGIN
	RAISE NOTICE '* Validating farm years...';

	FOREACH table_name IN ARRAY
		ARRAY['farm_emission_formal_ceilings_global_policies', 'farm_emission_formal_ceilings_jurisdiction_policies',
			'farm_emission_ceilings_no_policies', 'farm_emission_ceilings_global_policies', 'farm_emission_ceilings_jurisdiction_policies',
			'farm_emission_correction_factors_fodder', 'setup.farm_substitution_fractions']
	LOOP
		RETURN QUERY SELECT * FROM setup.ae_validate_year_set(table_name, (SELECT array_agg(year::smallint) FROM years WHERE year_category = 'future'));
	END LOOP;

	FOREACH table_name IN ARRAY
		ARRAY['farm_animal_category_economic_growths']
	LOOP
		RETURN QUERY SELECT * FROM setup.ae_validate_year_set(table_name, (SELECT array_agg(year::smallint) FROM years WHERE year_category IN ('base', 'future')));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_farm_emission_formal_ceilings
 * -----------------------------------------
 * Valideert de emissieplafonds en bijbehorende tabellen.
 * Het wettelijk en berekend emissieplafond moet gelijk blijven of lager worden naarmate het beleidsscenario strenger wordt.
 * Idem voor ieder 'latere' jaar.
 * Verder moet voor elke emissieplafond-categorie, stof, en basis+toekomstjaar er een vervangingswaarde zijn.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_emission_formal_ceilings()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	ceiling_table_name regclass;
BEGIN
	/*RAISE NOTICE '* Validating completeness of (calculated & formal) farm emission ceilings...';
	FOREACH ceiling_table_name IN ARRAY
		ARRAY['farm_emission_formal_ceilings_no_policies', 'farm_emission_formal_ceilings_global_policies', 'farm_emission_formal_ceilings_jurisdiction_policies',
			'farm_emission_ceilings_no_policies', 'farm_emission_ceilings_global_policies', 'farm_emission_ceilings_jurisdiction_policies']
	LOOP
		FOR rec IN
			EXECUTE setup.ae_validate_get_completeness_sql(ceiling_table_name, 'farm_animal_categories, years, substances',
				$$ substance_id = 17 AND year_category = 'future' $$)
		LOOP
			RETURN NEXT setup.ae_to_validation_result('error', ceiling_table_name,
				format('farm emission ceiling category %s, year %s, substance %s, has no emission ceiling', rec.farm_emission_ceiling_category_id, rec.year, rec.substance_id));
		END LOOP;
	END LOOP;*/

	RAISE NOTICE '* Validating decreasing (calculated & formal) farm emission ceilings over years...';
	FOREACH ceiling_table_name IN ARRAY
		ARRAY['farm_emission_formal_ceilings_global_policies', 'farm_emission_formal_ceilings_jurisdiction_policies',
			'farm_emission_ceilings_no_policies', 'farm_emission_ceilings_global_policies', 'farm_emission_ceilings_jurisdiction_policies']
	LOOP
		RETURN QUERY SELECT * FROM setup.ae_validate_declining_over_years(ceiling_table_name);
	END LOOP;

	RAISE NOTICE '* Validating decreasing farm emission formal ceilings over policies...';
	FOR rec IN SELECT
		farm_emission_ceiling_category_id,
		year,
		substance_id,
		jurisdiction_id,
		np.emission_ceiling AS emission_ceiling_np,
		gp.emission_ceiling AS emission_ceiling_gp,
		jp.emission_ceiling AS emission_ceiling_jp

		FROM farm_emission_formal_ceilings_no_policies AS np
			FULL OUTER JOIN farm_emission_formal_ceilings_global_policies AS gp USING (farm_emission_ceiling_category_id, substance_id)
			FULL OUTER JOIN farm_emission_formal_ceilings_jurisdiction_policies AS jp USING (farm_emission_ceiling_category_id, year, substance_id)

		WHERE jp.emission_ceiling > gp.emission_ceiling OR gp.emission_ceiling > np.emission_ceiling  -- Catch increasing values; skips NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_emission_formal_ceilings_global_policies',
			format('Non-declining farm emission formal ceiling, category %s, year %s, substance %s, jurisdiction %s: np %s, gp %s, jp %s', rec.farm_emission_ceiling_category_id, rec.year, rec.substance_id, rec.jurisdiction_id, rec.emission_ceiling_np, rec.emission_ceiling_gp, rec.emission_ceiling_jp));
	END LOOP;

	RAISE NOTICE '* Validating decreasing farm emission ceilings over policies...';
	FOR rec IN SELECT
		farm_emission_ceiling_category_id,
		year,
		substance_id,
		jurisdiction_id,
		np.emission_ceiling AS emission_ceiling_np,
		gp.emission_ceiling AS emission_ceiling_gp,
		jp.emission_ceiling AS emission_ceiling_jp

		FROM farm_emission_ceilings_no_policies AS np
			FULL OUTER JOIN farm_emission_ceilings_global_policies AS gp USING (farm_emission_ceiling_category_id, year, substance_id)
			FULL OUTER JOIN farm_emission_ceilings_jurisdiction_policies AS jp USING (farm_emission_ceiling_category_id, year, substance_id)

		WHERE jp.emission_ceiling > gp.emission_ceiling OR gp.emission_ceiling > np.emission_ceiling  -- Catch increasing values; skips NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_emission_ceilings_global_policies',
			format('Non-declining farm emission ceiling, category %s, year %s, substance %s, jurisdiction %s: np %s, gp %s, jp %s', rec.farm_emission_ceiling_category_id, rec.year, rec.substance_id, rec.jurisdiction_id, rec.emission_ceiling_np, rec.emission_ceiling_gp, rec.emission_ceiling_jp));
	END LOOP;

	RAISE NOTICE '* Validating completeness of farm substitution fractions...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('setup.farm_substitution_fractions', 'farm_emission_ceiling_categories, years, substances',
			$$ substance_id = 17 AND year_category = 'future' $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'setup.farm_substitution_fractions',
			format('farm emission ceiling category %s, year %s, substance %s, has no substitution fraction', rec.farm_emission_ceiling_category_id, rec.year, rec.substance_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_farm_lodgings
 * -------------------------
 * Valideert de staltypes.
 * Elk staltype moet een emissiefactor hebben.
 * Elke landbouwbron moet minimaal een staltype hebben.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_lodgings()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of farm lodging type emission factors...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_lodging_type_emission_factors', 'farm_lodging_types, substances',
			$$ substance_id = 17 $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_lodging_type_emission_factors',
			format('farm lodging type %s, substance %s, has no emission factor', rec.farm_lodging_type_id, rec.substance_id));
	END LOOP;

	RAISE NOTICE '* Validating completeness of farm source lodging types...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_source_lodging_types', 'farm_sources')
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_source_lodging_types',
			format('farm source %s, has no lodging type', rec.source_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_farm_completeness_other
 * -----------------------------------
 * Valideert de overige landbouw tabellen op compleetheid.
 * Elke diercategorie moet voor ieder jaar een economische groei hebben.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_completeness_other()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of farm animal category economic growths...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_animal_category_economic_growths', 'years, farm_animal_categories',
			$$ year_category IN ('base', 'future') $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_animal_category_economic_growths',
			format('farm animal category %s, year %s, has no economic growth', rec.farm_animal_category_id, rec.year));
	END LOOP;

	RAISE NOTICE '* Validating completeness of farm emission fodder corrections...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_emission_correction_factors_fodder', 'years, farm_animal_categories, substances',
			$$ substance_id = 17
				AND year_category = 'future'
				AND farm_animal_category_id IN (SELECT farm_animal_category_id FROM farm_animal_categories WHERE name ILIKE 'A1%s' OR name ILIKE 'A3%s') $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_emission_correction_factors_fodder',
			format('farm animal category %s, year %s, substance %s, has no fodder correction factor', rec.farm_animal_category_id, rec.year, rec.substance_id));
	END LOOP;

	RAISE NOTICE '* Validating completeness of farm emission grazing corrections...';
	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_emission_correction_factors_grazing', 'jurisdictions, farm_animal_categories, substances',
			$$ substance_id = 17 AND farm_animal_categories.name ILIKE 'A1%s' $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_emission_correction_factors_grazing',
			format('jurisdiction %s, farm animal category %s, substance %s, has no grazing correction factor', rec.jurisdiction_id, rec.farm_animal_category_id, rec.substance_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_farm_emissions
 * --------------------------
 * De berekende emissies moeten gelijk blijven of minder worden naarmate het beleidsscenario strenger wordt.
 * Tevens moet dit zo zijn voor ieder 'latere' jaar.
 * Test eerst met alle correcties uit, dan nog eens met alles aan.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_emissions()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	adjustments boolean;
	use_calculation_ceilings boolean;
	rec record;
BEGIN
	FOREACH adjustments IN ARRAY
		ARRAY[FALSE, TRUE]
	LOOP
		FOREACH use_calculation_ceilings IN ARRAY
			ARRAY[TRUE, FALSE]
		LOOP
			CREATE TEMPORARY TABLE tmp_validate_farm_emissions ON COMMIT DROP AS
			SELECT policy_type, farm_emissions.*
				FROM (SELECT unnest(enum_range(NULL::policy_type)) AS policy_type) AS policy_types
					CROSS JOIN years
					CROSS JOIN ae_farm_emissions(year, (SELECT array_agg(source_id) FROM farm_sources), policy_type, adjustments, adjustments, adjustments, adjustments, adjustments, use_calculation_ceilings, FALSE) AS farm_emissions

				WHERE year_category IN ('farm_source', 'base', 'last', 'future')
			;

			-- Check whether emissions are declining between all policy types
			RAISE NOTICE '* Validating decreasing farm emissions over policies...';
			FOR rec IN
			SELECT
				year,
				source_id,
				site_id,
				np.emission AS emission_np,
				gp.emission AS emission_gp,
				jp.emission AS emission_jp

				FROM (SELECT * FROM tmp_validate_farm_emissions WHERE policy_type = 'no_policies') AS np
					FULL OUTER JOIN (SELECT * FROM tmp_validate_farm_emissions WHERE policy_type = 'global_policies') AS gp USING (year, source_id, site_id)
					FULL OUTER JOIN (SELECT * FROM tmp_validate_farm_emissions WHERE policy_type = 'jurisdiction_policies') AS jp USING (year, source_id, site_id)

				WHERE
					np.emission IS NULL OR gp.emission IS NULL OR jp.emission IS NULL OR -- Catch NULLs
					jp.emission > gp.emission OR gp.emission > np.emission  -- Catch increasing values
			LOOP
				RETURN NEXT setup.ae_to_validation_result('error', 'tmp_validate_farm_emissions',
					format('Non-declining farm emissions for year %s, source %s, site %s: np %s, gp %s, jp %s', rec.year, rec.source_id, rec.site_id, rec.emission_np, rec.emission_gp, rec.emission_jp));
			END LOOP;

			-- Check whether emissions are declining from year to year
			RAISE NOTICE '* Validating decreasing farm emissions over years...';
			RETURN QUERY SELECT * FROM setup.ae_validate_declining_over_years('tmp_validate_farm_emissions', 'emission', 'policy_type, source_id, site_id, substance_id');

			DROP TABLE tmp_validate_farm_emissions;
		END LOOP;
	END LOOP;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
