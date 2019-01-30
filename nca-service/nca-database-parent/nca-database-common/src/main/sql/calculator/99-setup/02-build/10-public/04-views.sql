/*
 * setup.build_background_cell_results_view
 * ----------------------------------------
 * View voor het vullen van de (tussentabel) background_cell_results
 */
CREATE OR REPLACE VIEW setup.build_background_cell_results_view AS
SELECT
	background_cell_id,
	year,
	substance_id,
	'concentration'::emission_result_type AS result_type,
	concentration AS result

	FROM background_cells
		INNER JOIN background_cell_concentrations USING (background_cell_id)

UNION ALL

SELECT
	background_cell_id,
	year,
	1711::smallint AS substance_id,
	'deposition'::emission_result_type AS result_type,
	deposition AS result

	FROM background_cells
		INNER JOIN background_cell_depositions USING (background_cell_id)
;

/*
 * setup.build_receptors_to_background_cells_view
 * ----------------------------------------------
 * View voor het vullen van de (tussentabel) receptors_to_background_cells
 */
CREATE OR REPLACE VIEW setup.build_receptors_to_background_cells_view AS
SELECT 
	(ae_determine_receptor_ids_in_geometry(geometry)).receptor_id, 
	background_cell_id
	
	FROM background_cells
;
