/*
 * shipping_maritime_emission_factors_view
 * ---------------------------------------
 * View retourneert de emissiefactoren voor zeescheep vaart.
 * Zie shipping_maritime_category_emission_factors en shipping_maritime_emission_trend_factors voor meer informatie.
 */
CREATE OR REPLACE VIEW shipping_maritime_emission_factors_view AS
SELECT
	shipping_maritime_category_id,
	year,
	substance_id,
	movement_type,
	emission_factor * trend_factor AS emission_factor

	FROM shipping_maritime_category_emission_factors
		INNER JOIN shipping_maritime_emission_trend_factors USING (substance_id, movement_type)
;


/*
 * shipping_maritime_source_characteristics_view
 * ---------------------------------------------
 * View retourneert de emissie karakteristieken voor zeescheep vaart.
 */
CREATE OR REPLACE VIEW shipping_maritime_source_characteristics_view AS
SELECT
	shipping_maritime_category_id,
	movement_type,
	gcn_sector_id,
	shipping_maritime_category_source_characteristics.heat_content,
	shipping_maritime_category_source_characteristics.height,
	shipping_maritime_category_source_characteristics.spread,
	emission_diurnal_variations.emission_diurnal_variation_id,
	emission_diurnal_variations.code AS emission_diurnal_variation_code

	FROM shipping_maritime_category_source_characteristics
		INNER JOIN default_gcn_sector_source_characteristics_view USING (gcn_sector_id)
		INNER JOIN emission_diurnal_variations USING (emission_diurnal_variation_id)
;
