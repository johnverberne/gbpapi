/*
 * shipping_inland_categories
 * --------------------------
 * De categories van verschillende soorten binnenvaart-schepen.
 * In de naam wordt ook de tonnages aangegeven. De naam wordt verder gebruikt als identificatie van de categorie voor een gebruiker.
 *
 * Standaard kenmerken voor een specifieke scheepstype kunnen via sector verkregen worden.
 */
CREATE TABLE shipping_inland_categories
(
	shipping_inland_category_id smallint NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT shipping_inland_categories_pkey PRIMARY KEY (shipping_inland_category_id)
);


/*
 * shipping_inland_emission_trend_factors
 * --------------------------------------
 * De trend factoren voor emissies voor de verschillende soorten varende schepen.
 * Deze factoren zijn uniek per stof.
 *
 * Bedoeling van de trendfactoren is om de emissiefactor bij te werken aan de hand van het rekenjaar.
 */
CREATE TABLE shipping_inland_emission_trend_factors
(
	substance_id smallint NOT NULL,
	year year_type NOT NULL,
	trend_factor posreal NOT NULL,

	CONSTRAINT shipping_inland_emission_trend_factors_pkey PRIMARY KEY (substance_id, year),
	CONSTRAINT shipping_inland_emission_trend_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * shipping_inland_category_emission_trend_factors_docked
 * ------------------------------------------------------
 * De trend factoren voor emissies voor de verschillende soorten stilliggende schepen.
 * Deze factoren zijn uniek per stof.
 *
 * Bedoeling van de trendfactoren is om de emissiefactor bij te werken aan de hand van het rekenjaar.
 */
CREATE TABLE shipping_inland_category_emission_trend_factors_docked
(
	shipping_inland_category_id smallint NOT NULL,
	substance_id smallint NOT NULL,
	year year_type NOT NULL,
	trend_factor posreal NOT NULL,

	CONSTRAINT shipping_inland_category_emis_trend_fac_docked_pkey PRIMARY KEY (shipping_inland_category_id, substance_id, year),
	CONSTRAINT shipping_inland_category_emis_trend_fac_docked_fkey_categories FOREIGN KEY (shipping_inland_category_id) REFERENCES shipping_inland_categories,
	CONSTRAINT shipping_inland_category_emis_trend_fac_docked_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * shipping_inland_category_emission_factors
 * -----------------------------------------
 * De emissie factoren voor de verschillende soorten varende schepen.
 * Deze factoren zijn uniek per scheepstype, vaarwegtype, vaarrichtingen, ladingstoestand en stof.
 *
 * Hierin is emission_factor de emissie factor tijdens varen (in kg/(kilometer * aantal schepen)) bij een bepaalde snelheid.
 */
CREATE TABLE shipping_inland_category_emission_factors
(
	shipping_inland_category_id smallint NOT NULL,
	shipping_inland_waterway_category_id integer NOT NULL,
	ship_direction shipping_inland_ship_direction_type NOT NULL,
	laden_state shipping_inland_laden_state NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT shipping_inland_category_emission_factors_pkey PRIMARY KEY (shipping_inland_category_id, shipping_inland_waterway_category_id, ship_direction, laden_state, substance_id),
	CONSTRAINT shipping_inland_category_emission_factors_fkey_categories FOREIGN KEY (shipping_inland_category_id) REFERENCES shipping_inland_categories,
	CONSTRAINT shipping_inland_category_emission_factors_fkey_waterway_categories FOREIGN KEY (shipping_inland_waterway_category_id) REFERENCES shipping_inland_waterway_categories,
	CONSTRAINT shipping_inland_category_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * shipping_inland_category_emission_factors_docked
 * ------------------------------------------------
 * De emissie factoren voor verschillende soorten stilliggende schepen.
 * Deze kenmerken zijn uniek per scheepstype, ladingstoestand en stof.
 *
 * Hierin is emission_factor de emissie factor tijdens varen (in kg/(kilometer * aantal schepen)) bij een bepaalde snelheid.
 */
CREATE TABLE shipping_inland_category_emission_factors_docked
(
	shipping_inland_category_id smallint NOT NULL,
	laden_state shipping_inland_laden_state NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT shipping_inland_category_emission_factors_docked_pkey PRIMARY KEY (shipping_inland_category_id, laden_state, substance_id),
	CONSTRAINT shipping_inland_category_emission_factors_docked_fkey_categories FOREIGN KEY (shipping_inland_category_id) REFERENCES shipping_inland_categories,
	CONSTRAINT shipping_inland_category_emission_factors_docked_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * shipping_inland_category_source_characteristics
 * -----------------------------------------------
 * De OPS karakteristieken voor verschillende soorten varende schepen.
 * Deze karakteristieken zijn uniek per scheepstype, vaarwegtypes, vaarrichtingen en ladingstoestand.
 */
CREATE TABLE shipping_inland_category_source_characteristics
(
	shipping_inland_category_id smallint NOT NULL,
	shipping_inland_waterway_category_id integer NOT NULL,
	ship_direction shipping_inland_ship_direction_type NOT NULL,
	laden_state shipping_inland_laden_state NOT NULL,
	gcn_sector_id integer NOT NULL,
	heat_content posreal NOT NULL,
	height posreal NOT NULL,
	spread posreal NOT NULL,

	CONSTRAINT shipping_inland_category_source_characteristics_pkey PRIMARY KEY (shipping_inland_category_id, shipping_inland_waterway_category_id, ship_direction, laden_state),
	CONSTRAINT shipping_inland_category_source_characteristics_fkey_categories FOREIGN KEY (shipping_inland_category_id) REFERENCES shipping_inland_categories,
	CONSTRAINT shipping_inland_category_source_characteristics_fkey_waterway_categories FOREIGN KEY (shipping_inland_waterway_category_id) REFERENCES shipping_inland_waterway_categories,
	CONSTRAINT shipping_inland_category_source_characteristics_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors
);


/*
 * shipping_inland_category_source_characteristics_docked
 * ------------------------------------------------------
 * De OPS karakteristieken voor verschillende soorten stilliggende schepen.
 * Deze karakteristieken zijn uniek per scheepstype en ladingstoestand.
 */
CREATE TABLE shipping_inland_category_source_characteristics_docked
(
	shipping_inland_category_id smallint NOT NULL,
	laden_state shipping_inland_laden_state NOT NULL,
	gcn_sector_id integer NOT NULL,
	heat_content posreal NOT NULL,
	height posreal NOT NULL,
	spread posreal NOT NULL,

	CONSTRAINT shipping_inland_category_source_char_docked_pkey PRIMARY KEY (shipping_inland_category_id, laden_state),
	CONSTRAINT shipping_inland_category_source_char_docked_fkey_categories FOREIGN KEY (shipping_inland_category_id) REFERENCES shipping_inland_categories,
	CONSTRAINT shipping_inland_category_source_char_docked_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors
);
