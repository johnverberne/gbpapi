/*
 * users
 * -----
 * Gebruikers voor Scenario. Zij worden uniek geïdentificeerd op basis van e-mail adres of API-key.
 *
 * @column api_key De API-key is bedoeld voor gebruikers die berekeningen doen via de Connect-webservice. Aan de hand hiervan kan
 * het systeem dan de user_id opzoeken.
 * @column max_concurrent_jobs Het maximaal aantal jobs dat de gebruiker tegelijkertijd mag uitvoeren.
 */
CREATE TABLE users (
	user_id serial NOT NULL,
	api_key text NOT NULL,
	email_address text NOT NULL CHECK(email_address = lower(email_address)),
	enabled boolean NOT NULL DEFAULT TRUE,
	max_concurrent_jobs posint NOT NULL,

	CONSTRAINT users_pkey PRIMARY KEY (user_id),
	CONSTRAINT users_unique_api_key UNIQUE (api_key),
	CONSTRAINT users_unique_email_address UNIQUE (email_address)
);


/*
 * jobs
 * ----
 * Rekenjobs die opgepakt zijn of kunnen worden door de worker.
 * Een job is de verzameling van (1 of 2) situaties in een berekening, en er wordt bijgehouden welke gebruiker de job aangemaakt heeft.
 * Dezelfde gebruiker kan verschillende jobs aan zich gekoppeld hebben.
 * De job key wordt gegenereerd en gebruikt door de worker om de koppeling tussen de job en de worker taak bij te houden.
 */
CREATE TABLE jobs (
	job_id serial NOT NULL,
	key text NOT NULL,
	name text,
	state job_state_type NOT NULL DEFAULT 'initialized'::job_state_type,
	type job_type NOT NULL,
	user_id integer NOT NULL,
	error_message text,

	CONSTRAINT jobs_pkey PRIMARY KEY (job_id),
	CONSTRAINT jobs_fkey_users FOREIGN KEY (user_id) REFERENCES users
);

CREATE UNIQUE INDEX idx_jobs_key ON jobs(key);
CREATE INDEX idx_jobs_user_id ON jobs(user_id);


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


/*
 * job_progress
 * ------------
 * Tabel om de voortgang van een (Connect) rekenjob bij te houden.
 *
 * @column progress_count Aantal scenarios doorgerekend
 * @column aantal scenarios in de berkening
 * @column start_time Tijd dat de job door de gebruiker is aangeboden
 * @column pick_up_time Tijd dat de job opgepakt wordt uit de que om te rekenen, of NULL indien nog niet opgepakt
 * @column end_time Tijd dat de job voltooide, of NULL indien (nog) niet succesvol afgerond
 * @column result_url URL naar het bestand waarin de resultaten terug te vinden zijn, of NULL indien de job nog niet voltooid is
 */
CREATE TABLE job_progress (
	job_id integer NOT NULL,
	progress_count bigint NOT NULL DEFAULT 0,
	max_progress bigint NOT NULL DEFAULT 0,
	start_time timestamp with time zone,
	pick_up_time timestamp with time zone,
	end_time timestamp with time zone,
	result_url text,

	CONSTRAINT job_progress_pkey PRIMARY KEY (job_id),
	CONSTRAINT job_progress_fkey_jobs FOREIGN KEY (job_id) REFERENCES jobs
);