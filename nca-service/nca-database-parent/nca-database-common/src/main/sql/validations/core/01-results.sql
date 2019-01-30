/*
 * validation_runs
 * ---------------
 * Tabel voor het opslaan van de validatie-runs.
 * Van elke runs wordt er in deze tabel een entry opgeslagen.
 * Een validatie-run hoort altijd bij een specifieke backend verbinding. Bij het draaien van validaties in een nieuwe verbinding hoort
 * dus ook een nieuw validation_run_id. Dit wordt automatisch gedaan door de validatie-logger-functie.
 */
CREATE TABLE setup.validation_runs (
	validation_run_id serial NOT NULL,
	transaction_id bigint NOT NULL,

	CONSTRAINT validation_runs_pkey PRIMARY KEY (validation_run_id)
);


/*
 * validation_results
 * ------------------
 * Tabel voor het opslaan van de validatie-runs.
 * Van elke validatie wordt er in deze tabel het resultaat opgeslagen.
 */
CREATE TABLE setup.validation_results (
	validaton_result_id serial NOT NULL,
	validation_run_id integer NOT NULL,
	name regproc NOT NULL,
	result setup.validation_result_type NOT NULL,

	CONSTRAINT validation_results_pkey PRIMARY KEY (validaton_result_id),
	CONSTRAINT validation_results_fkey_validaton_runs FOREIGN KEY (validation_run_id) REFERENCES setup.validation_runs,
	CONSTRAINT validation_results_unique_combination UNIQUE (validation_run_id, name)
);


/*
 * validation_logs
 * ---------------
 * Tabel voor het opslaan van de validatie-runs.
 * Van elke test binnen een validatie wordt er in deze tabel het resultaat opgeslagen.
 */
CREATE TABLE setup.validation_logs (
	validation_log_id serial NOT NULL,
	validation_run_id integer NOT NULL,
	name regproc NOT NULL,
	result setup.validation_result_type NOT NULL,
	object text,
	message text NOT NULL,

	CONSTRAINT validation_logs_pkey PRIMARY KEY (validation_log_id),
	CONSTRAINT validation_logs_fkey_validaton_runs FOREIGN KEY (validation_run_id) REFERENCES setup.validation_runs
);


/*
 * last_validation_run_results_view
 * --------------------------------
 * Deze view retourneert de validatie resultaten van de laatste validatie-run.
 * Voor iedere validatie-functie wordt het 'ergste' resultaat teruggegeven (bevat 1 onderdeel een warning en 1 ander een error, dan wordt error geretourneerd).
 */
CREATE OR REPLACE VIEW setup.last_validation_run_results_view AS
SELECT
	validation_run_id,
	name,
	result

	FROM setup.validation_results
		INNER JOIN (SELECT validation_run_id FROM setup.validation_runs ORDER BY validation_run_id DESC LIMIT 1) AS last_run_id USING (validation_run_id)

	ORDER BY validation_run_id, result DESC, name
;


/*
 * last_validation_logs_view
 * -------------------------
 * Deze view retourneert de validatie logs van de laatste validatie-run.
 */
CREATE OR REPLACE VIEW setup.last_validation_logs_view AS
SELECT
	validation_run_id,
	name,
	run_results.result AS run_result,
	logs.result AS log_result,
	object,
	message

	FROM setup.last_validation_run_results_view AS run_results
		INNER JOIN setup.validation_logs AS logs USING (validation_run_id, name)

	ORDER BY validation_run_id, run_result DESC, log_result DESC, name, object
;


/*
 * last_validation_run_view
 * ------------------------
 * Deze view retourneert de validatie-statistieken van de laatste validatie-run.
 * De resultaten van elke validatie zijn geaggregeerd per result type.
 */
CREATE OR REPLACE VIEW setup.last_validation_run_view AS
SELECT
	validation_run_id,
	result,
	COALESCE(COUNT(name), 0) AS number_of_tests

	FROM (SELECT validation_run_id FROM setup.validation_runs ORDER BY validation_run_id DESC LIMIT 1) AS last_run_id
		CROSS JOIN (SELECT unnest(enum_range(null::setup.validation_result_type)) AS result) AS result_types
		LEFT JOIN setup.validation_results USING (validation_run_id, result)

	GROUP BY validation_run_id, result

	ORDER BY validation_run_id, result DESC
;