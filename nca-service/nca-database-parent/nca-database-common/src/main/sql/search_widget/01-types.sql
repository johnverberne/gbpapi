/*
 * search_area_type
 * ----------------
 * Type zoekgebieden voor de search widget
 */
CREATE TYPE search_area_type AS ENUM
	('natura2000_area', 'province_area', 'municipality_area', 'town_area', 'zip_code_area');