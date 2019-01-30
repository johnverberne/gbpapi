/*
 * build_relevant_habitat_areas_view
 * ---------------------------------
 * View om de relevant_habitat_areas tabel te vullen (o.b.v. habitat_areas).
 */
CREATE OR REPLACE VIEW setup.build_relevant_habitat_areas_view AS
SELECT
	assessment_area_id,
	habitat_area_id,
	habitat_type_id,
	coverage,
	ST_CollectionExtract(ST_Multi(ST_Union(ST_Intersection(natura2000_directive_area_geometry, habitats_geometry))), 3) AS geometry

	FROM
		-- Stikstofgevoelige aangewezen habitat (of H9999) binnen een HR-gebied
		(SELECT
			assessment_area_id,
			habitat_area_id,
			habitat_type_id,
			natura2000_directive_area_id,
			coverage,
			natura2000_directive_areas.geometry AS natura2000_directive_area_geometry,
			habitat_areas.geometry AS habitats_geometry

			FROM habitat_areas
				INNER JOIN habitat_types USING (habitat_type_id)
				INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
				INNER JOIN
					(SELECT natura2000_directive_area_id, natura2000_area_id AS assessment_area_id, bird_directive, habitat_directive, geometry
						FROM natura2000_directive_areas
					) AS natura2000_directive_areas USING (assessment_area_id)
				LEFT JOIN designated_habitats_view USING (habitat_type_id, assessment_area_id)

			WHERE
				sensitive IS TRUE
				AND habitat_directive IS TRUE
				AND (designated_habitats_view.habitat_type_id IS NOT NULL OR habitat_types.name ILIKE 'H9999%')
		UNION

		-- Aangewezen (vogel)soorten binnen een stikstofgevoelig habitat-gebied binnen een HR- of VR-gebied
		SELECT
			assessment_area_id,
			habitat_area_id,
			habitat_type_id,
			natura2000_directive_area_id,
			coverage,
			natura2000_directive_areas.geometry AS natura2000_directive_area_geometry,
			habitat_areas.geometry AS habitats_geometry

			FROM habitat_areas
				INNER JOIN habitat_type_critical_depositions_view USING (habitat_type_id)
				INNER JOIN
					(SELECT natura2000_directive_area_id, natura2000_area_id AS assessment_area_id, bird_directive, habitat_directive, geometry
						FROM natura2000_directive_areas
					) AS natura2000_directive_areas USING (assessment_area_id)
				INNER JOIN designated_species_to_habitats_view USING (assessment_area_id, habitat_type_id)
				INNER JOIN species USING (species_id)

			WHERE
				sensitive IS TRUE
				AND ((species_type IN ('breeding_bird_species', 'non_breeding_bird_species') AND bird_directive IS TRUE)
					OR (species_type = 'habitat_species' AND habitat_directive IS TRUE))

		) AS relevant_habitats

	GROUP BY assessment_area_id, habitat_area_id, habitat_type_id, coverage
;


/*
 * build_habitats_view
 * -------------------
 * View om de habitats tabel te vullen (o.b.v. habitat_areas).
 *
 * In de bepaling van de coverage is de oppervlakte van de losse habitat-gebieden als zwaarte meegenomen.
 */
CREATE OR REPLACE VIEW setup.build_habitats_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	ae_weighted_avg(coverage::numeric, ST_Area(habitat_areas.geometry)::numeric)::fraction AS coverage,
	ST_CollectionExtract(ST_Multi(ST_Union(habitat_areas.geometry)), 3) AS geometry

	FROM habitat_areas

	GROUP BY assessment_area_id, habitat_type_id
;


/*
 * build_relevant_habitats_view
 * ----------------------------
 * View om de relevant_habitats tabel te vullen (o.b.v. relevant_habitat_areas).
 * Uiteindelijk wordt dus hetzelfde algoritme gevolgd als in build_relevant_habitat_areas_view.
 *
 * In de bepaling van de coverage is de oppervlakte van de losse habitat-gebieden als zwaarte meegenomen.
 */
CREATE OR REPLACE VIEW setup.build_relevant_habitats_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	ae_weighted_avg(habitat_areas.coverage::numeric, ST_Area(habitat_areas.geometry)::numeric)::fraction AS coverage,
	ST_CollectionExtract(ST_Multi(ST_Union(relevant_habitat_areas.geometry)), 3) AS geometry

	FROM relevant_habitat_areas
		INNER JOIN habitat_areas USING (assessment_area_id, habitat_area_id, habitat_type_id)

	GROUP BY assessment_area_id, habitat_type_id
;
