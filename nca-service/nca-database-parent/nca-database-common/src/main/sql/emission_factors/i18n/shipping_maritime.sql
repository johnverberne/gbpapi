/*
 * shipping_maritime_categories
 * ----------------------------
 * Vertaaltabel voor categorieën van verschillende soorten zeevaart-schepen.
 */
CREATE TABLE i18n.shipping_maritime_categories (
	shipping_maritime_category_id smallint NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT shipping_maritime_categories_pkey PRIMARY KEY (shipping_maritime_category_id, language_code),
	CONSTRAINT shipping_maritime_categories_fkey FOREIGN KEY (shipping_maritime_category_id) REFERENCES shipping_maritime_categories
);
