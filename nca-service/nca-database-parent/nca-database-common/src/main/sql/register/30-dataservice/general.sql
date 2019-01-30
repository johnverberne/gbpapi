/*
 * sync_pronouncements_per_week_view
 * ---------------------------------
 * Synchronisatie view voor het ophalen van het aantal meldingen (per week) van de afgelopen anderhalf jaar.
 * De afgewezen meldingen worden niet meegenomen in de telling.
 */
CREATE OR REPLACE VIEW dataservice.sync_pronouncements_per_week_view AS
SELECT
	monday AS first_day_of_week,
	COUNT(request_id) AS value

	FROM
		(SELECT date_trunc('week', generate_series(now() - interval '78 weeks', now(), '1 week'))::date AS monday) past_mondays

		LEFT JOIN
			(SELECT
				request_id,
				date_trunc('week', insert_date)::date AS monday

				FROM requests
					INNER JOIN pronouncements USING (request_id)

				WHERE status = 'assigned' -- Only count assigned pronouncements

			) AS pronouncements USING (monday)

	GROUP BY monday
	ORDER BY monday
;



/*
 * sync_permits_per_week_view
 * --------------------------
 * Synchronisatie view voor het ophalen van het aantal aanvragen (per week) van de afgelopen anderhalf jaar.
 * Het gaat hier om alle aanvragen, dus ook de eventueel afgewezen aanvragen.
 */
CREATE OR REPLACE VIEW dataservice.sync_permits_per_week_view AS
SELECT
	monday AS first_day_of_week,
	COUNT(request_id) AS value

	FROM
		(SELECT date_trunc('week', generate_series(now() - interval '78 weeks', now(), '1 week'))::date AS monday) past_mondays

		LEFT JOIN
			(SELECT
				request_id,
				date_trunc('week', insert_date)::date AS monday

				FROM requests
					INNER JOIN permits USING (request_id)
			) AS permits USING (monday)

	GROUP BY monday
	ORDER BY monday
;
