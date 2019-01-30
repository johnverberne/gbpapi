/*
 * gcn_sector_economic_scale_factors
 * ---------------------------------
 * Economische groei schaalfactoren per GCN-sector, stof en jaar (ABR: 2,5% economische groei) uitgaande het jaar 2011.
 */
CREATE TABLE setup.gcn_sector_economic_scale_factors (
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	scale_factor real NOT NULL,

	CONSTRAINT gcn_sector_economic_scale_factors_pkey PRIMARY KEY (year, gcn_sector_id, substance_id),
	CONSTRAINT gcn_sector_economic_scale_factors_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
	CONSTRAINT gcn_sector_economic_scale_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * gcn_sector_economic_scale_factors_no_economy
 * --------------------------------------------
 * Economische groei schaalfactoren per per GCN-sector, stof en jaar (POR: 0,0% economsiche groei) uitgaande het jaar 2011.
 */
CREATE TABLE setup.gcn_sector_economic_scale_factors_no_economy (
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	scale_factor real NOT NULL,

	CONSTRAINT gcn_sector_economic_scale_factors_no_economy_pkey PRIMARY KEY (year, gcn_sector_id, substance_id),
	CONSTRAINT gcn_sector_economic_scale_factors_no_economy_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
	CONSTRAINT gcn_sector_economic_scale_factors_no_economy_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * gcn_sector_economic_growth_factors
 * ----------------------------------
 * De generieke economische groeifactoren ten opzichte van 2011.
 * Er kan ook krimp plaats vinden. Deze tabel bevat in dat geval een negatieve growth_factor.
 */
CREATE TABLE setup.gcn_sector_economic_growth_factors (
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	growth_factor real NOT NULL,

	CONSTRAINT gcn_sector_economic_growth_factors_pkey PRIMARY KEY (year, gcn_sector_id, substance_id),
	CONSTRAINT gcn_sector_economic_growth_fact_cor_fkey_eco_sca_fact_no_eco FOREIGN KEY (year, gcn_sector_id, substance_id) REFERENCES setup.gcn_sector_economic_scale_factors_no_economy
);


/*
 * gcn_sector_economic_growth_factor_corrections
 * ---------------------------------------------
 * Correctiefactoren voor de generieke economische groeifactoren.
 * De economische groeifactor moet voor de verfijnde gcn sectoren aangepast worden.
 * Dit volgt de waterbed methode.
 */
CREATE TABLE setup.gcn_sector_economic_growth_factor_corrections (
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	correction fraction NOT NULL,

	CONSTRAINT gcn_sector_economic_growth_factor_corrections_pkey PRIMARY KEY (year, gcn_sector_id, substance_id)--,
	--CONSTRAINT gcn_sector_economic_growth_fact_corr_fkey_eco_growth_fact FOREIGN KEY (year, gcn_sector_id, substance_id) REFERENCES setup.gcn_sector_economic_growth_factors  -- TODO #1100 reenable when data allows it
);


/*
 * gcn_sector_economic_growth_corrections
 * --------------------------------------
 * Correctie voor de berekende economische groei.
 */
CREATE TABLE setup.gcn_sector_economic_growth_corrections (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	gcn_sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	correction real NOT NULL,

	CONSTRAINT gcn_sector_economic_growth_corrections_pkey PRIMARY KEY (receptor_id, year, gcn_sector_id, substance_id),
	--CONSTRAINT gcn_sector_economic_growth_corrections_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors, -- TODO #1100 CHECK constraint
	CONSTRAINT gcn_sector_economic_growth_corrections_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
	CONSTRAINT gcn_sector_economic_growth_corrections_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);