/*
 * farm_animal_categories
 * ----------------------
 * Vertaaltabel voor diercategorieën.
 */
CREATE TABLE i18n.farm_animal_categories (
	farm_animal_category_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text,

	CONSTRAINT farm_animal_categories_pkey PRIMARY KEY (farm_animal_category_id, language_code),
	CONSTRAINT farm_animal_categories_fkey FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories
);


/*
 * farm_lodging_types
 * ------------------
 * Vertaaltabel voor stalsystemen.
 */
CREATE TABLE i18n.farm_lodging_types (
	farm_lodging_type_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text,

	CONSTRAINT farm_lodging_types_pkey PRIMARY KEY (farm_lodging_type_id, language_code),
	CONSTRAINT farm_lodging_types_fkey FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types
);


/*
 * farm_additional_lodging_systems
 * -------------------------------
 * Vertaaltabel voor additionele staltechnieken.
 */
CREATE TABLE i18n.farm_additional_lodging_systems (
	farm_additional_lodging_system_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text,

	CONSTRAINT farm_additional_lodging_systems_pkey PRIMARY KEY (farm_additional_lodging_system_id, language_code),
	CONSTRAINT farm_additional_lodging_systems_fkey FOREIGN KEY (farm_additional_lodging_system_id) REFERENCES farm_additional_lodging_systems
);


/*
 * farm_reductive_lodging_systems
 * ------------------------------
 * Vertaaltabel voor emissiereducerende staltechnieken.
 */
CREATE TABLE i18n.farm_reductive_lodging_systems (
	farm_reductive_lodging_system_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text,

	CONSTRAINT farm_reductive_lodging_systems_pkey PRIMARY KEY (farm_reductive_lodging_system_id, language_code),
	CONSTRAINT farm_reductive_lodging_systems_fkey FOREIGN KEY (farm_reductive_lodging_system_id) REFERENCES farm_reductive_lodging_systems
);


/*
 * farm_lodging_fodder_measures
 * ----------------------------
 * Vertaaltabel voor voer- en managementmaatregelen.
 */
CREATE TABLE i18n.farm_lodging_fodder_measures (
	farm_lodging_fodder_measure_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text,

	CONSTRAINT farm_lodging_fodder_measures_pkey PRIMARY KEY (farm_lodging_fodder_measure_id, language_code),
	CONSTRAINT farm_lodging_fodder_measures_fkey FOREIGN KEY (farm_lodging_fodder_measure_id) REFERENCES farm_lodging_fodder_measures
);


/*
 * farm_lodging_system_definitions
 * -------------------------------
 * Vertaaltabel voor stalbeschrijvingen.
 */
CREATE TABLE i18n.farm_lodging_system_definitions (
	farm_lodging_system_definition_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text,

	CONSTRAINT farm_lodging_system_definitions_pkey PRIMARY KEY (farm_lodging_system_definition_id, language_code),
	CONSTRAINT farm_lodging_system_definitions_fkey FOREIGN KEY (farm_lodging_system_definition_id) REFERENCES farm_lodging_system_definitions
);
