/*
 * ae_development_rule_exceeding_space_check
 * -----------------------------------------
 * Functie om voor elke receptor binnen de situatie-berekening te bepalen
 * of door de toename van deze situatie een overschrijding van de ontwikkelingsruimte wordt veroorzaakt.
 */
CREATE OR REPLACE FUNCTION ae_development_rule_exceeding_space_check(v_proposed_calculation_id integer, v_current_calculation_id integer, v_segment segment_type, v_with_demand boolean = TRUE)
	RETURNS TABLE(receptor_id integer, rule development_rule_type, passed boolean) AS
$BODY$
	SELECT
		development_space_demands.receptor_id,
		'exceeding_space_check'::development_rule_type,

		ae_has_space(available.available_after_assigned, (CASE WHEN v_with_demand THEN development_space_demand ELSE 0 END)) AS passed

		FROM development_space_demands
			INNER JOIN available_development_spaces_view AS available USING (receptor_id)

		WHERE
			proposed_calculation_id = v_proposed_calculation_id
			AND current_calculation_id = COALESCE(v_current_calculation_id, 0)
			AND available.segment = v_segment
	;
$BODY$
LANGUAGE SQL STABLE;


/*
 * ae_development_rule_checks
 * --------------------------
 * Bepaal de uitkomsten van alle beleidsregels voor het opgegeven segment (bij toepassen van de opgegeven berekeningen).
 *
 * @param v_with_demand Of de demand meegenomen moet worden bij het bepalen van de overschrijdingen, of dat deze al in de OR opgenomen is.
 */
CREATE OR REPLACE FUNCTION ae_development_rule_checks(v_proposed_calculation_id integer, v_current_calculation_id integer, v_segment segment_type, v_with_demand boolean = TRUE)
	RETURNS TABLE(receptor_id integer, rule development_rule_type, passed boolean) AS
$BODY$
	SELECT * FROM ae_development_rule_exceeding_space_check(v_proposed_calculation_id, v_current_calculation_id, v_segment, v_with_demand);
$BODY$
LANGUAGE SQL STABLE;
