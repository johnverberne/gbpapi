/*
 * posint
 * ------
 * Positieve integer gebruikt voor o.a. de diameter van een bron
 */
CREATE DOMAIN posint AS integer
	CHECK (VALUE >= 0::integer);


/*
 * posreal
 * -------
 * Positieve real gebruikt voor o.a. deposities
 */
CREATE DOMAIN posreal AS real
	CHECK (VALUE >= 0::real);


/*
 * fraction
 * --------
 * Real tussen 0..1 gebruikt voor o.a. de habitat bedekkingsfactor
 */
CREATE DOMAIN fraction AS real
	CHECK ((VALUE >= 0::real) AND (VALUE <= 1::real));


/*
 * year_type
 * ---------
 * Small integer gebruikt voor o.a. begin- en eindjaren maatregelen
 */
CREATE DOMAIN year_type AS smallint
	CHECK ((VALUE >= 2000::smallint) AND (VALUE <= 2050::smallint));


/*
 * ae_key_value_rs
 * ---------------
 * Type gebruikt als return type in het geval dat een key-value pair wordt teruggegeven.
 * Bedoeld als gebruik bij de aggregate functie ae_max_with_key, maar zou ook in andere gevallen gebruikt kunnen worden.
 */
CREATE TYPE ae_key_value_rs AS
(
	key numeric,
	value numeric
);