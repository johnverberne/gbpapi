/*
 * development_spaces_view
 * -----------------------
 * AERIUS te benutten, toegekende, in behandeling zijnde, benutte en beschikbare ontwikkelingsruimte
 *
 * De te benutten, toegekende, in behandeling zijnde, benutte en beschikbare (na benutting) ontwikkelingsruimte.
 *
 * Retourneert enkel data voor zoom_level 1.
 */
CREATE OR REPLACE VIEW opendata.development_spaces_view AS
SELECT
	segment,
	receptor_id,
	zoom_level,
	(non_exceeding_receptors.receptor_id IS NULL) AS exceeding,
	initial_available_development_spaces.space AS initial_available_space,
	development_spaces_view.assigned_segment_space,
	(development_spaces_view.utilized_segment_space - development_spaces_view.assigned_segment_space) AS pending_segment_space,
	(initial_available_development_spaces.space - available_development_spaces_view.available_after_utilized) AS utilized_space,
	available_development_spaces_view.available_after_utilized AS available_space,
	geometry

	FROM initial_available_development_spaces
		INNER JOIN available_development_spaces_view USING (segment, receptor_id)
		INNER JOIN development_spaces_view USING (segment, receptor_id)
		INNER JOIN hexagons USING (receptor_id)
		LEFT JOIN non_exceeding_receptors USING (receptor_id)

	WHERE zoom_level = 1

	ORDER BY segment, receptor_id, zoom_level
;


/*
 * depositions_view
 * ----------------
 * AERIUS verfijnde depositiekaart
 *
 * De verfijnde depositiekaart (basisjaar en twee toekomstjaren) voor alle hexagonen die vallen binnen een natura2000-gebied.
 *
 * Retourneert enkel data voor zoom_level 1.
 */
CREATE OR REPLACE VIEW opendata.depositions_view AS
SELECT
	year,
	receptor_id,
	zoom_level,
	total_deposition,
	geometry

	FROM depositions_jurisdiction_policies
		INNER JOIN hexagons USING (receptor_id)
		INNER JOIN years USING (year)

	WHERE
		zoom_level = 1
		AND year_category IN ('base', 'future')

	ORDER BY year, receptor_id, zoom_level
;


/*
 * hexagons_view
 * -------------
 * AERIUS hexagonengrid
 *
 * Het AERIUS hexagonengrid met daarin alle hexagonen die vallen binnen een natura2000-gebied en hun kenmerken.
 * Het gaat hierbij om: stikstof relevantie, OR relevantie en de (laagste) kritische depositie waarde (kdw).
 *
 * Retourneert enkel data voor zoom_level 1.
 */
CREATE OR REPLACE VIEW opendata.hexagons_view AS
SELECT
	receptor_id,
	zoom_level,
	(critical_depositions.receptor_id IS NOT NULL) AS relevant,
	(reserved_development_spaces.receptor_id IS NOT NULL) AS development_space_relevant,
	critical_deposition,
	hexagons.geometry

	FROM receptors
		LEFT JOIN critical_depositions USING (receptor_id)
		LEFT JOIN
			(SELECT
				DISTINCT receptor_id
				FROM reserved_development_spaces
			) AS reserved_development_spaces USING (receptor_id)
		INNER JOIN hexagons USING (receptor_id)

	WHERE zoom_level = 1

	ORDER BY receptor_id, zoom_level
;


/*
 * hexagons_to_relevant_habitats_view
 * ----------------------------------
 * AERIUS koppeltabel hexagonengrid en relevante-habitats
 *
 * Koppeltabel tussen het AERIUS hexagonengrid en de relevante-habitats.
 * Naast de koppeling is ook het natuurgebied, de kritische depositie waarde en de dekkingsgraad van het relevante-habitat ook opgenomen.
 * Tevens is de oppervlakte van de overlap tussen het hexagon en het relevante-habitat in surface terug te vinden.
 *
 * Retourneert enkel data voor zoom_level 1.
 */
CREATE OR REPLACE VIEW opendata.hexagons_to_relevant_habitats_view AS
SELECT
	receptor_id,
	zoom_level,
	assessment_area_id AS natura2000_area_id,
	assessment_areas.name AS natura2000_area_name,
	habitat_type_id,
	habitat_types.name AS habitat_type_name,
	habitat_types.description AS habitat_type_description,
	critical_deposition,
	surface,
	coverage,
	hexagons.geometry

	FROM receptors_to_relevant_habitats_view
		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
		INNER JOIN hexagons USING (receptor_id)

	WHERE zoom_level = 1

	ORDER BY receptor_id, zoom_level, natura2000_area_id, habitat_type_id
;


/*
 * relevant_habitats_view
 * ----------------------
 * AERIUS relevante-habitats
 *
 * De relevante-habitats. Dit zijn de relevante delen van de samengevoegde habitatgebieden binnen een natura2000-gebied.
 * Per relevant-habitat is de kritische depositie waarde (KDW) en de dekkingsgraad ook opgegeven.
 */
CREATE OR REPLACE VIEW opendata.relevant_habitats_view AS
SELECT
	assessment_area_id AS natura2000_area_id,
	assessment_areas.name AS natura2000_area_name,
	habitat_type_id,
	habitat_types.name AS habitat_type_name,
	habitat_types.description AS habitat_type_description,
	critical_deposition,
	coverage,
	relevant_habitats.geometry

	FROM relevant_habitats
		INNER JOIN assessment_areas USING (assessment_area_id)
		INNER JOIN habitat_types USING (habitat_type_id)
		INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)

	ORDER BY natura2000_area_id, habitat_type_id
;