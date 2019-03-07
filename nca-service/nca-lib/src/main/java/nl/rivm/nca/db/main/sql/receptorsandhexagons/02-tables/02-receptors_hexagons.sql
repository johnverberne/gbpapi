/*
 * receptors
 * ---------
 * Receptoren (rekenpunten)
 * Receptoren representeren het zwaartepunt van hun bijbehorende hexagonen.
 */
CREATE TABLE receptors (
	receptor_id integer NOT NULL,
	geometry geometry(Point),

	CONSTRAINT receptors_pkey PRIMARY KEY (receptor_id)
);

CREATE INDEX idx_receptors_geometry_gist ON receptors USING GIST (geometry);


/*
 * hexagons
 * --------
 * De hexagonen (incl. geometrie) behorende bij de receptoren.
 * De hexagonen zijn zeshoeken welke dienen als het representatiegebied van een receptor bij een bepaald zoom level.
 * Op zoom level 1 is de oppervlakte een hectare. Bij hogere zoom levels worden hexagonen geaggregeerd.
 */
CREATE TABLE hexagons (
	receptor_id integer NOT NULL,
	zoom_level posint NOT NULL,
	geometry geometry(Polygon),

	CONSTRAINT hexagons_pkey PRIMARY KEY (receptor_id, zoom_level),
	CONSTRAINT hexagons_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX idx_hexagons_geometry_gist ON hexagons USING GIST (geometry);
CREATE INDEX idx_hexagons_zoom_level ON hexagons (zoom_level);

