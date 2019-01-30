/*
 * imported_imaer_files
 * --------------------
 * Bevat de eigenschappen van de (door de Scenario gebruikers) geïmporteerde IMAER-files. 
 */
CREATE TABLE imported_imaer_files (
	imported_imaer_file_id serial NOT NULL,
	version text NOT NULL,
	filename text NOT NULL,
	insert_date timestamp with time zone NOT NULL DEFAULT now(),	
	--metadata text NOT NULL,
	
	CONSTRAINT imported_imaer_files_pkey PRIMARY KEY (imported_imaer_file_id)
);


/*
 * imported_imaer_features
 * -----------------------
 * Bevat de imaer-features (gml-features) van de geïmporteerde IMAER-files.
 *
 * @column feature De imaer-feature-element string.
 * @column id De gml-identifier van de imaer-feature.
 * @column geometry De geometry van de imaer-feature.
 */
CREATE TABLE imported_imaer_features (
	imported_imaer_feature_id bigserial NOT NULL,
	imported_imaer_file_id integer NOT NULL,
	feature text NOT NULL,
	id text NOT NULL,
	geometry geometry(Geometry) NOT NULL,
	
	CONSTRAINT imported_imaer_features_pkey PRIMARY KEY (imported_imaer_feature_id),
	CONSTRAINT imported_imaer_features_fkey_imported_imaer_files FOREIGN KEY (imported_imaer_file_id) REFERENCES imported_imaer_files
);

CREATE INDEX imported_imaer_features_find_feature_by_id ON imported_imaer_features (imported_imaer_file_id, id);

CREATE INDEX imported_imaer_features_gist ON imported_imaer_features USING GIST (geometry);


/*
 * user_imported_imaer_files
 * -------------------------
 * Koppeltabel voor 1:N koppeling tussen een gebruiker en zijn geïmporteerde IMAER-file(s).
 */
CREATE TABLE user_imported_imaer_files (
	imported_imaer_file_id integer NOT NULL,
	user_id integer NOT NULL,

	CONSTRAINT user_imported_imaer_files_pkey PRIMARY KEY (imported_imaer_file_id),
	CONSTRAINT user_imported_imaer_files_fkey_users FOREIGN KEY (user_id) REFERENCES users,
	CONSTRAINT user_imported_imaer_files_fkey_imported_imaer_files FOREIGN KEY (imported_imaer_file_id) REFERENCES imported_imaer_files
);


/*
 * user_geo_layers
 * ---------------
 * Bevat de eigenschappen van de geo-layer (momenteel enkel WMS) van de Scenario gebruikers.
 *
 * @column key De (unieke) key (sleutel) van de geo-layer. Deze key kan ook uitgedeeld worden indien een gebruiker zijn layer wil delen.
 * @colomn type Het type van de geo-layer (of eigenlijk het type van de geo-layer-features). Op basis van dit type kan bepaald worden welke SLD er gebuikt moeten worden.
 */
CREATE TABLE user_geo_layers (
	user_geo_layer_id serial NOT NULL,
	imported_imaer_file_id integer NOT NULL,
	key text NOT NULL,
	type text NOT NULL,
	
	CONSTRAINT user_geo_layers_pkey PRIMARY KEY (user_geo_layer_id),
	CONSTRAINT user_geo_layers_fkey_imported_imaer_files FOREIGN KEY (imported_imaer_file_id) REFERENCES imported_imaer_files
);

CREATE UNIQUE INDEX idx_user_geo_layers_key ON user_geo_layers (key);

CREATE INDEX user_geo_layers_find_layer_by_type ON user_geo_layers (imported_imaer_file_id, type);


/*
 * user_geo_layer_features
 * -----------------------
 * Bevat de features van de geo-layers.
 *
 * @column value Een geparsde value van de bijbehoorende imaer-feature. In de tabel user_geo_layers is vastgelegd om welk type (value) het gaat.
 */
CREATE TABLE user_geo_layer_features (
	user_geo_layer_feature_id bigserial NOT NULL,
	user_geo_layer_id integer NOT NULL,
	imported_imaer_feature_id integer NOT NULL,
	value text NOT NULL,
	
	CONSTRAINT user_geo_layer_features_pkey PRIMARY KEY (user_geo_layer_feature_id),
	CONSTRAINT user_geo_layer_features_fkey_user_geo_layers FOREIGN KEY (user_geo_layer_id) REFERENCES user_geo_layers,
	CONSTRAINT user_geo_layer_features_fkey_imported_imaer_features FOREIGN KEY (imported_imaer_feature_id) REFERENCES imported_imaer_features
);