/*
 * sector_depositions_no_policies
 * ------------------------------
 * Depositiebijdrage per sector zonder beleid.
 */
CREATE TABLE sector_depositions_no_policies (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	receptor_id integer NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT sector_depositions_no_policies_pkey PRIMARY KEY (receptor_id, year, sector_id),
	CONSTRAINT sector_depositions_no_policies_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sector_depositions_no_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX sector_depositions_no_policies_idx_receptor ON sector_depositions_no_policies (receptor_id);


/*
 * sector_depositions_global_policies
 * ----------------------------------
 * Depositiebijdrage per sector volgens rijksbeleid.
 */
CREATE TABLE sector_depositions_global_policies (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	receptor_id integer NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT sector_depositions_global_policies_pkey PRIMARY KEY (receptor_id, year, sector_id),
	CONSTRAINT sector_depositions_global_policies_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sector_depositions_global_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX sector_depositions_global_policies_idx_receptor ON sector_depositions_global_policies (receptor_id);


/*
 * sector_depositions_jurisdiction_policies
 * ----------------------------------------
 * Depositiebijdrage per sector volgens provinciaalbeleid.
 */
CREATE TABLE sector_depositions_jurisdiction_policies (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	receptor_id integer NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT sector_depositions_jurisdiction_policies_pkey PRIMARY KEY (receptor_id, year, sector_id),
	CONSTRAINT sector_depositions_jurisdiction_policies_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sector_depositions_jurisdiction_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX sector_depositions_jurisdiction_policies_idx_receptor ON sector_depositions_jurisdiction_policies (receptor_id);
CREATE INDEX sector_depositions_jurisdiction_policies_idx_sector ON sector_depositions_jurisdiction_policies (sector_id);


/*
 * other_depositions
 * -----------------
 * Depositiebijdrage die niet aan een sector is toe te kennen.
 */
CREATE TABLE other_depositions (
	year year_type NOT NULL,
	other_deposition_type other_deposition_type NOT NULL,
	receptor_id integer NOT NULL,
	deposition real NOT NULL,

	CONSTRAINT other_depositions_pkey PRIMARY KEY (receptor_id, year, other_deposition_type),
	CONSTRAINT other_depositions_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * depositions_no_policies
 * -----------------------
 * Total depositiebijdrage per receptor zonder beleid.
 * Bevat zowel bijdrage van sectoren als de overige depositie (de bijdrage die niet aan een sector toe te kennen is).
 */
CREATE TABLE depositions_no_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT depositions_no_policies_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT depositions_no_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX depositions_no_policies_idx_year ON depositions_no_policies (year);


/*
 * depositions_global_policies
 * ---------------------------
 * Total depositiebijdrage per receptor volgens rijksbeleid.
 * Bevat zowel bijdrage van sectoren als de overige depositie (de bijdrage die niet aan een sector toe te kennen is).
 */
CREATE TABLE depositions_global_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT depositions_global_policies_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT depositions_global_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * depositions_jurisdiction_policies
 * ---------------------------------
 * Total depositiebijdrage per receptor volgens provinciaalbeleid.
 * Bevat zowel bijdrage van sectoren als de overige depositie (de bijdrage die niet aan een sector toe te kennen is).
 */
CREATE TABLE depositions_jurisdiction_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT depositions_jurisdiction_policies_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT depositions_jurisdiction_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * delta_depositions_no_policies
 * -----------------------------
 * Total depositiedaling t.o.v. het basisjaar, per receptor zonder beleid. Alleen toekomstjaren.
 * Daling is een negatief getal. Kan ook stijging zijn, dan is het een positief getal.
 */
CREATE TABLE delta_depositions_no_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	delta_deposition real NOT NULL,

	CONSTRAINT delta_depositions_no_policies_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT delta_depositions_no_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * delta_depositions_global_policies
 * ---------------------------------
 * Total depositiedaling t.o.v. het basisjaar, per receptor volgens rijksbeleid. Alleen toekomstjaren.
 * Daling is een negatief getal. Kan ook stijging zijn, dan is het een positief getal.
 */
CREATE TABLE delta_depositions_global_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	delta_deposition real NOT NULL,

	CONSTRAINT delta_depositions_global_policies_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT delta_depositions_global_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * delta_depositions_jurisdiction_policies
 * ---------------------------------------
 * Total depositiedaling t.o.v. het basisjaar, per receptor volgens provinciaalbeleid. Alleen toekomstjaren.
 * Daling is een negatief getal. Kan ook stijging zijn, dan is het een positief getal.
 */
CREATE TABLE delta_depositions_jurisdiction_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	delta_deposition real NOT NULL,

	CONSTRAINT delta_depositions_jurisdiction_policies_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT delta_depositions_jurisdiction_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * reductions_jurisdiction_policies
 * --------------------------------
 * Totale reductie per receptor volgens provinciaalbeleid t.o.v. zonder beleid. Alleen toekomstjaren.
 * Reductie is het effect van maatregelen; in deze tabel is dat het verschil tussen de berekende sectorbijdragen zonder beleid en provinciaalbeleid
 * binnen hetzelfde jaar. De berekende sectorbijdragen komen uit het setup schema.
 * Reductie is altijd de afname als positief getal. Als er een toename is, is de reductie 0 (dus niet negatief).
 */
CREATE TABLE reductions_jurisdiction_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	reduction posreal NOT NULL,

	CONSTRAINT reductions_jurisdiction_policies_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT reductions_jurisdiction_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);