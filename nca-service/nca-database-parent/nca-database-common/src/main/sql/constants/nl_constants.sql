{import_common 'constants/general_constants.sql'}

/**
 * Default SRID.
 */
INSERT INTO constants (key, value) VALUES ('SRID', 28992);

/**
 * De begrenzing (box) van het rekengrid.
 */
INSERT INTO constants (key, value) VALUES ('CALCULATOR_GRID_BOUNDARY_BOX', 'POLYGON((3604 296800,3604 629300,287959 629300,287959 296800,3604 296800))');

/**
 * De begrenzing (polygon) van het (landsdekkende) rekengrid op zoom level 3
 */
INSERT INTO constants (key, value) VALUES ('CALCULATOR_GRID_BOUNDARY', 
   'POLYGON(
     (-3000 399000,76000 471000,89000 560000,132000 614000,239000 632000,286000 596000,288000 557000,267000 507000,280000 472000,250000 426000,208000 418000,224000 374000,200000 297000,165000 307000,173000 345000,160000 355000,108000 374000,52000 347000,18000 353000,-3000 399000))');

/**
 * De begrenzing van het rekenbereik in Calculator. Het gaat hier om de inverse van boundary.
 */
INSERT INTO constants (key, value) VALUES ('CALCULATOR_BOUNDARY',
	'POLYGON(
		(-285804 22648,-285804 902914,595215 902914,595215 22648,-285804 22648),
		(141000 629000,100000 600000,80000 500000,3604 392000,3604 336000,101000 336000,161000 296800,219000 296800,287959 451000,287959 614000,259000 629000,141000 629000))');

/**
 * Oppervlakte van een zoom-level 1 hexagon (in m2).
 */
INSERT INTO constants (key, value) VALUES ('SURFACE_ZOOM_LEVEL_1', 10000);

/**
 * Aantal zoom-levels.
 */
INSERT INTO constants (key, value) VALUES ('MAX_ZOOM_LEVEL', 5);

/**
 * De geometry of interest area buffer (in meters).
 */
INSERT INTO constants (key, value) VALUES ('GEOMETRY_OF_INTEREST_BUFFER', 170);