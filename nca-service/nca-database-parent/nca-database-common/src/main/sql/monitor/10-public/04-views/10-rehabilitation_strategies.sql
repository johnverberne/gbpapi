/*
 * rehabilitation_strategy_info_for_assessment_area_view
 * -----------------------------------------------------
 * Geeft de herstelmaatregelen terug, inclusief bijbehorende natuurgebied (assessment_area_id)
 * en meer informatie over habitattype(s).
 *
 * Gebruikt in:
 * - Gebiedssamenvatting H3. Herstelmaatregelen
 * - Webapp Monitor Herstelmaatregelen (voor natuurgebied).
 */
CREATE OR REPLACE VIEW rehabilitation_strategy_info_for_assessment_area_view AS
SELECT
	rehabilitation_strategy_id,
	assessment_area_id,
	rehabilitation_strategies.description AS rehabilitation_strategy_description,
	note,
	area,
	geometry_accuracy,

	habitat_type_id,
	habitat_types.name AS habitat_type_name,
	habitat_types.description AS habitat_type_description,
	potential,
	frequency,
	response_time,

	management_period,

	Box2D(geometry) AS boundingbox,
	geometry

	FROM rehabilitation_strategies
		INNER JOIN rehabilitation_strategy_habitat_types USING (rehabilitation_strategy_id)
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN rehabilitation_strategy_management_periods USING (rehabilitation_strategy_id)
;


/*
 * rehabilitation_strategy_info_for_receptor_view
 * ----------------------------------------------
 * Geeft de herstelmaatregelen terug voor een receptor, inclusief bijbehorende natuurgebied (assessment_area_id)
 * en meer informatie over habitattype(s).
 *
 * Gebruikt in:
 * - Webapp Monitor Herstelmaatregelen (voor receptor).
 */
CREATE OR REPLACE VIEW rehabilitation_strategy_info_for_receptor_view AS
SELECT
	rehabilitation_strategy_id,
	assessment_area_id,
	receptor_id,
	rehabilitation_strategy_description,
	note,
	area,
	geometry_accuracy,

	habitat_type_id,
	habitat_type_name,
	habitat_type_description,
	potential,
	frequency,
	response_time,

	management_period,

	boundingbox,
	geometry

	FROM rehabilitation_strategy_info_for_assessment_area_view
		INNER JOIN rehabilitation_strategies_to_receptors USING (rehabilitation_strategy_id)
;


/*
 * rehabilitation_strategy_grouped_geometries_view
 * -----------------------------------------------
 * Geeft informatie over groepen van herstelmaatregelen terug, waarbij de herstelmaatregelen gegroepeerd zijn op geometrie.
 * De geometrie wordt teruggegeven, inclusief om wat voor type het gaat (preciese locatie of schets) en de oppervlakte,
 * alsook alle IDs van de herstelmaatregelen die gegroepeerd zijn.
 *
 * Wordt op oppervlakte geordend voor gebruik in functie om clusters te bepalen die tezamen op een kaart getoond kunnen worden zonder overlappend te zijn.
 */
CREATE OR REPLACE VIEW rehabilitation_strategy_grouped_geometries_view AS
SELECT
	assessment_area_id,
	array_agg(rehabilitation_strategy_id) AS rehabilitation_strategy_ids,
	geometry_accuracy,
	ST_Area(geometry) AS surface,
	geometry

	FROM rehabilitation_strategies

	WHERE 
		geometry IS NOT NULL
		AND NOT ST_IsEmpty(geometry)

	GROUP BY assessment_area_id, geometry_accuracy, geometry

	ORDER BY surface DESC
;
