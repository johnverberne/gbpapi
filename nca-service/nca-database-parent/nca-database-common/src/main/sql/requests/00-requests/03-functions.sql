/*
 * ae_check_for_request_space
 * --------------------------
 * Retourneert TRUE indien er voor de request genoeg ontwikkelingsruimte over is binnen zijn segment.
 * Als een request geen development_space_demand heeft is er ruimte, tenzij de status "initial" is want dan zijn de rekenresultaten (nog) onbekend en zou
 * je deze functie uberhaupt niet moeten aanroepen.
 *
 * @column has_space_after_assigned Of er genoeg ruimte is voor de aanvraag, kijkend naar hoeveel ruimte er al toegekend is.
 * @column has_space_after_utilized Of er genoeg ruimte is voor de aanvraag, kijkend naar hoeveel ruimte er al benut is (assigned + pending_with_space).
 * @column has_space_after_requested Of er genoeg ruimte is voor de aanvraag, kijkend naar hoeveel ruimte al toegekend is (assigned) en tijdeljk toegekend is (pending*).
 */
CREATE OR REPLACE FUNCTION ae_check_for_request_space(IN v_request_id integer, OUT has_space_after_assigned boolean, OUT has_space_after_utilized boolean, OUT has_space_after_requested boolean) AS
$BODY$
BEGIN
	SELECT
		COALESCE(
			bool_and(ae_has_space(available.available_after_assigned, development_space_demand)),
			bool_and(status <> 'initial')
		) AS has_space_after_assigned,
		COALESCE(
			bool_and(ae_has_space(available.available_after_utilized, development_space_demand)),
			bool_and(status <> 'initial')
		) AS has_space_after_utilized,
		COALESCE(
			bool_and(ae_has_space(available.available_after_requested, development_space_demand)),
			bool_and(status <> 'initial')
		) AS has_space_after_requested

		INTO has_space_after_assigned, has_space_after_utilized, has_space_after_requested

		FROM requests
			LEFT JOIN (SELECT * FROM request_demands_view WHERE development_space_demand > 0) AS demands USING (request_id)
			LEFT JOIN available_development_spaces_view AS available USING (segment, receptor_id)

		WHERE request_id = v_request_id
	;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_delete_request
 * -----------------
 * Gebruik deze functie om een aanvraag te verwijderen inclusief bijbehorende rekenresultaten.
 * Indien nodig wordt de berekening ook van de totalen afgetrokken.
 *
 * LET OP: Je moet deze niet los aanroepen, dit gebeurt vanzelf vanuit de functies welke een vergunning of melding verwijderen.
 *
 * @param v_request_id Id van de aanvraag die verwijderd moet worden.
 * @param v_only_inactive_initial TRUE indien de aanvraag alleen verwijderd mag worden als deze niet-actief is. Dat wil zeggen dat deze nog niet in het proces
 * is opgenomen (status = INITIAL) en er geen berekeningen voor gaande zijn. Dit kan het geval zijn als een nieuw-geimporteerde berekening is mislukt. Dit soort
 * rondzwevende aanvragen moeten ook uit het systeem verwijderd kunnen worden door gebruikers met beperkte rechten.
 */
CREATE OR REPLACE FUNCTION ae_delete_request(v_request_id integer, v_only_inactive_initial boolean = FALSE)
	RETURNS void AS
$BODY$
DECLARE
	v_segment segment_type;
	v_status request_status_type;
	v_reference text;
	v_space_state development_space_state;
	v_proposed_calculation_id integer = NULL;
	v_current_calculation_id integer = NULL;
BEGIN
	SELECT segment, status, reference INTO STRICT v_segment, v_status, v_reference FROM requests WHERE request_id = v_request_id;

	IF v_status = 'initial' AND v_only_inactive_initial THEN
		IF EXISTS (SELECT calculation_id FROM request_situation_calculations INNER JOIN calculations USING (calculation_id) WHERE request_id = v_request_id AND state = 'running') THEN
			RAISE EXCEPTION 'Geen rechten om aanvragen te verwijderen die actief zijn (kenmerk = %)', v_reference USING ERRCODE = 'AE106';
		END IF;
	END IF;

	SELECT calculation_id INTO v_proposed_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'proposed';
	SELECT calculation_id INTO v_current_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'current';

	v_space_state := v_status::development_space_state;

	IF v_space_state IS NOT NULL AND v_segment <> 'priority_projects' THEN -- Remove request from assigned or other space.
		PERFORM ae_adjust_development_space('subtract', v_segment, v_space_state, v_proposed_calculation_id, v_current_calculation_id);
	END IF;

	-- Delete calculations
	DELETE FROM request_situation_calculations WHERE request_id = v_request_id;
	IF v_proposed_calculation_id IS NOT NULL THEN -- A permit could have no calculations (initial)
		PERFORM ae_delete_calculation(v_proposed_calculation_id);
	END IF;
	IF v_current_calculation_id IS NOT NULL THEN
		PERFORM ae_delete_calculation(v_current_calculation_id);
	END IF;

	DELETE FROM request_files WHERE request_id = v_request_id;
	DELETE FROM request_situation_emissions WHERE request_id = v_request_id;
	DELETE FROM request_situation_properties WHERE request_id = v_request_id;
	DELETE FROM requests WHERE request_id = v_request_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

/*
 * ae_requests_within_distance
 * ---------------------------
 * Convenience SQL functie voor het bepalen van demands requests (zowel aanvragen als meldingen)
 * die binnen 10km van een bepaalde request liggen.
 */
CREATE OR REPLACE FUNCTION ae_requests_within_distance(v_request_id integer, v_max_distance integer)
    RETURNS TABLE(request_id integer, distance double precision) AS
$BODY$
	SELECT
		others.request_id,
		ST_Distance(target.geometry, others.geometry) AS distance

		FROM requests AS target
			INNER JOIN requests AS others ON ST_DWithin(target.geometry, others.geometry, v_max_distance)

		WHERE
			target.request_id = v_request_id
			AND target.request_id != others.request_id;
	;
$BODY$
LANGUAGE sql STABLE;


/*
 * ae_development_rule_request_checks
 * ----------------------------------
 * Bepaal de uitkomsten van alle beleidsregels voor het opgegeven segment.
 */
CREATE OR REPLACE FUNCTION ae_development_rule_request_checks(v_request_id integer, v_type segment_type)
	RETURNS TABLE(receptor_id integer, rule development_rule_type, passed boolean) AS
$BODY$
DECLARE
	v_proposed_calculation_id integer;
	v_current_calculation_id integer;
BEGIN
	SELECT proposed_calculation_id, current_calculation_id INTO v_proposed_calculation_id, v_current_calculation_id FROM request_calculations_view WHERE request_id = v_request_id;

	--TODO: something with wachtrij. For now just use the calculator version.

	RETURN QUERY SELECT * FROM ae_development_rule_checks(v_proposed_calculation_id, v_current_calculation_id, v_type);
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
