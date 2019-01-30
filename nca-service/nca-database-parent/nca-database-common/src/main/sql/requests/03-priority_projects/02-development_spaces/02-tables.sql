/*
 * priority_project_development_spaces
 * -----------------------------------
 * De gereserveerde en toegekende segment 1 ontwikkelingsruimte per prioritair project.
 * Let op dat per prioritair project de receptorset een subset kan zijn van die in reserved_development_spaces.
 */
CREATE TABLE priority_project_development_spaces (
	request_id integer NOT NULL,
	receptor_id integer NOT NULL,
	reserved_space posreal NOT NULL,
	assigned_space posreal NOT NULL,

	CONSTRAINT priority_project_development_spaces_pkey PRIMARY KEY (request_id, receptor_id),
	CONSTRAINT priority_project_development_spaces_fkey_priority_projects FOREIGN KEY (request_id) REFERENCES priority_projects
);
