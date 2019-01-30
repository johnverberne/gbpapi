/*
 * pronouncements_view
 * -------------------
 * View om melding op te halen met vaak gebruikte eigenschappen.
 */
CREATE OR REPLACE VIEW pronouncements_view AS
SELECT
	request_id,
	reference,
	sector_id,
	has_multiple_sectors,
	marked,
	status,
	checked,
	corporation,
	project_name,
	description,
	start_year,
	temporary_period,
	authority_id,
	province_area_id,
	application_version,
	database_version,
	last_modified,
	insert_date,
	geometry

	FROM pronouncements
		INNER JOIN requests USING (request_id)
;
