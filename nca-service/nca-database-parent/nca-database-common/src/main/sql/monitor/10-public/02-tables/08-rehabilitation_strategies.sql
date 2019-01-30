/*
 * rehabilitation_strategies
 * -------------------------
 * Maatregelen per natuurgebied.
 *
 * Area is de indicatie van oppervlakte of lengte van de maatregel inclusief eenheid. Dit is dus een tekstveld!
 * Geometry_accuracy geeft hierbij aan of de geometrie precies is (strict) of een zoekgebied (sketch).
 */
CREATE TABLE rehabilitation_strategies (
	rehabilitation_strategy_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	description text NOT NULL,
	note text NOT NULL,
	area text,
	geometry_accuracy rehabilitation_strategy_geometry_accuracy_type NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT rehabilitation_strategies_pkey PRIMARY KEY (rehabilitation_strategy_id),
	CONSTRAINT rehabilitation_strategies_fkey_assessment_areas FOREIGN KEY (assessment_area_id) REFERENCES natura2000_areas (assessment_area_id) -- Currently limited to N2000. Can't reference base table 'assessment_areas'.
);

CREATE INDEX rehabilitation_strategies_geometry_gist ON rehabilitation_strategies USING GIST (geometry);


/*
 * rehabilitation_strategies_to_receptors
 * --------------------------------------
 * Koppeltabel tussen maatregelen en receptoren.
 */
CREATE TABLE rehabilitation_strategies_to_receptors (
	rehabilitation_strategy_id integer NOT NULL,
	receptor_id integer NOT NULL,

	CONSTRAINT rehabilitation_strategies_to_receptors_pkey PRIMARY KEY (rehabilitation_strategy_id, receptor_id),
	CONSTRAINT rehabilitation_strategies_to_receptors_fkey_rehabilitation_strategies FOREIGN KEY (rehabilitation_strategy_id) REFERENCES rehabilitation_strategies,
	CONSTRAINT rehabilitation_strategies_to_receptors_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * rehabilitation_strategy_habitat_types
 * -------------------------------------
 * De (aangewezen) habitattypes waar een kenschetsmaatregel voor geldt.
 */
CREATE TABLE rehabilitation_strategy_habitat_types (
	rehabilitation_strategy_id integer NOT NULL,
	habitat_type_id integer NOT NULL,
	potential potential_type NOT NULL,
	frequency frequency_type NOT NULL,
	response_time response_time_type,

	CONSTRAINT rehabilitation_strategy_habitat_types_pkey PRIMARY KEY (rehabilitation_strategy_id, habitat_type_id),
	CONSTRAINT rehabilitation_strategy_habitat_types_fkey_rehabilitation_strategies FOREIGN KEY (rehabilitation_strategy_id) REFERENCES rehabilitation_strategies,
	CONSTRAINT rehabilitation_strategy_habitat_types_fkey_habitat_type_id FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
);


/*
 * rehabilitation_strategy_management_periods
 * ------------------------------------------
 * Beheerplanperiodes waarin een kenschetsmaatregel geldt.
 */
CREATE TABLE rehabilitation_strategy_management_periods (
	rehabilitation_strategy_id integer NOT NULL,
	management_period management_period_type NOT NULL,

	CONSTRAINT rehabilitation_strategy_management_periods_pkey PRIMARY KEY (rehabilitation_strategy_id, management_period),
	CONSTRAINT rehabilitation_strategy_management_periods_fkey_rehabilitation_strategies FOREIGN KEY (rehabilitation_strategy_id) REFERENCES rehabilitation_strategies
);


/*
 * rehabilitation_strategy_files
 * -----------------------------
 * De aangeleverde png maatregelkaarten.
 */
CREATE TABLE rehabilitation_strategy_files (
	assessment_area_id integer NOT NULL,
	rehabilitation_strategy_file_id integer NOT NULL,
	content bytea NOT NULL,

	CONSTRAINT rehabilitation_strategy_files_pkey PRIMARY KEY (assessment_area_id, rehabilitation_strategy_file_id)
);
