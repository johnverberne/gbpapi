/*
 * plan_categories_source_characteristics_view
 * -------------------------------------------
 * View retourneert de categorieen voor plannen. Dit bevat onder andere de emissiefactoren en de emissie karakteristieken.
 * Zie plan_categories en plan_category_emission_factors voor meer informatie.
 */
CREATE OR REPLACE VIEW plan_categories_source_characteristics_view AS
SELECT
	plan_categories.plan_category_id,
	plan_categories.code,
	plan_categories.name,
	plan_categories.gcn_sector_id,
	gcn_sector_source_characteristics.substance_id,
	plan_categories.category_unit,
	plan_category_emission_factors.emission_factor,
	gcn_sector_source_characteristics.heat_content,
	gcn_sector_source_characteristics.height,
	gcn_sector_source_characteristics.spread,
	gcn_sector_source_characteristics.particle_size_distribution,
	emission_diurnal_variations.emission_diurnal_variation_id,
	emission_diurnal_variations.code AS emission_diurnal_variation_code

	FROM plan_categories
		INNER JOIN plan_category_emission_factors USING (plan_category_id)
		LEFT JOIN gcn_sector_source_characteristics USING (gcn_sector_id, substance_id)
		INNER JOIN emission_diurnal_variations USING (emission_diurnal_variation_id)

	ORDER BY plan_category_id
;
