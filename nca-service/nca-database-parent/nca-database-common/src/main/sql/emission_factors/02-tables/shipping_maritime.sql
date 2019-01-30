/*
 * shipping_maritime_categories
 * ----------------------------
 * De categories van verschillende soorten schepen voor zeevaart.
 * In de naam wordt ook de tonnages aangegeven. De naam wordt verder gebruikt als identificatie van de categorie voor een gebruiker.
 */
CREATE TABLE shipping_maritime_categories
(
	shipping_maritime_category_id smallint NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT shipping_maritime_categories_pkey PRIMARY KEY (shipping_maritime_category_id)
);


/*
 * shipping_maritime_category_maneuver_properties
 * ----------------------------------------------
 * Manoeuvreer-eigenschappen per zeevaart schip.
 *
 * Maneuver_factor is de factor waarmee de emissie in het beginstuk van de vaarroute moet worden opgehoogd vanwege het manouvreren van het schip bij de kade.
 * Maneuver_length is de lengte van de route waarbij deze factor gebruikt moet worden.
 */
CREATE TABLE shipping_maritime_category_maneuver_properties
(
	shipping_maritime_category_id smallint NOT NULL,
	maneuver_factor posreal NOT NULL,
	maneuver_length posreal NOT NULL,

	CONSTRAINT shipping_maritime_category_maneuver_properties_pkey PRIMARY KEY (shipping_maritime_category_id),
	CONSTRAINT shipping_maritime_category_maneuver_properties_fkey_categories FOREIGN KEY (shipping_maritime_category_id) REFERENCES shipping_maritime_categories
);


/*
 * shipping_maritime_category_emission_factors
 * -------------------------------------------
 * De emissie factoren voor verschillende soorten schepen voor zeescheepvaart.
 * Deze factoren zijn uniek per scheepstype per stof per jaar per snelheid.
 *
 * Hierin is emission_factor de emissie factor tijdens varen (in kg/(kilometer * aantal schepen)) bij een bepaalde snelheid.
 * De emission_factor bij een snelheid van 0 is de emissie factor tijdens stilliggen.
 * (in kg/(aantal schepen * uur stilliggen)).
 */
CREATE TABLE shipping_maritime_category_emission_factors
(
	shipping_maritime_category_id smallint NOT NULL,
	substance_id smallint NOT NULL,
	movement_type shipping_movement_type NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT shipping_maritime_category_emission_factors_pkey PRIMARY KEY (shipping_maritime_category_id, substance_id, movement_type),
	CONSTRAINT shipping_maritime_category_emission_factors_fkey_categories FOREIGN KEY (shipping_maritime_category_id) REFERENCES shipping_maritime_categories,
	CONSTRAINT shipping_maritime_category_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * shipping_maritime_category_source_characteristics
 * -------------------------------------------------
 * De OPS karakteristieken per scheepstype.
 *
 * De warmteinhoud (heat_content) in deze tabel overschrijft verder de warmteinhoud verkregen via de sector van het scheepstype.
 * Dit omdat de warmteinhoud afhankelijk is van de scheepstype en beweegtype.
 * De hoogte gedefinieerd in deze tabel overschrijft daarbij de hoogte verkregen via de sector.
 * Dit omdat de hoogte varieert per tonnage-reeks en beweeg type, niet alleen per sector.
 * Spreiding is verder weer een karakteristiek die sterk samenhangt per hoogte, en is daarom ook meegenomen in deze tabel.
 */
CREATE TABLE shipping_maritime_category_source_characteristics
(
	shipping_maritime_category_id smallint NOT NULL,
	movement_type shipping_movement_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	heat_content posreal NOT NULL,
	height posreal NOT NULL,
	spread posreal NOT NULL,

	CONSTRAINT shipping_maritime_category_source_char_pkey PRIMARY KEY (shipping_maritime_category_id, movement_type),
	CONSTRAINT shipping_maritime_category_source_char_fkey_categories FOREIGN KEY (shipping_maritime_category_id) REFERENCES shipping_maritime_categories,
	CONSTRAINT shipping_maritime_category_source_char_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors
);


/*
 * shipping_maritime_emission_trend_factors
 * ----------------------------------------
 * De trend factoren voor emissies voor verschillende jaren.
 * Deze factoren zijn uniek per stof per jaar per beweegtype.
 *
 * Bedoeling van de trendfactoren is om de emissiefactor bij te werken aan de hand van het rekenjaar.
 */
CREATE TABLE shipping_maritime_emission_trend_factors
(
	substance_id smallint NOT NULL,
	year year_type NOT NULL,
	movement_type shipping_movement_type NOT NULL,
	trend_factor posreal NOT NULL,

	CONSTRAINT shipping_maritime_emission_trend_factors_pkey PRIMARY KEY (substance_id, year, movement_type),
	CONSTRAINT shipping_maritime_emission_trend_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);
