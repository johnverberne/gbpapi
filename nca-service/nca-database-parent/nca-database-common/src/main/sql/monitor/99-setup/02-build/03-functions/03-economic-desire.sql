/*
 * ae_build_sector_economic_desires
 * --------------------------------
 * Functie voor het bepalen van de ontwikkelingsbehoefte per AERIUS-sector.
 * De functie wordt aangeroepen per sectorgroep.
 * Dit is een lange functie, echter opdelen ervan zal de logica alleen maar verwarrender maken. Deze keuze is dus bewust.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_sector_economic_desires(v_sectorgroup setup.sectorgroup)
	RETURNS void AS
$BODY$
BEGIN
	CREATE TEMPORARY TABLE tmp_sector_economic_desires (
		year year_type NOT NULL,
		sector_id integer NOT NULL,
		receptor_id integer NOT NULL,
		substance_id smallint NOT NULL,

		source_scaled_priority_projects_desire real NOT NULL,
		priority_projects_demand_desire real NOT NULL,
		growth_deposition_future_base real NOT NULL,
		growth_correction_priority_projects_desire real NOT NULL,
		priority_projects_desire_correction real NOT NULL,

		source_scaled_other_desire real NOT NULL,
		desire_deposition_growth_no_growth real NOT NULL,
		growth_correction_other_desire real NOT NULL,
		other_desire_correction real NOT NULL,

		CONSTRAINT sector_economic_desires_pkey PRIMARY KEY (year, sector_id, receptor_id, substance_id)
	) ON COMMIT DROP;

	RAISE NOTICE 'Start calculating the economic desire of sectorgroup: % @ %', v_sectorgroup, timeofday();

	EXECUTE $$
		INSERT INTO tmp_sector_economic_desires (year, receptor_id, sector_id, substance_id, source_scaled_priority_projects_desire, priority_projects_demand_desire, growth_deposition_future_base, growth_correction_priority_projects_desire, priority_projects_desire_correction, source_scaled_other_desire, desire_deposition_growth_no_growth, growth_correction_other_desire, other_desire_correction)
		SELECT
			year,
			receptor_id,
			sector_id,
			substance_id,

			COALESCE(source_depositions_scaled.priority_projects_desire, 0) AS source_scaled_priority_projects_desire,
			COALESCE(priority_projects_demands.desire, 0) AS priority_projects_demand_desire,
			COALESCE(depositions_future_base.growth, 0) AS growth_deposition_future_base,
			COALESCE(growth_corrections.priority_projects_desire, 0) AS growth_correction_priority_projects_desire,
			COALESCE(desire_corrections.priority_projects_desire, 0) AS priority_projects_desire_correction,

			COALESCE(source_depositions_scaled.other_desire, 0) AS source_scaled_other_desire,
			COALESCE(depositions_growth_no_growth.desire, 0) AS desire_deposition_growth_no_growth,
			COALESCE(growth_corrections.other_desire, 0) AS growth_correction_other_desire,
			COALESCE(desire_corrections.other_desire, 0) AS other_desire_correction

			FROM
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 1) RIVM behoefte (relevant voor niet verfijnde (delen van) sectoren).
				--    Opgesplitst in other_desire en priority_projects_desire.
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				(SELECT
					year,
					receptor_id,
					sector_id,
					substance_id,
					SUM(GREATEST(source_year.deposition * growth_factor * correction * priority_projects_size, 0)) AS priority_projects_desire,
					SUM(GREATEST(source_year.deposition * growth_factor * correction * (no_permit_required_size + projects_size + permit_threshold_size), 0)) AS other_desire

					FROM gcn_sectors
						INNER JOIN
							(SELECT
								year AS source_year,
								receptor_id,
								gcn_sector_id,
								substance_id,
								deposition

								FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
									INNER JOIN years USING (year)

								WHERE year_category = 'source'
							) AS source_year USING (gcn_sector_id)

						INNER JOIN setup.gcn_sector_economic_growth_factors USING (gcn_sector_id, substance_id)
						INNER JOIN setup.gcn_sector_economic_growth_factor_corrections USING (year, gcn_sector_id, substance_id)
						INNER JOIN setup.sector_deposition_space_segmentations USING (sector_id)

					GROUP BY year, receptor_id, sector_id, substance_id
				) AS source_depositions_scaled

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 2) Behoeftedeel: behoefte prioritaire projecten (niet afgetopt).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						substance_id,
						GREATEST(demand, 0) AS desire

						FROM setup.sector_priority_project_demands_desire
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE sectorgroup = '$$ || v_sectorgroup || $$'

					) AS priority_projects_demands USING (year, receptor_id, sector_id, substance_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 3) Behoeftedeel: toekomst min huidig (voor sectoren die zowel voor het huidige jaar, als de toekomst verfijnd zijn en dat gebruikt moet worden voor de groeibepaling).
				--    Zelfde als groeideel 3 (deposition space).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						substance_id,
						SUM(GREATEST(future_year.deposition - base_year.deposition, 0)) AS growth

						FROM gcn_sectors
							INNER JOIN
								(SELECT
									year AS base_year,
									receptor_id,
									gcn_sector_id,
									substance_id,
									deposition

									FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
										INNER JOIN years USING (year)
									WHERE year_category = 'base'
								) AS base_year USING (gcn_sector_id)

							INNER JOIN
								(SELECT
									year,
									receptor_id,
									gcn_sector_id,
									substance_id,
									deposition

									FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
										INNER JOIN years USING (year)
									WHERE year_category = 'future'
								) AS future_year USING (receptor_id, gcn_sector_id, substance_id)

							LEFT JOIN setup.gcn_sector_depositions_jurisdiction_policies_no_growth USING (year, receptor_id, gcn_sector_id, substance_id)

						WHERE setup.gcn_sector_depositions_jurisdiction_policies_no_growth.deposition IS NULL

						GROUP BY year, receptor_id, sector_id, substance_id
					) AS depositions_future_base USING (year, receptor_id, sector_id, substance_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 4) Behoeftedeel: toekomstige bijdrage min toekomstige bijdrage zonder groei, rekening houden met priority projects (voor stallen)
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						substance_id,
						GREATEST(
							future_depositions.growth - COALESCE(priority_projects.demand, 0), -- groeideel 4 - behoeftedeel 2
							0.3 * future_depositions.growth -- of minimaal 30% van groeideel 4
						) AS desire

						FROM
							-- Groeideel 4
							(SELECT
								year,
								receptor_id,
								sector_id,
								substance_id,
								SUM(GREATEST(depositions.deposition - depositions_no_growth.deposition, 0)) AS growth

								FROM gcn_sectors
									INNER JOIN setup.gcn_sector_depositions_jurisdiction_policies_view AS depositions USING (gcn_sector_id)
									INNER JOIN years USING (year)
									INNER JOIN setup.gcn_sector_depositions_jurisdiction_policies_no_growth_view AS depositions_no_growth USING (receptor_id, year, gcn_sector_id, substance_id)
									INNER JOIN setup.sectors_sectorgroup USING (sector_id)

								WHERE year_category = 'future'

								GROUP BY year, receptor_id, sector_id, substance_id
							) AS future_depositions

							-- Behoeftedeel 2
							LEFT JOIN
								(SELECT
									year,
									receptor_id,
									sector_id,
									substance_id,
									SUM(demand) AS demand

									FROM setup.sector_priority_project_demands_desire

									GROUP BY year, receptor_id, sector_id, substance_id
								) AS priority_projects USING (year, receptor_id, sector_id, substance_id)

							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE sectorgroup = '$$ || v_sectorgroup || $$'

					) AS depositions_growth_no_growth USING (year, receptor_id, sector_id, substance_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 5) Behoeftedeel: correctie op de behoefte (voor sectoren waarbij de groei buiten de database om is berekend).
				--    Zelfde als groeideel 5 (deposition space), maar met een opsplitsing in other_desire (stallen) en priority_projects_desire (rest).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						substance_id,
						SUM(CASE WHEN gcn_sector_id = 4110 THEN 0 ELSE correction END) AS priority_projects_desire, -- TODO #1100: add table for pp / other choice
						SUM(CASE WHEN gcn_sector_id = 4110 THEN correction ELSE 0 END) AS other_desire

						FROM gcn_sectors
							INNER JOIN setup.gcn_sector_economic_growth_corrections USING (gcn_sector_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE
							sectorgroup = '$$ || v_sectorgroup || $$'
							AND correction >= 0 -- Negatieve behoeftecorrecties worden niet meegenomen

						GROUP BY year, receptor_id, sector_id, substance_id
					) AS growth_corrections USING (year, receptor_id, sector_id, substance_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 6) Correctie van behoeftedeel 1
				--    Behoeftedeel 1 + 6 = resterende behoefte voor de niet verfijnde sectoren.
				--    Namelijk: resterende behoefte = totale niet verfijnde groei (groeideel 1 + 2) min prioritaire projecten behoefte (behoeftedeel 2)
				--    Stallen en wegverkeer zijn van deze stap uitgesloten.
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						substance_id,

						((COALESCE(priority_projects_growths.growth, 0) -
							COALESCE(priority_projects_desires.desire, 0)) *
								priority_projects_size) AS priority_projects_desire,

						((COALESCE(priority_projects_growths.growth, 0) -
							COALESCE(priority_projects_desires.desire, 0)) *
								(no_permit_required_size + projects_size + permit_threshold_size)) AS other_desire

						FROM
							-- Groeideel 2 (deposition space)
							(SELECT
								year,
								receptor_id,
								sector_id,
								substance_id,
								SUM(GREATEST((demand * limiter_factor) + demand_unlimited, 0)) AS growth

								FROM setup.sector_priority_project_demands_growth
									INNER JOIN setup.sector_priority_project_economic_growth_limiter_factors USING (year, sector_id, substance_id)

								GROUP BY year, receptor_id, sector_id, substance_id
							) AS priority_projects_growths

							-- Behoeftedeel 2
							FULL OUTER JOIN
								(SELECT
									year,
									receptor_id,
									sector_id,
									substance_id,
									SUM(GREATEST(demand, 0)) AS desire

									FROM setup.sector_priority_project_demands_desire

									GROUP BY year, receptor_id, sector_id, substance_id
								) AS priority_projects_desires USING (year, receptor_id, sector_id, substance_id)

							INNER JOIN setup.sector_deposition_space_segmentations USING (sector_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE 
							sectorgroup = '$$ || v_sectorgroup || $$'
							AND sector_id NOT IN (4110, 3111, 3112, 3113)

					) AS desire_corrections USING (year, receptor_id, sector_id, substance_id)

				INNER JOIN years USING (year)

			WHERE year_category = 'future'
	$$;

	RAISE NOTICE 'Appending sectorgroup % to data table of economic desire @ %', v_sectorgroup, timeofday();

	EXECUTE $$
		INSERT INTO sector_economic_desires (year, receptor_id, sector_id, priority_projects_desire, other_desire)
		SELECT
			year,
			receptor_id,
			sector_id,

			(priority_projects_demand_desire + -- Behoeftedeel 2
				growth_deposition_future_base + -- Behoeftedeel 3
				growth_correction_priority_projects_desire + -- Behoeftedeel 5 dat prioritair is
				GREATEST(
					GREATEST(
						-- Behoeftedeel 1 dat prioritair is + behoeftedeel 6 dat prioritair is
						(source_scaled_priority_projects_desire + priority_projects_desire_correction),
						-- moet ten minste 20% zijn van RIVM groei (selectie van sectoren)
						(source_depositions_scaled.growth * 0.2 * priority_projects_size)
					),
				0)
			) AS priority_projects_desire,

			(growth_correction_other_desire + -- Behoeftedeel 5 dat niet prioritair is
				desire_deposition_growth_no_growth + -- Behoeftedeel 4
				GREATEST(
					GREATEST(
						-- Behoeftedeel 1 dat niet prioritair is + behoeftedeel 6 dat niet prioritair is
						(source_scaled_other_desire + other_desire_correction),
						-- moet ten minste 20% zijn van RIVM groei (selectie van sectoren)
						(source_depositions_scaled.growth * 0.2 * (no_permit_required_size + projects_size + permit_threshold_size))
					),
				0)
			) AS other_desire

			FROM
				(SELECT
					year,
					sector_id,
					receptor_id,

					SUM(source_scaled_priority_projects_desire) AS source_scaled_priority_projects_desire,
					SUM(priority_projects_demand_desire) AS priority_projects_demand_desire,
					SUM(growth_deposition_future_base) AS growth_deposition_future_base,
					SUM(growth_correction_priority_projects_desire) AS growth_correction_priority_projects_desire,
					SUM(priority_projects_desire_correction) AS priority_projects_desire_correction,

					SUM(source_scaled_other_desire) AS source_scaled_other_desire,
					SUM(desire_deposition_growth_no_growth) AS desire_deposition_growth_no_growth,
					SUM(growth_correction_other_desire) AS growth_correction_other_desire,
					SUM(other_desire_correction) AS other_desire_correction

					FROM tmp_sector_economic_desires

					GROUP BY year, sector_id, receptor_id

				) AS sector_economic_desires

				INNER JOIN setup.sector_deposition_space_segmentations USING (sector_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- RIVM groei
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				LEFT JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						SUM(GREATEST(source_year.deposition * growth_factor, 0)) AS growth

						FROM gcn_sectors
							INNER JOIN
								(SELECT
									year AS source_year,
									receptor_id,
									gcn_sector_id,
									substance_id,
									deposition

									FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
										INNER JOIN years USING (year)

									WHERE year_category = 'source'
								) AS source_year USING (gcn_sector_id)

							INNER JOIN setup.gcn_sector_economic_growth_factors USING (gcn_sector_id, substance_id)

						WHERE sector_id IN (1050, 1100, 1300, 1400, 1500, 1700, 1800, 2100, 4320, 7510, 7520, 7610, 7620, 8200, 8210, 8640) -- TODO: tabel voor 20% regel

						GROUP BY year, receptor_id, sector_id

					) AS source_depositions_scaled USING (year, receptor_id, sector_id)
	$$;

	RAISE NOTICE 'Appending sectorgroup % to analysis table of economic desire @ %', v_sectorgroup, timeofday();

	INSERT INTO setup.sector_economic_desires_analysis (year, sector_id, substance_id, source_scaled_priority_projects_desire, priority_projects_demand_desire, growth_deposition_future_base, growth_correction_priority_projects_desire, priority_projects_desire_correction, source_scaled_other_desire, desire_deposition_growth_no_growth, growth_correction_other_desire, other_desire_correction)
	SELECT
		year,
		sector_id,
		substance_id,

		AVG(source_scaled_priority_projects_desire) AS source_scaled_priority_projects_desire,
		AVG(priority_projects_demand_desire) AS priority_projects_demand_desire,
		AVG(growth_deposition_future_base) AS growth_deposition_future_base,
		AVG(growth_correction_priority_projects_desire) AS growth_correction_priority_projects_desire,
		AVG(priority_projects_desire_correction) AS priority_projects_desire_correction,

		AVG(source_scaled_other_desire) AS source_scaled_other_desire,
		AVG(desire_deposition_growth_no_growth) AS desire_deposition_growth_no_growth,
		AVG(growth_correction_other_desire) AS growth_correction_other_desire,
		AVG(other_desire_correction) AS other_desire_correction

		FROM tmp_sector_economic_desires

		GROUP BY year, sector_id, substance_id
	;

	DROP TABLE tmp_sector_economic_desires;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;