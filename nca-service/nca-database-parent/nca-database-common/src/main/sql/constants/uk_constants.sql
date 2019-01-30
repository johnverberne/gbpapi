{import_common 'constants/general_constants.sql'}

/**
 * Default SRID.
 */
INSERT INTO constants (key, value) VALUES ('SRID', 27700);

/**
 * De begrenzing (box) van het rekengrid.
 */
INSERT INTO constants (key, value) VALUES ('CALCULATOR_GRID_BOUNDARY_BOX', 'POLYGON((1393.0196 13494.9764,1393.0196 1230275.0454,671196.3657 1230275.0454,671196.3657 13494.9764,1393.0196 13494.9764))');

/**
 * De begrenzing (polygon) van het (landsdekkende) rekengrid op zoom level 3
 */
INSERT INTO constants (key, value) VALUES ('CALCULATOR_GRID_BOUNDARY', 'POLYGON((1393.0196 13494.9764,1393.0196 1230275.0454,671196.3657 1230275.0454,671196.3657 13494.9764,1393.0196 13494.9764))');

/**
 * De begrenzing van het rekenbereik in Calculator. Het gaat hier om de inverse van boundary.
 */
INSERT INTO constants (key, value) VALUES ('CALCULATOR_BOUNDARY', 'POLYGON((-1673115.34565 -1203285.0926,-1673115.34565 2447055.1144,2345704.73095 2447055.1144,2345704.73095 -1203285.0926,-1673115.34565 -1203285.0926),(1393.0196 13494.9764,671196.3657 13494.9764,671196.3657 1230275.0454,1393.0196 1230275.0454,1393.0196 13494.9764))');

/**
 * Oppervlakte van een zoom-level 1 hexagon (in m2).
 */
INSERT INTO constants (key, value) VALUES ('SURFACE_ZOOM_LEVEL_1', 250000);

/**
 * Aantal zoom-levels.
 */
INSERT INTO constants (key, value) VALUES ('MAX_ZOOM_LEVEL', 7);

/**
 * De geometry of interest area buffer (in meters).
 */
INSERT INTO constants (key, value) VALUES ('GEOMETRY_OF_INTEREST_BUFFER', 850);