/*
 * sectorgroup_properties
 * ----------------------
 * Systeemtabel met daarin de properties zoals kleur en icon per sectorgroup.
 */
CREATE TABLE system.sectorgroup_properties (
	sectorgroup system.sectorgroup NOT NULL,
	name text NOT NULL,
	color system.color NOT NULL,
	icon_type text NOT NULL,

	CONSTRAINT sectorgroup_properties_pkey PRIMARY KEY (sectorgroup)
);


/*
 * other_deposition_type_properties
 * --------------------------------
 * Systeemtabel met daarin de properties zoals kleur en icon van de depositiegroepen die niet onder een sector vallen.
 */
CREATE TABLE system.other_deposition_type_properties (
	other_deposition_type other_deposition_type NOT NULL,
	name text NOT NULL,
	color system.color NOT NULL,
	icon_type text NOT NULL,

	CONSTRAINT other_deposition_type_properties_pkey PRIMARY KEY (other_deposition_type)
);


/*
 * assessment_area_report_images
 * -----------------------------
 * Systeemtabel met daarin de images die voor rapportages gebruikt kunnen worden.
 *
 * Voorlopig bevatten deze alleen de foto's die voor elk natuurgebied worden gebruikt voor het voorblad.
 */
CREATE TABLE system.assessment_area_report_images (
	assessment_area_id integer NOT NULL,
	photographer text,
	original_filename text,
	content bytea NOT NULL,

	CONSTRAINT assessment_area_report_images_pkey PRIMARY KEY (assessment_area_id)
);
