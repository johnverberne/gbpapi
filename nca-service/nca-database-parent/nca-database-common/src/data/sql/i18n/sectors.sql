-- i18n voor de module sectors
BEGIN; SELECT setup.ae_load_table('i18n.sectors', '{data_folder}/temp/i18n.temp_sectors_20180809_nl.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('i18n.sectors', '{data_folder}/temp/i18n.temp_sectors_20180809_en.txt'); COMMIT;

BEGIN; SELECT setup.ae_load_table('i18n.emission_diurnal_variations', '{data_folder}/i18n/i18n.emission_diurnal_variations_20170119_nl.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('i18n.emission_diurnal_variations', '{data_folder}/i18n/i18n.emission_diurnal_variations_20170119_en.txt'); COMMIT;
