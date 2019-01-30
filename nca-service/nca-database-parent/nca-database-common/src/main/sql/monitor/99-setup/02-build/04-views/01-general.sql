/*
 * build_site_generated_properties_view
 * ------------------------------------
 * View om de site_generated_properties tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_site_generated_properties_view AS
SELECT
	site_id,
	sector_id,
	number_of_sources,
	geometry

	FROM (
		-- Number of source and site geometry
		SELECT
			site_id,
			COUNT(*) AS number_of_sources,
			ST_ConvexHull(ST_Collect(geometry)) AS geometry

			FROM non_aggregated_sources_view

			GROUP BY site_id
		) AS sources_agg

		-- Top sector ranked by number of source per site and sector
		INNER JOIN (
			SELECT site_id, sector_id, rank()
				OVER (PARTITION BY site_id ORDER BY COUNT(source_id) DESC, sector_id)

				FROM non_aggregated_sources_view

				GROUP BY site_id, sector_id
			) AS sector_agg USING (site_id)

		WHERE
			rank = 1
			AND number_of_sources > 0
;
