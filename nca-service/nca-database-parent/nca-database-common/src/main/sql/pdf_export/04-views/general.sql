/*
 * full_assessment_areas_pdf_export_view
 * -------------------------------------
 * Toont depositie statistieken voor een berekening (nieuwe situatie of uitbreiding), per natuurgebied.
 * Inclusief gebied-specifieke informatie als naam, grenswaarde en of het een PAS gebied is of niet.
 *
 * De aggregatie van de depositie resultaten verschilt per type gebied.
 * De receptoren die meegenomen moeten worden voor de statistieken worden bepaald in relevant_pdf_export_receptors_view.
 */
CREATE OR REPLACE VIEW full_assessment_areas_pdf_export_view AS
SELECT
	proposed_calculation_id,
	current_calculation_id,

	assessment_area_id,
	assessment_areas.name,
	assessment_areas.geometry,
	directive,
	pas_area,
	foreign_authority,
	country_id,
	countries.code AS country_code,
	countries.name AS country_name,

	receptor_id_for_max_delta,
	current_demand_for_max_delta,
	proposed_demand_for_max_delta,
	max_delta_demand,
	max_delta_demand_only_exceeding,
	max_background_deposition

	FROM
		(SELECT
			proposed_calculation_id,
			current_calculation_id,
			assessment_area_id,
			pas_area,

			(ae_max_with_key(receptor_id::numeric, delta_demand::numeric)).key AS receptor_id_for_max_delta,
			(ae_max_with_key(current_demand::numeric, delta_demand::numeric)).key AS current_demand_for_max_delta,
			(ae_max_with_key(proposed_demand::numeric, delta_demand::numeric)).key AS proposed_demand_for_max_delta,
			MAX(delta_demand) AS max_delta_demand,
			MAX(CASE WHEN exceeding THEN delta_demand ELSE NULL END) AS max_delta_demand_only_exceeding,
			MAX(total_deposition) AS max_background_deposition

			FROM development_space_demands_extended_view
				INNER JOIN pdf_export_receptors_to_assessment_areas USING (receptor_id)
				LEFT JOIN depositions_jurisdiction_policies USING (receptor_id, year)

			GROUP BY proposed_calculation_id, current_calculation_id, assessment_area_id, pas_area
		) AS stats

		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN authorities_view USING (authority_id)
		INNER JOIN countries USING (country_id)
		LEFT JOIN assessment_area_directive_view USING (assessment_area_id)
;



/*
 * full_habitats_pdf_export_view
 * -----------------------------
 * Toont depositie statistieken voor een berekening (nieuwe situatie of uitbreiding), per natuurgebied en per habitattype (alleen de relevante habitattypen en pasgebieden).
 * Inclusief habitat-specifieke informatie als naam en beschrijving van habitat type.
 * Niet-PAS-gebieden worden weggefilterd zodat deze ondanks "grenshexagonen" toch niet worden getoond.
 *
 * De aggregatie van de depositie resultaten verschilt per type gebied.
 * De receptoren die meegenomen moeten worden voor de statistieken worden bepaald in relevant_pdf_export_receptors_view.
 */
CREATE OR REPLACE VIEW full_habitats_pdf_export_view AS
SELECT
	proposed_calculation_id,
	current_calculation_id,

	assessment_area_id,
	pas_area,
	habitat_type_id,
	name,
	description,

	receptor_id_for_max_delta,
	current_demand_for_max_delta,
	proposed_demand_for_max_delta,
	max_delta_demand,
	max_delta_demand_only_exceeding

	FROM
		(SELECT
			proposed_calculation_id,
			current_calculation_id,
			assessment_area_id,
			pas_area,
			habitat_type_id,

			(ae_max_with_key(receptor_id::numeric, delta_demand::numeric)).key AS receptor_id_for_max_delta,
			(ae_max_with_key(current_demand::numeric, delta_demand::numeric)).key AS current_demand_for_max_delta,
			(ae_max_with_key(proposed_demand::numeric, delta_demand::numeric)).key AS proposed_demand_for_max_delta,
			MAX(delta_demand) AS max_delta_demand,
			MAX(CASE WHEN exceeding THEN delta_demand ELSE NULL END) AS max_delta_demand_only_exceeding

			FROM development_space_demands_extended_view
				INNER JOIN pdf_export_receptors_to_assessment_areas USING (receptor_id)
				INNER JOIN receptors_to_relevant_habitats_view  USING (receptor_id, assessment_area_id)

			WHERE pas_area IS TRUE -- Only pas areas

			GROUP BY proposed_calculation_id, current_calculation_id, assessment_area_id, pas_area, habitat_type_id
		) AS stats

	INNER JOIN habitat_types USING (habitat_type_id)
;


/*
 * exceeding_calculation_deposition_results_view
 * ---------------------------------------------
 * Retourneert de projectbijdrage per berekening en receptor waarvan de kritische depositiewaarde is overschreden.
 * Wordt gebruikt vanuit een WMS view.
 *
 * Gebruik 'calculation_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW exceeding_calculation_deposition_results_view AS
SELECT
	calculation_id,
	receptor_id,
	deposition

	FROM calculation_summed_deposition_results_view
		INNER JOIN exceeding_calculation_depositions_view USING (calculation_id, receptor_id)
;