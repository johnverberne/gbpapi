/*
 * ae_determine_pronouncement_authority_id
 * ---------------------------------------
 * Bepaal (het ID van) het bevoegd gezag van een melding op basis van een geometrie.
 *
 * @param v_geometry Het middenpunt van de geometrieen van alle bronnen.
 */
CREATE OR REPLACE FUNCTION ae_determine_pronouncement_authority_id(v_geometry geometry(Point))
	RETURNS integer AS
$BODY$
BEGIN
	RETURN authority_id FROM ae_determine_nearest_province(v_geometry) AS province_area_id
			INNER JOIN province_areas USING (province_area_id);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_assign_pronouncement
 * -----------------------
 * Ken een melding toe en update de toegekende ontwikkelingsruimte. Meegegeven wordt het ID van de melding.
 * Deze functie doet al het werk in één transactie, inclusief het locken van de ruimtetabel op het juiste moment.
 *
 * @param v_request_id Het database ID van de melding
 */
CREATE OR REPLACE FUNCTION ae_assign_pronouncement(v_request_id integer)
	RETURNS integer AS
$BODY$
DECLARE
	v_status request_status_type;
	v_reference text;
	v_proposed_calculation_id integer;
	v_current_calculation_id integer = NULL;
	v_previous_request_id integer = NULL;
	v_errcode text = NULL;
BEGIN
	SELECT status, reference INTO STRICT v_status, v_reference FROM pronouncements INNER JOIN requests USING (request_id) WHERE request_id = v_request_id;
	-- Do some extra checks based on input
	IF v_status != 'queued' THEN
		RAISE EXCEPTION 'Meldingen mogen alleen toegekend worden als ze de status QUEUED hebben. (kenmerk = %)', v_reference
			USING ERRCODE = 'AE004';
	END IF;

	SELECT calculation_id INTO STRICT v_proposed_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'proposed';
	SELECT calculation_id INTO v_current_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'current';


	-- Check if the request is still classified as a pronouncement. This should only depend on the permit_threshold_values. We don't touch development_spaces
	-- yet, so we don't lock it yet. It's unlikely the threshold value changed between sending the request and processing it, but you never know.
	SELECT
		(CASE
			WHEN NOT bool_and(max_development_space_demand < permit_threshold_value) THEN 'AE003'
		END) INTO v_errcode

		FROM ae_assessment_area_calculation_demands(v_proposed_calculation_id, v_current_calculation_id)

		WHERE permit_threshold_value = ae_constant('PRONOUNCEMENT_THRESHOLD_VALUE')::real -- Only check demand if threshold value is lowered
	;

	IF v_errcode IS NOT NULL THEN
		RAISE EXCEPTION 'Aanvraag % is geen melding (meer)', v_reference USING ERRCODE = v_errcode;
	END IF;


	-- We lock this table exclusively. Meaning that a second attempt to lock it like this, will result in a pause until the first lock is cleared.
	-- That happens when the function is done and thus the transaction ends.
	-- So in other words, if this function is ran concurrently, it will never interfere with itself.
	-- No other process can do UPDATEs or INSERTs while the table is locked.
	-- SELECTs are still possible, for the webapp to show graphs etc. These are based on the snapsnot of when the transaction begun.
	LOCK TABLE development_spaces IN EXCLUSIVE MODE;

	-- Check if there is space.
	IF (SELECT COUNT(*)
			FROM development_space_demands
				INNER JOIN available_development_spaces_view USING (receptor_id)

			WHERE
				proposed_calculation_id = v_proposed_calculation_id
				AND current_calculation_id = COALESCE(v_current_calculation_id, 0)
				AND segment = 'permit_threshold'
				AND NOT ae_has_space(available_after_utilized, development_space_demand) -- Use available_after_utilized because of the pending_with_space of s2
		) > 0
	THEN
		RAISE EXCEPTION 'Melding % past niet in de meldingsruimte', v_reference USING ERRCODE = 'AE001';
	END IF;

	-- Add the pronouncement to assigned space
	PERFORM ae_adjust_development_space('add', 'permit_threshold', 'assigned', v_proposed_calculation_id, v_current_calculation_id);

	-- Update status of the pronouncement to be assigned
	UPDATE requests SET status = 'assigned' WHERE request_id = v_request_id;

	RETURN v_request_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_delete_pronouncement
 * -----------------------
 * Verwijdert een melding en bijbehorende aanvraag. Hierbij wordt alles uit het systeem gehaald, tevens wordt de projectbehoefte weer van de
 * ontwikkelingsruimte reservering afgetrokken.
 *
 * Deze functie kan worden gebruikt om een melding in zijn geheel te verwijderen.
 *
 * Tevens wordt deze aanroepen bij het vervangen een melding; hierbij wordt ook de projectbehoefte weer van de ontwikkelingsruimte reservering afgetrokken.
 * Je kunt dus stellen dat de melding ongedaan wordt gemaakt, of wordt teruggenomen. Dit is nodig als een nieuwe melding een oude vervangt.
 */
CREATE OR REPLACE FUNCTION ae_delete_pronouncement(v_request_id integer)
	RETURNS void AS
$BODY$
BEGIN
	-- Delete all records
	DELETE FROM pronouncements WHERE request_id = v_request_id;
	PERFORM ae_delete_request(v_request_id);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
