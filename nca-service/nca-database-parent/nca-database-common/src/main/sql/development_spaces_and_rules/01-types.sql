/*
 * development_rule_type
 * ---------------------
 * Enum voor de verschillende beleidsregels.
 */
CREATE TYPE development_rule_type AS ENUM
	('exceeding_space_check', 'max_development_space_demand_check');


/*
 * development_space_state
 * -----------------------
 * De verschillende statussen van een OR-aanvraag waarbij er een beroep gedaan wordt op de ontwikkelingsruimte.
 */
CREATE TYPE development_space_state AS ENUM
	('pending_without_space', 'pending_with_space', 'assigned');


/*
 * development_space_action_type
 * -----------------------------
 * Voor de functie die de ontwikkelingsruimte aanpast kun je opgeven of de bijdrage erbij wordt opgeteld of van afgehaald.
 */
CREATE TYPE development_space_action_type AS ENUM
	('add', 'subtract');


/*
 * ae_development_space_action_type_to_integer
 * -------------------------------------------
 * Functie nodig voor de cast van development_space_action_type naar integer.
 */
CREATE OR REPLACE FUNCTION ae_development_space_action_type_to_integer(v_action development_space_action_type)
	RETURNS integer AS
$BODY$
	SELECT (CASE WHEN v_action = 'add' THEN 1 ELSE -1 END);
$BODY$
LANGUAGE sql IMMUTABLE;

CREATE CAST (development_space_action_type AS integer)
	WITH FUNCTION ae_development_space_action_type_to_integer(development_space_action_type);


-- This cast is needed by the syncer
CREATE CAST (CHARACTER VARYING AS development_space_state) WITH INOUT AS ASSIGNMENT;