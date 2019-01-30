/*
 * farm_sources
 * ------------
 * De specifieke bronnen welke landbouwbronnen (stallen) zijn.
 * Dit is dus een subset van de sources tabel. Eventueel landbouwbron-specifieke eigenschappen kunnen in deze tabel komen.
 */
CREATE TABLE farm_sources (
	source_id integer NOT NULL,

	CONSTRAINT farm_sources_pkey PRIMARY KEY (source_id),
	CONSTRAINT farm_sources_fkey_sources FOREIGN KEY (source_id) REFERENCES sources
);


/*
 * farm_animal_categories
 * ----------------------
 * Diercategorieen die voorkomen in de RAV-code lijst. (RAV = Regeling ammoniak en veehouderij)
 * Per diercategorie kunnen er maatregelen uitgevoerd worden.
 */
CREATE TABLE farm_animal_categories (
	farm_animal_category_id integer NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT farm_animal_categories_pkey PRIMARY KEY (farm_animal_category_id)
);


/*
 * farm_emission_ceiling_categories
 * --------------------------------
 * Categorieen voor de emissieplafonds.
 * Deze categorieen omvatten een set van stalsystemen.
 */
CREATE TABLE farm_emission_ceiling_categories (
	farm_emission_ceiling_category_id integer NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT farm_emission_ceiling_categories_pkey PRIMARY KEY (farm_emission_ceiling_category_id)
);


/*
 * farm_nema_clusters
 * ------------------
 * AERIUS-NEMA-clusters.
 * Clustering van de NEMA-diercategorieen zodat deze (uiteindelijk) gelinked kunnen worden aan RAV-codes.
 */
CREATE TABLE farm_nema_clusters (
	farm_nema_cluster_id integer NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT farm_nema_clusters_pkey PRIMARY KEY (farm_nema_cluster_id)
);


/*
 * farm_lodging_types
 * ------------------
 * Stalsystemen (huisvestingssystemen); dit is in essentie de RAV-code lijst, zie http://wetten.overheid.nl/BWBR0013629/geldigheidsdatum_19-11-2014
 * Per stalsysteem kunnen er maatregelen uitgevoerd worden.
 * Een stalsysteem behoort altijd tot een bepaalde diercategorie en emissieplafond-categorie.
 * Aan de hand van de sector kan de schaalfactor voor het stalsysteem worden opgevraagd.
 *
 * Indien er een nieuwe versie van de RAV lijst is, dan zullen er enkel *nieuwe* RAV-codes toegevoegd worden. Enkel de emissie kan veranderen in de loop van de tijd.
 */
CREATE TABLE farm_lodging_types (
	farm_lodging_type_id integer NOT NULL,
	farm_animal_category_id integer NOT NULL,
	farm_emission_ceiling_category_id integer NOT NULL,
	farm_nema_cluster_id integer, -- NOT NULL,
	gcn_sector_id integer NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT farm_lodging_types_pkey PRIMARY KEY (farm_lodging_type_id),
	CONSTRAINT farm_lodging_types_fkey_farm_animal_categories FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories,
	CONSTRAINT farm_lodging_types_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	--CONSTRAINT farm_lodging_types_fkey_farm_nema_clusters FOREIGN KEY (farm_nema_cluster_id) REFERENCES farm_nema_clusters,
	CONSTRAINT farm_lodging_types_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors
);


/*
 * farm_lodging_type_emission_factors
 * ----------------------------------
 * Bevat de emissie factoren (kg/jaar) van de stalsystemen.
 */
CREATE TABLE farm_lodging_type_emission_factors (
	farm_lodging_type_id integer NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT farm_lodging_type_emission_factors_pkey PRIMARY KEY (farm_lodging_type_id, substance_id),
	CONSTRAINT farm_lodging_type_emission_factors_fkey_farm_lodging_types FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types,
	CONSTRAINT farm_lodging_type_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_source_lodging_types
 * -------------------------
 * Iedere bron bestaat uit een of meerdere stalsystemen.
 * Per stalsysteem is het aantal dieren bekend. (Een stalsysteem behoort altijd tot een bepaalde diercategorie.)
 */
CREATE TABLE farm_source_lodging_types (
	source_id integer NOT NULL,
	farm_lodging_type_id integer NOT NULL,
	num_animals posint NOT NULL,

	CONSTRAINT farm_source_lodging_types_pkey PRIMARY KEY (source_id, farm_lodging_type_id),
	CONSTRAINT farm_source_lodging_types_fkey_farm_sources FOREIGN KEY (source_id) REFERENCES farm_sources,
	CONSTRAINT farm_source_lodging_types_fkey_farm_lodging_types FOREIGN KEY (farm_lodging_type_id) REFERENCES farm_lodging_types
);


/*
 * farm_animal_category_economic_growths
 * -------------------------------------
 * Groei per diercategorie per jaar. In deze factoren vind er wel krimp t.o.v. het basisjaar plaats.
 * Gebruik farm_animal_category_economic_growths_view indien er geen krimp t.o.v. het basisjaar mag optreden.
 */
CREATE TABLE farm_animal_category_economic_growths (
	farm_animal_category_id integer NOT NULL,
	year year_type NOT NULL,
	growth posreal NOT NULL,

	CONSTRAINT farm_animal_category_economic_growths_pkey PRIMARY KEY (farm_animal_category_id, year),
	CONSTRAINT farm_animal_category_economic_growths_fkey_farm_animal_cat FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories
);