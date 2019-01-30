/*
 * wms_calculation_substance_deposition_results_view
 * -------------------------------------------------
 * WMS view voor calculation_deposition_results_view, waarbij berekende deposities per stof geretourneerd worden.
 * 
 * Gebruik 'calculation_id' en 'zoom_level' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_calculation_substance_deposition_results_view AS
SELECT
	calculation_id, 
	receptor_id, 
	calculation_substance, 
	calculation_deposition AS deposition,
	zoom_level,
	geometry

	FROM calculation_deposition_results_view
		INNER JOIN hexagons USING (receptor_id)
;


/*
 * wms_calculations_substance_deposition_results_difference_view
 * -------------------------------------------------------------
 * WMS visualisatie van verschil tussen de projectbijdrages van twee berekeningen A en B per stof.
 * 'delta_deposition' is het verschil van B t.o.v. A, dus B - A.
 * 'delta_deposition_percentage' is het verschil in een percentage tussen B t.o.v. A dus ((B / A) - 1) * 100 
 *
 * Gebruik 'calculation_a_id', 'calculation_b_id' en 'zoom_level' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW wms_calculations_substance_deposition_results_difference_view AS
SELECT
	results_a.calculation_id AS calculation_a_id,
	results_b.calculation_id AS calculation_b_id,
	receptor_id,
	calculation_substance,
	(results_b.calculation_deposition - results_a.calculation_deposition) AS delta_deposition,
	((results_b.calculation_deposition / NULLIF(results_a.calculation_deposition, 0)) - 1) * 100::real AS delta_deposition_percentage,
	zoom_level,
	geometry

	FROM calculation_deposition_results_view AS results_a
		INNER JOIN calculation_deposition_results_view AS results_b USING (receptor_id, calculation_substance)
		INNER JOIN hexagons USING (receptor_id)
;
