/*
 * exceeding_receptors
 * -------------------
 * Tabel met daarin de receptoren waarbij de KDW na realisatie van de behoefte dreigt overschreden te worden (KDW - 70 mol).
 * Het gaat in dit geval om de depositie naar provinciaal beleid.
 */
CREATE TABLE exceeding_receptors (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,

	CONSTRAINT exceeding_receptors_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT exceeding_receptors_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * jurisdictions
 * -------------
 * Gezagsgebieden incl. geometrie (momenteel alleen provincies)
 */
CREATE TABLE jurisdictions
(
	jurisdiction_id integer NOT NULL,
	name text NOT NULL,
	geometry geometry(MultiPolygon),

	CONSTRAINT jurisdictions_pkey PRIMARY KEY (jurisdiction_id),
	CONSTRAINT jurisdictions_name_unique UNIQUE (name)
);

CREATE INDEX jurisdictions_geometry_gist ON jurisdictions USING GIST (geometry);


/*
 * assessment_area_detailed_extents
 * --------------------------------
 * Gebiedssamenvatting-gerelateerde tabel voor de opdeling van N2000 gebieden voor de detail bijlage van de GS.
 */
CREATE TABLE assessment_area_detailed_extents (
	assessment_area_id integer NOT NULL,
	index_number posint NOT NULL,
	geometry geometry(Polygon),

	CONSTRAINT assessment_area_detailed_extents_pkey PRIMARY KEY (assessment_area_id, index_number),
	CONSTRAINT assessment_area_detailed_extents_fkey_assessment_areas FOREIGN KEY (assessment_area_id) REFERENCES natura2000_areas (assessment_area_id)
);