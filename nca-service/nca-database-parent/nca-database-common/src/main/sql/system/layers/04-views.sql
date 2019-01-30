/*
 * layers_view
 * -----------
 * View die alle systeem properties voor een sector bij elkaar schraapt en retourneert.
 */
CREATE OR REPLACE VIEW system.layers_view AS
SELECT
	layer_id,
	layer_properties_id,
	layer_type,
	name,
	title,
	attribution,
	opacity,
	enabled,
	layer_legend_id,
	min_scale,
	max_scale,
	
	base_url,
	image_type,
	service_version,
	
	NULL AS layer_capabilities_id,
	NULL AS url,
	NULL AS sld_url,
	NULL AS begin_year,
	NULL AS end_year,
	NULL AS dynamic_type,
	NULL AS tile_size

	FROM system.layers
		INNER JOIN system.tms_layer_properties USING (layer_properties_id)
UNION ALL
SELECT
	layer_id,
	layer_properties_id,
	layer_type,
	name,
	title,
	attribution,
	opacity,
	enabled,
	layer_legend_id,
	min_scale,
	max_scale,
	
	NULL AS base_url,
	NULL AS image_type,
	NULL AS service_version,
	
	layer_capabilities_id,
	url,
	sld_url,
	begin_year,
	end_year,
	dynamic_type,
	tile_size

	FROM system.layers
		INNER JOIN system.wms_layer_properties USING (layer_properties_id)
		INNER JOIN system.layer_capabilities USING (layer_capabilities_id)
;
