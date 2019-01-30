/*
 * critical_deposition_area_deposition_ranges_view
 * -----------------------------------------------
 * Bepaal de bereiken van depositie binnen een natuurgebied/KDW-gebied/jaar combinatie.
 * Geeft aantal receptoren en oppervlakte binnen de bereiken terug.
 *
 * Gebruik 'assessment_area_id', 'critical_deposition_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_deposition_ranges_view AS
SELECT
	assessment_area_id,
	year,
	critical_deposition_area_id,
	type,
	(unnest(ae_color_range('total_deposition'::color_range_type, deposition::numeric, 1::numeric))).lower_value AS lower_value,
	(unnest(ae_color_range('total_deposition'::color_range_type, deposition::numeric, 1::numeric))).total::bigint AS number_of_receptors,
	(unnest(ae_color_range('total_deposition'::color_range_type, deposition::numeric, surface::numeric))).total::real AS surface

	FROM critical_deposition_area_receptor_depositions_view

	GROUP BY assessment_area_id, year, critical_deposition_area_id, type
;


/*
 * assessment_area_deposition_ranges_view
 * --------------------------------------
 * Bepaal de bereiken van depositie binnen een natuurgebied/jaar combinatie.
 * Geeft aantal receptoren en oppervlakte binnen de bereiken terug.
 *
 * Kijkt alleen naar receptoren waar daadwerkelijk een KDW-gebied van type 'type' ligt.
 *
 * Gebruik 'assessment_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW assessment_area_deposition_ranges_view AS
SELECT
	assessment_area_id,
	year,
	type,
	(unnest(ae_color_range('total_deposition'::color_range_type, deposition::numeric, 1::numeric))).lower_value AS lower_value,
	(unnest(ae_color_range('total_deposition'::color_range_type, deposition::numeric, 1::numeric))).total::bigint AS number_of_receptors,
	(unnest(ae_color_range('total_deposition'::color_range_type, deposition::numeric, surface::numeric))).total::real AS surface --TODO: should coverage be used? result is in hectare

	FROM receptors_to_assessment_areas_on_critical_deposition_area_view
		INNER JOIN depositions_jurisdiction_policies USING (receptor_id)

	GROUP BY assessment_area_id, year, type
;


/*
 * critical_deposition_area_delta_deposition_ranges_view
 * -----------------------------------------------------
 * Bepaal de bereiken van delta depositie binnen een natuurgebied/KDW-gebied/jaar combinatie.
 * Geeft aantal receptoren en oppervlakte binnen de bereiken terug.
 *
 * Gebruik 'assessment_area_id', 'critical_deposition_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_delta_deposition_ranges_view AS
SELECT
	assessment_area_id,
	year,
	critical_deposition_area_id,
	type,
	(unnest(ae_color_range('delta_deposition'::color_range_type, delta_deposition::numeric, 1::numeric))).lower_value AS lower_value,
	(unnest(ae_color_range('delta_deposition'::color_range_type, delta_deposition::numeric, 1::numeric))).total::bigint AS number_of_receptors,
	(unnest(ae_color_range('delta_deposition'::color_range_type, delta_deposition::numeric, surface::numeric))).total::real AS surface

	FROM critical_deposition_area_receptor_delta_depositions_view

	GROUP BY assessment_area_id, year, critical_deposition_area_id, type
;


/*
 * assessment_area_delta_deposition_ranges_view
 * --------------------------------------------
 * Bepaal de bereiken van delta depositie binnen een natuurgebied/jaar combinatie.
 * Geeft aantal receptoren en oppervlakte binnen de bereiken terug.
 *
 * Kijkt alleen naar receptoren waar daadwerkelijk een KDW-gebied van type 'type' ligt.
 *
 * Gebruik 'assessment_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW assessment_area_delta_deposition_ranges_view AS
SELECT
	assessment_area_id,
	year,
	type,
	(unnest(ae_color_range('delta_deposition'::color_range_type, delta_deposition::numeric, 1::numeric))).lower_value AS lower_value,
	(unnest(ae_color_range('delta_deposition'::color_range_type, delta_deposition::numeric, 1::numeric))).total::bigint AS number_of_receptors,
	(unnest(ae_color_range('delta_deposition'::color_range_type, delta_deposition::numeric, surface::numeric))).total::real AS surface --TODO: should coverage be used? result is in hectare

	FROM receptors_to_assessment_areas_on_critical_deposition_area_view
		INNER JOIN delta_depositions_jurisdiction_policies USING (receptor_id)

	GROUP BY assessment_area_id, year, type
;


/*
 * critical_deposition_area_deviation_ranges_view
 * ----------------------------------------------
 * Bepaal de bereiken van afstand-tot-kdw binnen een natuurgebied/KDW-gebied/jaar combinatie.
 * Geeft aantal receptoren en oppervlakte binnen de bereiken terug.
 *
 * Gebruik 'assessment_area_id', 'critical_deposition_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_deviation_ranges_view AS
SELECT
	assessment_area_id,
	year,
	critical_deposition_area_id,
	type,
	(unnest(ae_color_range('deviation_from_critical_deposition'::color_range_type, deviation_from_critical_deposition::numeric, 1::numeric))).lower_value AS lower_value,
	(unnest(ae_color_range('deviation_from_critical_deposition'::color_range_type, deviation_from_critical_deposition::numeric, 1::numeric))).total::bigint AS number_of_receptors,
	(unnest(ae_color_range('deviation_from_critical_deposition'::color_range_type, deviation_from_critical_deposition::numeric, surface::numeric))).total::real AS surface

	FROM critical_deposition_area_receptor_deviations_view

	GROUP BY assessment_area_id, year, critical_deposition_area_id, type
;


/*
 * assessment_area_deviation_ranges_view
 * -------------------------------------
 * Bepaal de bereiken van afstand-tot-kdw binnen een natuurgebied/jaar combinatie.
 * Geeft aantal receptoren en oppervlakte binnen de bereiken terug.
 *
 * Kijkt alleen naar receptoren waar daadwerkelijk een KDW-gebied van type 'type' ligt.
 *
 * Gebruik 'assessment_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW assessment_area_deviation_ranges_view AS
SELECT
	assessment_area_id,
	year,
	type,
	(unnest(ae_color_range('deviation_from_critical_deposition'::color_range_type, deviation_from_critical_deposition::numeric, 1::numeric))).lower_value AS lower_value,
	(unnest(ae_color_range('deviation_from_critical_deposition'::color_range_type, deviation_from_critical_deposition::numeric, 1::numeric))).total::bigint AS number_of_receptors,
	(unnest(ae_color_range('deviation_from_critical_deposition'::color_range_type, deviation_from_critical_deposition::numeric, surface::numeric))).total::real AS surface --TODO: should coverage be used? result is in hectare

	FROM receptors_to_assessment_areas_on_critical_deposition_area_view
		INNER JOIN deviations_from_critical_deposition_view USING (receptor_id)

	GROUP BY assessment_area_id, year, type
;
