/*
 * wms_hexagons_view
 * ---------
 * View voor de buitenwereld van hexagonen uit AERIUS op zoomlevel 1
 */
CREATE OR REPLACE VIEW wms_hexagons_view AS 
SELECT 
	* 
	FROM hexagons 
	WHERE zoom_level= 1
;

