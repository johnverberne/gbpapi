/*
 * habitat_type_colors
 * -------------------
 * Systeem tabel voor de WMS kleuren van habitattypes.
 */
CREATE TABLE system.habitat_type_colors (
	habitat_type_id integer NOT NULL,
	fill_color system.color NOT NULL,
	stroke_color system.color NOT NULL,

	CONSTRAINT habitat_type_colors_pkey PRIMARY KEY (habitat_type_id),
	CONSTRAINT habitat_type_colors_fkey_habitat_types FOREIGN KEY (habitat_type_id) REFERENCES habitat_types
);
