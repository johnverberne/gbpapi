/*
 * permits
 * -------
 * Aanvragen voor een vergunning (Segment 2).
 */
CREATE TABLE permits (
	request_id integer NOT NULL,
	handler_id integer NOT NULL, -- behandelaar
	received_date timestamp without time zone, -- datum postkamer
	dossier_id text, -- zaaknummer/dossiernummer
	remarks text, -- opmerkingen

	CONSTRAINT permits_pkey PRIMARY KEY (request_id),
	CONSTRAINT permits_fkey_requests FOREIGN KEY (request_id) REFERENCES requests,
	CONSTRAINT permits_fkey_users FOREIGN KEY (handler_id) REFERENCES users
);


/*
 * potentially_rejectable_permits
 * ------------------------------
 * Potentieel af te wijzen aanvragen voor een vergunning. Deze tabel wordt nachtelijks tijdens het
 * bepalen van de wachtrij opnieuw gevuld met aanvragen waarvoor op dat moment geen ruimte is. Ook
 * niet als alle voorgaande aanvragen zouden worden afgewezen. In de GUI worden deze aanvragen met
 * een rood sterretje aangeduid.
 */
CREATE TABLE potentially_rejectable_permits (
	request_id integer NOT NULL,

	CONSTRAINT potentially_rejectable_permits_pkey PRIMARY KEY (request_id),
	CONSTRAINT potentially_rejectable_permits_fkey_permits FOREIGN KEY (request_id) REFERENCES permits
);