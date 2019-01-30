/*
 * relevant_development_space_exceeding_receptors_view
 * ---------------------------------------------------
 * Deze view retourneert alle OR-relevante receptoren waarbij de KDW dreigt overschreden te worden.
 */
CREATE OR REPLACE VIEW relevant_development_space_exceeding_receptors_view AS
SELECT
	receptor_id,
	year

	FROM exceeding_receptors
		FULL OUTER JOIN override_relevant_development_space_receptors USING (receptor_id, year)
		INNER JOIN included_receptors USING (receptor_id) -- Should always be a included_receptors

	WHERE
		override_relevant_development_space_receptors.relevant IS NULL
		OR override_relevant_development_space_receptors.relevant IS TRUE
;


/*
 * depositions_all_policies_view
 * -----------------------------
 * Bepaalt de totale depositie per jaar op een punt voor alle beleidsmaatregelen apart.
 */
CREATE OR REPLACE VIEW depositions_all_policies_view AS
SELECT
	receptor_id,
	year,
	depositions_no_policies.deposition AS deposition_no_policies,
	depositions_global_policies.deposition AS deposition_global_policies,
	depositions_jurisdiction_policies.deposition AS deposition_jurisdiction_policies

	FROM depositions_no_policies
		INNER JOIN depositions_global_policies USING (receptor_id, year)
		INNER JOIN depositions_jurisdiction_policies USING (receptor_id, year)
;


/*
 * delta_depositions_all_policies_view
 * -----------------------------------
 * Geeft per jaar weer wat het verschil is in depositie tussen dat jaar en het basisjaar
 * voor de drie beleidsscenarios.
 *
 * Gebruik 'year' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW delta_depositions_all_policies_view AS
SELECT
	receptor_id,
	year,
	delta_depositions_no_policies.delta_deposition AS delta_deposition_no_policies,
	delta_depositions_global_policies.delta_deposition AS delta_deposition_global_policies,
	delta_depositions_jurisdiction_policies.delta_deposition AS delta_deposition_jurisdiction_policies

	FROM delta_depositions_no_policies
		INNER JOIN delta_depositions_global_policies USING (receptor_id, year)
		INNER JOIN delta_depositions_jurisdiction_policies USING (receptor_id, year)
;


/*
 * other_depositions_no_policies_view
 * ----------------------------------
 * Bepaalt de overige depositie zonder beleid.
 */
CREATE OR REPLACE VIEW other_depositions_no_policies_view AS
SELECT
	year,
	other_deposition_type,
	receptor_id,
	deposition

	FROM other_depositions

	WHERE NOT other_deposition_type IN ('returned_deposition_space', 'returned_deposition_space_limburg')
;


/*
 * other_depositions_global_policies_view
 * --------------------------------------
 * Bepaalt de overige depositie volgens rijksbeleid.
 */
CREATE OR REPLACE VIEW other_depositions_global_policies_view AS
SELECT
	year,
	other_deposition_type,
	receptor_id,
	deposition

	FROM other_depositions

	WHERE NOT other_deposition_type IN ('returned_deposition_space_limburg')
;


/*
 * other_depositions_jurisdiction_policies_view
 * --------------------------------------------
 * Bepaalt de overige depositie volgens provinciaal beleid.
 */
CREATE OR REPLACE VIEW other_depositions_jurisdiction_policies_view AS
SELECT
	year,
	other_deposition_type,
	receptor_id,
	deposition

	FROM other_depositions
;


/*
 * assessment_area_depositions_all_policies_view
 * ---------------------------------------------
 * Bepaalt het gewogen gemiddelde aan totale depositievracht per jaar voor een assessment area voor alle beleidsmaatregelen apart.
 * Dit gewogen gemiddelde is bepaald over receptoren die in een relevant habitat liggen.
 */
CREATE OR REPLACE VIEW assessment_area_depositions_all_policies_view AS
SELECT
	assessment_area_id,
	year,
	ae_weighted_avg(deposition_no_policies::numeric, weight::numeric)::real AS deposition_no_policies,
	ae_weighted_avg(deposition_global_policies::numeric, weight::numeric)::real AS deposition_global_policies,
	ae_weighted_avg(deposition_jurisdiction_policies::numeric, weight::numeric)::real AS deposition_jurisdiction_policies

	FROM receptors_to_assessment_areas_on_relevant_habitat_view
		INNER JOIN depositions_all_policies_view USING (receptor_id)

	GROUP BY assessment_area_id, year
;


/*
 * assessment_area_sector_depositions_jurisdiction_policies_view
 * -------------------------------------------------------------
 * Bepaalt het gewogen gemiddelde aan depositievracht per sector per jaar op een interessegebied.
 * Hierbij zijn de invloeden van zowel landsbrede als provinciale maatregelen meegenomen.
 * Dit gewogen gemiddelde is bepaald over receptoren die in een relevant habitat liggen.
 */
CREATE OR REPLACE VIEW assessment_area_sector_depositions_jurisdiction_policies_view AS
SELECT
	assessment_area_id,
	sector_id,
	year,
	ae_weighted_avg(deposition::numeric, weight::numeric)::real AS deposition

	FROM receptors_to_assessment_areas_on_relevant_habitat_view
		INNER JOIN sector_depositions_jurisdiction_policies USING (receptor_id)

	GROUP BY year, sector_id, assessment_area_id
;


/*
 * assessment_area_other_depositions_jurisdiction_policies_view
 * ------------------------------------------------------------
 * Bepaalt het gewogen gemiddelde aan depositievracht per overige category per jaar op een interessegebied.
 * Hierbij zijn de invloeden van zowel landsbrede als provinciale maatregelen meegenomen.
 * Dit gewogen gemiddelde geldt voor receptoren waar een HT ligt met KDW < 2400.
 */
CREATE OR REPLACE VIEW assessment_area_other_depositions_jurisdiction_policies_view AS
SELECT
	assessment_area_id,
	other_deposition_type,
	year,
	ae_weighted_avg(deposition::numeric, weight::numeric)::real AS deposition

	FROM receptors_to_assessment_areas_on_relevant_habitat_view
		INNER JOIN other_depositions_jurisdiction_policies_view USING (receptor_id)

	GROUP BY year, other_deposition_type, assessment_area_id
;


/*
 * critical_deposition_area_receptor_nitrogen_loads_view
 * -----------------------------------------------------
 * Geeft per receptor, toetsgebied, KDW-gebied en jaar hoeveel oppervlakte in de stikstofbelasting classificaties valt.
 * 'nitrogen_load' is de stikstofbelasting.
 * Geldt alleen voor aangewezen KDW-gebieden binnen het toetsgebied.
 *
 * Gebruik 'year' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_receptor_nitrogen_loads_view AS
SELECT
	receptor_id,
	included,
	assessment_area_id,
	year,
	type,
	critical_deposition_area_id,
	name,
	description,
	critical_deposition,
	ae_get_nitrogen_load_classification(critical_deposition, depositions_jurisdiction_policies.deposition) AS nitrogen_load,
	weight,
	surface,
	receptors_to_critical_deposition_areas_view.coverage

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN critical_deposition_areas_view USING (assessment_area_id, type, critical_deposition_area_id)
		INNER JOIN depositions_jurisdiction_policies USING (receptor_id)
;


/*
 * assessment_area_receptor_max_nitrogen_loads_view
 * ------------------------------------------------
 * Geeft per receptor, toetsgebied en jaar wat de hoogste stikstofbelasting classificaties is.
 * 'nitrogen_load' is de stikstofbelasting.
 * Kijkt alleen naar aangewezen en relevante KDW-gebieden binnen het toetsgebied.
 *
 * Gebruik 'year' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW assessment_area_receptor_max_nitrogen_loads_view AS
SELECT
		receptor_id,
		assessment_area_id,
		year,
		MAX(nitrogen_load) AS nitrogen_load

		FROM critical_deposition_area_receptor_nitrogen_loads_view

		WHERE type = 'relevant_habitat'

		GROUP BY receptor_id, assessment_area_id, year
;

/*
 * assessment_area_aggregate_max_nitrogen_loads_view
 * -------------------------------------------------
 * Geeft per toetsgebied en jaar aan wat het aantal receptoren met de aangegeven stikstofbelasting classificatie is.
 *
 * Sortorder wordt op een vrij lelijke manier gebruikt zodat met color ranges gewerkt kunnen worden.
 */
CREATE OR REPLACE VIEW assessment_area_aggregate_max_nitrogen_loads_view AS
SELECT
		assessment_area_id,
		year,
		nitrogen_load,
		enumsortorder AS enum_ordinal,
		1 AS zoom_level
		
		FROM assessment_area_receptor_max_nitrogen_loads_view
			INNER JOIN pg_catalog.pg_enum ON enumtypid = 'nitrogen_load_classification'::regtype AND enumlabel = nitrogen_load::text
;

/*
 * critical_deposition_area_nitrogen_load_distributions_view
 * ---------------------------------------------------------
 * Geeft per jaar, toetsgebied, en KDW-gebied hoe de oppervlakte gedistribueerd is qua stikstofbelasting classificaties.
 * De teruggegeven arrays bevatten de oppervlaktes voor ieder van de 4 classificaties.
 * 'nitrogen_load' is de stikstofbelasting (voor opgegeven 'year').
 *
 * Gebruik 'year' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_nitrogen_load_distributions_view AS
SELECT
	assessment_area_id,
	year,
	type,
	critical_deposition_area_id,
	name,
	description,
	critical_deposition,
	ae_distribute_enum(nitrogen_load, surface::numeric) AS distribution,
	enum_range(NULL::nitrogen_load_classification)::text[] AS keys,
	SUM(surface) AS total_surface,
	SUM(surface * coverage) AS total_cartographic_surface

	FROM critical_deposition_area_receptor_nitrogen_loads_view

	GROUP BY year, assessment_area_id, type, critical_deposition_area_id, name, description, critical_deposition
;


/*
 * critical_deposition_area_receptor_depositions_view
 * --------------------------------------------------
 * Geeft per receptor, toetsgebied, KDW-gebied en jaar wat de stikstof depositie zal zijn.
 *
 * Gebruik 'year', 'critical_deposition_area_id', 'type' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_receptor_depositions_view AS
SELECT
	receptor_id,
	included,
	assessment_area_id,
	critical_deposition_area_id,
	type,
	year,
	deposition,
	surface

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN depositions_jurisdiction_policies USING (receptor_id)
;


/*
 * critical_deposition_area_receptor_delta_depositions_view
 * --------------------------------------------------------
 * Geeft per receptor, toetsgebied, KDW-gebied en jaar wat de prognose (verschil tussen geselecteerde jaar en basisjaar)
 * van de stikstof depositie zal zijn.
 *
 * Gebruik 'year', 'critical_deposition_area_id', 'type' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_receptor_delta_depositions_view AS
SELECT
	receptor_id,
	included,
	assessment_area_id,
	critical_deposition_area_id,
	type,
	year,
	delta_deposition,
	surface

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN delta_depositions_jurisdiction_policies USING (receptor_id)
;


/*
 * deviations_from_critical_deposition_view
 * ----------------------------------------
 * Geeft per receptor en jaar wat de afstand tot de kdw zal zijn.
 */
CREATE OR REPLACE VIEW deviations_from_critical_deposition_view AS
SELECT
	receptor_id,
	year,
	deposition - critical_deposition AS deviation_from_critical_deposition

	FROM depositions_jurisdiction_policies
		INNER JOIN critical_depositions USING (receptor_id)
;


/*
 * critical_deposition_area_receptor_deviations_view
 * -------------------------------------------------
 * Geeft per receptor, toetsgebied, KDW-gebied en jaar wat de afstand tot de kdw zal zijn.
 *
 * Gebruik 'year', 'assessment_area_id', 'type' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW critical_deposition_area_receptor_deviations_view AS
SELECT
	receptor_id,
	included,
	assessment_area_id,
	critical_deposition_area_id,
	type,
	year,
	deviation_from_critical_deposition,
	surface

	FROM receptors_to_critical_deposition_areas_view
		INNER JOIN deviations_from_critical_deposition_view USING (receptor_id)
;


/*
 * deposition_jurisdiction_policies_sectors_view
 * ---------------------------------------------
 * Geeft terug voor welke sectoren de deposities berekend zijn
 * (resultaten van bekend in sector_depositions_jurisdiction_policies).
 */
CREATE OR REPLACE VIEW deposition_jurisdiction_policies_sectors_view AS
SELECT
	sector_id

	FROM sectors
		WHERE sector_id NOT IN (
			SELECT DISTINCT sector_id FROM sectors
				LEFT JOIN sector_depositions_jurisdiction_policies USING (sector_id)
				WHERE sector_depositions_jurisdiction_policies.sector_id IS NULL
		)
;


/*
 * relevant_habitat_depositions_view
 * ---------------------------------
 * Geaggregeerde waardes per habitat type/natuurgebied van totale deposities (zowel sector gerelateerd als overige bronnen).
 * Hierbij wordt alleen gekeken naar aangewezen habitat gebieden.
 *
 * Bevat gewogen gemiddelde, 10e en 90e percentiel en som.
 */
CREATE OR REPLACE VIEW relevant_habitat_depositions_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	habitat_types.name AS habitat_type_name,
	habitat_types.description AS habitat_type_description,
	year,
	ae_weighted_avg(deposition::numeric, weight::numeric)::real AS avg_deposition,
	ae_percentile(array_agg(deposition::real)::numeric[], 10) AS percentile_10_deposition,
	ae_percentile(array_agg(deposition::real)::numeric[], 90) AS percentile_90_deposition,
	SUM(deposition * weight) AS total_deposition

	FROM receptors_to_relevant_habitats_view
		INNER JOIN depositions_jurisdiction_policies USING (receptor_id)
		INNER JOIN habitat_types USING (habitat_type_id)

	GROUP BY assessment_area_id, habitat_type_id, name, description, year
;


/*
 * relevant_habitat_delta_depositions_view
 * ---------------------------------------
 * Geaggregeerde delta waardes (waarde van het jaar t.o.v. het basisjaar)
 * per habitat type/natuurgebied van totale deposities (zowel sector gerelateerd als overige bronnen).
 *
 * Bevat gewogen gemiddelde, 10e en 90e percentiel.
 */
CREATE OR REPLACE VIEW relevant_habitat_delta_depositions_view AS
SELECT
	assessment_area_id,
	habitat_type_id,
	habitat_types.name AS habitat_type_name,
	habitat_types.description AS habitat_type_description,
	year,
	ae_weighted_avg((0 - delta_deposition)::numeric, weight::numeric)::real AS avg_delta_deposition,
	ae_percentile(array_agg(0 - delta_deposition)::numeric[], 10) AS percentile_10_delta_deposition,
	ae_percentile(array_agg(0 - delta_deposition)::numeric[], 90) AS percentile_90_delta_deposition

	FROM receptors_to_relevant_habitats_view
		INNER JOIN delta_depositions_jurisdiction_policies USING (receptor_id)
		INNER JOIN habitat_types USING (habitat_type_id)

	GROUP BY assessment_area_id, habitat_type_id, name, description, year
;


/*
 * assessment_area_surface_deposition_increase_view
 * ------------------------------------------------
 * Geeft per natuurgebied het totale oppervlakte terug
 * en de oppervlakte waarbij er een toename van depositie optreedt t.o.v. het basisjaar.
 *
 * Deze oppervlakte is gebaseerd op de oppervlakte van de receptoren behorende bij het natuurgebied,
 * waarbij de receptoren een stikstofgevoelig, aangewezen habitat bevatten,
 * en waarbij alleen de oppervlakte bedekt door het natuurgebied wordt meegenomen.
 *
 * Hierdoor zal de totale oppervlakte van bijv. de waddenzee niet overeenkomen met de st_area(geometry) van dat gebied,
 * omdat de receptoren die volledig op water liggen niet in de database staan.
 * Ook zijn er receptoren zonder stikstofgevoelig, aangewezen habitat type.
 */
CREATE OR REPLACE VIEW assessment_area_surface_deposition_increase_view AS
SELECT
	assessment_area_id,
	year,
	SUM(surface) AS total_surface,
	SUM(CASE WHEN delta_deposition > 0.05 THEN surface ELSE 0 END) AS surface_increasing_deposition --TODO: coverage mag hier niet meegenomen worden

	FROM receptors_to_assessment_areas_on_relevant_habitat_view
		INNER JOIN delta_depositions_jurisdiction_policies USING (receptor_id)

	GROUP BY assessment_area_id, year
;


/*
 * assessment_area_depositions_policy_influence_view
 * -------------------------------------------------
 * Geeft binnen een natuurgebied weer wat de invloed is van de PAS per jaar.
 * Dit wordt bepaald aan de hand van het verschil in depositie tussen beleidsscenarios 'geen' (autonoom) en 'provinciaal' (PAS).
 * De getallen zijn het aantal relevante receptoren.
 *
 * Gebruik 'year' en 'assessment_area_id' in de WHERE-clause.
 */
CREATE OR REPLACE VIEW assessment_area_depositions_policy_influence_view AS
SELECT
	assessment_area_id,
	year,
	SUM((ROUND(np.deposition::numeric, 2) > ROUND(jp.deposition::numeric, 2))::int) AS influence_positive,
	SUM((ROUND(np.deposition::numeric, 2) < ROUND(jp.deposition::numeric, 2))::int) AS influence_negative,
	SUM((ROUND(np.deposition::numeric, 2) = ROUND(jp.deposition::numeric, 2))::int) AS influence_none

	FROM receptors_to_assessment_areas_on_relevant_habitat_view
		INNER JOIN depositions_no_policies AS np USING (receptor_id)
		INNER JOIN depositions_jurisdiction_policies AS jp USING (receptor_id, year)

	GROUP BY assessment_area_id, year
;
