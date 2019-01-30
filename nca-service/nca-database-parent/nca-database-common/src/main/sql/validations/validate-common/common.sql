/*
 * ae_validate_geometries
 * ----------------------
 * Valideert alle geometry data in de database.
 * De geoemtry velden worden bepaald met behulp van de (postgis) geometry_columns view.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_geometries()
	 RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	v_table_schema text;
	v_table_name text;
	v_geometry_column text;
	v_pkey_column_names text[];
	v_pkey_values text;
	v_invalid_reason text;
BEGIN
	RAISE NOTICE '* Listing invalid geometries...';

	-- Foreach geometry_column in each table_name
	FOR v_table_name, v_pkey_column_names, v_geometry_column IN
	
		(SELECT table_name, pkey_column_names, geometry_column 
			FROM
				(SELECT
					(f_table_schema || '.' || f_table_name)::regclass AS table_name,
					f_geometry_column AS geometry_column

					FROM geometry_columns
					
				) AS geometry_columns

				INNER JOIN
					(SELECT
						(pg_namespace.nspname || '.' || pg_class.relname)::regclass AS table_name

						FROM pg_catalog.pg_class
							INNER JOIN pg_catalog.pg_namespace ON pg_namespace.oid = pg_class.relnamespace

						WHERE pg_class.relkind = 'r'

					) AS tables USING (table_name)
					
				INNER JOIN
					(SELECT
						table_name,
						array_agg(pkey_column_name) AS pkey_column_names

						FROM
							(SELECT
								(pg_namespace.nspname || '.' || pg_class.relname)::regclass AS table_name,
								pg_attribute.attname AS pkey_column_name

								FROM pg_index
									INNER JOIN pg_class ON (pg_index.indrelid = pg_class.oid)
									INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid AND pg_attribute.attnum = ANY(pg_index.indkey))
									INNER JOIN pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
								WHERE
									pg_index.indisprimary IS TRUE
							) AS pkeys

							GROUP BY table_name

					) AS table_pkeys USING (table_name)
		)
		
	LOOP
		RAISE NOTICE '    Validate % - %', v_table_name, v_geometry_column;
		 
		-- Foreach invalid_reason within table
		FOR v_invalid_reason, v_pkey_values IN
			EXECUTE 'SELECT ST_IsValidReason(' || v_geometry_column || '), ARRAY[' || array_to_string(v_pkey_column_names, ','::text) || '] FROM ' || v_table_name || ' WHERE ST_IsValid(' || v_geometry_column || ') IS FALSE'
		LOOP
			RETURN NEXT setup.ae_to_validation_result('error', v_table_name,
				format('Invalid geometry table %s (%s values %s): %s', v_table_name, v_pkey_column_names, v_pkey_values, v_invalid_reason));
		END LOOP;

	END LOOP;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_sector_source_characteristics
 * -----------------------------------------
 * Validate the source characteristics for each sector.
 * Source characteristics are default values for OPS. Each sector should have a default one.
 * Returns error if a sector has no source characteristics. Some specific sectors are skipped if they are validated some other way.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_sector_source_characteristics()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating sector source characteristics...';
	
	CREATE TEMPORARY TABLE tmp_validation_exclude_sectors AS 
	SELECT sector_id
		
		FROM sectors
			INNER JOIN system.sector_calculation_properties USING (sector_id)
			
		WHERE emission_calculation_method ILIKE 'SHIPPING%' 
			OR emission_calculation_method ILIKE 'PLAN';

	FOR rec IN
		SELECT sector_id, description, SUM(CASE WHEN sscv.heat_content IS NOT NULL THEN 1 ELSE 0 END) AS counter
		FROM sectors
			LEFT JOIN default_source_characteristics_view AS sscv USING (sector_id)
			LEFT JOIN tmp_validation_exclude_sectors USING (sector_id)
			
		WHERE tmp_validation_exclude_sectors.sector_id IS NULL
		GROUP BY sector_id, description
		ORDER BY sector_id
	LOOP
		IF rec.counter < 1 THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'default_source_characteristics_view',
				format('Sector %s (%s) has missing source characteristics', rec.sector_id, rec.description));
		END IF;
	END LOOP;
	
	DROP TABLE tmp_validation_exclude_sectors;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_validate_shipping_source_characteristics
 * -------------------------------------------
 * Validate the source characteristics for each ship type (both maritime and inland).
 * Source characteristics are values used in OPS. Each shiptype should have a one.
 * Returns error if a ship type has no source characteristics.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_shipping_source_characteristics()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating shipping inland characteristics...';

	FOR rec IN
		SELECT shipping_inland_category_id, description
		
			FROM shipping_inland_categories
				LEFT JOIN shipping_inland_source_characteristics_view USING (shipping_inland_category_id)
				
			WHERE shipping_inland_source_characteristics_view.shipping_inland_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_source_characteristics_view',
			format('Inland shipping category %s (%s) has missing source characteristics', rec.shipping_inland_category_id, rec.description));
	END LOOP;

	--
	-- Shipping inland category/shipping inland waterway category combinations that are not allowed have no source characteristics records.
	--
	
	-- Check that when a ship type/waterway type combination has upstream emission factors, there are also downstream ones (and vice versa).
	-- For irrelevant direction, this doesn't have to be checked.
	FOR rec IN
		SELECT shipping_inland_category_id, shipping_inland_waterway_category_id FROM (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_source_characteristics_view WHERE ship_direction = 'upstream'
		) AS upstream_types
		FULL JOIN (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_source_characteristics_view WHERE ship_direction = 'downstream'
		) AS downstream_types USING (shipping_inland_category_id, shipping_inland_waterway_category_id)
		WHERE upstream_types.shipping_inland_waterway_category_id IS NULL OR downstream_types.shipping_inland_waterway_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_source_characteristics',
			format('Shipping inland category "%s", waterway type "%s" only has source characteristics for either upstream or downstream', rec.shipping_inland_category_id, rec.shipping_inland_waterway_category_id));
	END LOOP;
	
	-- Check that when a ship type/waterway type combination has laden source characteristics, there are also unladen ones (and vice versa).
	FOR rec IN
		SELECT shipping_inland_category_id, shipping_inland_waterway_category_id FROM (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_source_characteristics_view WHERE laden_state = 'laden'
		) AS laden_types
		FULL JOIN (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_source_characteristics_view WHERE laden_state = 'unladen'
		) AS unladen_types USING (shipping_inland_category_id, shipping_inland_waterway_category_id)
		WHERE laden_types.shipping_inland_waterway_category_id IS NULL OR  unladen_types.shipping_inland_waterway_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_source_characteristics',
			format('Shipping inland category "%s", waterway type "%s" only has source characteristics for either laden or unladen', rec.shipping_inland_category_id, rec.shipping_inland_waterway_category_id));
	END LOOP;



	RAISE NOTICE '* Validating shipping inland docked source characteristics...';
	
	FOR rec IN
		SELECT shipping_inland_category_id, description

			FROM shipping_inland_categories
				LEFT JOIN shipping_inland_source_characteristics_docked_view USING (shipping_inland_category_id)

			WHERE shipping_inland_source_characteristics_docked_view.shipping_inland_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_source_characteristics_docked_view',
			format('Inland shipping category %s (%s) has missing docked source characteristics', rec.shipping_inland_category_id, rec.description));
	END LOOP;

	-- Check that when a ship type has laden source characteristics, there are also unladen ones (and vice versa).
	FOR rec IN
		SELECT shipping_inland_category_id FROM (
			SELECT DISTINCT shipping_inland_category_id FROM shipping_inland_source_characteristics_docked_view WHERE laden_state = 'laden'
		) AS laden_types
		FULL JOIN (
			SELECT DISTINCT shipping_inland_category_id FROM shipping_inland_source_characteristics_docked_view WHERE laden_state = 'unladen'
		) AS unladen_types USING (shipping_inland_category_id)
		WHERE laden_types.shipping_inland_category_id IS NULL OR  unladen_types.shipping_inland_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_source_characteristics_docked',
			format('Shipping inland category "%s" only has docked source characteristics for either laden or unladen', rec.shipping_inland_category_id));
	END LOOP;
	

	
	RAISE NOTICE '* Validating shipping maritime characteristics...';

	FOR rec IN
		SELECT shipping_maritime_category_id, description
		
			FROM shipping_maritime_categories
				LEFT JOIN shipping_maritime_source_characteristics_view USING (shipping_maritime_category_id)
				
			WHERE shipping_maritime_source_characteristics_view.shipping_maritime_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_maritime_source_characteristics_view',
			format('Maritime shipping category %s (%s) has missing source characteristics', rec.shipping_maritime_category_id, rec.description));
	END LOOP;

	-- Check that a maritime ship type has laden source characteristics, there are also unladen ones (and vice versa).
	FOR rec IN
		SELECT shipping_maritime_category_id 

			FROM shipping_maritime_categories

			WHERE shipping_maritime_category_id NOT IN
				(SELECT shipping_maritime_category_id
					FROM
						(SELECT DISTINCT shipping_maritime_category_id 
							FROM shipping_maritime_source_characteristics_view
							WHERE movement_type = 'dock'
						) AS dock_categories
							
						INNER JOIN 
							(SELECT DISTINCT shipping_maritime_category_id 
								FROM shipping_maritime_source_characteristics_view
								WHERE movement_type = 'inland'
							) AS inland_categories USING (shipping_maritime_category_id)
							
						INNER JOIN
							(SELECT DISTINCT shipping_maritime_category_id 
								FROM shipping_maritime_source_characteristics_view
								WHERE movement_type = 'maritime'
							) AS maritime_categories USING (shipping_maritime_category_id)
					)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_maritime_source_characteristics_view',
			format('Shipping maritime category "%s" does not have a complete set of source characteristics for dock, inland and maritime.', rec.shipping_maritime_category_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_plan_source_characteristics
 * ---------------------------------------
 * Validate the source characteristics for each kind of Plan.
 * Source characteristics are values used in OPS. Each plan should have a set.
 * Returns error if a plan has no source characteristics.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_plan_source_characteristics()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating plan characteristics...';

	FOR rec IN
		SELECT plan_category_id, name FROM plan_categories_source_characteristics_view WHERE heat_content IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'plan_categories_source_characteristics_view',
			format('Plan category %s (%s) has missing source characteristics', rec.plan_category_id, rec.name));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;



/*
 * ae_validate_road_emission_factors
 * ---------------------------------
 * Validate the emisison factors for roads.
 * Warnings if there are no emission factors for a road type, vehicle type combination
 * Warnings if there are only emission factors for either strict or not_strict for that combination. If one exists, the other should exist as well.
 * Warnings if no emission factor could be found for each road_type, vehicle type, maximum speed and substance id and each year.
 * Each year is based on the different years available in the table.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_road_emission_factors()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	num_records integer;
	num_years integer;
BEGIN
	RAISE NOTICE '* Validating road category emission factors...';

	--check that when a vehicle_type/road_type combination has strict enforcement emission factors, there are also non-strict ones.
	FOR rec IN
		SELECT vehicle_type, road_type FROM (
			SELECT DISTINCT vehicle_type, road_type FROM road_categories_view WHERE speed_limit_enforcement = 'strict'
		) AS strict_types
		LEFT JOIN (
			SELECT DISTINCT vehicle_type, road_type FROM road_categories_view WHERE speed_limit_enforcement = 'not_strict'
		) AS not_strict_types USING (vehicle_type, road_type)
		WHERE not_strict_types.vehicle_type IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'road_category_emission_factors',
			format('Road vehicle type "%s", road type "%s" only has emissionfactors for STRICT speed limit enforcement', rec.vehicle_type, rec.road_type));
	END LOOP;

	--check that when a vehicle_type/road_type combination has non-strict enforcement emission factors, there are also strict ones.
	FOR rec IN
		SELECT vehicle_type, road_type FROM (
			SELECT DISTINCT vehicle_type, road_type FROM road_categories_view WHERE speed_limit_enforcement = 'strict'
		) AS strict_types
		RIGHT JOIN (
			SELECT DISTINCT vehicle_type, road_type FROM road_categories_view WHERE speed_limit_enforcement = 'not_strict'
		) AS not_strict_types USING (vehicle_type, road_type)
		WHERE strict_types.vehicle_type IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'road_category_emission_factors',
			format('Road vehicle type "%s", road type "%s" only has emissionfactors for NOT_STRICT speed limit enforcement', rec.vehicle_type, rec.road_type));
	END LOOP;
	--for irrelevant enforcement, this doesn't have to be checked.

	--check that all road_type, vehicle_type combo's have emission factor.
	FOR rec IN
		SELECT vehicle_type, road_type FROM
			(SELECT CAST(e.enumlabel AS vehicle_type) AS vehicle_type FROM pg_enum e JOIN pg_type t ON e.enumtypid = t.oid WHERE t.typname = 'vehicle_type') AS vehicletypes,
			(SELECT CAST(e.enumlabel AS road_type) AS road_type FROM pg_enum e JOIN pg_type t ON e.enumtypid = t.oid WHERE t.typname = 'road_type') AS roadtypes
	LOOP
		IF (SELECT NOT EXISTS(
			SELECT 1 FROM road_categories_view roadef
			WHERE roadef.vehicle_type = rec.vehicle_type
			AND roadef.road_type = rec.road_type))
		THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'road_category_emission_factors',
				format('Road vehicle type "%s", road type "%s" combination does not have emission factors', rec.vehicle_type, rec.road_type));
		END IF;
	END LOOP;

	--there should be an emission factor for each road category, speed profile combination.
	--for each distinct substance_id in the table, there should be an emission factor for all those combinations as well.
	--All combinations should have the same amount of different years.
	num_years := COUNT(DISTINCT year) FROM road_category_emission_factors;
	FOR rec IN
		SELECT DISTINCT road_category_id, road_speed_profile_id, substance_id
		FROM road_category_emission_factors
	LOOP
		SELECT COUNT(*) FROM road_category_emission_factors roadef
			WHERE roadef.road_category_id = rec.road_category_id
			AND roadef.road_speed_profile_id = rec.road_speed_profile_id
			AND roadef.substance_id = rec.substance_id
			INTO num_records;
		IF num_records < (num_years) THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'road_category_emission_factors',
				format('Road category ID "%s", road speed profile ID "%s", substance "%s" does not have an emission factor for all years. Expected %s, found "%s"', rec.road_category_id, rec.road_speed_profile_id, rec.substance_id, num_years, num_records));
		END IF;
	END LOOP;

	--there should be an emission factor for each vehicle_type, road_type, speedlimit (with/without enforcement) combination.
	--for each distinct substance_id in the table, there should be an emission factor for all those combinations as well.
	--All combinations should have the same amount of different years.
	num_years := COUNT(DISTINCT year) FROM road_categories_view;
	FOR rec IN
		SELECT DISTINCT vehicle_type, road_type, speed_limit_enforcement, maximum_speed, substance_id
		FROM road_categories_view
		ORDER BY vehicle_type, road_type, speed_limit_enforcement, maximum_speed
	LOOP
		SELECT COUNT(*) FROM road_categories_view roadef
			WHERE roadef.vehicle_type = rec.vehicle_type
			AND roadef.road_type = rec.road_type
			AND roadef.speed_limit_enforcement = rec.speed_limit_enforcement
			AND (roadef.maximum_speed = rec.maximum_speed OR (roadef.maximum_speed IS NULL AND rec.maximum_speed IS NULL))
			AND roadef.substance_id = rec.substance_id
			INTO num_records;
		IF num_records < (num_years) THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'road_category_emission_factors',
				format('Road vehicle type "%s", road type "%s", speed limit enforcement "%s", max speed "%s", substance "%s" does not have an emission factor for all years. Expected %s, found "%s"', rec.vehicle_type, rec.road_type, rec.speed_limit_enforcement, rec.maximum_speed, rec.substance_id, num_years, num_records));
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;



/*
 * ae_validate_shipping_emission_factors
 * -------------------------------------
 * Validate the emisison factors for shipping.
 * Warnings if there are only emission factors for either upstream or downstream for that combination. If one exists, the other should exist as well.
 * Warnings if no emission factor could be found for each waterway type, ship type, direction and substance id and each year.
 * Each year is based on the different years available in the table.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_shipping_emission_factors()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	num_records integer;
	num_years integer;
BEGIN
	RAISE NOTICE '* Validating shipping category emission factors...';

	--check that when a ship type/waterway type combination has upstream emission factors, there are also downstream ones (and vica versa).
	FOR rec IN
		SELECT shipping_inland_category_id, shipping_inland_waterway_category_id FROM (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_emission_factors_view WHERE ship_direction = 'upstream'
		) AS upstream_types
		FULL JOIN (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_emission_factors_view WHERE ship_direction = 'downstream'
		) AS downstream_types USING (shipping_inland_category_id, shipping_inland_waterway_category_id)
		WHERE upstream_types.shipping_inland_waterway_category_id IS NULL OR downstream_types.shipping_inland_waterway_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_emission_factors',
			format('Shipping inland category "%s", waterway type "%s" only has emissionfactors for either upstream or downstream', rec.shipping_inland_category_id, rec.shipping_inland_waterway_category_id));
	END LOOP;
	
	--check that when a ship type/waterway type combination has laden emission factors, there are also unladen ones (and vica versa).
	FOR rec IN
		SELECT shipping_inland_category_id, shipping_inland_waterway_category_id FROM (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_emission_factors_view WHERE laden_state = 'laden'
		) AS laden_types
		FULL JOIN (
			SELECT DISTINCT shipping_inland_category_id, shipping_inland_waterway_category_id FROM shipping_inland_emission_factors_view WHERE laden_state = 'unladen'
		) AS unladen_types USING (shipping_inland_category_id, shipping_inland_waterway_category_id)
		WHERE laden_types.shipping_inland_waterway_category_id IS NULL OR  unladen_types.shipping_inland_waterway_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_emission_factors',
			format('Shipping inland category "%s", waterway type "%s" only has emissionfactors for either laden or unladen', rec.shipping_inland_category_id, rec.shipping_inland_waterway_category_id));
	END LOOP;

	--for irrelevant direction, this doesn't have to be checked.

	--check that all shipping inland categories have at least one emission factor.
	FOR rec IN
		SELECT shipping_inland_category_id FROM shipping_inland_categories
			LEFT JOIN shipping_inland_emission_factors_view USING (shipping_inland_category_id)
			WHERE shipping_inland_emission_factors_view.shipping_inland_category_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_emission_factors',
			format('Shipping inland category "%s" does not have emission factors', rec.shipping_inland_category_id));
	END LOOP;

	--there should be an emission factor for each ship category/direction/laden state.
	--for each distinct substance_id in the table, there should be an emission factor for all those combinations as well.
	--All combinations should have the same amount of different years.
	num_years := COUNT(DISTINCT year) FROM shipping_inland_emission_factors_view;
	FOR rec IN
		SELECT DISTINCT shipping_inland_category_id, ship_direction, laden_state, substance_id
		FROM shipping_inland_emission_factors_view
	LOOP
		SELECT COUNT(*) FROM shipping_inland_emission_factors_view roadef
			WHERE roadef.shipping_inland_category_id = rec.shipping_inland_category_id
			AND roadef.ship_direction = rec.ship_direction
			AND roadef.laden_state = rec.laden_state
			AND roadef.substance_id = rec.substance_id
			INTO num_records;
		IF num_records < (num_years) THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'shipping_inland_emission_factors',
				format('Inland ship category ID "%s", direction "%s", laden state "%s", substance "%s" does not have an emission factor for all years. Expected %s, found "%s"', 
						rec.shipping_inland_category_id, rec.ship_direction, rec.laden_state, rec.substance_id, num_years, num_records));
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_farm_completeness
 * -----------------------------
 * Valideert de emissiefactoren van stalsystemen. Exceptie als er geen factor is bij een stalsysteem.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_farm_completeness()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of farm lodging type emission factors...';

	FOR rec IN
		EXECUTE setup.ae_validate_get_completeness_sql('farm_lodging_type_emission_factors', 'substances, farm_lodging_types', $$ substance_id = 17 $$)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'farm_lodging_type_emission_factors',
			format('substance %s, farm lodging type %s has no emission factors', rec.substance_id, rec.farm_lodging_types));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;



/*
 * ae_validate_system_sectors
 * --------------------------
 * List sectors and/or sectorgroups which have no presence in system sector specific tables.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_system_sectors()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	num_records integer;
BEGIN
	RAISE NOTICE '* Validating (system) sector properties...';
	-- Each sector should be available through the view. If not, it won't be shown in calculator for instance.
	FOR rec IN
		SELECT sector_id, description
		FROM sectors
		LEFT JOIN system.sector_properties_view USING (sector_id)
		WHERE sector_properties_view.sector_id IS NULL
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'system.sector_properties_view',
			format('Sector "%s", description "%s" has no proper system sector properties', rec.sector_id, rec.description));
	END LOOP;

	RAISE NOTICE '* Validating (system) sector properties on sectorgroups...';
	-- Determine which sectorgroups are NOT present in the view.
	FOR rec IN
		SELECT DISTINCT sectorgroup FROM system.sectors_sectorgroup
	LOOP
		SELECT COUNT(*) FROM system.sector_properties_view
			WHERE sector_properties_view.sectorgroup = rec.sectorgroup
			INTO num_records;
		IF num_records < 1 THEN
			RETURN NEXT setup.ae_to_validation_result('error', 'system.sector_properties_view',
				format('Sectorgroup "%s" was not found in the system sector properties', rec.sectorgroup));
		END IF;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_system_habitat_colors
 * ---------------------------------
 * Valideert of alle ingetekende habitattypen ook een WMS-kleur hebben.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_system_habitat_colors()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating (system) habitat type colors';

	FOR rec IN
		SELECT DISTINCT habitat_type_id FROM habitat_areas -- mapped only
		EXCEPT
		SELECT habitat_type_id FROM system.habitat_type_colors
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'system.habitat_type_colors',
			format('habitat type id %s has no color', rec.habitat_type_id));
	END LOOP;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_habitat_type_critical_level
 * ---------------------------------------
 * Valideert de habitat type critical levels. Exceptie als er geen deposition level is bij een habitat type.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_habitat_type_critical_level()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating completeness of habitat type critical levels...';

	FOR rec IN
		(SELECT
			habitat_type_id

			FROM habitat_types
				LEFT JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
				
			WHERE habitat_type_critical_depositions_view.habitat_type_id IS NULL

			ORDER BY habitat_type_id)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'habitat_type_critical_levels',
			format('habitat type id %s, has no critical deposition level', rec.habitat_type_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_all_relevant_receptors_in_pas_assessment_areas
 * ----------------------------------------------------------
 * Valideert dat alle relevante receptoren in PAS-gebieden liggen.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_all_relevant_receptors_in_pas_assessment_areas()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
	v_count integer;
BEGIN
	v_count := 
		(SELECT
			COUNT(*)
			
			FROM (SELECT DISTINCT receptor_id FROM reserved_development_spaces) AS relevant_receptors
				LEFT JOIN 
					(SELECT * 
						FROM receptors_to_assessment_areas 
							INNER JOIN pas_assessment_areas USING (assessment_area_id)
					) AS receptors_to_pas_assessment_areas USING (receptor_id)
			
			WHERE receptors_to_pas_assessment_areas.assessment_area_id IS NULL
		);

	IF v_count > 0 THEN
		RETURN NEXT setup.ae_to_validation_result('error', 'reserved_development_spaces',
				format('%s relevant receptors not in pas assessment areas', v_count));
	END IF;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_relevant_habitats
 * -----------------------------
 * Valideert of alle relevante habitats gekoppeld zijn aan een aangewezen habitat en/of soort OF een H9999x zijn.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_relevant_habitats()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating relevant habitats (areas)...';

	FOR rec IN
		(SELECT
			assessment_area_id,
			habitat_type_id
			
			FROM habitat_types
				INNER JOIN relevant_habitats USING (habitat_type_id)
				LEFT JOIN designated_habitats_view USING (assessment_area_id, habitat_type_id)
				LEFT JOIN designated_species_to_habitats_view USING (assessment_area_id, habitat_type_id)

			WHERE
				designated_habitats_view.habitat_type_id IS NULL -- geen aangewezen habitat-type
				AND designated_species_to_habitats_view.habitat_type_id IS NULL -- geen aangewezen soort
				AND name NOT ILIKE 'H9999%' -- geen H9999

			ORDER BY assessment_area_id, habitat_type_id
		)
	LOOP
		RETURN NEXT setup.ae_to_validation_result('error', 'relevant_habitats',
			format('relevant habitat type id %s within areassesment area id %s, should not be relevant.', rec.habitat_type_id, rec.assessment_area_id));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;