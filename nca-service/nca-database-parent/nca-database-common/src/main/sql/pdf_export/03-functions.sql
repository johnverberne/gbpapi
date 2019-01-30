/*
 * ae_development_rule_checks_assessment_areas
 * -------------------------------------------
 * Bepaal de uitkomsten van alle beleidsregels voor het opgegeven segment geaggregeerd per toetsgebied.
 * Met de booelan with_demand kan aangegeven worden of de development_space_demand meegenomen moet worden (TRUE) of dat deze al in de OR opgenomen is (FALSE).
 * Indien 1 receptor niet slaagt voor de regel, dan het hele gebied niet.
 */
CREATE OR REPLACE FUNCTION ae_development_rule_checks_assessment_areas(proposed_calculation_id integer, current_calculation_id integer, segment segment_type, with_demand boolean)
	RETURNS TABLE(assessment_area_id integer, rule development_rule_type, passed boolean) AS
$BODY$
SELECT
	assessment_area_id,
	rule,
	bool_and(COALESCE(passed, TRUE)) AS passed_rule

	FROM ae_development_rule_checks(proposed_calculation_id, current_calculation_id, segment, with_demand)
		INNER JOIN receptors_to_assessment_areas USING (receptor_id)
	GROUP BY assessment_area_id, rule
;
$BODY$
LANGUAGE sql VOLATILE;


/*
 * ae_development_rule_checks_habitats
 * -----------------------------------
 * Bepaal de uitkomsten van alle beleidsregels voor het opgegeven segment geaggregeerd per toetsgebied en habitat type.
 * Met de booelan with_demand kan aangegeven worden of de development_space_demand meegenomen moet worden (TRUE) of dat deze al in de OR opgenomen is (FALSE).
 * Indien 1 receptor niet slaagt voor de regel, dan het hele gebied niet.
 */
CREATE OR REPLACE FUNCTION ae_development_rule_checks_habitats(proposed_calculation_id integer, current_calculation_id integer, segment segment_type, with_demand boolean)
	RETURNS TABLE(assessment_area_id integer, habitat_type_id integer, rule development_rule_type, passed boolean) AS
$BODY$
SELECT
	assessment_area_id,
	habitat_type_id,
	rule,
	bool_and(COALESCE(passed, TRUE)) AS passed_rule

	FROM ae_development_rule_checks(proposed_calculation_id, current_calculation_id, segment, with_demand)
		INNER JOIN receptors_to_relevant_habitats_view USING (receptor_id)
	GROUP BY assessment_area_id, habitat_type_id, rule
;
$BODY$
LANGUAGE sql VOLATILE;


/*
 * ae_determine_pages_for_geometry
 * -------------------------------
 * Determines 'pages' to use when showing a geometry in a PDF.
 */
CREATE OR REPLACE FUNCTION ae_determine_pages_for_geometry(geom geometry, page_width float, page_height float)
	RETURNS SETOF geometry AS
$BODY$
DECLARE
	width_geom_extent float;
	height_geom_extent float;
	width_portrait float;
	height_portrait float;
	width_landscape float;
	height_landscape float;

	actual_page_width float;
	actual_page_height float;
	page geometry;
	return_geom geometry;
	current_x float;
	current_y float;
	min_y float;
BEGIN
	width_geom_extent := GREATEST(ST_Xmax(geom) - ST_XMin(geom), 1);
	height_geom_extent := GREATEST(ST_Ymax(geom) - ST_YMin(geom), 1);

	width_portrait := ceil(width_geom_extent / page_width) * page_width;
	height_portrait := ceil(height_geom_extent / page_height) * page_height;

	width_landscape := ceil(width_geom_extent / page_height) * page_height;
	height_landscape := ceil(height_geom_extent / page_width) * page_width;

	IF width_portrait * height_portrait > width_landscape * height_landscape THEN
		--use landscape
		actual_page_width := page_height;
		actual_page_height := page_width;
		--center around the geometry
		current_x := ST_Xmin(geom) - ((width_landscape - width_geom_extent) / 2);
		current_y := ST_Ymin(geom) - ((height_landscape - height_geom_extent) / 2);
	ELSE
		--use portrait
		actual_page_width := page_width;
		actual_page_height := page_height;
		--center around the geometry.
		current_x := ST_Xmin(geom) - ((width_portrait - width_geom_extent) / 2);
		current_y := ST_Ymin(geom) - ((height_portrait - height_geom_extent) / 2);
	END IF;

	--ensure we keep using the same starting point for y coordinate
	min_y := current_y;

	--create the base 'page' to translate to the right position each time.
	page := ST_SetSRID(ST_MakeBox2D(ST_MakePoint(0, 0), ST_MakePoint(actual_page_width, actual_page_height)), ae_get_srid());

	WHILE current_x < ST_Xmax(geom) LOOP
		WHILE current_y < ST_Ymax(geom) LOOP
			return_geom := ST_Translate(page, current_x, current_y);
			--skip any 'pages' without content.
			IF ST_Intersects(geom, return_geom) THEN
				RETURN NEXT return_geom;
			END IF;
			--next column
			current_y := current_y + actual_page_height;
		END LOOP;
		--next row.
		current_x := current_x + actual_page_width;
		--reset column
		current_y := min_y;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_calculation_detail_pages_pdf_export
 * --------------------------------------
 * Bepaalt de extents te gebruiken voor detailkaarten in een PDF export.
 */
CREATE OR REPLACE FUNCTION ae_calculation_detail_pages_pdf_export(v_proposed_calculation_id integer, v_current_calculation_id integer, v_page_width float, v_page_height float)
	RETURNS TABLE(geometry geometry) AS
$BODY$
	SELECT ae_determine_pages_for_geometry(ST_Union(geometry), v_page_width, v_page_height) AS extents

		FROM development_space_demands
			INNER JOIN receptors USING (receptor_id)

		WHERE proposed_calculation_id = v_proposed_calculation_id AND current_calculation_id = COALESCE(v_current_calculation_id, 0)
;
$BODY$
LANGUAGE sql STABLE;