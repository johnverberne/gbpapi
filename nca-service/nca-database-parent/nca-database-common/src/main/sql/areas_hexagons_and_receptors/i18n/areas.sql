/*
 * habitat_types
 * -------------
 * Vertaaltabel voor habitattypen.
 */
CREATE TABLE i18n.habitat_types (
	habitat_type_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text NOT NULL,

	CONSTRAINT habitat_types_pkey PRIMARY KEY (habitat_type_id, language_code),
	CONSTRAINT habitat_types_fkey FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
);
