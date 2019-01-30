/*
 * province_land_borders
 * ---------------------
 * Provinciale landgrenzen (dus excl. water).
 */
CREATE TABLE setup.province_land_borders (
	province_land_border_id integer NOT NULL,
	name text NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT province_land_borders_pkey PRIMARY KEY (province_land_border_id),
	CONSTRAINT province_land_borders_name_unique UNIQUE (name)
);

CREATE INDEX province_land_borders_geometry_gist ON setup.province_land_borders USING GIST (geometry);


/*
 * geometry_of_interests
 * ---------------------
 * De interessegebieden behorende de natuurgebieden. Op basis van deze geoemtry zijn de receptors gemaakt.
 */
CREATE TABLE setup.geometry_of_interests (
	assessment_area_id integer NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT geometry_of_interests_pkey PRIMARY KEY (assessment_area_id)
);

CREATE INDEX geometry_of_interests_geometry_gist ON setup.geometry_of_interests USING GIST (geometry);

