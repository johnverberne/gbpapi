/*
 * mobile_source_off_road_categories
 * ---------------------------------
 * De categorieÃ«n van verschillende soorten offroad mobiele bronnen.
 * Dit is qua structuur dezelfde tabel als mobile_source_on_road_categories.
 * Hierdoor zou overerving wel kunnen, echter is het nadeel hierbij dat voor de ID's
 * vervolgens rekening gehouden moet worden met de andere tabel. Hierom is gekozen NIET gebruik te maken van overerving.
 * Er is een kans dat de lijsten afzonderlijk van elkaar zullen gaan wijzigen.
 *
 * De naam is hierbij de identificatie van de categorie voor de gebruiker.
 */
CREATE TABLE mobile_source_off_road_categories
(
	mobile_source_off_road_category_id smallint NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT mobile_source_off_road_categories_pkey PRIMARY KEY (mobile_source_off_road_category_id)
);


/*
 * mobile_source_off_road_category_emission_factors
 * ------------------------------------------------
 * De emissie factoren voor verschillende soorten offroad mobiele bronnen.
 * De emissie factoren zijn hier in kg/l.
 */
CREATE TABLE mobile_source_off_road_category_emission_factors
(
	mobile_source_off_road_category_id smallint NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT mobile_source_off_road_category_efac_pkey PRIMARY KEY (mobile_source_off_road_category_id, substance_id),
	CONSTRAINT mobile_source_off_road_category_efac_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances,
	CONSTRAINT mobile_source_off_road_category_efac_fkey_mobile_off_road_cat FOREIGN KEY (mobile_source_off_road_category_id) REFERENCES mobile_source_off_road_categories
);

/*
 * mobile_source_on_road_categories
 * --------------------------------
 * De categorieÃ«n van verschillende soorten onroad mobiele bronnen.
 * Dit is qua structuur dezelfde tabel als mobile_source_off_road_categories.
 * Hierdoor zou overerving wel kunnen, echter is het nadeel hierbij dat voor de ID's
 * vervolgens rekening gehouden moet worden met de andere tabel. Hierom is gekozen NIET gebruik te maken van overerving.
 * Er is een kans dat de lijsten afzonderlijk van elkaar zullen gaan wijzigen.
 *
 * De naam is hierbij de identificatie van de categorie voor de gebruiker.
 */
CREATE TABLE mobile_source_on_road_categories
(
	mobile_source_on_road_category_id smallint NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT mobile_source_on_road_categories_pkey PRIMARY KEY (mobile_source_on_road_category_id)
);


/*
 * mobile_source_on_road_category_emission_factors
 * -----------------------------------------------
 * De emissie factoren voor verschillende soorten onroad mobiele bronnen.
 * De emissie factoren zijn hier in kg/km/voertuig.
 */
CREATE TABLE mobile_source_on_road_category_emission_factors
(
	mobile_source_on_road_category_id smallint NOT NULL,
	road_type road_type NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT mobile_source_on_road_efac_pkey PRIMARY KEY (mobile_source_on_road_category_id, road_type, substance_id),
	CONSTRAINT mobile_source_on_road_efac_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances,
	CONSTRAINT mobile_source_on_road_efac_fkey_mobile_on_road_cat FOREIGN KEY (mobile_source_on_road_category_id) REFERENCES mobile_source_on_road_categories
);
