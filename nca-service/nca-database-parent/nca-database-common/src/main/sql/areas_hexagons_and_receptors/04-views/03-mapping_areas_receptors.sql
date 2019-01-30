/*
 * receptors_to_critical_deposition_areas_view
 * -------------------------------------------
 * Breidt receptors_to_critical_deposition_areas_view uit met de kolom weight. Het is consequenter om altijd dat veld te gebruiken om
 * te wegen (i.p.v. overal zelf eventuele surface/coverage logica toe te passen).
 * View zorgt
 */
CREATE OR REPLACE VIEW receptors_to_critical_deposition_areas_view AS
SELECT
	assessment_area_id,
	type,
	critical_deposition_area_id,
	receptor_id,
	(included_receptors.receptor_id IS NOT NULL) AS included,
	(surface / 10000.0)::real AS weight,  --TOD0: #1217 zeker weten dat coverage hier niet meegenomen dient te worden?
	surface,
	coverage

	FROM receptors_to_critical_deposition_areas
		LEFT JOIN included_receptors USING (receptor_id)  -- Adds 'included' boolean
;


/*
 * receptors_to_habitats_view
 * --------------------------
 * Versie van receptors_to_critical_deposition_areas_view die alleen het type 'habitat' teruggeeft, via habitat_type_id.
 */
CREATE OR REPLACE VIEW receptors_to_habitats_view AS
SELECT
	assessment_area_id,
	critical_deposition_area_id AS habitat_type_id,
	receptor_id,
	included,
	weight,
	surface,
	coverage

	FROM receptors_to_critical_deposition_areas_view

	WHERE type = 'habitat'
;


/*
 * receptors_to_relevant_habitats_view
 * -----------------------------------
 * Versie van receptors_to_critical_deposition_areas_view die alleen het type 'relevant_habitat' teruggeeft, via habitat_type_id.
 */
CREATE OR REPLACE VIEW receptors_to_relevant_habitats_view AS
SELECT
	assessment_area_id,
	critical_deposition_area_id AS habitat_type_id,
	receptor_id,
	included,
	weight,
	surface,
	coverage

	FROM receptors_to_critical_deposition_areas_view

	WHERE type = 'relevant_habitat'
;


/*
 * receptors_to_assessment_areas_on_critical_deposition_area_view
 * --------------------------------------------------------------
 * Deze view brengt receptors_to_critical_deposition_areas_view terug tot alleen een koppeling tussen toetsgebieden en receptoren.
 * Het gaat dan wel alleen om receptoren die in een KDW-gebied liggen. Het type KDW-gebied moet op gefilterd worden via 'type'.
 * Surface en weight volgen uit de toetsgebied/receptor relatie (KDW-gebieden zijn dus samengenomen).
 */
CREATE OR REPLACE VIEW receptors_to_assessment_areas_on_critical_deposition_area_view AS
SELECT
	assessment_area_id,
	receptor_id,
	bool_or(included) AS included,
	type,
	SUM(surface * coverage / 10000.0)::real AS weight,  --coverage meenemen
	SUM(surface) AS surface,
	SUM(surface * coverage) AS cartographic_surface

	FROM receptors_to_critical_deposition_areas_view

	GROUP BY assessment_area_id, receptor_id, type
;


/*
 * receptors_to_assessment_areas_on_relevant_habitat_view
 * ------------------------------------------------------
 * Zoals 'receptors_to_assessment_areas_on_critical_deposition_area_view', maar dan voor type = 'relevant_habitat'..
 */
CREATE OR REPLACE VIEW receptors_to_assessment_areas_on_relevant_habitat_view AS
SELECT
	assessment_area_id,
	receptor_id,
	included,
	weight,
	surface,
	cartographic_surface

	FROM receptors_to_assessment_areas_on_critical_deposition_area_view

	WHERE type = 'relevant_habitat'
;
