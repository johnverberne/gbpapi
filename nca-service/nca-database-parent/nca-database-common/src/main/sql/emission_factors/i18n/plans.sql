/*
 * plan_categories
 * ---------------
 * Vertaaltabel voor categorieën van verschillende soorten plannen.
 */
CREATE TABLE i18n.plan_categories (
	plan_category_id smallint NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT plan_categories_pkey PRIMARY KEY (plan_category_id, language_code),
	CONSTRAINT plan_categories_fkey FOREIGN KEY (plan_category_id) REFERENCES plan_categories
);
