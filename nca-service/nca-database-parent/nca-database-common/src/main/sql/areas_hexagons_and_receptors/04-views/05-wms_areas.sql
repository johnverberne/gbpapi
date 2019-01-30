/*
 * wms_habitat_areas_sensitivity_view
 * ----------------------------------
 * Geeft habitatgebieden terug inclusief KDW-gevoeligheid en relevantie.
 */
CREATE OR REPLACE VIEW wms_habitat_areas_sensitivity_view AS
SELECT
	habitat_area_id,
	habitat_type_id,
	critical_deposition,
	ae_critical_deposition_classification(critical_deposition) AS critical_deposition_classification,
	(relevant_habitat_areas.habitat_type_id IS NOT NULL) AS relevant,
	habitat_areas.geometry,
	relevant_habitat_areas.geometry AS relevant_geometry

	FROM habitat_areas
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
		LEFT JOIN relevant_habitat_areas USING (habitat_area_id, assessment_area_id, habitat_type_id)
;


/*
 * wms_nature_areas_view
 * ---------------------
 * Selectie van natura2000_directive_areas (inclusief naam).
 */
CREATE OR REPLACE VIEW wms_nature_areas_view AS
SELECT
	natura2000_areas.assessment_area_id,
	country_id,
	bird_directive,
	habitat_directive,
	design_status,
	natura2000_areas.name,
	natura2000_directive_areas.geometry

	FROM natura2000_directive_areas
		INNER JOIN authorities USING (authority_id)
		INNER JOIN natura2000_areas USING (natura2000_area_id)
;

/*
 * wms_habitats_view
 * -----------------
 * WMS laag voor het tonen van habitat gebied(en) binnen een natuur gebied.
 * Gebruik 'assessment_area_id' in de WHERE-clause en eventueel de habitat_type_id.
 */
CREATE OR REPLACE VIEW wms_habitats_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	name,
	description,
	geometry,
	relevant_geometry

	FROM habitats_view
;


/*
 * wms_receptors_to_habitats_with_relevant_geometry_view
 * -----------------------------------------------------
 * WMS laag voor het tonen van habitat(type)s die raken aan een receptor.
 * Gebruik receptor_id en eventueel de habitat_type_id in de WHERE clause.
 */
CREATE OR REPLACE VIEW wms_receptors_to_habitats_with_relevant_geometry_view AS
SELECT
	receptor_id,
	assessment_area_id,
	habitat_type_id,
	name,
	description,
	geometry,
	relevant_geometry

	FROM receptors_to_habitats_with_relevant_geometry_view
;


/*
 * wms_relevant_habitat_info_for_receptor_view
 * -------------------------------------------
 * WMS laag voor het tonen van habitatgebieden die raken aan een receptor.
 * Gebruik receptor_id en de habitat_type_id in de WHERE clause.
 *
 * De geometrieën worden per assessment_area_id teruggegeven opdat er geen trage ST_Union noodzakelijk is. Dit uit zich
 * grafisch enkel in een lijntje op de grenzen.
 */
CREATE OR REPLACE VIEW wms_relevant_habitat_info_for_receptor_view AS
SELECT
	receptor_id,
	assessment_area_id,
	habitat_type_id,
	geometry

	FROM receptors_to_relevant_habitats_view
		INNER JOIN relevant_habitats USING (assessment_area_id, habitat_type_id)
;

/*
 * wms_province_areas_view
 * -----------------------
 * WMS laag voor het tonen van provinciegrenzen.
 */
CREATE OR REPLACE VIEW wms_province_areas_view AS
SELECT
	province_area_id,
	name,
	authority_id,
	geometry

	FROM province_areas
;
