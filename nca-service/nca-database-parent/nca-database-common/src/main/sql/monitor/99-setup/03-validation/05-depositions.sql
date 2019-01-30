/*
 * ae_validate_receptor_data_completeness
 * --------------------------------------
 * Controleert of er genoeg receptoren staan in de receptor data tabellen.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_receptor_data_completeness()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	table_name regclass;
BEGIN
	RAISE NOTICE '* Validating completeness of receptor data...';

	-- setup.sector_economic_growths: (year, sector_id)={2020|2030,4120}; found 528783, expected 528803; WIL JE NIET
	-- setup.gcn_sector_depositions_no_policies_agriculture: (year, gcn_sector_id, substance_id)={2011,4110|4120,11}; found 528796, expected 528803	FROMs. WIL JE NIET
	-- sector_economic_desires: (year, sector_id)={2020|2030,4120}; found 528783, expected 528803   FROMs. WIL JE NIET

	/*
	 * Niet in onderstaande checks:
	 * setup.gcn_sector_corrections_no_policies
	 * setup.gcn_sector_economic_growth_corrections
	 * setup.sector_priority_project_demands_desire
	 * setup.sector_priority_project_demands_desire_divided
	 * setup.sector_priority_project_demands_growth
	 * setup.gcn_sector_depositions_no_policies_no_growth
	 *
	 * Deze tabellen worden waar ze gebruikt worden ge-FULL OUTER JOIN-ed, waardoor dit niet uitmaakt.
	 */

	FOREACH table_name IN ARRAY
		ARRAY[	'setup.deposition_spaces',
			'setup.gcn_sector_corrections_global_policies',
			'setup.gcn_sector_corrections_jurisdiction_policies',
			'setup.gcn_sector_depositions_global_policies',
			'setup.gcn_sector_depositions_global_policies_no_growth',
			'setup.gcn_sector_depositions_jurisdiction_policies',
			'setup.gcn_sector_depositions_jurisdiction_policies_no_growth',
			'setup.gcn_sector_depositions_no_policies_agriculture',
			'setup.gcn_sector_depositions_no_policies_industry',
			'setup.gcn_sector_depositions_no_policies_other',
			'setup.gcn_sector_depositions_no_policies_road_freeway',
			'setup.gcn_sector_depositions_no_policies_road_transportation',
			'setup.gcn_sector_depositions_no_policies_shipping',
			'setup.sector_deposition_space_corrections_jurisdiction_policies',
			'setup.sector_economic_growths',
			'depositions_global_policies',
			'depositions_jurisdiction_policies',
			'depositions_no_policies',
			'other_depositions',
			'sector_depositions_global_policies',
			'sector_depositions_jurisdiction_policies',
			'sector_depositions_no_policies',
			'sector_economic_desires']
	LOOP
		RAISE NOTICE '* Validating completeness of receptor data table ''%''...', table_name;
		RETURN QUERY SELECT * FROM setup.ae_validate_completeness_receptors(table_name, TRUE);
	END LOOP;

	FOREACH table_name IN ARRAY
		ARRAY['deposition_spaces_divided']
	LOOP
		RAISE NOTICE '* Validating completeness of included receptor data table ''%''...', table_name;
		RETURN QUERY SELECT * FROM setup.ae_validate_completeness_receptors(table_name, TRUE, TRUE);
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_deposition_space
 * ----------------------------
 * Controleert de depositieruimte tabellen.
 * De tabel met de in vakjes opgedeelde depositieruimte moet overeenkomen met de tabel waar de depositieruimte als 1 getal per jaar en receptor in staat.
 * De inhoud van deze twee tabellen wordt namelijk op verschillende manieren bepaald.
 */
CREATE OR REPLACE FUNCTION setup.ae_validate_deposition_space()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	rec record;
BEGIN
	RAISE NOTICE '* Validating total deposition space matching segmented deposition space...';

	FOR rec IN SELECT
		year,
		receptor_id,
		COALESCE(total_space + total_space_addition, 0) AS total_space,
		COALESCE(no_permit_required + permit_threshold + priority_projects + projects, 0) AS total_summed_space

		FROM deposition_spaces_divided
			FULL OUTER JOIN setup.deposition_spaces USING (year, receptor_id)
			INNER JOIN included_receptors USING (receptor_id)

		WHERE ABS(COALESCE(total_space + total_space_addition, 0) - COALESCE(no_permit_required + permit_threshold + priority_projects + projects, 0)) > 0.01
	LOOP
		RETURN NEXT setup.ae_to_validation_result('warning', 'deposition_spaces_divided',
			format('deposition_spaces_divided, setup.deposition_spaces: Does not match for year %s, receptor %s (total: %s, segmented summed: %s)', rec.year, rec.receptor_id, rec.total_space, rec.total_summed_space));
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_validate_receptor_data_completeness
 * --------------------------------------
 * Controleert of er genoeg receptoren staan in de receptor data tabellen.
 */
 /*
CREATE OR REPLACE FUNCTION setup.ae_validate_depositions_completeness()
	RETURNS SETOF setup.validation_result AS
$BODY$
DECLARE
	v_sectorgroup text;
BEGIN
	RAISE NOTICE '* Validating completeness of depositions no policies 2011 wrt growth factors...';
	FOREACH v_sectorgroup IN ARRAY enum_range(NULL::setup.sectorgroup)
	LOOP
		FOR rec IN
			EXECUTE setup.ae_validate_get_completeness_sql('setup.gcn_sector_depositions_no_policies_' || v_sectorgroup,
				$$ year_category = 'source'
					AND gcn_sector_id IN (SELECT DISTINCT gcn_sector_id FROM gcn_sectors INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = '$$ || v_sectorgroup || $$'
					AND (substance_id, gcn_sector_id) IN (SELECT DISTINCT substance_id, gcn_sector_id FROM setup.gcn_sector_economic_growth_factors) $$)
		LOOP
			RETURN NEXT setup.ae_to_validation_result('error', 'setup.gcn_sector_depositions_no_policies_' || v_sectorgroup,
				format('year %s, GCN-sector %s, substance %s, has no depositions (but does have a growth factor)', rec.year, rec.gcn_sector_id, rec.substance_id));
		END LOOP;
	END LOOP;
	RETURN;
END;
$BODY$
LANGUAGE plpgsql STABLE;
*/
