{import_common 'system/general.sql'}
{import_common 'i18n/messages/'}

BEGIN; SELECT setup.ae_load_table('receptors', '{data_folder}/public/receptors_20180917.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('hexagons', '{data_folder}/public/hexagons_20180424.txt'); COMMIT;

---100x100 grid for geoserver
BEGIN; SELECT setup.ae_load_table('grids', '{data_folder}/public/grids.geo_20190207.txt'); COMMIT;

INSERT INTO system.constants (key, value) VALUES ('NUMBER_OF_TASKCLIENT_THREADS', '40');
