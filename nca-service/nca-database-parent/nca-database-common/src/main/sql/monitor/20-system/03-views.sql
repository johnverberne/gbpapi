/*
 * sector_properties_monitor_view
 * ------------------------------
 * View die de sector properties inclusief sector group properties voor de Monitor applicatie retourneert.
 */
CREATE OR REPLACE VIEW system.sector_properties_monitor_view AS
SELECT
	sector_id, 
	sector.color AS sector_color, 
	sector.icon_type AS sector_icon, 
	sectorgroup,
	sectorgroup.name AS sectorgroup_name,
	sectorgroup.color AS sectorgroup_color, 
	sectorgroup.icon_type AS sectorgroup_icon

	FROM system.sector_properties_view AS sector
		INNER JOIN system.sectorgroup_properties AS sectorgroup USING (sectorgroup)
;
