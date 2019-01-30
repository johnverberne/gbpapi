/*
 * calculation_results_view
 * ------------------------
 * Alle emission results (concentraties, deposities en overschrijdingsdagen) per calculation en receptor.
 * Gebruik 'calculation_id', 'receptor_id', 'substance_id' en 'result_type' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_results_view AS
SELECT
	calculation_id,
	receptor_id,
	substance_id,
	result_type,
	result

	FROM calculation_results
		INNER JOIN calculation_result_sets USING (calculation_result_set_id)

	WHERE result_set_type = 'total'
;


/*
 * calculation_sector_results_view
 * -------------------------------
 * Alle emission results (concentraties, deposities en overschrijdingsdagen) per calculation en receptor.
 * Gebruik 'calculation_id', 'receptor_id', 'substance_id' en 'result_type' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_sector_results_view AS
SELECT
	calculation_id,
	receptor_id,
	substance_id,
	result_type,
	result_set_type_key AS sector_id,
	result

	FROM calculation_results
		INNER JOIN calculation_result_sets USING (calculation_result_set_id)

	WHERE result_set_type = 'sector'
;


/*
 * calculation_point_results_view
 * ------------------------------
 * Alle emission results (concentraties, deposities en overschrijdingsdagen) per calculation en custom points.
 * Gebruik 'calculation_id', 'receptor_id', 'substance_id' en 'result_type' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_point_results_view AS
SELECT
	calculation_id,
	calculation_point_id,
	label,
	substance_id,
	result_type,
	result,
	calculation_points.geometry

	FROM calculation_point_results
		INNER JOIN calculation_result_sets USING (calculation_result_set_id)
		INNER JOIN calculations USING (calculation_id)
		INNER JOIN calculation_points USING (calculation_point_set_id, calculation_point_id)
		
	WHERE result_set_type = 'total'
;


/*
 * calculation_point_sector_results_view
 * -------------------------------------
 * Alle emission results (concentraties, deposities en overschrijdingsdagen) per calculation en custom points.
 * Gebruik 'calculation_id', 'receptor_id', 'substance_id' en 'result_type' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_point_sector_results_view AS
SELECT
	calculation_id,
	calculation_point_id,
	label,
	substance_id,
	result_type,
	result_set_type_key AS sector_id,
	result,
	calculation_points.geometry

	FROM calculation_point_results
		INNER JOIN calculation_result_sets USING (calculation_result_set_id)
		INNER JOIN calculations USING (calculation_id)
		INNER JOIN calculation_points USING (calculation_point_set_id, calculation_point_id)
		
	WHERE result_set_type = 'sector'
;


/*
 * calculation_summed_deposition_results_view
 * ------------------------------------------
 * Retourneert de gesommeerde NOx en NH3 (= substance_id 11 + 17) projectbijdrage (calculation_deposition) per berekening en receptor.
 * 
 * Gebruik 'calculation_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_summed_deposition_results_view AS
SELECT 
	calculation_id, 
	receptor_id, 
	SUM(result) AS deposition

	FROM calculation_results_view

	WHERE
		substance_id IN (11, 17)
		AND result_type = 'deposition'

	GROUP BY calculation_id, receptor_id
;


/*
 * calculation_deposition_results_view
 * -----------------------------------
 * Retourneert de projectbijdrage (calculation_deposition) per berekening, receptor en rekenstof.
 * substance_id wordt omgezet naar een calculation_substance_type (rekenstof). Retourneert ook de gesommeerde rekenstof "noxnh3" (= substance_id 11 + 17).
 *
 * Gebruik 'calculation_id' en eventueel 'calculation_substance' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_deposition_results_view AS
SELECT calculation_id, receptor_id, 'nox'::calculation_substance_type AS calculation_substance, result AS calculation_deposition
	FROM calculation_results_view
	WHERE
		substance_id = 11
		AND result_type = 'deposition'
UNION ALL
SELECT calculation_id, receptor_id, 'nh3'::calculation_substance_type AS calculation_substance, result AS calculation_deposition
	FROM calculation_results_view
	WHERE
		substance_id = 17
		AND result_type = 'deposition'
UNION ALL
SELECT calculation_id, receptor_id, 'noxnh3'::calculation_substance_type AS calculation_substance, deposition AS calculation_deposition
	FROM calculation_summed_deposition_results_view
;


/*
 * calculation_sector_summed_deposition_results_view
 * -------------------------------------------------
 * Retourneert de gesommeerde NOx en NH3 (= substance_id 11 + 17) projectbijdrage (calculation_deposition) per berekening, sector en receptor.
 * 
 * Gebruik 'calculation_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_sector_summed_deposition_results_view AS
SELECT 
	calculation_id, 
	receptor_id, 
	sector_id,
	SUM(result) AS calculation_deposition

	FROM calculation_sector_results_view

	WHERE
		substance_id IN (11, 17)
		AND result_type = 'deposition'

	GROUP BY calculation_id, receptor_id, sector_id
;


/*
 * calculation_sector_deposition_results_view
 * ------------------------------------------
 * Retourneert de projectbijdrage (calculation_deposition) per berekening, receptor en rekenstof.
 * substance_id wordt omgezet naar een calculation_substance_type (rekenstof). Retourneert ook de gesommeerde rekenstof "noxnh3" (= substance_id 11 + 17).
 *
 * Gebruik 'calculation_id' en eventueel 'calculation_substance' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_sector_deposition_results_view AS
SELECT calculation_id, receptor_id, 'nox'::calculation_substance_type AS calculation_substance, sector_id, result AS calculation_deposition
	FROM calculation_sector_results_view
	WHERE 
		substance_id = 11
		AND result_type = 'deposition'
UNION ALL
SELECT calculation_id, receptor_id, 'nh3'::calculation_substance_type AS calculation_substance, sector_id, result AS calculation_deposition
	FROM calculation_sector_results_view
	WHERE
		substance_id = 17
		AND result_type = 'deposition'
UNION ALL
SELECT calculation_id, receptor_id, 'noxnh3'::calculation_substance_type AS calculation_substance, sector_id, calculation_deposition
	FROM calculation_sector_summed_deposition_results_view
;


/*
 * ae_calculation_all_depositions
 * ------------------------------
 * Convenience SQL functie voor het bepalen van deposities voor verschillende stoffen en combinaties van stoffen voor een berekening (voor 1 situatie of 2 situaties).
 * Hierbij wordt wel rekening gehouden met receptoren waarvoor in de ene berekening wel resultaten zijn en bij de andere niet. 
 * Hierbij wordt geen rekening gehouden met grenswaardes en/of dalingen (deze worden gewoon teruggegeven).
 * 
 * Door gebruik te maken van een SQL functie wordt voorkomen dat de group by in calculation_summed_deposition_results_view parten gaat spelen voor de performance.
 * Er wordt direct op bepaalde berekeningen gefiltered waardoor een kleinere set geretourneerd wordt ipv dat calculation_summed_deposition_results_view voor alle berekeningen wordt uitgevoerd.
 */
CREATE OR REPLACE FUNCTION ae_calculation_all_depositions(v_proposed_calculation_id integer, v_current_calculation_id integer)
	RETURNS TABLE(receptor_id integer, calculation_substance calculation_substance_type, current_deposition real, proposed_deposition real) AS
$BODY$
	SELECT 
		receptor_id,
		COALESCE(current.calculation_substance, proposed.calculation_substance) AS calculation_substance,
		COALESCE(current.calculation_deposition, 0) AS current_deposition,
		COALESCE(proposed.calculation_deposition, 0) AS proposed_deposition

		FROM 
			(SELECT DISTINCT receptor_id 
				FROM calculation_results
					INNER JOIN calculation_result_sets USING (calculation_result_set_id) 
				WHERE calculation_id IN (v_current_calculation_id, v_proposed_calculation_id)
			) AS receptors
			LEFT JOIN (
				SELECT 
						calculation_id AS current_calculation_id, 
						receptor_id, 
						calculation_substance, 
						calculation_deposition

						FROM calculation_deposition_results_view
						WHERE calculation_id = v_current_calculation_id
			) AS current USING (receptor_id)
			LEFT JOIN (
					SELECT 
						calculation_id AS proposed_calculation_id, 
						receptor_id, 
						calculation_substance, 
						calculation_deposition
						FROM calculation_deposition_results_view
					WHERE calculation_id = v_proposed_calculation_id
			) AS proposed USING (receptor_id)
	
		WHERE current.receptor_id IS NULL 
			OR proposed.receptor_id IS NULL 
			OR (current.receptor_id = proposed.receptor_id AND current.calculation_substance = proposed.calculation_substance)
	;
$BODY$
LANGUAGE sql STABLE;


/*
 * calculation_combinations_view
 * -----------------------------
 * Retourneert de verschillende combinaties van berekeningen om zo tot alle mogelijke proposed en current calculation id's te komen die hetzelfde rekenjaar gebruiken.
 * Ook de combinatie van proposed zonder current calculation wordt hierbij meegenomen.
 */
CREATE OR REPLACE VIEW calculation_combinations_view AS
SELECT
	proposed.calculation_id AS proposed_calculation_id,
	current.calculation_id AS current_calculation_id,
	proposed.year

	FROM calculations AS proposed
		INNER JOIN calculations AS current USING (year)
	WHERE proposed.calculation_id != current.calculation_id
UNION ALL
SELECT
	calculation_id AS proposed_calculation_id,
	NULL AS current_calculation_id,
	year

	FROM calculations
;


/*
 * calculation_combination_all_depositions_view
 * --------------------------------------------
 * Retourneert de deposities voor verschillende stoffen en combinaties van stoffen 
 * van verschillende combinaties van berekeningen.
 */
CREATE OR REPLACE VIEW calculation_combination_all_depositions_view AS
SELECT 
	proposed_calculation_id,
	current_calculation_id,
	year,
	(ae_calculation_all_depositions(proposed_calculation_id, current_calculation_id)).calculation_substance,
	(ae_calculation_all_depositions(proposed_calculation_id, current_calculation_id)).receptor_id,
	(ae_calculation_all_depositions(proposed_calculation_id, current_calculation_id)).current_deposition,
	(ae_calculation_all_depositions(proposed_calculation_id, current_calculation_id)).proposed_deposition

	FROM calculation_combinations_view
;
