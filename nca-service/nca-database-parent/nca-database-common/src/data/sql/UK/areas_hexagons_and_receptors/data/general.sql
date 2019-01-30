BEGIN; SELECT setup.ae_load_table('setup.province_land_borders', '{data_folder}/UK/setup/setup.province_land_borders_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('setup.geometry_of_interests', '{data_folder}/UK/setup/setup.geometry_of_interests_20161104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('countries', '{data_folder}/UK/public/countries_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('authorities', '{data_folder}/UK/public/authorities_20161104.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('submitting_authorities', '{data_folder}/temp/temp_submitting_authorities_20151104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('natura2000_areas', '{data_folder}/UK/public/natura2000_areas_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('natura2000_directive_areas', '{data_folder}/UK/temp/temp_natura2000_directive_areas_20161215.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('natura2000_area_properties', '{data_folder}/UK/public/natura2000_area_properties_20161104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('habitat_types', '{data_folder}/UK/public/habitat_types_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_type_critical_levels', '{data_folder}/UK/public/habitat_type_critical_levels_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_areas', '{data_folder}/UK/public/habitat_areas_20170314.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_properties', '{data_folder}/UK/public/habitat_properties_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitat_type_relations', '{data_folder}/UK/public/habitat_type_relations_20161104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('species', '{data_folder}/UK/public/species_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('species_properties', '{data_folder}/UK/public/species_properties_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('species_to_habitats', '{data_folder}/UK/public/species_to_habitats_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('designated_species', '{data_folder}/UK/public/designated_species_20161104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('province_areas', '{data_folder}/UK/public/province_areas_20161104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('receptors', '{data_folder}/UK/public/receptors_20161104.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('hexagons', '{data_folder}/UK/public/hexagons_20161104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('terrain_properties', '{data_folder}/UK/public/terrain_properties_20161022.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('receptors_to_assessment_areas', '{data_folder}/UK/public/receptors_to_assessment_areas_20170314.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/receptors_to_assessment_areas.sql'*/

BEGIN; SELECT setup.ae_load_table('relevant_habitat_areas', '{data_folder}/UK/public/relevant_habitat_areas_20170314.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('habitats', '{data_folder}/UK/public/habitats_20170314.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('relevant_habitats', '{data_folder}/UK/public/relevant_habitats_20170314.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/habitats.sql' */

BEGIN; SELECT setup.ae_load_table('receptors_to_critical_deposition_areas', '{data_folder}/UK/public/receptors_to_critical_deposition_areas_20170314.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/receptors_to_critical_deposition_areas.sql' */

BEGIN; SELECT setup.ae_load_table('assessment_areas_to_province_areas', '{data_folder}/UK/public/assessment_areas_to_province_areas_20161104.txt'); COMMIT;
/* Om te genereren: import_common 'modules/areas_hexagons_and_receptors/build/assessment_areas_to_province_areas.sql'*/

BEGIN; SELECT setup.ae_load_table('pas_assessment_areas', '{data_folder}/UK/public/pas_assessment_areas_20161104.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('system.habitat_type_colors', '{data_folder}/UK/system/system.habitat_type_colors_20161104.txt'); COMMIT;

