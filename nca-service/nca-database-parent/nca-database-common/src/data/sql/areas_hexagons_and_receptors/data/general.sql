BEGIN; SELECT setup.ae_load_table('setup.province_land_borders', '{data_folder}/setup/setup.province_land_borders_20131129.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('setup.geometry_of_interests', '{data_folder}/setup/setup.geometry_of_interests_20180424.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('countries', '{data_folder}/temp/temp_countries_20150721.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('authorities', '{data_folder}/public/authorities_20180614.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('submitting_authorities', '{data_folder}/public/submitting_authorities_20180614.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('natura2000_areas', '{data_folder}/public/natura2000_areas_20180413.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('natura2000_directive_areas', '{data_folder}/public/natura2000_directive_areas_20180413.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('natura2000_area_properties', '{data_folder}/public/natura2000_area_properties_20180413.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('habitat_types', '{data_folder}/public/habitat_types_20170425.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_type_critical_levels', '{data_folder}/public/habitat_type_critical_levels_20170425.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_areas', '{data_folder}/public/habitat_areas_20180720.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_properties', '{data_folder}/public/habitat_properties_20180515.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_type_relations', '{data_folder}/public/habitat_type_relations_20170425.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('species', '{data_folder}/public/species_20170421.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('species_properties', '{data_folder}/public/species_properties_20180420.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('species_to_habitats', '{data_folder}/public/species_to_habitats_20180720.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('designated_species', '{data_folder}/public/designated_species_20180420.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('province_areas', '{data_folder}/public/province_areas_20180420.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('receptors', '{data_folder}/public/receptors_20180917.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('hexagons', '{data_folder}/public/hexagons_20180424.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('terrain_properties', '{data_folder}/temp/temp_terrain_properties_20160404.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('receptors_to_assessment_areas', '{data_folder}/public/receptors_to_assessment_areas_20180721.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/receptors_to_assessment_areas.sql'*/

BEGIN; SELECT setup.ae_load_table('relevant_habitat_areas', '{data_folder}/public/relevant_habitat_areas_20180720.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitats', '{data_folder}/public/habitats_20180720.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('relevant_habitats', '{data_folder}/public/relevant_habitats_20180720.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/habitats.sql' */

BEGIN; SELECT setup.ae_load_table('receptors_to_critical_deposition_areas', '{data_folder}/public/receptors_to_critical_deposition_areas_20180721.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/receptors_to_critical_deposition_areas.sql' */

BEGIN; SELECT setup.ae_load_table('assessment_areas_to_province_areas', '{data_folder}/public/assessment_areas_to_province_areas_20180722.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/assessment_areas_to_province_areas.sql'*/

BEGIN; SELECT setup.ae_load_table('pas_assessment_areas', '{data_folder}/public/pas_assessment_areas_20180420.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('system.habitat_type_colors', '{data_folder}/system/system.habitat_type_colors_20170421.txt'); COMMIT;