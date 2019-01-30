/*
 * calculation_depositions_view
 * ----------------------------
 * Retourneert de totale depositie per berekening, receptor en rekenstof.
 *   totale depositie = achtergrond depositie rekenjaar + projectbijdrage
 *
 * Gebruik 'calculation_id' en eventueel 'calculation_substance' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_depositions_view AS
SELECT
	calculation_summed_deposition_results_view.calculation_id,
	calculation_summed_deposition_results_view.receptor_id,
	(calculation_summed_deposition_results_view.deposition +
		COALESCE(depositions_jurisdiction_policies.total_deposition, 0)) AS total_deposition

	FROM calculation_summed_deposition_results_view
		INNER JOIN calculations USING (calculation_id)
		LEFT JOIN depositions_jurisdiction_policies USING (year, receptor_id)
;


/*
 * exceeding_calculation_depositions_view
 * --------------------------------------
 * Retourneert (indien kritische depositiewaarde is overschreden) de totale depositie en KDW-overschrijdingspercentage.
 * per berekening, receptor en rekenstof.
 *
 * Gebruik 'calculation_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW exceeding_calculation_depositions_view AS
SELECT
	calculation_id,
	receptor_id,
	total_deposition,
	(total_deposition - critical_deposition) / critical_deposition AS exceed_percentage

	FROM calculation_depositions_view
		INNER JOIN critical_depositions USING (receptor_id)

	WHERE total_deposition > critical_deposition
;
