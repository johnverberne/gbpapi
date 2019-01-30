/*
 * ae_insert_calculation_demands
 * -----------------------------
 * SQL functie voor het bepalen van demands (depositie nh3+nox) voor een berekening (voor 1 situatie of 2 situaties).
 * Dit resultaat wordt opgeslagen in de tabel "development_space_demands".
 *
 * @param v_proposed_calculation_id Berekenings-id van de gewenste situatie.
 * @param v_current_calculation_id Berekenings-id van de huidige situatie. Mag NULL zijn als de situatie er niet is.
 * @param v_zeroing_of_development_space_demands_under_threshold Als TRUE, dan worden waarden onder de grenswaarde in het veld 'development_space_demand' teruggegeven als 0.
 *
 * @see development_space_demands
 */
CREATE OR REPLACE FUNCTION ae_insert_calculation_demands(v_proposed_calculation_id integer, v_current_calculation_id integer, v_zeroing_of_development_space_demands_under_threshold boolean)
	RETURNS void AS
$BODY$
	INSERT INTO development_space_demands (proposed_calculation_id, current_calculation_id, receptor_id, development_space_demand)
	SELECT
		v_proposed_calculation_id,
		COALESCE(v_current_calculation_id, 0),
		receptor_id,
		(CASE WHEN ((reserved_development_spaces.receptor_id IS NULL) OR (v_zeroing_of_development_space_demands_under_threshold AND delta_demand < ae_constant('PRONOUNCEMENT_THRESHOLD_VALUE')::real)) THEN
			0
		ELSE
			GREATEST(delta_demand, 0)
		END) AS development_space_demand

		FROM
			(SELECT
				receptor_id,
				proposed_demand - COALESCE(current_demand, 0) AS delta_demand

				FROM
					(SELECT
						receptor_id,
						GREATEST(deposition, 0) AS proposed_demand

						FROM calculations
							INNER JOIN calculation_summed_deposition_results_view USING (calculation_id)

						WHERE calculation_id = v_proposed_calculation_id
					) AS proposed_demands

					LEFT JOIN
						(SELECT
							receptor_id,
							GREATEST(deposition, 0) AS current_demand

							FROM calculations
								INNER JOIN calculation_summed_deposition_results_view USING (calculation_id)

							WHERE calculation_id = v_current_calculation_id
						) AS current_demands USING (receptor_id)
			) AS demands

			LEFT JOIN
				(SELECT
					DISTINCT receptor_id
					FROM reserved_development_spaces
				) AS reserved_development_spaces USING (receptor_id)
	;
$BODY$
LANGUAGE SQL VOLATILE;
