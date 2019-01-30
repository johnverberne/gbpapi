/*
 * build_deposition_spaces_view
 * ----------------------------
 * View om de setup.deposition_spaces tabel te vullen.
 * Bepaald de depositie ruimte voor alle receptoren (dus niet alleen de included receptor set).
 */
CREATE OR REPLACE VIEW setup.build_deposition_spaces_view AS
SELECT
	receptor_id,
	year,
	deposition_space AS total_space,
	space_addition AS total_space_addition

	FROM
		(SELECT
			receptor_id,
			year,
			SUM(deposition_space_growth
				+ COALESCE(reduction * 0.5, 0)
				+ COALESCE(correction, 0)
			) AS deposition_space

			FROM setup.sector_economic_growths
				LEFT JOIN setup.sector_reductions_global_policies_view USING (receptor_id, year, sector_id)
				LEFT JOIN setup.sector_deposition_space_corrections_jurisdiction_policies USING (receptor_id, year, sector_id)

			GROUP BY receptor_id, year
		) AS depositions_spaces


		INNER JOIN
			(SELECT
				receptor_id,
				year,
				GREATEST((critical_deposition - 70) - deposition, 0) AS space_addition

				FROM setup.build_depositions_jurisdiction_policies_view AS jurisdiction_policies_future
					LEFT JOIN critical_depositions USING (receptor_id)
					INNER JOIN years USING (year)

			) AS space_additions USING (receptor_id, year)
;


/*
 * build_deposition_spaces_divided_view
 * ------------------------------------
 * View om de deposition_spaces_divided tabel te vullen.
 * Bepaald de depositie ruimte voor enkel de included receptor set
 * en de receptoren die via de override-tabel OR-relevantie gemaakt zijn.
 */
CREATE OR REPLACE VIEW setup.build_deposition_spaces_divided_view AS
SELECT
	year,
	receptor_id,

	 -- Stap 1 (NTVP)
	LEAST(
		no_permit_required_desire, -- NTVP behoefte,
		space)::real AS no_permit_required, -- Mist genoeg total deposition space

 	-- Stap 2 (GWR)
	LEAST(
		permit_threshold_desire, -- GWR behoefte
		GREATEST(space - no_permit_required_desire, 0))::real AS permit_threshold, -- Mist genoeg resterende deposition space

 	-- Stap 3 (Segment 1)
	LEAST(
		priority_projects_desire, -- Segment 1 behoefte
		GREATEST(space - no_permit_required_desire - permit_threshold_desire, 0))::real AS priority_projects, -- Mist genoeg resterende deposition space

 	-- Stap 4 (Segment 2)
	GREATEST(space - no_permit_required_desire - permit_threshold_desire - priority_projects_desire, 0)::real AS projects -- Is de resterende deposition space (indien er nog wat over is)

	FROM included_receptors

		INNER JOIN
			(SELECT
				year,
				receptor_id,
				total_space + total_space_addition AS space

				FROM setup.deposition_spaces
			) AS spaces USING (receptor_id)

		INNER JOIN
			(SELECT
				year,
				receptor_id,

				-- NTVP (deel desire + no_permit_required_demand)
				SUM(other_desire * no_permit_required_size) +
					COALESCE(SUM(no_permit_required_demand), 0) AS no_permit_required_desire,

				-- GWR (deel desire)
				SUM(other_desire * permit_threshold_size) AS permit_threshold_desire,

				-- Segment 1 (desire + priority_projects_demand + permit_threshold_demand)
				-- Als veiligheidsklep gebruiken we niet priority_projects_demand maar de optelling van de andere twee segmenten.
				SUM(priority_projects_desire) -
					COALESCE(SUM(no_permit_required_demand), 0) AS priority_projects_desire,

				-- Segment 2 (only desire)
				SUM(other_desire * projects_size) AS projects_desire

				FROM sector_economic_desires
					INNER JOIN setup.sector_deposition_space_segmentations USING (sector_id)
					LEFT JOIN setup.sector_priority_project_demands_desire_divided USING (year, sector_id, receptor_id)

				GROUP BY year, receptor_id

			) AS desires USING (year, receptor_id)
;


/*
 * build_economic_desires_view
 * ---------------------------
 * View om de economic_desires tabel te vullen.
 */
CREATE OR REPLACE VIEW setup.build_economic_desires_view AS
SELECT
	year,
	receptor_id,
	SUM(priority_projects_desire + other_desire) AS total_desire

	FROM sector_economic_desires

	GROUP BY year, receptor_id
;
