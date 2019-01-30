/*
 * ae_select_imaer_features
 * ------------------------
 * Functie voor het selecteren van IMAER-features van een geïmporteerde IMAER-file.
 *
 * @column v_imported_imaer_file_id Het id van de geïmporteerde IMAER-file.
 * @column v_x De positie op de longitude.
 * @column v_y De positie op de latitude.
 * @column v_buffer De buffer waarin de imaer-features moeten vallen.
 *
 * @returns feature_id De gml-identifier van imaer-feature.
 * @returns imaer_feature De imaer-feature waarop de geo-layer-feature gebaseerd is.
 * @returns De IMAER-versie van de IMAER-file (GML).
 * @returns geometry De geometry van de imaer-feature.
 */
CREATE OR REPLACE FUNCTION ae_select_imaer_features(v_imported_imaer_file_id integer, v_x integer, v_y integer, v_buffer real)
	 RETURNS TABLE (feature_id text, imaer_feature text, imaer_version text, geometry geometry) AS
$BODY$
	SELECT
		id AS feature_id,
		feature AS imaer_feature,
		version AS imaer_version,	
		geometry

		FROM imported_imaer_features
			INNER JOIN imported_imaer_files USING (imported_imaer_file_id)

		WHERE
			imported_imaer_file_id = v_imported_imaer_file_id
			AND ST_Distance(geometry, ST_SetSRID(ST_MakePoint(v_x, v_y), ae_get_srid())) <= v_buffer
	;
$BODY$
LANGUAGE sql IMMUTABLE;


/*
 * ae_delete_imported_imaer_file
 * -----------------------------
 * Gebruik deze functie om een geïmporteerd IMAER-file te verwijderen inclusief de bijbehorende kaartlagen.
 *
 * @param v_imported_imaer_file_id Id van de IMAER-file die verwijderd moet worden.
 */
CREATE OR REPLACE FUNCTION ae_delete_imported_imaer_file(v_imported_imaer_file_id integer)
	RETURNS void AS
$BODY$
	DELETE FROM user_geo_layer_features WHERE user_geo_layer_feature_id IN (SELECT user_geo_layer_feature_id FROM user_geo_layers WHERE imported_imaer_file_id = v_imported_imaer_file_id);
	DELETE FROM user_geo_layers WHERE imported_imaer_file_id = v_imported_imaer_file_id;
	DELETE FROM imported_imaer_features WHERE imported_imaer_file_id = v_imported_imaer_file_id;
	DELETE FROM user_imported_imaer_files WHERE imported_imaer_file_id = v_imported_imaer_file_id;
	DELETE FROM imported_imaer_files WHERE imported_imaer_file_id = v_imported_imaer_file_id;
$BODY$
LANGUAGE sql VOLATILE;