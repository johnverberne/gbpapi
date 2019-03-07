
/*
 * calculation_jobs_view
 * ------------------------
 */
CREATE OR REPLACE VIEW calculation_jobs_view AS
SELECT 
	user_id,
    job_id,
	model,
	geolayer,
	data
	
	FROM jobs 
		INNER JOIN job_calculations USING (job_id ) 
		INNER JOIN calculation_results USING (calculation_id)
;

