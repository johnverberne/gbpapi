/*
 * ae_apply_overkill_corrections
 * -----------------------------
 * Past de rekenafstand-correctiefactoren toe op verscheidene tabellen.
 * Het gaat om een correctie voor receptoren met een te korte rekenafstand tot de bronnen.
 *
 * Er zijn correctiefactoren per receptor, stof en sector (ook te koppelen aan GCN-sector).
 * De lijst met tabellen waarop deze correctie wordt toegepast is bepaald en staat gedefinieerd binnen deze functie.
 * Voor ieder jaar wordt dezelfde correctie toegepast.
 *
 * Momenteel zijn er correcties voor:
 *	Hoofdwegen - Growth-correction tabel (= groei, bestaande uit drie delen opgeteld)
 *	Hoofdwegen - Sectorbijdragen NoGrowthNoPolicy (is de POR-sectorbijdrage): voor 2014-2020-2030
 *	HWS (mobiele werktuigen) - PP bijdrage van IenM
 *	HWS (mobiele werktuigen) - Correctielaag 2014 van HWS (correctie totale depositie)
 *	Vaarwegen - PP bijdrage van IenW voor die sectoren
 *	Prioritaire Projecten provincies - PP bijdragen van wegverkeer projecten
 *	Prioritaire Projecten provincies - PP bijdragen andere sectoren? Alle sectoren? (glastuinbouw, enina divers, stallen, consumenten, HDO)
 *	Stallen - Stalbijdragen
 */
CREATE OR REPLACE FUNCTION setup.ae_apply_overkill_corrections()
	RETURNS void AS
$BODY$
DECLARE
	tables regclass[] = ARRAY[
			'setup.gcn_sector_depositions_no_policies_agriculture',
			'setup.gcn_sector_depositions_no_policies_no_growth',
			'setup.gcn_sector_depositions_global_policies',
			'setup.gcn_sector_depositions_jurisdiction_policies',
			'setup.gcn_sector_depositions_jurisdiction_policies_no_growth',

			'setup.sector_deposition_space_corrections_jurisdiction_policies',
			
			'setup.gcn_sector_economic_growth_corrections',
			
			'setup.sector_priority_project_demands_growth',	
			'setup.sector_priority_project_demands_desire',
			'setup.sector_priority_project_demands_desire_divided'
		]::regclass[];

	table_name regclass;
	key_column_array text[];
	correct_field text;
	rows_updated integer;
BEGIN
	RAISE NOTICE 'Applying overkill corrections...';

	FOREACH table_name IN ARRAY tables LOOP
		-- Determine (from primary key) the key columns to join on.
		key_column_array := (
			SELECT array_agg(attname) FROM (
				SELECT pg_attribute.attname
					FROM pg_index
						INNER JOIN pg_class ON (pg_index.indrelid = pg_class.oid)
						INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid AND pg_attribute.attnum = ANY(pg_index.indkey))
						INNER JOIN pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
					WHERE
						pg_index.indisprimary IS TRUE
						AND (pg_namespace.nspname || '.' || pg_class.relname)::regclass = table_name
				) AS columns
		);

		-- Determine field to apply correction factor as the first field that is not in the key_column_array.
		correct_field := (
			SELECT pg_attribute.attname
				FROM pg_class
					INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid)
					INNER JOIN pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
				WHERE
					pg_attribute.attnum > 0
					AND (pg_namespace.nspname || '.' || pg_class.relname)::regclass = table_name
					AND NOT pg_attribute.attname = ANY(key_column_array)
				ORDER BY pg_attribute.attnum
				LIMIT 1
		);

		IF 'substance_id' = ANY(key_column_array) THEN
			-- Run update on sector or gcn_sector table
			IF 'gcn_sector_id' = ANY(key_column_array) THEN
				EXECUTE $$
					UPDATE $$ || table_name || $$ AS u
						SET $$ || correct_field || $$ = $$ || correct_field || $$ * correction_factor

						FROM setup.sector_overkill_corrections AS c
							INNER JOIN gcn_sectors AS g USING (sector_id)

						WHERE
							u.receptor_id = c.receptor_id
							AND u.gcn_sector_id = g.gcn_sector_id
							AND u.substance_id = c.substance_id
				$$;
			ELSE
				EXECUTE $$
					UPDATE $$ || table_name || $$ AS u
						SET $$ || correct_field || $$ = $$ || correct_field || $$ * correction_factor

						FROM setup.sector_overkill_corrections AS c

						WHERE
							u.receptor_id = c.receptor_id
							AND u.sector_id = c.sector_id
							AND u.substance_id = c.substance_id
				$$;
			END IF;
		ELSE
			-- Run update on sector or gcn_sector table
			IF 'gcn_sector_id' = ANY(key_column_array) THEN
				EXECUTE $$
					UPDATE $$ || table_name || $$ AS u
						SET $$ || correct_field || $$ = $$ || correct_field || $$ * correction_factor

						FROM
							(SELECT gcn_sector_id, receptor_id, MIN(correction_factor) AS correction_factor
								FROM setup.sector_overkill_corrections
									INNER JOIN gcn_sectors AS g USING (sector_id)
								GROUP BY gcn_sector_id, receptor_id
							) AS c

						WHERE
							u.receptor_id = c.receptor_id
							AND u.gcn_sector_id = c.gcn_sector_id
				$$;
			ELSE
				EXECUTE $$
					UPDATE $$ || table_name || $$ AS u
						SET $$ || correct_field || $$ = $$ || correct_field || $$ * correction_factor

						FROM
							(SELECT sector_id, receptor_id, MIN(correction_factor) AS correction_factor
								FROM setup.sector_overkill_corrections
								GROUP BY sector_id, receptor_id
							) AS c

						WHERE
							u.receptor_id = c.receptor_id
							AND u.sector_id = c.sector_id
				$$;
			END IF;
		END IF;

		GET DIAGNOSTICS rows_updated = ROW_COUNT;
		RAISE NOTICE 'Updated % rows in table %', rows_updated, table_name;
	END LOOP;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

