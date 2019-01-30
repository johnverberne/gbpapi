/*
 * ae_perform_and_report_validation
 * --------------------------------
 * Voer een validatietest uit en logt deze informatie in de validation tabellen.
 */
CREATE OR REPLACE FUNCTION setup.ae_perform_and_report_validation(function_name regproc, params text = NULL)
	 RETURNS void AS
$BODY$
DECLARE
	rec record;
	validation_result setup.validation_result_type = 'success';
BEGIN
	FOR rec IN
		EXECUTE 'SELECT result, object, message FROM ' || function_name || '(' || COALESCE(params, '') || ')'
	LOOP
		validation_result := GREATEST(validation_result, rec.result);
		INSERT INTO setup.validation_logs(validation_run_id, name, result, object, message)
			VALUES(setup.ae_current_validation_run_id(), function_name, rec.result, rec.object, rec.message);
	END LOOP;
	INSERT INTO setup.validation_results(validation_run_id, name, result)
		VALUES(setup.ae_current_validation_run_id(), function_name, validation_result);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_perform_and_report_test
 * --------------------------
 * Voer een unittest uit en logt deze informatie in de validation tabellen.
 */
CREATE OR REPLACE FUNCTION setup.ae_perform_and_report_test(function_name regproc, params text = NULL)
	 RETURNS void AS
$BODY$
DECLARE
	rec record;
	validation_result setup.validation_result_type = 'success';
BEGIN
	BEGIN
		EXECUTE 'SELECT ' || function_name || '(' || COALESCE(params, '') || ')';
	EXCEPTION WHEN OTHERS THEN
		validation_result := 'error';
		INSERT INTO setup.validation_logs(validation_run_id, name, result, object, message)
			VALUES(setup.ae_current_validation_run_id(), function_name, validation_result, NULL::text, SQLERRM);
	END;
	INSERT INTO setup.validation_results(validation_run_id, name, result)
		VALUES(setup.ae_current_validation_run_id(), function_name, validation_result);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_to_validation_result
 * -----------------------
 * Transformeert de losse validation results variabelen naar een validation result type.
 */
CREATE OR REPLACE FUNCTION setup.ae_to_validation_result(v_result setup.validation_result_type, v_object text, v_message text)
	 RETURNS setup.validation_result AS
$BODY$
BEGIN
	RETURN (v_result, v_object, v_message);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_to_validation_result
 * -----------------------
 * Transformeert de losse validation results variabelen naar een validation result type.
 */
CREATE OR REPLACE FUNCTION setup.ae_to_validation_result(v_result setup.validation_result_type, v_object regclass, v_message text)
	 RETURNS setup.validation_result AS
$BODY$
BEGIN
	RETURN (v_result, v_object::text, v_message);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_current_validation_run_id
 * ----------------------------
 * Bepaald de huidige validation_run_id of maakt een nieuwe validation_run aan indien deze nog niet bestaat.
 */
CREATE OR REPLACE FUNCTION setup.ae_current_validation_run_id()
	 RETURNS integer AS
$BODY$
DECLARE
	v_validation_run_id integer;
BEGIN
	v_validation_run_id := (
		SELECT validation_run_id
			FROM setup.validation_runs
			WHERE transaction_id = txid_current()
	);

	IF v_validation_run_id IS NULL THEN
		INSERT INTO setup.validation_runs(transaction_id)
			SELECT txid_current()
			RETURNING validation_run_id INTO v_validation_run_id;
	END IF;

	RETURN v_validation_run_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_validate_tables_not_empty
 * ----------------------------
 * List tables that are empty; exception for those that shouldn't be.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_tables_not_empty()
	 RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	rec_in_table record;
BEGIN
	RAISE NOTICE '* Listing empty tables...';

	-- TODO: Give NOTICE for expected empty tables, EXCEPTION for unexpected.
	--		 A list needs to be compiled of the expected tables. Do so near release. Supply by parameter.

	FOR rec IN
		SELECT (table_schema || '.' || table_name)::regclass AS tablename
			FROM information_schema.tables
		WHERE table_type = 'BASE TABLE' AND table_schema NOT IN ('pg_catalog', 'information_schema')
		ORDER BY table_schema, table_name
	LOOP
		EXECUTE 'SELECT 1 FROM ' || rec.tablename || ' LIMIT 1' INTO rec_in_table;
		IF rec_in_table IS NULL THEN
			RETURN NEXT setup.ae_to_validation_result('hint', rec.tablename, 'Table is empty');
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_incorrect_imports
 * -----------------------------
 * Retourneert alle tabellen met een string \N als veld waarde.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_incorrect_imports()
	 RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	num_records integer;
BEGIN
	-->> Text fields containing the string \N indicate that NULL values were incorrectly imported
	RAISE NOTICE '* Searching for incorrect COPY FROM imports: NULL values...';
	FOR rec IN
		SELECT (table_schema || '.' || table_name)::regclass AS tablename, column_name
		FROM information_schema.columns
		WHERE is_updatable = 'YES' AND table_schema NOT IN ('pg_catalog', 'information_schema') AND (data_type = 'text' OR data_type = 'character' OR data_type = 'character varying')
		ORDER BY table_schema, table_name, ordinal_position
	LOOP
		EXECUTE 'SELECT COUNT(*) FROM ' || rec.tablename || ' WHERE "' || rec.column_name || E'" = E''\\\\N''' INTO num_records;
		IF num_records > 0 THEN
			RETURN NEXT setup.ae_to_validation_result('error', rec.tablename,
				format(E'Column "%s" has %s records containing \\N', rec.column_name, num_records));
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_get_completeness_sql
 * --------------------------------
 * Genereert een algemene SQL om completeness (volledigheid) validatie op een tabel te kunnen doen.
 * @param v_validate_table De tabel welke gecontroleerd moet worden.
 * @param v_key_tables De tabellen waarnaar verwezen wordt in de pkey van de validatietabel (middels fkeys); alle mogelijke key combinaties (evt. gefilterd) zullen moeten voorkomen.
 * @param v_where_filter Optioneel filter op de key combinaties van de key-tabellen. Schrijf als de inhoud van een WHERE-clause.
 * @param v_key_columns De pkey kolommen van de v_key_tables waarop gegroepeerd wordt. Standaard bepaalt de functie deze zelf, dus deze hoeft alleen opgegeven te worden in geval
 * van afwijkingen van de standaard keys.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_get_completeness_sql(v_validate_table regclass, v_key_tables text, v_where_filter text = NULL, v_key_columns text = NULL)
	RETURNS text AS
$BODY$
DECLARE
	key_tables_array text[];
	key_column_array text[];
	key_column_list text;
BEGIN
	key_tables_array := (SELECT array_agg(TRIM(key_table)) FROM unnest(string_to_array(v_key_tables, ',')) AS key_table);

	-- Determine key columns to join and group on. By default these are the merged primary keys of the v_key_tables.
	IF v_key_columns IS NULL THEN
		key_column_array := (
			SELECT array_agg(attname) FROM (
				SELECT pg_attribute.attname
					FROM pg_index
						INNER JOIN pg_class ON (pg_index.indrelid = pg_class.oid)
						INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid AND pg_attribute.attnum = ANY(pg_index.indkey))
						INNER JOIN pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
					WHERE
						pg_index.indisprimary IS TRUE
						AND (pg_namespace.nspname || '.' || pg_class.relname)::regclass = ANY(key_tables_array::regclass[])
						AND attname <> 'year_category'

					ORDER BY ae_array_to_index(key_tables_array::regclass[], (pg_namespace.nspname || '.' || pg_class.relname)::regclass) -- User ordering
				) AS columns
		);
	ELSE
		key_column_array := (SELECT array_agg(TRIM(key_column)) FROM unnest(string_to_array(v_key_columns, ',')) AS key_column);
	END IF;
	key_column_list := array_to_string(key_column_array, ', ');


	RETURN $$
		SELECT
			$$ || key_column_list || $$

			FROM $$ || array_to_string(key_tables_array, ' CROSS JOIN ') || $$
				LEFT JOIN (SELECT DISTINCT $$ || key_column_list || $$ FROM $$ || v_validate_table || $$) AS target_table USING ($$ || key_column_list || $$)

			WHERE ($$ || COALESCE(v_where_filter, 'TRUE') || $$)
			AND target_table.$$ || key_column_array[1] || $$ IS NULL

			GROUP BY $$ || key_column_list || $$

			ORDER BY $$ || key_column_list || $$
	$$;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_completeness_receptors
 * ----------------------------------
 * Valideert of het aantal receptoren per keycombinatie overeen komt met het totaal aantal receptoren, dus of een receptordata tabel compleet is.
 * Er wordt gegroepeerd op iedere key behalve receptor_id, vervolgens wordt per groep het aantal receptor_id's geteld. Dit moet overeenkomen met het
 * aantal in de 'receptors' tabel.
 * Let op dat lege tabellen niet worden gedetecteerd.
 *
 * @param v_validate_table De tabel welke gecontroleerd moet worden.
 * @param v_use_only_calculated_receptors Standaard wordt gecontroleerd op het aantal receptoren in receptors. Voor sommige tabellen kan beter gekeken worden naar de
 * receptoren die niet in de uncalculated_recepors staan. Dat kan mbv deze parameter.
 * @param v_use_only_included_receptors Standaard wordt gecontroleerd op het aantal receptoren in receptors. Voor sommige tabellen kan beter gekeken worden naar de
 * included_receptors tabel. Dat kan mbv deze parameter.
 * @param v_key_columns De pkey kolommen van de v_validate_table waarop gegroepeerd wordt. Standaard bepaalt de functie deze zelf, dus deze hoeft
 * alleen opgegeven te worden in geval van afwijkingen van de standaard keys.
 * @param v_where_filter Optioneel filter op de key combinaties van de tabel. Schrijf als de inhoud van een WHERE-clause.
 *
 * Opmerking: ae_validate_get_completeness_sql() werkt iets anders dan deze functie: die kijkt naar CROSS JOINs van tabellen zoals year en sectors en
 * checkt dan voor iedere combinatie of er data voor is.
 * Deze functie daarintegen kijkt voor alle receptoren of ze data hebben in specifieke tabellen, door te kijken naar alle combinaties van de primary key
 * kolommen (behalve receptor_id). Het vindt NIET de situatie dat een specifieke combinatie helemaal niet voorkomt.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_completeness_receptors(v_validate_table regclass, v_use_only_calculated_receptors boolean = FALSE, v_use_only_included_receptors boolean = FALSE, v_key_columns text = NULL, v_where_filter text = NULL)
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	key_column_array text[];
	key_column_list text;
	v_expected_num_receptors integer;
	rec record;
BEGIN
	-- Determine key columns to join and group on. By default these are the merged primary keys of the v_key_tables.
	IF v_key_columns IS NULL THEN
		key_column_array := (
			SELECT array_agg(attname) FROM (
				SELECT pg_attribute.attname
					FROM pg_index
						INNER JOIN pg_class ON (pg_index.indrelid = pg_class.oid)
						INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid AND pg_attribute.attnum = ANY(pg_index.indkey))
						INNER JOIN pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
					WHERE
						pg_index.indisprimary IS TRUE
						AND (pg_namespace.nspname || '.' || pg_class.relname)::regclass = v_validate_table
				) AS columns
				WHERE lower(attname) <> 'receptor_id'
		);
	ELSE
		key_column_array := (SELECT array_agg(TRIM(key_column)) FROM unnest(string_to_array(v_key_columns, ',')) AS key_column);
	END IF;
	key_column_list := COALESCE(array_to_string(key_column_array, ', '), '1');

	v_expected_num_receptors := (SELECT COUNT(receptor_id)
									FROM receptors
										LEFT JOIN included_receptors USING (receptor_id)
										LEFT JOIN setup.uncalculated_receptors USING (receptor_id)
									WHERE
										(v_use_only_calculated_receptors IS FALSE OR uncalculated_receptors.receptor_id IS NULL)
										AND (v_use_only_included_receptors IS FALSE OR included_receptors.receptor_id IS NOT NULL));

	FOR rec IN EXECUTE $$
	SELECT
		ARRAY[$$ || key_column_list || $$]::text[] AS key_values,
		COUNT(receptor_id) AS num_receptors

		FROM $$ || v_validate_table || $$

		WHERE ($$ || COALESCE(v_where_filter, 'TRUE') || $$)

		GROUP BY $$ || key_column_list || $$
		HAVING COUNT(receptor_id) <> $$ || v_expected_num_receptors || $$

		ORDER BY $$ || key_column_list || $$
	$$ LOOP
		RETURN NEXT setup.ae_to_validation_result('error', v_validate_table,
			format('Incorrect receptor count for keys (%s)=%s; found %s, expected %s', key_column_list, rec.key_values, rec.num_receptors, v_expected_num_receptors));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_year_set
 * --------------------
 * Valideert de jaren in een tabel tegen een gegeven set. De tabel mag niet meer en niet minder jaren bevatten dan de set.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_year_set(v_table_name regclass, v_allowed_year_set smallint[])
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	table_year_set smallint[];
BEGIN
	RAISE NOTICE '* Validating years in table %...', v_table_name;

	/*
	 * Distinct apparantly doesn't benefit that much from an index.
	 * This recursive selection works (if year is present in index) if the expected set of distinct values is relatively small compared to the number of rows.
	 * So does kinda depend on year being in an index, but performance gain is quite substantial (126424 ms -> 203 ms in a test).
	 */
	EXECUTE $$
		WITH RECURSIVE t(n) AS (
			SELECT MIN(year) FROM $$ || v_table_name || $$
			UNION
			SELECT (SELECT year FROM $$ || v_table_name || $$ WHERE year > n ORDER BY year LIMIT 1)
				FROM t WHERE n IS NOT NULL
		)
		SELECT array_agg(n::smallint) FROM t WHERE n IS NOT NULL $$ INTO table_year_set;

	IF EXISTS (SELECT unnest(v_allowed_year_set) EXCEPT SELECT unnest(table_year_set)) THEN
		RETURN NEXT setup.ae_to_validation_result('error', v_table_name,
			format('Table does not have enough years; missing years = %s',
				(SELECT array_agg(y) FROM (SELECT unnest(v_allowed_year_set) AS y EXCEPT SELECT unnest(table_year_set) AS y) AS missing_years)));
	END IF;

	IF EXISTS (SELECT unnest(table_year_set) EXCEPT SELECT unnest(v_allowed_year_set)) THEN
		RETURN NEXT setup.ae_to_validation_result('error', v_table_name,
			format('Table has too many years; invalid years = %s',
				(SELECT array_agg(y) FROM (SELECT unnest(table_year_set) AS y EXCEPT SELECT unnest(v_allowed_year_set) AS y) AS invalid_years)));
	END IF;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_declining_over_years
 * --------------------------------
 * Valideert of waarden in een tabel met jaren, gelijk blijven of lager worden naarmate het jaar verder in de toekomst ligt.
 * @param v_validate_table Tabel om te valideren
 * @param v_validate_field Dataveld om te valideren. Standaard bepaalt de functie deze zelf en is dit het eerst niet-pkey veld.
 * @param v_key_columns Velden om op te groeperen. Standaard bepaalt de functie deze zelf en is dit de pkey van v_validate_table min 'year'.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_declining_over_years(v_validate_table regclass, v_validate_field text = NULL, v_key_columns text = NULL)
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	key_tables_array text[];
	key_column_array text[];
	key_column_list text;
	validate_field text;
	prev_keys text[];
	curr_keys text[];
	prev_year year_type;
	curr_year year_type;
	prev_value numeric;
	curr_value numeric;
BEGIN
	-- Determine key columns to check on. By default this is the primary key of the v_validate_table minus 'year'.
	IF v_key_columns IS NULL THEN
		key_column_array := (
			SELECT array_agg(attname) FROM (
				SELECT pg_attribute.attname
					FROM pg_index
						INNER JOIN pg_class ON (pg_index.indrelid = pg_class.oid)
						INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid AND pg_attribute.attnum = ANY(pg_index.indkey))
						INNER JOIN pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
					WHERE
						pg_index.indisprimary IS TRUE
						AND (pg_namespace.nspname || '.' || pg_class.relname)::regclass = v_validate_table
						AND pg_attribute.attname <> 'year'
					ORDER BY pg_attribute.attnum
				) AS columns
		);
	ELSE
		key_column_array := (SELECT array_agg(TRIM(key_column)) FROM unnest(string_to_array(v_key_columns, ',')) AS key_column);
	END IF;
	key_column_list := array_to_string(key_column_array, ', ');

	-- Determine field to validate on, by default the first field not in key_column_array
	IF v_validate_field IS NULL THEN
		validate_field := (
			SELECT pg_attribute.attname
				FROM pg_class
					INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid)
					INNER JOIN pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
				WHERE
					pg_attribute.attnum > 0
					AND (pg_namespace.nspname || '.' || pg_class.relname)::regclass = v_validate_table
					AND NOT pg_attribute.attname = ANY(key_column_array)
					AND NOT pg_attribute.attname = 'year'
				ORDER BY pg_attribute.attnum
				LIMIT 1
		);
	ELSE
		validate_field := v_validate_field;
	END IF;

	prev_keys := NULL;
	prev_year := NULL;
	prev_value := NULL;

	-- Do ordered loop and ensure decreasing values
	FOR curr_keys, curr_year, curr_value IN EXECUTE $$
	SELECT
		ARRAY[$$ || key_column_list || $$]::text[],
		year,
		$$ || validate_field || $$

		FROM $$ || v_validate_table || $$

		ORDER BY $$ || key_column_list || $$, year ASC
	$$ LOOP
		IF (curr_keys = prev_keys) AND (curr_year > prev_year) AND (curr_value > prev_value) THEN
			RETURN NEXT setup.ae_to_validation_result('error', v_validate_table,
				format('Non-declining ''%s'' for (%s)=%s, from year %s to year %s: %s -> %s', validate_field, key_column_list, curr_keys, prev_year, curr_year, prev_value, curr_value));
		END IF;
		prev_keys := curr_keys;
		prev_year := curr_year;
		prev_value := curr_value;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
