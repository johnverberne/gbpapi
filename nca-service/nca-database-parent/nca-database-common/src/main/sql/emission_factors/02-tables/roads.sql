/*
 * road_categories
 * ---------------
 * Tabel met daarin de verschillende soorten wegen en de verschillende type voertuigen op die wegen.
 *
 * Dit zijn de standaard categorieen voor wegverkeer (bijv. personenauto's).
 */
CREATE TABLE road_categories
(
	road_category_id integer NOT NULL,
	gcn_sector_id integer NOT NULL,
	road_type road_type NOT NULL,
	vehicle_type vehicle_type NOT NULL,
	name text NOT NULL UNIQUE,
	description text,

	CONSTRAINT road_categories_pkey PRIMARY KEY (road_category_id),
	CONSTRAINT road_categories_fkey_gcn_sectors FOREIGN KEY (gcn_sector_id) REFERENCES gcn_sectors,
	CONSTRAINT road_categories_road_and_vehicle_type_unique UNIQUE (road_type, vehicle_type)
);


/*
 * road_speed_profiles
 * -------------------
 * Tabel met daarin de verschillende snelheidstyperingen per wegtype.
 */
CREATE TABLE road_speed_profiles
(
	road_speed_profile_id integer NOT NULL,
	road_type road_type NOT NULL,
	speed_limit_enforcement speed_limit_enforcement_type NOT NULL,
	maximum_speed integer,
	name text,

	CONSTRAINT road_speed_profiles_pkey PRIMARY KEY (road_speed_profile_id)
);


/*
 * road_category_emission_factors
 * ------------------------------
 * De emissie factoren voor verschillende soorten verkeer bij verschillende snelheidstyperingen voor verschillende soorten stoffen.
 * De emissie factors zijn hier in g/voertuig/km.
 *
 * LET OP: De jaren die in deze tabel voorkomen zijn niet per definitie gelijk aan de AERIUS beleidsjaren.
 */
CREATE TABLE road_category_emission_factors
(
	road_category_id integer NOT NULL,
	road_speed_profile_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	emission_factor double precision NOT NULL,
	stagnated_emission_factor double precision NOT NULL,

	CONSTRAINT road_category_emission_factors_pkey PRIMARY KEY (road_category_id, road_speed_profile_id, year, substance_id),
	CONSTRAINT road_category_emission_factors_fkey_road_categories FOREIGN KEY (road_category_id) REFERENCES road_categories,
	CONSTRAINT road_category_emission_factors_fkey_road_speed_profiles FOREIGN KEY (road_speed_profile_id) REFERENCES road_speed_profiles,
	CONSTRAINT road_category_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);
