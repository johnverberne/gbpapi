/*
 * ae_change_priority_subproject_state
 * -----------------------------------
 * Gebruik deze functie om de status van een prioritair deelproject te veranderen. De OR-totalen worden geupdate wanneer dat nodig is.
 *
 * @param v_request_id Het prioritair deelproject waarvan de status veranderd moet worden.
 * @param v_new_status De nieuwe status van het prioritair deelproject.
 * @param v_only_within_total_reservation Boolean die aangeeft of het wijzigen naar toegekend kan alleen kan wanneer dit past binnen de totale reservering voor prioritaire projecten (true)
 * of dat dit altijd mag zolang het maar binnen de reservering van het koepelproject past.
 */
CREATE OR REPLACE FUNCTION ae_change_priority_subproject_state(v_request_id integer, v_new_status request_status_type, v_only_within_total_reservation boolean = TRUE)
	RETURNS void AS
$BODY$
DECLARE
	v_status request_status_type;
	v_reference text;
	v_priority_project_request_id integer;
	v_old_space_state development_space_state = NULL;
	v_new_space_state development_space_state = NULL;
BEGIN
	SELECT status, reference, priority_project_request_id INTO STRICT v_status, v_reference, v_priority_project_request_id FROM priority_subprojects INNER JOIN requests USING (request_id) WHERE request_id = v_request_id;

	-- Determine development space statuses
	v_old_space_state := v_status::development_space_state;
	v_new_space_state := v_new_status::development_space_state;

	-- Ensure no illegal status change
	PERFORM ae_validate_priority_subproject_state_change(v_status, v_new_status, v_reference);

	-- Now (when needed) move the development space around
	IF v_old_space_state IS DISTINCT FROM v_new_space_state THEN

		-- We lock this table exclusively. Meaning that a second attempt to lock it like this, will result in a pause until the first lock is cleared.
		-- That happens when the function is done and thus the transaction ends.
		-- So in other words, if this function is ran concurrently, it will never interfere with itself.
		-- No other process can do UPDATEs or INSERTs while the table is locked.
		-- SELECTs are still possible, for the webapp to show graphs etc. These are based on the snapsnot of when the transaction begun.
		LOCK TABLE development_spaces IN EXCLUSIVE MODE;
		PERFORM 1 FROM priority_project_development_spaces WHERE request_id = v_priority_project_request_id FOR UPDATE;

		-- In case we want to assign space, make sure there is enough.
		IF v_new_space_state = 'assigned' AND ae_check_for_priority_subproject_space(v_request_id) IS FALSE THEN
			RAISE EXCEPTION 'Geen rechten om prioritaire deelprojecten toe te kennen wanneer er niet voldoende reserveringsruimte over is in het prioritair project (kenmerk = %)', v_reference
				USING ERRCODE = 'AE303';
		END IF;
		IF v_new_space_state = 'assigned' AND v_only_within_total_reservation AND (ae_check_for_request_space(v_request_id)).has_space_after_assigned IS FALSE THEN
			RAISE EXCEPTION 'Geen rechten om prioritaire deelprojecten toe te kennen wanneer er niet voldoende ruimte vrij is in segment 1 (kenmerk = %)', v_reference
				USING ERRCODE = 'AE302';
		END IF;

		IF v_old_space_state IS NOT NULL THEN
			-- Remove calculations from the old development space state
			PERFORM ae_adjust_priority_project_development_space('subtract', v_priority_project_request_id, v_request_id);
		END IF;

		IF v_new_space_state IS NOT NULL THEN
			-- Add calculations to the new development space state
			PERFORM ae_adjust_priority_project_development_space('add', v_priority_project_request_id, v_request_id);
		END IF;
	END IF;

	-- Update last modified flag and status
	UPDATE requests SET status = v_new_status, last_modified = NOW() WHERE request_id = v_request_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_validate_priority_subproject_state_change
 * --------------------------------------------
 * Gebruik deze functie om te kijken of een status wijziging van een prioritair deelproject valide is.
 *
 * @param v_old_status De oude/huidige status van het prioritair deelproject.
 * @param v_new_status De nieuwe status van het prioritair deelproject.
 * @param v_reference Kenmerk van het prioritair deelproject (voor exceptie teksten).
 */
CREATE OR REPLACE FUNCTION ae_validate_priority_subproject_state_change(v_old_status request_status_type, v_new_status request_status_type, v_reference text)
	RETURNS void AS
$BODY$
BEGIN
	IF v_old_status = v_new_status THEN
		RAISE EXCEPTION 'Prioritair deelproject % heeft reeds de status "%"', v_reference, v_new_status;

	ELSIF v_old_status IN ('pending_with_space', 'pending_without_space') THEN
		RAISE EXCEPTION 'Prioritair deelproject % is ongeldig; heeft status "%"', v_reference, v_old_status;
	ELSIF v_new_status IN ('pending_with_space', 'pending_without_space') THEN
		RAISE EXCEPTION 'Prioritaire deelprojecten kunnen niet de status "%" krijgen (kenmerk = %)', v_new_status, v_reference;

	ELSIF v_new_status = 'initial' THEN
		RAISE EXCEPTION 'Prioritaire deelprojecten kunnen niet terug naar status "initial" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'queued' AND v_old_status <> 'initial' THEN
		RAISE EXCEPTION 'Prioritaire deelprojecten kunnen alleen naar status "queued" vanuit status "initial" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'assigned' AND v_old_status NOT IN ('queued', 'rejected_without_space') THEN
		RAISE EXCEPTION 'Prioritaire deelprojecten kunnen alleen naar status "assigned" vanuit status "queued" of "rejected_without_space" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'assigned_final' AND v_old_status <> 'assigned' THEN
		RAISE EXCEPTION 'Prioritaire deelprojecten kunnen alleen naar status "assigned_final" vanuit status "assigned" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'rejected_without_space' AND v_old_status NOT IN ('queued', 'assigned', 'assigned_final') THEN
		RAISE EXCEPTION 'Prioritaire deelprojecten kunnen alleen naar status "rejected_without_space" vanuit status "queued", "assigned_final" of "assigned_final" (kenmerk = %)', v_reference;

	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_delete_priority_project
 * --------------------------
 * Gebruik deze functie om een volledig prioritair project te verwijderen, inclusief alle rekenresultaten en het bijstellen van de totalen.
 * Ook alle onderliggende deelprojecten worden dus verwijderd!! Hierdoor is er ook geen reservering en toekenning meer binnen dit prioritair project.
 *
 * @param v_request_id Id van het prioritair project dat verwijderd moet worden.
 *
 * TODO: zie note bij ATTENTION hieronder, volgens mij hangen er tegenwoordig ook berekeningen aan...
 */
CREATE OR REPLACE FUNCTION ae_delete_priority_project(v_request_id integer)
	RETURNS void AS
$BODY$
DECLARE
	v_reference text;
	v_priority_subproject_request_id integer;
BEGIN
	SELECT reference INTO STRICT v_reference FROM priority_projects INNER JOIN requests USING (request_id) WHERE request_id = v_request_id; -- Ensure PP exists

	-- Delete the priority project from the priority project spaces table. Deleting the subprojects is faster too when these records are already gone.
	DELETE FROM priority_project_development_spaces WHERE request_id = v_request_id;

	FOR v_priority_subproject_request_id IN (SELECT request_id FROM priority_subprojects WHERE priority_project_request_id = v_request_id)
	LOOP
		PERFORM ae_delete_priority_subproject(v_priority_subproject_request_id);
	END LOOP;

	DELETE FROM priority_projects WHERE request_id = v_request_id;

	PERFORM ae_delete_request(v_request_id); -- Deleting from development_spaces::'priority_projects' is a NO-OP.

	-- Also adjusted is 'development_spaces'. Should we do something with the S1 reservation in 'reserved_development_spaces'? Because we *do*
	-- delete associated calculations
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_delete_priority_subproject
 * -----------------------------
 * Gebruik deze functie om een prioritair deelproject te verwijderen, inclusief alle rekenresultaten en het bijstellen van de OR in het bovenliggende
 * prioritair project en de totalen.
 *
 * @param v_request_id Id van de aanvraag die verwijderd moet worden.
 */
CREATE OR REPLACE FUNCTION ae_delete_priority_subproject(v_request_id integer)
	RETURNS void AS
$BODY$
DECLARE
	v_status request_status_type;
	v_reference text;
	v_priority_project_request_id integer;
BEGIN
	SELECT status, reference, priority_project_request_id INTO STRICT v_status, v_reference, v_priority_project_request_id FROM priority_subprojects INNER JOIN requests USING (request_id) WHERE request_id = v_request_id;

	IF v_status::development_space_state IS NOT DISTINCT FROM 'assigned' THEN
		PERFORM ae_adjust_priority_project_development_space('subtract', v_priority_project_request_id, v_request_id);
	END IF;

	DELETE FROM priority_subprojects WHERE request_id = v_request_id;

	PERFORM ae_delete_request(v_request_id); -- Deleting from development_spaces::'priority_subprojects' is a NO-OP.
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
