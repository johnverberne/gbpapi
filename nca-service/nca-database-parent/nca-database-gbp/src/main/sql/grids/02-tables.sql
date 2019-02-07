/*
 * grids (mogelijk gridcells gaan noemen)
 * ---------
 * Grids (100x100 meter vierkante vlakken geometrie)
 */
CREATE TABLE grids (
	grid_id integer NOT NULL,
	geometry geometry(Polygon),
	CONSTRAINT grids_pkey PRIMARY KEY (grid_id)
);

CREATE INDEX idx_grids_geometry_gist ON grids USING GIST (geometry);
