/*
 * ae_sites_distance_to_assessment_area
 * ------------------------------------
 * Geeft de afstand van een toetsgebied tot de verschillende sites, gesorteerd op distance.
 * Gebruik 'assessment_area_id' in de WHERE-clause.
 *
 * Sneller dan een view door gebruik van gelimiteerde set van combinaties gebaseerd op een benadering van de afstand.
 * Van die set worden de preciese afstanden bepaald, waarna deze gesorteerd worden teruggegeven.
 * Hoe groter het gebied hoe trager (bij test met limiet van 100: binnenveld ~90ms, veluwe ~22000ms).
 * Let op: IMMUTABLE verandert naar STABLE. Performed het nog steeds?
 */
CREATE OR REPLACE FUNCTION ae_sites_distance_to_assessment_area(v_assessment_area_id integer, v_limit integer, v_offset integer, v_is_priority_project boolean )
	RETURNS TABLE(assessement_area_id integer, site_id integer, distance double precision) AS
$BODY$
DECLARE
	assessment_area_geometry geometry;
BEGIN
	assessment_area_geometry := ST_Simplify(geometry, 1) FROM assessment_areas WHERE assessment_areas.assessment_area_id = v_assessment_area_id;

	RETURN QUERY
		WITH index_query AS (
			SELECT
				assessment_areas.assessment_area_id,
				site_generated_properties_view.site_id,
				ST_Distance(site_generated_properties_view.geometry, assessment_areas.geometry) AS distance

				FROM site_generated_properties_view
					CROSS JOIN assessment_areas

				WHERE
					assessment_areas.assessment_area_id = v_assessment_area_id
					AND site_generated_properties_view.is_priority_project = v_is_priority_project

				ORDER BY site_generated_properties_view.geometry <#> assessment_area_geometry
				LIMIT GREATEST(5000, (v_offset + v_limit) * 10)
		)
		SELECT * FROM index_query

			ORDER BY distance, site_id
			LIMIT v_limit OFFSET v_offset;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
