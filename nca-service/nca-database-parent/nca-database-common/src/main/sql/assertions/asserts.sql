/*
 * ae_assert_equals
 * ----------------
 * Assertion functie: gooit een exception indien de twee elementen (expected & actual) niet gelijk zijn aan elkaar.
 *
 * Expected en actual moeten van hetzelfde data type zijn.
 */
CREATE OR REPLACE FUNCTION setup.ae_assert_equals(expected anyelement, actual anyelement, message text)
	RETURNS void AS
$BODY$
DECLARE
BEGIN
	IF actual != expected THEN
		RAISE EXCEPTION 'ae_assert_equals failed: %', message;
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_assert_not_equals
 * --------------------
 * Assertion functie: gooit een exception indien de twee elementen (expected & actual) gelijk zijn aan elkaar.
 *
 * Expected en actual moeten van hetzelfde data type zijn.
 */
CREATE OR REPLACE FUNCTION setup.ae_assert_not_equals(expected anyelement, actual anyelement, message text)
	RETURNS void AS
$BODY$
DECLARE
BEGIN
	IF actual = expected THEN
		RAISE EXCEPTION 'ae_assert_not_equals failed: %', message;
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_assert_true
 * --------------
 * Assertion functie: gooit een exception indien condition gelijk is aan false of null.
 */
CREATE OR REPLACE FUNCTION setup.ae_assert_true(condition boolean, message text)
	RETURNS void AS
$BODY$
DECLARE
BEGIN
	IF condition != TRUE THEN
		RAISE EXCEPTION 'ae_assert_true failed: %', message;
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_assert_false
 * ---------------
 * Assertion functie: gooit een exception indien condition gelijk is aan true of null.
 */
CREATE OR REPLACE FUNCTION setup.ae_assert_false(condition boolean, message text)
	RETURNS void AS
$BODY$
DECLARE
BEGIN
	IF condition != FALSE THEN
		RAISE EXCEPTION 'ae_assert_false failed: %', message;
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_assert_not_null
 * ------------------
 * Assertion functie: gooit een exception indien anyelement null is.
 */
CREATE OR REPLACE FUNCTION setup.ae_assert_not_null(anyelement anyelement, message text = null)
	RETURNS void AS
$BODY$
DECLARE
BEGIN
	IF anyelement IS NULL THEN
		RAISE EXCEPTION 'ae_assert_not_null failed: %', message;
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_assert_null
 * --------------
 * Assertion functie: gooit een exception indien anyelement ongelijk aan null is.
 */
CREATE OR REPLACE FUNCTION setup.ae_assert_null(anyelement anyelement, message text = null)
	RETURNS void AS
$BODY$
DECLARE
BEGIN
	IF anyelement IS NOT NULL THEN
		RAISE EXCEPTION 'ae_assert_null failed: %', message;
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;