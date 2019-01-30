/*
 * sector_economic_growths
 * -----------------------
 * Tussentabel met de generieke groei per toekomstjaar, AERIUS-sector, stof en receptor.
 */
CREATE TABLE setup.sector_economic_growths (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	receptor_id integer NOT NULL,
	deposition_space_growth real NOT NULL,
	growth real NOT NULL,

	CONSTRAINT sector_economic_growths_pkey PRIMARY KEY (year, sector_id, receptor_id)--,
--	CONSTRAINT sector_economic_growths_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
--	CONSTRAINT sector_economic_growths_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);
