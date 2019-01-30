/*
 * ae_output_summary_table
 * -----------------------
 * Genereert bestanden met kengetallen voor alle Natura 2000 gebieden. Dient gebruikt te worden om database releases inhoudelijk met
 * elkaar te kunnen vergelijken.
 * Deze functie genereert een bestand volgens de opgegeven bestandsspecificatie. Het is een algemene tabel met N2000 informatie. Uitvoer is CSV.
 * In de bestandsspecificatie moet de string {title} gebruikt worden, deze zal per tabel vervangen worden door de naam van die tabel.
 * Verder wordt {datesuffix} vervangen door de huidige datum in YYYYMMDD formaat.
 * @param filespec Pad en bestandsspecificatie zoals hierboven beschreven.
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	filename text;
	query text;
BEGIN
	RAISE NOTICE 'Creating summary output.';

	-- There's a number of views that we'll store in temporary tables for the duration of this function. This is
	-- to improve performance when we are creating the tables later on.
	-- Additionally we'll do a temporary mapping between natura2000 areas and receptors. Also for performance.

	RAISE NOTICE 'Mapping N2000 areas to receptors in temporary table...';

	CREATE TEMPORARY TABLE temp_natura2000_areas_to_receptors (
		natura2000_area_id integer NOT NULL,
		receptor_id integer NOT NULL,

		CONSTRAINT temp_natura2000_areas_to_receptors_pkey PRIMARY KEY (natura2000_area_id, receptor_id)
	) ON COMMIT DROP;
	CREATE INDEX idx_temp_natura2000_areas_to_receptors_receptor_id ON temp_natura2000_areas_to_receptors (receptor_id);

	INSERT INTO temp_natura2000_areas_to_receptors(natura2000_area_id, receptor_id)
	SELECT
		natura2000_area_id,
		receptor_id

		FROM natura2000_areas
			INNER JOIN receptors ON ST_Intersects(receptors.geometry, natura2000_areas.geometry);

	filename := replace(filespec, '{datesuffix}', to_char(current_timestamp, 'YYYYMMDD'));
	filename := '''' || filename || '''';

	-- Main table
	-- Natura 2000 number, name, geometry surface, number of receptors touching, number of habitats touching.

	RAISE NOTICE 'Creating main table...';

	query := $QUERY$
	SELECT
		natura2000_area_id,
		name,
		ROUND(ST_Area(geometry)) AS surface,
		num_receptors,
		num_habitats

		FROM natura2000_areas
			INNER JOIN
				(SELECT
					natura2000_area_id,
					COUNT(receptor_id) AS num_receptors

					FROM temp_natura2000_areas_to_receptors

					GROUP BY natura2000_area_id
				) AS receptor_count USING (natura2000_area_id)
			INNER JOIN
				(SELECT
					natura2000_area_id,
					COUNT(habitat_type_id) AS num_habitats
					/*, SUM(ST_Area(habitat_areas.geometry))*/

					FROM natura2000_areas
						INNER JOIN habitat_areas ON ST_Intersects(habitat_areas.geometry, natura2000_areas.geometry)
						INNER JOIN habitat_types USING (habitat_type_id)

					GROUP BY natura2000_area_id
				) AS habitat_count USING (natura2000_area_id)

		ORDER BY natura2000_area_id
	$QUERY$;

	EXECUTE 'COPY (' || query || ') TO ' || replace(filename, '{title}', 'main_summary_table') || ' CSV HEADER';
END;
$BODY$
LANGUAGE plpgsql VOLATILE;