BEGIN;
	INSERT INTO i18n.farm_lodging_types
	SELECT farm_lodging_type_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), description FROM farm_lodging_types;
COMMIT;

BEGIN;
	INSERT INTO i18n.farm_additional_lodging_systems
	SELECT farm_additional_lodging_system_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), description FROM farm_additional_lodging_systems;
COMMIT;

BEGIN;
	INSERT INTO i18n.farm_reductive_lodging_systems
	SELECT farm_reductive_lodging_system_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), description FROM farm_reductive_lodging_systems;
COMMIT;

BEGIN;
	INSERT INTO i18n.farm_lodging_system_definitions
	SELECT farm_lodging_system_definition_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), description FROM farm_lodging_system_definitions;
COMMIT;

BEGIN;
	INSERT INTO i18n.farm_animal_categories
	SELECT farm_animal_category_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), description FROM farm_animal_categories;
COMMIT;

BEGIN;
	INSERT INTO i18n.farm_lodging_fodder_measures
	SELECT farm_lodging_fodder_measure_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), description FROM farm_lodging_fodder_measures;
COMMIT;

BEGIN; SELECT setup.ae_load_table('i18n.mobile_source_off_road_categories', '{data_folder}/i18n/i18n.mobile_source_off_road_categories_20150126_nl.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('i18n.mobile_source_off_road_categories', '{data_folder}/i18n/i18n.mobile_source_off_road_categories_20150126_en.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('i18n.mobile_source_on_road_categories', '{data_folder}/i18n/i18n.mobile_source_on_road_categories_20150127_nl.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('i18n.mobile_source_on_road_categories', '{data_folder}/i18n/i18n.mobile_source_on_road_categories_20150127_en.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('i18n.plan_categories', '{data_folder}/i18n/i18n.plan_categories_20140904_nl.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('i18n.plan_categories', '{data_folder}/i18n/i18n.plan_categories_20140904_en.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('i18n.shipping_maritime_categories', '{data_folder}/i18n/i18n.shipping_maritime_categories_20140904_nl.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('i18n.shipping_maritime_categories', '{data_folder}/i18n/i18n.shipping_maritime_categories_20140904_en.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('i18n.shipping_inland_categories', '{data_folder}/i18n/i18n.shipping_inland_categories_20140904_nl.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('i18n.shipping_inland_categories', '{data_folder}/i18n/i18n.shipping_inland_categories_20140904_en.txt'); COMMIT;

BEGIN;
	INSERT INTO i18n.shipping_inland_waterway_categories
	SELECT shipping_inland_waterway_category_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), name, description FROM shipping_inland_waterway_categories;
COMMIT;

BEGIN;
	INSERT INTO i18n.machinery_types
	SELECT machinery_type_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), name FROM machinery_types;
COMMIT;

BEGIN;
	INSERT INTO i18n.machinery_fuel_types
	SELECT machinery_fuel_type_id, unnest(ARRAY['nl', 'en']::i18n.language_code_type[]), name FROM machinery_fuel_types;
COMMIT;
