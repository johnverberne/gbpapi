/*
 * ae_relevant_habitat_points_of_interest_by_source_collection
 * -----------------------------------------------------------
 * Functie retourneert per natura2000- en habitat-gebied combinatie het dichtsbijzijnde punt (de points of interest) gezien de opgegeven
 * bronnen (sourceCollection) en binnen de opgegeven radius (withinRadius).
 */
CREATE OR REPLACE FUNCTION ae_relevant_habitat_points_of_interest_by_source_collection(sourceCollection geometry, withinRadius integer)
	RETURNS TABLE(assessment_area_id integer, habitat_type_id integer, assessment_area_name text, habitat_name text, distance double precision, geometry geometry) AS
$BODY$
	SELECT
		assessment_area_id,
		habitat_type_id,
		assessment_areas.name AS assessment_area_name,
		habitat_types.name AS habitat_name,
		ST_Distance(relevant_habitats.geometry, ST_ConvexHull($1)) AS distance,
		ST_ClosestPoint(relevant_habitats.geometry, ST_ConvexHull($1)) AS geometry

		FROM relevant_habitats
			INNER JOIN habitat_types USING (habitat_type_id)
			INNER JOIN assessment_areas USING (assessment_area_id)

		WHERE ST_Intersects(relevant_habitats.geometry, ST_Buffer(ST_ConvexHull($1), $2))
$BODY$
LANGUAGE sql STABLE;


/*
 * ae_assessment_area_points_of_interest_by_source_collection
 * ----------------------------------------------------------
 * Functie retourneert per natura2000 gebied het dichtsbijzijnde punt (de points of interest) gezien de opgegeven bronnen (sourceCollection)
 * en binnen de opgegeven radius (withinRadius).
 */
CREATE OR REPLACE FUNCTION ae_assessment_area_points_of_interest_by_source_collection(sourceCollection geometry, withinRadius integer)
	RETURNS TABLE(assessment_area_id integer, assessment_area_name text, distance double precision, geometry geometry) AS
$BODY$
	SELECT
		assessment_areas.assessment_area_id,
		assessment_areas.name AS assessment_area_name,
		ST_Distance(assessment_areas.geometry, ST_ConvexHull($1)) AS distance,
		ST_ClosestPoint(assessment_areas.geometry, ST_ConvexHull($1)) AS geometry

		FROM assessment_areas
		WHERE
			ST_Intersects(geometry, ST_Buffer(ST_ConvexHull($1), $2))
			AND assessment_areas.type = 'natura2000_area'
$BODY$
LANGUAGE sql STABLE;