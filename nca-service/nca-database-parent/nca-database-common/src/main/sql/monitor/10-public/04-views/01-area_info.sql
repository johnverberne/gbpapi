/*
 * non_exceeding_receptors_view
 * ----------------------------
 * Lijst met OR relevante receptoren waar de KDW niet overschreden dreigt te worden.
 * LET OP: deze functie is pas na de database build te gebruiken. Tijdens de build wordt de override tabel namelijk gevuld.
 *
 * Bepaald door:
 * - Begin met all receptoren op een relevant (aangewezen) habitat-gebied (included_receptors)
 * - Filter alle receptoren er uit waarbij de KDW na realisatie van de behoefte dreigt overschreden te worden (exceeding_receptors)
 * - Filter alle receptoren er uit die niet in een pas gebied vallen of niet uitgesloten zijn als PAS relevant (override_relevant_development_space_receptors)
 */
CREATE OR REPLACE VIEW non_exceeding_receptors_view AS
SELECT receptor_id
	FROM included_receptors		
		LEFT JOIN exceeding_receptors USING (receptor_id)
		LEFT JOIN override_relevant_development_space_receptors USING (receptor_id)
	
	WHERE
		exceeding_receptors.receptor_id IS NULL
		AND override_relevant_development_space_receptors.receptor_id IS NULL
;


/*
 * designated_habitat_properties_view
 * ----------------------------------
 * Geeft de aangewezen habitattypen in het toetsgebied inclusief eigenschappen zoals coverage, oppervlakte en doelstellingen indien beschikbaar.
 * Geeft alleen gekarteerde habitattypes terug.
 */
CREATE OR REPLACE VIEW designated_habitat_properties_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	name AS habitat_type_name,
	description AS habitat_type_description,
	ST_Area(geometry)::real AS surface,
	habitat_quality_type,
	quality_goal,
	extent_goal

	FROM habitats
		INNER JOIN designated_habitats_view USING (assessment_area_id, habitat_type_id)
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_properties_view USING (habitat_type_id, assessment_area_id)
;


/*
 * designated_unmapped_habitat_properties_view
 * -------------------------------------------
 * Geeft de aangewezen habitattypen in het toetsgebied inclusief eigenschappen zoals coverage, oppervlakte en doelstellingen indien beschikbaar.
 * Geeft alleen niet gekarteerde habitattypes terug.
 */
CREATE OR REPLACE VIEW designated_unmapped_habitat_properties_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	name AS habitat_type_name,
	description AS habitat_type_description,
	habitat_quality_type,
	quality_goal,
	extent_goal

	FROM
		(SELECT DISTINCT
			assessment_area_id,
			habitat_type_relations.goal_habitat_type_id AS habitat_type_id

			FROM designated_habitats_view
				INNER JOIN habitat_type_relations USING (habitat_type_id)
				LEFT JOIN
					(SELECT DISTINCT
						assessment_area_id,
						goal_habitat_type_id

						FROM designated_habitat_properties_view
							INNER JOIN habitat_type_relations USING (habitat_type_id)
					) AS designated_mapped_goal_habitats USING (assessment_area_id, goal_habitat_type_id)

			WHERE designated_mapped_goal_habitats.goal_habitat_type_id IS NULL
		) AS designated_unmapped_goal_habitats

		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_properties_view USING (habitat_type_id, assessment_area_id)
;


/*
 * habitat_info_for_receptor_view
 * ------------------------------
 * Geeft de habitattypen op een receptor inclusief eigenschappen zoals coverage en oppervlakte van de habitattype op de receptor en de PAS category binnen het natuurgebied.
 * Toepassing:
 * - Webapp Monitor Gebiedsinformatie voor Puntlocatie tabblad Habitattypen
 * Gebruik 'receptor_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW habitat_info_for_receptor_view AS
SELECT
	receptor_id,
	habitat_info_for_assessment_area_view.*

	FROM receptors_to_habitats_view
		INNER JOIN habitat_info_for_assessment_area_view USING (assessment_area_id, habitat_type_id)
;


/*
 * relevant_goal_habitat_complete_info_view
 * ----------------------------------------
 * Geeft de doelstelling habitattypen in het toetsgebied inclusief eigenschappen zoals coverage, oppervlakte en doelstellingen indien beschikbaar.
 * Geeft zowel gekarteerde als niet gekarteerde habitattypes terug.
 * Geeft ook aan of het habitat type is aangewezen binnen het natuurgebied.
 *
 * Toepassingen:
 * - Gebiedssamenvatting PDF, [Hoofdstuk 2] Beschermde habitattypen en leefgebieden, Aangewezen habitattypen (tabel)
 * Gebruik 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW relevant_goal_habitat_complete_info_view AS
SELECT
	assessment_area_id,
	goal_habitat_type_id,
	name AS habitat_type_name,
	description AS habitat_type_description,
	substance_id,
	result_type,
	critical_level,
	designated,
	ae_weighted_avg(coverage::numeric, surface::numeric)::real AS coverage,
	SUM(surface) AS surface,
	SUM(cartographic_surface) AS cartographic_surface,
	ae_weighted_avg(relevant_coverage::numeric, surface::numeric)::real AS relevant_coverage, -- We gebruiken hier (net zoals in build_relevant_receptors_view) de surface als weight (ipv de relevant_surface) voor het gewogen gemiddelde.
	SUM(relevant_surface) AS relevant_surface,
	SUM(relevant_cartographic_surface) AS relevant_cartographic_surface,
	habitat_quality_type,
	quality_goal,
	extent_goal

	FROM
		(SELECT	-- designated and mapped
			assessment_area_id,
			habitat_type_id,
			designated,
			coverage,
			surface, -- ingetekend totaal oppervlak
			cartographic_surface, -- gekarteerd totaal oppervlak
			relevant_coverage,
			relevant_surface, -- ingetekend relevant oppervlak
			relevant_cartographic_surface, -- gekarteerd relevant oppervlak
			habitat_quality_type,
			quality_goal,
			extent_goal

			FROM habitat_info_for_assessment_area_view

			WHERE relevant_surface > 0

		UNION ALL
		SELECT	-- designated but not mapped
			assessment_area_id,
			habitat_type_id,
			TRUE AS designated,
			NULL AS coverage,
			NULL AS surface, -- ingetekend totaal oppervlak
			NULL AS cartographic_surface, -- gekarteerd totaal oppervlak
			NULL AS relevant_coverage,
			NULL AS relevant_surface, -- ingetekend relevant oppervlak
			NULL AS relevant_cartographic_surface, -- gekarteerd relevant oppervlak
			habitat_quality_type,
			quality_goal,
			extent_goal

			FROM designated_unmapped_habitat_properties_view
				INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)

			WHERE sensitive IS TRUE
		) AS habitat_complete

		INNER JOIN 
			(SELECT
				habitat_type_relations.habitat_type_id,
				goal_habitat_type_id,
				name,
				description,
				substance_id,
				result_type,
				critical_level,
				sensitive

				FROM habitat_type_relations
					INNER JOIN habitat_types AS goal_habitat_types ON (goal_habitat_types.habitat_type_id = habitat_type_relations.goal_habitat_type_id)
					INNER JOIN habitat_type_critical_levels ON (habitat_type_critical_levels.habitat_type_id = habitat_type_relations.goal_habitat_type_id)
			) AS goal_habitat_types_view USING (habitat_type_id)

	GROUP BY
		assessment_area_id,
		goal_habitat_type_id,
		name,
		description,
		substance_id,
		result_type,
		critical_level,
		-- onderstaande velden zouden (per assessment_area_id en goal_habitat_type) altijd gelijk moeten zijn
		designated,
		habitat_quality_type,
		quality_goal,
		extent_goal
;


/*
 * species_habitat_info_for_assessment_area_view
 * ---------------------------------------------
 * Geeft de aangewezen soorten in het toetsgebied inclusief eigenschappen zoals doelstellingen
 * en eventuele koppelingen met leefgebieden/habitattypes.
 * Toepassing:
 * - Gebiedssamenvatting PDF, [Hoofdstuk 2] Beschermde habitattypen en leefgebieden, Leefgebieden van aangewezen soorten (tabel)
 * Gebruik 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW species_habitat_info_for_assessment_area_view AS
SELECT
	assessment_area_id,
	species_id,
	species.name AS species_name,
	species.description AS species_description,
	species_type,
	population_goal,
	population_goal_description,
	species_properties.quality_goal AS species_quality_goal,
	species_properties.extent_goal AS species_extent_goal,
	habitats_view.habitat_type_id, -- keep prefix: should be NULL if unmapped
	habitats_view.name AS habitat_type_name,
	habitats_view.description AS habitat_type_description,
	designated,
	substance_id,
	result_type,
	critical_level,
	coverage,
	surface,
	cartographic_surface,
	relevant_coverage,
	relevant_surface,
	relevant_cartographic_surface,
	habitat_quality_type,
	habitat_properties_view.quality_goal,
	habitat_properties_view.extent_goal

	FROM designated_species_to_habitats_view
		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN species USING (species_id)
		INNER JOIN species_properties USING (assessment_area_id, species_id)
		LEFT JOIN habitats_view USING (assessment_area_id, habitat_type_id)
		LEFT JOIN habitat_properties_view USING (assessment_area_id, habitat_type_id)
		LEFT JOIN habitat_type_critical_levels USING (habitat_type_id)

;


/*
 * species_habitat_info_for_receptor_view
 * --------------------------------------
 * Geeft de aangewezen soorten op het receptor inclusief eigenschappen zoals doelstellingen
 * en koppelingen met leefgebieden/habitattypes.
 * Toepassing:
 * - Webapp Monitor Gebiedsinformatie voor Puntlocatie
 * Gebruik 'receptor_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW species_habitat_info_for_receptor_view AS
SELECT
	receptor_id,
	species_habitat_info_for_assessment_area_view.*

	FROM receptors_to_habitats_view
		INNER JOIN species_habitat_info_for_assessment_area_view USING (assessment_area_id, habitat_type_id)
;
