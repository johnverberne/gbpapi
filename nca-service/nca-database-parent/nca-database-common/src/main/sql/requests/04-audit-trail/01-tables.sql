/*
 * request_audit_trail_items
 * -------------------------
 * Geschiedenis van een OR-aanvraag. Per keer dat er data toegevoegd of gewijzigd wordt, wordt een item aangemaakt.
 * Het tijdstip van de wijziging en de ingelogde gebruiker die de wijziging doorvoert worden opgeslagen.
 *
 * Deze tabel heeft geen foreign key naar requests omdat het mogelijk moet zijn de requests uit de database te verwijderen,
 * waarna de audit trail wel behouden moet blijven.
 * Tevens bevat de tabel het veld segment, wat dubbelop lijkt. Dit veld is toegevoegd zodat we het segment nog weten als de request verwijderd is.
 * Hetzelfde gels voor reference.
 */
CREATE TABLE request_audit_trail_items (
	request_audit_trail_item_id serial NOT NULL,
	request_id integer NOT NULL,
	reference text NOT NULL,
	segment segment_type NOT NULL,
	user_id integer NOT NULL,
	audit_trail_date_time timestamp,

	CONSTRAINT request_audit_trail_items_pkey PRIMARY KEY (request_audit_trail_item_id),
	CONSTRAINT request_audit_trail_items_fkey_users FOREIGN KEY (user_id) REFERENCES users
);


/*
 * request_audit_trail_item_changes
 * --------------------------------
 * Per keer dat er data toegevoegd of gewijzigd wordt kunnen meerdere wijzigingen gedaan zijn.
 * Deze wijzigingen worden hier opgeslagen met een indicatie van het type wijziging en de oude en de nieuwe waarde.
 */
CREATE TABLE request_audit_trail_item_changes (
	request_audit_trail_item_id integer NOT NULL,
	audit_trail_type text NOT NULL,
	old_value text,
	new_value text,

	CONSTRAINT request_audit_trail_item_changes_pkey PRIMARY KEY (request_audit_trail_item_id, audit_trail_type),
	CONSTRAINT request_audit_trail_item_changes_fkey_audit_trail_item FOREIGN KEY (request_audit_trail_item_id) REFERENCES request_audit_trail_items
);