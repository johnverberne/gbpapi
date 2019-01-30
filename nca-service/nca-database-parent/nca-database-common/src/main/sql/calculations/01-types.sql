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
	('nature_area', 'radius', 'custom_points', 'permit');

/*
 * calculation_substance_type
 * --------------------------
 * Geeft aan welke stoffen doorberekend moeten worden.
 */
CREATE TYPE calculation_substance_type AS ENUM
	('pm10', 'pm25', 'no2', 'nox', 'nh3', 'noxnh3');

/*
 * calculation_result_set_type
 * ---------------------------
 * Geeft aan wat voor type een resultaat set is.
 */
CREATE TYPE calculation_result_set_type AS ENUM
	('total', 'sector');