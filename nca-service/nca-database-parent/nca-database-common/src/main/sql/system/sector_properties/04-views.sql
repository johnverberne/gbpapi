/*
 * sector_properties_view
 * ----------------------
 * View die alle systeem properties voor een sector bij elkaar schraapt en retourneert.
 */
CREATE OR REPLACE VIEW system.sector_properties_view AS
SELECT
	sector_id,
	sectorgroup,
	color,
	icon_type,
	emission_calculation_method,
	calculation_engine,
	building_possible

	FROM system.sectors_sectorgroup
		INNER JOIN system.sector_cosmetic_properties USING (sector_id)
		INNER JOIN system.sector_calculation_properties USING (sector_id)
;
