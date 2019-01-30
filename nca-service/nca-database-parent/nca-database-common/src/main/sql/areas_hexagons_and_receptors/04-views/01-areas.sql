/*
 * habitat_type_critical_depositions_view
 * --------------------------------------
 * Geeft de KDW van een habitat type terug.
 */
CREATE OR REPLACE VIEW habitat_type_critical_depositions_view AS
SELECT
	habitat_type_id,
	critical_level AS critical_deposition,
	sensitive

	FROM habitat_type_critical_levels
	
	WHERE
		substance_id= 1711
		AND result_type = 'deposition'
;


/*
 * goal_habitat_types_view
 * -----------------------
 * Geeft de eigenschappen van het doelstellingstype (goal_habitat_type) per onderliggend habitat-type.
 */
CREATE OR REPLACE VIEW goal_habitat_types_view AS
SELECT
	habitat_type_relations.habitat_type_id,
	goal_habitat_type_id,
	name,
	description,
	critical_deposition,
	sensitive

	FROM habitat_type_relations
		INNER JOIN habitat_types AS goal_habitat_types ON (goal_habitat_types.habitat_type_id = habitat_type_relations.goal_habitat_type_id)
		INNER JOIN habitat_type_critical_depositions_view ON (habitat_type_critical_depositions_view.habitat_type_id = habitat_type_relations.goal_habitat_type_id)
;


/*
 * habitat_properties_view
 * -----------------------
 * Geeft de eigenschappen van een habitat in een natuurgebied weer.
 * Hierbij wordt gekeken naar de waarden van de parent HT volgens de habitat_type_relations tabel.
 */
CREATE OR REPLACE VIEW habitat_properties_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	habitat_quality_type,
	quality_goal,
	extent_goal

	FROM habitat_properties
		INNER JOIN habitat_type_relations USING (goal_habitat_type_id)
;


/*
 * species_to_habitats_view
 * ------------------------
 * Geeft per soort aan binnen welk natuurgebied/habitat type deze voorkomt.
 * Hierbij wordt gekeken naar de waarden van de parent HT volgens de habitat_type_relations tabel.
 */
CREATE OR REPLACE VIEW species_to_habitats_view AS
SELECT
	species_id,
	assessment_area_id,
	habitat_type_id

	FROM species_to_habitats
		INNER JOIN habitat_type_relations USING (goal_habitat_type_id)
;


/*
 * designated_habitats_view
 * ------------------------
 * Bepaalt de aangewezen habitat types per natuurgebied.
 * Hierbij wordt rekening gehouden met relaties op basis van habitat_type_relations.
 */
CREATE OR REPLACE VIEW designated_habitats_view AS
SELECT
	assessment_area_id,
	habitat_type_id

	FROM habitat_properties_view

	WHERE NOT (quality_goal = 'none' AND extent_goal = 'none')
;


/*
 * designated_species_to_habitats_view
 * -----------------------------------
 * Bepaalt de aangewezen (vogel)soorten per habitat type en natuurgebied.
 * Hierbij wordt rekening gehouden met relaties op basis van habitat_type_relations.
 */
CREATE OR REPLACE VIEW designated_species_to_habitats_view AS
SELECT
	species_id,
	assessment_area_id,
	habitat_type_id

	FROM species_to_habitats_view
		INNER JOIN designated_species USING (species_id, assessment_area_id)
;


/*
 * critical_deposition_areas_view
 * ------------------------------
 * Verzamelt de KDW-gebieden met bijbehorend type, KDW, en of deze aangewezen is.
 * Het gaat hier om (relevante) habitatgebieden.
 */
CREATE OR REPLACE VIEW critical_deposition_areas_view AS
SELECT
	assessment_area_id,
	'habitat'::critical_deposition_area_type AS type,
	habitat_type_id AS critical_deposition_area_id,
	name,
	description,
	critical_deposition,
	FALSE AS relevant, -- Het gaat NIET om de relevant_habitats
	sensitive,
	coverage,
	geometry

	FROM habitats
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
UNION ALL
SELECT
	assessment_area_id,
	'relevant_habitat'::critical_deposition_area_type AS type,
	habitat_type_id AS critical_deposition_area_id,
	name,
	description,
	critical_deposition,
	TRUE AS relevant, -- Het gaat om de relevant_habitats
	sensitive,
	coverage,
	geometry

	FROM relevant_habitats
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
;

/*
 * assessment_areas_to_province_areas_view
 * ---------------------------------------
 * Bepaalt de toetsgebied - provincie koppeling, waarbij het toetsgebied (gedeeltelijk) in de provincie moet liggen.
 */
CREATE OR REPLACE VIEW assessment_areas_to_province_areas_view AS
SELECT
	assessment_area_id,
	province_area_id

	FROM assessment_areas_to_province_areas

	WHERE distance = 0;
;

/*
 * non_species_areas_filter_view
 * -----------------------------
 * Lelijke filter-view om ervoor te zorgen dat habitat types waarvan de naam begint met LG (leefgebieden) niet mee worden genomen in een view...
 */
CREATE OR REPLACE VIEW non_species_areas_filter_view AS
SELECT
	habitat_type_id

	FROM habitat_types

	WHERE NOT name ILIKE 'LG%'
;


/*
 * authorities_view
 * ----------------
 * Geeft extra informatie over de bevoegde gezagen terug. De gezagen die mogelijk zijn als opvoerder zijn aangegeven.
 * De resultaten zijn gesorteerd op type dan naam (en daardoor geschikt voor weergave in de UI).
 */
CREATE OR REPLACE VIEW authorities_view AS
SELECT
	authority_id,
	country_id,
	code,
	name,
	type,
	(type = 'foreign') AS foreign_authority,
	(submitting_authorities.authority_id IS NOT NULL) AS submitting_authority

	FROM authorities
		LEFT JOIN submitting_authorities USING (authority_id)

	ORDER BY type, name
;
