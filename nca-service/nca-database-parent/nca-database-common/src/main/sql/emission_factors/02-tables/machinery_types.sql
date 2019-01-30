/*
 * machinery_types
 * ---------------
 * De verschillende soorten werktuigen met naam en sector waarin zij gebruikt worden.
 */
CREATE TABLE machinery_types (
	machinery_type_id integer NOT NULL,
	sector_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL,
	sort_order integer NOT NULL UNIQUE,

	CONSTRAINT machinery_types_pkey PRIMARY KEY (machinery_type_id),
	CONSTRAINT machinery_types_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);


/*
 * machinery_fuel_types
 * --------------------
 * De verschillende soorten brandstof voor werktuigen.
 * @column density soortelijk gewicht in kg/liter.
 */
CREATE TABLE machinery_fuel_types (
	machinery_fuel_type_id integer NOT NULL,
	code text NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	density posreal NOT NULL,

	CONSTRAINT machinery_fuel_types_pkey PRIMARY KEY (machinery_fuel_type_id)
);


/*
 * machinery_type_fuel_options
 * ---------------------------
 * Parameters per werktuig en brandstof voor de emissieberekening.
 * @column power vermogen in kW.
 * @column load belasting, een percentage als fractie.
 * @column energy_efficiency efficientie van de motor in g/kWh (hoeveel gram brandstof benodigd is voor 1 kWh).
 */
CREATE TABLE machinery_type_fuel_options (
	machinery_type_id integer NOT NULL,
	machinery_fuel_type_id integer NULL,
	power posint NOT NULL,
	load fraction NOT NULL,
	energy_efficiency posreal NOT NULL,

	CONSTRAINT machinery_type_fuel_options_pkey PRIMARY KEY (machinery_type_id, machinery_fuel_type_id),
	CONSTRAINT machinery_type_fuel_options_fkey_machinery_types FOREIGN KEY (machinery_type_id) REFERENCES machinery_types,
	CONSTRAINT machinery_type_fuel_options_fkey_machinery_fuel_types FOREIGN KEY (machinery_fuel_type_id) REFERENCES machinery_fuel_types
);


/*
 * machinery_type_emission_factors
 * -------------------------------
 * De emissiefactoren per werktuig, brandstof en emissiestof.
 * Emissie factor is hier in g/kWh.
 */
CREATE TABLE machinery_type_emission_factors (
	machinery_type_id integer NOT NULL,
	machinery_fuel_type_id integer NULL,
	substance_id integer NOT NULL,
	emission_factor posreal NOT NULL,

	CONSTRAINT machinery_type_emission_factors_pkey PRIMARY KEY (machinery_type_id, machinery_fuel_type_id, substance_id),
	CONSTRAINT machinery_type_emission_factors_fkey_machinery_types FOREIGN KEY (machinery_type_id, machinery_fuel_type_id) REFERENCES machinery_type_fuel_options,
	CONSTRAINT machinery_type_emission_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);
