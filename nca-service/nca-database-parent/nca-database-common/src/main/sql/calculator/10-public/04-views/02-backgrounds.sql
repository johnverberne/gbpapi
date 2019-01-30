/*
 * background_cell_results_view
 * ----------------------------
 * Achtergrond concentratie, depositie en overschrijdingsdagen informatie.
 * Gebruik 'year', 'substance_id', 'result_type' en ST_Intersects(.., geometry) in de WHERE-clause.
 * Voorbeeld:
 *     WHERE year = 2018 AND substance_id = 10 AND result_type = 'concentration'
 *     AND ST_Intersects(ST_SetSRID(ST_Point(218928, 486793), ae_get_srid()), geometry)
 */
CREATE OR REPLACE VIEW background_cell_results_view AS
SELECT
	background_cell_id,
	year,
	substance_id,
	result_type,
	result,
	geometry

	FROM background_cells
		INNER JOIN background_cell_results USING (background_cell_id)
;


/*
 * calculation_background_results_view
 * -----------------------------------
 * Achtergrondconcentraties en -deposities voor alle berekende receptoren.
 *
 * Gebruik 'calculation_id' en eventueel de daaropvolgende 4 velden in de WHERE-clause.
 * Voorbeeld:
 *     WHERE calculation_id = 2
 */
CREATE OR REPLACE VIEW calculation_background_results_view AS
SELECT
	calculation_id,
	receptor_id,
	year,
	substance_id,
	result_type,
	background_cell_results.result AS result

	FROM calculations
		INNER JOIN calculation_result_sets USING (calculation_id)
		INNER JOIN calculation_results USING (calculation_result_set_id)
		INNER JOIN receptors_to_background_cells USING (receptor_id)
		INNER JOIN background_cell_results USING (background_cell_id, year, substance_id, result_type)
;


/*
 * calculation_point_background_results_view
 * -----------------------------------------
 * Achtergrondconcentraties en -deposities voor alle berekende rekenpunten.
 *
 * Gebruik 'calculation_id' en eventueel de overige van de eerste 5 velden in de WHERE-clause.
 * Voorbeeld:
 *     WHERE calculation_id = 2
 */
CREATE OR REPLACE VIEW calculation_point_background_results_view AS
SELECT
	calculation_id,
	calculation_point_id,
	year,
	substance_id,
	result_type,
	COALESCE(receptor_background_results.result, background_results.result) AS result

	FROM (
		SELECT calculation_id,
			calculation_point_id,
			year,
			substance_id,
			result_type,
			result

			FROM calculations
				INNER JOIN calculation_points USING (calculation_point_set_id)
				INNER JOIN background_cells ON ST_Within(calculation_points.geometry, background_cells.geometry)
				INNER JOIN background_cell_results USING (background_cell_id, year)
	) AS background_results
	LEFT JOIN (
		SELECT calculation_id,
			calculation_point_id,
			calculations.year,
			substance_id,
			result_type,
			result

			FROM calculations
				INNER JOIN calculation_points USING (calculation_point_set_id)
				INNER JOIN background_results_view
					ON (calculation_points.nearest_receptor_id = background_results_view.receptor_id)
						AND calculations.year = background_results_view.year
	) AS receptor_background_results USING (calculation_id, calculation_point_id, year, substance_id, result_type)
;
