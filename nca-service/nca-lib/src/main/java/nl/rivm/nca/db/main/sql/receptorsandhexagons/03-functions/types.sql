/*
 * ae_get_natura2000_directive_type
 * --------------------------------
 * Convert a N2000 area directive into a single enum.
 */
CREATE OR REPLACE FUNCTION ae_get_natura2000_directive_type(bird_directive boolean, habitat_directive boolean)
	RETURNS natura2000_directive_type AS
$BODY$
BEGIN
	CASE
		WHEN (bird_directive = TRUE AND habitat_directive = TRUE) THEN RETURN 'VR+HR'::natura2000_directive_type;
		WHEN (bird_directive = TRUE) THEN RETURN 'VR'::natura2000_directive_type;
		WHEN (habitat_directive = TRUE) THEN RETURN 'HR'::natura2000_directive_type;
		ELSE RETURN NULL;
	END CASE;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_integer_to_land_use_classification
 * -------------------------------------
 * Cast functie voor integer naar land_use_classification
 */
CREATE OR REPLACE FUNCTION ae_integer_to_land_use_classification(anyint integer)
	RETURNS land_use_classification AS
$BODY$
	SELECT ae_enum_by_index(null::land_use_classification, $1);
$BODY$
LANGUAGE sql IMMUTABLE;


/*
 * ae_critical_deposition_classification
 * -------------------------------------
 * Op basis van KDW (Kritische Depositie Waarde) geeft deze functie de gevoeligheids-classificatie terug.
 * Huidige klassering:
 * - zeer gevoelig: < 1400
 * - gevoelig: 1400 =< KDW < 2400
 * - minder/niet gevoelig: >= 2400
 */
CREATE OR REPLACE FUNCTION ae_critical_deposition_classification(critical_deposition posreal)
	RETURNS text AS
$BODY$
DECLARE
	result critical_deposition_classification;
BEGIN
	IF (critical_deposition < 1400) THEN
		result = 'high_sensitivity';
	ELSIF (critical_deposition >= 2400) THEN
		result = 'low_sensitivity';
	ELSE
		result = 'normal_sensitivity';
	END IF;

	RETURN result::text;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;