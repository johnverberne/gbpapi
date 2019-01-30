/*
 * development_space_warning_type
 * ------------------------------
 * Enum voor de verschillende waarschuwingen die getoond kunnen worden voor Ontwikkelingsruimte.
 */
CREATE TYPE development_space_warning_type AS ENUM
	('shortage', 'near_shortage', 'first_half_pas_period_limit');
