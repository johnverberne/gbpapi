/*
 * emission_result_type
 * --------------------
 * Geeft aan wat voor type een resultaat is.
 */
CREATE TYPE emission_result_type AS ENUM
	('concentration', 'deposition', 'dry_deposition', 'wet_deposition');


/*
 * year_category_type
 * ------------------
 * Jaarcategorie, voor welke toepassing een jaar wordt gebruikt.
 */
CREATE TYPE year_category_type AS ENUM
	('source', 'farm_source', 'base', 'last', 'future');


/*
 * point_weight
 * ------------
 * Typedefinitie voor een punt met een gewicht (wegingsfactor)
 */
CREATE TYPE point_weight AS
(
	point geometry,
	weight fraction
);


/*
 * ae_color_range_rs
 * -----------------
 * Type die aangeeft wat de totalen (aantal receptoren, totale depositie, totale oppervlakte) binnen een kleurbereik zijn.
 * Wordt gebruikt bij de aggregate functie ae_color_range.
 */
CREATE TYPE ae_color_range_rs AS (
	lower_value real, 
	color text, 
	total numeric
);


/*
 * color_range_type
 * ----------------
 * Type van kleur bereik.
 */
CREATE TYPE color_range_type AS ENUM
	('total_deposition', 'delta_deposition', 'deviation_from_critical_deposition', 'report_delta_deposition_jurisdiction_policies_decrease', 'report_receptor_delta_depositions', 'report_receptor_depositions', 'report_receptor_deposition_spaces', 'report_receptor_receptor_max_nitrogen_loads');


/*
 * critical_deposition_classification
 * ----------------------------------
 * Type van kdw (kritische depositie waarde) classificatie.
 * Huidige klassering:
 * - high_sensitivity: zeer gevoelig
 * - normal_sensitivity: gevoelig
 * - low_sensitivity: minder/niet gevoelig
 */
CREATE TYPE critical_deposition_classification AS ENUM
	('high_sensitivity', 'normal_sensitivity', 'low_sensitivity');


/*
 * unit_type
 * ---------
 * Type van eenheid (gebruikt voor emissiefactoren bij plannen).
 */
CREATE TYPE unit_type AS ENUM
	('hectare', 'giga_joule', 'mega_watt_hours', 'count', 'no_unit', 'square_meters', 'tonnes');


/*
 * segment_type
 * ------------
 * Enum voor de onderverdeling van de ontwikkelingsruimte (is onderdeel van depositieruimte).
 */
CREATE TYPE segment_type AS ENUM
	('priority_projects', 'projects', 'permit_threshold', 'priority_subprojects');



-- This cast is needed by the syncer
CREATE CAST (CHARACTER VARYING AS segment_type) WITH INOUT AS ASSIGNMENT;