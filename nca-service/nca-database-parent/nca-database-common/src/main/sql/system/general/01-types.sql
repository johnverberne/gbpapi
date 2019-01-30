/*
 * color
 * -----
 * Hexadecimale kleur code.
 */
CREATE DOMAIN system.color AS character varying(6)
	CHECK ((VALUE IS NULL) OR (VALUE::text ~ '[0-9a-fA-F]{6}'::text));


/*
 * option_type
 * -----------
 * option_type wordt gebruikt om aan te geven welk type lijstjes een optielijst is die in de webapplicatie gebruikt kan worden.
 */
CREATE TYPE system.option_type AS ENUM
	('filter_min_fraction_used');