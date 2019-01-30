/*
 * ae_check_new_layer_properties_id
 * --------------------------------
 * Trigger function that ensures no records can be added to child tables from which the
 * layer_properties_id already exists in the parent table.
 */
CREATE OR REPLACE FUNCTION system.ae_check_new_layer_properties_id()
	RETURNS trigger AS
$BODY$
DECLARE
	idcheck boolean;
BEGIN
	IF (TG_OP = 'INSERT') THEN
		idcheck := TRUE;
	ELSIF (OLD.layer_properties_id <> NEW.layer_properties_id) THEN
		idcheck := TRUE;
	ELSE
		idcheck := FALSE;
	END IF;

	IF idcheck THEN
		IF (SELECT COUNT(*) FROM system.layer_properties WHERE layer_properties_id = NEW.layer_properties_id) > 0 THEN
			RAISE EXCEPTION 'Layer % already exists in parent table "system.layer_properties"', NEW.layer_properties_id;
			RETURN NULL;
		END IF;
	END IF;

	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;
