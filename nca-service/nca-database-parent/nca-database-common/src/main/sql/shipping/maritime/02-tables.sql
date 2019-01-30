/*
 * shipping_maritime_nodes
 * -----------------------
 * De nodes in het zeescheepvaart netwerk.
 * @column snappable geeft aan of de node gebruikt kan worden door gebruikers om hun route aan te haken.
 */
CREATE TABLE shipping_maritime_nodes
(
	shipping_node_id integer NOT NULL,
	snappable boolean NOT NULL,
	geometry geometry(Point),

	CONSTRAINT shipping_maritime_nodes_pkey PRIMARY KEY (shipping_node_id)
);

CREATE INDEX idx_shipping_maritime_nodes_geometry_gist ON shipping_maritime_nodes USING GIST (geometry);


/*
 * shipping_maritime_maneuver_areas
 * --------------------------------
 * Manouvreer gebieden (bijv. sluizen) voor zeescheepvaart.
 * De manouvreer factor moet hierbij voor de emissies binnen het gebied gebruikt worden.
 * Mocht het manouvreer gedeelte van een route door zo'n gebied gaan, dan geldt de hoogste waarde als factor welke gebruikt moet worden.
 */
CREATE TABLE shipping_maritime_maneuver_areas
(
	shipping_maritime_maneuver_area_id integer NOT NULL,
	maneuver_factor posreal NOT NULL,
	geometry geometry(Polygon),

	CONSTRAINT shipping_maritime_maneuver_areas_pkey PRIMARY KEY (shipping_maritime_maneuver_area_id)
);

CREATE INDEX idx_shipping_maritime_maneuver_areas_geometry_gist ON shipping_maritime_maneuver_areas USING GIST (geometry);
