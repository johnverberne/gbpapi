/*
 * ae_assessment_area_geometry_of_interest
 * ---------------------------------------
 * Retourneert het interessegebied van een assessment gebied.
 * Het interessegebied is het assessment gebied op het land plus het gebied op het water waar habitatgebieden liggen.
 * Voor de zekerheid hebben we rond het deel op het water een buffer van 170mtr toegevoegd. Over het samengestelde
 * land en water deel voegen we nogmaals een buffer van 170mtr toe.
 */
CREATE OR REPLACE FUNCTION setup.ae_assessment_area_geometry_of_interest(v_assessment_area_id integer, v_land_geometry geometry)
	RETURNS geometry AS
$BODY$
DECLARE
	v_on_land_geometry geometry;
	v_on_water_geometry geometry;
	v_habitat_on_water_geometry geometry;
	v_habitat_on_water_count integer;
	v_buffer integer = ae_constant('GEOMETRY_OF_INTEREST_BUFFER')::integer;
BEGIN
	-- Get the geometry of the assessment area on land and water
	v_on_land_geometry := (SELECT ST_Intersection(geometry, v_land_geometry) FROM assessment_areas WHERE assessment_area_id = v_assessment_area_id);
	v_on_water_geometry := (SELECT ST_Difference(geometry, v_land_geometry) FROM assessment_areas WHERE assessment_area_id = v_assessment_area_id);

	-- Habitat on land geometry must be set
	v_habitat_on_water_geometry := ST_GeomFromText('POLYGON EMPTY', ae_get_srid());

	-- Get the hatiat geometry on water
	IF (NOT ST_IsEmpty(v_on_water_geometry)) THEN
		-- Get the geometry of the habitat_areas within the on water geometry
		-- Use count because ST_Union(NULL) returns invalid geometry
		SELECT
			ST_Union(ST_Intersection(geometry, v_on_water_geometry)),
			COUNT(*)

			INTO v_habitat_on_water_geometry, v_habitat_on_water_count

			FROM habitats
				INNER JOIN goal_habitat_types_view USING (habitat_type_id) -- Use sensitive boolean from parent type

			WHERE
				assessment_area_id = v_assessment_area_id
				AND sensitive IS TRUE
				AND ST_Intersects(v_on_water_geometry, geometry)
		;

		IF (v_habitat_on_water_count = 0) THEN
			v_habitat_on_water_geometry := ST_GeomFromText('POLYGON EMPTY', ae_get_srid());
		END IF;
	END IF;

	RAISE NOTICE E'Assessment area %: % m\u00B2 land, % m\u00B2 water, % m\u00B2 habitat on water.', v_assessment_area_id, FLOOR(ST_Area(v_on_land_geometry)), FLOOR(ST_Area(v_on_water_geometry)), FLOOR(ST_Area(v_habitat_on_water_geometry));

	RETURN ST_Buffer(ST_Union(v_on_land_geometry, ST_Buffer(v_habitat_on_water_geometry, 2 * v_buffer)), v_buffer);
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_build_geometry_of_interests
 * ------------------------------
 * Bepaalt de interessegebieden van ieder toetsgebied.
 * Deze functie moet eerst aangeroepen worden voordat de receptoren gemaakt kunnen worden.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_geometry_of_interests()
	RETURNS void AS
$BODY$
DECLARE
	v_land_geometry geometry;
BEGIN
	RAISE NOTICE '[%] Generating land geometry...', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
	v_land_geometry := (SELECT ST_Union(geometry) FROM setup.province_land_borders);

	RAISE NOTICE '[%] Generating all geometry of interests...', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
	INSERT INTO setup.geometry_of_interests(assessment_area_id, geometry)
	SELECT
		assessment_area_id,
		ST_Multi(setup.ae_assessment_area_geometry_of_interest(assessment_area_id, v_land_geometry))

		FROM
			(SELECT assessment_area_id FROM assessment_areas WHERE type = 'natura2000_area' ORDER BY assessment_area_id) AS assessment_area_ids
	;

	RAISE NOTICE '[%] Done.', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_build_receptors
 * ------------------
 * Vult de receptor tabel met alle receptoren die in de interessegebieden van de toetsgebieden liggen.
 * Deze functie moet eerst aangeroepen worden voordat de hexagonen gemaakt worden.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_receptors()
	RETURNS void AS
$BODY$
DECLARE
	v_geometry_of_interests geometry;
	v_outside_boundary geometry;
BEGIN
	IF (SELECT COUNT(*) FROM setup.geometry_of_interests) = 0 THEN
		RAISE EXCEPTION '"setup.geometry_of_interests" table is empty. You must generate geometry of interests before receptors. You can use "setup.ae_build_geometry_of_interests()".';
	END IF;

	IF EXISTS(SELECT receptor_id FROM hexagons LIMIT 1) THEN
		RAISE WARNING '"hexagons" table is not empty! You should generate receptors BEFORE hexagons!';
	END IF;

	RAISE NOTICE '[%] Merging geometry of interests...', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
	v_geometry_of_interests := (SELECT ST_Union(geometry) FROM setup.geometry_of_interests);

	RAISE NOTICE '[%] Subtracting outside boundary...', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
	v_outside_boundary := ST_SetSRID(ST_GeomFromText(ae_constant('CALCULATOR_BOUNDARY')), ae_get_srid());
	v_geometry_of_interests := ST_Difference(v_geometry_of_interests, v_outside_boundary);

	RAISE NOTICE '[%] Generating receptors...', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
	CREATE TEMPORARY TABLE receptors_in_bb ON COMMIT DROP AS
	SELECT receptor_id, geometry FROM ae_determine_receptor_ids_in_geometry(v_geometry_of_interests);

	RAISE NOTICE '[%] Inserting receptors...', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
	INSERT INTO receptors SELECT receptor_id, geometry FROM receptors_in_bb;

	DROP TABLE receptors_in_bb;

	RAISE NOTICE '[%] Done.', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_build_hexagons
 * -----------------
 * Vult de hexagons tabel met alle hexagonen die bij de receptoren horen.
 * Deze functie mag pas aangeroepen worden nadat de receptoren gemaakt zijn.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_hexagons()
	RETURNS void AS
$BODY$
DECLARE
	v_max_zoom_level integer = ae_constant('MAX_ZOOM_LEVEL')::integer;
	v_zoom_level integer;
BEGIN
	IF (SELECT COUNT(*) FROM receptors) = 0 THEN
		RAISE EXCEPTION '"receptors" table is empty! You must generate receptors before hexagons. You can use "setup.ae_build_receptors()".';
	END IF;

	RAISE NOTICE '[%] Generating hexagons...', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');

	FOR v_zoom_level IN 1..v_max_zoom_level LOOP
		INSERT INTO hexagons
		SELECT receptors.receptor_id, v_zoom_level, ae_create_hexagon(receptors.receptor_id, v_zoom_level)
			FROM receptors
			WHERE
				v_zoom_level = 1
				OR ae_is_receptor_id_available_on_zoomlevel(receptors.receptor_id, v_zoom_level);
	END LOOP;
	RAISE NOTICE '[%] Done.', to_char(clock_timestamp(), 'DD-MM-YYYY HH24:MI:SS.MS');
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
