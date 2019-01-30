/*
 * user_geo_layers_view
 * --------------------
 * View voor het retourneren van de de geo-layers per Sencario gebruiker.
 *
 * @column api_key De (unieke) key (sleutel) van een Scenario gebruiker. Aan de hand van deze key kan het systeem dan de user_id opzoeken.
 * @column imaer_filename De filename van de ingeladen IMAER-file.
 * @column key De (unieke) key (sleutel) van de geo-layer. Deze key kan ook uitgedeeld worden indien een gebruiker zijn layer wil delen.
 * @colomn type Het type van de geo-layer (of eigenlijk het type van de geo-layer-features). Op basis van dit type kan bepaald worden welke SLD er gebuikt moeten worden.
 */
CREATE OR REPLACE VIEW user_geo_layers_view AS
SELECT
	api_key,
	filename AS imaer_filename,
	key,
	type

	FROM imported_imaer_files
		INNER JOIN user_geo_layers USING (imported_imaer_file_id)
		INNER JOIN user_imported_imaer_files USING (imported_imaer_file_id)
		INNER JOIN users USING (user_id)
;
		


/*
 * wms_user_geo_layer_features_view
 * --------------------------------
 * Generieke view voor het retoureren van de WMS features behorende een geo-layer.
 *
 * @column key De key behorende de geo-layer.
 * @column type Het type van de geo-layer-features.
 * @column value De value van de geo-layer-feature.
 * @column feature_id De gml-identifier van imaer-feature.
 * @column imaer_feature De imaer-feature waarop de geo-layer-feature gebaseerd is.
 * @column imaer_version De IMAER-versie van de IMAER-file (GML).
 */
CREATE OR REPLACE VIEW wms_user_geo_layer_features_view AS
SELECT
	key,
	type,
	value,
	id AS feature_id,
	feature AS imaer_feature,
	version AS imaer_version,
	geometry

	FROM user_geo_layer_features
		INNER JOIN user_geo_layers USING (user_geo_layer_id)
		INNER JOIN imported_imaer_features USING (imported_imaer_feature_id, imported_imaer_file_id)
		INNER JOIN imported_imaer_files USING (imported_imaer_file_id)
;