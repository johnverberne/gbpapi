/*
 * shipping_inland_waterway_categories
 * -----------------------------------
 * Alle type vaarwegen in het scheepvaart netwerk voor binnenvaart.
 * Voor sommige types is de stroming van de vaarweg van belang, dit wordt hier ook aangegeven.
 */
CREATE TABLE shipping_inland_waterway_categories
(
	shipping_inland_waterway_category_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,
	flowing boolean NOT NULL,

	CONSTRAINT shipping_inland_waterway_categories_pkey PRIMARY KEY (shipping_inland_waterway_category_id)
);

/*
 * shipping_inland_waterways
 * -------------------------
 * Alle originele vaarwegen in het scheepvaart netwerk voor binnenvaart.
 * Stroming kan (maar hoeft niet) van belang zijn op de waterweg (wat betreft de emissiefactoren). Dit hangt vast aan het type vaarweg.
 * Wanneer er stroming staat wordt ervanuit gegaan dat de geometry met de stroomrichting mee is ingevuld.
 * (als voorbeeld de waal: beginpunt lijn ligt in Duitsland, eindpunt ligt richting de noordzee)
 */
CREATE TABLE shipping_inland_waterways
(
	shipping_inland_waterway_id integer NOT NULL,
	shipping_inland_waterway_category_id integer NOT NULL,
	geometry geometry(LineString),

	CONSTRAINT shipping_inland_waterways_pkey PRIMARY KEY (shipping_inland_waterway_id),
	CONSTRAINT shipping_inland_waterways_fkey_categories FOREIGN KEY (shipping_inland_waterway_category_id) REFERENCES shipping_inland_waterway_categories
);

CREATE INDEX idx_shipping_inland_waterways_geometry_gist ON shipping_inland_waterways USING GIST (geometry);

/*
 * shipping_inland_locks
 * ---------------------
 * Alle sluizen in het netwerk.
 * Deze bevat de polygon waarbinnen de ophoogfactor van de sluis geldt.
 */
CREATE TABLE shipping_inland_locks
(
	shipping_inland_lock_id integer NOT NULL,
	lock_factor posreal NOT NULL,
	geometry geometry(Polygon),

	CONSTRAINT shipping_inland_locks_pkey PRIMARY KEY (shipping_inland_lock_id)
);

CREATE INDEX idx_shipping_inland_locks_geometry_gist ON shipping_inland_locks USING GIST (geometry);
