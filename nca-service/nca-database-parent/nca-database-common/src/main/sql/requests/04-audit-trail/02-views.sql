/*
 * base_requests_audit_trail_view
 * ------------------------------
 * Helper view om de audit trail van een aanvraag op te halen.
 */
CREATE OR REPLACE VIEW base_requests_audit_trail_view AS
SELECT
	request_id,
	reference,
	segment,
	request_audit_trail_item_id,
	user_id,
	audit_trail_date_time,
	audit_trail_type,
	old_value,
	new_value

	FROM request_audit_trail_items
		INNER JOIN request_audit_trail_item_changes USING (request_audit_trail_item_id)
;


/*
 * requests_audit_trail_view
 * -------------------------
 * View om de audit trail van een aanvraag op te halen.
 */
CREATE OR REPLACE VIEW requests_audit_trail_view AS
SELECT
	request_id,
	reference,
	segment,
	request_audit_trail_item_id,
	user_id,
	audit_trail_date_time,
	audit_trail_type,
	old_value,
	new_value

	FROM base_requests_audit_trail_view
	
	WHERE segment != 'priority_subprojects'

UNION ALL

SELECT
	priority_subprojects.priority_project_request_id AS request_id,
	reference,
	segment,
	request_audit_trail_item_id,
	user_id,
	audit_trail_date_time,
	audit_trail_type,
	old_value,
	new_value

	FROM base_requests_audit_trail_view
		INNER JOIN priority_subprojects USING (request_id)

	WHERE segment = 'priority_subprojects'
;