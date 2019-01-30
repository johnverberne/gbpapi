/*
 * gcn_sector_depositions_no_policies_agriculture
 * ----------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep farm.
 */
CREATE TABLE setup.gcn_sector_depositions_no_policies_agriculture (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_no_pol_agriculture_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_no_pol_agriculture_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_no_pol_agriculture_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_no_pol_agriculture_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

/*
 * gcn_sector_depositions_no_policies_industry
 * -------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep industry.
 */
CREATE TABLE setup.gcn_sector_depositions_no_policies_industry (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_no_pol_industry_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_no_pol_industry_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_no_pol_industry_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_no_pol_industry_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

/*
 * gcn_sector_depositions_no_policies_other
 * ----------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep other.
 */
CREATE TABLE setup.gcn_sector_depositions_no_policies_other (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_no_pol_other_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_no_pol_other_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_no_pol_other_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_no_pol_other_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

/*
 * gcn_sector_depositions_no_policies_road_freeway
 * -----------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep road_freeway.
 */
CREATE TABLE setup.gcn_sector_depositions_no_policies_road_freeway (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_no_pol_road_freeway_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_no_pol_road_freeway_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_no_pol_road_freeway_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_no_pol_road_freeway_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

/*
 * gcn_sector_depositions_no_policies_road_transportation
 * ------------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep road_transportation.
 */
CREATE TABLE setup.gcn_sector_depositions_no_policies_road_transportation (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_no_pol_road_transportation_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_no_pol_road_transportation_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_no_pol_road_transportation_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_no_pol_road_transportation_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

/*
 * gcn_sector_depositions_no_policies_shipping
 * -------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep shipping.
 */
CREATE TABLE setup.gcn_sector_depositions_no_policies_shipping (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_no_pol_shipping_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_no_pol_shipping_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_no_pol_shipping_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_no_pol_shipping_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);



/*
 * gcn_sector_depositions_no_policies_no_growth
 * --------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid zonder groei.
 */
CREATE TABLE setup.gcn_sector_depositions_no_policies_no_growth (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_no_pol_no_growth_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_no_pol_no_growth_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_no_pol_no_growth_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_no_pol_no_growth_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);



/*
 * gcn_sector_corrections_no_policies
 * ----------------------------------
 * Correctie per jaar, GCN-sector, stof en receptor ten opzichte van de doorgerekende depositie.
 */
CREATE TABLE setup.gcn_sector_corrections_no_policies (
	correction_type setup.deposition_correction_type NOT NULL,
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	correction real NOT NULL,

	CONSTRAINT gcn_sector_corrections_no_policies_pkey PRIMARY KEY (receptor_id, year, correction_type, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_corrections_no_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_corrections_no_policies_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_corrections_no_policies_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

/*
 * gcn_sector_correction_factors_no_policies
 * -----------------------------------------
 * Algemene depositie correctie-factor per jaar en GCN-sector.
 * Deze tabel  bevat momenteel geen data meer.
 */
CREATE TABLE setup.gcn_sector_correction_factors_no_policies (
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	correction_factor posreal NOT NULL,

	CONSTRAINT gcn_sector_cor_factors_no_policies_pkey PRIMARY KEY (year, gcn_sector_id)--,
--	CONSTRAINT gcn_sector_cor_factors_no_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_cor_factors_no_policies_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_cor_factors_no_policies_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);