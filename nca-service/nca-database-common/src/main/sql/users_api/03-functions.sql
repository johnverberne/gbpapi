/*
 * ae_delete_job
 * -------------
 * Gebruik deze functie om een job te verwijderen inclusief bijbehorende rekenresultaten.
 *
 * @param v_job_id Id van de job die verwijderd moet worden.
 */
CREATE OR REPLACE FUNCTION ae_delete_job(v_job_id integer)
	RETURNS void AS
$BODY$
BEGIN
	PERFORM ae_delete_job_calculations(v_job_id);

	DELETE FROM job_progress WHERE job_id = v_job_id;
	DELETE FROM jobs WHERE job_id = v_job_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

/*
 * ae_delete_job_calculations
 * --------------------------
 * Gebruik deze functie om alleen de rekenresultaten van een job te verwijderen.
 *
 * @param v_job_id Id van de job waarvan de rekenresultaten verwijderd moet worden.
 */
CREATE OR REPLACE FUNCTION ae_delete_job_calculations(v_job_id integer)
	RETURNS void AS
$BODY$
DECLARE
	v_calculation_id integer;
BEGIN
	FOR v_calculation_id IN
		(SELECT calculation_id FROM job_calculations WHERE job_id = v_job_id)
	LOOP
		DELETE FROM job_calculations WHERE job_id = v_job_id AND calculation_id = v_calculation_id;
		PERFORM ae_delete_calculation(v_calculation_id);
	END LOOP;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
