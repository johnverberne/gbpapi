/*
 * non_aggregated_sources_view
 * ---------------------------
 * View voor het uitfilteren van de geaggregeerde gcn-bronnen.
 */
CREATE OR REPLACE VIEW non_aggregated_sources_view AS
SELECT
	source_id,
	site_id,
	sector_id,
	origin_id,
	reference,
	description,
	geometry

	FROM sources
		LEFT JOIN source_source_characteristics USING (source_id)

	WHERE diameter IS NULL OR diameter < 1000
;

/*
 * site_generated_properties_view
 * ------------------------------
 * View voor sites.
 * Geeft onder andere het aantal bronnen dat hoort bij de site terug en de bounding box van deze bronnen.
 * Ook de convex hull van de bronnen wordt teruggegeven.
 */
CREATE OR REPLACE VIEW site_generated_properties_view AS
SELECT
	site_id,
	sector_id,
	name,
	number_of_sources,
	Box2D(site_generated_properties.geometry) AS boundingbox,
	priority_project_sites.site_id IS NOT NULL AS is_priority_project,
	site_generated_properties.geometry

	FROM sites
		INNER JOIN site_generated_properties USING (site_id)
		LEFT JOIN priority_project_sites USING (site_id)
;


/*
 * site_distance_for_receptor_view
 * -------------------------------
 * Geeft de afstand van receptors tot de verschillende sites, gesorteerd op distance.
 * Gebruik 'receptor_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW site_distance_for_receptor_view AS
SELECT
	receptor_id,
	site_id,
	site_generated_properties.geometry AS site_geometry,
	receptors.geometry AS receptor_geometry,
	ST_Distance(site_generated_properties.geometry, receptors.geometry) AS distance

	FROM receptors
		CROSS JOIN site_generated_properties

	ORDER BY distance, site_id
;


/*
 * site_sources_view
 * -----------------
 * Geeft alle bronnen van een site weer, inclusief emissies.
 * 
 * 
 */
CREATE OR REPLACE VIEW site_sources_view AS
SELECT
	site_id,
	source_id,
	sector_id,
	sources.reference,
	sources.description,
	COALESCE(source_char.heat_content, sector_char.heat_content) AS heat_content,
	COALESCE(source_char.height, sector_char.height) AS height,
	COALESCE(source_char.spread, sector_char.spread) AS spread,
	COALESCE(source_char.emission_diurnal_variation_id, sector_char.emission_diurnal_variation_id),
	geometry

	FROM sites
		INNER JOIN sources USING (site_id)
		LEFT JOIN source_source_characteristics AS source_char USING (source_id)
		LEFT JOIN default_source_characteristics_view AS sector_char USING (sector_id)
;


/*
 * site_generic_sources_view
 * -------------------------
 * Geeft de generieke bronnen van een site weer, inclusief emissies.
 */
CREATE OR REPLACE VIEW site_generic_sources_view AS
SELECT
	site_id,
	source_id,
	substance_id,
	emission

	FROM sites
		INNER JOIN sources USING (site_id)
		INNER JOIN source_emissions USING (source_id)
;

/*
 * site_farm_sources_view
 * ----------------------
 * Geeft de landbouw bronnen (stallen) van een site weer, inclusief dieraantallen.
 */
CREATE OR REPLACE VIEW site_farm_sources_view AS
SELECT
	site_id,
	source_id,
	farm_lodging_type_id,
	num_animals

	FROM sites
		INNER JOIN sources USING (site_id)
		INNER JOIN farm_source_lodging_types USING (source_id)
;
