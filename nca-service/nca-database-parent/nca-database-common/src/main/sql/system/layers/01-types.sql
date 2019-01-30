/*
 * layer_legend_type
 * -----------------
 * layer_legend_type wordt gebruikt om aan te geven welk type een legenda is.
 */
CREATE TYPE system.layer_legend_type AS ENUM
	('circle', 'hexagon', 'text');

/*
 * layer_type
 * ----------
 * layer_type wordt gebruikt om aan te geven welk type een layer (laag) is.
 */
CREATE TYPE system.layer_type AS ENUM
	('wms', 'tms');

/*
 * dynamic_wms_layer_type
 * ----------------------
 * dynamic_wms_layer_type wordt gebruikt om aan te geven wat voor soort dynamisch type een wms layer (laag) is.
 */
CREATE TYPE system.dynamic_wms_layer_type AS ENUM
	('year', 'sector', 'habitat_type', 'data_range');
