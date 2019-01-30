/*
 * machinery_types_view
 * --------------------
 * Geeft informatie over de werktuigen terug, inclusief brandstof informatie.
 */
CREATE OR REPLACE VIEW machinery_types_view AS
SELECT
	machinery_type_id,
	sector_id,
	machinery_types.code AS machinery_code,
	machinery_types.name AS machinery_name,
	sort_order,
	machinery_fuel_type_id,
	machinery_fuel_types.code AS fuel_code,
	machinery_fuel_types.name AS fuel_name,
	density AS fuel_density,
	power,
	load,
	energy_efficiency,
	substance_id,
	emission_factor

	FROM machinery_types
		INNER JOIN machinery_type_fuel_options USING (machinery_type_id)
		INNER JOIN machinery_fuel_types USING (machinery_fuel_type_id)
		INNER JOIN machinery_type_emission_factors USING (machinery_type_id, machinery_fuel_type_id)
;

/*
 * machinery_fuel_types_view
 * -------------------------
 * Geeft de brandstoffen terug, herhaald voor de sectoren waar werktuigen voor beschikbaar zijn.
 * Hiermee kan werktuigtype "Anders" gegeneerd worden in de UI.
 */
CREATE OR REPLACE VIEW machinery_fuel_types_view AS
SELECT
	sector_id,
	machinery_fuel_type_id,
	machinery_fuel_types.code AS fuel_code,
	machinery_fuel_types.name AS fuel_name,
	density AS fuel_density

	FROM machinery_fuel_types
		CROSS JOIN (SELECT DISTINCT sector_id FROM machinery_types) AS machinery_sectors
;

