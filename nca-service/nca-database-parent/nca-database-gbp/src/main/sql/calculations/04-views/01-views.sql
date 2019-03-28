
/*
 * calculation_result_view
 * ------------------------
 */
CREATE OR REPLACE VIEW calculation_result_view AS
SELECT 
    calculation_id,
	model,
	geolayer,
	data
	
	FROM calculation_results 
;

