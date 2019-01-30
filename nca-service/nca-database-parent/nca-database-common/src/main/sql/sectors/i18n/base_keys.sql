/*
 * sectors
 * -------
 * Vertaaltabel voor sectoren.
 */
CREATE TABLE i18n.sectors (
	sector_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	description text NOT NULL,

	CONSTRAINT sectors_pkey PRIMARY KEY (sector_id, language_code),
	CONSTRAINT sectors_fkey FOREIGN KEY (sector_id) REFERENCES sectors
);


/*
 * emission_diurnal_variations
 * ---------------------------
 * Vertaaltabel voor de verschillende type temporele variaties.
 */
CREATE TABLE i18n.emission_diurnal_variations (
	emission_diurnal_variation_id integer NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT emission_diurnal_variations_pkey PRIMARY KEY (emission_diurnal_variation_id, language_code),
	CONSTRAINT emission_diurnal_variations_fkey FOREIGN KEY (emission_diurnal_variation_id) REFERENCES emission_diurnal_variations,
	CONSTRAINT emission_diurnal_variations_unique_name UNIQUE (language_code, name)
);