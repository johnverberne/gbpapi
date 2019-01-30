/*
 * origins
 * -------
 * Bronhouder van de aangeleverde bron-data.
 */
CREATE TABLE origins (
	origin_id integer NOT NULL,
	name text NOT NULL,
	authority text,

	CONSTRAINT origins_pkey PRIMARY KEY (origin_id)
);


/*
 * sites
 * -----
 * Bronverzamelingen. Bij elkaar horende bronnen zijn bijv. voor landbouwbronnen
 * een boerderij met stallen, en voor industriebronnen een bedrijf met meerdere
 * schoorstenen. Deze bronnen liggen ook geografisch altijd bij elkaar.
 */
CREATE TABLE sites (
	site_id integer NOT NULL,
	name text NOT NULL,
	reference text NOT NULL,
	street_name text,
	number text,
	zip_code text,
	city text,
	description text,

	CONSTRAINT sites_pkey PRIMARY KEY (site_id)
);


/*
 * site_generated_properties
 * -------------------------
 * Extra eigenschappen van een site.
 * Geometry is hierbij de convexhull van de geometries van de sources die horen bij de site, niet een simpele samenvoeging.
 * sector_id is de (meest voorkomende) sector van de sources.
 * number_of_sources geeft het aantal bronnen aan dat hoort bij de site.
 *
 * De geaggregeerde gcn-bronnen zijn bij het bepalen van deze tabel-data niet meegenomen.
 */
CREATE TABLE site_generated_properties (
	site_id integer NOT NULL,
	sector_id integer NOT NULL,
	number_of_sources integer NOT NULL,
	geometry geometry(Geometry),

	CONSTRAINT site_generated_properties_pkey PRIMARY KEY (site_id),
	CONSTRAINT site_generated_properties_fkey_sites FOREIGN KEY (site_id) REFERENCES sites,
	CONSTRAINT site_generated_properties_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);

CREATE INDEX site_generated_properties_geometry_gist ON site_generated_properties USING GIST (geometry);


/*
 * sources
 * -------
 * Brondefinities incl. geografisch punt.
 */
CREATE TABLE sources (
	source_id integer NOT NULL,
	site_id integer NOT NULL,
	sector_id integer NOT NULL,
	origin_id integer NOT NULL,
	reference text NOT NULL,
	description text,
	geometry geometry(Geometry),

	CONSTRAINT sources_pkey PRIMARY KEY (source_id),
	CONSTRAINT sources_fkey_sites FOREIGN KEY (site_id) REFERENCES sites,
	CONSTRAINT sources_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sources_fkey_origins FOREIGN KEY (origin_id) REFERENCES origins
);

CREATE INDEX sources_geometry_gist ON sources USING GIST (geometry);
CREATE INDEX idx_sources_site_id ON sources (site_id);


/*
 * sources_gcn_sector
 * ------------------
 * Koppeltabel om indien bekend, bronnen aan gcn-sectoren te koppelen.
 */
CREATE TABLE sources_gcn_sector (
	source_id integer NOT NULL,
	gcn_sector_id integer NOT NULL,

	CONSTRAINT sources_gcn_sector_pkey PRIMARY KEY (source_id),
	CONSTRAINT sources_gcn_sector_fkey_sources FOREIGN KEY (source_id) REFERENCES sources,
	CONSTRAINT sources_gcn_sector_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors
);


/*
 * source_source_characteristics
 * -----------------------------
 * De ops karakteristieken van de bronnen.
 */
CREATE TABLE source_source_characteristics (
	source_id integer NOT NULL,
	heat_content posreal NOT NULL,
	height posreal NOT NULL,
	diameter posint NOT NULL,
	spread posreal NOT NULL,
	emission_diurnal_variation_id integer NOT NULL,

	CONSTRAINT source_source_characteristics_pkey PRIMARY KEY (source_id),
	CONSTRAINT source_source_characteristics_fkey_source_id FOREIGN KEY (source_id) REFERENCES sources,
	CONSTRAINT source_source_characteristics_fkey_emission_diurnal_variations FOREIGN KEY (emission_diurnal_variation_id) REFERENCES emission_diurnal_variations
);


/*
 * source_emissions
 * ----------------
 * De emissies van de bronnen.
 */
CREATE TABLE source_emissions (
	source_id integer NOT NULL,
	substance_id smallint NOT NULL,
	emission posreal NOT NULL,

	CONSTRAINT source_emissions_pkey PRIMARY KEY (source_id, substance_id),
	CONSTRAINT source_emissions_fkey_source_id FOREIGN KEY (source_id) REFERENCES sources,
	CONSTRAINT source_emissions_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);