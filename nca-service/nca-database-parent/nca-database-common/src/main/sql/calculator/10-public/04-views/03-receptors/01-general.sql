/*
 * background_results_view
 * -----------------------
 * Totale (receptor) depositie en concentratie informatie op receptor niveau.
 *
 * Bevat op het moment alleen de depositie waardes zoals bepaalt in Monitor.
 * Zal alleen waardes bevatten voor receptoren die in een natuurgebied liggen.
 * Gebruik 'receptor_id' en 'year' in WHERE-clause.
 */
CREATE OR REPLACE VIEW background_results_view AS
SELECT
	receptor_id,
	year,
	1711::smallint AS substance_id,
	'deposition'::emission_result_type AS result_type,
	total_deposition AS result

	FROM depositions_jurisdiction_policies
;

/*
 * receptors_to_designated_critical_habitats_view
 * ----------------------------------------------
 * Voor elke receptor is een KDW als er habitat types aanwezig zijn die binnen een toetsgebied (assessment area) zijn aangewezen.
 * De laagste KDW van al deze habitat types zorgt voor de KDW van de receptor.
 * Om te achterhalen welke habitat type(s) de oorzaak waren voor de KDW kan deze view gebruikt worden.
 */
CREATE OR REPLACE VIEW receptors_to_designated_critical_habitats_view AS
SELECT
	receptor_id,
	assessment_area_id,
	critical_deposition_area_id AS habitat_type_id --TODO: keep critical_deposition_area_id?

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN critical_deposition_areas_view USING (assessment_area_id, type, critical_deposition_area_id)
		INNER JOIN critical_depositions USING (receptor_id)

	WHERE
		critical_deposition_areas_view.critical_deposition <= critical_depositions.critical_deposition
		AND type = 'relevant_habitat'
;
