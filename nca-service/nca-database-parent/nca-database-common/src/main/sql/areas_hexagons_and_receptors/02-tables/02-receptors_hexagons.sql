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


/*
 * included_receptors
 * ------------------
 * Een receptor wordt alleen meegenomen in de overzichten als het in deze tabel staat.
 * De receptor kan bijvoorbeeld ontbreken als deze te dicht bij een bron ligt waardoor de resultaten voor dit receptorpunt onjuist zijn
 * of in een niet relevant habitat gebied.
 */
CREATE TABLE included_receptors (
	receptor_id integer NOT NULL,

	CONSTRAINT included_receptors_pkey PRIMARY KEY (receptor_id),
	CONSTRAINT included_receptors_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * critical_depositions
 * --------------------
 * De kritische depositie waarde (KDW) per receptor.
 * Ieder KDW-gebied heeft een KDW. Voor het bepalen van de KDW per receptor wordt gekeken welke relevante KDW-gebieden binnen het toetsgebied
 * snijden met de hexagon behorende bij de receptor. Uit deze selectie wordt per receptor de laagste (=strengste) KDW waarde gebruikt, ongeacht grootte van het oppervlak.
 */
CREATE TABLE critical_depositions (
	receptor_id integer NOT NULL,
	critical_deposition posint NOT NULL CHECK (critical_deposition > 0),

	CONSTRAINT critical_depositions_pkey PRIMARY KEY (receptor_id),
	CONSTRAINT critical_depositions_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * terrain_properties
 * ------------------
 * De gemiddelde ruwheid en het dominante landgebruik per receptor en zoom-level.
 * Daarnaast is er een kolom met voor elk mogelijk landgebruiktype het relatieve aandeel per receptor.
 * Dit is een array met 9 posities. Het aantal van 9 is gelijk aan het aantal mogelijke waarden van de land_use_classification enum.
 * Alle waarden in deze tabel zijn bepaald binnen het gebied van de hexagon (zoomlevel 1) die bij het receptorpunt hoort.
 * Ruwheid is in meters, dominant landgebruik is een waarde uit een enumeratie.
 */
CREATE TABLE terrain_properties (
	receptor_id integer NOT NULL,
	zoom_level integer NOT NULL,
	average_roughness real NOT NULL,
	dominant_land_use land_use_classification NOT NULL,
	land_uses integer ARRAY[9] NOT NULL,

	CONSTRAINT terrain_properties_pkey PRIMARY KEY (receptor_id, zoom_level)
);
