/* Shipping nodes (maritime) */  

BEGIN; SELECT setup.ae_load_table('shipping_maritime_nodes', '{data_folder}/temp/temp_shipping_nodes_20130829.txt'); COMMIT;


/* Shipping inland */

BEGIN; SELECT setup.ae_load_table('shipping_inland_waterway_categories', '{data_folder}/temp/temp_shipping_inland_waterway_categories_20160301.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_waterways', '{data_folder}/temp/temp_shipping_inland_waterways_20160301.txt'); COMMIT;
BEGIN; SELECT setup.ae_load_table('shipping_inland_locks', '{data_folder}/public/shipping_inland_locks_20140131.txt'); COMMIT;