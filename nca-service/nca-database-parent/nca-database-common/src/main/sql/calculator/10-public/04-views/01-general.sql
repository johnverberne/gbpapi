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
