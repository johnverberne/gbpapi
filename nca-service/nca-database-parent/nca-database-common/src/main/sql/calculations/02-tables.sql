/*
 * calculation_point_sets
 * ----------------------
 * Als een gebruiker een berekening start in de Calculator, dan kan daarbij een door de gebruiker gedefinieerde set aan rekenpunten gebruikt worden.
 * Meerdere berekeningen kunnen dezelfde set aan punten gebruiken.
 * Die set van punten wordt via deze tabel bijgehouden.
 */
CREATE TABLE calculation_point_sets
(
	calculation_point_set_id serial NOT NULL,

	CONSTRAINT calculation_point_sets_pkey PRIMARY KEY (calculation_point_set_id)
);


/*
 * calculation_points
 * ------------------
 * De punten die een gebruiker heeft opgegeven om te berekenen.
 * Een rekenpunt wordt geidentificeerd door de combinatie van een calculation point set ID en een punt ID. Het punt ID is uniek binnen de context van een set.
 * "nearest_receptor_id" is het ID van de dichtstbij liggende receptor uit het hexagonengrid. Dit
 * ID wordt gebruikt voor het snel toewijzen van omgevingskenmerken (ruwheidslengte e.d.).
 */
CREATE TABLE calculation_points (
	calculation_point_set_id integer NOT NULL,
	calculation_point_id integer NOT NULL,
	label text,
	nearest_receptor_id integer NOT NULL,
	geometry geometry(Point),

	CONSTRAINT calculation_points_pkey PRIMARY KEY (calculation_point_set_id, calculation_point_id),
	CONSTRAINT calculation_points_fkey_calculation_point_sets FOREIGN KEY (calculation_point_set_id) REFERENCES calculation_point_sets
);

CREATE INDEX idx_calculation_points_gist ON calculation_points USING GIST (geometry);


/*
 * calculations
 * ------------
 * Als een gebruiker een berekening start in de Calculator, dan worden een aantal berekeningen gedaan.
 * De resultaten van deze berekeningen worden samen gebracht onder 1 calculation, die in deze tabel komen te staan.
 * Een berekening heeft een eigen ID en de status van de berekening wordt ook bijgehouden.
 */
CREATE TABLE calculations
(
	calculation_id serial NOT NULL,
	calculation_point_set_id integer,
	year year_type NOT NULL,
	creation_time timestamp with time zone NOT NULL DEFAULT now(),
	state calculation_state_type NOT NULL DEFAULT 'initialized'::calculation_state_type,

	CONSTRAINT calculations_pkey PRIMARY KEY (calculation_id),
	CONSTRAINT calculations_fkey_calculation_point_sets FOREIGN KEY (calculation_point_set_id) REFERENCES calculation_point_sets
);


/*
 * calculation_batch_options
 * -------------------------
 * Voor de custom en batch jobs zijn er per berekening een paar instellingen. Deze worden hier opgeslagen.
 */
CREATE TABLE calculation_batch_options
(
	calculation_id integer NOT NULL,
	description text,
	input_file text,

	CONSTRAINT calculation_batch_options_pkey PRIMARY KEY (calculation_id),
	CONSTRAINT calculation_batch_options_fkey_calculations FOREIGN KEY (calculation_id) REFERENCES calculations
);


/*
 * calculation_result_sets
 * -----------------------
 * Per calculation zullen er 1 of meerdere resultaten per receptor zijn. Deze resultaten worden per stof/resultaat type bijeengehouden in een result set.
 * Een result set heeft een eigen ID.
 */
CREATE TABLE calculation_result_sets
(
	calculation_result_set_id serial NOT NULL,
	calculation_id integer NOT NULL,
	result_set_type calculation_result_set_type NOT NULL,
	result_set_type_key integer NOT NULL,
	result_type emission_result_type NOT NULL,
	substance_id smallint NOT NULL,

	CONSTRAINT calculation_result_sets_pkey PRIMARY KEY (calculation_result_set_id),
	CONSTRAINT calculation_result_sets_fkey_calculation FOREIGN KEY (calculation_id) REFERENCES calculations,
	CONSTRAINT calculation_result_sets_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances,
	CONSTRAINT calculation_result_sets_unique_combination UNIQUE (calculation_id, result_set_type, result_set_type_key, result_type, substance_id),
	CONSTRAINT calculation_result_sets_type_key CHECK (
		(result_set_type = 'total' AND result_set_type_key = 0)
		OR (result_set_type = 'sector' AND result_set_type_key != 0))
);

CREATE INDEX idx_calculation_result_sets_by_calculation_id 
		ON calculation_result_sets (calculation_id, result_set_type, substance_id, result_type);
CREATE INDEX idx_calculation_result_sets_with_result_set_type_key 
		ON calculation_result_sets (calculation_id, result_set_type, result_set_type_key, substance_id, result_type);


/*
 * calculation_results
 * -------------------
 * De uitkomst van een berekening.
 * Per receptor worden resultaten opgeslagen.
 * Om welke stof het gaat en in welke vorm deze stof zich bevindt is te vinden in de calculation_result_sets tabel.
 *
 * Omdat ook resultaten worden berekend voor locaties waar zich geen natuurgebied bevindt (en er dus geen vermelding in receptors tabel is)
 * bevat deze tabel geen foreign key naar receptors.
 */
CREATE TABLE calculation_results
(
	calculation_result_set_id integer NOT NULL,
	receptor_id integer NOT NULL,
	result posreal NOT NULL,

	CONSTRAINT calculation_results_pkey PRIMARY KEY (calculation_result_set_id, receptor_id),
	CONSTRAINT calculation_results_fkey_calculation_result_sets FOREIGN KEY (calculation_result_set_id) REFERENCES calculation_result_sets
);

CREATE INDEX idx_calculation_results_by_calculation_set_id 
		ON calculation_results (calculation_result_set_id);


/*
 * calculation_point_results
 * -------------------------
 * De uitkomst van een berekening voor een door de gebruiker gedefinieerd punt.
 * Per punt worden resultaten opgeslagen.
 * Om welke stof het gaat en in welke vorm deze stof zich bevindt is te vinden in de calculation_result_set tabel.
 */
CREATE TABLE calculation_point_results
(
	calculation_result_set_id integer NOT NULL,
	calculation_point_id integer NOT NULL,
	result posreal NOT NULL,

	CONSTRAINT calculation_point_results_pkey PRIMARY KEY (calculation_result_set_id, calculation_point_id),
	CONSTRAINT calculation_point_results_fkey_calculation_result_set FOREIGN KEY (calculation_result_set_id) REFERENCES calculation_result_sets
);

CREATE INDEX idx_calculation_point_results_by_calculation_set_id 
		ON calculation_point_results (calculation_result_set_id);


/*
 * permit_calculation_radius_types
 * -------------------------------
 * Domeintabel met daarin de verschillende afstandsgrens-types voor Wet natuurbescherking berkeningen.
 *
 * De naam van deze tabel is afwijkend. Volgens de conventie had deze tabel namelijk request_calculation_radius_types moeten heten.
 * Het gaat echter om een domeintabel voor IMAER waarbij het veld in IMAER afwijkend is (om daar aan de conventie te voldoen).
 * Het gaat daar namelijk om een property van de calculationType PERMIT.
 */
CREATE TABLE permit_calculation_radius_types
(
	permit_calculation_radius_type_id integer NOT NULL,
	code text NOT NULL,
	name text NOT NULL,
	radius posint NOT NULL,

	CONSTRAINT permit_calculation_radius_types_pkey PRIMARY KEY (permit_calculation_radius_type_id),
	CONSTRAINT permit_calculation_radius_types_code_unique UNIQUE (code)
);