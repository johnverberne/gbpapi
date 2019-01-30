/*
 * gcn_sector_depositions_global_policies
 * --------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar rijksbeleid.
 */
CREATE TABLE setup.gcn_sector_depositions_global_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_depositions_global_policies_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_depositions_global_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_depositions_global_policies_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_depositions_global_policies_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);



/*
 * gcn_sector_depositions_global_policies_no_growth
 * ------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar rijksbeleid zonder groei.
 */
CREATE TABLE setup.gcn_sector_depositions_global_policies_no_growth (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT gcn_sector_dep_global_pol_no_growth_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_dep_global_pol_no_growth_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_dep_global_pol_no_growth_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_dep_global_pol_no_growth_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);



/*
 * gcn_sector_corrections_global_policies
 * --------------------------------------
 * Correctie per jaar, GCN-sector, stof en receptor ten opzichte van de (eventueel) doorgerekende depositie naar rijksbeleid
 * of de (eventueel gecorrigeerde) depositie naar vaststaand beleid.
 */
CREATE TABLE setup.gcn_sector_corrections_global_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	correction_type setup.deposition_correction_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	correction real NOT NULL,

	CONSTRAINT gcn_sector_corrections_global_policies_pkey PRIMARY KEY (receptor_id, year, correction_type, gcn_sector_id, substance_id)--,
--	CONSTRAINT gcn_sector_corrections_global_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_corrections_global_policies_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_corrections_global_policies_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

/*
 * gcn_sector_correction_factors_global_policies
 * ---------------------------------------------
 * Algemene depositie correctie-factor per jaar en GCN-sector.
 */
CREATE TABLE setup.gcn_sector_correction_factors_global_policies (
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	correction_factor posreal NOT NULL,

	CONSTRAINT gcn_sector_cor_factors_global_policies_pkey PRIMARY KEY (year, gcn_sector_id)--,
--	CONSTRAINT gcn_sector_cor_factors_global_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT gcn_sector_cor_factors_global_policies_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
--	CONSTRAINT gcn_sector_cor_factors_global_policies_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);