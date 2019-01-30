/*
 * requests
 * --------
 * De aanvraag voor ontwikkelingsruimte (binnen en segment) voor een initiatief.
 * Het gaat hier dus om zowel segment-1 als -2-projecten alsmede meldingen.
 */
CREATE TABLE requests (
	request_id serial NOT NULL,
	segment segment_type NOT NULL,
	status request_status_type NOT NULL DEFAULT 'initial',
	authority_id integer NOT NULL,
	province_area_id integer NOT NULL,
	sector_id integer NOT NULL,
	has_multiple_sectors boolean NOT NULL,
	marked boolean NOT NULL DEFAULT false,
	reference text NOT NULL,
	start_year year_type NOT NULL,
	temporary_period integer,
	corporation text NOT NULL,
	project_name text NOT NULL,
	description text NOT NULL,
	application_version text,
	database_version text,
	insert_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified timestamp without time zone NOT NULL DEFAULT now(),
	geometry geometry(Point),

	CONSTRAINT requests_pkey PRIMARY KEY (request_id),
	CONSTRAINT requests_fkey_authorities FOREIGN KEY (authority_id) REFERENCES authorities,
	CONSTRAINT requests_fkey_province_areas FOREIGN KEY (province_area_id) REFERENCES province_areas,
	CONSTRAINT requests_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);

CREATE UNIQUE INDEX idx_unique_requests_reference ON requests(reference);
CREATE INDEX idx_requests_geometry_gist ON requests USING GIST (geometry);


/*
 * request_files
 * -------------
 * De bestanden die bij een aanvraag horen, zowel initiele bestanden gebruikt om door te rekenen als besluit bestanden.
 */
CREATE TABLE request_files (
	request_id integer NOT NULL,
	file_type request_file_type NOT NULL,
	file_format_type request_file_format_type NOT NULL,
	file_name text,
	content bytea NOT NULL,

	CONSTRAINT request_files_pkey PRIMARY KEY (request_id, file_type),
	CONSTRAINT request_files_fkey_requests FOREIGN KEY (request_id) REFERENCES requests
);


/*
 * request_situation_calculations
 * ------------------------------
 * De berekeningen van een aanvraag, per situatie.
 * Voor een melding wordt deze tabel gevuld op het moment dat de melding wordt gedaan.
 * Bij een vergunning wordt deze tabel pas gevuld op het moment dat de worker klaar is met rekenen.
 * (of in ieder geval niet op het moment dat de vergunning in request/permit wordt aangemaakt).
 * Indien een initiatiefnemer uitbreid moeten er voor twee situaties berekeningen opgegeven worden.
 */
CREATE TABLE request_situation_calculations (
	request_id integer NOT NULL,
	situation situation_type NOT NULL,
	calculation_id integer NOT NULL,

	CONSTRAINT request_situation_calculations_pkey PRIMARY KEY (request_id, situation),
	CONSTRAINT request_situation_calculations_fkey_requests FOREIGN KEY (request_id) REFERENCES requests,
	CONSTRAINT request_situation_calculations_fkey_calculations FOREIGN KEY (calculation_id) REFERENCES calculations
);


/*
 * request_situation_properties
 * ----------------------------
 * De situaties die in een bijlage zitten, met vergunning specifieke eigenschappen per situatie. Vooralsnog alleen de naam.
 * Wordt niet gevuld voor meldingen.
 */
CREATE TABLE request_situation_properties (
	request_id integer NOT NULL,
	situation situation_type NOT NULL,
	name text NOT NULL,

	CONSTRAINT request_situations_pkey PRIMARY KEY (request_id, situation),
	CONSTRAINT request_situations_fkey_requests FOREIGN KEY (request_id) REFERENCES requests
);


/*
 * request_situation_emissions
 * ---------------------------
 * De totale emissies van een bijlage per stof per situatie.
 * Voor ieder record moet er ook een entry zijn in request_situation_properties.
 * Wordt niet gevuld voor meldingen.
 */
CREATE TABLE request_situation_emissions (
	request_id integer NOT NULL,
	situation situation_type NOT NULL,
	substance_id integer NOT NULL,
	total_emission posreal NOT NULL,

	CONSTRAINT request_situation_emissions_pkey PRIMARY KEY (request_id, situation, substance_id),
	CONSTRAINT request_situation_emissions_fkey_request_situation_properties FOREIGN KEY (request_id, situation) REFERENCES request_situation_properties,
	CONSTRAINT request_situation_emissions_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);