/*
 * farm_lodging_type_emission_factors_view
 * ---------------------------------------
 * Geeft de eigenschappen van een stalsysteem, inclusief code, beschrijving, diercategorie, emissiefactoren, of het een luchtwasser is, het
 * bijbehorende traditionele stalsysteem, en de stalbeschrijvingen die er bij gekozen kunnen worden.
 */
CREATE OR REPLACE VIEW farm_lodging_type_emission_factors_view AS
SELECT
	farm_lodging_type_id,
	farm_lodging_types.code,
	farm_lodging_types.name,
	farm_lodging_types.description,
	farm_animal_category_id,
	farm_lodging_system_definition_id,
	substance_id,
	emission_factor,
	farm_other_lodging_type_id,
	scrubber

	FROM farm_lodging_types
		INNER JOIN farm_animal_categories USING (farm_animal_category_id)
		INNER JOIN farm_lodging_types_to_lodging_system_definitions USING (farm_lodging_type_id)
		INNER JOIN farm_lodging_type_emission_factors USING (farm_lodging_type_id)
		LEFT JOIN farm_lodging_types_other_lodging_type USING (farm_lodging_type_id)

	ORDER BY left(farm_lodging_types.code, 1), string_to_array(right(farm_lodging_types.code, -1), '.')::int[]
;


/*
 * farm_additional_lodging_system_emission_factors_view
 * ----------------------------------------------------
 * Geeft de eigenschappen van een additionele staltechniek, inclusief code, beschrijving, diercategorie, emissiefactoren, of het een
 * luchtwasser is, en de stalbeschrijvingen die er bij gekozen kunnen worden.
 */
CREATE OR REPLACE VIEW farm_additional_lodging_system_emission_factors_view AS
SELECT
	farm_additional_lodging_system_id,
	farm_additional_lodging_systems.code,
	farm_additional_lodging_systems.name,
	farm_additional_lodging_systems.description,
	farm_animal_category_id,
	farm_lodging_system_definition_id,
	substance_id,
	emission_factor,
	scrubber

	FROM farm_additional_lodging_systems
		INNER JOIN farm_animal_categories USING (farm_animal_category_id)
		INNER JOIN farm_additional_lodging_system_emission_factors USING (farm_additional_lodging_system_id)
		INNER JOIN farm_additional_lodging_systems_to_lodging_system_definitions USING (farm_additional_lodging_system_id)
;


/*
 * farm_reductive_lodging_system_reduction_factors_view
 * ----------------------------------------------------
 * Geeft de eigenschappen van een emissiereducerende staltechniek, inclusief code, beschrijving, diercategorie, reductiefactoren, of het een
 * luchtwasser is, en de stalbeschrijvingen die er bij gekozen kunnen worden.
 */
CREATE OR REPLACE VIEW farm_reductive_lodging_system_reduction_factors_view AS
SELECT
	farm_reductive_lodging_system_id,
	farm_reductive_lodging_systems.code,
	farm_reductive_lodging_systems.name,
	farm_reductive_lodging_systems.description,
	farm_animal_category_id,
	farm_lodging_system_definition_id,
	substance_id,
	reduction_factor,
	scrubber

	FROM farm_reductive_lodging_systems
		INNER JOIN farm_animal_categories USING (farm_animal_category_id)
		INNER JOIN farm_reductive_lodging_system_reduction_factors USING (farm_reductive_lodging_system_id)
		INNER JOIN farm_reductive_lodging_systems_to_lodging_system_definitions USING (farm_reductive_lodging_system_id)
;


/*
 * farm_lodging_fodder_measure_reduction_factors_view
 * --------------------------------------------------
 * Geeft de eigenschappen van een voer- en managementmaatregel, inclusief code, beschrijving, de diercategorieën waarop deze mag worden toegepast en
 * de bijbehorende aandeel- en reductiefactoren voor die diercategorie.
 */
CREATE OR REPLACE VIEW farm_lodging_fodder_measure_reduction_factors_view AS
SELECT
	farm_lodging_fodder_measure_id,
	farm_lodging_fodder_measures.code,
	farm_lodging_fodder_measures.name,
	farm_lodging_fodder_measures.description,
	farm_animal_category_id,
	substance_id,
	reduction_factor_floor,
	reduction_factor_cellar,
	reduction_factor_total,
	proportion_floor,
	proportion_cellar

	FROM farm_lodging_fodder_measures
		INNER JOIN farm_lodging_fodder_measure_reduction_factors USING (farm_lodging_fodder_measure_id)
		INNER JOIN farm_lodging_fodder_measures_animal_category USING (farm_lodging_fodder_measure_id)
		INNER JOIN farm_animal_categories USING (farm_animal_category_id)
;
