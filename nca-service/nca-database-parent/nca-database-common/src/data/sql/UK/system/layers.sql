--layer legends
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (1, 'circle', 'Nature areas');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (2, 'hexagon', 'Background deposition');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (3, 'circle', 'Nitrogen sensitivity habitat types');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (4, 'hexagon', 'Depositions');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (5, 'hexagon', 'Development space');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (6, 'hexagon', 'Depostion development');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (7, 'hexagon', 'Effect program');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (8, 'hexagon', 'Distance to CDV');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (9, 'hexagon', 'Development balance');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (10, 'hexagon', 'Project need');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (11, 'text', 'Relevant hexagons are represented by dotted shading.');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (12, 'hexagon', 'Diffence in project need');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (13, 'hexagon', 'Available development space');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (14, 'hexagon','Percentage development space');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (15, 'circle', 'Source labels');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (16, 'circle', 'Road speedtype');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (17, 'circle', 'Road total vehicles per day');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (18, 'circle', 'Road total vehicles per day light traffic');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (19, 'hexagon', 'Available development space label');
INSERT INTO system.layer_legends (layer_legend_id,legend_type,description) VALUES (20, 'hexagon', 'Percentage development space label');

--layer legend items
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (1, 1, 'Habitat directive', 'E6E600');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (1, 2, 'Bird directive', 'BEE8FF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (1, 3, 'Bird directive, Habitat directive', 'D1FF73');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 1, '<10', 'FFFFD4');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 2, '10-14', 'FEE391');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 3, '14-18', 'FEC44F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 4, '18-22', 'FE9929');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 5, '22-28', 'EC7014');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 6, '28-32', 'CC4C02');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (2, 7, '>32', '8C2D04');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (3, 1, 'Highly sensitive', '7B3294');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (3, 2, 'Sensitive', 'C2A5CF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (3, 3, 'Less/not sensitive', 'EBF5C8');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 1, '<0.5', 'F6EFF7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 2, '0.2-1', 'D0D1E6');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 3, '1-2', 'A6BDDB');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 4, '2-3', '67A9CF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 5, '3-5', '3690C0');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 6, '5-7', '02818A');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (4, 7, '>7', '016450');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 1, '0-0.25', 'F2F0F7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 2, '0.25-0.5', 'DADAEB');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 3, '0.5-0.75', 'BCBDDC');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 4, '0.75-1', '9E9AC8');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 5, '1-1.5', '807DBA');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 6, '1.5-2', '6A51A3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (5, 7, '>2', '4A1486');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 1, '< -3', '6C8B41');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 2, '-3 - -2', '89A267');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 3, '-2 - -1.5', 'A7B98D');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 4, '-1.5 - -1', 'C4D1B3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 5, '-0.5 - -.01', 'E2E8D9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 6, '0', 'F2F2F2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 7, '0.01 - 0.5', 'DCD9E9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 8, '0.5 - 1', 'B9B3D4');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 9, '1 - 2', '978CBE');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 10, '2 - 3', '7466A9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (6, 11, '> 3', '514093');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 1, '< -2', '168D36');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 2, '-2 - -1', '3FAC5D');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 3, '-1 - -0.5', '7AC48F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 4, '-0.5 - -0.14', 'A0DDB2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 5, '-0.14 - 0.14', 'ECF2C9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (7, 6, '> 0.14', '7C3494');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 1, '<0', '6C8B41');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 2, '0-0.5', 'F2F0F7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 3, '0.5-1', 'DADAEB');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 4, '1-1.5', 'BCBDDC');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 5, '1.5-2', '9E9AC8');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 6, '2-2.5', '807DBA');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 7, '2.5-3', '6A51A3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (8, 8, '>3', '4A1486');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 1, '<-1', '514093');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 2, '-1 - -0.5', '7466A9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 3, '-0.5 - -1', '978CBE');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 4, '0', 'F2F2F2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 5, '1 - 0.5', 'C4D1B3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 6, '0.5 - 1', '89A267');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (9, 7, '>1', '6C8B41');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 1, '0-0.0007', 'FFFDB3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 2, '0.0007-0.01', 'FDE76A');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 3, '0.01-0.04', 'FEB66E');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 4, '0.04-0.07', 'A5CC46');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 5, '0.07-0.1', '23A870');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 6, '0.1-0.14', '5A7A32');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 7, '0.14-0.21', '0093BD');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 8, '0.21-0.29', '0D75B5');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 9, '0.29-0.36', '6A70B1');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 10, '0.36-0.5', '304594');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 11, '0.5-1', '7F3B17');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 12, '1-1.5', '5E2C8F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 13, '1.5-2', '3F2A84');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (10, 14, '>2', '2A1612');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 1, '<-0.2', '6C8B41');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 2, '-0.2 - -0.15', '89A267');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 3, '-0.15 - -0.1', 'A7B98D');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 4, '-0.01 - -0.05', 'C4D1B3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 5, '-0.05 - 0', 'E2E8D9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 6, '0', 'F2F2F2');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 7, '0 - 0.05', 'DCD9E9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 8, '0.05 - 0.1', 'B9B3D4');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 9, '0.1 - 0.15', '978CBE');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 10, '0.15 - 0.2', '7466A9');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (12, 11, '>0.2', '514093');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 1, '> 0.1714', 'FDF1BF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 2, '0.1000 <= 0.1714', 'E1EC8C');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 3, '0.0571 <= 0.1000', '86B496');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 4, '0.0286 <= 0.0571', '789FCA');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 5, '0.0143 <= 0.0286', 'E59435');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 6, '0.0071 <= 0.0143', 'F45B0F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 7, '0 <= 0.0071', 'FF00FF');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 1, '0-0.0071', 'FFFDB3');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 2, '0.0071-0.0143', 'FDE76A');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 3, '0.0143-0.0429', 'FEB66E');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 4, '0.0429-0.0714', 'A5CC46');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 5, '0.0714-0.1', '23A870');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 6, '0.1-0.1429', '5A7A32');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 7, '0.1429-0.2143', '0093BD');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 8, '0.2143-0.2857', '0D75B5');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 9, '0.2857-0.3572', '6A70B1');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 10, '0.3572-0.5', '304594');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 11, '0.5-1', '7F3B17');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 12, '1-1.5', '5E2C8F');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 13, '1.5-2', '3F2A84');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (13, 14, '> 2', '2A1612');


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

--layer range filter item values multiply with 0.014286
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 1, 140, '<= 2');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 2, 105, '<= 1.5');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 3,  70, '<= 1');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 4,  35, '<= 0.5000');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 5,  25, '<= 0.3572');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 6,  20, '<= 0.2857');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 7,  15, '<= 0.2143');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 8,  10, '<= 0.1429');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13, 9,   7, '<= 0.1000');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,10,   5, '<= 0.0714');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,11,   3, '<= 0.0429');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,12,   1, '<= 0.0143');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (13,13, 0.5, '<= 0.0071'); 

INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 1, 90, '<= 90 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 2, 80, '<= 80 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 3, 70, '<= 70 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 4, 60, '<= 60 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 5, 50, '<= 50 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 6, 40, '<= 40 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 7, 30, '<= 30 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 8, 20, '<= 20 %');
INSERT INTO system.layer_data_range_items (layer_legend_id, sort_order, range, name) VALUES (14, 9, 10, '<= 10 %');

INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 1, '80 km/h', 'FFB767');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 2, '80 km/h strict (dashed line)', 'FFB767');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 3, '100 km/h', 'EB1C23');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 4, '100 km/h strict (dashed line)', 'EB1C23');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 5, '120 km/h', '0073B7');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 6, '130 km/h', '000000');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 7, '100-130 km/h', 'BEE8FF');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 8, '120-130 km/h', '7B3294');
INSERT INTO system.layer_legend_color_items (layer_legend_id, sort_order, name, color) VALUES (16, 9, 'Other', '00AA6D');

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
INSERT INTO system.layer_capabilities (layer_capabilities_id, url) VALUES (4, 'https://test.aerius.nl/ukbars/map?');

--wms layers (for now ID's 10+)
--default WMS layer properties
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (10, 1.0, false, null, 12800000, null, 1);
--wms_nature_areas_view
INSERT INTO system.wms_layer_properties (layer_properties_id, title, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (11, 'Special areas of conservation', 0.8, true, 1, 12800000, null, 1);
--wms_depositions_jurisdiction_policies_view
INSERT INTO system.wms_layer_properties (layer_properties_id, title, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (12, 'Total deposition', 1.0, false, 2, 12800000, null, 1, 'year');
--wms_habitat_areas_sensitivity_view
INSERT INTO system.wms_layer_properties (layer_properties_id, title, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (13, 'Nitrogen sensitive habitat types', 0.8, false, 3, 12800000, null, 1);
--wms_habitat_types
INSERT INTO system.wms_layer_properties (layer_properties_id, title, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (14, 'Habitat types', 1.0, false, null, 12800000, null, 1, 'habitat_type');
--wms_other_depositions_jurisdiction_policies_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (17, 1.0, false, 4, 12800000, null, 1, 'year');
--wms_assessment_area_receptor_deposition_spaces_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type, begin_year)
	VALUES (18, 1.0, false, 5, 12800000, null, 1, 'year', 2020);
--wms_assessment_area_receptor_delta_depositions_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type, begin_year)
	VALUES (19, 1.0, false, 6, 12800000, null, 1, 'year', 2020);
--wms_assessment_area_receptor_delta_policy_depositions_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type, begin_year)
	VALUES (20, 1.0, false, 7, 12800000, null, 1, 'year', 2020);
--wms_sector_depositions_jurisdiction_policies_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (21, 1.0, false, 4, 12800000, null, 1, 'sector');
--wms_deviations_from_critical_deposition_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (22, 1.0, false, 8, 12800000, null, 1, 'year');
--wms_delta_space_desire_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (23, 1.0, false, 9, 12800000, null, 1, 'year');
--wms_included_receptors_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (24, 0.8, false, 11, 12800000, null, 1);
--wms_permit_demands_view en wms_calculation_substance_deposition_results_view
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (25, 1.0, false, 10, 12800000, null, 1);
--wms_calculations_substance_deposition_results_difference_view
INSERT INTO system.wms_layer_properties (layer_properties_id, title, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (27, 'Delta results', 1.0, false, 12, 12800000, null, 1);
-- wms_province_areas_view (not product specific)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id)
	VALUES (28, 0.8, true, null, null, null, 1);

-- wms_calculations_substance_deposition_results_difference_view_utilisation (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (30, 1.0, false, 13, 12800000, null, 1, 'data_range');
-- wms_calculations_substance_deposition_results_difference_view_utilisation_percentage (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (31, 0.8, false, 14, 12800000, null, 1, 'data_range');
-- calculator:wms_user_source_labels (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (32, 1, false, 15, 12800000, null, 1, null);
-- calculator:wms_user_road_speed_types (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type)
	VALUES (33, 1, false, 16, 12800000, null, 1, null);
-- calculator:wms_user_road_total_vehicles_per_day (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (34, 1, false, 17, 12800000, null, 1, null);
-- calculator:wms_user_road_total_vehicles_per_day_light_traffic (scenario)
INSERT INTO system.wms_layer_properties (layer_properties_id, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, dynamic_type) 
	VALUES (35, 1, false, 18, 12800000, null, 1, null);
  
INSERT INTO system.wms_layer_properties (layer_properties_id, title, attribution, opacity, enabled, layer_legend_id, min_scale, max_scale, layer_capabilities_id, tile_size)
  VALUES (36, 'Base Layer', '&copy Crown copyright and database rights 2013 Ordnance Survey [100017955]', 0.8, true, null, null, null, 4, 250);

--default layers background layers.
INSERT INTO system.layers (layer_id, layer_properties_id, layer_type, name)
  VALUES (5, 36, 'wms', 'OS-Scale-Dependent');

