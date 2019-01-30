/*
 * wms_available_development_spaces_view
 * -------------------------------------
 * WMS view voor available_development_spaces_view.
 */
CREATE OR REPLACE VIEW wms_available_development_spaces_view AS
SELECT
	segment,
	receptor_id,
	available_after_assigned AS available_development_space,
	zoom_level,
	geometry

	FROM available_development_spaces_view
		INNER JOIN hexagons USING (receptor_id)
;
