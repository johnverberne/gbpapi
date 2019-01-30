/*
 * mobile_source_off_road_categories
 * ---------------------------------
 * Vertaaltabel voor categorieën van verschillende soorten offroad mobiele bronnen.
 */
CREATE TABLE i18n.mobile_source_off_road_categories (
	mobile_source_off_road_category_id smallint NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT mobile_source_off_road_categories_pkey PRIMARY KEY (mobile_source_off_road_category_id, language_code),
	CONSTRAINT mobile_source_off_road_categories_fkey FOREIGN KEY (mobile_source_off_road_category_id) REFERENCES mobile_source_off_road_categories
);


/*
 * mobile_source_on_road_categories
 * --------------------------------
 * Vertaaltabel voor categorieën van verschillende soorten onroad mobiele bronnen.
 */
CREATE TABLE i18n.mobile_source_on_road_categories (
	mobile_source_on_road_category_id smallint NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT mobile_source_on_road_categories_pkey PRIMARY KEY (mobile_source_on_road_category_id, language_code),
	CONSTRAINT mobile_source_on_road_categories_fkey FOREIGN KEY (mobile_source_on_road_category_id) REFERENCES mobile_source_on_road_categories
);
