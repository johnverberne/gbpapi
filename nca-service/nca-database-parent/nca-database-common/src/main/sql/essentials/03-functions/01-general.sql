/*
 * ae_protect_table
 * ----------------
 * Simple trigger function to make a table readonly.
 * Useful for 'abstract base tables'.
 */
CREATE OR REPLACE FUNCTION ae_protect_table()
	RETURNS trigger AS
$BODY$
BEGIN
	RAISE EXCEPTION '%.% is a protected/readonly table!', TG_TABLE_SCHEMA, TG_TABLE_NAME;
END;
$BODY$
LANGUAGE plpgsql;


/*
 * ae_raise_notice
 * ---------------
 * Functie voor het tonen van report messages.
 * Gewrapped in een functie zodat deze aangeroepen kan worden vanuit SQL (buiten een functie).
 */
CREATE OR REPLACE FUNCTION ae_raise_notice(message text)
	RETURNS void AS
$BODY$
DECLARE
BEGIN
	RAISE NOTICE '%', message;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_linear_interpolate
 * ---------------------
 * Linear interpolatie functie.
 *
 * xb, yb = Begin punt
 * xe, ye = Eind punt
 * xi = x waarbij de bijbehorende y teruggegeven moet worden
 * Verwacht een float voor elke waarde en retourneert die ook.
 */
CREATE OR REPLACE FUNCTION ae_linear_interpolate(xb float, xe float, yb float, ye float, xi float)
	RETURNS float AS
$BODY$
DECLARE
BEGIN
	IF xe - xb = 0 THEN
		RETURN yb;
	ELSE
		RETURN yb + ( (xi - xb) / (xe - xb) ) * (ye - yb);
	END IF;

END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_linear_interpolate
 * ---------------------
 * Linear interpolatie functie.
 *
 * xb, yb = Begin punt
 * xe, ye = Eind punt
 * xi = x waarbij de bijbehorende y teruggegeven moet worden
 * Verwacht integer xb,xe,xi waardes en real yb,ye waardes.
 * Retourneert real waarde.
 */
CREATE OR REPLACE FUNCTION ae_linear_interpolate(xb integer, xe integer, yb real, ye real, xi integer)
	RETURNS real AS
$BODY$
DECLARE
BEGIN
	IF xe - xb = 0 THEN
		RETURN yb;
	ELSE
		RETURN yb + ( (xi - xb)::real / (xe - xb) ) * (ye - yb);
	END IF;

END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_array_index
 * --------------
 * Helper functie welke de index terug geeft (van de eerste match) van anyelement in anyarray.
 */
CREATE OR REPLACE FUNCTION ae_array_index(anyarray, anyelement)
	RETURNS INT AS 
$BODY$
	SELECT i
		FROM (SELECT generate_series(array_lower($1,1), array_upper($1,1))) g(i)

		WHERE $1[i] = $2

		LIMIT 1
$BODY$
LANGUAGE sql IMMUTABLE;