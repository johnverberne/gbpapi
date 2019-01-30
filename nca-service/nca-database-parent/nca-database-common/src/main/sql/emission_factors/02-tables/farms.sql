/*
 * farm_animal_categories
 * ----------------------
 * Diercategorieen die voorkomen in de RAV-code lijst. (RAV = Regeling ammoniak en veehouderij)
 */
CREATE TABLE farm_animal_categories (
	farm_animal_category_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT farm_animal_categories_pkey PRIMARY KEY (farm_animal_category_id)
);


/*
 * farm_lodging_types
 * ------------------
 * Stalsystemen (huisvestingssystemen); dit is in essentie de RAV-code lijst, zie http://wetten.overheid.nl/BWBR0013629/geldigheidsdatum_11-06-2015#Bijlage1
 * Een stalsysteem behoort altijd tot een bepaalde diercategorie.
 * Ook aangegeven is of het een luchtwasser is.
 */
CREATE TABLE farm_lodging_types (
	farm_lodging_type_id integer NOT NULL,
	farm_animal_category_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,
	scrubber boolean NOT NULL,

	CONSTRAINT farm_lodging_types_pkey PRIMARY KEY (farm_lodging_type_id),
	CONSTRAINT farm_lodging_types_fkey_farm_animal_categories FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories
);


/*
 * farm_lodging_type_emission_factors
 * ----------------------------------
 * Bevat de emissiefactoren (kg/jaar) van de stalsystemen.
 */
CREATE TABLE farm_lodging_type_emission_factors (
	farm_lodging_type_id integer NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT farm_lodging_type_emission_factors_pkey PRIMARY KEY (farm_lodging_type_id, substance_id),
	CONSTRAINT farm_lodging_type_emission_factors_fkey_farm_lodging_types FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types,
	CONSTRAINT farm_lodging_type_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_lodging_types_other_lodging_type
 * -------------------------------------
 * Geeft voor emissiearme stalsystemen aan wat het bijbehorende 'overige' stalsysteem is.
 * De koppeling (N:1) is alleen opgenomen als het stalsysteem als 'emissiearm' is geklassificeerd. In bepaalde gevallen wordt dan namelijk de
 * emissiefactor begrensd in de emissie berekening, o.b.v. die van het 'overige' stalsysteem.
 */
CREATE TABLE farm_lodging_types_other_lodging_type (
	farm_lodging_type_id integer NOT NULL,
	farm_other_lodging_type_id integer NOT NULL,

	CONSTRAINT farm_lodging_type_other_types_pkey PRIMARY KEY (farm_lodging_type_id),
	CONSTRAINT farm_lodging_type_other_types_fkey_farm_lodging_types FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types,
	CONSTRAINT farm_lodging_type_other_types_fkey_farm_other_lodging_types FOREIGN KEY (farm_other_lodging_type_id) REFERENCES farm_lodging_types(farm_lodging_type_id),

	CONSTRAINT farm_lodging_type_other_types_chk_selfref CHECK (farm_lodging_type_id <> farm_other_lodging_type_id)
);


/*
 * farm_additional_lodging_systems
 * -------------------------------
 * Additionele staltechnieken. Dit zijn staltechnieken die zorgen voor extra emissies en die gestapeld kunnen worden op een stalsysteem (farm_lodging_type).
 * Deze additionele staltechnieken zijn afgeleid uit de RAV-code lijst.
 */
CREATE TABLE farm_additional_lodging_systems (
	farm_additional_lodging_system_id integer NOT NULL,
	farm_animal_category_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,
	scrubber boolean NOT NULL,

	CONSTRAINT farm_additional_lodging_systems_pkey PRIMARY KEY (farm_additional_lodging_system_id),
	CONSTRAINT farm_additional_lodging_systems_fkey_farm_animal_categories FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories
);


/*
 * farm_additional_lodging_system_emission_factors
 * -----------------------------------------------
 * Bevat de emissiefactoren (kg/jaar) van de additionele staltechnieken.
 * Deze emissiefactor wordt extra toegepast op een deel van het aantal dieren van het stalsysteem waarop gestapeld wordt.
 */
CREATE TABLE farm_additional_lodging_system_emission_factors (
	farm_additional_lodging_system_id integer NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT farm_additional_lodging_system_emission_factors_pkey PRIMARY KEY (farm_additional_lodging_system_id, substance_id),
	CONSTRAINT farm_additional_lodging_system_emission_factors_fkey_types FOREIGN KEY (farm_additional_lodging_system_id) REFERENCES farm_additional_lodging_systems,
	CONSTRAINT farm_additional_lodging_system_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_lodging_types_to_additional_lodging_systems
 * ------------------------------------------------
 * Koppeling (N:N) welke aangeeft op welke stalsystemen de additionele staltechnieken gestapeld kunnen worden.
 * In deze tabel staan de toegestane combinaties van stapelingen binnen de RAV systematiek, echter binnen de Nb-wet is iedere combinatie mogelijk.
 */
CREATE TABLE farm_lodging_types_to_additional_lodging_systems (
	farm_lodging_type_id integer NOT NULL,
	farm_additional_lodging_system_id integer NOT NULL,

	CONSTRAINT farm_lodging_types_to_additional_lodging_systems_pkey PRIMARY KEY (farm_lodging_type_id, farm_additional_lodging_system_id),
	CONSTRAINT farm_lodging_types_to_additional_lodging_systems_fkey_types FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types,
	CONSTRAINT farm_lodging_types_to_additional_lodging_systems_fkey_systems FOREIGN KEY (farm_additional_lodging_system_id) REFERENCES farm_additional_lodging_systems,

	CONSTRAINT farm_lodging_types_to_additional_lodging_systems_chk_selfref CHECK (farm_lodging_type_id <> farm_additional_lodging_system_id)
);


/*
 * farm_reductive_lodging_systems
 * ------------------------------
 * Emissiereducerende staltechnieken. Dit zijn staltechnieken die zorgen voor minder emissies en gestapeld kunnen worden op een stalsysteem (farm_lodging_type).
 * Deze reducerende staltechnieken zijn afgeleid uit de RAV-code lijst.
 * Ook aangegeven is of het een luchtwasser is.
 */
CREATE TABLE farm_reductive_lodging_systems (
	farm_reductive_lodging_system_id integer NOT NULL,
	farm_animal_category_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,
	scrubber boolean NOT NULL,

	CONSTRAINT farm_reductive_lodging_systems_pkey PRIMARY KEY (farm_reductive_lodging_system_id),
	CONSTRAINT farm_reductive_lodging_systems_fkey_farm_animal_categories FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories
);


/*
 * farm_reductive_lodging_system_reduction_factors
 * -----------------------------------------------
 * Bevat de reductiefactoren (factor 0..1) van de emissiereducerende staltechnieken.
 * Deze reductiefactor wordt toegepast op de totale emissie van het stalsysteem waarop gestapeld wordt, inclusief eventuele additionele staltechnieken die hierop gestapeld zijn.
 */
CREATE TABLE farm_reductive_lodging_system_reduction_factors (
	farm_reductive_lodging_system_id integer NOT NULL,
	substance_id smallint NOT NULL,
	reduction_factor fraction NOT NULL,

	CONSTRAINT farm_reductive_lodging_system_reduction_factors_pkey PRIMARY KEY (farm_reductive_lodging_system_id, substance_id),
	CONSTRAINT farm_reductive_lodging_system_reduction_factors_fkey_types FOREIGN KEY (farm_reductive_lodging_system_id) REFERENCES farm_reductive_lodging_systems,
	CONSTRAINT farm_reductive_lodging_system_reduction_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_lodging_types_to_reductive_lodging_systems
 * -----------------------------------------------
 * Koppeling (N:N) welke aangeeft op welke stalsystemen de emissiereducerende staltechnieken gestapeld kunnen worden.
 * In deze tabel staan de toegestane combinaties van stapelingen binnen de RAV systematiek, echter binnen de Nb-wet is iedere combinatie mogelijk.
 */
CREATE TABLE farm_lodging_types_to_reductive_lodging_systems (
	farm_lodging_type_id integer NOT NULL,
	farm_reductive_lodging_system_id integer NOT NULL,

	CONSTRAINT farm_lodging_types_to_reductive_lodging_systems_pkey PRIMARY KEY (farm_lodging_type_id, farm_reductive_lodging_system_id),
	CONSTRAINT farm_lodging_types_to_reductive_lodging_systems_fkey_types FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types,
	CONSTRAINT farm_lodging_types_to_reductive_lodging_systems_fkey_reductive FOREIGN KEY (farm_reductive_lodging_system_id) REFERENCES farm_reductive_lodging_systems,

	CONSTRAINT farm_lodging_types_to_reductive_lodging_systems_chk_selfref CHECK (farm_lodging_type_id <> farm_reductive_lodging_system_id)
);


/*
 * farm_lodging_system_definitions
 * -------------------------------
 * Stalbeschrijvingen (BWL-nummers) zoals gebruikt voor de stalsystemen in de RAV.
 * Zie http://www.infomil.nl/onderwerpen/landbouw-tuinbouw/ammoniak/rav/stalbeschrijvingen
 */
CREATE TABLE farm_lodging_system_definitions (
	farm_lodging_system_definition_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT farm_lodging_system_definitions_pkey PRIMARY KEY (farm_lodging_system_definition_id)
);


/*
 * farm_lodging_types_to_lodging_system_definitions
 * ------------------------------------------------
 * Koppeling tussen stalsystemen en stalbeschrijvingen (N:N).
 */
CREATE TABLE farm_lodging_types_to_lodging_system_definitions (
	farm_lodging_type_id integer NOT NULL,
	farm_lodging_system_definition_id integer NOT NULL,

	CONSTRAINT farm_lodging_types_to_lodging_system_definitions_pkey PRIMARY KEY (farm_lodging_type_id, farm_lodging_system_definition_id),
	CONSTRAINT farm_lodging_types_to_lodging_system_definitions_fkey_types FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types,
	CONSTRAINT farm_lodging_types_to_lodging_system_definitions_fkey_defs FOREIGN KEY (farm_lodging_system_definition_id) REFERENCES farm_lodging_system_definitions
);


/*
 * farm_additional_lodging_systems_to_lodging_system_definitions
 * -------------------------------------------------------------
 * Koppeling tussen additionele staltechnieken en stalbeschrijvingen (N:N).
 */
CREATE TABLE farm_additional_lodging_systems_to_lodging_system_definitions (
	farm_additional_lodging_system_id integer NOT NULL,
	farm_lodging_system_definition_id integer NOT NULL,

	CONSTRAINT farm_additional_lodging_systems_to_definitions_pkey PRIMARY KEY (farm_additional_lodging_system_id, farm_lodging_system_definition_id),
	CONSTRAINT farm_additional_lodging_systems_to_definitions_fkey_additional FOREIGN KEY (farm_additional_lodging_system_id) REFERENCES farm_additional_lodging_systems,
	CONSTRAINT farm_additional_lodging_systems_to_definitions_fkey_defs FOREIGN KEY (farm_lodging_system_definition_id) REFERENCES farm_lodging_system_definitions
);


/*
 * farm_reductive_lodging_systems_to_lodging_system_definitions
 * ------------------------------------------------------------
 * Koppeling tussen emissiereducerende staltechnieken en stalbeschrijvingen (N:N).
 */
CREATE TABLE farm_reductive_lodging_systems_to_lodging_system_definitions (
	farm_reductive_lodging_system_id integer NOT NULL,
	farm_lodging_system_definition_id integer NOT NULL,

	CONSTRAINT farm_reductive_lodging_systems_to_definitions_pkey PRIMARY KEY (farm_reductive_lodging_system_id, farm_lodging_system_definition_id),
	CONSTRAINT farm_reductive_lodging_systems_to_definitions_fkey_reductive FOREIGN KEY (farm_reductive_lodging_system_id) REFERENCES farm_reductive_lodging_systems,
	CONSTRAINT farm_reductive_lodging_systems_to_definitions_fkey_defs FOREIGN KEY (farm_lodging_system_definition_id) REFERENCES farm_lodging_system_definitions
);


/*
 * farm_lodging_fodder_measures
 * ----------------------------
 * Voer- en managementmaatregelen; zie http://wetten.overheid.nl/BWBR0013629/geldigheidsdatum_11-06-2015#Bijlage2
 * en http://www.infomil.nl/onderwerpen/landbouw-tuinbouw/ammoniak/rav/pas-maatregelen/alle-pas-maatregelen/
 * Dit zijn maatregelen die zorgen voor minder emissies en toegepast kunnen worden op een stalsysteem (farm_lodging_type).
 */
CREATE TABLE farm_lodging_fodder_measures (
	farm_lodging_fodder_measure_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT farm_lodging_fodder_measures_pkey PRIMARY KEY (farm_lodging_fodder_measure_id)
);


/*
 * farm_lodging_fodder_measure_reduction_factors
 * ---------------------------------------------
 * Bevat de reductie factoren (factor 0..1) van de voer- en managementmaatregelen.
 * Als er maatregelen op een stalsysteem worden toegepast, wordt van de combinatie van maatregelen eerst een enkele reductiefactor bepaalt. Deze reductiefactor
 * wordt vervolgens toegepast op de totale emissie van het stalsysteem waarop gestapeld wordt, inclusief eventuele additionele en emissiereducerende
 * staltechnieken die hierop gestapeld zijn.
 *
 * @column reduction_factor_floor De reductiefactor voor de emissie vanaf de vloer
 * @column reduction_factor_cellar De reductiefactor voor de emissie uit de mestkelder
 * @column reduction_factor_total De gecombineerde reductiefactor voor de emissie vanaf de vloer en uit de mestkelder
 */
CREATE TABLE farm_lodging_fodder_measure_reduction_factors (
	farm_lodging_fodder_measure_id integer NOT NULL,
	substance_id smallint NOT NULL,
	reduction_factor_floor fraction NOT NULL,
	reduction_factor_cellar fraction NOT NULL,
	reduction_factor_total fraction NOT NULL,

	CONSTRAINT farm_lodging_fodder_measure_reduction_factors_pkey PRIMARY KEY (farm_lodging_fodder_measure_id, substance_id),
	CONSTRAINT farm_lodging_fodder_measure_reduction_factors_fkey_measures FOREIGN KEY (farm_lodging_fodder_measure_id) REFERENCES farm_lodging_fodder_measures,
	CONSTRAINT farm_lodging_fodder_measure_reduction_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances,

	CONSTRAINT farm_lodging_fodder_measure_reduction_factors_chk_factotal CHECK (CASE WHEN reduction_factor_floor = reduction_factor_cellar THEN reduction_factor_total = reduction_factor_floor ELSE reduction_factor_total <= reduction_factor_floor + reduction_factor_cellar END)
);


/*
 * farm_lodging_fodder_measures_animal_category
 * --------------------------------------------
 * De diercategorieën van de stalsystemen waarop een maatregel mag worden toegepast, en de bijbehorende verhouding van de ammoniakemissie afkomstig van de vloer en
 * uit de mestkelder welke de verdeling van reductiefactoren bepaalt.
 * De ammoniakverhouding voor alle maatregelen moet altijd gelijk zijn, wat impliceert dat alle gekozen maatregelen moeten gelden voor dezelfde diercategorie: dat
 * van het het stalsysteem. Met andere woorden, een maatregel reduceert alleen de emissies van een stalsysteem als deze kan worden toegepast op de diercategorie
 * van het stalsysteem.
 *
 * @column proportion_floor Het aandeel van de totale ammoniakemissie afkomstig van de vloer voor deze combinatie van maatregel en diercategorie
 * @column proportion_cellar Het aandeel van de totale ammoniakemissie uit de mestkelder voor deze combinatie van maatregel en diercategorie
 */
CREATE TABLE farm_lodging_fodder_measures_animal_category (
	farm_lodging_fodder_measure_id integer NOT NULL,
	farm_animal_category_id integer NOT NULL,
	proportion_floor fraction NOT NULL,
	proportion_cellar fraction NOT NULL,

	CONSTRAINT farm_lodging_fodder_measures_animal_category_pkey PRIMARY KEY (farm_lodging_fodder_measure_id, farm_animal_category_id),
	CONSTRAINT farm_lodging_fodder_measures_animal_category_fkey_measures FOREIGN KEY (farm_lodging_fodder_measure_id) REFERENCES farm_lodging_fodder_measures,
	CONSTRAINT farm_lodging_fodder_measures_animal_category_fkey_animalcat FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories,

	CONSTRAINT farm_lodging_fodder_measures_animal_category_chk_proportions CHECK (proportion_floor + proportion_cellar = 1.0)
);
