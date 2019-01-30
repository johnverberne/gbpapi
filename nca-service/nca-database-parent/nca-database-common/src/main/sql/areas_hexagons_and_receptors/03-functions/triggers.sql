/*
 * ae_check_new_assessment_area_id
 * -------------------------------
 * Trigger function that ensures no records can be added to child tables from which the
 * assessment_area_id already exists in the parent table.
 */
CREATE OR REPLACE FUNCTION ae_check_new_assessment_area_id()
	RETURNS trigger AS
$BODY$
DECLARE
	idcheck boolean;
BEGIN
	IF (TG_OP = 'INSERT') THEN
		idcheck := TRUE;
	ELSIF (OLD.assessment_area_id <> NEW.assessment_area_id) THEN
		idcheck := TRUE;
	ELSE
		idcheck := FALSE;
	END IF;

	IF idcheck THEN
		IF (SELECT COUNT(*) FROM assessment_areas WHERE assessment_area_id = NEW.assessment_area_id) > 0 THEN
			RAISE EXCEPTION 'Assessment area % already exists in parent table "assessment_areas"', NEW.assessment_area_id;
			RETURN NULL;
		END IF;
	END IF;

	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


/*
 * ae_check_existing_assessment_area_id
 * ------------------------------------
 * Trigger function that ensures only records can be added to tables referencing assessment_areas
 * where the assessment_area_id exists in the parent table.
 */
CREATE OR REPLACE FUNCTION ae_check_existing_assessment_area_id() RETURNS trigger AS
$BODY$
DECLARE
	idcheck boolean;
BEGIN
	IF (TG_OP = 'INSERT') THEN
		idcheck := TRUE;
	ELSIF (OLD.assessment_area_id <> NEW.assessment_area_id) THEN
		idcheck := TRUE;
	ELSE
		idcheck := FALSE;
	END IF;

	IF idcheck THEN
		IF (SELECT COUNT(*) FROM assessment_areas WHERE assessment_area_id = NEW.assessment_area_id) = 0 THEN
			RAISE EXCEPTION 'Assessment area % does not exist in table "assessment_areas"', NEW.assessment_area_id;
			RETURN NULL;
		END IF;
	END IF;

	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


/*
 * ae_add_existing_assessment_area_id_triggers
 * -------------------------------------------
 * Adds the check existing assessment area trigger to all tables with an assessment_area_id column
 * (except the ones that effectively make up assessment_areas).
 */
CREATE OR REPLACE FUNCTION ae_add_existing_assessment_area_id_triggers()
	RETURNS void AS
$BODY$
DECLARE
	pkey_constraints record;
	sql text;
BEGIN
	FOR pkey_constraints IN
		SELECT (nspname || '.' || relname)::regclass::text AS tablename
			FROM pg_class
				INNER JOIN pg_attribute ON (pg_attribute.attrelid = pg_class.oid)
				INNER JOIN pg_namespace ON (pg_namespace.oid = pg_class.relnamespace)
			WHERE
				pg_attribute.attname = 'assessment_area_id'
				AND pg_class.relkind = 'r'
				AND NOT (nspname || '.' || relname)::regclass = ANY(ARRAY['assessment_areas', 'natura2000_areas',
					'natura2000_directive_areas', 'setup.geometry_of_interests']::regclass[])

			ORDER BY tablename
	LOOP
		sql := 'CREATE TRIGGER ae_trigger_check_existing_assessment_area_id BEFORE INSERT OR UPDATE ON ' || pkey_constraints.tablename
				|| ' FOR EACH ROW EXECUTE PROCEDURE ae_check_existing_assessment_area_id(); ';
		RAISE NOTICE '%', sql;
		EXECUTE sql;
	END LOOP;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
