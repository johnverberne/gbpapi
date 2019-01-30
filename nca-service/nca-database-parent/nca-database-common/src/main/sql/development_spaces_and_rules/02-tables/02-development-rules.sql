/*
 * development_rules_constants
 * ---------------------------
 * Tabel met daarin de beleidsregel-constanten per development-rule en assessment-area.
 */
CREATE TABLE development_rules_constants (
	development_rule development_rule_type NOT NULL,
	assessment_area_id integer NOT NULL,
	value real NOT NULL,

	CONSTRAINT development_rules_constants_pkey PRIMARY KEY (development_rule, assessment_area_id)
);
