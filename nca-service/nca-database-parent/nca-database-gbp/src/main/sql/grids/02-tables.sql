/*
 * grids
 * -----
 * Grids
 */
CREATE TABLE grids (
	grid_id integer NOT NULL,
	geometry geometry(Polygon),
	CONSTRAINT grids_pkey PRIMARY KEY (grid_id)
);

CREATE INDEX idx_grids_geometry_gist ON grids USING GIST (geometry);


/*
 * grids10 (tijdelijke subset)
 * ---------------------------
 * Grids (10x10 meter vierkante vlakken geometrie)
 */
CREATE TABLE grids10 (
	grid_id integer NOT NULL,
	geometry geometry(Polygon),
	CONSTRAINT grids10_pkey PRIMARY KEY (grid_id)
);

CREATE INDEX idx_grids10_geometry_gist ON grids10 USING GIST (geometry);
