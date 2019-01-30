/*
 * sectors
 * -------
 * Sectorindeling van AERIUS
 */
CREATE TABLE sectors (
	sector_id integer NOT NULL,
	description text NOT NULL,

	CONSTRAINT sectors_pkey PRIMARY KEY (sector_id)
);


/*
 * gcn_sectors
 * -----------
 * Sectorindeling van het RIVM.
 * Elke GCN-sector is gekoppeld aan een AERIUS-sector. Hierdoor weten we aan welke AERIUS-sector de depositie van de RIVM-bronnen toegekend moet worden.
 */
CREATE TABLE gcn_sectors (
	gcn_sector_id integer NOT NULL,
	sector_id integer NOT NULL,
	description text NOT NULL,

	CONSTRAINT gcn_sectors_pkey PRIMARY KEY (gcn_sector_id),
	CONSTRAINT gcn_sectors_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);


/*
 * sectors_main_gcn_sector
 * -----------------------
 * Koppeltabel om voor de sectoren (zonder (sub)categorieen) aan te geven aan welke hoofd-GCN-sector deze bronnen gekoppeld kunnen worden.
 */
CREATE TABLE sectors_main_gcn_sector (
	sector_id integer NOT NULL,
	gcn_sector_id integer NOT NULL,

	CONSTRAINT sectors_main_gcn_sector_pkey PRIMARY KEY (sector_id),
	CONSTRAINT sectors_main_gcn_sector_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sectors_main_gcn_sector_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors
);