
/*
 * ae_export_imaer_data
 * --------------------
 * Kopieert de code en description kolommen van de opgegeven tabel (een IMAER domein tabel) naar een .csv bestand in de opgegeven folder.
 * Bestanden zijn puntkomma-gescheiden en bevat een header. 
 * De opgegeven folder moet al wel bestaan.
 */
CREATE OR REPLACE FUNCTION setup.ae_export_imaer_data(folder text, table_to_export text)
	RETURNS void AS
$BODY$
BEGIN
	PERFORM setup.ae_store_query(table_to_export, 
		'SELECT code, name, description FROM ' || table_to_export || ' ORDER BY code',
		folder || 'IMAER_{queryname}_{datesuffix}.csv', TRUE);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_export_all_imaer_data
 * ------------------------
 * Kopieert de code en description kolommen van de juiste tabellen (alle IMAER domein tabellen) naar .csv bestanden in de opgegeven folder.
 * De sector_id en description kolommen van de sector tabel worden ook ge-exporteerd.
 * De opgegeven folder moet al wel bestaan.
 */
CREATE OR REPLACE FUNCTION setup.ae_export_all_imaer_data(folder text)
	RETURNS void AS
$BODY$
BEGIN
	PERFORM setup.ae_store_query('sectors', 
		'SELECT sector_id AS code, sector_id AS name, description FROM sectors ORDER BY code',
		folder || 'IMAER_{queryname}_{datesuffix}.csv', TRUE);

	PERFORM setup.ae_export_imaer_data(folder, 'farm_lodging_types');
	PERFORM setup.ae_export_imaer_data(folder, 'farm_lodging_system_definitions');
	PERFORM setup.ae_export_imaer_data(folder, 'farm_additional_lodging_systems');
	PERFORM setup.ae_export_imaer_data(folder, 'farm_reductive_lodging_systems');
	PERFORM setup.ae_export_imaer_data(folder, 'farm_lodging_fodder_measures');

	PERFORM setup.ae_export_imaer_data(folder, 'emission_diurnal_variations');

	PERFORM setup.ae_export_imaer_data(folder, 'mobile_source_off_road_categories');

	PERFORM setup.ae_export_imaer_data(folder, 'plan_categories');

	PERFORM setup.ae_export_imaer_data(folder, 'mobile_source_on_road_categories');

	PERFORM setup.ae_export_imaer_data(folder, 'shipping_inland_categories');
	PERFORM setup.ae_export_imaer_data(folder, 'shipping_maritime_categories');
	
	PERFORM setup.ae_store_query('shipping_inland_waterway_categories', 
		'SELECT DISTINCT code, name, name AS description FROM shipping_inland_waterway_categories_view ORDER BY code',
		folder || 'IMAER_{queryname}_{datesuffix}.csv', TRUE);
	
	PERFORM setup.ae_store_query('machinery_fuel_types', 
		'SELECT code, name, name AS description FROM machinery_fuel_types ORDER BY code',
		folder || 'IMAER_{queryname}_{datesuffix}.csv', TRUE);
	
	PERFORM setup.ae_store_query('authorities', 
		'SELECT code, name, name AS description FROM authorities INNER JOIN submitting_authorities USING (authority_id) ORDER BY code',
		folder || 'IMAER_{queryname}_{datesuffix}.csv', TRUE);

	PERFORM setup.ae_store_query('permit_calculation_radius_types', 
		'SELECT code, name, name AS description FROM permit_calculation_radius_types ORDER BY code',
		folder || 'IMAER_{queryname}_{datesuffix}.csv', TRUE);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
