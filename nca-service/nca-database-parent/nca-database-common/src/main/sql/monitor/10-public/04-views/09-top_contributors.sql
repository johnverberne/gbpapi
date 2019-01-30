/*
 * site_emissions_view
 * -------------------
 * Geeft de totale emissies van een site weer.
 */
CREATE OR REPLACE VIEW site_emissions_view AS
SELECT
	site_id,
	substance_id,
	SUM(emission) AS emission

	FROM (
		SELECT
			site_id,
			substance_id,
			emission

			FROM site_generic_sources_view

		UNION ALL

		SELECT
			site_id,
			substance_id,
			(num_animals * emission_factor) AS emission

			FROM site_farm_sources_view
				INNER JOIN sources USING (site_id, source_id)
				INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
		) AS all_sources

	GROUP BY site_id, substance_id
;


/*
 * ae_receptor_top_contributor_candidates
 * --------------------------------------
 * Functie voor het bepalen van site_id's die waarschijnlijk het meeste depositie zullen genereren voor een receptor.
 */
CREATE OR REPLACE FUNCTION ae_receptor_top_contributor_candidates(v_receptor_id integer, v_is_priority_project boolean)
	RETURNS TABLE(site_id integer, rank integer) AS
$BODY$
	SELECT
		candidate_sites.site_id,
		(rank() OVER (ORDER BY weighted_emission DESC))::int AS weighted_rank

		FROM (SELECT
			site_id,
			SUM(ae_deposition_factor_over_distance_decay(GREATEST(distance, 1), substance_id) * emission) AS weighted_emission

			FROM site_distance_for_receptor_view
				INNER JOIN site_emissions_view USING (site_id)
				INNER JOIN site_generated_properties_view USING (site_id)

			WHERE site_distance_for_receptor_view.receptor_id = v_receptor_id
				AND site_generated_properties_view.is_priority_project = v_is_priority_project
				AND distance < 50000

			GROUP BY site_id
		) AS candidate_sites
$BODY$
LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_assessment_area_top_contributor_candidates
 * ---------------------------------------------
 * Functie voor het bepalen van site_id's die waarschijnlijk het meeste depositie zullen genereren voor een natuurgebied.
 */
CREATE OR REPLACE FUNCTION ae_assessment_area_top_contributor_candidates(v_assessment_area_id integer, v_is_priority_project boolean)
	RETURNS TABLE(site_id integer, rank integer) AS
$BODY$
	SELECT
		candidate_sites.site_id,
		(rank() OVER (ORDER BY weighted_emission DESC))::int AS weighted_rank

		FROM (SELECT
			site_id,
			SUM(ae_deposition_factor_over_distance_decay(GREATEST(distance, 1), substance_id) * emission) AS weighted_emission

			FROM ae_sites_distance_to_assessment_area(v_assessment_area_id, 10000, 0, v_is_priority_project)
				INNER JOIN site_emissions_view USING (site_id)

			WHERE distance < 50000

			GROUP BY site_id
		) AS candidate_sites
$BODY$
LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT;


/*
 * top_contributor_site_depositions_view
 * -------------------------------------
 * Retourneert de sites van een spin berekening, gesorteerd op totale depositie (aflopend).
 */
CREATE OR REPLACE VIEW top_contributor_site_depositions_view AS
SELECT
	top_contributor_plot_id,
	site_id,
	SUM(deposition) AS total_deposition

	FROM top_contributor_plots
		INNER JOIN top_contributor_plot_calculations_by_site USING (top_contributor_plot_id)
		INNER JOIN calculation_summed_deposition_results_view USING (calculation_id)

	GROUP BY top_contributor_plot_id, site_id

	ORDER BY total_deposition DESC
;
