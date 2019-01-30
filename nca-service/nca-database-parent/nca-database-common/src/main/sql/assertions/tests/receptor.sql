/*
 * ae_test_determine_receptor_id_from_coordinates
 * ----------------------------------------------
 * This test first creates a random point and get the receptor according to postgis. When it exists, the function ae_determine_receptor_id_from_coordinates is called
 * and checked if it returns the same receptor_id.
 */
CREATE OR REPLACE FUNCTION setup.ae_test_determine_receptor_id_from_coordinates()
	RETURNS text AS
$BODY$
DECLARE
	-- To know the bouderies of the x and y variable, the min and maximum of the bounding box are given:

	coordinate_x_min int = 0;
	coordinate_x_max int = 281000;
	coordinate_y_min int = 306000;
	coordinate_y_max int = 625000;

	-- Finally some dummy variables
	loop_iterator int = 0;
	succes_counter int = 0;
	test_x_coordinate int;
	test_y_coordinate int;
	test_point geometry;
	receptor_id_in_database int;
	receptor_id_from_function int;

	return_message text;

BEGIN
	WHILE (loop_iterator < 100) LOOP
		test_x_coordinate := round(coordinate_x_min + (coordinate_x_max - coordinate_x_min) * random())::int;
		test_y_coordinate := round(coordinate_y_min + (coordinate_y_max - coordinate_y_min) * random())::int;
		test_point := ST_SetSRID(ST_MakePoint(test_x_coordinate, test_y_coordinate), ae_get_srid());
		receptor_id_in_database := receptor_id FROM hexagons WHERE ST_Within(test_point, hexagons.geometry) AND zoom_level = 1;
		-- Only count when there are receptors in the database
		IF (receptor_id_in_database > 0) THEN
			receptor_id_from_function = ae_determine_receptor_id_from_coordinates(test_x_coordinate, test_y_coordinate, 1);
			IF (receptor_id_from_function = receptor_id_in_database ) THEN
				succes_counter = succes_counter + 1 ;
			END IF;
			loop_iterator = loop_iterator + 1;
		END IF;
	END LOOP;

	IF (succes_counter = 100) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed';
	END IF;
	RETURN return_message;

END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_test_determine_receptor_id_from_coordinates_from_receptor_id
 * ---------------------------------------------------------------
 * This test creates a random receptor in the range of all receptors. Next the coordinates of this receptor are calculated.
 * With the coordinates the corresponding receptor_id is calculated. Both ids should be the same.
 */
CREATE OR REPLACE FUNCTION setup.ae_test_determine_receptor_id_from_coordinates_from_receptor_id()
	RETURNS text AS
$BODY$
DECLARE
	-- Some dummy variables
	max_receptors int = 9462981;
	loop_iterator int = 0;
	succes_counter int = 0;
	random_receptor_id int;
	calculated_receptor_id int;
	geometry_from_function geometry;
	return_message text;
BEGIN
	WHILE (loop_iterator < 100) LOOP
		random_receptor_id 	:= round(max_receptors * random())::int;
		geometry_from_function	:= ae_determine_coordinates_from_receptor_id(random_receptor_id);
		calculated_receptor_id	:= ae_determine_receptor_id_from_coordinates(round(ST_X(geometry_from_function))::int, round(ST_Y(geometry_from_function))::int,1);

		IF (calculated_receptor_id = random_receptor_id) THEN
			succes_counter = succes_counter + 1;
		END IF;
		loop_iterator = loop_iterator + 1;
	END LOOP;

	IF (succes_counter = 100) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed';
	END IF;
	RETURN return_message;

END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_test_determine_receptor_ids_in_rectangle
 * -------------------------------------------
 * Create 100 random rectangles. Get the receptors from the rectangles according to postgis. The intersection of the function with the receptors should return the same receptors.
 *
 */
CREATE OR REPLACE FUNCTION setup.ae_test_determine_receptor_ids_in_rectangle()
	RETURNS text AS
$BODY$
DECLARE
	-- Some dummy variables
	coordinate_x_min int = 0;
	coordinate_x_max int = 281000;
	coordinate_y_min int = 306000;
	coordinate_y_max int = 625000;

	loop_iterator int = 0;
	succes_counter int = 0;
	x_min_for_rectangle int;
	x_max_for_rectangle int;
	y_min_for_rectangle int;
	y_max_for_rectangle int;

	point_low_left	geometry;
	point_up_right	geometry;
	rectangle	geometry;

	number_of_distinct_rows	int;
	return_message 	text;
BEGIN
	WHILE (loop_iterator < 100) LOOP
		-- Get a random min and max X,Y coordinate and get the corresponding receptors according to postgis
		x_min_for_rectangle	:= coordinate_x_min + round((coordinate_x_max - coordinate_x_min) * random())::int;
		x_max_for_rectangle	:= x_min_for_rectangle + round((coordinate_x_max - x_min_for_rectangle) * random())::int;
		y_min_for_rectangle	:= coordinate_y_min + round((coordinate_y_max - coordinate_y_min) * random())::int;
		y_max_for_rectangle	:= y_min_for_rectangle + round((coordinate_y_max - y_min_for_rectangle) * random())::int;
		point_low_left		:= ST_MakePoint(x_min_for_rectangle,y_min_for_rectangle);
		point_up_right		:= ST_MakePoint(x_max_for_rectangle,y_max_for_rectangle);
		rectangle		:= ST_SetSRID(ST_MakeBox2D(point_low_left, point_up_right), ae_get_srid());
		CREATE TEMPORARY TABLE tmp_postgis_receptor_ids AS SELECT receptor_id FROM receptors WHERE ST_Within (receptors.geometry, rectangle);

		-- Get the receptors from the rectangle by the function. Get the intersection of these receptors and the receptors in the db. This intersection should be exactly the same the the receptors above, so there should be no distinct rows.
		CREATE TEMPORARY TABLE tmp_calculated_receptor_ids AS SELECT ae_determine_receptor_ids_in_rectangle(x_min_for_rectangle, x_max_for_rectangle, y_min_for_rectangle, y_max_for_rectangle) AS receptor_id_calc;
		CREATE TEMPORARY TABLE tmp_intersect_receptor_ids AS SELECT receptor_id AS receptor_id_inner FROM tmp_calculated_receptor_ids INNER JOIN receptors ON (receptor_id_calc = receptor_id);
		CREATE TEMPORARY TABLE tmp_distinct_receptor_ids AS SELECT * FROM tmp_postgis_receptor_ids FULL OUTER JOIN tmp_intersect_receptor_ids ON (receptor_id = receptor_id_inner) WHERE receptor_id IS NULL OR receptor_id_inner IS NULL;
		number_of_distinct_rows = count(*) FROM tmp_distinct_receptor_ids;

		IF (number_of_distinct_rows = 0) THEN
			succes_counter = succes_counter + 1;
		END IF;
		loop_iterator = loop_iterator + 1;

		DROP TABLE tmp_postgis_receptor_ids;
		DROP TABLE tmp_calculated_receptor_ids;
		DROP TABLE tmp_intersect_receptor_ids;
		DROP TABLE tmp_distinct_receptor_ids;

	END LOOP;

	IF (succes_counter = 100) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed';
	END IF;
	RETURN return_message;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_test_determine_receptor_ids_from_receptor_with_radius
 * --------------------------------------------------------
 * This test checks if the function holds for the borders of the bouding box. When the function takes the borders into account, a perpendicular
 * projection of the receptors can't have any "holes" in it.
 *
 */
CREATE OR REPLACE FUNCTION setup.ae_test_determine_receptor_ids_from_receptor_with_radius()
	RETURNS text AS
$BODY$
DECLARE
	-- Some dummy variables
	loop_iterator int = 0;
	succes_counter int = 0;

	max_receptor_id int = 9462980;
	max_radius int = 1529;

	receptor_id int;
	radius int;
	number_of_distinct_rows int;
	first_vertically_projected int;
	last_vertically_projected int;

	return_message text;
BEGIN
	WHILE (loop_iterator < 100) LOOP

		receptor_id	:= 1 + (round(max_receptor_id * random()))::int;
		radius		:= 1 + (round(max_radius * random()))::int;
		-- The perpendicular projection of the receptor_ids is done by taking the distinct numbers modulo the number of hexagons horizontally.
		CREATE TEMPORARY TABLE tmp_calculated_receptor_ids AS SELECT DISTINCT ((receptor_id_calc - 1) % 1529 + 1) AS vert_proj
					FROM ae_determine_receptor_ids_from_receptor_with_radius(receptor_id, radius) AS receptor_id_calc
					ORDER BY vert_proj ASC;
		number_of_distinct_rows 	:= count(*) FROM tmp_calculated_receptor_ids;
		first_vertically_projected 	:= vert_proj FROM tmp_calculated_receptor_ids ORDER BY vert_proj ASC LIMIT 1;
		last_vertically_projected 	:= vert_proj FROM tmp_calculated_receptor_ids ORDER BY vert_proj DESC LIMIT 1;

		-- Because the set in tmp_calculated_receptor_ids is an ordered and distinct set of integers, the following holds: id(x+n) >= id(x) + n.
		-- Furthermore when there are no "holes" in the set, the following holds: id(x+n) = id(x) + n. So we only need the first and last id in the set
		-- and the number of id's.
		IF (first_vertically_projected + number_of_distinct_rows - 1 = last_vertically_projected) THEN
			succes_counter = succes_counter + 1;
		END IF;
		loop_iterator = loop_iterator + 1;

		DROP TABLE tmp_calculated_receptor_ids;
	END LOOP;

	IF (succes_counter = 100) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed';
	END IF;
 	RETURN return_message;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_test_is_receptor_id_available_on_zoomlevel
 * ---------------------------------------------
 * This test consists of two parts.
 * The first part tests whether the function confirms that three receptors, of which we know the are avaiable on zoomlevel 5, indeed are
 * available on zoomlevel 5.
 * The second part checks if the hexagons that are available at a certain zoomlevel also get a positive from the function.
 */
CREATE OR REPLACE FUNCTION setup.ae_test_is_receptor_id_available_on_zoomlevel()
	RETURNS text AS
$BODY$
DECLARE
	-- Three receptors from which we know they are available on zoomlevel 5:
	input_1 int = 1;
	input_2 int = 33;
	input_3 int = 48929;

	-- Finally some dummy variables
	rec_id_test int;
	zoomlevel_test posint;
	succes_counter int = 0;
	test_part_1 boolean = false;
	return_message text;
BEGIN
	--The first part of the test.
	IF (ae_is_receptor_id_available_on_zoomlevel(input_1, 5)
		AND ae_is_receptor_id_available_on_zoomlevel(input_2, 5)
		AND ae_is_receptor_id_available_on_zoomlevel(input_3, 5))
	THEN
		test_part_1 = true;
	END IF;

	--The second part of the test. The geometry_test table has 100 records, so the succes_counter must also reach 100.
	CREATE TEMPORARY TABLE tmp_geometry_test ON COMMIT DROP AS SELECT receptor_id, zoom_level FROM hexagons WHERE zoom_level = 1 ORDER BY random() LIMIT 20;
	INSERT INTO tmp_geometry_test SELECT receptor_id, zoom_level FROM hexagons WHERE zoom_level = 2 ORDER BY random() LIMIT 20;
	INSERT INTO tmp_geometry_test SELECT receptor_id, zoom_level FROM hexagons WHERE zoom_level = 3 ORDER BY random() LIMIT 20;
	INSERT INTO tmp_geometry_test SELECT receptor_id, zoom_level FROM hexagons WHERE zoom_level = 4 ORDER BY random() LIMIT 20;
	INSERT INTO tmp_geometry_test SELECT receptor_id, zoom_level FROM hexagons WHERE zoom_level = 5 ORDER BY random() LIMIT 20;

	FOR rec_id_test IN SELECT receptor_id FROM tmp_geometry_test LOOP
		zoomlevel_test	:= zoom_level FROM tmp_geometry_test WHERE receptor_id = rec_id_test LIMIT 1;
		IF (ae_is_receptor_id_available_on_zoomlevel(rec_id_test, zoomlevel_test)) THEN
			succes_counter = succes_counter + 1;
		END IF;
	END LOOP;

	IF (test_part_1 AND succes_counter = 100) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed';
	END IF;
	RETURN return_message;
	DROP TABLE tmp_geometry_test;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_test_determine_coordinates_from_receptor_id
 * ----------------------------------------------
 * This test first gets a random receptor from the database and get its coordinates according to postgis. Next, the function is called
 * and checked if it returns the same coordinates.
 */
CREATE OR REPLACE FUNCTION setup.ae_test_determine_coordinates_from_receptor_id()
	RETURNS text AS
$BODY$
DECLARE
	-- Some dummy variables
	loop_iterator int := 0;
	succes_counter int := 0;
	receptor_id_in_database int;
	geometry_in_database geometry;

	return_message text;
BEGIN
	WHILE (loop_iterator < 100) LOOP
		receptor_id_in_database := receptor_id FROM receptors ORDER BY random() LIMIT 1;
		geometry_in_database 	:= geometry FROM receptors WHERE receptor_id = receptor_id_in_database;

		IF (ae_determine_coordinates_from_receptor_id(receptor_id_in_database) = geometry_in_database) THEN
			succes_counter = succes_counter + 1;
		END IF;
		loop_iterator = loop_iterator + 1;
	END LOOP;

	IF (succes_counter = 100) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed';
	END IF;
	RETURN return_message;

END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_test_determine_receptor_ids_from_receptor_between_radii
 * ----------------------------------------------------------
 * This test checks if the set of receptors given by the function lies comletely within a bounding box around the radius.
 */
CREATE OR REPLACE FUNCTION setup.ae_test_determine_receptor_ids_from_receptor_between_radii()
	RETURNS text AS
$BODY$
DECLARE
	-- Some dummy variables
	radius_hexagon double precision = 100 * sqrt(2 / (3 * sqrt(3)));
	height_hexagon double precision = radius_hexagon * sqrt(3);

	loop_iterator int = 0;
	succes_counter int = 0;

	max_receptor_id int = 9462980;
	max_radius int = 500;
	receptor_id_input int;
	inner_radius int;
	outer_radius int;

	coordinates_of_receptor geometry;
	point_low_left geometry;
	point_up_right geometry;
	bounding_box geometry;

	number_of_distinct_rows int;
	return_message text;
BEGIN
	WHILE (loop_iterator < 100) LOOP

		receptor_id_input	:= receptor_id FROM receptors ORDER BY random() LIMIT 1;
		inner_radius 		:= 1 + (round(max_radius * random()))::int;
		outer_radius		:= inner_radius + 20;
		coordinates_of_receptor	:= ae_determine_coordinates_from_receptor_id(receptor_id_input);

		-- The points to create the bounding box, the bounding box itself and a table with the receptors within the bounding box.
		point_low_left	:= ST_MakePoint(ST_X(coordinates_of_receptor) - radius_hexagon * outer_radius * 3 / 2.0 - 1, ST_Y(coordinates_of_receptor) - height_hexagon * outer_radius - 1);
		point_up_right	:= ST_MakePoint(ST_X(coordinates_of_receptor) + radius_hexagon * outer_radius * 3 / 2.0 + 1, ST_Y(coordinates_of_receptor) + height_hexagon * outer_radius + 1);
		bounding_box	:= ST_SetSRID(ST_MakeBox2D(point_low_left, point_up_right), ae_get_srid());
		CREATE TEMPORARY TABLE tmp_postgis_receptor_ids ON COMMIT DROP AS SELECT receptor_id FROM receptors WHERE ST_Within(receptors.geometry, bounding_box);

		-- A table is made which consists of all receptors that are in tmp_calculated_receptor_ids but not in tmp_postgis_receptor_ids and we count the number of rows in it.
		CREATE TEMPORARY TABLE tmp_distinct_receptor_ids ON COMMIT DROP AS
				SELECT *
				FROM tmp_postgis_receptor_ids
				FULL OUTER JOIN tmp_calculated_receptor_ids ON (tmp_postgis_receptor_ids.receptor_id = tmp_calculated_receptor_ids.receptor_id_calc)
				WHERE tmp_postgis_receptor_ids.receptor_id IS NULL;
		number_of_distinct_rows = count(*) FROM tmp_distinct_receptor_ids;

		-- Succes when there are no number of rows outside of the bounding box
		IF (number_of_distinct_rows = 0) THEN
			succes_counter = succes_counter + 1;
		END IF;
		loop_iterator = loop_iterator + 1;

		DROP TABLE tmp_postgis_receptor_ids;
		DROP TABLE tmp_calculated_receptor_ids;
		DROP TABLE tmp_distinct_receptor_ids;

	END LOOP;

	IF (succes_counter = 100) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed';
	END IF;
	RETURN return_message;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_test_determine_receptor_ids_from_receptor_to_offset
 * ----------------------------------------------------------
 * This test checks if the receptors in of the function ae_determine_receptor_ids_from_receptor_between_radius_and_offs are the same as the receptors in a large table from
 * all receptors around a base receptor .
 */
CREATE OR REPLACE FUNCTION setup.ae_test_determine_receptor_ids_from_receptor_to_offset(only_within_n2k_area boolean)
	RETURNS text AS
$BODY$
DECLARE
	-- Some dummy variables
	radius_hexagon double precision = 100 * sqrt(2 / (3 * sqrt(3)));
	height_hexagon double precision = radius_hexagon * sqrt(3);

	loop_iterator_checks int = 0;
	loop_iterator_blocks int = 0;
	number_of_checks int = 20;
	succes_counter int = 0;

	receptor_id_input int;
	receptor_id_output int = 0;
	receptor_id_input_2 int;
	inner_radius int;
	outer_radius int;

	nr_of_records int;
	nr_of_blocks int;
	block_size int = 250;
	offs int;
	limi int;

	number_of_distinct_rows int;
	return_message text;
BEGIN
	WHILE (loop_iterator_checks < number_of_checks) LOOP

		loop_iterator_blocks := 0;
		number_of_distinct_rows := 0;
		receptor_id_input := receptor_id FROM receptors ORDER BY random() LIMIT 1;
		receptor_id_input_2 := receptor_id_input;
		inner_radius := 0;
		outer_radius := 50;

		-- Create a table with all receptor in the hexagon with radius 100
		CREATE TEMPORARY TABLE tmp_receptors_in_hexagon_with_radius ON COMMIT DROP AS SELECT receptor_id FROM ae_determine_receptor_ids_from_receptor_between_radii(only_within_n2k_area, receptor_id_input, inner_radius, outer_radius);
		nr_of_records := count(*) FROM tmp_receptors_in_hexagon_with_radius;
		nr_of_blocks := nr_of_records / block_size;

		WHILE (loop_iterator_blocks < nr_of_blocks) LOOP
			offs := block_size * loop_iterator_blocks;
			limi := block_size;
			CREATE TEMPORARY TABLE tmp_receptors_in_block_with_radius ON COMMIT DROP AS SELECT receptor_id AS receptor_id_in_block FROM tmp_receptors_in_hexagon_with_radius OFFSET offs LIMIT limi;
 			CREATE TEMPORARY TABLE tmp_receptors_in_func_with_radius ON COMMIT DROP AS SELECT receptor_id AS receptor_id_in_func FROM ae_determine_receptor_ids_from_receptor_between_radius_and_offs(receptor_id_input, receptor_id_input_2, block_size, only_within_n2k_area);

			-- A table is made which consists of all receptors that are in tmp_calculated_receptor_ids but not in tmp_postgis_receptor_ids and we count the number of rows in it.
			CREATE TEMPORARY TABLE tmp_distinct_receptor_ids ON COMMIT DROP AS
				SELECT *
				FROM tmp_receptors_in_block_with_radius
				FULL OUTER JOIN tmp_receptors_in_func_with_radius ON (tmp_receptors_in_block_with_radius.receptor_id_in_block = tmp_receptors_in_func_with_radius.receptor_id_in_func);

			receptor_id_input_2 := receptor_id_in_func FROM tmp_receptors_in_func_with_radius OFFSET (block_size - 1);
 			number_of_distinct_rows = number_of_distinct_rows - block_size + count(*) FROM tmp_distinct_receptor_ids;
 			DROP TABLE tmp_receptors_in_block_with_radius;
 			DROP TABLE tmp_receptors_in_func_with_radius;
 			DROP TABLE tmp_distinct_receptor_ids;
			loop_iterator_blocks = loop_iterator_blocks + 1;
		END LOOP;
		-- Succes when there are no number of rows outside of the bounding box
		IF (number_of_distinct_rows = 0) THEN
			succes_counter = succes_counter + 1;
		ELSE
			receptor_id_output = receptor_id_input;
		END IF;
		loop_iterator_checks = loop_iterator_checks + 1;
		DROP TABLE tmp_receptors_in_hexagon_with_radius;
	END LOOP;

	IF (succes_counter = number_of_checks) THEN
		return_message = 'Succes';
	ELSE
		return_message = 'Failed' || receptor_id_output;
	END IF;
	RETURN return_message;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;
