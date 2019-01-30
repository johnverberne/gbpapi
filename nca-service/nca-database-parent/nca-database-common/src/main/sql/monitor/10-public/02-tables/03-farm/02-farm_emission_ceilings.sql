/*
 * farm_emission_formal_ceilings_no_policies
 * -----------------------------------------
 * Wettelijke emissieplafonds voor vaststaandbeleid.
 */
CREATE TABLE farm_emission_formal_ceilings_no_policies (
	farm_emission_ceiling_category_id integer NOT NULL,
	substance_id smallint NOT NULL,
	emission_ceiling posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_formal_ceilings_np_pkey PRIMARY KEY (farm_emission_ceiling_category_id, substance_id),
	CONSTRAINT farm_emission_formal_ceilings_np_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	CONSTRAINT farm_emission_formal_ceilings_np_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_emission_formal_ceilings_global_policies
 * ---------------------------------------------
 * Wettelijke emissieplafonds voor rijksbeleid.
 */
CREATE TABLE farm_emission_formal_ceilings_global_policies (
	farm_emission_ceiling_category_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	emission_ceiling posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_formal_ceilings_gp_pkey PRIMARY KEY (farm_emission_ceiling_category_id, year, substance_id),
	CONSTRAINT farm_emission_formal_ceilings_gp_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	CONSTRAINT farm_emission_formal_ceilings_gp_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_emission_formal_ceilings_jurisdiction_policies
 * ---------------------------------------------------
 * Wettelijke emissieplafonds voor provinciaal beleid.
 */
CREATE TABLE farm_emission_formal_ceilings_jurisdiction_policies (
	jurisdiction_id integer NOT NULL,
	farm_emission_ceiling_category_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	emission_ceiling posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_formal_ceilings_jp_pkey PRIMARY KEY (jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id),
	CONSTRAINT farm_emission_formal_ceilings_jp_fkey_jurisdictions FOREIGN KEY (jurisdiction_id) REFERENCES jurisdictions,
	CONSTRAINT farm_emission_formal_ceilings_jp_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	CONSTRAINT farm_emission_formal_ceilings_jp_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_emission_ceilings_no_policies
 * ----------------------------------
 * Emissieplafonds voor vaststaandbeleid.
 */
CREATE TABLE farm_emission_ceilings_no_policies (
	farm_emission_ceiling_category_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	emission_ceiling posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_ceilings_np_pkey PRIMARY KEY (farm_emission_ceiling_category_id, year, substance_id),
	CONSTRAINT farm_emission_ceilings_np_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	CONSTRAINT farm_emission_ceilings_np_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_emission_ceilings_global_policies
 * --------------------------------------
 * Emissieplafonds voor rijksbeleid.
 */
CREATE TABLE farm_emission_ceilings_global_policies (
	farm_emission_ceiling_category_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	emission_ceiling posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_ceilings_gp_pkey PRIMARY KEY (farm_emission_ceiling_category_id, year, substance_id),
	CONSTRAINT farm_emission_ceilings_gp_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	CONSTRAINT farm_emission_ceilings_gp_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_emission_ceilings_jurisdiction_policies
 * --------------------------------------------
 * Emissieplafonds voor provinciaal beleid.
 */
CREATE TABLE farm_emission_ceilings_jurisdiction_policies (
	jurisdiction_id integer NOT NULL,
	farm_emission_ceiling_category_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	emission_ceiling posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_ceilings_jp_pkey PRIMARY KEY (jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id),
	CONSTRAINT farm_emission_ceilings_jp_fkey_jurisdictions FOREIGN KEY (jurisdiction_id) REFERENCES jurisdictions,
	CONSTRAINT farm_emission_ceilings_jp_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	CONSTRAINT farm_emission_ceilings_jp_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);