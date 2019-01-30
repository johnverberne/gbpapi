/*
 * assessment_area_deposition_spaces_view
 * --------------------------------------
 * Retourneert de gemiddelde depositie ruimte verdelingen (en de som van de delen) binnen een natuurgebied.
 * Dit gewogen gemiddelde geldt voor receptoren waar een HT ligt met KDW < 2400.
 * Wordt gebruikt in:
 * Gebiedssamenvatting, 6. Verdeling depositieruimte naar segment
 */
CREATE OR REPLACE VIEW assessment_area_deposition_spaces_view AS
SELECT
	assessment_area_id,
	year,
	ae_weighted_avg(no_permit_required::numeric, weight::numeric)::real AS avg_no_permit_required,
	ae_weighted_avg(permit_threshold::numeric, weight::numeric)::real AS avg_permit_threshold,
	ae_weighted_avg(priority_projects::numeric, weight::numeric)::real AS avg_priority_projects,
	ae_weighted_avg(projects::numeric, weight::numeric)::real AS avg_projects,
	ae_weighted_avg(total_space::numeric, weight::numeric)::real AS total_space

	FROM receptors_to_assessment_areas_on_relevant_habitat_view
		INNER JOIN deposition_spaces_divided_view USING (receptor_id)
		INNER JOIN deposition_spaces_view USING (year, receptor_id)

	GROUP BY assessment_area_id, year
;


/*
 * relevant_habitat_deposition_decrease_view
 * -----------------------------------------
 * Retourneert de minimale en maximale daling in depositie tussen het opgegeven jaar en het basisjaar (huidige jaar)
 * voor elk habitat type/natuurgebied combinatie.
 * Hierbij wordt alleen gekeken naar aangewezen habitat gebieden.
 */
CREATE OR REPLACE VIEW relevant_habitat_deposition_decrease_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	year,
	ae_percentile(array_agg(0 - delta_deposition)::numeric[], 10) AS deposition_drop_10_percentile,
	ae_percentile(array_agg(0 - delta_deposition)::numeric[], 90) AS deposition_drop_90_percentile

	FROM receptors_to_relevant_habitats_view
		INNER JOIN delta_depositions_jurisdiction_policies USING (receptor_id)

	GROUP BY assessment_area_id, habitat_type_id, year
;


/*
 * relevant_habitat_deposition_spaces_view
 * ---------------------------------------
 * Retourneert de totale depositieruimte voor het opgegeven jaar voor elk habitat type/natuurgebied combinatie.
 * Hierbij wordt alleen gekeken naar aangewezen habitat gebieden.
 */
CREATE OR REPLACE VIEW relevant_habitat_deposition_spaces_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	year,
	SUM(total_space * weight) AS total_deposition_space

	FROM receptors_to_relevant_habitats_view
		INNER JOIN deposition_spaces_view USING (receptor_id)

	GROUP BY assessment_area_id, year, habitat_type_id
;


/*
 * relevant_habitat_deposition_decrease_space_info_view
 * ----------------------------------------------------
 * Retourneert een overzicht van gegevens voor elk habitat type/natuurgebied combinatie.
 * Hierbij wordt alleen gekeken naar aangewezen habitat gebieden.
 * Wordt gebruikt in:
 * Gebiedssamenvatting, 6. Ontwikkelingsruimte per habitattype.
 */
CREATE OR REPLACE VIEW relevant_habitat_deposition_decrease_space_info_view AS
SELECT
	assessment_area_id,
	year,
	habitat_type_id,
	habitat_types.name AS habitat_type_name,
	habitat_types.description AS habitat_type_description,
	deposition_drop_10_percentile,
	deposition_drop_90_percentile,
	total_deposition,
	total_deposition_space

	FROM relevant_habitat_deposition_decrease_view
		INNER JOIN relevant_habitat_depositions_view USING (assessment_area_id, habitat_type_id, year)
		INNER JOIN relevant_habitat_deposition_spaces_view USING (assessment_area_id, habitat_type_id, year)
		INNER JOIN habitat_types USING (habitat_type_id)
;


/*
 * critical_deposition_area_delta_space_desire_distributions_view
 * --------------------------------------------------------------
 * Geeft per jaar, toetsgebied, en KDW-gebied hoe de oppervlakte gedistribueerd is qua verschil tussen ontwikkelingsruimte en -behoefte classificaties.
 * De teruggegeven arrays bevatten de oppervlaktes voor ieder van de 4 classificaties.
 * 'distribution' is de delta_space_desire_range_distrubition (tekort/overschot in ontwikkelingsruimte) (voor opgegeven 'year').
 *
 * Gebruik 'year', 'assessment_area_id' en 'type' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_delta_space_desire_distributions_view AS
SELECT
	assessment_area_id,
	year,
	critical_deposition_area_id,
	type,
	name,
	description,
	critical_deposition,
	ae_distribute_enum(ae_get_delta_space_desire_range_condensed(total_space, total_desire), surface::numeric) AS distribution,
	enum_range(NULL::delta_space_desire_range_condensed)::text[] AS keys,
	SUM(surface) AS total_surface

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN deposition_spaces_view USING (receptor_id)
		INNER JOIN economic_desires USING (year, receptor_id)
		INNER JOIN critical_deposition_areas_view USING (assessment_area_id, type, critical_deposition_area_id)

	GROUP BY assessment_area_id, year, critical_deposition_area_id, type, name, description, critical_deposition
;


/*
 * assessment_area_has_deposition_spaces_view
 * ------------------------------------------
 * Geeft van alle assessment_areas terug of er in dit gebied in een toekomstjaar de KDW na realisatie van de behoefte dreigt overschreden te worden (KDW - 70 mol).
 */
CREATE OR REPLACE VIEW assessment_area_has_deposition_spaces_view AS
SELECT 
	assessment_area_id,
	bool_or(relevant_development_space_exceeding_receptors_view.receptor_id IS NOT NULL) AS has_deposition_spaces
	
	FROM receptors_to_assessment_areas
		LEFT JOIN relevant_development_space_exceeding_receptors_view USING (receptor_id)
	
	GROUP BY assessment_area_id
;