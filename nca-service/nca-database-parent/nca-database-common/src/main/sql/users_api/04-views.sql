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
	hexagon_counter,
	result_url,
	error_message
	
	FROM jobs
		INNER JOIN job_progress USING (job_id)
;


/*
 * user_request_download_permissions_view
 * --------------------------------------
 * Retourneert alle download permissies per user (en API-key).
 */
CREATE OR REPLACE VIEW user_request_download_permissions_view AS
SELECT 
	user_id,
	api_key,
	request_reference

	FROM users
		INNER JOIN user_request_download_permissions USING (user_id)
;