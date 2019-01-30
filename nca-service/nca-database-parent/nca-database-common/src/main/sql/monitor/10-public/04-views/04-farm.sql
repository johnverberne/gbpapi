/*
 * farm_animal_category_economic_growths_view
 * ------------------------------------------
 * Groei per diercategorie per jaar waarbij er geen krmip t.o.v. het basisjaar mag optreden.
 */
CREATE OR REPLACE VIEW farm_animal_category_economic_growths_view AS
SELECT
	farm_animal_category_id,
	year,

	(CASE WHEN (base_year < year) THEN
		GREATEST(base_growth, growth)
	ELSE
		growth
	END) AS growth

	FROM farm_animal_category_economic_growths
		INNER JOIN
			(SELECT
				farm_animal_category_id,
				year AS base_year,
				growth AS base_growth

				FROM farm_animal_category_economic_growths
					INNER JOIN years USING (year)

				WHERE year_category = 'base'
			) AS base USING (farm_animal_category_id)
;


/*
 * farm_source_lodging_types_scaled_view
 * -------------------------------------
 * Retourneert de geschaalde dieraantallen.
 * Stoppers en hobbyboeren worden niet geschaald.
 *
 * Voor ieder jaar worden tevens de geschaalde dieraantallen van het basisjaar herhaald (num_animals_base).
 * Dit zodat de ae_farm_emissions() function gebruik kan maken van deze waarde zonder zelf twee keer met
 * deze view te joinen. Dit bleek namelijk de performance flink nadelig te beinvloeden, en kon niet op
 * een betere manier herschreven worden.
 * Voor ieder record waar "year" het basisjaar is, geldt dus dat "num_animals" == "num_animals_base".
 */
CREATE OR REPLACE VIEW farm_source_lodging_types_scaled_view AS
SELECT
	years.year,
	source_id,
	farm_lodging_type_id,

	(CASE WHEN (recreational IS FALSE AND no_growth IS FALSE AND farm_site_suspenders.suspender IS FALSE) THEN
		FLOOR(num_animals * COALESCE(growth, 1.0))
	ELSE
		num_animals
	END)::integer AS num_animals,

	(CASE WHEN (recreational IS FALSE AND no_growth IS FALSE  AND farm_site_suspenders.suspender IS FALSE) THEN
		FLOOR(num_animals * COALESCE(base_growth, 1.0)) -- TODO #1100: growth gebruiken indien base_year >= year
	ELSE
		num_animals
	END)::integer AS num_animals_base

	FROM farm_source_lodging_types
		INNER JOIN sources USING (source_id)
		INNER JOIN farm_sources USING (source_id)
		INNER JOIN farm_lodging_types USING (farm_lodging_type_id)
		INNER JOIN farm_sites USING (site_id)
		CROSS JOIN years
		LEFT JOIN farm_site_suspenders USING (site_id, farm_emission_ceiling_category_id)
		LEFT JOIN farm_animal_category_economic_growths_view USING (farm_animal_category_id, year)
		LEFT JOIN
			(SELECT
				farm_animal_category_id,
				growth AS base_growth

				FROM farm_animal_category_economic_growths_view
					INNER JOIN years USING (year)

				WHERE year_category = 'base'
			) AS base_growths USING (farm_animal_category_id)
;


/*
 * farm_number_of_animals_by_jurisdiction_view
 * -------------------------------------------
 * Retourneert het aantal dieren per diercategorie, provincie en jaar.
 */
CREATE OR REPLACE VIEW farm_number_of_animals_by_jurisdiction_view AS
SELECT
	year,

	farm_animal_categories.farm_animal_category_id,
	farm_animal_categories.name AS farm_animal_category_name,

	jurisdictions.jurisdiction_id,
	jurisdictions.name AS jurisdiction_name,

	SUM(num_animals) AS num_animals

	FROM sources
		INNER JOIN farm_sources USING (source_id)
		INNER JOIN farm_source_lodging_types_scaled_view USING (source_id)
		INNER JOIN farm_lodging_types USING (farm_lodging_type_id)
		INNER JOIN farm_animal_categories USING (farm_animal_category_id)
		INNER JOIN jurisdictions ON ST_Within(sources.geometry, jurisdictions.geometry)

	GROUP BY
		year,
		farm_animal_categories.farm_animal_category_id,
		farm_animal_categories.name,
		jurisdictions.jurisdiction_id,
		jurisdictions.name
;


/*
 * farm_lodging_type_emission_factors_view
 * ---------------------------------------
 * Geeft de eigenschappen van een staltechniek weer, inclusief code, beschrijving en emissiefactors.
 */
CREATE OR REPLACE VIEW farm_lodging_type_emission_factors_view AS
SELECT
	farm_lodging_type_id,
	name AS code, --monitor farm_lodging_types don't have a code...
	name,
	description,
	substance_id,
	emission_factor

	FROM farm_lodging_types
		INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
;

