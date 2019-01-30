--BEGIN; SELECT setup.ae_load_table('setup.geometry_of_interests', '{data_folder}/setup/setup.geometry_of_interests_abroad_20160428.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('authorities', '{data_folder}/temp/temp_authorities_abroad_20160208.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('natura2000_areas', '{data_folder}/public/natura2000_areas_abroad_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('natura2000_directive_areas', '{data_folder}/public/natura2000_directive_areas_abroad_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('natura2000_area_properties', '{data_folder}/temp/temp_natura2000_area_properties_abroad_20150223.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('habitat_types', '{data_folder}/public/habitat_types_abroad_calculator_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('habitat_type_critical_levels', '{data_folder}/public/habitat_type_critical_levels_abroad_calculator_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('habitat_areas', '{data_folder}/public/habitat_areas_abroad_calculator_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('habitat_properties', '{data_folder}/public/habitat_properties_abroad_calculator_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('habitat_type_relations', '{data_folder}/public/habitat_type_relations_abroad_calculator_20170425.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('receptors', '{data_folder}/public/receptors_abroad_20160428.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('hexagons', '{data_folder}/public/hexagons_abroad_20160428.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('receptors_to_assessment_areas', '{data_folder}/public/receptors_to_assessment_areas_abroad_20170425.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('relevant_habitat_areas', '{data_folder}/public/relevant_habitat_areas_abroad_calculator_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('habitats', '{data_folder}/public/habitats_abroad_calculator_20170425.txt'); COMMIT;
--BEGIN; SELECT setup.ae_load_table('relevant_habitats', '{data_folder}/public/relevant_habitats_abroad_calculator_20170425.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('receptors_to_critical_deposition_areas', '{data_folder}/public/receptors_to_critical_deposition_areas_abroad_calculator_20170425.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('assessment_areas_to_province_areas', '{data_folder}/public/assessment_areas_to_province_areas_abroad_20170425.txt'); COMMIT;

--BEGIN; SELECT setup.ae_load_table('system.habitat_type_colors', '{data_folder}/system/system.habitat_type_colors_abroad_calculator_20170425.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('setup.uncalculated_receptors', '{data_folder}/temp/temp_setup.uncalculated_receptors_20180616.txt'); COMMIT;