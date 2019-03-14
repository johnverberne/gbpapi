INSERT INTO users (api_key,email_address,enabled, max_concurrent_jobs) VALUES ('0000-0000-0000-0000', 'john.verberne@gmail.com', true, 9)

INSERT INTO job_progress (job_id) VALUES (1);
INSERT INTO calculations (calcualtion_uuid) VALUES ("1");
INSERT INTO calculation_results (calculation_id, data) VALUES (1, '<json>');



---
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
