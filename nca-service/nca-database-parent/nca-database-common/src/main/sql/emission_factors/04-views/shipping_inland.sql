/*
 * shipping_inland_emission_factors_view
 * -------------------------------------
 * View retourneert de emissiefactoren voor zeescheep vaart.
 * Zie shipping_inland_category_emission_factors en shipping_inland_emission_trend_factors voor meer informatie.
 */
CREATE OR REPLACE VIEW shipping_inland_emission_factors_view AS
SELECT
	shipping_inland_category_id,
	year,
	substance_id,
	shipping_inland_waterway_category_id,
	ship_direction,
	laden_state,
	emission_factor * trend_factor AS emission_factor

	FROM shipping_inland_category_emission_factors
		INNER JOIN shipping_inland_emission_trend_factors USING (substance_id)
;


/*
 * shipping_inland_emission_factors_docked_view
 * --------------------------------------------
 * View retourneert de emissiefactoren voor zeescheep vaart.
 * Zie shipping_inland_category_emission_factors_docked en shipping_inland_category_emission_trend_factors_docked voor meer informatie.
 */
CREATE OR REPLACE VIEW shipping_inland_emission_factors_docked_view AS
SELECT
	shipping_inland_category_id,
	year,
	substance_id,
	emission_factor * trend_factor AS emission_factor

	FROM shipping_inland_category_emission_factors_docked
		INNER JOIN shipping_inland_category_emission_trend_factors_docked USING (shipping_inland_category_id, substance_id)

	WHERE laden_state = 'laden'
;

/*
 * shipping_inland_source_characteristics_view
 * -------------------------------------------
 * View retourneert de emissie karakteristieken voor routes voor binnenvaart.
 */
CREATE OR REPLACE VIEW shipping_inland_source_characteristics_view AS
SELECT
	shipping_inland_category_id,
	shipping_inland_waterway_category_id,
	ship_direction,
	laden_state,
	gcn_sector_id,
	shipping_inland_category_source_characteristics.heat_content,
	shipping_inland_category_source_characteristics.height,
	shipping_inland_category_source_characteristics.spread,
	emission_diurnal_variations.emission_diurnal_variation_id,
	emission_diurnal_variations.code AS emission_diurnal_variation_code

	FROM shipping_inland_category_source_characteristics
		INNER JOIN default_gcn_sector_source_characteristics_view USING (gcn_sector_id)
		INNER JOIN emission_diurnal_variations USING (emission_diurnal_variation_id)
;

/*
 * shipping_inland_source_characteristics_docked_view
 * --------------------------------------------------
 * View retourneert de emissie karakteristieken voor aanlegplaatsen voor binnenvaart.
 */
CREATE OR REPLACE VIEW shipping_inland_source_characteristics_docked_view AS
SELECT
	shipping_inland_category_id,
	laden_state,
	gcn_sector_id,
	shipping_inland_category_source_characteristics_docked.heat_content,
	shipping_inland_category_source_characteristics_docked.height,
	shipping_inland_category_source_characteristics_docked.spread,
	emission_diurnal_variations.emission_diurnal_variation_id,
	emission_diurnal_variations.code AS emission_diurnal_variation_code

	FROM shipping_inland_category_source_characteristics_docked
		INNER JOIN default_gcn_sector_source_characteristics_view USING (gcn_sector_id)
		INNER JOIN emission_diurnal_variations USING (emission_diurnal_variation_id)
;


/*
 * shipping_inland_waterway_categories_view
 * ----------------------------------------
 * View retourneert de waterweg categorieen.
 */
CREATE OR REPLACE VIEW shipping_inland_waterway_categories_view AS
SELECT DISTINCT 
	shipping_inland_waterway_category_id, 
	code, 
	name,
	ship_direction

	FROM shipping_inland_emission_factors_view 
		INNER JOIN shipping_inland_waterway_categories USING (shipping_inland_waterway_category_id)
	ORDER BY shipping_inland_waterway_category_id;
;
