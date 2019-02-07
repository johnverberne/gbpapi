CREATE TABLE grids (
	grid_id integer NOT NULL,
	geometry geometry(Polygon),
	CONSTRAINT grids_pkey PRIMARY KEY (grid_id)
);
