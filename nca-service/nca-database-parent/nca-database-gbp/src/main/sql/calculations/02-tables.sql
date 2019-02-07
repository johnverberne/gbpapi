/*
 * calculations
 * ------------
 * Als een gebruiker een berekening start dan worden een aantal berekeningen gedaan.
 * Dit wordt bijgehouden.
 */
CREATE TABLE calculations
(
	calculation_id serial NOT NULL,
	calculation_uuid text, 
	creation_time timestamp with time zone NOT NULL DEFAULT now(),
	state calculation_state_type NOT NULL DEFAULT 'initialized'::calculation_state_type,

	CONSTRAINT calculations_pkey PRIMARY KEY (calculation_id)
);

/*
 * calculation_results
 * -------------------
 * De uitkomst van een berekening.
 * Voor elk model een result set als json opgeslagen.
 */
CREATE TABLE calculation_results
(
	calculation_id integer NOT NULL,
	data jsonb
);



