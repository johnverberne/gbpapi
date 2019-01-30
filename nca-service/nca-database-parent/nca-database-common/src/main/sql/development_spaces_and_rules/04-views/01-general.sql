/*
 * development_space_demands_extended_view
 * ---------------------------------------
 * Retourneert de OR-behoefte van combinaties van berekeningen uit de development_space_demands tabel inclusief
 * het berekeningsjaar (van de gewenste situatie, moet gelijk zijn aan de huidige situatie) en inclusief de demands
 * van de losse situaties.
 *
 * LET OP: Indien er geen huidige situatie is, dan is current_calculation_id 0 (en dus niet NULL). Dit volgt de inhoud van
 * de development_space_demands tabel en performed goed door de bijbehorende index.
 *
 * @column proposed_calculation_id Berekenings-id gewenste situatie
 * @column current_calculation_id Berekenings-id huidige situatie, of 0 als er alleen een gewenste situatie is
 * @column delta_demand Verschil tussen de gewenste en de huidige behoefte in het geval van 2 situaties; of enkel de gewenste
 *   behoefte in het geval van 1 situatie. Kan negatief zijn!
 *
 * @see full_habitats_pdf_export_view
 * @see full_assessment_areas_pdf_export_view
 * @see development_space_demands
 */
CREATE OR REPLACE VIEW development_space_demands_extended_view AS
SELECT
	development_space_demands.proposed_calculation_id,
	development_space_demands.current_calculation_id,
	year,
	receptor_id,
	development_space_demand,
	proposed_demand - COALESCE(current_demand, 0) AS delta_demand,
	proposed_demand,
	COALESCE(current_demand, 0) AS current_demand

	FROM development_space_demands
		INNER JOIN
			(SELECT
				calculations.year,
				calculation_id AS proposed_calculation_id,
				receptor_id,
				GREATEST(deposition, 0) AS proposed_demand

				FROM calculations
					INNER JOIN calculation_summed_deposition_results_view USING (calculation_id)
			) AS proposed_demands USING (proposed_calculation_id, receptor_id)
		LEFT JOIN
			(SELECT
				calculation_id AS current_calculation_id,
				receptor_id,
				GREATEST(deposition, 0) AS current_demand

				FROM calculations
					INNER JOIN calculation_summed_deposition_results_view USING (calculation_id)
			) AS current_demands USING (current_calculation_id, receptor_id)
;
