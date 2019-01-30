/*
 * ae_deposition_factor_over_distance_decay
 * ----------------------------------------
 * Geeft de depositie factor voor de opgegeven afstand (meter) en stof.
 * De ondersteunde stoffen zijn: 11 (nox) en 17 (nh3).
 *
 * Meer informatie over de formules:
 * Afstand verval curven2.xlsx
 */
CREATE OR REPLACE FUNCTION ae_deposition_factor_over_distance_decay(distance double precision, substance_id smallint)
	RETURNS real AS
$BODY$
DECLARE
	deposition_factor real;
BEGIN
	CASE substance_id
		WHEN 11 THEN
			-- nox formule
			deposition_factor := 4.9483 * EXP(-0.587 *(distance/5000+1));
		WHEN 17 THEN
			-- nh3 formule
			deposition_factor := 42.283 * POW((distance/1000),-1.6245);
		ELSE
			RAISE EXCEPTION 'Unexpected substance_id %', substance_id;
	END CASE;

	RETURN deposition_factor;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;
