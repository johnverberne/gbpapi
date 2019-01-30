/*
 * sectors_sectorgroup
 * -------------------
 * Systeem tabel met daarin de sectorgroup voor een sector.
 */
CREATE TABLE system.sectors_sectorgroup (
	sector_id integer NOT NULL,
	sectorgroup system.sectorgroup NOT NULL,

	CONSTRAINT sectors_sectorgroup_pkey PRIMARY KEY (sector_id),
	CONSTRAINT sectors_sectorgroup_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);

/*
 * sector_cosmetic_properties
 * --------------------------
 * Systeem tabel met daarin de cosmetische properties zoals kleur en icon per sector.
 */
CREATE TABLE system.sector_cosmetic_properties (
	sector_id integer NOT NULL,
	color system.color NOT NULL,
	icon_type text NOT NULL,

	CONSTRAINT sector_cosmetic_properties_pkey PRIMARY KEY (sector_id),
	CONSTRAINT sector_cosmetic_properties_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);

/*
 * sector_calculation_properties
 * -----------------------------
 * Systeem tabel met daarin de reken properties zoals emissie bepaal methode en rekenengine per sub-sector.
 * Als de sector niet in deze tabel voorkomt kan deze niet doorgerekend worden.
 */
CREATE TABLE system.sector_calculation_properties (
	sector_id integer NOT NULL,
	emission_calculation_method text NOT NULL,
	calculation_engine text NOT NULL,
	building_possible boolean NOT NULL,

	CONSTRAINT sector_calculation_properties_pkey PRIMARY KEY (sector_id),
	CONSTRAINT sector_calculation_properties_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);
