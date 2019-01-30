/*
 * wms_depositions_jurisdiction_policies_view
 * ------------------------------------------
 * WMS visualisatie van wms_depositions_jurisdiction_policies_view.
 */
CREATE OR REPLACE VIEW wms_depositions_jurisdiction_policies_view AS
SELECT
	depositions_jurisdiction_policies.year,
	depositions_jurisdiction_policies.receptor_id,
	hexagons.zoom_level,
	depositions_jurisdiction_policies.total_deposition AS deposition,
	hexagons.geometry

	FROM depositions_jurisdiction_policies
		INNER JOIN hexagons USING (receptor_id)
;