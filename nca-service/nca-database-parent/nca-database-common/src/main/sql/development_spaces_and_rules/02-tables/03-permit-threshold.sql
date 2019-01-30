/*
 * permit_threshold_values
 * -----------------------
 * Tabel met daarin de grenswaarde per gebied.
 * De grenswaarde van een gebied is standaard 1 mol. Wanneer echter op 1 hexagoon binnen een gebied 95% van de
 * grenswaardereservering bereikt is, wordt de grenswaarde binnen dit gebied op 0.05 mol gezet.
 */
CREATE TABLE permit_threshold_values (
	assessment_area_id integer NOT NULL,
	value posreal NOT NULL,

	CONSTRAINT permit_threshold_values_pkey PRIMARY KEY (assessment_area_id)
);
