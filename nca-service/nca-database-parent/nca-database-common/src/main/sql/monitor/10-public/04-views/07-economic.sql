/*
 * deposition_spaces_divided_view
 * ------------------------------
 * Retourneert de depositie ruimte per segment voor de receptoren waarbij de KDW na realisatie van de behoefte dreigt overschreden te worden (KDW - 70 mol).
 *
 * @todo renamen view? uit de naam is niet af te leiden dat het om een subset van de relevante receptoren gaat...
 */
CREATE OR REPLACE VIEW deposition_spaces_divided_view AS
SELECT
	year,
	receptor_id,
	no_permit_required,
	permit_threshold,
	priority_projects,
	projects

	FROM deposition_spaces_divided
		INNER JOIN relevant_development_space_exceeding_receptors_view USING (year, receptor_id)
;


/*
 * deposition_spaces_view
 * ----------------------
 * Retourneert de totale depositie ruimte voor de receptoren waarbij de KDW na realisatie van de behoefte dreigt overschreden te worden (KDW - 70 mol).
 *
 * @todo renamen view? uit de naam is niet af te leiden dat het om een subset van de relevante receptoren gaat...
 */
CREATE OR REPLACE VIEW deposition_spaces_view AS
SELECT
	year,
	receptor_id,
	no_permit_required +
		permit_threshold +
		priority_projects +
		projects AS total_space

	FROM deposition_spaces_divided_view
;


/*
 * deposition_spaces_export_view
 * -----------------------------
 * Retourneert de totale depositie ruimte voor alle receptoren.
 */
CREATE OR REPLACE VIEW deposition_spaces_export_view AS
SELECT
	year,
	receptor_id,
	no_permit_required +
		permit_threshold +
		priority_projects +
		projects AS total_space

	FROM deposition_spaces_divided
;


/*
 * assessment_area_sector_economic_desires_view
 * --------------------------------------------
 * Retourneert het gewogen gemiddelde aan ontwikkelingsbehoefte voor een natuurgebied per sector.
 * Dit gewogen gemiddelde geldt voor receptoren waar een HT ligt met KDW < 2400.
 */
CREATE OR REPLACE VIEW assessment_area_sector_economic_desires_view AS
SELECT
	year,
	sector_id,
	assessment_area_id,
	ae_weighted_avg(priority_projects_desire::numeric, weight::numeric)::real AS priority_projects_desire,
	ae_weighted_avg(other_desire::numeric, weight::numeric)::real AS other_desire

	FROM receptors_to_assessment_areas_on_relevant_habitat_view
		INNER JOIN sector_economic_desires USING (receptor_id)
		INNER JOIN relevant_development_space_exceeding_receptors_view USING (year, receptor_id)

	GROUP BY year, sector_id, assessment_area_id
;
