/*
 * search_widget_results_view
 * --------------------------
 * Geeft een lijst terug van id's en namen, welke een mix is van gemeentes, provincies, plaatsen en postcode 4 gebieden,
 * en natuurgebieden (aangegeven met kolom 'type'), plus indien van toepassing de id's en namen van de natuurgebieden welke binnen 30 km van dat gebied liggen.
 * De daadwerkelijke afstand tussen het gebied en het natuurgebied wordt dan ook teruggegeven.
 */
CREATE OR REPLACE VIEW search_widget_results_view AS
SELECT
	search_results.id,
	search_results.name AS search_term,
	search_results.display_name,
	search_results.type,
	Box2D(search_results.geometry) AS boundingbox,
	assessment_area_id,
	assessment_areas.type AS assessment_area_type,
	assessment_areas.name AS assessment_area_name,
	Box2D(assessment_areas.geometry) AS assessment_area_boundingbox,
	search_results.distance

	FROM
		(SELECT
			province_area_id AS id,
			name,
			name AS display_name,
			'province_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM province_areas
				LEFT JOIN assessment_areas_to_province_areas USING (province_area_id)
		UNION ALL
		SELECT
			municipality_area_id AS id,
			name,
			name AS display_name,
			'municipality_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM municipality_areas
				LEFT JOIN assessment_areas_to_municipality_areas USING (municipality_area_id)
		UNION ALL
		SELECT
			town_area_id AS id,
			name,
			name AS display_name,
			'town_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM town_areas
				LEFT JOIN assessment_areas_to_town_areas USING (town_area_id)
		UNION ALL
		SELECT
			zip_code_area_id AS id,
			name,
			name || ' (' || town || ')' AS display_name,
			'zip_code_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM zip_code_areas
				LEFT JOIN assessment_areas_to_zip_code_areas USING (zip_code_area_id)
		UNION ALL
		SELECT
			natura2000_area_id AS id,
			name,
			name AS display_name,
			'natura2000_area'::search_area_type AS type,
			assessment_area_id,
			0,
			geometry

			FROM natura2000_areas
		)
		AS search_results
			LEFT JOIN assessment_areas USING (assessment_area_id)
;


/*
 * search_widget_sub_results_view
 * ------------------------------
 * Wordt aangeroepen bij het uitklappen van geocoder resultaten.
 * Gebruik een WHERE clause waarin het geocoder-punt intersect met de teruggegeven "geometry": WHERE ST_Intersects(point, geometry).
 * De teruggegeven "distance" is dan gebaseerd op de afstand tussen gebiedpolygon en natuurgebiedpolygon.
 * Filter ook op "area_type" (afhankelijk van wat wordt uitgeklapt) en maximum "distance".
 */
CREATE OR REPLACE VIEW search_widget_sub_results_view AS
SELECT
	areas.id AS area_id,
	areas.name AS area_name,
	areas.type AS area_type,
	assessment_areas.type AS assessment_area_type,
	assessment_area_id,
	assessment_areas.name AS assessment_area_name,
	Box2D(assessment_areas.geometry) AS assessment_area_boundingbox,
	areas.distance,
	areas.geometry

	FROM
		(SELECT
			province_area_id AS id,
			name,
			'province_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM assessment_areas_to_province_areas
				INNER JOIN province_areas USING (province_area_id)
		UNION ALL
		SELECT
			municipality_area_id AS id,
			name,
			'municipality_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM assessment_areas_to_municipality_areas
				INNER JOIN municipality_areas USING (municipality_area_id)
		UNION ALL
		SELECT
			town_area_id AS id,
			name,
			'town_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM assessment_areas_to_town_areas
				INNER JOIN town_areas USING (town_area_id)
		UNION ALL
		SELECT
			zip_code_area_id AS id,
			name,
			'zip_code_area'::search_area_type AS type,
			assessment_area_id,
			distance,
			geometry

			FROM assessment_areas_to_zip_code_areas
				INNER JOIN zip_code_areas USING (zip_code_area_id)
		)
		AS areas
			INNER JOIN assessment_areas USING (assessment_area_id)
;
