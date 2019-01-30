/*
 * shipping_inland_categories
 * --------------------------
 * Vertaaltabel voor categorieën van verschillende soorten binnenvaart-schepen.
 */
CREATE TABLE i18n.shipping_inland_categories (
	shipping_inland_category_id smallint NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT shipping_inland_categories_pkey PRIMARY KEY (shipping_inland_category_id, language_code),
	CONSTRAINT shipping_inland_categor_fkey FOREIGN KEY (shipping_inland_category_id) REFERENCES shipping_inland_categories
);

/*
 * shipping_inland_waterway_categories
 * -----------------------------------
 * Vertaaltabel voor categorieën van verschillende soorten binnenvaart vaarwegen.
 */
CREATE TABLE i18n.shipping_inland_waterway_categories (
	shipping_inland_waterway_category_id smallint NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT shipping_inland_waterway_categories_pkey PRIMARY KEY (shipping_inland_waterway_category_id, language_code),
	CONSTRAINT shipping_inland_waterway_categories_fkey FOREIGN KEY (shipping_inland_waterway_category_id) REFERENCES shipping_inland_waterway_categories
);
