/*
 * ae_farm_emissions_no_policies
 * -----------------------------
 * Functie voor het bepalen en toesten van de landbouw emissies volgens vaststaand beleid.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_no_policies(v_year year_type, v_source_list integer[])
	RETURNS TABLE(year year_type, site_id integer, source_id integer, farm_lodging_type_id integer, substance_id smallint, emission posreal) AS
$BODY$
BEGIN
	RETURN QUERY SELECT * FROM ae_farm_emissions(v_year, v_source_list, 'no_policies'::policy_type);

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions_global_policies
 * ---------------------------------
 * Functie voor het bepalen en toesten van de landbouw emissies volgens rijksbeleid.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_global_policies(v_year year_type, v_source_list integer[])
	RETURNS TABLE(year year_type, site_id integer, source_id integer, farm_lodging_type_id integer, substance_id smallint, emission posreal) AS
$BODY$
BEGIN
	RETURN QUERY SELECT * FROM ae_farm_emissions(v_year, v_source_list, 'global_policies'::policy_type);

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions_jurisdiction_policies
 * ---------------------------------------
 * Functie voor het bepalen en toesten van de landbouw emissies volgens provinciaal beleid.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_jurisdiction_policies(v_year year_type, v_source_list integer[])
	RETURNS TABLE(year year_type, site_id integer, source_id integer, farm_lodging_type_id integer, substance_id smallint, emission posreal) AS
$BODY$
BEGIN
	RETURN QUERY SELECT * FROM ae_farm_emissions(v_year, v_source_list, 'jurisdiction_policies'::policy_type);

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions
 * -----------------
 * Functie voor het bepalen en toesten van de landbouw stal emissies aan de hand van een aantal beleidsscenario-opties.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions(
		v_year year_type,
		v_source_list integer[],
		v_policy_type policy_type,
		v_adjust_ceiling_suspenders boolean = TRUE,
		v_adjust_ceiling_sources boolean = TRUE,
		v_apply_grazing_corrections boolean = TRUE,
		v_apply_nema_corrections boolean = TRUE,
		v_apply_fodder_corrections boolean = TRUE,
		v_use_calculation_ceilings boolean = TRUE,
		v_with_growth boolean = TRUE)
	RETURNS TABLE(year year_type, site_id integer, source_id integer, farm_lodging_type_id integer, substance_id smallint, emission posreal) AS
$BODY$
BEGIN
	RAISE NOTICE 'Calculating farm emissions % for year % and % source(s). adjust_ceiling_suspenders=%, adjust_ceiling_sources=%, apply_grazing_corrections=%, apply_nema_corrections=%, apply_fodder_corrections=%, use_calculation_ceiling=%, with_growth=%',
		v_policy_type, v_year, array_length(v_source_list, 1), v_adjust_ceiling_suspenders, v_adjust_ceiling_sources, v_apply_grazing_corrections, v_apply_nema_corrections, v_apply_fodder_corrections, v_use_calculation_ceilings, v_with_growth;

	-- Create temporary table with farm emission data
	CREATE TEMPORARY TABLE tmp_farm_emissions ON COMMIT DROP AS
	SELECT
		source_lodgings_scaled.year AS year,
		source_lodgings_scaled.source_id,
		jurisdictions.jurisdiction_id,
		sources.site_id,
		source_lodgings_scaled.farm_lodging_type_id,
		lodgings.farm_animal_category_id,
		lodgings.farm_emission_ceiling_category_id,
		lodgings.farm_nema_cluster_id,

		CASE
			WHEN v_with_growth THEN
				source_lodgings_scaled.num_animals
			ELSE  -- Always take num_animals from the base year, the view already provides this value. See view comment.
				source_lodgings_scaled.num_animals_base
		END AS num_animals,

		farm_site_suspenders.suspender,
		farm_sites.recreational,
		farm_sites.no_growth,
		emission_factors.substance_id,
		emission_factors.emission_factor,
		null::real AS emission_ceiling,
		1.0::real AS correction

		FROM sources
			INNER JOIN farm_sites USING (site_id)
			INNER JOIN farm_source_lodging_types AS source_lodgings USING (source_id)
			INNER JOIN farm_source_lodging_types_scaled_view AS source_lodgings_scaled USING (source_id, farm_lodging_type_id)
			INNER JOIN farm_lodging_types AS lodgings USING (farm_lodging_type_id)
			INNER JOIN farm_lodging_type_emission_factors AS emission_factors USING (farm_lodging_type_id)
			INNER JOIN jurisdictions ON ST_Within(sources.geometry, jurisdictions.geometry)
			LEFT JOIN farm_site_suspenders USING (site_id, farm_emission_ceiling_category_id)

		WHERE
			source_lodgings_scaled.year = v_year
			AND sources.source_id = ANY(v_source_list)
	;

	-- Edit farm emissions
	IF v_adjust_ceiling_suspenders THEN
		EXECUTE ae_farm_emissions_adjust_ceiling_suspenders();
	END IF;

	IF v_adjust_ceiling_sources THEN
		EXECUTE ae_farm_emissions_adjust_ceiling_sources(v_policy_type, v_use_calculation_ceilings);
	END IF;

	IF v_apply_grazing_corrections THEN
		EXECUTE ae_farm_emissions_apply_grazing_corrections();
	END IF;

	IF v_apply_nema_corrections THEN
		EXECUTE ae_farm_emissions_apply_nema_corrections();
	END IF;

	IF v_apply_fodder_corrections AND v_policy_type <> 'no_policies' THEN
		EXECUTE ae_farm_emissions_apply_fodder_corrections();
	END IF;

	-- Return farm emissions
	RETURN QUERY
		SELECT
			tmp_farm_emissions.year,
			tmp_farm_emissions.site_id,
			tmp_farm_emissions.source_id,
			tmp_farm_emissions.farm_lodging_type_id,
			tmp_farm_emissions.substance_id,
			(num_animals * COALESCE(emission_ceiling, emission_factor) * correction)::posreal AS emission

			FROM tmp_farm_emissions;

	-- Cleanup
	DROP TABLE tmp_farm_emissions;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions_adjust_ceiling_suspenders
 * -------------------------------------------
 * Functie voor het aanpassen van de huidige emissie factoren van een bedrijf indien dit bedrijf op emissieplafond-categorie-niveau niet aan het emissieplafond voldoen.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_adjust_ceiling_suspenders()
	RETURNS void AS
$BODY$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'tmp_farm_emissions') THEN
		RAISE EXCEPTION 'Cannot run this function independently; use ae_farm_emissions() or ae_farm_emissions_..._policies().';
	END IF;

	UPDATE tmp_farm_emissions
		SET emission_ceiling = ceiling.emission_ceiling

		FROM farm_emission_formal_ceilings_no_policies AS ceiling

		WHERE
			tmp_farm_emissions.suspender IS TRUE
			AND tmp_farm_emissions.farm_emission_ceiling_category_id = ceiling.farm_emission_ceiling_category_id
			AND tmp_farm_emissions.substance_id = ceiling.substance_id
	;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions_adjust_ceiling_sources
 * ----------------------------------------
 * Functie voor het aanpassen van de huidige emissie factoren van een bedrijf indien dit bedrijf op emissieplafond-categorie-niveau niet aan het emissieplafond voldoen.
 * We passen voor alle suspenders (en alle jaren) de emissiefactoren aan. Aangezien het om een suspnder gaat weten we dat het bedrijf niet voldoet aan het emissieplafond. Dit plafond wordt in de functie dan ook niet meer gecontroleerd.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_adjust_ceiling_sources(v_policy_type policy_type, v_use_calculation_ceilings boolean)
	RETURNS void AS
$BODY$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'tmp_farm_emissions') THEN
		RAISE EXCEPTION 'Cannot run this function independently; use ae_farm_emissions() or ae_farm_emissions_..._policies().';
	END IF;

	UPDATE tmp_farm_emissions
		SET emission_ceiling = relevant_emissions.new_emission_ceiling
		FROM
			(SELECT
				year,
				source_id,
				farm_lodging_type_id,
				substance_id,
				new_emission_ceiling

				FROM

					(SELECT
						tmp_farm_emissions.year,
						tmp_farm_emissions.source_id,
						tmp_farm_emissions.farm_lodging_type_id,
						tmp_farm_emissions.substance_id,
						tmp_farm_emissions.emission_factor,
						tmp_farm_emissions.emission_ceiling,

						CASE
							-- formal ceilings
							WHEN (v_policy_type = 'no_policies'::policy_type AND v_use_calculation_ceilings IS FALSE) THEN
								farm_emission_formal_ceilings_all_policies_view.emission_ceiling_np
							WHEN (v_policy_type = 'global_policies'::policy_type AND v_use_calculation_ceilings IS FALSE) THEN
								farm_emission_formal_ceilings_all_policies_view.emission_ceiling_gp
							WHEN (v_policy_type = 'jurisdiction_policies'::policy_type AND v_use_calculation_ceilings IS FALSE) THEN
								farm_emission_formal_ceilings_all_policies_view.emission_ceiling_jp

							-- calculation ceilings
							WHEN (v_policy_type = 'no_policies'::policy_type AND v_use_calculation_ceilings IS TRUE) THEN
								farm_emission_ceilings_all_policies_view.emission_ceiling_np
							WHEN (v_policy_type = 'global_policies'::policy_type AND v_use_calculation_ceilings IS TRUE) THEN
								farm_emission_ceilings_all_policies_view.emission_ceiling_gp
							WHEN (v_policy_type = 'jurisdiction_policies'::policy_type AND v_use_calculation_ceilings IS TRUE) THEN
								farm_emission_ceilings_all_policies_view.emission_ceiling_jp

							ELSE NULL
						END AS new_emission_ceiling

						FROM tmp_farm_emissions
							LEFT JOIN farm_emission_formal_ceilings_all_policies_view USING (jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id)
							LEFT JOIN farm_emission_ceilings_all_policies_view USING (jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id)

						WHERE
							tmp_farm_emissions.suspender IS FALSE
							AND tmp_farm_emissions.recreational IS FALSE

					) AS emissions

				WHERE
					emissions.new_emission_ceiling IS NOT NULL
					AND LEAST(emissions.emission_factor, emissions.new_emission_ceiling) = emissions.new_emission_ceiling
					AND LEAST(emissions.emission_ceiling, emissions.new_emission_ceiling) = emissions.new_emission_ceiling

			) AS relevant_emissions

		WHERE
			tmp_farm_emissions.year = relevant_emissions.year
			AND tmp_farm_emissions.source_id = relevant_emissions.source_id
			AND tmp_farm_emissions.farm_lodging_type_id = relevant_emissions.farm_lodging_type_id
			AND tmp_farm_emissions.substance_id = relevant_emissions.substance_id
	;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions_apply_grazing_corrections
 * -------------------------------------------
 * Functie voor het toepassen van de weide reductie.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_apply_grazing_corrections()
	RETURNS void AS
$BODY$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'tmp_farm_emissions') THEN
		RAISE EXCEPTION 'Cannot run this function independently; use ae_farm_emissions() or ae_farm_emissions_..._policies().';
	END IF;

	UPDATE tmp_farm_emissions
		SET correction = correction * correction_factor

		FROM farm_emission_correction_factors_grazing

		WHERE
			tmp_farm_emissions.jurisdiction_id = farm_emission_correction_factors_grazing.jurisdiction_id
			AND tmp_farm_emissions.farm_animal_category_id = farm_emission_correction_factors_grazing.farm_animal_category_id
			AND tmp_farm_emissions.substance_id = farm_emission_correction_factors_grazing.substance_id
	;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions_apply_fodder_corrections
 * ------------------------------------------
 * Functie voor het toepassen van de voermanagement reductie.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_apply_fodder_corrections()
	RETURNS void AS
$BODY$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'tmp_farm_emissions') THEN
		RAISE EXCEPTION 'Cannot run this function independently; use ae_farm_emissions() or ae_farm_emissions_..._policies().';
	END IF;

	UPDATE tmp_farm_emissions
		SET correction = correction * correction_factor

		FROM farm_emission_correction_factors_fodder

		WHERE
			tmp_farm_emissions.farm_animal_category_id = farm_emission_correction_factors_fodder.farm_animal_category_id
			AND tmp_farm_emissions.year = farm_emission_correction_factors_fodder.year
			AND tmp_farm_emissions.substance_id = farm_emission_correction_factors_fodder.substance_id
			AND tmp_farm_emissions.suspender IS FALSE
			AND tmp_farm_emissions.recreational IS FALSE
	;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_farm_emissions_apply_nema_corrections
 * ----------------------------------------
 * Functie voor het toepassen van de nema correctie.
 */
CREATE OR REPLACE FUNCTION ae_farm_emissions_apply_nema_corrections()
	RETURNS void AS
$BODY$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'tmp_farm_emissions') THEN
		RAISE EXCEPTION 'Cannot run this function independently; use ae_farm_emissions() or ae_farm_emissions_..._policies().';
	END IF;

	UPDATE tmp_farm_emissions
		SET correction = correction * correction_factor

		FROM farm_emission_correction_factors_nema

		WHERE
			tmp_farm_emissions.farm_nema_cluster_id = farm_emission_correction_factors_nema.farm_nema_cluster_id
			AND tmp_farm_emissions.substance_id = farm_emission_correction_factors_nema.substance_id
	;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;