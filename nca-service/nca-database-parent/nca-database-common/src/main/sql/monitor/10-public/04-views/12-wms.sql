/*
 * wms_depositions_jurisdiction_policies_view
 * ------------------------------------------
 * WMS visualisatie van wms_depositions_jurisdiction_policies_view.
 */
CREATE OR REPLACE VIEW wms_depositions_jurisdiction_policies_view AS
SELECT
	depositions_jurisdiction_policies.year,
	depositions_jurisdiction_policies.receptor_id,
	hexagons.zoom_level,
	depositions_jurisdiction_policies.deposition,
	hexagons.geometry

	FROM depositions_jurisdiction_policies
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_rehabilitation_strategies_view
 * ----------------------------------
 * WMS laag voor het tonen van herstelmaatregelen binnen een natuurgebied.
 *
 * Gebruik 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_rehabilitation_strategies_view AS
SELECT
	rehabilitation_strategy_id,
	assessment_area_id,
	geometry

	FROM rehabilitation_strategies

	WHERE
		geometry IS NOT NULL
		AND NOT ST_IsEmpty(geometry)
;


/*
 * wms_assessment_area_receptor_delta_policy_depositions_view
 * ----------------------------------------------------------
 * WMS laag geeft per jaar weer wat het verschil is in depositie tussen provinciaalbeleid en zonder beleid.
 * Oftewel het effect van het PAS programma (= jurisdiction_policies) t.o.v. autonoom (no_policies).
 *
 * Gebruik 'year' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_assessment_area_receptor_delta_policy_depositions_view AS
SELECT
	assessment_area_id,
	receptor_id,
	year,
	ROUND((jp.deposition - np.deposition)::numeric, 2)::real AS jurisdiction_and_no_policies_difference,
	zoom_level,
	geometry

	FROM receptors_to_assessment_areas
		INNER JOIN depositions_no_policies AS np USING (receptor_id)
		INNER JOIN depositions_jurisdiction_policies AS jp USING (receptor_id, year)
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_assessment_area_receptor_nitrogen_loads_view
 * ------------------------------------------------
 * WMS laag geeft per receptor, toetsgebied en jaar aan wat de hoogste stikstofbelasting classificatie is.
 * Geldt alleen voor aangewezen KDW-gebieden binnen het toetsgebied.
 *
 * Gebruik 'year' en eventueel 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_assessment_area_receptor_nitrogen_loads_view AS
SELECT
	assessment_area_id,
	receptor_id,
	year,
	nitrogen_load,
	zoom_level,
	geometry

	FROM assessment_area_receptor_max_nitrogen_loads_view
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_assessment_area_receptor_deposition_spaces_view
 * ---------------------------------------------------
 * WMS laag voor het visualiseren van de totale depositieruimte per jaar (en receptor).
 *
 * Gebruik 'year', 'zoom_level' en eventueel 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_assessment_area_receptor_deposition_spaces_view AS
SELECT
	assessment_area_id,
	receptor_id,
	year,
	total_space,
	zoom_level,
	geometry

	FROM deposition_spaces_view
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_critical_deposition_area_receptor_depositions_view
 * ------------------------------------------------------
 * WMS laag voor het visualiseren van depositie per receptor, toetsgebied, KDW-gebied en jaar.
 *
 * Gebruik 'assessment_area_id', 'critical_deposition_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_critical_deposition_area_receptor_depositions_view AS
SELECT
	assessment_area_id,
	critical_deposition_area_id,
	type,
	receptor_id,
	year,
	deposition,
	(ae_color_range_lower_value('total_deposition', deposition)).color,
	zoom_level,
	geometry

	FROM critical_deposition_area_receptor_depositions_view
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_critical_deposition_area_receptor_delta_depositions_view
 * ------------------------------------------------------------
 * WMS laag voor het visualiseren van de delta depositie (verschil jaar t.o.v. basis-jaar)
 * per receptor, toetsgebied, KDW-gebied en jaar.
 *
 * Gebruik 'assessment_area_id', 'critical_deposition_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_critical_deposition_area_receptor_delta_depositions_view AS
SELECT
	assessment_area_id,
	critical_deposition_area_id,
	type,
	receptor_id,
	year,
	delta_deposition,
	(ae_color_range_lower_value('delta_deposition', delta_deposition)).color,
	zoom_level,
	geometry

	FROM critical_deposition_area_receptor_delta_depositions_view
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_deviations_from_critical_deposition_view
 * --------------------------------------------
 * WMS laag voor het visualiseren van de afstand tot KDW
 * per receptor en jaar.
 *
 * Gebruik 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_deviations_from_critical_deposition_view AS
SELECT
	receptor_id,
	year,
	deposition - critical_deposition AS deviation_from_critical_deposition,
	(ae_color_range_lower_value('deviation_from_critical_deposition', (deposition - critical_deposition)::real)).color,
	zoom_level,
	geometry

	FROM depositions_jurisdiction_policies
		INNER JOIN critical_depositions USING (receptor_id)
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_critical_deposition_area_receptor_deviations_view
 * -----------------------------------------------------
 * WMS laag voor het visualiseren van de afwijking van KDW (afstand tot KDW)
 * per receptor, toetsgebied, KDW-gebied en jaar.
 *
 * Gebruik 'assessment_area_id', 'critical_deposition_area_id', 'type' en 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_critical_deposition_area_receptor_deviations_view AS
SELECT
	assessment_area_id,
	critical_deposition_area_id,
	type,
	receptor_id,
	year,
	deviation_from_critical_deposition,
	(ae_color_range_lower_value('deviation_from_critical_deposition', deviation_from_critical_deposition::real)).color,
	zoom_level,
	geometry

	FROM critical_deposition_area_receptor_deviations_view
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_other_depositions_jurisdiction_policies_view
 * ------------------------------------------------
 * WMS visualisatie van depositie als gevolg van het overige depositie bronnen (zoals buitenland).
 */
CREATE OR REPLACE VIEW wms_other_depositions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	other_deposition_type,
	year,
	deposition,
	zoom_level,
	geometry

	FROM other_depositions_jurisdiction_policies_view
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_sector_depositions_jurisdiction_policies_view
 * -------------------------------------------------
 * WMS visualisatie van deposities als gevolg van sector activiteit.
 */
CREATE OR REPLACE VIEW wms_sector_depositions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	sector_id,
	year,
	deposition,
	zoom_level,
	geometry

	FROM sector_depositions_jurisdiction_policies
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_assessment_area_receptor_depositions_view
 * ---------------------------------------------
 * WMS visualisatie van totale deposities (zowel sector gerelateerd als overige bronnen).
 */
CREATE OR REPLACE VIEW wms_assessment_area_receptor_depositions_view AS
SELECT
	assessment_area_id,
	receptor_id,
	year,
	deposition,
	zoom_level,
	geometry

	FROM depositions_jurisdiction_policies
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		INNER JOIN included_receptors USING (receptor_id)
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_assessment_area_receptor_delta_depositions_view
 * ---------------------------------------------------
 * WMS laag geeft per jaar weer wat het verschil is in depositie tussen dat jaar en het basis jaar
 * voor PAS beleid (de provinciale beleidsvoering).
 *
 * Geeft alleen receptoren terug die een aangewzen-stikstofgevoelig habitat type bevatten.
 *
 * Gebruik 'year' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_assessment_area_receptor_delta_depositions_view AS
SELECT
	assessment_area_id,
	receptor_id,
	(included_receptors.receptor_id IS NOT NULL) AS included,
	year,
	delta_deposition AS delta_deposition_jurisdiction_policies,
	zoom_level,
	geometry

	FROM receptors_to_assessment_areas
		INNER JOIN delta_depositions_jurisdiction_policies USING (receptor_id)
		INNER JOIN hexagons USING (receptor_id)
		LEFT JOIN included_receptors USING (receptor_id)
;


/*
 * wms_assessment_area_receptor_decrease_delta_depositions_view
 * ------------------------------------------------------------
 * WMS laag geeft per jaar weer wat de daling is in depositie tussen dat jaar en het basis jaar
 * voor PAS beleid (de provinciale beleidsvoering).
 *
 * Geeft alleen receptoren terug die een aangewzen-stikstofgevoelig habitat type bevatten.
 *
 * Gebruik 'year' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_assessment_area_receptor_decrease_delta_depositions_view AS
SELECT
	assessment_area_id,
	receptor_id,
	included,
	year,
	-delta_deposition_jurisdiction_policies AS delta_deposition_jurisdiction_policies,
	zoom_level,
	geometry

	FROM wms_assessment_area_receptor_delta_depositions_view
;


/*
 * wms_included_receptors_view
 * ---------------------------
 * Deze WMS laag geeft de relevante hexagonen weer.
 * (stikstofgevoelig, aangewezen, niet uitgesloten, etc)
 */
CREATE OR REPLACE VIEW wms_included_receptors_view AS
SELECT
	receptor_id,
	zoom_level,
	geometry

	FROM included_receptors
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_delta_space_desire_view
 * ---------------------------
 * WMS visualisatie van confrontatie ontwikkelingsruimte en -behoefte.
 */
CREATE OR REPLACE VIEW wms_delta_space_desire_view AS
SELECT
	year,
	receptor_id,
	hexagons.zoom_level,
	ae_get_delta_space_desire_range(total_space, total_desire) AS delta_space_desire_range,
	hexagons.geometry

	FROM deposition_spaces_view
		INNER JOIN economic_desires USING (year, receptor_id)
		INNER JOIN hexagons USING (receptor_id)
;
