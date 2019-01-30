/*
 * wms_inland_shipping_routes
 * --------------------------
 * WMS visualisatie van alle vaarwegen en sluizen in het scheepvaart netwerk voor binnenvaart.
 */
CREATE OR REPLACE VIEW wms_inland_shipping_routes AS
SELECT
	'waterway'::text AS type,
	code,
	description AS label,
	NULL::integer AS lock_factor,
	ST_Multi(ST_Union(geometry)) AS geometry
	
	FROM shipping_inland_waterways
		INNER JOIN shipping_inland_waterway_categories USING (shipping_inland_waterway_category_id)

	GROUP BY code, description
UNION ALL
SELECT
	'lock'::text AS type,
	shipping_inland_lock_id::text AS code,
	lock_factor::text AS label,
	lock_factor,
	geometry

	FROM shipping_inland_locks
;
