/*
 * emission_diurnal_variations
 * ---------------------------
 * Lijst met verschillende types temporele variaties.
 *
 * We gebruiken de veldnaam diurnal_variation in alle tabellen waar emission_diurnal_variation_id als foreign key voorkomt.
 */
CREATE TABLE emission_diurnal_variations (
	emission_diurnal_variation_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT emission_diurnal_variations_pkey PRIMARY KEY (emission_diurnal_variation_id)
);


/*
 * sector_default_source_characteristics
 * -------------------------------------
 * Standaard OPS kenmerken per sector.
 */
CREATE TABLE sector_default_source_characteristics (
	sector_id integer NOT NULL,
	heat_content posreal NOT NULL,
	height posreal NOT NULL,
	spread posreal NOT NULL,
	emission_diurnal_variation_id integer NOT NULL,
	particle_size_distribution integer NOT NULL,

	CONSTRAINT sector_default_source_characteristics_pkey PRIMARY KEY (sector_id),
	CONSTRAINT sector_default_source_characteristics_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sector_default_source_characteristics_fkey_emission_diurnal_variations FOREIGN KEY (emission_diurnal_variation_id) REFERENCES emission_diurnal_variations
);

/*
 * gcn_sector_source_characteristics
 * ---------------------------------
 * Voorgedefinieerde OPS kenmerken per GCN sector.
 */
CREATE TABLE gcn_sector_source_characteristics (
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	heat_content posreal NOT NULL,
	height posreal NOT NULL,
	spread posreal NOT NULL,
	emission_diurnal_variation_id integer NOT NULL,
	particle_size_distribution integer NOT NULL,

	CONSTRAINT gcn_sector_source_characteristics_pkey PRIMARY KEY (gcn_sector_id, substance_id),
	CONSTRAINT gcn_sector_source_characteristics_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
	CONSTRAINT gcn_sector_source_characteristics_fkey_gcn_substances FOREIGN KEY (substance_id) REFERENCES substances,
	CONSTRAINT gcn_sector_source_characteristics_fkey_emission_diurnal_variations FOREIGN KEY (emission_diurnal_variation_id) REFERENCES emission_diurnal_variations
);