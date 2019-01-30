/*
 * ae_geometry_typmod_in
 * ---------------------
 * Override functie voor geometry_typmod_in (de type modificator functie van de TYPE geometry).
 * Deze functie zal, in tegenstelling tot de default functie, indien er geen SRID opgegeven is bij het definieren van de geometry TYPE,
 * de opgegeven default SRID wegschrijven ipv SRID 0.
 * De opgegeven default SRID is gedefinieerd in de constanten tabel.
 */
CREATE OR REPLACE FUNCTION ae_geometry_typmod_in(v_args cstring[])
  RETURNS integer AS
$BODY$
DECLARE
	v_argscopy text[];
BEGIN
	-- Work with a text[] copy, because altering the cstring[] and forwarding it to the C function fails in newer PostgreSQL versions.
	v_argscopy := v_args;

	-- Check if srid is set
	IF (v_argscopy[2] IS NULL) THEN
		v_argscopy[2] := ae_get_srid()::text;
	END IF;

	RETURN geometry_typmod_in(v_argscopy::cstring[]);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

/*
 * Vervang de default geometry_typmod_in functie door ae_geometry_typmod_in
 */
UPDATE pg_catalog.pg_type
	SET typmodin = 'ae_geometry_typmod_in'::regproc
	WHERE typmodin = 'geometry_typmod_in'::regproc
;
