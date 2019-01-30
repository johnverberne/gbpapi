/*
 * farm_lodging_types
 * ------------------
 * Vertaaltabel voor stalsystemen.
 */
CREATE TABLE i18n.farm_lodging_types (
	farm_lodging_type_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text,

	CONSTRAINT farm_lodging_types_pkey PRIMARY KEY (farm_lodging_type_id, language_code),
	CONSTRAINT farm_lodging_types_fkey FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types
);
