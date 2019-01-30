/*
 * default_gcn_sector_source_characteristics_view
 * ----------------------------------------------
 * View retourneert de default GCN bron karakteristieken.
 * De GCN bron karakteristieken lijst is per GCN sector en stof. Deze view retourneert de bron karakteristieken van de meest relevante stof.
 */
CREATE OR REPLACE VIEW default_gcn_sector_source_characteristics_view AS
SELECT
	gcn_sector_id,
	heat_content,
	height,
	spread,
	emission_diurnal_variation_id,
	particle_size_distribution
	
	FROM gcn_sector_source_characteristics

	WHERE
		(substance_id = 11 AND (gcn_sector_id < 4120 OR gcn_sector_id >= 4300)) -- default source_characteristics
		OR (substance_id = 17 AND gcn_sector_id >= 4120 AND gcn_sector_id < 4300) -- nh3 farm source_characteristics
;


/*
 * emission_diurnal_variations_view
 * --------------------------------
 * View retourneert een lijst met verschillende types temporele variaties.
 */
CREATE OR REPLACE VIEW emission_diurnal_variations_view AS
SELECT
	emission_diurnal_variation_id,
	code AS emission_diurnal_variation_code,
	name AS emission_diurnal_variation_name,
	description AS_diurnal_variation_description

	FROM emission_diurnal_variations
;


/*
 * default_source_characteristics_view
 * -----------------------------------
 * View retourneert de emissie karakteristieken per AERIUS sector.
 * Valt terug op een default GCN bron karakteristieken indien er geen AERIUS default waarde is opgegeven.
 */
CREATE OR REPLACE VIEW default_source_characteristics_view AS
SELECT
	sector_id,
	gcn_sector_id,
	heat_content,
	height,
	spread,
	emission_diurnal_variation_id,
	emission_diurnal_variation_code,
	particle_size_distribution

	FROM
		(SELECT
			sector_id,
			gcn_sector_id,
			COALESCE(aerius_char.heat_content, gcn_char.heat_content) AS heat_content,
			COALESCE(aerius_char.height, gcn_char.height) AS height,
			COALESCE(aerius_char.spread, gcn_char.spread) AS spread,
			COALESCE(aerius_char.emission_diurnal_variation_id, gcn_char.emission_diurnal_variation_id) AS emission_diurnal_variation_id,
			COALESCE(aerius_char.particle_size_distribution, gcn_char.particle_size_distribution) AS particle_size_distribution

			FROM sectors
				LEFT JOIN sector_default_source_characteristics AS aerius_char USING (sector_id)
				LEFT JOIN sectors_main_gcn_sector USING (sector_id)
				LEFT JOIN default_gcn_sector_source_characteristics_view AS gcn_char USING (gcn_sector_id)

		) AS source_characteristics

		INNER JOIN emission_diurnal_variations_view USING (emission_diurnal_variation_id)
;