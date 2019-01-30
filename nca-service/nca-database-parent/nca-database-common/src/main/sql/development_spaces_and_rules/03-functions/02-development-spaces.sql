/*
 * ae_has_space
 * ------------
 * Retourneert TRUE indien space groter of gelijk is aan de development_space_demand (waarden worden vergeleken tot op 3 decimalen).
 */
CREATE OR REPLACE FUNCTION ae_has_space(v_space real, v_demand real)
	RETURNS boolean AS
$BODY$
	SELECT ROUND(v_space::numeric - v_demand::numeric, 3) >= 0;
$BODY$
LANGUAGE sql IMMUTABLE;


/*
 * ae_to_valid_space
 * -----------------
 * Retourneert de juiste space op basis van input.
 * In het geval de waarde negatief is, wordt een exceptie gegooit (geen geldige space waarde).
 * Is de waarde negatief, maar afgerond op 3 decimalen gelijk aan 0, dan wordt 0 teruggegeven (voorkomen afrondingsfouten).
 */
CREATE OR REPLACE FUNCTION ae_to_valid_space(v_space real, v_demand real, v_action development_space_action_type)
	RETURNS posreal AS
$BODY$
DECLARE
	new_space real;
BEGIN
	new_space := v_space + v_demand * v_action::integer;
	IF new_space > 0 THEN
		RETURN new_space;
	ELSIF ROUND(v_space::numeric - v_demand::numeric, 3) >= 0 THEN
		RETURN 0;
	ELSE
		RAISE EXCEPTION 'Can not end up with a negative space';
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_adjust_development_space
 * ---------------------------
 * Een OR-aanvraag kan zich in verschillende statussen bevinden. Per OR-aanvraag-status wordt het totaal (van alle aanvragen in deze status) bijgehouden.
 * Via deze functie kan het totaal bijgewerkt worden. De OR van een aanvraag kan zowel bij het totaal opgeteld als aftrokken worden.
 *
 * @param v_action Of bij de OR wordt opgeteld of afgetrokken
 * @param v_segment Welk segment moet worden aangepast
 * @param v_status Welke OR-status moet worden aangepast
 * @param v_proposed_calculation_id Id van de berekening met de nieuwe situatie
 * @param v_current_calculation_id Id van de berekening met de huidige situatie (mag NULL zijn)
 */
CREATE OR REPLACE FUNCTION ae_adjust_development_space(v_action development_space_action_type, v_segment segment_type, v_status development_space_state, v_proposed_calculation_id integer, v_current_calculation_id integer)
	RETURNS void AS
$BODY$
BEGIN
	LOCK TABLE development_spaces IN EXCLUSIVE MODE; -- Only one transaction/connection at a time.

	UPDATE development_spaces
		SET space = ae_to_valid_space(space, development_space_demand, v_action)

		FROM development_space_demands

		WHERE
			segment = v_segment
			AND status = v_status
			AND development_spaces.receptor_id = development_space_demands.receptor_id
			AND proposed_calculation_id = v_proposed_calculation_id
			AND current_calculation_id = COALESCE(v_current_calculation_id, 0)
	;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
