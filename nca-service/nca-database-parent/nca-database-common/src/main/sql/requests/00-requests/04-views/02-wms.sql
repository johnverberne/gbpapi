/*
 * wms_permit_demands_view
 * -----------------------
 * WMS view voor request_demands_view voor permits.
 * Roep aan met een permit_id in de WHERE clause.
 * Toont alleen receptoren waar daadwerkelijk sprake is van OR is.
 */
CREATE OR REPLACE VIEW wms_permit_demands_view AS
SELECT
	request_id,
	receptor_id,
	development_space_demand,
	zoom_level,
	geometry

	FROM request_demands_view
		INNER JOIN hexagons USING (receptor_id)
		INNER JOIN reserved_development_spaces USING (receptor_id)
		
		WHERE segment = 'projects'
;
