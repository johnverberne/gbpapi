/*
 * years
 * -----
 * AERIUS beleidsjaren (de jaren waarvoor de verschillende beleidsscenario's doorgerekend zijn)
 * en de AERIUS bronjaren (de jaren van de doorgerekende bronbestanden). 
 */
CREATE TABLE years (
	year year_type NOT NULL,
	year_category year_category_type NOT NULL,

	CONSTRAINT years_pkey PRIMARY KEY (year, year_category)
);


/*
 * substances
 * ----------
 * Stoffen
 */
CREATE TABLE substances (
	substance_id smallint NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT substances_pkey PRIMARY KEY (substance_id)
);