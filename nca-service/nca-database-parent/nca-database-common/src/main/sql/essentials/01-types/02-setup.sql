/*
 * validation_result_type
 * ----------------------
 * Type voor de verschillende validatie resultaten.
 * De volgorde van deze ENUM is van belang en loopt van laag naar hoog.
 */
CREATE TYPE setup.validation_result_type AS ENUM
	('success', 'hint', 'warning', 'error');


/*
 * validation_result
 * -----------------
 * Type voor de resultaten van een validatie.
 */
CREATE TYPE setup.validation_result AS (
	result setup.validation_result_type, 
	object text,
	message text
);
