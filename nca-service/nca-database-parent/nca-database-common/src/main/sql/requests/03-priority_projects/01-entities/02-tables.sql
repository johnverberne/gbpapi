/*
 * priority_projects
 * -----------------
 * Aanvraag voor een prioritair project (Segment 1 in Register).
 * De OR van een prioritair project kan worden toegekend in delen in de vorm van deelprojecten (priority_subprojects).
 *
 * @column dossier_id Zaaknummer/dossiernummer
 * @column remarks Opmerkingen
 * @column assign_completed Of uitgifte is voltooid
 * @column fraction_assigned Deel dat is toegekend (gecached om snel status te kunnen ophalen)
 */
CREATE TABLE priority_projects (
	request_id integer NOT NULL,
	dossier_id text,
	remarks text,
	assign_completed boolean NOT NULL,
	fraction_assigned real NOT NULL DEFAULT 0,

	CONSTRAINT priority_projects_pkey PRIMARY KEY (request_id),
	CONSTRAINT priority_projects_fkey_requests FOREIGN KEY (request_id) REFERENCES requests
);


/*
 * priority_subprojects
 * --------------------
 * Aanvraag voor een deelproject van een prioritair project (in Register).
 * De OR van een prioritair project kan worden toegekend in delen in de vorm van deelprojecten.
 */
CREATE TABLE priority_subprojects (
	request_id integer NOT NULL,
	priority_project_request_id integer NOT NULL, -- koepelproject
	label text,

	CONSTRAINT priority_subprojects_pkey PRIMARY KEY (request_id),
	CONSTRAINT priority_subprojects_fkey_requests FOREIGN KEY (request_id) REFERENCES requests,
	CONSTRAINT priority_subprojects_fkey_priority_projects FOREIGN KEY (priority_project_request_id) REFERENCES priority_projects(request_id)
);
