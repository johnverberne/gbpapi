/*
 * priority_project_sites
 * ----------------------
 * De lijst met prioritair projecten.
 */
CREATE TABLE priority_project_sites (
	site_id integer NOT NULL,
	realisation_year year_type NOT NULL,
	authority text NOT NULL,
	description text,
	comment text,

	CONSTRAINT priority_project_sites_pkey PRIMARY KEY (site_id),
	CONSTRAINT priority_project_fkey_site FOREIGN KEY (site_id) REFERENCES sites
);


/*
 * priority_project_site_files
 * ---------------------------
 * De aangeleverde prioritaire project bestanden.
 */
CREATE TABLE priority_project_site_files (
	site_id integer NOT NULL,
	type text NOT NULL,
	filename text NOT NULL,
	content bytea NOT NULL,

	CONSTRAINT priority_project_site_files_pkey PRIMARY KEY (site_id),
	CONSTRAINT priority_project_site_files_fkey_priority_projects FOREIGN KEY (site_id) REFERENCES priority_project_sites
);
