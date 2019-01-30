/*
 * build_sector_depositions_global_policies_view
 * ---------------------------------------------
 * View om de sector_depositions_global_policies tabel mee te vullen (beleidsscenario rijksbeleid), op basis van de eerder
 * berekende sector deposities zonder beleid.
 * NOTE: we kunnen hier ook setup.gcn_sector_depositions_global_policies_view gebruiken en de global waarde gebruiken indien deze aanwezig is.
 * Aangezien we de reduction echter al moeten bepalen voor de depositieruimte ging onze voorkeur er naar uit om deze hier dan ook te gebruiken.
 */
CREATE OR REPLACE VIEW setup.build_sector_depositions_global_policies_view AS
SELECT
	year,
	sector_id,
	receptor_id,
	deposition - COALESCE(reduction, 0) AS deposition

	FROM sector_depositions_no_policies
		LEFT JOIN
			(SELECT
				receptor_id,
				year,
				sector_id,
				SUM(reduction) AS reduction

				FROM setup.gcn_sector_reductions_global_policies_view
					INNER JOIN gcn_sectors USING (gcn_sector_id)

				GROUP BY receptor_id, year, sector_id

			) AS reductions USING (year, sector_id, receptor_id)
;


/*
 * build_sector_depositions_jurisdiction_policies_view
 * ---------------------------------------------------
 * View om de sector_depositions_jurisdiction_policies tabel mee te vullen (beleidsscenario provinciaalbeleid), op basis van de eerder
 * berekende sector deposities zonder beleid.
 * NOTE: we kunnen hier ook setup.gcn_sector_depositions_jurisdiction_policies_view gebruiken en de jurisdiction waarde gebruiken indien deze aanwezig is.
 * Aangezien we de reduction echter al moeten bepalen voor de depositieruimte ging onze voorkeur er naar uit om deze hier dan ook te gebruiken.
 */
CREATE OR REPLACE VIEW setup.build_sector_depositions_jurisdiction_policies_view AS
SELECT
	year,
	sector_id,
	receptor_id,
	deposition - COALESCE(reduction, 0) AS deposition

	FROM sector_depositions_no_policies
		LEFT JOIN
			(SELECT
				receptor_id,
				year,
				sector_id,
				SUM(reduction) AS reduction

				FROM setup.gcn_sector_reductions_jurisdiction_policies_view
					INNER JOIN gcn_sectors USING (gcn_sector_id)

				GROUP BY receptor_id, year, sector_id

			) AS reductions USING (receptor_id, year, sector_id)
;


/*
 * build_depositions_no_policies_view
 * ----------------------------------
 * View om depositions_no_policies tabel mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_depositions_no_policies_view AS
SELECT
	receptor_id,
	year,
	deposition + COALESCE(other_deposition, 0) AS deposition

	FROM
		(SELECT
			receptor_id,
			year,
			SUM(deposition) AS deposition

			FROM sector_depositions_no_policies

			GROUP BY receptor_id, year

		) AS sector

		LEFT JOIN
			(SELECT
				receptor_id,
				year,
				SUM(deposition) AS other_deposition

				FROM other_depositions_no_policies_view

				GROUP BY receptor_id, year

		) AS other USING (receptor_id, year)
;


/*
 * build_depositions_global_policies_view
 * --------------------------------------
 * View om depositions_global_policies tabel mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_depositions_global_policies_view AS
SELECT
	receptor_id,
	year,
	deposition + COALESCE(other_deposition, 0) AS deposition

	FROM
		(SELECT
			receptor_id,
			year,
			SUM(deposition) AS deposition

			FROM sector_depositions_global_policies

			GROUP BY receptor_id, year

		) AS sector

		LEFT JOIN (
			SELECT
				receptor_id,
				year,
				SUM(deposition) AS other_deposition

				FROM other_depositions_global_policies_view

				GROUP BY receptor_id, year

		) AS other USING (receptor_id, year)
;


/*
 * build_depositions_jurisdiction_policies_view
 * --------------------------------------------
 * View om depositions_jurisdiction_policies tabel mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_depositions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	year,
	deposition + COALESCE(other_deposition, 0) AS deposition

	FROM
		(SELECT
			receptor_id,
			year,
			SUM(deposition) AS deposition

			FROM sector_depositions_jurisdiction_policies

			GROUP BY receptor_id, year

		) AS sector

		LEFT JOIN (
			SELECT
				receptor_id,
				year,
				SUM(deposition) AS other_deposition

				FROM other_depositions_jurisdiction_policies_view

				GROUP BY receptor_id, year

		) AS other USING (receptor_id, year)
;


/*
 * build_delta_depositions_no_policies_view
 * ----------------------------------------
 * View om delta_depositions_no_policies tabel mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_delta_depositions_no_policies_view AS
SELECT
	receptor_id,
	year,
	ROUND((future.deposition - base.deposition)::numeric, 2) AS delta_deposition

	FROM
		(SELECT receptor_id, deposition FROM depositions_no_policies INNER JOIN years USING (year) WHERE year_category = 'base') AS base
		INNER JOIN depositions_no_policies AS future USING (receptor_id)
		INNER JOIN years USING (year)

	WHERE year_category IN ('last', 'future')
;


/*
 * build_delta_depositions_global_policies_view
 * --------------------------------------------
 * View om delta_depositions_global_policies tabel mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_delta_depositions_global_policies_view AS
SELECT
	receptor_id,
	year,
	ROUND((future.deposition - base.deposition)::numeric, 2) AS delta_deposition

	FROM
		(SELECT receptor_id, deposition FROM depositions_no_policies INNER JOIN years USING (year) WHERE year_category = 'base') AS base
		INNER JOIN depositions_global_policies AS future USING (receptor_id)
		INNER JOIN years USING (year)

	WHERE year_category IN ('last', 'future')
;


/*
 * build_delta_depositions_jurisdiction_policies_view
 * --------------------------------------------------
 * View om delta_depositions_jurisdiction_policies tabel mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_delta_depositions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	year,
	ROUND((future.deposition - base.deposition)::numeric, 2) AS delta_deposition

	FROM
		(SELECT receptor_id, deposition FROM depositions_no_policies INNER JOIN years USING (year) WHERE year_category = 'base') AS base
		INNER JOIN depositions_jurisdiction_policies AS future USING (receptor_id)
		INNER JOIN years USING (year)

	WHERE year_category IN ('last', 'future')
;


/*
 * build_exceeding_receptors_view
 * ------------------------------
 * View om exceeding_receptors tabel mee te vullen.
 *
 * Retourneert (per jaar) de receptoren waarbij de KDW na realisatie van de behoefte dreigt overschreden te worden (KDW - 70 mol).
 */
CREATE OR REPLACE VIEW setup.build_exceeding_receptors_view AS
SELECT	
	receptor_id,
	year

	FROM included_receptors
		CROSS JOIN years

		LEFT JOIN -- Waar dreigt de KDW (in een jaar) overschreden te worden.
			(SELECT
				receptor_id,
				bool_or(critical_deposition - deposition < 70) AS exceeding
				
			 	FROM depositions_jurisdiction_policies
					INNER JOIN critical_depositions USING (receptor_id)
					
				GROUP BY receptor_id
				
			) AS exceedings USING (receptor_id)

		LEFT JOIN -- Waar kon het tekort (per jaar) niet aangevuld worden met de ruimte tussen totale depositie en 70 mol onder de KDW.
			(SELECT
				receptor_id,
				year,
				((total_space + total_space_addition) < total_desire) AS shortage
					
				FROM setup.deposition_spaces
						INNER JOIN economic_desires USING (year, receptor_id)
					
			) AS shortages USING (receptor_id, year)
		
	WHERE
		year_category = 'future'
		AND (exceeding OR shortage)
;


/*
 * build_override_relevant_development_space_receptors_view
 * --------------------------------------------------------
 * View om de override_relevant_development_space_receptors tabel mee aan te vullen.
 *
 * Retourneert de OR-relevante receptoren welke enkel in een niet pas gebied vallen.
 * Deze receptoren zijn namelijk niet OR-relevant.
 */
CREATE OR REPLACE VIEW setup.build_override_relevant_development_space_receptors_view AS
SELECT
	
	receptor_id,
	year,
	non_pas_relevant_receptors.relevant,
	'Receptor is not located within a PAS assessment area'::text AS reason

	FROM included_receptors
		CROSS JOIN years
		INNER JOIN
			(SELECT
				receptor_id,
				bool_or(pas_assessment_areas.assessment_area_id IS NOT NULL) AS relevant

				FROM receptors_to_assessment_areas_on_relevant_habitat_view
					LEFT JOIN pas_assessment_areas USING (assessment_area_id)

				GROUP BY receptor_id
				
			) AS non_pas_relevant_receptors USING (receptor_id)
		LEFT JOIN override_relevant_development_space_receptors USING (receptor_id, year)

	WHERE
		year_category = 'future'
		AND override_relevant_development_space_receptors.receptor_id IS NULL
		AND non_pas_relevant_receptors.relevant IS FALSE
;