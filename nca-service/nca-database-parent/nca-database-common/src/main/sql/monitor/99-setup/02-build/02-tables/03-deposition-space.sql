/*
 * setup.sector_deposition_space_corrections_jurisdiction_policies
 * ---------------------------------------------------------------
 * De correctie op de depositieruimte (en de totale depositie jurisdiction_policies).
 */
CREATE TABLE setup.sector_deposition_space_corrections_jurisdiction_policies (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	correction real NOT NULL,

	CONSTRAINT sector_deposition_space_corrections_jp_pkey PRIMARY KEY (receptor_id, year, sector_id),
	CONSTRAINT sector_deposition_space_corrections_jp_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
	CONSTRAINT sector_deposition_space_corrections_jp_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);


/*
 * sector_deposition_space_segmentations
 * -------------------------------------
 * De vedeling van de resterende generieke behoefte.
 */
CREATE TABLE setup.sector_deposition_space_segmentations (
	sector_id integer NOT NULL,
	priority_projects_size fraction NOT NULL,
	no_permit_required_size fraction NOT NULL,
	projects_size fraction NOT NULL,
	permit_threshold_size fraction NOT NULL,

	CONSTRAINT sector_deposition_space_segmentations_pkey PRIMARY KEY (sector_id),
	CONSTRAINT sector_deposition_space_segmentations_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,

	CONSTRAINT sector_deposition_space_segmentations_valid_segmententation
		CHECK
			((priority_projects_size = 1.0 AND no_permit_required_size + projects_size + permit_threshold_size = 0.0)
			OR (priority_projects_size = 0.0 AND no_permit_required_size + projects_size + permit_threshold_size = 1.0))
);


/*
 * deposition_spaces
 * -----------------
 * De totale ontwikkelingsruimte per receptor/jaar.
 */
CREATE TABLE setup.deposition_spaces (
	year year_type NOT NULL,
	receptor_id integer NOT NULL,
	total_space real NOT NULL,
	total_space_addition real NOT NULL,

	CONSTRAINT deposition_spaces_pkey PRIMARY KEY (receptor_id, year)--,
	--CONSTRAINT deposition_spaces_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);