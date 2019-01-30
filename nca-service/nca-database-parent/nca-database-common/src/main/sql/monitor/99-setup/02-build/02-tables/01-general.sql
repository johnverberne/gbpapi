/*
 * sectors_sectorgroup
 * -------------------
 * Koppeltabel voor sector en sectorgroep. Deze koppeling is 1 op 1.
 */
CREATE TABLE setup.sectors_sectorgroup (
	sector_id integer NOT NULL,
	sectorgroup setup.sectorgroup NOT NULL,

	CONSTRAINT sectors_sectorgroup_pkey PRIMARY KEY (sector_id),
	CONSTRAINT sectors_sectorgroup_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);


/*
 * sector_overkill_corrections
 * ---------------------------
 * Correctiefactoren per sector en stof voor receptoren met een te korte rekenafstand tot de bronnen.
 */
CREATE TABLE setup.sector_overkill_corrections (
	receptor_id integer NOT NULL,
	sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	correction_factor real NOT NULL,

	CONSTRAINT sector_overkill_corrections_pkey PRIMARY KEY (receptor_id, sector_id, substance_id),
	CONSTRAINT sector_overkill_corrections_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
	CONSTRAINT sector_overkill_corrections_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sector_overkill_corrections_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);
