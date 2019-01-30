/*
 * color_ranges
 * ------------
 * Tabel om de kleuren bij te houden van een bereik waarbinnen receptoren gegroupeerd kunnen worden.
 */
CREATE TABLE system.color_ranges (
	color_range_type color_range_type NOT NULL,
	lower_value real NOT NULL,
	color system.color NOT NULL,

	CONSTRAINT color_ranges_pkey PRIMARY KEY (color_range_type, lower_value)
);

/*
 * options
 * -------
 * Systeem tabel voor de webapplicatie voor de opties in lijstjes die niet afgeleid kunnen worden uit andere data.
 */
CREATE TABLE system.options (
	option_type system.option_type NOT NULL,
	value text NOT NULL,
	label text NOT NULL,
	default_value boolean NOT NULL,

	CONSTRAINT options_pkey PRIMARY KEY (option_type, value)
);
