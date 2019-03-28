/*
 * job_progress_view
 * -----------------
 * Geeft voortgang terug van alle jobs van gebruikers. Koppelt met de berekeningen om daarvan de status en aanmaaktijd op te vragen.
 */
CREATE OR REPLACE VIEW job_progress_view AS
SELECT
	job_id,
	type,
	name,
	state,
	user_id,
	key,
	start_time,
	pick_up_time,
	end_time,
	progress_count,
	max_progress,
	result_url,
	error_message
	
	FROM jobs
		INNER JOIN job_progress USING (job_id)
;
