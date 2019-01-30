/*
 * priority_projects_view
 * ----------------------
 * View om prioritair projecten op te halen met vaak gebruikte eigenschappen.
 */
CREATE OR REPLACE VIEW priority_projects_view AS
SELECT
	request_id,
	reference,
	sector_id,
	has_multiple_sectors,
	marked,
	dossier_id,
	insert_date AS received_date,
	status,
	corporation,
	project_name,
	description,
	segment,
	start_year,
	temporary_period,
	remarks,
	assign_completed,
	fraction_assigned,
	authority_id,
	province_area_id,
	application_version,
	database_version,
	last_modified,
	geometry

	FROM priority_projects
		INNER JOIN requests USING (request_id)
;


/*
 * priority_subprojects_view
 * -------------------------
 * View om deelprojecten van een prioritair project op te halen met vaak gebruikte eigenschappen.
 */
CREATE OR REPLACE VIEW priority_subprojects_view AS
SELECT
	priority_subprojects.request_id,
	priority_project_request_id,
	priority_subprojects.label,
	priority_project.dossier_id AS priority_project_dossier_id,
	priority_project_authority.code AS priority_project_authority,
	requests.reference,
	requests.sector_id,
	requests.has_multiple_sectors,
	requests.marked,
	requests.status,
	requests.corporation,
	requests.project_name,
	requests.description,
	requests.segment,
	requests.start_year,
	requests.temporary_period,
	requests.authority_id,
	requests.province_area_id,
	requests.insert_date,
	requests.application_version,
	requests.database_version,
	requests.last_modified,
	requests.geometry

	FROM priority_subprojects
		INNER JOIN requests USING (request_id)
		INNER JOIN priority_projects_view AS priority_project ON (priority_subprojects.priority_project_request_id = priority_project.request_id)
		INNER JOIN authorities AS priority_project_authority ON (priority_project.authority_id = priority_project_authority.authority_id)
;


/*
 * assigned_siblings_by_priority_subproject_view
 * ---------------------------------------------
 * Bepaalt de (mede-)aanvragen voor een priority project's subproject die aangewezen zijn.
 * LET OP: Indien het priority_subproject_request_id zelf niet aangewezen is, wordt deze toch teruggegeven.
 * Gebruik priority_subproject_request_id in WHERE/GROUP clause.
 */
CREATE OR REPLACE VIEW assigned_siblings_by_priority_subproject_view AS
SELECT
	subproject.request_id AS priority_subproject_request_id,
	assigned.request_id

	FROM priority_subprojects
		INNER JOIN requests AS assigned USING (request_id)
		INNER JOIN priority_subprojects AS subproject USING (priority_project_request_id)

	WHERE assigned.status::development_space_state = 'assigned'

UNION -- Return the (by) priority_subproject_request_id even if the state is not assigned. The UNION will filter out duplicates.
SELECT
	request_id AS priority_subproject_request_id,
	request_id

	FROM priority_subprojects
;
	

/*
 * assigned_sibling_demands_by_priority_subproject_gml_export_view
 * ---------------------------------------------------------------
 * Bepaalt de totale depositie (per receptor en stof) van alle aangewezen (mede-)aanvragen.
 * LET OP: Indien het subproject (request_id) zelf niet aangewezen is, wordt deze toch opgenomen in het totaal.
 * Gebruik priority_subproject_request_id in WHERE/GROUP clause.
 */
CREATE OR REPLACE VIEW assigned_sibling_demands_by_priority_subproject_gml_export_view AS
SELECT
	priority_subproject_request_id AS request_id,
	receptor_id,
	substance_id,
	result_type,
	SUM(result) AS result

	FROM request_demands_gml_export_view
		INNER JOIN assigned_siblings_by_priority_subproject_view USING (request_id)

	GROUP BY priority_subproject_request_id, receptor_id, substance_id, result_type
;


/*
 * priority_project_demands_gml_export_view
 * ----------------------------------------
 * Bepaalt de totale projectbehoefte van de reservering (reserved) en de toegekende deelprojecten (assigned).
 * In GML zijn de rekenresultaten per stof en result type opgeslagen. Deze view geeft echter voor de result-type deposition resultaten terug.
 * Gebruik request_id in WHERE/GROUP clause.
 */
CREATE OR REPLACE VIEW priority_project_demands_gml_export_view AS
SELECT
	request_id,
	receptor_id,
	substance_id,
	result_type,
	COALESCE(reserved, 0) AS reserved,
	COALESCE(assigned, 0) AS assigned

	FROM
	
		(SELECT
			request_id,
			receptor_id,
			substance_id,
			result_type,
			result AS reserved

			FROM request_demands_gml_export_view
				INNER JOIN priority_projects USING (request_id)

		) AS reserved
		
		FULL OUTER JOIN
			(SELECT
					priority_project_request_id AS request_id,
					receptor_id,
					substance_id,
					result_type,
					SUM(result) AS assigned

					FROM request_demands_gml_export_view
						INNER JOIN priority_subprojects USING (request_id)
						INNER JOIN requests USING (request_id)

					WHERE status::development_space_state = 'assigned'

					GROUP BY
						priority_project_request_id,
						receptor_id,
						substance_id,
						result_type

				) AS assigned_space USING (request_id, receptor_id, substance_id, result_type)
;