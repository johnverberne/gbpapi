/*
 * farm_substitution_fractions
 * ---------------------------
 * Tabel met daarin de vervangingsgraad van de stallen.
 */
CREATE TABLE setup.farm_substitution_fractions (
	farm_emission_ceiling_category_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	substitution_fraction fraction NOT NULL,
	description text,

	CONSTRAINT farm_substitution_fraction_pkey PRIMARY KEY (farm_emission_ceiling_category_id, year, substance_id),
	CONSTRAINT farm_substitution_fraction_fkey_farm_emission_ceiling_categories FOREIGN KEY (farm_emission_ceiling_category_id) REFERENCES farm_emission_ceiling_categories,
	CONSTRAINT farm_substitution_fraction_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * farm_grazing_fractions
 * ----------------------
 * Getallen om de weidereductie te berekenen.
 * grazing_lodging_fraction: Aandeel beweiden; deel van stallen die niet permanent opstallen.
 * grazing_reduction: Emissiereductie beweiden; gemiddelde reductie door beweiden, kijkend naar gemiddeld aantal uren beweiding in
 * provincie (5% bij minimaal 720 uur, 10% bij minimaal 1500 uur en 15% bij minimaal 2200 uur).
 */
CREATE TABLE setup.farm_grazing_fractions (
	jurisdiction_id integer NOT NULL,
	substance_id smallint NOT NULL,
	grazing_lodging_fraction fraction NOT NULL,
	grazing_reduction_fraction fraction NOT NULL,
	description text,

	CONSTRAINT farm_grazing_fractions_pkey PRIMARY KEY (jurisdiction_id, substance_id),
	CONSTRAINT farm_grazing_fractions_fkey_jurisdictions FOREIGN KEY (jurisdiction_id) REFERENCES jurisdictions,
	CONSTRAINT farm_grazing_fractions_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);
