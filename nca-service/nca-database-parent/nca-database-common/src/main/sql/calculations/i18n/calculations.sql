/*
 * permit_calculation_radius_types
 * -------------------------------
 * Vertaaltabel voor sectoren de afstandsgrens-types voor Wet natuurbescherking berkeningen.
 */
CREATE TABLE i18n.permit_calculation_radius_types
(
	permit_calculation_radius_type_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,

	CONSTRAINT permit_calculation_radius_types_pkey PRIMARY KEY (permit_calculation_radius_type_id, language_code),
	CONSTRAINT permit_calculation_radius_types_fkey FOREIGN KEY (permit_calculation_radius_type_id) REFERENCES permit_calculation_radius_types
);