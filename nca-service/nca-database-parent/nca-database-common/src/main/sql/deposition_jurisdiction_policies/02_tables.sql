/*
 * depositions_jurisdiction_policies
 * ---------------------------------
 * Totale initiele deposities na provinciaal beleid (0-scenario berekening).
 */
CREATE TABLE depositions_jurisdiction_policies (
	year year_type NOT NULL,
	receptor_id integer NOT NULL,
	total_deposition posreal NOT NULL,

	CONSTRAINT depositions_jurisdiction_policies_pkey PRIMARY KEY (year, receptor_id),
	CONSTRAINT depositions_jurisdiction_policies_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);
