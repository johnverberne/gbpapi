/*
 * ae_build_sector_depositions_no_policies
 * ---------------------------------------
 * Functie voor het vullen van de depositie-tabel voor beleidsscenario zonder-beleid, per jaar en AERIUS-sector.
 * De functie wordt aangeroepen per sectorgroep.
 * Dit is een lange functie, echter opdelen ervan zal de logica alleen maar verwarrender maken. Deze keuze is dus bewust.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_sector_depositions_no_policies(v_sectorgroup setup.sectorgroup)
	RETURNS void AS
$BODY$
BEGIN
	CREATE TEMPORARY TABLE tmp_sector_depositions_no_policies (
		year year_type NOT NULL,
		sector_id integer NOT NULL,
		receptor_id integer NOT NULL,

		deposition_space_growth real NOT NULL,
		source_deposition_scaled real NOT NULL,
		base_deposition real NOT NULL,
		future_with_growth_deposition real NOT NULL,
		farm_lodging_correction real NOT NULL,
		post_correction real NOT NULL,

		CONSTRAINT tmp_sector_depositions_no_policies_pkey PRIMARY KEY (year, sector_id, receptor_id)
	) ON COMMIT DROP;

	-- -- BASE YEAR (NO POLICIES) -- --

	RAISE NOTICE 'Start calculating deposition base year no policies of sectorgroup: % @ %', v_sectorgroup, timeofday();

	EXECUTE $$
		INSERT INTO tmp_sector_depositions_no_policies (year, sector_id, receptor_id, deposition_space_growth, source_deposition_scaled, base_deposition, future_with_growth_deposition, farm_lodging_correction, post_correction)
		SELECT
			year,
			sector_id,
			receptor_id,
			0 AS deposition_space_growth,
			COALESCE(source_depositions_scaled.deposition, 0) AS source_deposition_scaled,
			COALESCE(base_depositions.deposition, 0) AS base_deposition,
			COALESCE(road_freeway_depositions.deposition, 0) AS future_with_growth_deposition,
			0 AS farm_lodging_correction,
			COALESCE(post_corrections.correction, 0) AS post_correction

			FROM
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 1) RIVM depositie (relevant voor niet verfijnde (delen van) sectoren).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				(SELECT
					future_year AS year,
					sector_id,
					receptor_id,
					SUM(deposition * scale_factor) AS deposition

					FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
						INNER JOIN (SELECT year AS future_year, gcn_sector_id, substance_id, scale_factor FROM setup.gcn_sector_economic_scale_factors) AS factors USING (gcn_sector_id, substance_id)
						INNER JOIN years USING (year)
						INNER JOIN gcn_sectors USING (gcn_sector_id)

					WHERE year_category = 'source'

					GROUP BY future_year, sector_id, receptor_id

				) AS source_depositions_scaled

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 2) Depositie verfijnde sectoren die voor 2014 vervangende emissies hebben.
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						sector_id,
						receptor_id,
						SUM(deposition) AS deposition

						FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
							INNER JOIN years USING (year)
							INNER JOIN gcn_sectors USING (gcn_sector_id)

						WHERE year_category IN ('base', 'last')

						GROUP BY year, sector_id, receptor_id

					) AS base_depositions USING (year, sector_id, receptor_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 3) Depositie no_policies_no_growth (VLW bijdragen HWN).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						sector_id,
						receptor_id,
						SUM(deposition) AS deposition

						FROM setup.gcn_sector_depositions_no_policies_no_growth
							INNER JOIN years USING (year)
							INNER JOIN gcn_sectors USING (gcn_sector_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE
							sectorgroup = '$$ || v_sectorgroup || $$'
							AND year_category IN ('base', 'last')

						GROUP BY year, sector_id, receptor_id

					) AS road_freeway_depositions USING (year, sector_id, receptor_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 4) Post corrections
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						sector_id,
						receptor_id,
						SUM(correction) AS correction

						FROM setup.gcn_sector_post_corrections_no_policies_view
							INNER JOIN years USING (year)
							INNER JOIN gcn_sectors USING (gcn_sector_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE
							sectorgroup = '$$ || v_sectorgroup || $$'
							AND year_category IN ('base', 'last')

						GROUP BY year, sector_id, receptor_id

					) AS post_corrections USING (year, sector_id, receptor_id)
	$$;

	-- -- FUTURE YEARS (NO POLICIES) -- --

	RAISE NOTICE 'Start calculating deposition future year no policies of sectorgroup: % @ %', v_sectorgroup, timeofday();

	EXECUTE $$
		INSERT INTO tmp_sector_depositions_no_policies (year, sector_id, receptor_id, deposition_space_growth, source_deposition_scaled, base_deposition, future_with_growth_deposition, farm_lodging_correction, post_correction)
		SELECT
			year,
			sector_id,
			receptor_id,
			COALESCE(deposition_space_growths.growth, 0) AS deposition_space_growth,
			COALESCE(source_depositions_scaled.deposition, 0) AS source_deposition_scaled,
			COALESCE(base_depositions.deposition, 0) AS base_deposition,
			COALESCE(future_depositions_lodging_highway.deposition, 0) AS future_with_growth_deposition,
			COALESCE(farm_lodging_corrections.correction, 0) AS farm_lodging_correction,
			COALESCE(post_corrections.correction, 0) AS post_correction

			FROM
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 1) Groei zoals opgenomen in depositie ruimte (maardan met ook negatieve waarde).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				(SELECT
						year,
						sector_id,
						receptor_id,
						growth

						FROM setup.sector_economic_growths
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE sectorgroup = '$$ || v_sectorgroup || $$'
				) AS deposition_space_growths

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 2) RIVM depositie (relevant voor niet verfijnde (delen van) sectoren).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						future_year AS year,
						sector_id,
						receptor_id,
						SUM(deposition * scale_factor) AS deposition

						FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
							INNER JOIN (SELECT year AS future_year, gcn_sector_id, substance_id, scale_factor FROM setup.gcn_sector_economic_scale_factors_no_economy) AS factors USING (gcn_sector_id, substance_id)
							INNER JOIN gcn_sectors USING (gcn_sector_id)
							INNER JOIN years USING (year)

						WHERE year_category = 'source'

						GROUP BY future_year, sector_id, receptor_id

					) AS source_depositions_scaled USING (year, sector_id, receptor_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 3) Depositie verfijnde sectoren waarbij zonder groei de depositie gelijk blijft aan 2014.
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						future_year AS year,
						sector_id,
						receptor_id,
						SUM(deposition) AS deposition

						FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view
							INNER JOIN years USING (year)
							INNER JOIN gcn_sectors USING (gcn_sector_id)
							CROSS JOIN (SELECT year AS future_year FROM years WHERE year_category = 'future') AS future_years

						WHERE
							year_category = 'base'
							AND gcn_sector_id <> 4110 -- Zonder stallen

						GROUP BY future_year, sector_id, receptor_id

					) AS base_depositions USING (year, sector_id, receptor_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 4) Depositie stallen en HWN.
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- TODO: stap 4 opdelen in stallen en HWN deel
				FULL OUTER JOIN
					(SELECT
						year,
						sector_id,
						receptor_id,
						SUM(COALESCE(no_policies.deposition, no_policies_no_growth.deposition)) AS deposition

						FROM setup.gcn_sector_depositions_no_policies_$$ || v_sectorgroup || $$_view AS no_policies
							FULL OUTER JOIN setup.gcn_sector_depositions_no_policies_no_growth AS no_policies_no_growth USING (receptor_id, year, gcn_sector_id, substance_id)
							INNER JOIN years USING (year)
							INNER JOIN gcn_sectors USING (gcn_sector_id)

						WHERE
							(('$$ || v_sectorgroup || $$' = 'agriculture' AND gcn_sector_id = 4110) -- Alleen stallen en HWN/OWN
								OR ('$$ || v_sectorgroup || $$' = 'road_freeway' AND gcn_sector_id = 3111)
								OR ('$$ || v_sectorgroup || $$' = 'road_transportation' AND gcn_sector_id IN (3112, 3113)))
							AND year_category = 'future'

						GROUP BY year, sector_id, receptor_id

					) AS future_depositions_lodging_highway USING (year, sector_id, receptor_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 5) Correcties op staldepositie (groei landbouw + stoppers zitten er dubbel in).
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						sector_id,
						receptor_id,
						SUM(depositions_no_growth.deposition - depositions.deposition - COALESCE(correction, 0)) AS correction

						FROM gcn_sectors
							INNER JOIN setup.gcn_sector_depositions_jurisdiction_policies_view AS depositions USING (gcn_sector_id)
							INNER JOIN years USING (year)
							INNER JOIN setup.gcn_sector_depositions_jurisdiction_policies_no_growth_view AS depositions_no_growth USING (receptor_id, year, gcn_sector_id, substance_id)
							LEFT JOIN setup.gcn_sector_economic_growth_corrections USING (receptor_id, year, gcn_sector_id, substance_id)

						WHERE
							'$$ || v_sectorgroup || $$' = 'agriculture'
							AND gcn_sector_id = 4110 -- Alleen voor stallen
							AND year_category = 'future'

						GROUP BY year, receptor_id, sector_id

					) AS farm_lodging_corrections USING (year, sector_id, receptor_id)

				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				-- 6) Post corrections
				-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
				FULL OUTER JOIN
					(SELECT
						year,
						sector_id,
						receptor_id,
						SUM(correction) AS correction

						FROM setup.gcn_sector_post_corrections_no_policies_view
							INNER JOIN years USING (year)
							INNER JOIN gcn_sectors USING (gcn_sector_id)
							INNER JOIN setup.sectors_sectorgroup USING (sector_id)

						WHERE
							sectorgroup = '$$ || v_sectorgroup || $$'
							AND year_category = 'future'

						GROUP BY year, sector_id, receptor_id

					) AS post_corrections USING (year, sector_id, receptor_id)
	$$;

	-- -- FIX BASE YEAR COMPLETENESS -- --

	RAISE NOTICE 'Ensuring all sectors in sectorgroup % in future years have data in base year @ %', v_sectorgroup, timeofday();

	EXECUTE $$
		INSERT INTO tmp_sector_depositions_no_policies (year, sector_id, receptor_id, deposition_space_growth, source_deposition_scaled, base_deposition, future_with_growth_deposition, farm_lodging_correction, post_correction)
		SELECT
			year,
			sector_id,
			receptor_id,
			0 AS deposition_space_growth,
			0 AS source_deposition_scaled,
			0 AS base_deposition,
			0 AS future_with_growth_deposition,
			0 AS farm_lodging_correction,
			0 AS post_correction

			FROM
				-- all sectors with receptors EXCEPT those in base year = those that only exist in future year
				(SELECT DISTINCT sector_id, receptor_id FROM tmp_sector_depositions_no_policies
				 EXCEPT
				 SELECT DISTINCT sector_id, receptor_id FROM tmp_sector_depositions_no_policies INNER JOIN years using (year) WHERE year_category = 'base'
				) AS sectors_receptors
				CROSS JOIN years

			WHERE year_category = 'base'
	$$;

	EXECUTE $$
		INSERT INTO tmp_sector_depositions_no_policies (year, sector_id, receptor_id, deposition_space_growth, source_deposition_scaled, base_deposition, future_with_growth_deposition, farm_lodging_correction, post_correction)
		SELECT
			year,
			sector_id,
			receptor_id,
			0 AS deposition_space_growth,
			0 AS source_deposition_scaled,
			0 AS base_deposition,
			0 AS future_with_growth_deposition,
			0 AS farm_lodging_correction,
			0 AS post_correction

			FROM
				-- all sectors with receptors EXCEPT those in base year = those that only exist in future year
				(SELECT DISTINCT sector_id, receptor_id FROM tmp_sector_depositions_no_policies
				 EXCEPT
				 SELECT DISTINCT sector_id, receptor_id FROM tmp_sector_depositions_no_policies INNER JOIN years using (year) WHERE year_category = 'last'
				) AS sectors_receptors
				CROSS JOIN years

			WHERE year_category = 'last'
	$$;

	RAISE NOTICE 'Appending sectorgroup % to data table of deposition no policies @ %', v_sectorgroup, timeofday();

	INSERT INTO sector_depositions_no_policies (year, sector_id, receptor_id, deposition)
	SELECT
		year,
		sector_id,
		receptor_id,
		GREATEST(deposition_space_growth + source_deposition_scaled + base_deposition + future_with_growth_deposition + farm_lodging_correction + post_correction, 0) AS deposition

		FROM tmp_sector_depositions_no_policies
	;

	RAISE NOTICE 'Appending sectorgroup % to analysis table of deposition no policies @ %', v_sectorgroup, timeofday();

	INSERT INTO setup.sector_depositions_no_policies_analysis (year, sector_id, deposition_space_growth, source_deposition_scaled, base_deposition, future_with_growth_deposition, farm_lodging_correction, post_correction)
	SELECT
		year,
		sector_id,

		AVG(deposition_space_growth) AS deposition_space_growth,
		AVG(source_deposition_scaled) AS source_deposition_scaled,
		AVG(base_deposition) AS base_deposition,
		AVG(future_with_growth_deposition) AS future_with_growth_deposition,
		AVG(farm_lodging_correction) AS farm_lodging_correction,
		AVG(post_correction) AS post_correction

		FROM tmp_sector_depositions_no_policies

		GROUP BY year, sector_id
	;

	DROP TABLE tmp_sector_depositions_no_policies;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
