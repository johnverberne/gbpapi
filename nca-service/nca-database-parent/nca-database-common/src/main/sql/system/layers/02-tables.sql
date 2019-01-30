/*
 * layer_legends
 * -------------
 * Legenda voor (WMS) layers. Bevat id, type en omschrijving. Meerdere lagen kunnen verwijzen
 * naar een specifieke legenda.
 */
CREATE TABLE system.layer_legends (
	layer_legend_id integer NOT NULL,
	legend_type system.layer_legend_type NOT NULL,
	description text NOT NULL,

	CONSTRAINT layer_legends_pkey PRIMARY KEY (layer_legend_id)
);


/*
 * layer_legend_color_items
 * ------------------------
 * Items voor de legenda's van (WMS) layers.
 */
CREATE TABLE system.layer_legend_color_items (
	layer_legend_id integer NOT NULL,
	name text NOT NULL,
	color system.color NOT NULL,
	sort_order integer NOT NULL,

	CONSTRAINT layer_legend_color_items_pkey PRIMARY KEY (layer_legend_id, name),
	CONSTRAINT layer_legend_color_items_fkey_layer_legends FOREIGN KEY (layer_legend_id) REFERENCES system.layer_legends
);


/*
 * layer_data_range_items
 * ----------------------
 * Items voor de legenda's van filter (WMS) layers.
 */
CREATE TABLE system.layer_data_range_items (
  layer_legend_id integer NOT NULL,
  name text NOT NULL,
  range float NOT NULL,
  sort_order integer NOT NULL,

  CONSTRAINT layer_data_range_items_pkey PRIMARY KEY (layer_legend_id, name)
);


/*
 * layer_capabilities
 * ------------------
 * Capabilities voor een laag.
 */
CREATE TABLE system.layer_capabilities (
	layer_capabilities_id integer NOT NULL,
	url text NOT NULL,

	CONSTRAINT layer_capabilities_pkey PRIMARY KEY (layer_capabilities_id)
);


/*
 * layer_properties
 * ----------------
 * Parent tabel voor properties voor lagen. Bevat zelf geen fysieke records.
 */
CREATE TABLE system.layer_properties (
	layer_properties_id integer NOT NULL,
	title text,
	attribution text,
	opacity float NOT NULL,
	enabled boolean NOT NULL,
	layer_legend_id integer,
	min_scale integer,
	max_scale integer,

	CONSTRAINT layer_properties_pkey PRIMARY KEY (layer_properties_id),
	CONSTRAINT layer_properties_fkey_layer_legends FOREIGN KEY (layer_legend_id) REFERENCES system.layer_legends
);


/*
 * tms_layer_properties
 * --------------------
 * Bevat properties voor TMS (Tile Map Service) lagen.
 */
CREATE TABLE system.tms_layer_properties (
	base_url text NOT NULL,
	image_type text NOT NULL,
	service_version text NOT NULL

) INHERITS (system.layer_properties);

CREATE UNIQUE INDEX idx_tms_layers_layer_id ON system.tms_layer_properties (layer_properties_id);


/*
 * wms_layer_properties
 * --------------------
 * Bevat properties voor WMS (Web Map Service) lagen.
 */
CREATE TABLE system.wms_layer_properties (
	layer_capabilities_id integer NOT NULL,
	sld_url text,
	begin_year integer,
	end_year integer,
	dynamic_type system.dynamic_wms_layer_type,
	tile_size integer

) INHERITS (system.layer_properties);

CREATE UNIQUE INDEX idx_wms_layers_layer_properties_id ON system.wms_layer_properties (layer_properties_id);


/*
 * layers
 * ------
 * Parent tabel voor lagen.
 */
CREATE TABLE system.layers (
	layer_id integer NOT NULL,
	layer_properties_id integer NOT NULL,
	layer_type system.layer_type NOT NULL,
	name text NOT NULL,

	CONSTRAINT layers_pkey PRIMARY KEY (layer_id)
);


/*
 * default_layers
 * --------------
 * Tabel om aan te geven welke lagen standaard geladen moeten worden (en in welke volgorde).
 */
CREATE TABLE system.default_layers (
	layer_id integer NOT NULL,
	sort_order integer NOT NULL,
	part_of_base_layer boolean,

	CONSTRAINT default_layers_pkey PRIMARY KEY (layer_id),
	CONSTRAINT default_layers_fkey_layers FOREIGN KEY (layer_id) REFERENCES system.layers
);
