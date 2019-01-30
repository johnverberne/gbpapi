/*
 * ae_id_to_capital_letter
 * -----------------------
 * Functie voor omzetten van een ID naar een hoofdletter.
 * Bij ID > 26 wordt er gebruik gemaakt van meerdere hoofdletters.
 */
CREATE OR REPLACE FUNCTION ae_id_to_capital_letter(id integer)
	RETURNS text AS
$BODY$
DECLARE
	return_value text;
	letters_in_alphabet integer = 26;
	start_capital_letter integer = 65;
BEGIN
	return_value := chr(start_capital_letter + (id - 1) % letters_in_alphabet);
	IF (id - 1) / letters_in_alphabet > 0 THEN
		return_value := ae_id_to_capital_letter((id - 1) / letters_in_alphabet) || return_value;
	END IF;
	RETURN return_value;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;