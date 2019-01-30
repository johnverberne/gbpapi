/*
 * request_file_format_type
 * ------------------------
 * bestands formaat-type.
 */
CREATE TYPE request_file_format_type AS ENUM
	('gml', 'pdf', 'zip');


/*
 * request_file_type
 * -----------------
 * File-type voor een bestand behorende bij een OR-aanvraag.
 */
CREATE TYPE request_file_type AS ENUM
	('application', 'decree', 'detail_decree', 'priority_project_reservation', 'priority_project_actualisation', 'priority_project_factsheet');


/*
 * situation_type
 * --------------
 * Enum voor de situatie binnen een aanvraag.
 */
CREATE TYPE situation_type AS ENUM
	('proposed', 'current');


/*
 * request_status_type
 * -------------------
 * Status van een OR-aanvraag.
 * Van een subset van deze statussen (development_space_state) wordt het totaal bijgehouden.
 *
 * Let op: de statussen "verwijderd" en "definitief afgewezen" ontbreken, want deze hebben beiden tot gevolg
 * dat de vergunning fysiek uit het systeem verdwijnt. Het heeft dus geen zin om hier een status voor te hebben.
 */
CREATE TYPE request_status_type AS ENUM
	('initial',                     -- standaardwaarde na toevoeging aan het systeem; na doorrekening direct naar 'queued'
	 'queued',                      -- in de wachtrij / klaar voor verwerking (toetsbaar)
	 'pending_with_space',          -- in behandeling (OR beschikbaar)
	 'pending_without_space',       -- in behandeling (OR niet beschikbaar)
	 'assigned',                    -- toegekend
	 'rejected_without_space',      -- afgewezen (vanuit pending_without_space: OR is niet toegekend)
	 'assigned_final'               -- onherroepelijk toegekend
	);


/*
 * ae_request_status_to_development_space_state
 * --------------------------------------------
 * Functie nodig voor de cast van request_status_type naar development_space_state.
 */
CREATE OR REPLACE FUNCTION ae_request_status_to_development_space_state(v_status request_status_type)
	RETURNS development_space_state AS
$BODY$
BEGIN
	RETURN (CASE v_status
			WHEN 'initial'
				THEN NULL
			WHEN 'queued'
				THEN NULL
			WHEN 'pending_with_space'
				THEN 'pending_with_space'
			WHEN 'pending_without_space'
				THEN 'pending_without_space'
			WHEN 'assigned'
				THEN 'assigned'
			WHEN 'assigned_final'
				THEN 'assigned'
			WHEN 'rejected_without_space'
				THEN NULL
		END)::development_space_state;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

CREATE CAST (request_status_type AS development_space_state)
	WITH FUNCTION ae_request_status_to_development_space_state(request_status_type);
