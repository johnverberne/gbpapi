/*
 * calculation_development_space_percentage_view
 * ---------------------------------------------
 * Retourneert het procentuele beroep op de ontwikkelingsruimte (van segment 2, 'projects' segment).
 * per berekening, receptor en rekenstof.
 *
 * Gebruik 'calculation_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_development_space_percentage_view AS
SELECT
	calculation_id,
	receptor_id,
	deposition / space AS development_space_percentage

	FROM calculation_summed_deposition_results_view
		INNER JOIN initial_available_development_spaces USING (receptor_id)

	WHERE
		segment = 'projects'
		AND space > 0
;


/*
 * calculation_markers_for_assessment_area_view
 * --------------------------------------------
 * Per berekening en natuurgebied worden de volgende receptoren/markers teruggegeven:
 * - receptor met de hoogste berekende depositie (projectbijdrage) (roze marker)
 * - receptor met de hoogste totale depositie bij overschrijding van de KDW (blauwe marker)
 * - receptor met het hoogste procentuele beroep op de ontwikkelingsruimte (oranje marker)
 *
 * Indien de KDW nergens is overschreden zal total_deposition de waarde NULL hebben.
 * Indien er geen receptor met development space is berekent zal development_space_percentage de waarde NULL hebben.
 *
 * Markers worden zowel in UI als PDF gebruikt.
 *
 * Gebruik 'calculation_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_markers_for_assessment_area_view AS
SELECT
	calculation_id,
	assessment_area_id,

	(ae_max_with_key(receptor_id::numeric, deposition::numeric)).key::integer AS calculation_deposition_receptor_id,
	MAX(deposition)::real AS calculation_deposition,

	(ae_max_with_key(exceeding.receptor_id::numeric, exceeding.total_deposition::numeric)).key::integer AS total_deposition_receptor_id,
	MAX(exceeding.total_deposition)::real AS total_deposition,

	(ae_max_with_key(usage.receptor_id::numeric, usage.development_space_percentage::numeric)).key::integer AS development_space_percentage_receptor_id,
	MAX(usage.development_space_percentage)::real AS development_space_percentage

	FROM calculation_summed_deposition_results_view
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
		LEFT JOIN exceeding_calculation_depositions_view AS exceeding USING (calculation_id, receptor_id)
		LEFT JOIN calculation_development_space_percentage_view AS usage USING (calculation_id, receptor_id)

	GROUP BY calculation_id, assessment_area_id
;


/*
 * critical_deposition_area_calculation_results_view
 * -------------------------------------------------
 * Toont depositie statistieken van een berekening, per natuurgebied en per habitattype (of kdw gebied).
 * Van het KDW gebied wordt de naam en omschrijving teruggegeven.
 *
 * @column sum_deposition wordt de depositie geschaald naar overlap.
 * @column max_deposition is de depositie van de receptor met de hoogste depositie.
 * @column avg_deposition is de gemiddelde depositie per gebied.
 * @column percentage_critical_deposition geeft het percentage weer van de depositie ten opzichte van de KDW. Dus als de KDW 80 is
 * en de depositie 100 dan is het percentage 125.
 *
 * Gebruik 'calculation_id', 'calculation_substance' en 'type' in de WHERE clause.
 * Wordt in de UI aangeroepen met type = 'relevant_habitat'.
 */
CREATE OR REPLACE VIEW critical_deposition_area_calculation_results_view AS
SELECT
	proposed_calculation_id AS calculation_id,
	assessment_area_id,
	critical_deposition_area_id,
	type,
	name,
	description,
	calculation_substance,
	SUM(proposed_deposition * weight)::real AS sum_deposition,
	MAX(proposed_deposition) AS max_deposition,
	ae_weighted_avg(proposed_deposition::numeric, weight::numeric)::real AS avg_deposition,
	COALESCE(MAX(COALESCE(depositions_jurisdiction_policies.total_deposition, 0) + proposed_deposition) / NULLIF(critical_deposition, 0), 0) * 100::real AS percentage_critical_deposition

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN critical_deposition_areas_view USING (assessment_area_id, type, critical_deposition_area_id)
		INNER JOIN calculation_combination_all_depositions_view USING (receptor_id)
		LEFT JOIN depositions_jurisdiction_policies USING (year, receptor_id)

	WHERE current_calculation_id IS NULL

	GROUP BY calculation_id, assessment_area_id,
			critical_deposition_area_id, type, name, description,
			calculation_substance, critical_deposition
;


/*
 * critical_deposition_area_calculations_difference_view
 * -----------------------------------------------------
 * Toont verschil in depositie, maximum depositie, gemiddelde depositie per natuurgebied, per KDW gebied en per type stof tussen twee berekeningen.
 * (Tijdelijk weggehaald: Verschil in procentpunten van het percentage ten opzichte van de KDW)
 * Gebruik 'base_calculation_id', 'variant_calculation_id' en 'type' in de WHERE clause.
 * Wordt in de UI aangeroepen met type = 'relevant_habitat'.
 */
CREATE OR REPLACE VIEW critical_deposition_area_calculations_difference_view AS
SELECT
	current_calculation_id AS base_calculation_id,
	proposed_calculation_id AS variant_calculation_id,
	assessment_area_id,
	critical_deposition_area_id,
	type,
	name,
	description,
	calculation_substance,
	SUM((proposed_deposition - current_deposition) * weight) AS total_deposition_diff,
	MAX(proposed_deposition - current_deposition) AS max_deposition_diff,
	ae_weighted_avg((proposed_deposition - current_deposition)::numeric, weight::numeric)::real AS avg_deposition_diff

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN critical_deposition_areas_view USING (assessment_area_id, type, critical_deposition_area_id)
		INNER JOIN calculation_combination_all_depositions_view USING (receptor_id)

	WHERE receptors_to_critical_deposition_areas_view.type IN ('habitat', 'relevant_habitat')

	GROUP BY base_calculation_id, variant_calculation_id, assessment_area_id,
			critical_deposition_area_id, type, name, description,
			calculation_substance
;


/*
 * receptors_to_calculation_critical_deposition_areas_view
 * -------------------------------------------------------
 * Geeft alle receptoren binnen een berekening per toetsgebied en KDW gebied.
 * Wordt in de UI aangeroepen met type = 'relevant_habitat'.
 */
CREATE OR REPLACE VIEW receptors_to_calculation_critical_deposition_areas_view AS
SELECT DISTINCT
	calculation_id,
	assessment_area_id,
	critical_deposition_area_id,
	type,
	receptor_id,
	surface

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN calculation_results USING (receptor_id)
		INNER JOIN calculation_result_sets USING (calculation_result_set_id)
;


/*
 * calculation_point_results_with_background_depositions_view
 * ----------------------------------------------------------
 * Geeft de resultaten van de calculation points (door gebruiker gedefinieerde punten) inclusief achtergrond depositie op dat punt.
 * Achtergrond depositie is bepaalt aan de hand van year in de calculation tabel.
 *
 * Gebruik 'calculation_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW calculation_point_results_with_background_depositions_view AS
SELECT
	calculation_id,
	calculation_point_id,
	label,
	substance_id,
	result_type,
	result,
	background_cell_depositions.deposition AS background_deposition,
	calculation_point_results_view.geometry

	FROM calculation_point_results_view
		INNER JOIN calculations USING (calculation_id) -- for year
		LEFT JOIN background_cells ON ST_Within(calculation_point_results_view.geometry, background_cells.geometry)
		LEFT JOIN background_cell_depositions USING (background_cell_id, year)
;
