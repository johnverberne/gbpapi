/*
 * farm_emission_correction_factors_grazing
 * ----------------------------------------
 * Tabel met daarin de correctie op weide emissies.
 * De correctie is een factor en is hier een reductie (<= 1).
 * In praktijk zijn de dit netto emissie reductiefactoren voor A1-dieren.
 */
CREATE TABLE farm_emission_correction_factors_grazing (
	jurisdiction_id integer NOT NULL,
	farm_animal_category_id integer NOT NULL,
	substance_id smallint NOT NULL,
	correction_factor posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_correction_factors_grazing_pkey PRIMARY KEY (jurisdiction_id, farm_animal_category_id, substance_id),
	CONSTRAINT farm_emission_correction_factors_grazing_fkey_jurisdictions FOREIGN KEY (jurisdiction_id) REFERENCES jurisdictions,
	CONSTRAINT farm_emission_correction_factors_grazing_fkey_farm_animal_categories FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories,
	CONSTRAINT farm_emission_correction_factors_grazing_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_emission_correction_factors_fodder
 * ---------------------------------------
 * Tabel met daarin de correctie op emissies wegens het voerbeleid.
 * De correctie is een factor en is hier een reductie (<= 1).
 */
CREATE TABLE farm_emission_correction_factors_fodder (
	farm_animal_category_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	correction_factor posreal NOT NULL,
	description text,

	CONSTRAINT farm_emission_correction_factors_fodder_pkey PRIMARY KEY (farm_animal_category_id, year, substance_id),
	CONSTRAINT farm_emission_correction_factors_fodder_fkey_farm_animal_categories FOREIGN KEY (farm_animal_category_id) REFERENCES farm_animal_categories,
	CONSTRAINT farm_emission_correction_factors_fodder_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);