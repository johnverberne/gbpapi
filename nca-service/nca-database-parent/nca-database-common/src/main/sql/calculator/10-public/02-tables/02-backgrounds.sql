/*
 * background_cells
 * ----------------
 * Achtergrondcellen (1x1 km vlakken)
 */
CREATE TABLE background_cells (
	background_cell_id integer NOT NULL,
	geometry geometry(Polygon),

	CONSTRAINT background_cells_pkey PRIMARY KEY (background_cell_id)
);

CREATE INDEX idx_background_cells_geometry_gist ON background_cells USING GIST (geometry);


/*
 * background_cell_concentrations
 * ------------------------------
 * Achtergrondconcentraties per jaar.
 * Bron: GCN (Grootschalige Concentratiekaart Nederland).
 */
CREATE TABLE background_cell_concentrations (
	background_cell_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	concentration posreal NOT NULL,

	CONSTRAINT background_cell_concentrations_pkey PRIMARY KEY (background_cell_id, year, substance_id),
	CONSTRAINT background_cell_concentrations_fkey_background_cells FOREIGN KEY (background_cell_id) REFERENCES background_cells,
	CONSTRAINT background_cell_concentrations_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);

CREATE INDEX idx_background_cell_concentrations_year_substance_id ON background_cell_concentrations (year, substance_id);


/*
 * background_cell_depositions
 * ---------------------------
 * Achtergronddeposities per jaar.
 * Bron: GDN (Grootschalige Depositiekaart Nederland).
 */
CREATE TABLE background_cell_depositions (
	background_cell_id integer NOT NULL,
	year year_type NOT NULL,
	deposition posreal NOT NULL,

	CONSTRAINT background_cell_depositions_pkey PRIMARY KEY (background_cell_id, year),
	CONSTRAINT background_cell_depositions_fkey_background_cells FOREIGN KEY (background_cell_id) REFERENCES background_cells
);

/*
 * background_cell_results
 * -----------------------
 * Achtergrond resultaten (concentraties en deposities) per jaar.
 * Samengevoegde depositions en concentrations tabellen.
 *
 * Bevat geen foreign key naar substances omdat hier ook substance_id in voor komt.
 */
CREATE TABLE background_cell_results
(
	background_cell_id integer NOT NULL,
	year year_type NOT NULL,
	substance_id smallint NOT NULL,
	result_type emission_result_type NOT NULL,
	result real,

	CONSTRAINT background_cell_results_pkey PRIMARY KEY (background_cell_id, year, substance_id, result_type),
	CONSTRAINT background_cell_results_fkey_background_cells FOREIGN KEY (background_cell_id) REFERENCES background_cells
);


/*
 * receptors_to_background_cells
 * -----------------------------
 * Koppeltabel tussen receptors en background cells.
 */
CREATE TABLE receptors_to_background_cells
(
	receptor_id integer NOT NULL,
	background_cell_id integer NOT NULL,
	
	CONSTRAINT receptors_to_background_cells_pkey PRIMARY KEY (receptor_id, background_cell_id),
	CONSTRAINT receptors_to_background_cells_fkey_background_cells FOREIGN KEY (background_cell_id) REFERENCES background_cells
);
