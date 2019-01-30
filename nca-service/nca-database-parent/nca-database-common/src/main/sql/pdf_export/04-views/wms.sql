/*
 * wms_exceeding_calculation_deposition_results_view
 * -------------------------------------------------
 * WMS visualisatie van exceeding_calculation_deposition_results_view.
 *
 * Gebruik 'calculation_id' en 'zoom_level' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_exceeding_calculation_deposition_results_view AS
SELECT
	exceeding_calculation_deposition_results_view.calculation_id,
	exceeding_calculation_deposition_results_view.receptor_id,
	hexagons.zoom_level,
	exceeding_calculation_deposition_results_view.deposition,
	hexagons.geometry

	FROM exceeding_calculation_deposition_results_view
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_country_exceeding_calculation_deposition_results_view
 * ---------------------------------------------------------
 * WMS visualisatie van exceeding_calculation_deposition_results_view, waarbij per land gekeken kan worden.
 *
 * Gebruik 'calculation_id', country_id en 'zoom_level' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_country_exceeding_calculation_deposition_results_view AS
SELECT
	wms_exceeding_calculation_deposition_results_view.calculation_id,
	wms_exceeding_calculation_deposition_results_view.receptor_id,
	authorities.country_id,
	wms_exceeding_calculation_deposition_results_view.zoom_level,
	wms_exceeding_calculation_deposition_results_view.deposition,
	wms_exceeding_calculation_deposition_results_view.geometry

	FROM wms_exceeding_calculation_deposition_results_view
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN authorities USING (authority_id)
;


/*
 * wms_calculations_deposition_results_difference_view
 * ---------------------------------------------------
 * WMS visualisatie van verschil tussen de projectbijdrages van twee berekeningen A en B.
 * Dit is de toe/afname van B t.o.v. A, dus B - A.
 *
 * Gebruik 'calculation_a_id', 'calculation_b_id' en 'zoom_level' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_calculations_deposition_results_difference_view AS
SELECT
	results_a.calculation_id AS calculation_a_id,
	results_b.calculation_id AS calculation_b_id,
	receptor_id,
	hexagons.zoom_level,
	(results_b.deposition - results_a.deposition) AS delta_deposition,
	hexagons.geometry

	FROM calculation_summed_deposition_results_view AS results_a
		INNER JOIN calculation_summed_deposition_results_view AS results_b USING (receptor_id)
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_country_calculations_deposition_results_difference_view
 * -----------------------------------------------------------
 * WMS visualisatie van verschil tussen de projectbijdrages van twee berekeningen A en B waarbij per land gekeken kan worden.
 * Dit is de toe/afname van B t.o.v. A, dus B - A.
 *
 * Gebruik 'calculation_a_id', 'calculation_b_id', 'country_id' en 'zoom_level' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_country_calculations_deposition_results_difference_view AS
SELECT
	calculation_a_id,
	calculation_b_id,
	receptor_id,
	country_id,
	zoom_level,
	delta_deposition,
	wms_calculations_deposition_results_difference_view.geometry

	FROM wms_calculations_deposition_results_difference_view
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN authorities USING (authority_id)
;
