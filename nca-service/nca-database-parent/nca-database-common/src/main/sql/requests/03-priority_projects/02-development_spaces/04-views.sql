/*
 * priority_project_available_development_spaces_view
 * --------------------------------------------------
 * View om de huidig beschikbare ontwikkelingsruimte van een prioritair project te bepalen.
 */
CREATE OR REPLACE VIEW priority_project_available_development_spaces_view AS
SELECT
	request_id,
	receptor_id,
	reserved_space,
	assigned_space,
	reserved_space - assigned_space AS available_space,
	COALESCE(assigned_space / NULLIF(reserved_space, 0), 0) AS fraction_space_assigned

	FROM priority_project_development_spaces
;


/*
 * priority_project_max_space_assigned_receptor_view
 * -------------------------------------------------
 * View om de receptor met het hoogste percentage toegewezen ruimte te bepalen voor een segment 1 project.
 */
CREATE OR REPLACE VIEW priority_project_max_space_assigned_receptor_view AS
SELECT DISTINCT ON (request_id)
	request_id,
	receptor_id,
	fraction_space_assigned

	FROM priority_project_available_development_spaces_view

	ORDER BY request_id, fraction_space_assigned DESC
;


/*
 * priority_subproject_space_view
 * ------------------------------
 * View die bepaalt hoeveel ruimte er nog is voor een deelproject in een koepelproject.
 *
 * Het kan zijn dat een deelproject meer receptoren heeft doorgerekend dan gereserveerd is in het koepelproject. Deze receptoren worden dan wel
 * teruggegeven met een reservering van 0. En dus zal het deelproject dan nooit passen.
 *
 * Let op: alleen receptoren die in de berekening zitten van het deelproject worden teruggegeven.
 * Tevens worden niet-OR-relevante receptoren uit de rekenresultaten gehaald; deze zullen namelijk nooit invloed hebben of een deelproject past.
 *
 * De volgorde van deze joins is zeer nauwkeurig; omdraaien kan leiden tot slechte performance of andere resultaten.
 */
CREATE OR REPLACE VIEW priority_subproject_space_view AS
SELECT
	request_id,
	receptor_id,
	COALESCE(development_space_demand, 0) AS development_space_demand,
	COALESCE(reserved, 0) AS reserved,
	COALESCE(assigned_exclusive, 0) AS assigned_exclusive,
	COALESCE(assigned_exclusive, 0) + COALESCE(development_space_demand, 0) AS assigned_inclusive,
	COALESCE(available_exclusive, 0) AS available_exclusive,
	COALESCE(available_exclusive, 0) - COALESCE(development_space_demand, 0) AS available_inclusive,
	NOT ae_has_space(COALESCE(available_exclusive, 0), COALESCE(development_space_demand, 0)) AS has_shortage

	FROM priority_subprojects
		INNER JOIN request_demands_view USING (request_id)
		INNER JOIN reserved_development_spaces USING (receptor_id) -- Get rid of non-OR receptors in the calculation
		LEFT JOIN
			(SELECT
				request_id AS priority_project_request_id,
				receptor_id,
				reserved_space AS reserved,
				assigned_space AS assigned_exclusive,
				available_space AS available_exclusive

				FROM priority_project_available_development_spaces_view
			) AS development_spaces USING (priority_project_request_id, receptor_id)

	WHERE reserved_development_spaces.segment = 'priority_projects'
;


/*
 * priority_subproject_assessment_area_review_info_view
 * ----------------------------------------------------
 * Geeft toetsings informatie van een deelproject per N2000-gebied, met name of de aanvraag past binnen de OR van het prioritair project als deze zou
 * worden toegekend.
 * Het wordt gebruikt in Register in de Toetsing tabel van een prioritair deelproject.
 * Niet-PAS-gebieden worden weggefilterd zodat deze ondanks "grenshexagonen" toch niet worden getoond.
 *
 * @column shortage_inclusive Gemiddelde tekort ontwikkelingsruimte in het toetsgebied indien de aanvraag wordt goedgekeurd (positief getal). Alleen het
 *  gemiddelde van de tekorten wordt genomen, receptoren zonder tekort worden niet meegeteld.
 * @column shortage_count_inclusive Aantal receptoren in het gebied waar een tekort aan ontwikkelingsruimte is, inclusief de aanvraag.
 */
CREATE OR REPLACE VIEW priority_subproject_assessment_area_review_info_view AS
SELECT
	request_id,
	assessment_area_id,
	assessment_areas.name AS assessment_area_name,

	COALESCE(AVG(shortage), 0)::real AS shortage_inclusive, -- only average shortages
	SUM((has_shortage)::integer)::integer AS shortage_count_inclusive

	FROM (SELECT
			request_id,
			receptor_id,
			has_shortage,
			NULLIF(CASE WHEN has_shortage THEN -available_inclusive ELSE 0 END, 0) AS shortage

			FROM priority_subproject_space_view) AS sub_query
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN pas_assessment_areas USING (assessment_area_id)

	GROUP BY request_id, assessment_area_id, assessment_areas.name
;


/*
 * ae_priority_subproject_checks_assessment_areas
 * ----------------------------------------------
 * Bepaal de uitkomsten van de beleidsregel wat betreft het uitgeven van ruimte binnen een prioritair project voor een prioritair subproject,
 * geaggregeerd per toetsgebied.
 * Met de boolean v_with_demand kan aangegeven worden of de development_space_demand meegenomen moet worden (TRUE) of dat deze al in de OR opgenomen is (FALSE).
 * Indien 1 receptor niet slaagt voor de regel, dan het hele gebied niet.
 * Niet-PAS-gebieden worden weggefilterd zodat deze ondanks "grenshexagonen" toch niet worden getoond.
 */
CREATE OR REPLACE FUNCTION ae_priority_subproject_checks_assessment_areas(v_request_id integer, v_with_demand boolean)
	RETURNS TABLE(assessment_area_id integer, passed boolean) AS
$BODY$
SELECT
	assessment_area_id,
	bool_and(COALESCE(
			CASE WHEN v_with_demand THEN NOT has_shortage ELSE ae_has_space(available_exclusive, 0) END,
			TRUE)) AS passed_check

	FROM priority_subproject_space_view
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		INNER JOIN pas_assessment_areas USING (assessment_area_id)

	WHERE request_id = v_request_id

	GROUP BY assessment_area_id
;
$BODY$
LANGUAGE sql VOLATILE;


/*
 * ae_priority_subproject_checks_habitats
 * --------------------------------------
 * Bepaal de uitkomsten van de beleidsregel wat betreft het uitgeven van ruimte binnen een prioritair project voor een prioritair subproject,
 * geaggregeerd per toetsgebied en habitat type.
 * Met de boolean v_with_demand kan aangegeven worden of de development_space_demand meegenomen moet worden (TRUE) of dat deze al in de OR opgenomen is (FALSE).
 * Indien 1 receptor niet slaagt voor de regel, dan het hele gebied niet.
 * Niet-PAS-gebieden worden weggefilterd zodat deze ondanks "grenshexagonen" toch niet worden getoond.
 */
CREATE OR REPLACE FUNCTION ae_priority_subproject_checks_habitats(v_request_id integer, v_with_demand boolean)
	RETURNS TABLE(assessment_area_id integer, habitat_type_id integer, passed boolean) AS
$BODY$
SELECT
	assessment_area_id,
	habitat_type_id,
	bool_and(COALESCE(
			CASE WHEN v_with_demand THEN NOT has_shortage ELSE ae_has_space(available_exclusive, 0) END,
			TRUE)) AS passed_check

	FROM priority_subproject_space_view
		INNER JOIN receptors_to_relevant_habitats_view USING (receptor_id)
		INNER JOIN pas_assessment_areas USING (assessment_area_id)

	WHERE request_id = v_request_id

	GROUP BY assessment_area_id, habitat_type_id
;
$BODY$
LANGUAGE sql VOLATILE;
