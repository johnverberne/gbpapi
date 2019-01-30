/*
 * ae_get_duration
 * ---------------
 * Deze functie retourneert op basis van een interger de duration.
 * De duration ligt tussen de 1 en de 6 (max_duration). Dit aangezien een pas-periode 6 jaar duurt.
 * Indien de duration buiten het bereik ligt zal max_duration terug gegeven worden.
 *
 * Optioneel kan opgeveven worden of de functie max_duration terug moet geven indien de opgegeven integer NULL is.
 */
CREATE OR REPLACE FUNCTION setup.ae_get_duration(v_duration integer, v_max_duration_if_null boolean = TRUE)
	RETURNS integer AS
$BODY$
DECLARE
	v_max_duration integer = 6;
BEGIN
	-- Check if duration is valid
	IF ((v_duration IS NULL AND v_max_duration_if_null)
			OR (v_duration IS NOT NULL AND v_duration NOT BETWEEN 1 AND v_max_duration))
	THEN
		-- Change (invalid) duration
		v_duration = v_max_duration;

	END IF;
	
	RETURN v_duration;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_get_basename
 * ---------------
 * Deze functie retourneert op basis van een filename de basename.
 * Optioneel kan opgeveven worden of de basename met extensie (TRUE; default) of zonder extensie (FALSE) geretourneerd moet worden.
 */
CREATE OR REPLACE FUNCTION setup.ae_get_basename(v_filename text, v_with_extention boolean = TRUE)
	RETURNS text AS
$BODY$
DECLARE
	v_basename text;
BEGIN
	v_basename := reverse(split_part(reverse(v_filename), E'\\', 1));

	IF v_with_extention IS FALSE THEN
		v_basename := left(v_basename, length(v_basename) - strpos(reverse(v_basename), '.'));
	END IF;

	RETURN v_basename;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_string_to_key_values
 * -----------------------
 * Deze functie retourneert op basis van een string de key-value-paren.
 * '-' scheidingsteken tussen key en value en karakter ipv spatie in de value. Dit karakter mag niet in de key voorkomen. De waarde na de eerste - is dus de value.
 * '_' scheiding tussen key-value paren dit karakter mag niet voorkomen in de keys en values.
 */
CREATE OR REPLACE FUNCTION setup.ae_string_to_key_values(v_string text)
	RETURNS TABLE(key text, value text) AS
$BODY$
DECLARE
	v_pair_delimiter text = '_';
	v_key_value_delimiter text = '-';
	v_basename text;
	v_current_pair text[];
	v_array_length integer;
BEGIN
	-- For all key-value-pairs
	FOR v_current_pair IN
		SELECT regexp_split_to_array(regexp_split_to_table(v_string, v_pair_delimiter), v_key_value_delimiter)
	LOOP
		v_array_length = array_length(v_current_pair, 1);
		-- Check if there is a key AND value
		IF (v_array_length > 1) THEN
			-- Return Key and Value
			RETURN QUERY
				(SELECT
					v_current_pair[1],
					array_to_string(v_current_pair[2:v_array_length], v_key_value_delimiter));
		END IF;

	END LOOP;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_string_to_value_by_key
 * -------------------------
 * Deze functie retourneert op basis van een string en een key de value
 * Zie ae_string_to_key_values voor meer informatie over de key-value separators.
 */
CREATE OR REPLACE FUNCTION setup.ae_string_to_value_by_key(v_string text, v_key text)
	RETURNS text AS
$BODY$
DECLARE
BEGIN
	RETURN (SELECT value FROM setup.ae_string_to_key_values(v_string) WHERE key = v_key);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_get_calculation_batch_results
 * --------------------------------
 * Retourneert de resultaten van de opgegeven calculation-ids of alle id's in de database indien deze niet is opgegeven.
 * De waarden voor de sector_id, gcn_sector_id, duration en scenario worden indien aanwezig uit de bestandsnaam (key-values) gehaald.
 * Indien de duration in de bestandsnaam is opgegeven zal deze verwerkt worden in de rekenresultaten.
 */
CREATE OR REPLACE FUNCTION setup.ae_get_calculation_batch_results(v_calculation_ids integer[] = NULL, v_duration integer = NULL)
	RETURNS TABLE(sector_id integer, gcn_sector_id integer, result_set_type_key integer, year year_type, substance_id smallint, result_type emission_result_type, duration integer, reference text, scenario text, receptor_id integer, result real) AS
$BODY$
DECLARE
BEGIN
	-- Check if v_calculation_ids is set
	IF (v_calculation_ids IS NULL) THEN
		v_calculation_ids := (SELECT array_agg(calculation_id) FROM calculations INNER JOIN calculation_batch_options USING (calculation_id));
	END IF;

	-- Add tmp_rename_input_files if not exists
	IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = 'tmp_rename_input_files') THEN
		CREATE TEMPORARY TABLE tmp_rename_input_files AS
			SELECT NULL::text AS input_file, NULL::text AS new_input_file LIMIT 0;
	END IF;

	-- Validate v_duration
	v_duration := setup.ae_get_duration(v_duration, FALSE);

	-- Collect the gcn-sector results
	RETURN QUERY
		(SELECT
			key_values.sector_id,
			key_values.gcn_sector_id,
			calculation_result_sets.result_set_type_key,
			calculations.year,
			calculation_result_sets.substance_id,
			calculation_result_sets.result_type,
			COALESCE(v_duration, key_values.duration) AS duration,
			key_values.reference,
			key_values.scenario,
			calculation_points.label::integer AS receptor_id,
			(MAX(calculation_point_results.result) * (setup.ae_get_duration(COALESCE(v_duration, key_values.duration)) / 6.0))::real AS result


			FROM (SELECT unnest(v_calculation_ids) AS calculation_id) AS calculation_ids
				INNER JOIN calculations USING (calculation_id)
				
				INNER JOIN
					(SELECT * 
						FROM calculation_result_sets 

						WHERE
							result_set_type = 'sector'
							AND calculation_result_sets.result_type IN ('concentration', 'deposition')
							
					) AS calculation_result_sets USING (calculation_id)

				INNER JOIN calculation_point_results USING (calculation_result_set_id)
				INNER JOIN calculation_points USING (calculation_point_set_id, calculation_point_id)
				INNER JOIN
					(SELECT
						calculation_id,
						setup.ae_string_to_value_by_key(basename, 'sector')::integer AS sector_id,
						setup.ae_string_to_value_by_key(basename, 'gcnsector')::integer AS gcn_sector_id,
						setup.ae_get_duration(setup.ae_string_to_value_by_key(basename, 'duration')::integer, FALSE) AS duration,
						setup.ae_string_to_value_by_key(basename, 'reference')::text AS reference,
						setup.ae_string_to_value_by_key(basename, 'scenario')::text AS scenario

						FROM
							(SELECT
								calculation_id,
								setup.ae_get_basename(split_part(COALESCE(new_input_file, input_file), ';', 1), FALSE) AS basename
								
								FROM calculation_batch_options
									LEFT JOIN tmp_rename_input_files USING (input_file)

							) AS basenames
							
					) AS key_values USING (calculation_id)

			WHERE state = 'completed'

			GROUP BY
				key_values.sector_id,
				key_values.gcn_sector_id,
				calculation_result_sets.result_set_type_key,
				calculations.year,
				calculation_result_sets.substance_id,
				calculation_result_sets.result_type,
				key_values.duration,
				key_values.reference,
				key_values.scenario,
				calculation_points.label
		);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_store_calculation_batch_results
 * ----------------------------------
 * Exporteert de resultaten van de opgegeven calculation-ids naar een result-bestand per result_type, result_set_type_key, year, gcn_sector_id, sector_id, reference, scenario en duration.
 * Deze key-values worden tevens opgenomen in de result-file-bestandsnaam.
 *
 * De key-values year, result_type, result_set_type_key zullen altijd in de bestandsnaam opgenomen worden en worden uit de data gehaald.
 * De key-values gcn_sector_id, sector_id, reference, scenario en duration worden indien aanwezig uit de source-filename overgenomen. 
 *
 * Formaat bestandsnaam: "reference-{reference}_scenario-{scenario}_resulttype-{resulttype}_resultsettkey-{resultsetkey}_year-{year}_gcnsector-{gcn_sector_id}_sector-{sector_id}_duration-{duration}_date-{date}.csv"
 *
 * Uitvoer is punt-komma gescheiden CSV met header.
 */
CREATE OR REPLACE FUNCTION setup.ae_store_calculation_batch_results(v_folder text, v_calculation_ids integer[])
	RETURNS TABLE(result_set_type_key integer, result_count integer, result_type emission_result_type, year year_type, substance_count integer, filename text) AS
$BODY$
DECLARE
	v_filespec text = '{folder}{prefix}resulttype-{resulttype}_resultsettkey-{resultsetkey}_year-{year}{suffix}_date-{date}.csv'; -- required key-values
	v_prefix text; -- string for optional suffix key-values
	v_suffix text; -- string for optional prefix key-values
	v_current_filespec text;
	v_result_set_type_key integer;
	v_result_type emission_result_type;
	v_result_count integer;
	v_substance_count integer;
	v_year year_type;
	v_reference text;
	v_scenario text;
	v_gcn_sector_id integer;
	v_sector_id integer;
	v_duration integer;
BEGIN
	RAISE NOTICE 'ae_store_calculation_batch_results [%] - start @ %', array_to_string(v_calculation_ids, ', '), timeofday();
	
	-- Collect the results
	CREATE TEMPORARY TABLE tmp_batch_results ON COMMIT DROP AS
		SELECT *
			FROM setup.ae_get_calculation_batch_results(v_calculation_ids);

	CREATE INDEX idx_tmp_batch_results ON tmp_batch_results (result_set_type_key, year, gcn_sector_id, sector_id, scenario, duration);

	-- For all result_set_type_key
	FOR v_result_set_type_key, v_year, v_gcn_sector_id, v_sector_id, v_reference, v_scenario, v_duration IN
		SELECT
			DISTINCT tmp_batch_results.result_set_type_key, tmp_batch_results.year, tmp_batch_results.gcn_sector_id, tmp_batch_results.sector_id, tmp_batch_results.reference, tmp_batch_results.scenario, tmp_batch_results.duration

			FROM tmp_batch_results

			ORDER BY tmp_batch_results.result_set_type_key, tmp_batch_results.year, tmp_batch_results.gcn_sector_id, tmp_batch_results.sector_id, tmp_batch_results.reference, tmp_batch_results.scenario, tmp_batch_results.duration
	LOOP
		RAISE NOTICE 'ae_store_calculation_batch_results - first for loop @ %', timeofday();

		-- Collect the result_set_type_key results
		CREATE TEMPORARY TABLE tmp_result_set_type_key_results ON COMMIT DROP AS
			SELECT *
				FROM tmp_batch_results
				WHERE
					tmp_batch_results.result_set_type_key = v_result_set_type_key
					AND tmp_batch_results.year = v_year
					AND (tmp_batch_results.gcn_sector_id = v_gcn_sector_id OR v_gcn_sector_id IS NULL) -- Null means no filter!
					AND (tmp_batch_results.sector_id = v_sector_id OR v_sector_id IS NULL) -- Null means no filter!
					AND (tmp_batch_results.reference = v_reference OR v_reference IS NULL) -- Null means no filter!
					AND (tmp_batch_results.scenario = v_scenario OR v_scenario IS NULL) -- Null means no filter!
			;

		CREATE INDEX idx_tmp_result_set_type_key_results ON tmp_result_set_type_key_results (result_type);


		-- Export the results
		FOR v_result_type IN
			SELECT DISTINCT tmp_result_set_type_key_results.result_type FROM tmp_result_set_type_key_results ORDER BY result_type
		LOOP
			RAISE NOTICE 'ae_store_calculation_batch_results - second for loop @ %', timeofday();

			v_result_count := (SELECT COUNT(*) FROM tmp_result_set_type_key_results WHERE tmp_result_set_type_key_results.result_type = v_result_type);
			v_substance_count := (SELECT COUNT(substance_id) FROM (SELECT DISTINCT substance_id FROM tmp_result_set_type_key_results WHERE tmp_result_set_type_key_results.result_type = v_result_type) AS substances);
		
			RAISE NOTICE '% results (% substances) found for result_set_type_key %, result_type % and year %.', v_result_count, v_substance_count, v_result_set_type_key, v_result_type, v_year;

			-- Determine filename
			v_current_filespec := v_filespec;
			v_current_filespec := replace(v_current_filespec, '{folder}', v_folder);
			v_current_filespec := replace(v_current_filespec, '{resulttype}', v_result_type::text);
			v_current_filespec := replace(v_current_filespec, '{resultsetkey}', v_result_set_type_key::text);
			v_current_filespec := replace(v_current_filespec, '{year}', v_year::text);
			v_current_filespec := replace(v_current_filespec, '{date}', to_char(current_timestamp, 'YYYYMMDD'));

			-- Get prefix
			v_prefix := '';
			IF v_reference IS NOT NULL THEN
				v_prefix := v_prefix || 'reference-' || v_reference || '_';
			END IF;

			IF v_scenario IS NOT NULL THEN
				v_prefix := v_prefix || 'scenario-' || v_scenario || '_';
			END IF;
			
			v_current_filespec := replace(v_current_filespec, '{prefix}', v_prefix::text);
			
			-- Get prefix
			v_suffix := '';
			IF v_gcn_sector_id IS NOT NULL THEN
				v_suffix := v_suffix || '_gcnsector-' || v_gcn_sector_id;
			END IF;

			IF v_sector_id IS NOT NULL THEN
				v_suffix := v_suffix || '_sector-' || v_sector_id;
			END IF;

			IF v_duration IS NOT NULL THEN
				v_suffix := v_suffix || '_duration-' || v_duration;
			END IF;

			v_current_filespec := replace(v_current_filespec, '{suffix}', v_suffix::text);

			-- Store
			RAISE NOTICE 'ae_store_calculation_batch_results - store data @ %', timeofday();
			
			-- Store data
			EXECUTE setup.ae_store_query(
					'tmp_result_set_type_key_results',
					E'SELECT year, result_set_type_key, result_type, substance_id, receptor_id, result FROM tmp_result_set_type_key_results WHERE result_type = ''' || v_result_type || E'''::emission_result_type',
					v_current_filespec,
					TRUE);

			-- Return info
			RETURN QUERY (SELECT v_result_set_type_key, v_result_count, v_result_type, v_year, v_substance_count, v_current_filespec);

		END LOOP;

		-- Cleanup loop
		DROP INDEX idx_tmp_result_set_type_key_results;
		DROP TABLE tmp_result_set_type_key_results;

	END LOOP;

	-- Cleanup loop
	DROP INDEX idx_tmp_batch_results;
	DROP TABLE tmp_batch_results;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_store_calculation_batch_results
 * ----------------------------------
 * Exporteert de resultaten van alle completed calculations naar een result-bestand per result_set_type_key, year, gcn_sector_id, sector_id en scenario.
 * Uitvoer is punt-komma gescheiden CSV met header.
 */
CREATE OR REPLACE FUNCTION setup.ae_store_calculation_batch_results(v_folder text)
	RETURNS TABLE(result_set_type_key integer, result_count integer, result_type emission_result_type, year year_type, substance_count integer, filename text) AS
$BODY$
DECLARE
	v_result_set_type_key integer;
	v_calculation_ids integer[];
BEGIN
	-- Add tmp_rename_input_files if not exists
	IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = 'tmp_rename_input_files') THEN
		CREATE TEMPORARY TABLE tmp_rename_input_files AS
			SELECT NULL::text AS input_file, NULL::text AS new_input_file LIMIT 0;
	END IF;

	-- Loop
	FOR v_result_set_type_key, v_calculation_ids IN
		SELECT
			calculation_result_sets.result_set_type_key,
			array_agg(DISTINCT calculation_id) AS calculation_ids

			FROM calculations
				INNER JOIN
					(SELECT
						calculation_id,
						setup.ae_string_to_value_by_key(basename, 'sector')::integer AS sector_id,
						setup.ae_string_to_value_by_key(basename, 'gcnsector')::integer AS gcn_sector_id,
						setup.ae_string_to_value_by_key(basename, 'duration')::integer AS duration,
						setup.ae_string_to_value_by_key(basename, 'reference')::text AS reference,
						setup.ae_string_to_value_by_key(basename, 'scenario')::text AS scenario

						FROM
							(SELECT
								calculation_id,
								setup.ae_get_basename(split_part(COALESCE(new_input_file, input_file), ';', 1), FALSE) AS basename
								
								FROM calculation_batch_options
									LEFT JOIN tmp_rename_input_files USING (input_file)

							) AS basenames
						) AS key_values USING (calculation_id)

				INNER JOIN calculation_result_sets USING (calculation_id)

			WHERE state = 'completed'

			GROUP BY
				key_values.sector_id,
				key_values.gcn_sector_id,
				key_values.duration,
				key_values.reference,
				key_values.scenario,
				calculation_result_sets.result_set_type_key
	LOOP

		RETURN QUERY SELECT * FROM setup.ae_store_calculation_batch_results(v_folder, v_calculation_ids);

	END LOOP;


	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_read_calculation_batch_results
 * ---------------------------------
 * Retourneert de resultaten van de opgegeven result-file.
 *
 * Zie setup.ae_read_calculation_batch_results(v_result_filenames text[]) voor meer info.
 */
CREATE OR REPLACE FUNCTION setup.ae_read_calculation_batch_results(v_result_filename text)
	RETURNS TABLE(sector_id integer, gcn_sector_id integer, result_set_type_key integer, year year_type, substance_id smallint, result_type emission_result_type, duration integer, reference text, scenario text, receptor_id integer, result real) AS
$BODY$
DECLARE
BEGIN
	RETURN QUERY
		(SELECT * FROM setup.ae_read_calculation_batch_results(ARRAY[v_result_filename]));

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_read_calculation_batch_results
 * ---------------------------------
 * Retourneert de resultaten van de opgegeven result-files.
 * De waarden voor de sector_id, gcn_sector_id, duration en scenario worden indien aanwezig uit de bestandsnaam (key-values) gehaald.
 * Indien de duration in de bestandsnaam is opgegeven zal deze verwerkt zijn in de rekenresultaten.
 */
CREATE OR REPLACE FUNCTION setup.ae_read_calculation_batch_results(v_result_filenames text[])
	RETURNS TABLE(sector_id integer, gcn_sector_id integer, result_set_type_key integer, year year_type, substance_id smallint, result_type emission_result_type, duration integer, reference text, scenario text, receptor_id integer, result real) AS
$BODY$
DECLARE
	v_result_filename text;
	v_result_basename text;
	v_sector_id integer;
	v_gcn_sector_id integer;
	v_duration integer;
	v_reference text;
	v_scenario text;
BEGIN

	-- Create temporary table for calculation results
	CREATE TEMPORARY TABLE tmp_batch_results (
		year year_type NOT NULL,
		result_set_type_key integer NOT NULL,
		result_type emission_result_type NOT NULL,
		substance_id smallint NOT NULL,
		receptor_id integer NOT NULL,
		result real NOT NULL
	)  ON COMMIT DROP;


	-- For all filenames
	FOR v_result_filename IN
		SELECT unnest(v_result_filenames)
	LOOP
		RAISE NOTICE 'ae_read_calculation_batch_results - read result-file % @ %', v_result_filename, timeofday();

		-- Load data
		PERFORM setup.ae_load_table('tmp_batch_results', v_result_filename, TRUE);

		-- Get key-values from filename
		v_result_basename := setup.ae_get_basename(v_result_filename, FALSE);
		v_sector_id := setup.ae_string_to_value_by_key(v_result_basename, 'sector'::text)::integer;
		v_gcn_sector_id := setup.ae_string_to_value_by_key(v_result_basename, 'gcnsector'::text)::integer;
		v_duration := setup.ae_string_to_value_by_key(v_result_basename, 'duration'::text)::integer;
		v_reference := setup.ae_string_to_value_by_key(v_result_basename, 'reference'::text);
		v_scenario := setup.ae_string_to_value_by_key(v_result_basename, 'scenario'::text);

		-- Return results
		RETURN QUERY
			(SELECT
				v_sector_id,
				v_gcn_sector_id,
				tmp_batch_results.result_set_type_key,
				tmp_batch_results.year,
				tmp_batch_results.substance_id,
				tmp_batch_results.result_type,
				v_duration,
				v_reference,
				v_scenario,
				tmp_batch_results.receptor_id,
				tmp_batch_results.result
				
				FROM tmp_batch_results);

		-- Empty temp table
		TRUNCATE TABLE tmp_batch_results;

	END LOOP;

	-- Drop table
	DROP TABLE tmp_batch_results;


	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;