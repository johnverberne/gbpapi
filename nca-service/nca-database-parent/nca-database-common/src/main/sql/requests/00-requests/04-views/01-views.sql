/*
 * request_calculation_status_view
 * -------------------------------
 * Bepaalt of de berekening(en) voor een aanvraag klaar zijn of niet.
 */
CREATE OR REPLACE VIEW request_calculation_status_view AS
SELECT
	request_id,
	bool_and(COALESCE(calculations.state = 'completed', FALSE)) AS finished

	FROM requests
		LEFT JOIN request_situation_calculations USING (request_id)
		LEFT JOIN calculations USING (calculation_id)

	GROUP BY request_id
;


/*
 * request_calculations_view
 * -------------------------
 * Bepaalt welke berekeningen voor een aanvraag zijn gedaan.
 */
CREATE OR REPLACE VIEW request_calculations_view AS
SELECT
	requests.request_id,
	proposed.calculation_id AS proposed_calculation_id,
	current.calculation_id AS current_calculation_id

	FROM requests
		INNER JOIN request_situation_calculations AS proposed USING (request_id)
		LEFT JOIN (
			SELECT request_id, calculation_id
				FROM request_situation_calculations
				WHERE situation = 'current') AS current USING (request_id)

	WHERE proposed.situation = 'proposed'
;


/*
 * request_demands_view
 * --------------------
 * Bepaalt de depositie voor een aanvraag voor een receptor.
 */
CREATE OR REPLACE VIEW request_demands_view AS
SELECT
	req.request_id,
	dev.receptor_id,
	dev.development_space_demand

	FROM request_calculations_view AS req
		INNER JOIN development_space_demands AS dev ON (dev.proposed_calculation_id = req.proposed_calculation_id AND dev.current_calculation_id = COALESCE(req.current_calculation_id, 0))
;


/*
 * request_demands_gml_export_view
 * -------------------------------
 * Bepaalt voor een aanvraag de depositie resultaten per receptor en stof.
 * In het geval dat er 2 situaties zijn wordt het verschil geretourneerd.
 */
CREATE OR REPLACE VIEW request_demands_gml_export_view AS
SELECT
	request_id,
	proposed.receptor_id,
	proposed.substance_id,
	proposed.result_type,
	proposed.result - COALESCE(current.result, 0) AS result

	FROM request_calculations_view
		INNER JOIN calculation_results_view AS proposed ON (request_calculations_view.proposed_calculation_id = proposed.calculation_id)
		LEFT JOIN calculation_results_view AS current ON (request_calculations_view.current_calculation_id = current.calculation_id
				AND proposed.receptor_id = current.receptor_id
				AND proposed.substance_id = current.substance_id
				AND proposed.result_type = current.result_type)

	WHERE proposed.result_type = 'deposition'
;


/*
 * requests_to_assessment_areas_view
 * ---------------------------------
 * Bepaalt welke aanvragen invloed hebben op een natuurgebied. Gebruikt in de zoekfilters van de aanvragen (momenteel alleen prioritaire projecten).
 * Dit gebeurd simpelweg door te kijken naar rekenresultaten: er wordt vanuit gegaan dat als er een resultaat is, dat de aanvraag invloed heeft.
 * Er zou wellicht naar proposed/current gekeken kunnen worden, maar dat gaat waarschijnlijk ten koste van performance.
 *
 * Er wordt alleen gezocht binnen PAS-gebieden, dus bij aanvragen met "grenshexagonen" wordt geen link gemaakt naar niet-PAS-gebieden.
 */
CREATE OR REPLACE VIEW requests_to_assessment_areas_view AS
SELECT DISTINCT
	assessment_area_id,
	request_id

	FROM assessment_areas
		INNER JOIN pas_assessment_areas USING (assessment_area_id)
		INNER JOIN receptors_to_assessment_areas USING (assessment_area_id)
		INNER JOIN reserved_development_spaces USING (receptor_id)
		INNER JOIN calculation_results USING (receptor_id)
		INNER JOIN calculation_result_sets USING (calculation_result_set_id)
		INNER JOIN request_situation_calculations USING (calculation_id)
		INNER JOIN requests USING (request_id, segment)
;


/*
 * decree_requests_without_decree_file_view
 * ----------------------------------------
 * Retourneert de aanvragen die in aanmerking komen voor een bijlage bij besluit, maar een bepaald bestand nog niet hebben.
 *
 * Gebruik file_type in de WHERE-clause om te filteren op een specifiek bestand, segment voor een bepaald soort aanvraag.
 */
CREATE OR REPLACE VIEW decree_requests_without_decree_file_view AS
SELECT
	file_type,
	request_id

	FROM unnest(ARRAY['decree', 'detail_decree']::request_file_type[]) AS file_type
		CROSS JOIN requests
		LEFT JOIN request_files AS permits_with_decree USING (request_id, file_type)

	WHERE status IN ('assigned', 'assigned_final', 'rejected_without_space')
		AND permits_with_decree.request_id IS NULL
		AND segment IN ('projects', 'priority_subprojects')
;