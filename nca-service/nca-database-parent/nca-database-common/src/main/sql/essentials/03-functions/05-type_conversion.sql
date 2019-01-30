/*
 * ae_array_to_index
 * -----------------
 * Index (beginnend bij 1; standaard postgres) van het eerste element in wat anyarray gelijk is aan anyelement
 * of NULL indien anyelement niet voor komt.
 */
CREATE OR REPLACE FUNCTION ae_array_to_index(anyarray anyarray, anyelement anyelement)
	RETURNS integer AS
$BODY$
	SELECT index
		FROM generate_subscripts($1, 1) AS index
		WHERE $1[index] = $2
		ORDER BY index
$BODY$
LANGUAGE sql IMMUTABLE;


/*
 * ae_enum_to_index
 * ----------------
 * Index (beginnend bij 1; standaard postgres) van anyenum in de type definitie van zijn enum type.
 */
CREATE OR REPLACE FUNCTION ae_enum_to_index(anyenum anyenum)
	RETURNS integer AS
$BODY$
	SELECT ae_array_to_index(enum_range($1), $1);
$BODY$
LANGUAGE sql IMMUTABLE;


/*
 * ae_enum_by_index
 * ----------------
 * Anyenum op positie index (beginnend bij 1; standaard postgres) in de type definitie van het enum type anyenum.
 * of NULL indien index ongeldig is.
 */
CREATE OR REPLACE FUNCTION ae_enum_by_index(anyenum anyenum, index integer)
	RETURNS anyenum AS
$BODY$
	SELECT (enum_range($1))[$2];
$BODY$
LANGUAGE sql IMMUTABLE;
