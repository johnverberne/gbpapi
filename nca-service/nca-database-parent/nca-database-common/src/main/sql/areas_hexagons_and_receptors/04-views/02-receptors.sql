/*
 * terrain_properties_view
 * -----------------------
 * View retourneert alle terrain-properties voor zoom-level 1.
 */
CREATE OR REPLACE VIEW terrain_properties_view AS
SELECT *

	FROM terrain_properties
	
	WHERE zoom_level = 1;
;


/*
 * permit_required_receptors_view
 * ------------------------------
 * View retourneert de (sub)set van receptors die relevant zijn voor de Wet Natuurbescherming berekening.
 * Het gaat hier om alle stikstof-relevante receptoren (included_receptors).
 */
CREATE OR REPLACE VIEW permit_required_receptors_view AS
SELECT
	receptor_id,
	average_roughness,
	dominant_land_use,
	land_uses

	FROM included_receptors
		INNER JOIN terrain_properties_view USING (receptor_id)
;
