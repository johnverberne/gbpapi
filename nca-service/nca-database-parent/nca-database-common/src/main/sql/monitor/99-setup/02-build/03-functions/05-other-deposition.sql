/*
 * ae_build_other_depositions
 * --------------------------
 * Build functie voor het aanvullen van de other_deposition tabel met de returned deposition space,
 * de returned deposition space limburg.
 * Voor 2014 wordt de waarde 0 ingevuld.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_other_depositions()
	RETURNS void AS
$BODY$
BEGIN

	PERFORM ae_raise_notice('other_depositions - returned_deposition_space @ ' || timeofday());

	EXECUTE $$
		INSERT INTO other_depositions (year, other_deposition_type, receptor_id, deposition)
		SELECT
			year,
			'returned_deposition_space'::other_deposition_type AS other_deposition_type,
			receptor_id,
			reduction * 0.5 AS deposition

			FROM
				(SELECT
					year,
					receptor_id,
					SUM(reduction) AS reduction

					FROM setup.gcn_sector_reductions_global_policies_view
						INNER JOIN years USING (year)
						INNER JOIN gcn_sectors USING (gcn_sector_id)

					WHERE year_category = 'future'

					GROUP BY receptor_id, year

				) AS reductions
		$$;


	PERFORM ae_raise_notice('other_depositions - returned_deposition_space_limburg @ ' || timeofday());

	EXECUTE $$
		INSERT INTO other_depositions (year, other_deposition_type, receptor_id, deposition)
		SELECT
			year,
			'returned_deposition_space_limburg'::other_deposition_type AS other_deposition_type,
			receptor_id,
			SUM(correction) AS deposition

			FROM setup.sector_deposition_space_corrections_jurisdiction_policies

			GROUP BY year, receptor_id
	$$;


	EXECUTE $$
		INSERT INTO other_depositions (year, other_deposition_type, receptor_id, deposition)
		SELECT
			year,
			unnest(ARRAY['returned_deposition_space', 'returned_deposition_space_limburg']::other_deposition_type[]) AS other_deposition_type,
			receptor_id,
			0 AS deposition

			FROM receptors
				LEFT JOIN setup.uncalculated_receptors USING (receptor_id) -- De data moet enkel voor de doogerekende receptoren aangemaakt worden
				CROSS JOIN years

			WHERE
				year_category IN ('base', 'last')
				AND uncalculated_receptors.receptor_id IS NULL
	$$;


	PERFORM ae_raise_notice('other_depositions - remaining_deposition @ ' || timeofday());

	EXECUTE $$
		UPDATE other_depositions
			SET other_deposition_type = 'remaining_deposition'
			WHERE other_deposition_type = 'dune_area_correction'
	$$;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;



/*
 * ae_build_other_depositions_part_2
 * ---------------------------------
 * Build functie voor het aanvullen van de other_deposition tabel met ELKEL de deposition_space_addition (TIJDELIJKE FIX).
 * Voor 2014 wordt de waarde 0 ingevuld.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_other_depositions_part_2()
	RETURNS void AS
$BODY$
BEGIN

	PERFORM ae_raise_notice('other_depositions - deposition_space_addition @ ' || timeofday());

	EXECUTE $$
		INSERT INTO other_depositions (year, other_deposition_type, receptor_id, deposition)
		SELECT
			year,
			'deposition_space_addition'::other_deposition_type AS other_deposition_type,
			receptor_id,
			space_addition AS deposition

			FROM
				(SELECT
					receptor_id,
					year,
					GREATEST(
						LEAST(
							(critical_deposition - 70) - deposition,
							total_desire - total_space), -- Total space bevat niet de addition
						0
					) AS space_addition

					FROM setup.deposition_spaces
						INNER JOIN economic_desires USING (year, receptor_id)
						INNER JOIN setup.build_depositions_jurisdiction_policies_view AS jurisdiction_policies_future USING (year, receptor_id) -- Tabel is nog niet aangemaakt
						INNER JOIN critical_depositions USING (receptor_id)

				) AS space_additions
	$$;


	PERFORM ae_raise_notice('other_depositions - set missing data to 0 @ ' || timeofday());

	EXECUTE $$
		INSERT INTO other_depositions (year, other_deposition_type, receptor_id, deposition)
		SELECT
			year,
			'deposition_space_addition'::other_deposition_type AS other_deposition_type,
			receptor_id,
			0 AS deposition

			FROM
				(SELECT
					year,
					receptor_id

					FROM receptors
						LEFT JOIN setup.uncalculated_receptors USING (receptor_id) -- De data moet enkel voor de doogerekende receptoren aangemaakt worden
						CROSS JOIN years

					WHERE
						year_category = 'future'
						AND uncalculated_receptors.receptor_id IS NULL

				EXCEPT

				SELECT
					year,
					receptor_id

					FROM other_depositions

					WHERE other_deposition_type = 'deposition_space_addition'

				) AS space_additions

	$$;

	EXECUTE $$
		INSERT INTO other_depositions (year, other_deposition_type, receptor_id, deposition)
		SELECT
			year,
			'deposition_space_addition'::other_deposition_type AS other_deposition_type,
			receptor_id,
			0 AS deposition

			FROM receptors
				LEFT JOIN setup.uncalculated_receptors USING (receptor_id) -- De data moet enkel voor de doogerekende receptoren aangemaakt worden
				CROSS JOIN years

			WHERE
				year_category IN ('base', 'last')
				AND uncalculated_receptors.receptor_id IS NULL
	$$;


	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;