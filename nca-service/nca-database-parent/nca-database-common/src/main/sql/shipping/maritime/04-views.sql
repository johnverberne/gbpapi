/*
 * wms_shipping_maritime_network_view
 * ----------------------------------
 * WMS visualisatie van shipping network. Retourneert zowel hoofdroutes als aanhaakpunten.
 *
 */
CREATE OR REPLACE VIEW wms_shipping_maritime_network_view AS
SELECT
	false AS is_line,
	geometry

	FROM shipping_maritime_nodes
	WHERE snappable = true 

;
