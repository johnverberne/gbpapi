/*
 * calculation_state_type
 * ----------------------
 * Geeft de status aan van een berekening.
 */
CREATE TYPE calculation_state_type AS ENUM
	('initialized', 'running', 'cancelled', 'completed');

/*
 * calculation_type
 * ----------------
 * Geeft aan wat voor type een berekening is.
 */
CREATE TYPE calculation_type AS ENUM
	('air_regulation');

