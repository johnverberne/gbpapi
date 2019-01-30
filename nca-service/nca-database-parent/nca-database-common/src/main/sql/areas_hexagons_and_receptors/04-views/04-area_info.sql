/*
 * assessment_area_ecology_quality_type_view
 * -----------------------------------------
 * View om het ecologisch oordeel voor een natuurgebied te bepalen.
 * Dit gebeurd op basis van de habitat gebieden die gekoppeld zijn aan het natuurgebied via de doelstelling-habitat-typen uit habitat_properties.
 * Mochten er geen habitat_properties aanwezig zijn voor een natuurgebied, dan zal 'unknown' gebruikt worden.
 */
CREATE OR REPLACE VIEW assessment_area_ecology_quality_type_view AS
SELECT
	assessment_area_id,
	COALESCE(MAX(habitat_properties.habitat_quality_type), 'unknown') AS ecology_quality_type

	FROM assessment_areas
		LEFT JOIN habitat_properties USING (assessment_area_id)

	GROUP BY assessment_area_id
;


/*
 * assessment_area_directive_view
 * ------------------------------
 * Geeft per toetsgebied de richtlijnen (enumeratiewaarde) en ontwerpstatus. Dit zijn eigenschappen van de deelgebieden van het N2000 gebied. Deze
 * informatie wordt samengevoegd tot een N2000 eigenschap. De view geldt indirect dus alleen voor N2000 gebieden.
 */
CREATE OR REPLACE VIEW assessment_area_directive_view AS
SELECT
	natura2000_areas.assessment_area_id,
	natura2000_directive_areas.natura2000_area_id,
	ae_get_natura2000_directive_type(bool_or(bird_directive), bool_or(habitat_directive)) AS directive,
	array_to_string(array_agg(DISTINCT natura2000_directive_areas.design_status), ', ') AS design_status

	FROM natura2000_directive_areas
		INNER JOIN natura2000_areas USING (natura2000_area_id)

	GROUP BY natura2000_areas.assessment_area_id, natura2000_area_id
;


/*
 * natura2000_area_info_view
 * -------------------------
 * Algemene informatie over de N2000 gebieden.
 * Gebruik 'assessment_area_id', 'natura2000_area_id' of ST_Intersects(ST_SetSRID(ST_Point(218928, 486793), ae_get_srid()), geometry) in de WHERE-clause.
 */
CREATE OR REPLACE VIEW natura2000_area_info_view AS
SELECT
	assessment_area_id,
	natura2000_area_id,
	natura2000_areas.name,
	assessment_area_directive_view.directive,
	assessment_area_directive_view.design_status,
	authorities.name AS authority,
	natura2000_area_properties.landscape_type,
	assessment_area_ecology_quality_type_view.ecology_quality_type,
	COALESCE(registered_surface, ROUND(ST_Area(natura2000_areas.geometry))::bigint) AS surface,
	Box2D(natura2000_areas.geometry) AS boundingbox,
	natura2000_areas.geometry

	FROM natura2000_areas
		INNER JOIN assessment_area_ecology_quality_type_view USING (assessment_area_id)
		INNER JOIN assessment_area_directive_view USING (assessment_area_id, natura2000_area_id)
		INNER JOIN authorities USING (authority_id)
		LEFT JOIN natura2000_area_properties USING (natura2000_area_id)
;


/*
 * habitats_view
 * -------------
 * Geeft voor een toetsgebied terug welke habitattypes er in liggen (alle habitatgebieden die het toetsgebied raken).
 * Ook de samengestelde geometrie van alle gebieden van het type wordt teruggegeven.
 * Gebruik 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW habitats_view AS
SELECT
	assessment_area_id,
	habitat_types.habitat_type_id,
	habitat_types.name,
	habitat_types.description,
	habitat_type_critical_depositions_view.critical_deposition,
	(relevant_habitats.habitat_type_id IS NOT NULL) AS relevant,
	(designated_habitats_view.habitat_type_id IS NOT NULL) AS designated,

	habitats.coverage,
	ST_Area(habitats.geometry) AS surface, -- ingetekend totaal oppervlak
	ST_Area(habitats.geometry) * habitats.coverage AS cartographic_surface, -- gekarteerd totaal oppervlak
	habitats.geometry,

	(COALESCE(relevant_habitats.coverage, 0))::real AS relevant_coverage,
	(COALESCE(ST_Area(relevant_habitats.geometry), 0))::real AS relevant_surface, -- ingetekend relevant oppervlak
	(COALESCE(ST_Area(relevant_habitats.geometry) * relevant_habitats.coverage, 0))::real AS relevant_cartographic_surface,
	relevant_habitats.geometry AS relevant_geometry

	FROM assessment_areas
		INNER JOIN habitats USING (assessment_area_id)
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
		LEFT JOIN relevant_habitats USING (assessment_area_id, habitat_type_id)
		LEFT JOIN designated_habitats_view USING (assessment_area_id, habitat_type_id)
;


/*
 * relevant_habitat_info_for_receptor_view
 * ---------------------------------------
 * Algemene informatie over habitat gebieden welke een hexagon raken.
 * De surface is de oppervlakte van het habitat-type dat in een hexagon valt. We kijken hierbij niet naar de coverage van de individuele habitat-gebieden.
 * Gebruik 'receptor_id' in de WHERE-clause.
 *
 * Note: Er wordt hierbij geen gebruik gemaakt van een tussentabel omdat de tussentabellen die we tot nog toe gebruiken
 * allemaal gebaseerd zijn op assessment_area. Dit zal dus voor receptoren waar meerdere natuurgbieden liggen met hetzelfde habitat type voor dubbelingen zorgen.
 * Onderstaande view is verder snel genoeg mits deze op basis van een receptor_id wordt gebruikt.
 * Als je deze query herschrijft op een manier die overeenkomt met onderstaande receptors_to_habitats_with_relevant_geometry_view, dan is hij niet meer vooruit te
 * branden op bijv. receptor 7404006.
 */
CREATE OR REPLACE VIEW relevant_habitat_info_for_receptor_view AS
SELECT
	receptor_id,
	habitat_type_id,
	name,
	description,
	substance_id,
	result_type,
	critical_level,
	SUM(surface)::posreal AS surface

	FROM receptors_to_relevant_habitats_view
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_type_critical_levels USING (habitat_type_id)

	GROUP BY receptor_id, habitat_type_id, name, description, substance_id, result_type, critical_level
;


/*
 * receptors_to_habitats_with_relevant_geometry_view
 * -------------------------------------------------
 * Algemene informatie over habitat(type)s welke een hexagon raken.
 * De surface is het percentage van de oppervlakte dat het habitat-type in een hexagon valt. We kijken dus niet naar de coverage van de individuele habitat-gebieden.
 * Een habitat_type_id kan in meerdere assessment_areas voorkomen maar zullen elkaar dan nooit overlappen.
 * Gebruik 'receptor_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW receptors_to_habitats_with_relevant_geometry_view AS
SELECT
	receptor_id,
	assessment_area_id,
	habitat_type_id,
	name,
	description,
	habitats_view.geometry,
	relevant_geometry

	FROM habitats_view
		INNER JOIN receptors_to_habitats_view USING (assessment_area_id, habitat_type_id)
;


/*
 * assessment_area_bounds_view
 * ---------------------------
 * Naam en boundingbox informatie over toetsgebieden.
 * Gebruik assessment_area_id in de WHERE-clause.
 */
CREATE OR REPLACE VIEW assessment_area_bounds_view AS
SELECT
	assessment_area_id,
	name,
	Box2D(geometry) AS boundingbox

	FROM assessment_areas
;


/*
 * habitat_info_for_assessment_area_view
 * -------------------------------------
 * Geeft de habitattypen in het toetsgebied inclusief eigenschappen zoals coverage, oppervlakte en doelstellingen.
 * Toepassingen:
 * - Webapp Calculator Info-popup Natuurgebied hover Habitattype
 * - Webapp Monitor Gebiedsinformatie voor Natuurgebied tabblad Habitattypen
 * Gebruik 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW habitat_info_for_assessment_area_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	name AS habitat_type_name,
	description AS habitat_type_description,
	designated,
	relevant,
	substance_id,
	result_type,
	critical_level,
	coverage,
	surface, -- ingetekend totaal oppervlak
	cartographic_surface, -- gekarteerd totaal oppervlak
	relevant_coverage,
	relevant_surface, -- ingetekend relevant oppervlak
	relevant_cartographic_surface, -- gekarteerd relevant oppervlak
	habitat_quality_type,
	quality_goal,
	extent_goal

	FROM habitats_view
		INNER JOIN habitat_type_critical_levels USING (habitat_type_id)
		INNER JOIN non_species_areas_filter_view USING (habitat_type_id)
		LEFT JOIN habitat_properties_view USING (habitat_type_id, assessment_area_id)
;


/*
 * relevant_habitat_name_info_for_receptor_view
 * --------------------------------------------
 * Geeft voor een receptor aan:
 * - welke natuurgebieden (inclusief naam) de hexagon raken
 * - welke relevante habitats (inclusief code + naam) binnen het natuurgebied/hexagon liggen.
 * Deze gegevens worden opgehaald voor de maatgevende hexagon op het Register Prioritair Project scherm.
 *
 * Alleen PAS-gebieden worden teruggegeven. Houd hier rekening mee bij de zogenaamde "grenshexagonen".
 *
 * Gebruik 'receptor_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW relevant_habitat_name_info_for_receptor_view AS
SELECT
	receptor_id,
	assessment_area_id,
	assessment_areas.name AS assessment_area_name,
	habitat_type_id,
	habitat_type_name,
	habitat_type_description

	FROM receptors_to_assessment_areas
		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN pas_assessment_areas USING (assessment_area_id)
		LEFT JOIN (
			SELECT
				receptor_id,
				assessment_area_id,
				habitat_type_id,
				name AS habitat_type_name,
				description AS habitat_type_description

				FROM receptors_to_habitats_with_relevant_geometry_view
			) AS habitats USING (receptor_id, assessment_area_id)
;
