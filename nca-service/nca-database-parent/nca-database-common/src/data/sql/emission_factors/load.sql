/* Road data */
BEGIN; SELECT setup.ae_load_table('road_categories', '{data_folder}/public/road_categories_20160602.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('road_speed_profiles', '{data_folder}/public/road_speed_profiles_20160602.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('road_category_emission_factors', '{data_folder}/public/road_category_emission_factors_20180607.txt'); COMMIT;

/* Farm animal category and -lodging data */
BEGIN; SELECT setup.ae_load_table('farm_animal_categories', '{data_folder}/public/farm_animal_categories_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_system_definitions', '{data_folder}/public/farm_lodging_system_definitions_20180914.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('farm_lodging_types', '{data_folder}/public/farm_lodging_types_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_type_emission_factors', '{data_folder}/public/farm_lodging_type_emission_factors_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_types_other_lodging_type', '{data_folder}/public/farm_lodging_types_other_lodging_type_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_types_to_lodging_system_definitions', '{data_folder}/public/farm_lodging_types_to_lodging_system_definitions_20180914.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('farm_additional_lodging_systems', '{data_folder}/public/farm_additional_lodging_systems_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_additional_lodging_system_emission_factors', '{data_folder}/public/farm_additional_lodging_system_emission_factors_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_additional_lodging_systems_to_lodging_system_definitions', '{data_folder}/public/farm_additional_lodging_systems_to_lodging_system_definitions_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_types_to_additional_lodging_systems', '{data_folder}/public/farm_lodging_types_to_additional_lodging_systems_20180914.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('farm_reductive_lodging_systems', '{data_folder}/public/farm_reductive_lodging_systems_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_reductive_lodging_system_reduction_factors', '{data_folder}/public/farm_reductive_lodging_system_reduction_factors_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_reductive_lodging_systems_to_lodging_system_definitions', '{data_folder}/public/farm_reductive_lodging_systems_to_lodging_system_definitions_20180914.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_types_to_reductive_lodging_systems', '{data_folder}/public/farm_lodging_types_to_reductive_lodging_systems_20180914.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('farm_lodging_fodder_measures', '{data_folder}/public/farm_lodging_fodder_measures_20150623_2.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_fodder_measure_reduction_factors', '{data_folder}/public/farm_lodging_fodder_measure_reduction_factors_20150623.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('farm_lodging_fodder_measures_animal_category', '{data_folder}/public/farm_lodging_fodder_measures_animal_category_20150625_2.txt'); COMMIT;

/* Plan emissionfactor data */
BEGIN; SELECT setup.ae_load_table('plan_categories', '{data_folder}/public/plan_categories_20141127.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('plan_category_emission_factors', '{data_folder}/public/plan_category_emission_factors_20160418.txt'); COMMIT;

/* Mobile source data */
BEGIN; SELECT setup.ae_load_table('mobile_source_off_road_categories', '{data_folder}/public/mobile_source_off_road_categories_20150126.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('mobile_source_off_road_category_emission_factors', '{data_folder}/public/mobile_source_off_road_category_emission_factors_20150126.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('mobile_source_on_road_categories', '{data_folder}/public/mobile_source_on_road_categories_20150127.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('mobile_source_on_road_category_emission_factors', '{data_folder}/public/mobile_source_on_road_category_emission_factors_20150127.txt'); COMMIT;

/* Shipping data */
BEGIN; SELECT setup.ae_load_table('shipping_maritime_categories', '{data_folder}/public/shipping_maritime_categories_20140331.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_maritime_category_maneuver_properties', '{data_folder}/temp/temp_shipping_maritime_category_maneuver_properties_20140402.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_maritime_maneuver_areas', '{data_folder}/temp/temp_shipping_maritime_maneuver_areas_20140422.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_maritime_category_emission_factors', '{data_folder}/temp/temp_shipping_maritime_category_emission_factors_20140327.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_maritime_category_source_characteristics', '{data_folder}/temp/temp_shipping_maritime_category_source_characteristics_20140327.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_maritime_emission_trend_factors', '{data_folder}/temp/temp_shipping_maritime_emission_trend_factors_20140327.txt'); COMMIT;

/* Inland shipping data */
BEGIN; SELECT setup.ae_load_table('shipping_inland_categories', '{data_folder}/public/shipping_inland_categories_20140327.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_category_source_characteristics', '{data_folder}/public/shipping_inland_category_source_characteristics_20180416.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_category_source_characteristics_docked', '{data_folder}/public/shipping_inland_category_source_characteristics_docked_20140326.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_category_emission_factors', '{data_folder}/public/shipping_inland_category_emission_factors_20161124.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_category_emission_factors_docked', '{data_folder}/public/shipping_inland_category_emission_factors_docked_20140131.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_emission_trend_factors', '{data_folder}/public/shipping_inland_emission_trend_factors_20140131.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_category_emission_trend_factors_docked', '{data_folder}/public/shipping_inland_category_emission_trend_factors_docked_20140131.txt'); COMMIT;

/* Machinery data */
BEGIN; SELECT setup.ae_load_table('machinery_fuel_types', '{data_folder}/temp/tmp_machinery_fuel_types_20151103.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('machinery_types', '{data_folder}/temp/tmp_machinery_types_20151103.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('machinery_type_fuel_options', '{data_folder}/public/machinery_type_fuel_options_20150224.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('machinery_type_emission_factors', '{data_folder}/public/machinery_type_emission_factors_20150224.txt'); COMMIT;
