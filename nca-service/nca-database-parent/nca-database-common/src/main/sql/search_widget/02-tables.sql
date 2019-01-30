/*
 * municipality_areas
 * ------------------
 * Gemeenten in Nederland.
 */
CREATE TABLE municipality_areas
(
	municipality_area_id integer NOT NULL,
	name text NOT NULL,
	code text NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT municipality_areas_pkey PRIMARY KEY (municipality_area_id)
);

CREATE INDEX idx_municipality_areas_geometry_gist ON municipality_areas USING GIST (geometry);
CREATE INDEX idx_municipality_areas_name ON municipality_areas (name);


/*
 * town_areas
 * ----------
 * Plaatsen in Nederland.
 */
CREATE TABLE town_areas
(
	town_area_id integer NOT NULL,
	name text NOT NULL,
	code text NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT town_areas_pkey PRIMARY KEY (town_area_id)
);

CREATE INDEX idx_town_areas_geometry_gist ON town_areas USING GIST (geometry);
CREATE INDEX idx_town_areas_name ON town_areas (name);


/*
 * zip_code_areas
 * --------------
 * Postcode 4 gebieden in Nederland.
 */
CREATE TABLE zip_code_areas
(
	zip_code_area_id integer NOT NULL,
	name text NOT NULL,
	town text NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT zip_code_areas_pkey PRIMARY KEY (zip_code_area_id)
);

CREATE INDEX idx_zip_code_areas_geometry_gist ON zip_code_areas USING GIST (geometry);
CREATE INDEX idx_zip_code_areas_name ON zip_code_areas (name);


/*
 * assessment_areas_to_municipality_areas
 * --------------------------------------
 * Koppeltabel tussen toetsgebieden (natura2000 gebieden) en gemeenten.
 */
CREATE TABLE assessment_areas_to_municipality_areas
(
	municipality_area_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	distance posreal NOT NULL,

	CONSTRAINT assessment_areas_to_municipality_areas_pkey PRIMARY KEY (municipality_area_id, assessment_area_id)
);


/*
 * assessment_areas_to_town_areas
 * ------------------------------
 * Koppeltabel tussen toetsgebieden (natura2000 gebieden) en plaatsen.
 */
CREATE TABLE assessment_areas_to_town_areas
(
	town_area_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	distance posreal NOT NULL,

	CONSTRAINT assessment_areas_to_town_areas_pkey PRIMARY KEY (town_area_id, assessment_area_id)
);


/*
 * assessment_areas_to_zip_code_areas
 * ----------------------------------
 * Koppeltabel tussen toetsgebieden (natura2000 gebieden) en postcode 4 gebieden.
 */
CREATE TABLE assessment_areas_to_zip_code_areas
(
	zip_code_area_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	distance posreal NOT NULL,

	CONSTRAINT assessment_areas_to_zip_code_areas_pkey PRIMARY KEY (zip_code_area_id, assessment_area_id)
);