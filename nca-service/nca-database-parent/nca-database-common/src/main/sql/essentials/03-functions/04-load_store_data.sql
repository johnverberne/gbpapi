/*
 * ae_load_table
 * -------------
 * Kopieert de data van het opgegeven bestand naar de opgegeven tabel.
 * Invoer moet tabgescheiden txt zonder header zijn of optioneel een punt-komma geschieden CSV inclusief header.
 */
CREATE OR REPLACE FUNCTION setup.ae_load_table(tablename regclass, filespec text, use_pretty_csv_format boolean = FALSE)
	RETURNS void AS
$BODY$
DECLARE
	current_encoding text;
	filename text;
	extra_options text = '';
	delimiter_to_use text = E'\t';
	sql text;
BEGIN
	-- set encoding
	EXECUTE 'SHOW client_encoding' INTO current_encoding;
	EXECUTE 'SET client_encoding TO UTF8';

	filename := replace(filespec, '{tablename}', tablename::text);
	filename := replace(filename, '{datesuffix}', to_char(current_timestamp, 'YYYYMMDD'));

	IF use_pretty_csv_format THEN
		extra_options := 'HEADER';
		delimiter_to_use := ';';
	END IF;

	sql := 'COPY ' || tablename || ' FROM ''' || filename || E''' DELIMITER ''' || delimiter_to_use || ''' CSV ' || extra_options;

	RAISE NOTICE '% Starting @ %', sql, timeofday();
	EXECUTE sql;
	RAISE NOTICE '% Done @ %', sql, timeofday();

	-- reset encoding
	EXECUTE 'SET client_encoding TO ' || current_encoding;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_store_query
 * --------------
 * Kopieert de uitkomst van de opgegeven query string naar het opgegeven bestand.
 * In de bestandsnaam kan de string {tablename} of {queryname} gebruikt worden, deze zal vervangen worden door de opgegeven tabelnaam.
 * Verder wordt {datesuffix} vervangen door de huidige datum in YYYYMMDD formaat.
 * Uitvoer is tabgescheiden CSV.
 * Optioneel kan extern-bruikbare CSV geexporteerd worden, waarbij ipv tabgescheiden CSV een punt-komma gescheiden CSV inclusief header wordt geexporteerd.
 */
CREATE OR REPLACE FUNCTION setup.ae_store_query(queryname text, sql_in text, filespec text, use_pretty_csv_format boolean = FALSE)
	RETURNS void AS
$BODY$
DECLARE
	current_encoding text;
	filename text;
	extra_options text = '';
	delimiter_to_use text = E'\t';
	sql text;
BEGIN
	-- set encoding
	EXECUTE 'SHOW client_encoding' INTO current_encoding;
	EXECUTE 'SET client_encoding TO UTF8';

	filename := replace(filespec, '{queryname}', queryname);
	filename := replace(filename, '{tablename}', queryname);
	filename := replace(filename, '{datesuffix}', to_char(current_timestamp, 'YYYYMMDD'));
	filename := '''' || filename || '''';

	IF use_pretty_csv_format THEN
		extra_options := 'HEADER';
		delimiter_to_use := ';';
	END IF;

	sql := 'COPY (' || sql_in || ') TO ' || filename || E' DELIMITER ''' || delimiter_to_use || ''' CSV ' || extra_options;
	
	RAISE NOTICE '%', sql;
	
	EXECUTE sql;

	-- reset encoding
	EXECUTE 'SET client_encoding TO ' || current_encoding;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_store_table
 * --------------
 * Kopieert de data van de opgegeven tabel naar het opgegeven bestand.
 * In de bestandsnaam kan de string {tablename} of {queryname} gebruikt worden, deze zal vervangen worden door de opgegeven tabelnaam.
 * Verder wordt {datesuffix} vervangen door de huidige datum in YYYYMMDD formaat.
 * Uitvoer is tabgescheiden CSV.
 * Optioneel kan de tabel gesorteerd geexporteerd worden.
 * Optioneel kan extern-bruikbare CSV geexporteerd worden, waarbij ipv tabgescheiden CSV een punt-komma gescheiden CSV inclusief header wordt geexporteerd.
 */
CREATE OR REPLACE FUNCTION setup.ae_store_table(tablename regclass, filespec text, ordered bool = FALSE, use_pretty_csv_format boolean = FALSE)
	RETURNS void AS
$BODY$
DECLARE
	ordered_columns_string text;
	tableselect text;
BEGIN
	tableselect := 'SELECT * FROM ' || tablename;
	
	IF ordered THEN
		SELECT
			array_to_string(array_agg(column_name::text), ', ')
			INTO ordered_columns_string
			FROM
				(SELECT column_name
					FROM information_schema.columns
					WHERE (CASE WHEN table_schema = 'public' THEN table_name ELSE table_schema || '.' || table_name END)::text = tablename::text
					ORDER BY ordinal_position
				) ordered_columns;
	
		tableselect := tableselect || ' ORDER BY ' || ordered_columns_string || '';
	END IF;
	
	PERFORM setup.ae_store_query(tablename::text, tableselect, filespec, use_pretty_csv_format);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
