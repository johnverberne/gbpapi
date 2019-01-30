
/*
 * plan_category_properties
 * ------------------------
 * Systeem tabel met daarin de properties zoals kleur en icon per plan categorie.
 */
CREATE TABLE system.plan_category_properties (
	plan_category_id integer NOT NULL,
	icon_type text NOT NULL,

	CONSTRAINT plan_category_properties_pkey PRIMARY KEY (plan_category_id),
	CONSTRAINT plan_category_properties_fkey_plan_categories FOREIGN KEY (plan_category_id) REFERENCES plan_categories
);
