/*
 * road_emission_factors_interpolation_years_view
 * ----------------------------------------------
 * Deze view retourneert voor alle jaren het begin- en eind-jaar welke gebruikt kunnen worden
 * voor het interpoleren van de wegemissiefactoren.
 * De begin- en eind-jaren worden geselecteerd uit de road_category_emission_factors tabel. De begin- en eind-jaren worden
 * voor iedere key uit die tabel opnieuw bepaald en teruggegeven.
 */
CREATE OR REPLACE VIEW road_emission_factors_interpolation_years_view AS
SELECT
	road_category_id,
	road_speed_profile_id,
	substance_id,
	all_years.year,
	MAX(begin_years.year) AS begin_year,
	MIN(end_years.year) AS end_year

	FROM
		(SELECT
			road_category_id,
			road_speed_profile_id,
			substance_id,
			generate_series(min_year, max_year)::year_type AS year

			FROM 
				(SELECT road_category_id, road_speed_profile_id, substance_id, MIN(year)::integer AS min_year
					FROM road_category_emission_factors
					GROUP BY road_category_id, road_speed_profile_id, substance_id
				) AS min_years
				
				INNER JOIN 
					(SELECT road_category_id, road_speed_profile_id, substance_id, MAX(year)::integer AS max_year
						FROM road_category_emission_factors
						GROUP BY road_category_id, road_speed_profile_id, substance_id
					) AS max_years USING (road_category_id, road_speed_profile_id, substance_id)
				
		) AS all_years

		INNER JOIN (SELECT road_category_id, road_speed_profile_id, substance_id, year FROM road_category_emission_factors) AS begin_years USING (road_category_id, road_speed_profile_id, substance_id)
		INNER JOIN (SELECT road_category_id, road_speed_profile_id, substance_id, year FROM road_category_emission_factors) AS end_years USING (road_category_id, road_speed_profile_id, substance_id)

	WHERE
		begin_years.year <= all_years.year 
		AND end_years.year >= all_years.year

	GROUP BY road_category_id, road_speed_profile_id, substance_id, all_years.year

	ORDER BY road_category_id, road_speed_profile_id, substance_id, all_years.year
;


/*
 * road_emission_factors_interpolated_view
 * ---------------------------------------
 * De wegemissiefactoren (road_category_emission_factors) waarvan alle ontbrekende tussenliggende rekenjaren worden geinterpoleerd.
 */
CREATE OR REPLACE VIEW road_emission_factors_interpolated_view AS
SELECT
	road_emission_factors_interpolation_years_view.road_category_id,
	road_emission_factors_interpolation_years_view.road_speed_profile_id,
	road_emission_factors_interpolation_years_view.year,
	road_emission_factors_interpolation_years_view.substance_id,
	ae_linear_interpolate(
			road_emission_factors_interpolation_years_view.begin_year,
			road_emission_factors_interpolation_years_view.end_year,
			road_emission_factors_begin.emission_factor,
			road_emission_factors_end.emission_factor,
			road_emission_factors_interpolation_years_view.year
		)::double precision AS emission_factor,
	ae_linear_interpolate(
			road_emission_factors_interpolation_years_view.begin_year,
			road_emission_factors_interpolation_years_view.end_year,
			road_emission_factors_begin.stagnated_emission_factor,
			road_emission_factors_end.stagnated_emission_factor,
			road_emission_factors_interpolation_years_view.year
		)::double precision AS stagnated_emission_factor

	FROM road_emission_factors_interpolation_years_view
		INNER JOIN road_category_emission_factors AS road_emission_factors_begin ON
			road_emission_factors_begin.road_category_id = road_emission_factors_interpolation_years_view.road_category_id
			AND road_emission_factors_begin.road_speed_profile_id = road_emission_factors_interpolation_years_view.road_speed_profile_id
			AND road_emission_factors_begin.substance_id = road_emission_factors_interpolation_years_view.substance_id
			AND road_emission_factors_begin.year = road_emission_factors_interpolation_years_view.begin_year
		INNER JOIN road_category_emission_factors AS road_emission_factors_end ON
			road_emission_factors_end.road_category_id = road_emission_factors_interpolation_years_view.road_category_id
			AND road_emission_factors_end.road_speed_profile_id = road_emission_factors_interpolation_years_view.road_speed_profile_id
			AND road_emission_factors_end.substance_id = road_emission_factors_interpolation_years_view.substance_id
			AND road_emission_factors_end.year = road_emission_factors_interpolation_years_view.end_year
;


/*
 * road_categories_view
 * --------------------
 * View retourneert de categorieen voor wegen. Dit bevat onder andere de emissiefactoren en stagnatiefactoren.
 * Zie road_categories en road_category_emission_factors voor meer informatie.
 *
 */
CREATE OR REPLACE VIEW road_categories_view AS
SELECT
	road_category_id,
	vehicle_type || '_' || road_categories.road_type AS code,
	road_categories.name AS name,
	vehicle_type,
	road_categories.road_type,
	gcn_sector_id,
	road_speed_profile_id,
	speed_limit_enforcement,
	maximum_speed,
	road_speed_profiles.name AS road_speed_profile_name,
	year,
	substance_id,
	emission_factor,
	stagnated_emission_factor

	FROM road_categories
		INNER JOIN road_emission_factors_interpolated_view USING (road_category_id)
		INNER JOIN road_speed_profiles USING (road_speed_profile_id)

	ORDER BY road_category_id
;
