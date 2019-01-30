/*
 * ae_test_land_use_classification_cast
 * ------------------------------------
 * Tests the land_use_classification enum
 */
CREATE OR REPLACE FUNCTION setup.ae_test_land_use_classification_cast()
	RETURNS void AS
$BODY$
DECLARE
	enum land_use_classification;
BEGIN
	--
	-- Test enum land_use_classification to integer cast
	--
	PERFORM setup.ae_assert_equals(
		1,
		('grasland'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		2,
		('bouwland'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		3,
		('vaste gewassen'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		4,
		('naaldbos'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		5,
		('loofbos'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		6,
		('water'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		7,
		('bebouwing'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		8,
		('overige natuur'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');

	PERFORM setup.ae_assert_equals(
		9,
		('kale grond'::land_use_classification)::integer,
		'Test enum land_use_classification to integer cast');
	--
	-- Test integer to enum land_use_classification cast
	--
	PERFORM setup.ae_assert_equals(
		'grasland'::land_use_classification,
		1::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'bouwland'::land_use_classification,
		2::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'vaste gewassen'::land_use_classification,
		3::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'naaldbos'::land_use_classification,
		4::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'loofbos'::land_use_classification,
		5::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'water'::land_use_classification,
		6::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'bebouwing'::land_use_classification,
		7::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'overige natuur'::land_use_classification,
		8::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_equals(
		'kale grond'::land_use_classification,
		9::land_use_classification,
		'Test integer to enum land_use_classification cast');

	PERFORM setup.ae_assert_null(
		0::land_use_classification,
		'There should not be a land use classification 0. The land use classification starts at 1.');

	PERFORM setup.ae_assert_null(
		10::land_use_classification,
		'There should not be a land use classification 10. The max land use classification is 9.');

	--
	-- Test if all enums are castable to an integer
	--
	FOR enum IN
		SELECT unnest(enum_range(null::land_use_classification))
	LOOP
		PERFORM setup.ae_assert_not_null(
			enum::integer,
			'enum ' || enum || ' should be castable to an integer.');
	END LOOP;

	--
	-- Test count
	--
	PERFORM setup.ae_assert_equals(
		9,
		(SELECT count(*)::integer FROM unnest(enum_range(null::land_use_classification))),
		'There should be 9 land use classifications.');

	RETURN;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;