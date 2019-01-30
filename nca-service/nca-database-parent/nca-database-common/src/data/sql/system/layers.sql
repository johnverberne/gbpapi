--layer legends
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (1, 'circle',  'Natuurgebieden');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (2, 'hexagon', 'Achtergronddepositie');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (3, 'circle',  'Stikstofgevoeligheid habitattypes');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (4, 'hexagon', 'Deposities');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (5, 'hexagon', 'Ontwikkelruimte');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (6, 'hexagon', 'Depositieontwikkeling');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (7, 'hexagon', 'Effect programma');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (8, 'hexagon', 'Afstand tot KDW');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (9, 'hexagon', 'Ontwikkelingssaldo');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (10, 'hexagon','Project behoefte');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (11, 'text'   ,'Relevante hexagonen worden met gestippelde arcering weergegeven.');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (12, 'hexagon','Verschil in project behoefte');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (13, 'hexagon','Resterende ontwikkelngsruimte');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (14, 'hexagon','Percentage ontwikkelngsruimte');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (15, 'circle', 'Bron labels');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (16, 'circle', 'Wegverkeer snelheidstypering');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (17, 'circle', 'Wegverkeer totaal aantal voertuigen per dag');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (18, 'circle', 'Wegverkeer totaal aantal voertuigen per dag licht verkeer');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (19, 'hexagon', 'Resterende ontwikkelngsruimte waarde');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (20, 'hexagon', 'Percentage ontwikkelngsruimte waarde');

--layer legend items
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (1, 1, 'Habitatrichtlijn', 'E6E600');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (1, 2, 'Vogelrichtlijn', 'BEE8FF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (1, 3, 'Vogelrichtlijn, Habitatrichtlijn', 'D1FF73');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 1, '<700', 'FFFFD4');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 2, '700-980', 'FEE391');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 3, '980-1260', 'FEC44F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 4, '1260-1540', 'FE9929');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 5, '1540-1960', 'EC7014');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 6, '1960-2240', 'CC4C02');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 7, '>2240', '8C2D04');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (3, 1, 'Zeer gevoelig', '7B3294');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (3, 2, 'Gevoelig', 'C2A5CF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (3, 3, 'Minder/niet gevoelig', 'EBF5C8');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 1, '<35', 'F6EFF7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 2, '35-70', 'D0D1E6');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 3, '70-140', 'A6BDDB');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 4, '140-210', '67A9CF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 5, '210-350', '3690C0');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 6, '350-490', '02818A');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 7, '>490', '016450');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 1, '0-17.5', 'F2F0F7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 2, '17.5-35', 'DADAEB');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 3, '35-52.5', 'BCBDDC');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 4, '52.5-70', '9E9AC8');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 5, '70-105', '807DBA');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 6, '105-140', '6A51A3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 7, '>140', '4A1486');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 1, '<-250', '6C8B41');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 2, '-250 - -175', '89A267');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 3, '-175 - -100', 'A7B98D');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 4, '-100 - -50', 'C4D1B3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 5, '-50 - -1', 'E2E8D9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 6, '0', 'F2F2F2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 7, '1 - 50', 'DCD9E9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 8, '50 - 100', 'B9B3D4');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 9, '100 - 175', '978CBE');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 10, '175 - 250', '7466A9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 11, '> 210', '514093');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 1, '< -140', '168D36');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 2, '-140 - -70', '3FAC5D');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 3, '-70 - -35', '7AC48F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 4, '-35 - -10', 'A0DDB2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 5, '-10 - 10', 'ECF2C9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 6, '> 10', '7C3494');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 1, '<0', '6C8B41');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 2, '0-35', 'F2F0F7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 3, '35-70', 'DADAEB');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 4, '70-105', 'BCBDDC');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 5, '105-140', '9E9AC8');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 6, '140-175', '807DBA');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 7, '175-210', '6A51A3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 8, '>210', '4A1486');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 1, '<-70', '514093');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 2, '-70 - -35', '7466A9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 3, '-35 - -1', '978CBE');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 4, '0', 'F2F2F2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 5, '1 - 35', 'C4D1B3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 6, '35 - 70', '89A267');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 7, '>70', '6C8B41');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 1, '0-0.05', 'FFFDB3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 2, '0.05-1', 'FDE76A');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 3, '1-3', 'FEB66E');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 4, '3-5', 'A5CC46');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 5, '5-7', '23A870');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 6, '7-10', '5A7A32');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 7, '10-15', '0093BD');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 8, '15-20', '0D75B5');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 9, '20-25', '6A70B1');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 10, '25-35', '304594');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 11, '35-70', '7F3B17');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 12, '70-105', '5E2C8F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 13, '105-140', '3F2A84');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 14, '>140', '2A1612');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 1, '<-14', '6C8B41');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 2, '-14 - -10.5', '89A267');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 3, '-10.5 - -7', 'A7B98D');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 4, '-7 - -3.5', 'C4D1B3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 5, '-3.5 - 0', 'E2E8D9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 6, '0', 'F2F2F2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 7, '0 - 3.5', 'DCD9E9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 8, '3.5 - 7', 'B9B3D4');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 9, '7 - 10.5', '978CBE');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 10, '10.5 - 14', '7466A9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 11, '>14', '514093');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 1, '0-0.05', 'FFFDB3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 2, '0.05-1', 'FDE76A');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 3, '1-3', 'FEB66E');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 4, '3-5', 'A5CC46');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 5, '5-7', '23A870');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 6, '7-10', '5A7A32');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 7, '10-15', '0093BD');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 8, '15-20', '0D75B5');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 9, '20-25', '6A70B1');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 10, '25-35', '304594');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 11, '35-70', '7F3B17');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 12, '70-105', '5E2C8F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 13, '105-140', '3F2A84');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 14, '>140', '2A1612');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 1, '> 90', '000000');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 2, '80 <= 90', '404040');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 3, '70 <= 80', '595959');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 4, '60 <= 70', '6F6F6F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 5, '50 <= 60', '828282');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 6, '40 <= 50', '959595');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 7, '30 <= 40', 'A7A7A7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 8, '20 <= 30', 'BCBCBC');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 9, '10 <= 20', 'D3D3D3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (14, 10, '<= 10', 'E6E6E6');

--layer range filter item values
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 1, 140, '<= 140');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 2, 105, '<= 105');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 3,  70, '<= 70');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 4,  35, '<= 35');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 5,  25, '<= 25');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 6,  20, '<= 20');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 7,  15, '<= 15');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 8,  10, '<= 10');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 9,   7, '<= 7');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,10,   5, '<= 5');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,11,   3, '<= 3');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,12,   1, '<= 1');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,13, 0.5, '<= 0.5');

INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 1, 90, '<= 90 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 2, 80, '<= 80 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 3, 70, '<= 70 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 4, 60, '<= 60 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 5, 50, '<= 50 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 6, 40, '<= 40 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 7, 30, '<= 30 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 8, 20, '<= 20 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 9, 10, '<= 10 %');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 1, '80 km/u', 'FFB767');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 2, '80 km/u strikt (streeplijn)', 'FFB767');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 3, '100 km/u', 'EB1C23');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 4, '100 km/u strikt (streeplijn)', 'EB1C23');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 5, '120 km/u', '0073B7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 6, '130 km/u', '000000');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 7, '100-130 km/u', 'BEE8FF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 8, '120-130 km/u', '7B3294');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 9, 'Overig', '00AA6D');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (17, 1, '< 10.000', 'FFB767');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (17, 2, '>= 10.000 - < 20.000', 'EB1C23');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (17, 3, '>= 20.000 - < 40.000', '0073B7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (17, 4, '>= 40.000 - < 80.000', '000000');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (17, 5, '>= 80.000', '00AA6D');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (18, 1, '< 10.000', 'FFB767');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (18, 2, '>= 10.000 - < 20.000', 'EB1C23');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (18, 3, '>= 20.000 - < 40.000', '0073B7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (18, 4, '>= 40.000 - < 80.000', '000000');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (18, 5, '>= 80.000', '00AA6D');

--layer capabilities
-- URL for capabilities can be updated in product specific part.
INSERT INTO system.layer_capabilities (layer_capabilities_id, url) VALUES (1, 'https://test.aerius.nl/calculator/aerius-geo-wms?');
INSERT INTO system.layer_capabilities (layer_capabilities_id, url) VALUES (2, 'http://geoservices.rijkswaterstaat.nl/verkeersscheidingsstelsel_noordzee');
INSERT INTO system.layer_capabilities (layer_capabilities_id, url) VALUES (3, 'http://geodata.nationaalgeoregister.nl/inspire/bu/wms?');

--tms layer properties (for now ID's 1 - 10)
--brtachtergrondkaart
INSERT INTO system.tms_layer_properties (layer_properties_id, title, opacity, enabled, min_scale, max_scale, base_url, image_type, service_version, attribution) 
	VALUES (1, 'Achtergrondkaart', 0.8, true, null, null, 'https://pdok.aerius.nl/pdok/tms/', 'png8', '1.0.0', '&copy; OSM &amp; Kadaster');
--luchtfoto
INSERT INTO system.tms_layer_properties (layer_properties_id, title, opacity, enabled, min_scale, max_scale, base_url, image_type, service_version) 
	VALUES (3, 'Luchtfoto (PDOK)', 1.0, false, null, null, 'https://geodata.nationaalgeoregister.nl/luchtfoto/rgb/tms/', 'jpeg', '1.0.0');

--wms layers (for now ID's 10+)
--default WMS layer properties
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (10, 1.0, false, null, 188000, null, 1);
--wms_nature_areas_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (11, 0.8, true, 1, 1504000, null, 1);
--wms_depositions_jurisdiction_policies_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (12, 1.0, false, 2, 188000, null, 1, 'year');
--wms_habitat_areas_sensitivity_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (13, 0.8, false, 3, 188000, null, 1);
--wms_habitat_types
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (14, 1.0, false, null, 1504000, null, 1, 'habitat_type');
--nzvss_beg,nzvss_sym,nzvss_sep (zeescheepvaart)
INSERT INTO system.wms_layer_properties (layer_properties_id, title, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id) 
	VALUES (15, 'Zeescheepvaart netwerk', 1.0, false, null, 1504000, null, 2);
--wms_shipping_maritime_network_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id) 
	VALUES (16, 1.0, false, null, 1504000, null, 1);
--wms_other_depositions_jurisdiction_policies_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (17, 1.0, false, 4, 188000, null, 1, 'year');
--wms_assessment_area_receptor_deposition_spaces_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type, begin_year)
	VALUES (18, 1.0, false, 5, 188000, null, 1, 'year', 2020);
--wms_assessment_area_receptor_delta_depositions_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type, begin_year)
	VALUES (19, 1.0, false, 6, 188000, null, 1, 'year', 2020);
--wms_assessment_area_receptor_delta_policy_depositions_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type, begin_year)
	VALUES (20, 1.0, false, 7, 188000, null, 1, 'year', 2020);
--wms_sector_depositions_jurisdiction_policies_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (21, 1.0, false, 4, 188000, null, 1, 'sector');
--wms_deviations_from_critical_deposition_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (22, 1.0, false, 8, 188000, null, 1, 'year');
--wms_delta_space_desire_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (23, 1.0, false, 9, 188000, null, 1, 'year');
--wms_included_receptors_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (24, 0.8, false, 11, 188000, null, 1);
--wms_permit_demands_view en wms_calculation_substance_deposition_results_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (25, 1.0, false, 10, 188000, null, 1);
-- BAG (not product specific)
INSERT INTO system.wms_layer_properties (layer_properties_id, title, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id) 
	VALUES (26, 'BAG', 0.4, false, null, 24000, null, 3);
--wms_calculations_substance_deposition_results_difference_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (27, 1.0, false, 12, 188000, null, 1);
-- wms_province_areas_view (not product specific)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (28, 0.8, true, null, null, null, 1);
-- wms_inland_shipping_routes (calculator/scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id) 
	VALUES (29, 1.0, false, null, 1504000, null, 1);
-- wms_calculations_substance_deposition_results_difference_view_utilisation (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (30, 1.0, false, 13, 188000, null, 1, 'data_range');
-- wms_calculations_substance_deposition_results_difference_view_utilisation_percentage (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (31, 0.8, false, 14, 188000, null, 1, 'data_range');
-- calculator:wms_user_source_labels (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (32, 1, false, 15, 188000, null, 1, null);
-- calculator:wms_user_road_speed_types (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (33, 1, false, 16, 1504000, null, 1, null);
-- calculator:wms_user_road_total_vehicles_per_day (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (34, 1, false, 17, 1504000, null, 1, null);
-- calculator:wms_user_road_total_vehicles_per_day_light_traffic (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (35, 1, false, 18, 1504000, null, 1, null);
-- wms_calculations_substance_deposition_results_difference_view_utilisation_percentage_label (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
  VALUES (36, 0.8, false, 19, 188000, null, 1, null);
  -- wms_calculations_substance_deposition_results_difference_view_utilisation_label (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
  VALUES (37, 0.8, false, 20, 188000, null, 1, null);
  
--default layers tms
INSERT INTO system.layers (layer_id, layer_properties_id, layer_type, name) 
	VALUES (1, 1, 'tms', 'brtachtergrondkaart');
-- 2 is added in every product specifically, as the name is product specific
INSERT INTO system.layers (layer_id, layer_properties_id, layer_type, name) 
	VALUES (3, 3, 'tms', 'Actueel_ortho25/EPSG:28992');
INSERT INTO system.layers (layer_id, layer_properties_id, layer_type, name) 
	VALUES (4, 26, 'wms', 'BU.Building');