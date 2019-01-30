/*
 * shipping_inland_laden_state
 * ---------------------------
 * Geeft aan of het binnenvaartschip beladen is of niet.
 */
CREATE TYPE shipping_inland_laden_state AS ENUM
	('laden', 'unladen');
