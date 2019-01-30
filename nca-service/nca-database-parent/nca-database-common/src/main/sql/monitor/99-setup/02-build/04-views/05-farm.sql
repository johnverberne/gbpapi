/*
 * build_farm_sites_view
 * ---------------------
 * View om farm_sites mee te vullen.
 *
 * recreational: site waarbij de totale emissie aan de hand van de stalsystemen (inclusief weide reductie) op bedrijfsniveau kleiner is dan 100 kg/jaar.
 */
CREATE OR REPLACE VIEW setup.build_farm_sites_view AS
SELECT
	site_id,
	(SUM(num_animals *
		emission_factor *
		COALESCE(grazing.correction_factor, 1.0)) < 100) AS recreational

	FROM sources
		INNER JOIN farm_sources USING (source_id)
		INNER JOIN farm_source_lodging_types USING (source_id)
		INNER JOIN farm_lodging_types USING (farm_lodging_type_id)
		INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
		LEFT JOIN jurisdictions ON ST_Within(sources.geometry, jurisdictions.geometry)
		LEFT JOIN farm_emission_correction_factors_grazing AS grazing USING (jurisdiction_id, farm_animal_category_id, substance_id)

	GROUP BY site_id
;

/*
 * build_farm_site_suspenders_view
 * -------------------------------
 * View om farm_site_suspenders mee te vullen.
 *
 * suspender: per site / emissieplafond categorie waarbij het wettelijke emissieplafond zonder beleid voor een emissie plafond categorie (D of E) op bedrijfsniveau niet voldoet.
 */
CREATE OR REPLACE VIEW setup.build_farm_site_suspenders_view AS
SELECT
	site_id,
	farm_emission_ceiling_category_id,
	(SUM(num_animals * emission_factor) > SUM(num_animals * COALESCE(emission_ceiling, emission_factor))
		AND (farm_emission_ceiling_categories.name ILIKE 'D%' OR farm_emission_ceiling_categories.name ILIKE 'E%')) AS suspender


	FROM sources
		INNER JOIN farm_sources USING (source_id)
		INNER JOIN farm_source_lodging_types USING (source_id)
		INNER JOIN farm_lodging_types USING (farm_lodging_type_id)
		INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
		LEFT JOIN farm_emission_formal_ceilings_no_policies USING (farm_emission_ceiling_category_id, substance_id)
		LEFT JOIN farm_emission_ceiling_categories USING (farm_emission_ceiling_category_id)

	GROUP BY site_id, farm_emission_ceiling_category_id, farm_emission_ceiling_categories.name
;

/*
 * build_farm_emission_correction_factors_grazing_view
 * ---------------------------------------------------
 * View om farm_emission_correction_factors_grazing mee te vullen. Dit zijn de netto emissie reductiefactoren voor A1-dieren.
 * Dwz de gemiddelde reductie die rekenkundig wordt toegepast op ALLE A1 stallen inclusief de permanent opstallen.
 */
CREATE OR REPLACE VIEW setup.build_farm_emission_correction_factors_grazing_view AS
SELECT
	jurisdiction_id,
	farm_animal_category_id,
	substance_id,
	1.0 - (grazing_lodging_fraction * grazing_reduction_fraction) AS correction_factor,
	farm_grazing_fractions.description

	FROM setup.farm_grazing_fractions
		CROSS JOIN farm_animal_categories

	WHERE farm_animal_categories.name ILIKE 'A1%'
;


/*
 * build_farm_emission_correction_factors_fodder_view
 * --------------------------------------------------
 * View om farm_emission_correction_factors_fodder mee te vullen.
 * Dit zijn de emissie reductiefactoren op A1+A3 dieren, om voor die stallen op totaal 3 kiloton reductie uit te komen.
 */
CREATE OR REPLACE VIEW setup.build_farm_emission_correction_factors_fodder_view AS
SELECT
	farm_animal_category_id,
	year,
	substance_id,
	COALESCE((total_emission - 3000000) / NULLIF(total_emission, 0), 0)::real AS correction_factor,
	'to scale the total A1 + A3 emissions from ' || total_emission::numeric || ' to ' || (total_emission - 3000000)::numeric AS description

	FROM farm_animal_categories
		CROSS JOIN
			(SELECT
				years.year,
				farm_emissions.substance_id,
				SUM(emission) AS total_emission

				FROM years
					CROSS JOIN ae_farm_emissions_global_policies(year, (SELECT array_agg(source_id) FROM farm_sources)) AS farm_emissions
					INNER JOIN farm_lodging_types USING (farm_lodging_type_id)
					INNER JOIN farm_animal_categories USING (farm_animal_category_id)
					INNER JOIN farm_sites USING (site_id)
					INNER JOIN farm_site_suspenders USING (site_id, farm_emission_ceiling_category_id)
					WHERE
						year_category = 'future'
						AND (farm_animal_categories.name ILIKE 'A1%' OR farm_animal_categories.name ILIKE 'A3%')
						AND suspender IS FALSE
						AND recreational IS FALSE

				GROUP BY years.year, substance_id
			) AS total_emissions

	WHERE (farm_animal_categories.name ILIKE 'A1%' OR farm_animal_categories.name ILIKE 'A3%')
;


/*
 * build_farm_emission_ceilings_no_policies_view
 * ---------------------------------------------
 * View om farm_emission_ceilings_no_policies mee te vullen. Dit zijn de rekenplafonds obv de wettelijke plafonds.
 *
 * Het rekenplafond is bepaald aan de hand van het wettelijke plafond waarbij er rekening gehouden is met de vervangingsgraad.
 * De vervangingsgraad geldt voor alle stallen. Wij gebruiken de vervangingsgraad om een inschatting te maken van
 * de verwachte daling, die alleen optreedt bij stallen die nu nog niet voldoen aan de wettelijke plafonds.
 */
CREATE OR REPLACE VIEW setup.build_farm_emission_ceilings_no_policies_view AS
SELECT
	farm_emission_ceiling_category_id,
	year,
	substance_id,
	avg_above_ceiling -
		((avg_above_ceiling - emission_ceiling) * substitution_fraction) AS emission_ceiling,
	farm_emission_formal_ceilings_no_policies.description

	FROM
		(SELECT
			farm_emission_ceiling_category_id,
			substance_id,
			SUM(emission_factor * num_animals) / SUM(num_animals) AS avg_above_ceiling -- TODO #1100: add ae_weighted_avg (of zoiets)

			FROM farm_source_lodging_types
				INNER JOIN sources USING (source_id)
				INNER JOIN farm_sites USING (site_id)
				INNER JOIN farm_site_suspenders USING (site_id)
				INNER JOIN farm_lodging_types USING (farm_lodging_type_id, farm_emission_ceiling_category_id)
				INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
				INNER JOIN farm_emission_formal_ceilings_no_policies USING (farm_emission_ceiling_category_id, substance_id)

			WHERE
				emission_factor > emission_ceiling
				AND suspender IS FALSE
				AND recreational IS FALSE

			GROUP BY farm_emission_ceiling_category_id, substance_id
		) AS above_ceiling

		INNER JOIN farm_emission_formal_ceilings_no_policies USING (farm_emission_ceiling_category_id, substance_id)
		INNER JOIN setup.farm_substitution_fractions USING (farm_emission_ceiling_category_id, substance_id)
;


/*
 * build_farm_emission_ceilings_global_policies_view
 * -------------------------------------------------
 * View om farm_emission_ceilings_global_policies mee te vullen. Dit zijn de rekenplafonds obv de wettelijke plafonds.
 *
 * Het rekenplafond is bepaald aan de hand van het wettelijke plafond waarbij er rekening gehouden is met de vervangingsgraad.
 * De vervangingsgraad geldt voor alle stallen. Wij gebruiken de vervangingsgraad om een inschatting te maken van
 * de verwachte daling, die alleen optreedt bij stallen die nu nog niet voldoen aan de wettelijke plafonds.
 */
CREATE OR REPLACE VIEW setup.build_farm_emission_ceilings_global_policies_view AS
SELECT
	farm_emission_ceiling_category_id,
	year,
	substance_id,
	avg_above_ceiling -
		((avg_above_ceiling - emission_ceiling) * substitution_fraction) AS emission_ceiling,
	farm_emission_formal_ceilings_global_policies.description

	FROM
		(SELECT
			farm_emission_ceiling_category_id,
			year,
			substance_id,
			SUM(emission_factor * num_animals) / SUM(num_animals) AS avg_above_ceiling

			FROM farm_source_lodging_types
				INNER JOIN sources USING (source_id)
				INNER JOIN farm_sites USING (site_id)
				INNER JOIN farm_site_suspenders USING (site_id)
				INNER JOIN farm_lodging_types USING (farm_lodging_type_id, farm_emission_ceiling_category_id)
				INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
				INNER JOIN farm_emission_formal_ceilings_global_policies USING (farm_emission_ceiling_category_id, substance_id)

			WHERE
				emission_factor > emission_ceiling
				AND suspender IS FALSE
				AND recreational IS FALSE

			GROUP BY farm_emission_ceiling_category_id, year, substance_id
		) AS above_ceiling

		INNER JOIN farm_emission_formal_ceilings_global_policies USING (farm_emission_ceiling_category_id, year, substance_id)
		INNER JOIN setup.farm_substitution_fractions USING (farm_emission_ceiling_category_id, year, substance_id)
;


/*
 * build_farm_emission_ceilings_jurisdiction_policies_view
 * -------------------------------------------------------
 * View om farm_emission_ceilings_jurisdiction_policies mee te vullen. Dit zijn de rekenplafonds obv de wettelijke plafonds.
 *
 * Het rekenplafond is bepaald aan de hand van het wettelijke plafond waarbij er rekening gehouden is met de vervangingsgraad.
 * De vervangingsgraad geldt voor alle stallen. Wij gebruiken de vervangingsgraad om een inschatting te maken van
 * de verwachte daling, die alleen optreedt bij stallen die nu nog niet voldoen aan de wettelijke plafonds.
 */
CREATE OR REPLACE VIEW setup.build_farm_emission_ceilings_jurisdiction_policies_view AS
SELECT
	jurisdiction_id,
	farm_emission_ceiling_category_id,
	year,
	substance_id,
	avg_above_ceiling -
		((avg_above_ceiling - emission_ceiling) * substitution_fraction) AS emission_ceiling,
	farm_emission_formal_ceilings_jurisdiction_policies.description

	FROM
		(SELECT
			jurisdiction_id,
			farm_emission_ceiling_category_id,
			year,
			substance_id,
			SUM(emission_factor * num_animals) / SUM(num_animals) AS avg_above_ceiling

			FROM farm_source_lodging_types
				INNER JOIN sources USING (source_id)
				INNER JOIN farm_sites USING (site_id)
				INNER JOIN farm_site_suspenders USING (site_id)
				INNER JOIN farm_lodging_types USING (farm_lodging_type_id, farm_emission_ceiling_category_id)
				INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
				INNER JOIN farm_emission_formal_ceilings_jurisdiction_policies USING (farm_emission_ceiling_category_id, substance_id)

			WHERE
				emission_factor > emission_ceiling
				AND suspender IS FALSE
				AND recreational IS FALSE

			GROUP BY jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id
		) AS above_ceiling

		INNER JOIN farm_emission_formal_ceilings_jurisdiction_policies USING (jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id)
		INNER JOIN setup.farm_substitution_fractions USING (farm_emission_ceiling_category_id, year, substance_id)
;


/*
 * build_farm_emission_correction_factors_nema_view
 * ------------------------------------------------
 * View om farm_emission_correction_factors_nema mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_farm_emission_correction_factors_nema_view AS
SELECT
	farm_nema_cluster_id,
	substance_id,
	farm_nema_emissions.emission / farm_lodging_emissions.emission AS correction_factor

	FROM 
		(SELECT
			farm_nema_cluster_id,
			substance_id,
			SUM(emission::double precision) AS emission

			FROM ae_farm_emissions_no_policies(
					(SELECT year FROM years WHERE year_category = 'farm_source'), 
					(SELECT array_agg(source_id) FROM farm_sources))
			
				INNER JOIN farm_lodging_types USING (farm_lodging_type_id)

			GROUP BY farm_nema_cluster_id, substance_id
			
		) AS farm_lodging_emissions
		
		INNER JOIN
			(SELECT
				farm_nema_cluster_id,
				substance_id,
				SUM(emission::double precision) AS emission
				
				FROM farm_nema_categories
					INNER JOIN farm_nema_category_emissions USING (farm_nema_category_id)

				GROUP BY farm_nema_cluster_id, substance_id
				
			) AS farm_nema_emissions USING (farm_nema_cluster_id, substance_id)
;