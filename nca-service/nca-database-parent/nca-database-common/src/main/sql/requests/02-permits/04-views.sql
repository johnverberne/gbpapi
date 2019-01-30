/*
 * permits_view
 * ------------
 * View om aanvragen op te halen met vaak gebruikte eigenschappen.
 */
CREATE OR REPLACE VIEW permits_view AS
SELECT
	request_id,
	reference,
	sector_id,
	has_multiple_sectors,
	marked,
	dossier_id,
	received_date,
	status,
	(potentially_rejectable_permits.request_id IS NOT NULL) AS potentially_rejectable,
	corporation,
	project_name,
	description,
	segment,
	start_year,
	temporary_period,
	handler_id,
	remarks,
	requests.authority_id,
	province_area_id,
	application_version,
	database_version,
	last_modified,
	geometry

	FROM permits
		INNER JOIN requests USING (request_id)
		INNER JOIN users ON (users.user_id = permits.handler_id)
		INNER JOIN user_details USING (user_id)
		LEFT JOIN potentially_rejectable_permits USING (request_id)
;


/*
 * dequeueable_permits_view
 * ------------------------
 * Retourneert de aanvragen die in de wachtrij staan waarvan de termijn verstreken is (gesorteerd van oud naar nieuw).
 * Dit zijn alleen vergunningen uit segment 2.
 */
CREATE OR REPLACE VIEW dequeueable_permits_view AS
SELECT
	request_id,
	received_date

	FROM permits
		INNER JOIN requests USING (request_id)

	WHERE
		segment = 'projects'
		AND status = 'queued'
		AND (now()::date - received_date::date) >= ae_constant('PERMIT_RECEIVED_DATE_TERM')::integer

	ORDER BY received_date
;


/*
 * permit_assessment_areas_view
 * ----------------------------
 * Geeft per permit aan welke gebieden geraakt worden.
 * Het gaat hierbij om alle receptoren die doorgerekend zijn. Dit kunnen ook niet OR relevante receptoren en grenshexagonen zijn.
 */
CREATE OR REPLACE VIEW permit_assessment_areas_view AS
SELECT DISTINCT
	request_id,
	assessment_area_id

	FROM permits
		INNER JOIN request_demands_view USING (request_id)
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
;


/*
 * permit_assessment_area_review_info_view
 * ---------------------------------------
 * Geeft per vergunning en N2000-gebied o.a. aan hoeveel ruimte al toegekend is.
 * Deze view wordt gebruikt in Register in de Toetsing-tab van een aanvraag.
 * Niet-PAS-gebieden worden weggefilterd zodat deze ondanks "grenshexagonen" toch niet worden getoond.
 * Er worden resultaten teruggeven voor twee receptorsets: de normale OR-relevante set en de exceeding receptor set. Deze zijn gescheiden met een boolean
 * veld genaamd "only_exceeding" welke in de WHERE-clause gebruikt kan worden.
 *
 * @column only_exceeding Of de getallen gelden voor de exceeding receptor set (TRUE) of alle OR-relevante receptoren (FALSE).
 * @column total_development_space_demand Aangevraagde ontwikkelingsruimte in het gebied.
 * @column available_exclusive Huidig beschikbare ontwikkelingsruimte in het gebied (zonder aanvraag).
 * @column shortage_inclusive Tekorten in ontwikkelingsruimte indien de aanvraag wordt goedgekeurd.
 * @column shortage_count_inclusive Aantal receptoren in het gebied waar een tekort aan ontwikkelingsruimte is, inclusief de aanvraag. Dit zal gelijk zijn
 *   aan het aantal receptoren die falen in de 'exceeding_space_check' van ae_development_rule_exceeding_space_check().
 *
 * @see ae_development_rule_exceeding_space_check()
 */
CREATE OR REPLACE VIEW permit_assessment_area_review_info_view AS
SELECT
	request_id,
	assessment_area_id,
	assessment_areas.name AS assessment_area_name,

	only_exceeding,

	total_development_space_demand,
	available_exclusive,
	shortage_inclusive,
	shortage_count_inclusive

	FROM
		(SELECT
			request_id,
			assessment_area_id,

			only_exceeding,

			SUM(development_space_demand::numeric) AS total_development_space_demand,
			SUM(GREATEST(available_after_assigned::numeric, 0)) AS available_exclusive,
			SUM(LEAST(available_after_assigned - COALESCE(development_space_demand, 0), 0)::numeric) AS shortage_inclusive,
			SUM((NOT ae_has_space(available_after_assigned, COALESCE(development_space_demand, 0)))::integer) AS shortage_count_inclusive

			FROM permit_assessment_areas_view
				INNER JOIN pas_assessment_areas USING (assessment_area_id)
				INNER JOIN receptors_to_assessment_areas USING (assessment_area_id)
				INNER JOIN available_development_spaces_view AS available USING (receptor_id)
				LEFT JOIN request_demands_view USING (request_id, receptor_id)
				LEFT JOIN non_exceeding_receptors USING (receptor_id)
				CROSS JOIN unnest(ARRAY[TRUE, FALSE]) AS only_exceeding

			WHERE
				segment = 'projects'
				AND (only_exceeding IS FALSE OR non_exceeding_receptors.receptor_id IS NULL)

			GROUP BY request_id, assessment_area_id, only_exceeding
		) AS demands

		INNER JOIN assessment_areas USING (assessment_area_id)

	WHERE total_development_space_demand > 0
;
