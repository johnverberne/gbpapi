/*
 * farm_sites
 * ----------
 * De site-specifieke eigenschappen van een boederij.
 */
CREATE TABLE farm_sites (
	site_id integer NOT NULL,
	recreational boolean NOT NULL,
	no_growth boolean NOT NULL,

	CONSTRAINT farm_sites_pkey PRIMARY KEY (site_id),
	CONSTRAINT farm_sites_fkey_sites FOREIGN KEY (site_id) REFERENCES sites
);


/*
 * farm_site_suspenders
 * --------------------
 * De site / emissieplafond categories welke gemarkeerd zijn als stopper.
 */
CREATE TABLE farm_site_suspenders (
	site_id integer NOT NULL,
	farm_emission_ceiling_category_id integer NOT NULL,
	suspender boolean NOT NULL,

	CONSTRAINT farm_site_suspenders_pkey PRIMARY KEY (site_id, farm_emission_ceiling_category_id),
	CONSTRAINT farm_site_suspenders_fkey_sites FOREIGN KEY (site_id) REFERENCES sites,
	CONSTRAINT farm_site_suspenders_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories
);