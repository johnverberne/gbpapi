/*
 * ae_validate_development_space_states
 * ------------------------------------
 * Valideert dat ieder OR-status-type ook een (subset van) aanvraag-status-type is.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_development_space_states()
	RETURNS void AS
$BODY$
BEGIN
	--TODO: apply refactor Bert
	--TODO: currently disabled because it is not the case
	--PERFORM enum_range(NULL::development_space_state)::text[] <@ enum_range(NULL::request_status_type)::text[];
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;
