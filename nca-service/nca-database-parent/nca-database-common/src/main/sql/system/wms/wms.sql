/*
 * sld
 * ---
 * Basis om een SLD laag te kunnen genereren uit de database. Bevat id en omschrijving. Meerdere lagen kunnen verwijzen
 * naar een specifieke SLD (zie ook sld_wms_layers en sld_rules).
 */
CREATE TABLE system.sld (
	sld_id integer NOT NULL,
	description text NOT NULL,

	CONSTRAINT sld_pkey PRIMARY KEY (sld_id)
);


/*
 * sld_rules
 * ---------
 * Een SLD bevat 1 of meerdere regels/filters. Per filter wordt aangegeven hoe een row uit de database (uit een WMS view) die
 * matcht moet worden getekend op de kaart. Per zoomlevel, mits gedefinieerd, komen de filters terug met als extra conditie dat ook
 * de zoomlevel matcht. Zo worden bijv. de hexagonen per zoomlevel gematcht en getekend waardoor deze in grote kunnen verschillen
 * afhankelijk van de opgevraagde zoomlevel.
 */
CREATE TABLE system.sld_rules (
	sld_rule_id serial NOT NULL,
	sld_id integer NOT NULL,
	condition text,
	fill_color system.color,
	stroke_color system.color,
	custom_draw_sld text,
	custom_condition_sld text,
	image_url text,

	CONSTRAINT sld_rules_pkey PRIMARY KEY (sld_rule_id),
	CONSTRAINT sld_rules_fkey_sld FOREIGN KEY (sld_id) REFERENCES system.sld,
	CONSTRAINT sld_rules_enforce_one_setting_at_least CHECK (
		(fill_color IS NOT NULL)
		OR (stroke_color IS NOT NULL)
		OR (custom_draw_sld IS NOT NULL)
		OR (image_url IS NOT NULL))
);


/*
 * wms_zoom_levels
 * ---------------
 * Een WMS laag bevat optioneel zoomlevels. De groep zoomlevels zijn vaak hetzelfde. Hier wordt een groep bijgehouden met
 * bijhorende titel (zie ook wms_zoom_level_properties).
 */
CREATE TABLE system.wms_zoom_levels (
	wms_zoom_level_id integer NOT NULL,
	name text,

	CONSTRAINT wms_zoom_levels_pkey PRIMARY KEY (wms_zoom_level_id)
);


/*
 * wms_zoom_level_properties
 * -------------------------
 * Bevat een of meerdere zoomlevels die bij een zoomlevelgroep horen (zie wms_zoom_levels). Bevat een zoom_level kolom welke matcht
 * met de zoom_level kolommen die in bepaalde WMS views terugkomen.
 */
CREATE TABLE system.wms_zoom_level_properties (
	wms_zoom_level_id integer NOT NULL,
	min_scale integer NOT NULL,
	max_scale integer NOT NULL,
	zoom_level posint,

	CONSTRAINT wms_zoom_level_properties_pkey PRIMARY KEY (wms_zoom_level_id, min_scale, max_scale),
	CONSTRAINT wms_zoom_level_properties_fkey_wms_zoom_levels FOREIGN KEY (wms_zoom_level_id) REFERENCES system.wms_zoom_levels
);


/*
 * sld_wms_layers
 * --------------
 * Basis om een volledige SLD voor een WMS laag te kunnen genereren uit de database. Bevat layer naam, titel en optioneel een verwijzing naar
 * zoomlevels (zie ook wms_zoom_levels en wms_zoom_level_properties) en sld (zie ook sld en sld_rules).
 */
CREATE TABLE system.sld_wms_layers (
	sld_wms_layer_id serial NOT NULL,
	wms_zoom_level_id integer,
	sld_id integer,
	name character varying(128) NOT NULL,
	title text NOT NULL,
	target_layer_name character varying(128),

	CONSTRAINT sld_wms_layers_pkey PRIMARY KEY (sld_wms_layer_id),
	CONSTRAINT sld_wms_layers_fkey_wms_zoom_levels FOREIGN KEY (wms_zoom_level_id) REFERENCES system.wms_zoom_levels,
	CONSTRAINT sld_wms_layers_fkey_sld FOREIGN KEY (sld_id) REFERENCES system.sld
);

CREATE UNIQUE INDEX idx_sld_wms_layers_name ON system.sld_wms_layers (name);
