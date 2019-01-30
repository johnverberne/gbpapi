/*
 * farm_nema_categories
 * --------------------
 * NEMA-diercategorieen.
 */
CREATE TABLE farm_nema_categories (
	farm_nema_category_id integer NOT NULL,
	farm_nema_cluster_id integer NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT farm_nema_category_pkey PRIMARY KEY (farm_nema_category_id),
	CONSTRAINT farm_nema_category_fkey_farm_nema_clusters FOREIGN KEY (farm_nema_cluster_id) REFERENCES farm_nema_clusters
);


/*
 * farm_nema_category_emissions
 * ----------------------------
 * Totale NEMA-emissie per NEMA-diercategory en stof.
 */
CREATE TABLE farm_nema_category_emissions (
	farm_nema_category_id integer NOT NULL,
	substance_id smallint NOT NULL,
	emission posint NOT NULL,

	CONSTRAINT farm_nema_category_emissions_pkey PRIMARY KEY (farm_nema_category_id, substance_id),
	CONSTRAINT farm_nema_category_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_emission_correction_factors_nema
 * -------------------------------------
 * Tabel met daarin de NEMA correctie per RAV-code.
 * De correctie is een factor.
 */
CREATE TABLE farm_emission_correction_factors_nema (
	farm_nema_cluster_id integer NOT NULL,
	substance_id smallint NOT NULL,
	correction_factor posreal NOT NULL,

	CONSTRAINT farm_emission_correction_factors_nema_pkey PRIMARY KEY (farm_nema_cluster_id, substance_id),
	CONSTRAINT farm_emission_correction_factors_nema_fkey_farm_nema_clusters FOREIGN KEY (farm_nema_cluster_id) REFERENCES farm_nema_clusters,
	CONSTRAINT farm_emission_correction_factors_nema_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);