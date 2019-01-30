/*
 * ae_build_sector_economic_growths
 * --------------------------------
 * Functie voor het bepalen van de generieke economische groei per AERIUS-sector.
 * De functie wordt aangeroepen per sectorgroep.
 * Dit is een lange functie, echter opdelen ervan zal de logica alleen maar verwarrender maken. Deze keuze is dus bewust.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_sector_economic_growths(v_sectorgroup setup.sectorgroup)
	RETURNS void AS
$BODY$
BEGIN
	CREATE TEMPORARY TABLE tmp_sector_economic_growths (
		year year_type NOT NULL,
		sector_id integer NOT NULL,
		receptor_id integer NOT NULL,

		space_source_deposition_scaled real NOT NULL,
		space_priority_projects_demand real NOT NULL,
		space_deposition_future_base real NOT NULL,
		space_deposition_growth_no_growth real NOT NULL,
		space_growth_correction real NOT NULL,

		source_deposition_scaled real NOT NULL,
		priority_projects_demand real NOT NULL,
		deposition_future_base real NOT NULL,
		deposition_growth_no_growth real NOT NULL,
		growth_correction real NOT NULL,

		CONSTRAINT tmp_sector_economic_growths_pkey PRIMARY KEY (year, sector_id, receptor_id)
	) ON COMMIT DROP;

	RAISE NOTICE 'Start calculating the economic growth of sectorgroup: % @ %', v_sectorgroup, timeofday();

	EXECUTE $$
		INSERT INTO tmp_sector_economic_growths (year, receptor_id, sector_id, space_source_deposition_scaled, space_priority_projects_demand, space_deposition_future_base, space_deposition_growth_no_growth, space_growth_correction, source_deposition_scaled, priority_projects_demand, deposition_future_base, deposition_growth_no_growth, growth_correction)
		SELECT
			year,
			receptor_id,
			sector_id,

			COALESCE(source_depositions_scaled.deposition_space_growth, 0) AS space_source_deposition_scaled,
			COALESCE(priority_projects_demands.deposition_space_growth, 0) AS space_priority_projects_demand,
			COALESCE(depositions_future_base.deposition_space_growth, 0) AS space_deposition_future_base,
			COALESCE(depositions_growth_no_growth.deposition_space_growth, 0) AS space_deposition_growth_no_growth,
			COALESCE(growth_corrections.deposition_space_growth, 0) AS space_growth_correction,

			COALESCE(source_depositions_scaled.growth, 0) AS source_deposition_scaled,
			COALESCE(priority_projects_demands.growth, 0) AS priority_projects_demand,
			COALESCE(depositions_future_base.growth, 0) AS deposition_future_base,
			COALESCE(depositions_growth_no_growth.growth, 0) AS deposition_growth_no_growth,
			COALESCE(growth_corrections.growth, 0) AS growth_correction

			FROM
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 1) RIVM groeideel (relevant voor niet verfijnde (delen van) sectoren).
				--    = deposition 2011 * growth factor * growth factor correction
				--    Samen met onderdeel 2 is dit de totale growth voor de niet verfijnde (delen van) sectoren (het waterbed).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				(SELECT
					year,
					receptor_id,
					sector_id,
					SUM(GREATEST(source_year.deposition * growth_factor * correction, 0)) AS deposition_space_growth,
					SUM(source_year.deposition * growth_factor * correction) AS growth

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

					GROUP BY year, receptor_id, sector_id
				) AS source_depositions_scaled

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 2) Prioritaire projecten groeideel relevant voor de niet verfijnde (delen van) sectoren (het waterbed).
				--    = (demand * limiter_factor) + demand_unlimited
				--    De uitgebreide prioritaire projecten lijst is hier de basis voor de demand.
				--    Samen met onderdeel 2 is dit de totale growth voor de niet verfijnde (delen van) sectoren (het waterbed).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						SUM(GREATEST((demand * limiter_factor) + demand_unlimited, 0)) AS deposition_space_growth,
						SUM((demand * limiter_factor) + demand_unlimited) AS growth

						FROM setup.sector_priority_project_demands_growth
							INNER JOIN setup.sector_priority_project_economic_growth_limiter_factors USING (year, sector_id, substance_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE sectorgroup = '$$ || v_sectorgroup || $$'

						GROUP BY year, receptor_id, sector_id
					) AS priority_projects_demands USING (year, receptor_id, sector_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 3) Groeideel: toekomst min huidig (voor sectoren die zowel voor het huidige jaar, als de toekomst verfijnd zijn en dat gebruikt moet worden voor de groeibepaling).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						SUM(GREATEST(future_year.deposition - base_year.deposition, 0)) AS deposition_space_growth,
						SUM(future_year.deposition - base_year.deposition) AS growth

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

						WHERE setup.gcn_sector_depositions_jurisdiction_policies_no_growth.deposition IS NULL -- Uitsluiten van stal depositie

						GROUP BY year, receptor_id, sector_id
					) AS depositions_future_base USING (year, receptor_id, sector_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 4) Groeideel: toekomstige bijdrage min toekomstige bijdrage zonder groei (voor stallen)
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						SUM(GREATEST(depositions.deposition - depositions_no_growth.deposition, 0)) AS deposition_space_growth,
						SUM(depositions.deposition - depositions_no_growth.deposition) AS growth

						FROM gcn_sectors
							INNER JOIN setup.gcn_sector_depositions_jurisdiction_policies_view AS depositions USING (gcn_sector_id)
							INNER JOIN years USING (year)
							INNER JOIN setup.gcn_sector_depositions_jurisdiction_policies_no_growth_view AS depositions_no_growth USING (receptor_id, year, gcn_sector_id, substance_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE
							sectorgroup = '$$ || v_sectorgroup || $$'
							AND year_category = 'future'

						GROUP BY year, receptor_id, sector_id
					) AS depositions_growth_no_growth USING (year, receptor_id, sector_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 5) Groeideel: correctie op de groei (voor sectoren waarbij de groei buiten de database om is berekend).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						receptor_id,
						sector_id,
						SUM(GREATEST(correction, 0)) AS deposition_space_growth,
						SUM(correction) AS growth

						FROM gcn_sectors
							INNER JOIN setup.gcn_sector_economic_growth_corrections USING (gcn_sector_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE sectorgroup = '$$ || v_sectorgroup || $$'

						GROUP BY year, receptor_id, sector_id
					) AS growth_corrections USING (year, receptor_id, sector_id)

				INNER JOIN years USING (year)

			WHERE year_category = 'future'
	$$;

	RAISE NOTICE 'Appending sectorgroup % to data table of economic growth @ %', v_sectorgroup, timeofday();

	INSERT INTO setup.sector_economic_growths (year, receptor_id, sector_id, deposition_space_growth, growth)
	SELECT
		year,
		receptor_id,
		sector_id,
		(space_source_deposition_scaled + space_priority_projects_demand + space_deposition_future_base + space_deposition_growth_no_growth + space_growth_correction) AS deposition_space_growth,
		(source_deposition_scaled + priority_projects_demand + deposition_future_base + deposition_growth_no_growth + growth_correction) AS growth

		FROM tmp_sector_economic_growths
	;

	RAISE NOTICE 'Appending sectorgroup % to analysis table of economic growth @ %', v_sectorgroup, timeofday();

	INSERT INTO setup.sector_economic_growths_analysis (year, sector_id, space_source_deposition_scaled, space_priority_projects_demand, space_deposition_future_base, space_deposition_growth_no_growth, space_growth_correction, source_deposition_scaled, priority_projects_demand, deposition_future_base, deposition_growth_no_growth, growth_correction)
	SELECT
		year,
		sector_id,

		AVG(space_source_deposition_scaled) AS space_source_deposition_scaled,
		AVG(space_priority_projects_demand) AS space_priority_projects_demand,
		AVG(space_deposition_future_base) AS space_deposition_future_base,
		AVG(space_deposition_growth_no_growth) AS space_deposition_growth_no_growth,
		AVG(space_growth_correction) AS space_growth_correction,

		AVG(source_deposition_scaled) AS source_deposition_scaled,
		AVG(priority_projects_demand) AS priority_projects_demand,
		AVG(deposition_future_base) AS deposition_future_base,
		AVG(deposition_growth_no_growth) AS deposition_growth_no_growth,
		AVG(growth_correction) AS growth_correction

		FROM tmp_sector_economic_growths

		GROUP BY year, sector_id
	;

	DROP TABLE tmp_sector_economic_growths;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;