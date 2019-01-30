/*
 * ae_determine_nearest_province
 * -----------------------------
 * Functie welke teruggeeft in welke provincie een punt ligt, of anders wat de dichtsbijzijnde provincie is.
 *
 * @column v_point Het punt waarbij de provincie gevonden moet worden. In het geval van een aanvraag wordt hier het middelpunt van de bronnen voor gebruikt.
 * @returns Id van provincie (province_area_id).
 */
CREATE OR REPLACE FUNCTION ae_determine_nearest_province(v_point geometry)
	RETURNS integer AS
$BODY$
DECLARE
	v_province_area_id integer := NULL;
BEGIN
	-- Find province that the point is located in.
	SELECT province_area_id INTO v_province_area_id FROM province_areas WHERE ST_Within(v_point, geometry) ORDER BY name LIMIT 1;

	IF v_province_area_id IS NULL THEN
		-- If not in any province, use the slower query that finds the nearest province.
		SELECT province_area_id INTO STRICT v_province_area_id FROM province_areas ORDER BY ST_Distance(v_point, geometry), name LIMIT 1;
	END IF;

	RETURN v_province_area_id;
END;
$BODY$
LANGUAGE plpgsql STABLE RETURNS NULL ON NULL INPUT;
