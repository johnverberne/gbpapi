/*
 * ae_adjust_priority_project_development_space
 * --------------------------------------------
 * Pas de toegekende OR van een prioritair project aan. Het kan erbij komen of er af gaan.
 * Ook wordt de tabel met de toegekende OR voor heel segment 1 geupdate.
 *
 * @param v_action Of bij de OR wordt opgeteld of afgetrokken
 * @param v_priority_project_request_id Request ID van het prioritair project waarbinnen de OR wordt aangepast
 * @param v_request_id Request ID van het prioritair deelproject waarvan de berekening moet worden gebruikt
 */
CREATE OR REPLACE FUNCTION ae_adjust_priority_project_development_space(v_action development_space_action_type, v_priority_project_request_id integer, v_request_id integer)
	RETURNS void AS
$BODY$
DECLARE
	v_proposed_calculation_id integer;
	v_current_calculation_id integer;
	v_currently_assigned real;
BEGIN
	PERFORM 1 FROM priority_project_development_spaces WHERE request_id = v_priority_project_request_id FOR UPDATE; -- Only one transaction/connection at a time.

	SELECT calculation_id INTO v_proposed_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'proposed';
	SELECT calculation_id INTO v_current_calculation_id FROM request_situation_calculations WHERE request_id = v_request_id AND situation = 'current';

	-- Update the assigned space of this specific priority project
	UPDATE priority_project_development_spaces
		SET assigned_space = ae_to_valid_space(assigned_space, development_space_demand, v_action)

		FROM development_space_demands

		WHERE
			proposed_calculation_id = v_proposed_calculation_id
			AND current_calculation_id = COALESCE(v_current_calculation_id, 0)
			AND request_id = v_priority_project_request_id
			AND priority_project_development_spaces.receptor_id = development_space_demands.receptor_id
	;

	-- Do the same change for the total assigned space of segment 1
	PERFORM ae_adjust_development_space(v_action, 'priority_projects', 'assigned', v_proposed_calculation_id, v_current_calculation_id);

	-- Update the fraction assigned for this project
	v_currently_assigned := (
		SELECT COALESCE(SUM(assigned_space) / NULLIF(SUM(reserved_space), 0), 0)::real
		FROM priority_project_available_development_spaces_view
		WHERE request_id = v_priority_project_request_id
	);
	UPDATE priority_projects SET fraction_assigned = v_currently_assigned WHERE request_id = v_priority_project_request_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_check_for_priority_subproject_space
 * --------------------------------------
 * Retourneert TRUE indien er voor de request genoeg ontwikkelingsruimte over is (S1 reservering).
 * Als een deelproject geen development_space_demand heeft is er ruimte, tenzij de status "initial" is want dan zijn de rekenresultaten (nog) onbekend en zou
 * je deze functie uberhaupt niet moeten aanroepen.
 */
CREATE OR REPLACE FUNCTION ae_check_for_priority_subproject_space(v_request_id integer)
	RETURNS boolean AS
$BODY$
BEGIN
	RETURN
		(SELECT
			COALESCE(
				bool_and(NOT has_shortage),
				bool_and(status <> 'initial')
			) AS has_space_left

			FROM requests
				INNER JOIN priority_subproject_space_view USING (request_id)

			WHERE request_id = v_request_id
		);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_insert_priority_project_development_spaces
 * ---------------------------------------------
 * Ken de gereserveerde OR van een prioritair project toe. Dit kan alleen bij projecten die niet reeds een reservering hebben staan.
 * De tabel met de gereserveerde OR voor heel segment 1 wordt NIET geupdated.
 *
 * @param v_request_id Request ID van het prioritair project waarvoor gereserveerd moet worden.
 * @param v_only_within_total_reservation Boolean die aangeeft of de reservering binnen de totale reservering van Segment 1 moet blijven (true)
 * of dat hier niet op gechecked hoeft te worden (false).
 */
CREATE OR REPLACE FUNCTION ae_insert_priority_project_development_spaces(v_request_id integer, v_only_within_total_reservation boolean = TRUE)
	RETURNS void AS
$BODY$
BEGIN
	IF NOT EXISTS (SELECT request_id FROM priority_projects WHERE request_id = v_request_id) THEN
		RAISE EXCEPTION 'Project (ID = %) niet gevonden als prioritair project.', v_request_id;
	END IF;

	IF EXISTS (SELECT receptor_id FROM priority_project_development_spaces WHERE request_id = v_request_id LIMIT 1) THEN
		RAISE EXCEPTION 'Koepelproject (ID = %) heeft reeds gereserveerde ruimte, dit kan niet nogmaals gereserveerd worden.', v_request_id;
	END IF;

	--check if the total reservation in priority_project_development_spaces doesn't exceed the space in reserved_development_spaces if needed
	IF v_only_within_total_reservation THEN
		IF EXISTS (
				SELECT receptor_id FROM reserved_development_spaces AS reserved
					INNER JOIN (SELECT receptor_id, SUM(reserved_space) AS space FROM priority_project_development_spaces GROUP BY receptor_id) AS current USING (receptor_id)
					INNER JOIN request_demands_view AS request USING (receptor_id)
						WHERE request_id = v_request_id
							AND segment = 'priority_projects'
							AND reserved.space < current.space + request.development_space_demand) THEN
			RAISE EXCEPTION 'Geen rechten om koepelproject (ID = %) ruimte te laten reserveren die de totale gereserveerde ruimte overschrijdt', v_request_id
				USING ERRCODE = 'AE301';
		END IF;
	END IF;

	-- Insert the reserved space of this specific priority project
	INSERT INTO priority_project_development_spaces(request_id, receptor_id, reserved_space, assigned_space)
	SELECT
		request_id,
		receptor_id,
		development_space_demand AS reserved_space,
		0 AS assigned_space

		FROM request_demands_view
			INNER JOIN reserved_development_spaces USING (receptor_id) -- Get rid of non-OR receptors in the calculation

		WHERE request_id = v_request_id
			AND reserved_development_spaces.segment = 'priority_projects';
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
