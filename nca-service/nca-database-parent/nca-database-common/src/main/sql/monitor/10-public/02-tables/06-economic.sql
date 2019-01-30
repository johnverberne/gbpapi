/*
 * economic_desires
 * ----------------
 * De totale ontwikkelbehoefte per receptor/jaar.
 */
CREATE TABLE economic_desires (
	year year_type NOT NULL,
	receptor_id integer NOT NULL,
	total_desire posreal NOT NULL,

	CONSTRAINT economic_desires_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT economic_desires_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX idx_economic_desires_year_receptor ON economic_desires (year, receptor_id);


/*
 * sector_economic_desires
 * -----------------------
 * De ontwikkelbehoefte per sector per receptor/jaar, gesplitst in priority projects en overige.
 */
CREATE TABLE sector_economic_desires (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	receptor_id integer NOT NULL,
	priority_projects_desire posreal NOT NULL,
	other_desire posreal NOT NULL,

	CONSTRAINT sector_economic_desires_pkey PRIMARY KEY (receptor_id, year, sector_id),
	CONSTRAINT sector_economic_desires_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
	CONSTRAINT sector_economic_desires_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX idx_sector_economic_desires_year_receptor ON sector_economic_desires (year, receptor_id);