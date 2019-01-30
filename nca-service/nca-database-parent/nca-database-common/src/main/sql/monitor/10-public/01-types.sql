/*
 * nitrogen_load_classification
 * ----------------------------
 * Classificatie stikstofbelasting. Dit is de afwijking van de totale depositie op de KDW.
 */
CREATE TYPE nitrogen_load_classification AS ENUM
	('no_nitrogen_problem', 'equilibrium', 'light_overload', 'heavy_overload');


/*
 * delta_space_desire_range
 * ------------------------
 * Klassen van bereik voor confontratie depositieruimte en ontwikkelbehoefte.
 * Uitgebreidere versie welke gebruikt wordt in de Summary en een WMS laag.
 */
CREATE TYPE delta_space_desire_range AS ENUM
	('shortage_70+', 'shortage_35-70', 'shortage_1-35', 'equal', 'surplus_1-35', 'surplus_35-70', 'surplus_70+');


/*
 * delta_space_desire_range_condensed
 * ----------------------------------
 * Klassen van bereik voor confontratie depositieruimte en ontwikkelbehoefte.
 * Ingekorte versie welke gebruikt wordt in de Gebiedssamenvatting.
 */
CREATE TYPE delta_space_desire_range_condensed AS ENUM
	('shortage_70+', 'shortage_35-70', 'shortage_1-35', 'surplus_1-35', 'surplus_35+');


/*
 * policy_type
 * -----------
 * Type beleids scenario
 */
CREATE TYPE policy_type AS ENUM
	('no_policies', 'global_policies', 'jurisdiction_policies');


/*
 * other_deposition_type
 * ---------------------
 * Type van de andere depositietypen.
 */
CREATE TYPE other_deposition_type AS ENUM
	('abroad_deposition', 'remaining_deposition', 'measurement_correction', 'dune_area_correction', 'returned_deposition_space', 'returned_deposition_space_limburg', 'deposition_space_addition');


/*
 * potential_type
 * --------------
 * Potentieele effectiviteit van een maatregel.
 */
CREATE TYPE potential_type AS ENUM
	('low', 'low_moderate', 'moderate', 'moderate_great', 'great', 'unproven', 'not_applicable');


/*
 * response_time_type
 * ------------------
 * Responstijd van een maatregel.
 */
CREATE TYPE response_time_type AS ENUM
	('within_year', 'one_to_five_years', 'five_to_ten_years', 'over_ten_years', 'unproven', 'not_applicable');


/*
 * frequency_type
 * --------------
 * Frequentie van uitvoering van een maatregel.
 */
CREATE TYPE frequency_type AS ENUM
	('once', 'cyclic');


/*
 * management_period_type
 * ----------------------
 * Beheerplanperiode (1, 2, of 3).
 */
CREATE DOMAIN management_period_type AS smallint
	CHECK ((VALUE >= 1::smallint) AND (VALUE <= 3::smallint));


/*
 * rehabilitation_strategy_geometry_accuracy_type
 * ----------------------------------------------
 * Gebiedsoort.
 *
 * strict	gebiedsspecifiek staat voor maatregelen die al duidelijk zijn beschreven op de kaart (toegewezen aan scherp gedefinieerd gebied)
 * sketch	uitvoeringsgebied staat voor maatregelen waarbij nog gezocht wordt naar inpassing (voorheen vaak zoekgebied genoemd)
 */
CREATE TYPE rehabilitation_strategy_geometry_accuracy_type AS ENUM
	('strict', 'sketch');