/*
 * plan_categories
 * ---------------
 * De categorieën van verschillende soorten plannen.
 *
 * De naam is hierbij de identificatie van de categorie voor de gebruiker.
 */
CREATE TABLE plan_categories
(
	plan_category_id smallint NOT NULL,
	gcn_sector_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	category_unit unit_type NOT NULL,
	description text,

	CONSTRAINT plan_categories_pkey PRIMARY KEY (plan_category_id),
	CONSTRAINT plan_categories_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors
);

/*
 * plan_category_emission_factors
 * ------------------------------
 * De emissie factoren voor verschillende soorten plannen.
 * De emissie factoren zijn hier afhankelijk van de category_unit van de bijbehorende plan_category.
 */
CREATE TABLE plan_category_emission_factors
(
	plan_category_id smallint NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT plan_category_emission_factors_pkey PRIMARY KEY (plan_category_id, substance_id),
	CONSTRAINT plan_category_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances,
	CONSTRAINT plan_category_emission_factors_fkey_plan_categories FOREIGN KEY (plan_category_id) REFERENCES plan_categories
);
