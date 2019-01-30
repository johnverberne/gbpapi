/*
 * gml_conversions
 * ---------------
 * Conversietabel voor aangepaste id's en codes die in oude GML versies gebruikt worden.
 */
CREATE TABLE system.gml_conversions (
	gml_version text NOT NULL,
	type text NOT NULL,
	old_value text NOT NULL,
	new_value text NOT NULL,
	issue_warning boolean NOT NULL,

	CONSTRAINT gml_conversions_pkey PRIMARY KEY (gml_version, type, old_value)
);
