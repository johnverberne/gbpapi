/*
 * shipping_movement_type
 * ----------------------
 * Geeft aan wat voor soort beweging een schip aan het maken is. Dit hangt af van de locatie van het schip.
 * Dock is hierbij bijvoorbeeld stilliggend aan de kade.
 */
CREATE TYPE shipping_movement_type AS ENUM
	('dock', 'inland', 'maritime');
