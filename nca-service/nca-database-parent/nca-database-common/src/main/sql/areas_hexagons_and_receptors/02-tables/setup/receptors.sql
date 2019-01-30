/*
 * uncalculated_receptors
 * ----------------------
 * De lijst van de receptoren die niet doorgerekend zijn.
 * In monitor is bijvoorbeeld enkel zoom_level 3 doorgerekend.
 */
CREATE TABLE setup.uncalculated_receptors (
	receptor_id integer NOT NULL,

	CONSTRAINT uncalculated_receptors_pkey PRIMARY KEY (receptor_id),
	CONSTRAINT uncalculated_receptors_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);