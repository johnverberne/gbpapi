BEGIN; SELECT setup.ae_load_table('sectors', '{data_folder}/public/sectors_20160617.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('gcn_sectors', '{data_folder}/public/gcn_sectors_20180426.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('sectors_main_gcn_sector', '{data_folder}/public/sectors_main_gcn_sector_20160617.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('emission_diurnal_variations', '{data_folder}/public/emission_diurnal_variations_20170119.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('sector_default_source_characteristics', '{data_folder}/public/sector_default_source_characteristics_20170116.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('gcn_sector_source_characteristics', '{data_folder}/public/gcn_sector_source_characteristics_20180615.txt'); COMMIT;
