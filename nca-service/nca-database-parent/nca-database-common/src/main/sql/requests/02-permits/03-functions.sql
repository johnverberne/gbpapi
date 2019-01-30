/*
 * ae_check_unique_dossier_id_per_authority
 * ----------------------------------------
 * Trigger function that ensures a dossier ID is unique within its authority.
 */
CREATE OR REPLACE FUNCTION ae_check_unique_dossier_id_per_authority()
	RETURNS trigger AS
$BODY$
DECLARE
	v_check_authority authorities%ROWTYPE;
	v_count bigint;
BEGIN
	SELECT
		authorities.* INTO v_check_authority

		FROM requests
			INNER JOIN authorities USING (authority_id)

		WHERE requests.request_id = NEW.request_id
	;

	SELECT
		COUNT(*) INTO v_count

		FROM permits
			INNER JOIN requests USING (request_id)
			INNER JOIN authorities USING (authority_id)

		WHERE
			dossier_id = NEW.dossier_id
			AND request_id != NEW.request_id
			AND authority_id = v_check_authority.authority_id
	;

	IF v_count > 0 THEN
		RAISE EXCEPTION 'Dossier ID % already exists for authority %', NEW.dossier_id, v_check_authority.code;
		RETURN NULL;
	END IF;

	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


/*
 * ae_change_permit_state
 * ----------------------
 * Gebruik deze functie om de status van een vergunningsstatus te veranderen. De OR-totalen worden geupdate wanneer dat nodig is.
 *
 * @param v_request_id De vergunning waarvan de status veranderd moet worden.
 * @param v_new_status De nieuwe status van de vergunning.
 */
CREATE OR REPLACE FUNCTION ae_change_permit_state(v_request_id integer, v_new_status request_status_type)
	RETURNS void AS
$BODY$
DECLARE
	v_segment segment_type;
	v_status request_status_type;
	v_reference text;
	v_old_space_state development_space_state = NULL;
	v_new_space_state development_space_state = NULL;
	v_proposed_calculation_id integer;
	v_current_calculation_id integer = NULL;
BEGIN
	SELECT segment, status, reference INTO STRICT v_segment, v_status, v_reference FROM permits INNER JOIN requests USING (request_id) WHERE request_id = v_request_id;

	-- Determine development space statuses
	v_old_space_state := v_status::development_space_state;
	v_new_space_state := v_new_status::development_space_state;

	-- Ensure no illegal status change
	PERFORM ae_validate_permit_state_change(v_status, v_new_status, v_reference);

	-- Now (when needed) move the development space around
	IF v_old_space_state IS DISTINCT FROM v_new_space_state THEN

		SELECT calculation_id INTO STRICT v_proposed_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'proposed';
		SELECT calculation_id INTO v_current_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'current';

		-- We lock this table exclusively. Meaning that a second attempt to lock it like this, will result in a pause until the first lock is cleared.
		-- That happens when the function is done and thus the transaction ends.
		-- So in other words, if this function is ran concurrently, it will never interfere with itself.
		-- No other process can do UPDATEs or INSERTs while the table is locked.
		-- SELECTs are still possible, for the webapp to show graphs etc. These are based on the snapsnot of when the transaction begun.
		LOCK TABLE development_spaces IN EXCLUSIVE MODE;

		-- In case we want to assign space, make sure there is enough.
		IF v_new_space_state = 'assigned' AND (ae_check_for_request_space(v_request_id)).has_space_after_assigned IS FALSE THEN
			RAISE EXCEPTION 'Geen rechten om vergunningsaanvragen toe te kennen wanneer er geen ontwikkelingsruimte is (kenmerk = %)', v_reference
				USING ERRCODE = 'AE105';
		END IF;

		IF v_old_space_state IS NOT NULL THEN
			-- Remove calculations from the old development space state
			PERFORM ae_adjust_development_space('subtract', v_segment, v_old_space_state, v_proposed_calculation_id, v_current_calculation_id);
		END IF;

		IF v_new_space_state IS NOT NULL THEN
			-- Add calculations to the new development space state
			PERFORM ae_adjust_development_space('add', v_segment, v_new_space_state, v_proposed_calculation_id, v_current_calculation_id);
		END IF;
	END IF;

	-- Update last modified flag and status
	UPDATE requests SET status = v_new_status, last_modified = NOW() WHERE request_id = v_request_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_validate_permit_state_change
 * -------------------------------
 * Gebruik deze functie om te kijken of een status wijziging van een vergunnning valide is.
 * Er worden geen permissie checks gedaan, het betreft hier dus alleen statuswijzigingen die NOOIT mogen.
 *
 * @param v_old_status De oude/huidige status van de vergunning.
 * @param v_new_status De nieuwe status van de vergunning.
 * @param v_reference Kenmerk van de vergunning (voor exceptie teksten).
 */
CREATE OR REPLACE FUNCTION ae_validate_permit_state_change(v_old_status request_status_type, v_new_status request_status_type, v_reference text)
	RETURNS void AS
$BODY$
BEGIN
	IF v_old_status = v_new_status THEN
		RAISE EXCEPTION 'Vergunningsaanvraag % heeft reeds de status "%"', v_reference, v_new_status;

	ELSIF v_new_status = 'initial' THEN
		RAISE EXCEPTION 'Vergunningsaanvragen kunnen niet terug naar status "initial" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'queued' AND v_old_status NOT IN ('initial', 'pending_with_space', 'pending_without_space', 'rejected_without_space') THEN
		RAISE EXCEPTION 'Vergunningsaanvragen kunnen alleen naar status "queued" vanuit status "initial" of "pending_with/without_space" of "rejected_without_space" (kenmerk = %)', v_reference;
		-- Note that 'initial' to 'queued' should only happen through worker (after calculation), which does not use this function.
		-- 'pending_whatever' to 'queued' happens in the nightly 'wachrij' mechanism (ae_reset_pending_permits()), which also do not use this function,
		-- but testers/superusers can do it via the UI so then it does come here.

	ELSIF v_new_status = 'pending_with_space' AND v_old_status <> 'queued' THEN
		RAISE EXCEPTION 'Vergunningsaanvragen kunnen alleen naar status "pending_with_space" vanuit status "queued" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'pending_without_space' AND v_old_status <> 'queued' THEN
		RAISE EXCEPTION 'Vergunningsaanvragen kunnen alleen naar status "pending_without_space" vanuit status "queued" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'assigned' AND v_old_status <> 'pending_with_space' THEN
		RAISE EXCEPTION 'Vergunningsaanvragen kunnen alleen naar status "assigned" vanuit status "pending_with_space" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'assigned_final' AND v_old_status <> 'assigned' THEN
		RAISE EXCEPTION 'Vergunningsaanvragen kunnen alleen naar status "assigned_final" vanuit status "assigned" (kenmerk = %)', v_reference;

	ELSIF v_new_status = 'rejected_without_space' AND v_old_status <> 'pending_without_space' THEN
		RAISE EXCEPTION 'Vergunningsaanvragen kunnen alleen naar status "rejected_without_space" vanuit status "pending_without_space" (kenmerk = %)', v_reference;

	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_delete_permit
 * ----------------
 * Gebruik deze functie om een vergunningsaanvraag te verwijderen, inclusief alle rekenresultaten en het bijstellen van de totalen.
 *
 * @param v_request_id Id van de aanvraag die verwijderd moet worden.
 * @param v_only_inactive_initial TRUE indien de vergunning alleen verwijderd mag worden als deze niet-actief is. Dat wil zeggen dat deze nog niet in het proces
 * is opgenomen (status = INITIAL) en er geen berekeningen voor gaande zijn. Dit kan het geval zijn als een nieuw-geimporteerde berekening is mislukt. Dit soort
 * rondzwevende aanvragen moeten ook uit het systeem verwijderd kunnen worden door gebruikers met beperkte rechten.
 */
CREATE OR REPLACE FUNCTION ae_delete_permit(v_request_id integer, v_only_inactive_initial boolean = FALSE)
	RETURNS void AS
$BODY$
DECLARE
	v_reference text;
BEGIN
	SELECT reference INTO STRICT v_reference FROM permits INNER JOIN requests USING (request_id) WHERE request_id = v_request_id; -- Ensure permit exists

	DELETE FROM potentially_rejectable_permits WHERE request_id = v_request_id;
	DELETE FROM permits WHERE request_id = v_request_id;

	PERFORM ae_delete_request(v_request_id, v_only_inactive_initial);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_reset_pending_permits
 * ------------------------
 * Zet in een keer alle aanvragen die in behandeling zijn terug in de wachtrij.
 */
CREATE OR REPLACE FUNCTION ae_reset_pending_permits()
	RETURNS void AS
$BODY$
BEGIN
	LOCK TABLE development_spaces IN EXCLUSIVE MODE;
	LOCK TABLE requests IN EXCLUSIVE MODE;

	UPDATE development_spaces
		SET space = 0
		WHERE
			segment = 'projects'
			AND status IN ('pending_with_space', 'pending_without_space')
	;

	UPDATE requests
		SET status = 'queued'
		FROM permits
		WHERE
			segment = 'projects'
			AND status IN ('pending_with_space', 'pending_without_space')
			AND requests.request_id = permits.request_id
	;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_dequeue_permits
 * ------------------
 * Zet alle aanvragen die in de wachtrijstaan en waarvan de termijn verstreken is, in behandeling.
 * De functie retoruneert de oude en nieuwe status van alle verwerkte aanvragen. Aan de hand van deze informatie kan de audit-trail ingevuld worden.
 */
CREATE OR REPLACE FUNCTION ae_dequeue_permits()
	RETURNS TABLE(request_id integer, old_status request_status_type, new_status request_status_type) AS
$BODY$
DECLARE
	v_request_id integer;
	v_old_status request_status_type;
	v_new_status request_status_type;
	v_available_spaces record;
BEGIN
	-- Lock necessary tables
	LOCK TABLE development_spaces IN EXCLUSIVE MODE;
	LOCK TABLE requests IN EXCLUSIVE MODE;
	LOCK TABLE potentially_rejectable_permits IN EXCLUSIVE MODE;

	-- Store old permit status
	CREATE TEMPORARY TABLE tmp_old_permit_status ON COMMIT DROP AS
	SELECT requests.request_id, requests.status
		FROM requests
			INNER JOIN permits USING (request_id)
		WHERE
			segment = 'projects'
			AND status IN ('queued', 'pending_with_space', 'pending_without_space')
	;
	ALTER TABLE tmp_old_permit_status ADD PRIMARY KEY (request_id);

	-- Reset all pending permits
	PERFORM ae_reset_pending_permits();

	-- Clear all existing potentially_rejectable_permits
	DELETE FROM potentially_rejectable_permits;

	-- Process all dequeueable permits
	FOR v_request_id IN
		(SELECT dequeueable_permits_view.request_id FROM dequeueable_permits_view ORDER BY received_date)
	LOOP
		v_available_spaces = ae_check_for_request_space(v_request_id);

		v_old_status = (SELECT status FROM tmp_old_permit_status WHERE tmp_old_permit_status.request_id = v_request_id);
		v_new_status = (CASE WHEN v_available_spaces.has_space_after_requested IS TRUE THEN 'pending_with_space' ELSE 'pending_without_space' END);

		IF (v_available_spaces.has_space_after_assigned IS FALSE) THEN
			INSERT INTO potentially_rejectable_permits (request_id) VALUES (v_request_id);
		END IF;

		RAISE NOTICE 'Process request % @ %', v_request_id, timeofday();

		PERFORM ae_change_permit_state(v_request_id, v_new_status);

		RETURN QUERY (SELECT v_request_id, v_old_status, v_new_status);
	END LOOP;

	-- Cleanup
	DROP TABLE tmp_old_permit_status;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
