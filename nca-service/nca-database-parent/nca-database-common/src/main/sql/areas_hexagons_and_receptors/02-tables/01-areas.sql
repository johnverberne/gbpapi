/*
 * countries
 * ---------
 * Landen. Bevat een code (voor gebruik in URL en dergelijke) en een (uitgebreidere) naam/beschrijving.
 */
CREATE TABLE countries (
	country_id integer NOT NULL,
	code text NOT NULL,
	name text NOT NULL,

	CONSTRAINT countries_pkey PRIMARY KEY (country_id),
	CONSTRAINT countries_code_unique UNIQUE (code)
);


/*
 * authorities
 * -----------
 * Bevoegde gezagen. Bevat een code (voor gebruik in URL en dergelijke) en een (uitgebreidere) naam/beschrijving en type.
 */
CREATE TABLE authorities (
	authority_id integer NOT NULL,
	country_id integer NOT NULL,
	code text NOT NULL,
	name text NOT NULL,
	type authority_type NOT NULL,

	CONSTRAINT authorities_pkey PRIMARY KEY (authority_id),
	CONSTRAINT authorities_code_unique UNIQUE (code),
	CONSTRAINT authorities_fkey_countries FOREIGN KEY (country_id) REFERENCES countries
);


/*
 * submitting_authorities
 * ----------------------
 * Subset van bevoegde gezagen die gelden als mogelijke opvoerders.
 * Een opvoerder is een bevoegd gezag die prioritaire projecten mag aandragen.
 */
CREATE TABLE submitting_authorities (
	authority_id integer NOT NULL,

	CONSTRAINT submitting_authorities_pkey PRIMARY KEY (authority_id),
	CONSTRAINT submitting_authorities_fkey_authorities FOREIGN KEY (authority_id) REFERENCES authorities
);


/*
 * assessment_areas
 * ----------------
 * Parent tabel voor toetsgebieden. Bevat zelf geen fysieke records.
 *     1..10000 = N2000 gebieden (in natura2000_areas) (1000+ = buitenland)
 * 10001..20000 = N2000 deelgebieden (in natura2000_directive_areas)
 */
CREATE TABLE assessment_areas
(
	assessment_area_id integer NOT NULL,
	type assessment_area_type NOT NULL,
	name text NOT NULL,
	code text NOT NULL,
	authority_id integer NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT assessment_areas_pkey PRIMARY KEY (assessment_area_id),
	CONSTRAINT assessment_areas_fkey_authorities FOREIGN KEY (authority_id) REFERENCES authorities,
	CONSTRAINT assessment_areas_code_unique UNIQUE (code)
);

CREATE INDEX idx_assessment_areas_geometry_gist ON assessment_areas USING GIST (geometry);
CREATE INDEX idx_assessment_areas_name ON assessment_areas (name);


/*
 * natura2000_areas
 * ----------------
 * Natura 2000 gebieden met bevoegd gezag en geometrie. De ID's zijn de officiele Natura 2000 gebiedsnummers.
 * De geometrie is gelijk aan de ST_Union van alle deelgebieden (natura2000_directive_areas) van dat gebied.
 */
CREATE TABLE natura2000_areas
(
	natura2000_area_id integer NOT NULL,

	CONSTRAINT natura2000_areas_pkey PRIMARY KEY (natura2000_area_id)

) INHERITS (assessment_areas);

CREATE UNIQUE INDEX idx_natura2000_areas_assessment_area_id ON natura2000_areas (assessment_area_id);
CREATE INDEX idx_natura2000_areas_geometry_gist ON natura2000_areas USING GIST (geometry);
CREATE INDEX idx_natura2000_areas_name ON natura2000_areas (name);


/*
 * natura2000_area_properties
 * --------------------------
 * Kenschets-gerelateerde eigenschappen van een N2000 gebied.
 *
 * Registered_surface is de oppervlakte in het aanwijsbesluit.
 */
CREATE TABLE natura2000_area_properties (
	natura2000_area_id integer NOT NULL,
	landscape_type landscape_type NOT NULL,
	registered_surface bigint NOT NULL,

	CONSTRAINT natura2000_area_properties_pkey PRIMARY KEY (natura2000_area_id),
	CONSTRAINT natura2000_area_properties_fkey_natura2000_areas FOREIGN KEY (natura2000_area_id) REFERENCES natura2000_areas
);


/*
 * natura2000_directive_areas
 * --------------------------
 * De deelgebieden van de Natura 2000 gebieden met elk hun ontwerp-status en (habitat- en vogel-) richtlijnen.
 */
CREATE TABLE natura2000_directive_areas
(
	natura2000_directive_area_id integer NOT NULL,
	natura2000_area_id integer NOT NULL,
	bird_directive boolean NOT NULL,
	habitat_directive boolean NOT NULL,
	design_status text NOT NULL,

	CONSTRAINT natura2000_directive_areas_pkey PRIMARY KEY (natura2000_directive_area_id),
	CONSTRAINT natura2000_directive_areas_fkey_natura2000_areas FOREIGN KEY (natura2000_area_id) REFERENCES natura2000_areas
	--CONSTRAINT natura2000_directive_areas_check_directive CHECK ((bird_directive = TRUE) OR (habitat_directive = TRUE))
) INHERITS (assessment_areas);

CREATE UNIQUE INDEX idx_natura2000_directive_areas_assessment_area_id ON natura2000_directive_areas (assessment_area_id);
CREATE INDEX idx_natura2000_directive_areas_geometry_gist ON natura2000_directive_areas USING GIST (geometry);
CREATE INDEX idx_natura2000_directive_areas_name ON natura2000_directive_areas (name);


/*
 * pas_assessment_areas
 * --------------------
 * Tabel die aangeeft welke assessment areas PAS-gebieden zijn.
 */
CREATE TABLE pas_assessment_areas (
	assessment_area_id integer NOT NULL,

	CONSTRAINT pas_assessment_areas_pkey PRIMARY KEY (assessment_area_id)
);


/*
 * habitat_types
 * -------------
 * De vastgelegde habitattypes met karakteristieken zoals identificatie, omschrijving en KDW.
 */
CREATE TABLE habitat_types
(
	habitat_type_id integer NOT NULL,
	name text NOT NULL,
	description text NOT NULL,

	CONSTRAINT habitat_types_pkey PRIMARY KEY (habitat_type_id)
);

CREATE UNIQUE INDEX idx_habitat_types_name ON habitat_types (name);


/*
 * habitat_type_critical_levels
 * ----------------------------
 * Kritische waarden van de aangewezen habitattypes per stof en emissie-result-type.
 * LET OP: Er moet een waarde voor stof 1711 "deposition" opgegeven zijn.
 */
CREATE TABLE habitat_type_critical_levels (
	habitat_type_id integer NOT NULL,
	substance_id smallint NOT NULL,
	result_type emission_result_type NOT NULL,
	critical_level posreal NOT NULL,
	sensitive boolean NOT NULL DEFAULT FALSE,

	CONSTRAINT habitat_type_critical_levels_pkey PRIMARY KEY (habitat_type_id, substance_id, result_type),
	CONSTRAINT habitat_type_critical_levels_fkey_habitat_types FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
	--CONSTRAINT habitat_type_critical_levels_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * habitat_properties
 * ------------------
 * Eigenschappen van de aangewezen habitattypes per natuurgebied.
 * Te weten: Kwaliteitscategorie, doelstelling kwaliteit, doelstelling oppervlakte.
 */
CREATE TABLE habitat_properties (
	goal_habitat_type_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	habitat_quality_type ecology_quality_type NOT NULL,
	quality_goal habitat_goal_type NOT NULL,
	extent_goal habitat_goal_type NOT NULL,

	CONSTRAINT habitat_properties_pkey PRIMARY KEY (goal_habitat_type_id, assessment_area_id),
	CONSTRAINT habitat_properties_fkey_habitat_types FOREIGN KEY (goal_habitat_type_id) REFERENCES habitat_types (habitat_type_id)
);


/*
 * habitat_type_relations
 * ----------------------
 * Habitattypes kunnen subtypes zijn.
 * Zo zijn er H1330A en ZGH1330A, welke beide tot het doelstellings-habitattype H1330A behoren.
 * Deze "parent-child" relatie is vastgelegd in deze tabel.
 * Een habitattype kan slechts 1 doelstellingstype hebben. Veel habitattypes hebben zichzelf als doelstellingstype.
 */
CREATE TABLE habitat_type_relations
(
	habitat_type_id integer NOT NULL UNIQUE,
	goal_habitat_type_id integer NOT NULL,

	CONSTRAINT habitat_type_relations_pkey PRIMARY KEY (habitat_type_id, goal_habitat_type_id),
	CONSTRAINT habitat_type_relations_fkey_habitat_types FOREIGN KEY (habitat_type_id) REFERENCES habitat_types,
	CONSTRAINT habitat_type_relations_fkey_goal_habitat_types FOREIGN KEY (goal_habitat_type_id) REFERENCES habitat_types (habitat_type_id)
);


/*
 * habitat_areas
 * -------------
 * Habitatgebieden per toetsgebied. Een habitatgebied heeft een habitattype en een bedekkingsfactor. Deze factor wordt gebruikt bij oppervlakteberekeningen.
 */
CREATE TABLE habitat_areas
(
	assessment_area_id integer NOT NULL,
	habitat_area_id integer NOT NULL,
	habitat_type_id integer NOT NULL,
	coverage fraction NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT habitat_areas_pkey PRIMARY KEY (habitat_area_id),
	CONSTRAINT habitat_areas_fkey_habitat_types FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
);

CREATE INDEX idx_habitat_areas_geometry_gist ON habitat_areas USING GIST (geometry);
CREATE INDEX idx_habitat_areas_assessment_area_id ON habitat_areas (assessment_area_id);
CREATE INDEX idx_habitat_areas_habitat_type_id ON habitat_areas (habitat_type_id);


/*
 * relevant_habitat_areas
 * ----------------------
 * De relevante delen van de habitatgebieden per toetsgebied.
 */
CREATE TABLE relevant_habitat_areas
(
	assessment_area_id integer NOT NULL,
	habitat_area_id integer NOT NULL,
	habitat_type_id integer NOT NULL,
	coverage fraction NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT relevant_habitat_areas_pkey PRIMARY KEY (habitat_area_id),
	CONSTRAINT relevant_habitat_areas_fkey_habitat_types FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
);

CREATE INDEX idx_relevant_habitat_areas_geometry_gist ON relevant_habitat_areas USING GIST (geometry);
CREATE INDEX idx_relevant_habitat_areas_assessment_area_id ON relevant_habitat_areas (assessment_area_id);
CREATE INDEX idx_relevant_habitat_areas_habitat_type_id ON relevant_habitat_areas (habitat_type_id);


/*
 * habitats
 * --------
 * Habitatgebieden samengevoegd naar toetsgebied met habitattype niveau.
 * De geometrie is de combinatie van alle uitsnedes van dat type.
 */
CREATE TABLE habitats
(
	assessment_area_id integer NOT NULL,
	habitat_type_id integer NOT NULL,
	coverage fraction NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT habitats_pkey PRIMARY KEY (assessment_area_id, habitat_type_id),
	CONSTRAINT habitats_fkey_habitat_types FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
);

CREATE INDEX idx_habitats_geometry_gist ON habitats USING GIST (geometry);
CREATE INDEX idx_habitats_habitat_type_id ON habitats (habitat_type_id);


/*
 * relevant_habitats
 * -----------------
 * De relevante delen van de samengevoegde habitatgebieden.
 * Een relevant habitatgebied heeft een habitattype een bedekkingsfactor. Deze factor wordt gebruikt bij oppervlakteberekeningen.
 * Er is geen rechtstreekse koppeling met Natura 2000 gebieden, hiervoor moet een spatial query worden uitgevoerd.
 */
CREATE TABLE relevant_habitats
(
	assessment_area_id integer NOT NULL,
	habitat_type_id integer NOT NULL,
	coverage fraction NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT relevant_habitats_pkey PRIMARY KEY (assessment_area_id, habitat_type_id),
	CONSTRAINT relevant_habitats_fkey_habitat_types FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
);

CREATE INDEX idx_relevant_habitats_geometry_gist ON relevant_habitats USING GIST (geometry);
CREATE INDEX idx_relevant_habitats_habitat_type_id ON relevant_habitats (habitat_type_id);


/*
 * species
 * -------
 * Soorten welke in een leefgebied (specifiek habitattype) voorkomen.
 * Dit kunnen zijn habitatsoorten, broedvogelsoorten en niet-broedvogelsoorten.
 * Een vogelsoort kan zowel als broedvogelsoorten en als niet-broedvogelsoorten in deze lijst voorkomen.
 */
CREATE TABLE species
(
	species_id integer NOT NULL,
	name text NOT NULL,
	description text NOT NULL,
	species_type species_type NOT NULL,

	CONSTRAINT species_pkey PRIMARY KEY (species_id)
);

CREATE UNIQUE INDEX idx_species_name ON species (name, species_type);


/*
 * species_properties
 * ------------------
 * Eigenschappen van de aangewezen soorten per natuurgebied met de doelstellingen voor die soorten,
 * te weten: Doelstelling kwaliteit leefgebied, doelstelling omvang leefgebied, doelstelling populatie.
 * De populatie doelstelling is voor de niet broedvogels als text opgegeven. De population_goal moet in dit geval 'specified' zijn.
 * In alle andere gevallen mag de doeltellingen niet gelijk zijn aan 'specified'. Dit laatste geld ook voor alle andere (type) doelstellingen.
 */
CREATE TABLE species_properties (
	species_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	quality_goal habitat_goal_type NOT NULL CHECK (quality_goal <> 'specified'),
	extent_goal habitat_goal_type NOT NULL CHECK (extent_goal <> 'specified'),
	population_goal habitat_goal_type NOT NULL CHECK ((population_goal <> 'specified' AND population_goal_description IS NULL)
														OR (population_goal = 'specified' AND population_goal_description IS NOT NULL)),
	population_goal_description text, -- TODO: need some refactoring

	CONSTRAINT species_properties_pkey PRIMARY KEY (species_id, assessment_area_id),
	CONSTRAINT species_properties_fkey_species FOREIGN KEY (species_id) REFERENCES species
);


/*
 * designated_species
 * ------------------
 * Aangewezen soorten per toetsingsgebied.
 */
CREATE TABLE designated_species
(
	species_id integer NOT NULL,
	assessment_area_id integer NOT NULL,

	CONSTRAINT designated_species_pkey PRIMARY KEY (species_id, assessment_area_id),
	CONSTRAINT designated_species_fkey_assessment_areas FOREIGN KEY (assessment_area_id) REFERENCES natura2000_areas (assessment_area_id), -- Currently limited to N2000. Can't reference base table 'assessment_areas'.
	CONSTRAINT designated_species_fkey_species FOREIGN KEY (species_id) REFERENCES species
);


/*
 * species_to_habitats
 * -------------------
 * De soorten welke in een habitattype kunnen voorkomen.
 */
CREATE TABLE species_to_habitats
(
	species_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	goal_habitat_type_id integer NOT NULL,

	CONSTRAINT species_to_habitats_pkey PRIMARY KEY (species_id, assessment_area_id, goal_habitat_type_id),
	CONSTRAINT species_to_habitats_fkey_species FOREIGN KEY (species_id) REFERENCES species,
	CONSTRAINT species_to_habitats_fkey_assessment_areas FOREIGN KEY (assessment_area_id) REFERENCES natura2000_areas (assessment_area_id), -- Currently limited to N2000. Can't reference base table 'assessment_areas'.
	CONSTRAINT species_to_habitats_fkey_habitat_types FOREIGN KEY (goal_habitat_type_id) REFERENCES habitat_types (habitat_type_id)
);


/*
 * province_areas
 * --------------
 * Provincies in Nederland.
 * Er is een bevoegd gezag voor iedere provincie; deze koppeling staat ook in deze tabel.
 */
CREATE TABLE province_areas
(
	province_area_id integer NOT NULL,
	name text NOT NULL,
	authority_id integer NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT province_areas_pkey PRIMARY KEY (province_area_id),
	CONSTRAINT province_areas_fkey_authorities FOREIGN KEY (authority_id) REFERENCES authorities
);

CREATE INDEX idx_province_areas_geometry_gist ON province_areas USING GIST (geometry);
CREATE INDEX idx_province_areas_name ON province_areas (name);


/*
 * assessment_areas_to_province_areas
 * ----------------------------------
 * Koppeltabel tussen toetsgebieden (natura2000 gebieden) en provincies.
 */
CREATE TABLE assessment_areas_to_province_areas
(
	province_area_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	distance posreal NOT NULL,

	CONSTRAINT assessment_areas_to_province_areas_pkey PRIMARY KEY (province_area_id, assessment_area_id)
);
