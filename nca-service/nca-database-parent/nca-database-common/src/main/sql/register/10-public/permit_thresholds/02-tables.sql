/*
 * permit_threshold_values_audit_trail
 * -----------------------------------
 * Geschiedenis van aanpassingen in de grenswaarde tabel. De grenswaarde van een gebied kan worden aangepast op basis van de grenswaardereservering
 * die nog over is. Dit gebeurt geautomatiseerd. De informatie over de aanpassing wordt gelogged in deze tabel.
 */
CREATE TABLE permit_threshold_values_audit_trail (
	permit_threshold_values_audit_trail_id serial NOT NULL,
	audit_trail_date_time timestamp DEFAULT now(),
	assessment_area_id integer NOT NULL,
	old_value posreal NOT NULL,
	new_value posreal NOT NULL,

	CONSTRAINT permit_threshold_values_audit_trail_pkey PRIMARY KEY (permit_threshold_values_audit_trail_id)
);
