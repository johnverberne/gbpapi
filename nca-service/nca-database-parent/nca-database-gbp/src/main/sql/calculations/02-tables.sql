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
	model text,
	geolayer text,
	data jsonb
);


/*
 * job_calculations
 * ----------------
 * Koppeltabel (1:N) tussen berekeningen en de job waar deze berekening bijhoren.
 * Een job kan dus meerdere berekeningen aan zich gekoppeld hebben. In praktijk maximaal 2: de 'current' en 'proposed' situatie.
*/
CREATE TABLE job_calculations (
	job_id integer NOT NULL,
	calculation_id integer NOT NULL,

	CONSTRAINT job_calculations_pkey PRIMARY KEY (job_id, calculation_id),	
	CONSTRAINT job_calculations_fkey_jobs FOREIGN KEY (job_id) REFERENCES jobs,
	CONSTRAINT job_calculations_fkey_calculations FOREIGN KEY (calculation_id) REFERENCES calculations
);

CREATE UNIQUE INDEX idx_job_calculations_job_calculation_id ON job_calculations(calculation_id);



