/*
 * ae_output_summary_table
 * -----------------------
 * Genereert overzichten van data als CSV bestanden. Dient gebruikt te worden om database releases inhoudelijk met elkaar te kunnen vergelijken.
 * Deze functie genereert bestanden volgens de opgegeven bestandsspecificatie. In de bestandsspecificatie moet de string {title} gebruikt worden,
 * deze zal per tabel vervangen worden door de naam van die tabel.
 * Verder wordt {datesuffix} vervangen door de huidige datum in YYYYMMDD formaat.
 * @param filespec Pad en bestandsspecificatie zoals hierboven beschreven.
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table(filespec text)
	RETURNS void AS
$BODY$
BEGIN
	DROP TABLE IF EXISTS tmp_summary_log;
	CREATE TEMPORARY TABLE tmp_summary_log (
		name regproc NOT NULL,
		start_time timestamp NOT NULL,
		duration interval NOT NULL
	) ON COMMIT DROP;

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_farm_lodgings_num_animals', filespec);
	--PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_farm_emissions', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_space_desire_per_n2000', filespec);
	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_space_desire_per_n2000_habitat', filespec);
	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_space_desire_per_n2000_receptor', filespec);
	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_space_desire_per_province', filespec);
	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_delta_space_desire', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_sectorgroup_deposition_space_growth_per_n2000', filespec);
	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_sectorgroup_desire_per_n2000', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_deposition_tables', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_sectorgroup_deposition_per_n2000', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_deposition_per_n2000', filespec);
	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_deposition_per_n2000_habitat', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_deposition_increase_per_n2000', filespec);
	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_deposition_increase_per_receptor_n2000', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_other_deposition_per_n2000', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_relevant_data_increase_per_receptor', filespec);

	PERFORM ae_run_and_log_summary('setup.ae_output_summary_table_analysis_per_sector', filespec);

	DROP TABLE tmp_summary_log;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_run_and_log_summary
 * ----------------------
 * Draait een specifieke summary, houdt de doorlooptijd bij en schrijft deze weg. 
 * De doorlooptijd wordt bijgehouden in de tabel tmp_summary_log die wordt aangemaakt in een andere functie (setup.ae_output_summary_table).
 * Als de tijdelijke log-tabel niet bestaat geeft deze functie een foutmelding, dus deze functie kan niet los worden aangeroepen.
 * De logfile wordt opgeslagen volgens dezelfde filespec als de summaries (met title "log").
 * @summary_function Naam van de uit te voeren summary functie.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION ae_run_and_log_summary(summary_function regproc, filespec text)
	 RETURNS void AS
$BODY$
DECLARE
	start_time timestamp;
	duration interval;
BEGIN
	IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'tmp_summary_log') THEN
		RAISE EXCEPTION 'Cannot run this function independently; use setup.ae_output_summary_table() or run the summary without logging.';
	END IF;
	
	start_time := clock_timestamp();
	EXECUTE 'SELECT ' || summary_function || '(''' || filespec || ''')';
	duration := clock_timestamp() - start_time;

	PERFORM ae_raise_notice('Duration of summary ' || summary_function || '(): ' || duration);

	INSERT INTO tmp_summary_log (name, start_time, duration) VALUES (summary_function, start_time, duration);
	
	PERFORM setup.ae_write_summary_table(filespec, 'log', 'SELECT * FROM tmp_summary_log ORDER BY start_time');	
END;
$BODY$
LANGUAGE plpgsql VOLATILE;



/*
 * ae_output_summary_table_farm_lodgings_num_animals
 * -------------------------------------------------
 * Genereert een CSV met overzichten van de aantallen dieren (som) per RAV (met plafondcategorie).
 * Hierdoor kunnen verkeerd gekoppelde bronnen bepaald worden.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_farm_lodgings_num_animals(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for num animals per farm lodging...';

	query := $$
		SELECT
			farm_lodging_type_id,
			farm_lodging_types.name AS farm_lodging_type_name,
			farm_lodging_types.description AS farm_lodging_type_description,
			farm_emission_ceiling_category_id,
			farm_emission_ceiling_categories.name AS farm_emission_ceiling_category_name,
			farm_emission_ceiling_categories.description AS farm_emission_ceiling_category_description,
			COALESCE(SUM(num_animals), 0) AS num_animals

			FROM farm_emission_ceiling_categories
				INNER JOIN farm_lodging_types USING (farm_emission_ceiling_category_id)
				LEFT JOIN farm_source_lodging_types USING (farm_lodging_type_id)

			GROUP BY farm_lodging_type_id, farm_lodging_type_name, farm_lodging_type_description, farm_emission_ceiling_category_id, farm_emission_ceiling_category_name, farm_emission_ceiling_category_description

			ORDER BY farm_lodging_type_name, farm_emission_ceiling_category_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'farm_lodgings_num_animals', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_farm_emissions
 * --------------------------------------
 * Genereert een CSV met overzichten van de stalemissies, per jaar, beleidsscenario en emissieplafondcategorie.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_farm_emissions(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	rec record;
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for farm emissions...';

	CREATE TEMPORARY TABLE tmp_summary_farm_emissions (
		calctype smallint NOT NULL,
		policy_type policy_type NOT NULL,
		year year_type NOT NULL,
		farm_emission_ceiling_category_id integer NOT NULL,
		emission real NOT NULL,

		PRIMARY KEY (calctype, policy_type, year, farm_emission_ceiling_category_id)
	) ON COMMIT DROP;

	FOR rec IN
	SELECT policy_types.policy_type, years.year

		FROM (SELECT unnest(enum_range(NULL::policy_type)) AS policy_type) AS policy_types
			CROSS JOIN years

		WHERE year_category IN ('farm_source', 'base', 'last', 'future')
	LOOP
		INSERT INTO tmp_summary_farm_emissions
		SELECT
			1::smallint AS calctype,
			rec.policy_type,
			emissions_using_ceiling.year,
			farm_lodging_types.farm_emission_ceiling_category_id,
			SUM(emission) AS emission

			FROM ae_farm_emissions(rec.year, (SELECT array_agg(source_id) FROM farm_sources), rec.policy_type, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE) AS emissions_using_ceiling
				INNER JOIN farm_lodging_types USING (farm_lodging_type_id)

			GROUP BY emissions_using_ceiling.year, farm_lodging_types.farm_emission_ceiling_category_id
		;

		INSERT INTO tmp_summary_farm_emissions
		SELECT
			2::smallint AS calctype,
			rec.policy_type,
			emissions_using_formal_ceiling.year,
			farm_lodging_types.farm_emission_ceiling_category_id,
			SUM(emission) AS emission

			FROM ae_farm_emissions(rec.year, (SELECT array_agg(source_id) FROM farm_sources), rec.policy_type, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE) AS emissions_using_formal_ceiling
				INNER JOIN farm_lodging_types USING (farm_lodging_type_id)

			GROUP BY emissions_using_formal_ceiling.year, farm_lodging_types.farm_emission_ceiling_category_id
		;

		INSERT INTO tmp_summary_farm_emissions
		SELECT
			3::smallint AS calctype,
			rec.policy_type,
			emissions_no_growth.year,
			farm_lodging_types.farm_emission_ceiling_category_id,
			SUM(emission) AS emission

			FROM ae_farm_emissions(rec.year, (SELECT array_agg(source_id) FROM farm_sources), rec.policy_type, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE) AS emissions_no_growth
				INNER JOIN farm_lodging_types USING (farm_lodging_type_id)

			GROUP BY emissions_no_growth.year, farm_lodging_types.farm_emission_ceiling_category_id
		;
	END LOOP;

	query := $$
		SELECT
			year,
			policy_type,
			farm_emission_ceiling_category_id,
			name,
			SUM(emission_using_ceiling) AS emission_using_ceiling,
			SUM(emission_using_formal_ceiling) AS emission_using_formal_ceiling,
			SUM(emission_no_growth) AS emission_no_growth

			FROM
				(SELECT
					year,
					policy_type,
					farm_emission_ceiling_category_id,
					emissions_using_ceiling.emission AS emission_using_ceiling,
					emissions_using_formal_ceiling.emission AS emission_using_formal_ceiling,
					emissions_no_growth.emission AS emission_no_growth

					FROM tmp_summary_farm_emissions AS emissions_using_ceiling
						FULL OUTER JOIN tmp_summary_farm_emissions AS emissions_using_formal_ceiling USING (year, policy_type, farm_emission_ceiling_category_id)
						FULL OUTER JOIN tmp_summary_farm_emissions AS emissions_no_growth USING (year, policy_type, farm_emission_ceiling_category_id)

					WHERE
						emissions_using_ceiling.calctype = 1
						AND emissions_using_formal_ceiling.calctype = 2
						AND emissions_no_growth.calctype = 3
				) AS emissions_columnized

				INNER JOIN farm_emission_ceiling_categories USING (farm_emission_ceiling_category_id)

			GROUP BY year, policy_type, farm_emission_ceiling_category_id, name

			ORDER BY year, policy_type, farm_emission_ceiling_category_id, name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'farm_emissions', query);

	DROP TABLE tmp_summary_farm_emissions; -- Clean up
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_space_desire_per_n2000
 * ----------------------------------------------
 * Genereert een CSV met overzichten van de depositieruimte en ontwikkelingsbehoefte per jaar en N2000 gebied.
 * De getallen worden gegeven als totaal, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_space_desire_per_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for total & average deposition space and average economic desire per N2000...';

	-- TODO: This temporary table is equal to the one in setup.ae_output_summary_table_space_desire_per_n2000_receptor and could maybe be reused!?
	CREATE TEMPORARY TABLE tmp_total_sector_economic_desires ON COMMIT DROP AS
	SELECT
		year,
		receptor_id,
		SUM(priority_projects_desire) AS priority_projects_desire,
		SUM(other_desire) AS other_desire
		
		FROM sector_economic_desires
		
		GROUP BY year, receptor_id
	;

	CREATE INDEX tmp_total_sector_economic_desires_idx ON tmp_total_sector_economic_desires (year, receptor_id);


	CREATE TEMPORARY TABLE tmp_deposition_spaces ON COMMIT DROP AS
	SELECT * FROM deposition_spaces_view;

	CREATE INDEX tmp_deposition_spaces_idx ON tmp_deposition_spaces (year, receptor_id);


	CREATE TEMPORARY TABLE tmp_space_desire_only_exceeding ON COMMIT DROP AS
	SELECT
		year,
		receptor_id,
		tmp_deposition_spaces.total_space,
		total_space_addition,
		no_permit_required,
		permit_threshold,
		priority_projects,
		projects,
		priority_projects_desire,
		other_desire
		
		FROM tmp_deposition_spaces
			INNER JOIN setup.deposition_spaces USING (year, receptor_id)
			INNER JOIN deposition_spaces_divided_view USING (year, receptor_id)
			INNER JOIN tmp_total_sector_economic_desires USING (year, receptor_id)
	;

	ALTER TABLE tmp_space_desire_only_exceeding ADD PRIMARY KEY (year, receptor_id);


	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			SUM(total_space) AS total_space,
			ae_weighted_avg(total_space::numeric, weight::numeric)::real AS avg_space,
			SUM(total_space_addition) AS total_space_addition,
			ae_weighted_avg(total_space_addition::numeric, weight::numeric)::real AS avg_total_space_addition,

			ae_weighted_avg(no_permit_required::numeric, weight::numeric)::real AS avg_no_permit_required_space,
			ae_weighted_avg(permit_threshold::numeric, weight::numeric)::real AS avg_permit_threshold_space,
			ae_weighted_avg(priority_projects::numeric, weight::numeric)::real AS avg_priority_projects_space,
			ae_weighted_avg(projects::numeric, weight::numeric)::real AS avg_projects_space,

			SUM(priority_projects_desire) AS priority_projects_desire,
			ae_weighted_avg(priority_projects_desire::numeric, weight::numeric)::real AS avg_priority_projects_desire,

			SUM(other_desire) AS other_desire,
			ae_weighted_avg(other_desire::numeric, weight::numeric)::real AS avg_other_desire,

			SUM(priority_projects_desire + other_desire) AS total_desire,
			ae_weighted_avg((priority_projects_desire + other_desire)::numeric, weight::numeric)::real AS avg_total_desire

			FROM tmp_space_desire_only_exceeding
				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'space_desire_only_exceeding_per_n2000', query);

	DROP TABLE tmp_total_sector_economic_desires;
	DROP TABLE tmp_deposition_spaces;
	DROP TABLE tmp_space_desire_only_exceeding;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_space_desire_per_n2000_habitat
 * ------------------------------------------------------
 * Genereert een CSV met overzichten van de depositieruimte en ontwikkelingsbehoefte per jaar en N2000 gebied en habitat-type.
 * De getallen worden gegeven als totaal, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_space_desire_per_n2000_habitat(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for total & average deposition space and average economic desire per N2000 and habitat type...';

	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,
			habitat_type_id,
			habitat_types.name AS habitat_type_name,

			SUM(surface) AS total_habitat_surface,

			SUM(total_space) AS total_space,
			ae_weighted_avg(total_space::numeric, weight::numeric)::real AS avg_space,

			SUM(total_desire) AS total_desire,
			ae_weighted_avg(total_desire::numeric, weight::numeric)::real AS avg_desire

			FROM deposition_spaces_view
				INNER JOIN economic_desires USING (year, receptor_id)
				INNER JOIN receptors_to_relevant_habitats_view USING (receptor_id)
				INNER JOIN habitat_types USING (habitat_type_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name, habitat_type_id, habitat_types.name

			ORDER BY year, assessment_area_id, natura2000_name, habitat_type_id, habitat_types.name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'space_desire_only_exceeding_per_n2000_habitat', query);


	RAISE NOTICE 'Creating summary for the (non exceeding) total & average deposition space and average economic desire per N2000 and habitat type...';

	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,
			habitat_type_id,
			habitat_types.name AS habitat_type_name,

			SUM(surface) AS total_habitat_surface,

			SUM(total_space + total_space_addition) AS total_space,
			ae_weighted_avg((total_space + total_space_addition)::numeric, surface::numeric)::real AS avg_space,

			SUM(total_desire) AS total_desire,
			ae_weighted_avg(total_desire::numeric, surface::numeric)::real AS avg_desire

			FROM setup.deposition_spaces
				INNER JOIN economic_desires USING (year, receptor_id)
				INNER JOIN receptors_to_relevant_habitats_view USING (receptor_id)
				INNER JOIN habitat_types USING (habitat_type_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)
				LEFT JOIN relevant_development_space_exceeding_receptors_view USING (year, receptor_id)

			WHERE relevant_development_space_exceeding_receptors_view.receptor_id IS NULL

			GROUP BY year, assessment_area_id, natura2000_name, habitat_type_id, habitat_types.name

			ORDER BY year, assessment_area_id, natura2000_name, habitat_type_id, habitat_types.name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'space_desire_non_exceeding_per_n2000_habitat', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_space_desire_per_n2000_receptor
 * -------------------------------------------------------
 * Genereert een CSV met overzichten van de depositieruimte en ontwikkelingsbehoefte per jaar, receptor en N2000 gebied.
 * De getallen worden gegeven als totaal, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_space_desire_per_n2000_receptor(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for total & average deposition space and average economic desire per N2000 and receptor...';

	-- TODO: This temporary table is equal to the one in setup.ae_output_summary_table_space_desire_per_n2000 and could maybe be reused!?
	CREATE TEMPORARY TABLE tmp_total_sector_economic_desires ON COMMIT DROP AS
	SELECT
		year,
		receptor_id,
		SUM(priority_projects_desire) AS priority_projects_desire,
		SUM(other_desire) AS other_desire

		FROM sector_economic_desires
		
		GROUP BY year, receptor_id
	;

	CREATE INDEX tmp_total_sector_economic_desires_idx ON tmp_total_sector_economic_desires (year, receptor_id);

	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,
			receptor_id,
			surface,
			critical_deposition,

			total_space,
			priority_projects_desire,
			other_desire,
			(priority_projects_desire + other_desire) AS total_desire

			FROM deposition_spaces_view
				INNER JOIN tmp_total_sector_economic_desires USING (year, receptor_id)
				INNER JOIN critical_depositions USING (receptor_id)
				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			ORDER BY year, assessment_area_id, natura2000_name, receptor_id
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'space_desire_only_exceeding_per_n2000_receptor', query);

	DROP TABLE tmp_total_sector_economic_desires;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;



/*
 * ae_output_summary_table_space_desire_per_province
 * -------------------------------------------------
 * Genereert een CSV met overzichten van de depositieruimte en ontwikkelingsbehoefte per jaar en provincie.
 * Voor iedere receptor wordt gekeken in welke provincie deze ligt, en daarbinnen worden de getallen gesommeerd.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_space_desire_per_province(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for total deposition space and average economic desire per province...';

	CREATE TEMPORARY TABLE tmp_sectorgroup_desire ON COMMIT DROP AS
	SELECT
		sectorgroup,
		year,
		receptor_id,
		SUM(priority_projects_desire::double precision) AS priority_projects_desire,
		SUM(other_desire::double precision) AS other_desire

		FROM sector_economic_desires
			INNER JOIN setup.sectors_sectorgroup USING (sector_id)
			INNER JOIN included_receptors USING (receptor_id)

		GROUP BY sectorgroup, year, receptor_id
	;
	ALTER TABLE tmp_sectorgroup_desire ADD PRIMARY KEY (sectorgroup, year, receptor_id);


	CREATE TEMPORARY TABLE tmp_deposition_space ON COMMIT DROP AS
	SELECT
		year,
		receptor_id,
		(total_space)::double precision AS total_space,
		(total_space - deposition_space_addition)::double precision AS total_space_without_space_addition

		FROM deposition_spaces_view
			INNER JOIN (SELECT year, receptor_id, deposition AS deposition_space_addition FROM other_depositions WHERE other_deposition_type = 'deposition_space_addition') AS deposition_space_additions USING (year, receptor_id)
	;
	ALTER TABLE tmp_deposition_space ADD PRIMARY KEY (year, receptor_id);


	CREATE TEMPORARY TABLE tmp_receptor_to_province ON COMMIT DROP AS
	SELECT
		receptor_id,
		province_area_id

		FROM receptors
			INNER JOIN province_areas ON (ST_Intersects(receptors.geometry, province_areas.geometry))
			INNER JOIN included_receptors USING (receptor_id)
	;
	ALTER TABLE tmp_receptor_to_province ADD PRIMARY KEY (receptor_id, province_area_id);


	query := $$
		SELECT
			year,
			province_area_id,
			province_areas.name,

			SUM(cartographic_surface::double precision) AS total_habitat_surface,

			SUM(total_space * weight) AS total_space,
			SUM(total_space_without_space_addition * weight) AS total_space_without_space_addition,

			SUM(agriculture.priority_projects_desire * weight) AS priority_projects_desire_agriculture,
			SUM(agriculture.other_desire * weight) AS other_desire_agriculture,

			SUM(industry.priority_projects_desire * weight) AS priority_projects_desire_industry,
			SUM(industry.other_desire * weight) AS other_desire_industry,

			SUM(shipping.priority_projects_desire * weight) AS priority_projects_desire_shipping,
			SUM(shipping.other_desire * weight) AS other_desire_shipping,

			SUM(road_transportation.priority_projects_desire * weight) AS priority_projects_desire_road_transportation,
			SUM(road_transportation.other_desire * weight) AS other_desire_road_transportation,

			SUM(road_freeway.priority_projects_desire * weight) AS priority_projects_desire_road_freeway,
			SUM(road_freeway.other_desire * weight) AS other_desire_road_freeway,

			SUM(other.priority_projects_desire * weight) AS priority_projects_desire_other,
			SUM(other.other_desire * weight) AS other_desire_other

			FROM tmp_deposition_space

				INNER JOIN (SELECT year, receptor_id, priority_projects_desire, other_desire FROM tmp_sectorgroup_desire WHERE sectorgroup = 'agriculture') AS agriculture USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, priority_projects_desire, other_desire FROM tmp_sectorgroup_desire WHERE sectorgroup = 'industry') AS industry USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, priority_projects_desire, other_desire FROM tmp_sectorgroup_desire WHERE sectorgroup = 'shipping') AS shipping USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, priority_projects_desire, other_desire FROM tmp_sectorgroup_desire WHERE sectorgroup = 'road_transportation') AS road_transportation USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, priority_projects_desire, other_desire FROM tmp_sectorgroup_desire WHERE sectorgroup = 'road_freeway') AS road_freeway USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, priority_projects_desire, other_desire FROM tmp_sectorgroup_desire WHERE sectorgroup = 'other') AS other USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)

				INNER JOIN tmp_receptor_to_province USING (receptor_id)
				INNER JOIN province_areas USING (province_area_id)

			GROUP BY year, province_area_id, province_areas.name

			ORDER BY year, province_area_id
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'space_desire_only_exceeding_per_province', query);

	DROP TABLE tmp_sectorgroup_desire;
	DROP TABLE tmp_deposition_space;
	DROP TABLE tmp_receptor_to_province;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_delta_space_desire
 * ------------------------------------------
 * Genereert CSV's met overzichten van de confrontatie depositieruimte en ontwikkelingsbehoefte, per klasse bereik.
 * Per klasse wordt gegeven: de totale oppervlakte, en het gemiddelde tekort/overschot gewogen op de oppervlakte.
 * Aggregatieniveas zijn: jaar/receptor, jaar/N2000, jaar/N2000/habitattype.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_delta_space_desire(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	-- View with most details
	CREATE OR REPLACE TEMPORARY VIEW tmp_delta_space_desire_view AS
	SELECT
		year,
		assessment_area_id,
		habitat_type_id,
		receptor_id,

		surface,
		coverage,

		ae_distribute_enum(ae_get_delta_space_desire_range(total_space, total_desire), (total_space - total_desire)::numeric)::real[] AS delta_range_distribution,
		ae_distribute_enum(ae_get_delta_space_desire_range(total_space, total_desire), (surface * coverage)::numeric)::real[] AS surface_range_distribution_n2000,
		ae_distribute_enum(ae_get_delta_space_desire_range(total_space, total_desire), (surface)::numeric)::real[] AS surface_range_distribution_n2000_habitat

		FROM deposition_spaces_view
			INNER JOIN economic_desires USING (year, receptor_id)
			INNER JOIN receptors_to_relevant_habitats_view USING (receptor_id)

		GROUP BY year, assessment_area_id, habitat_type_id, receptor_id, surface, coverage
	;

	-- Aggregate to receptors
	RAISE NOTICE 'Creating summary of confrontation deposition space and economic desire, per receptor...';
	query := $$
		SELECT
			year,
			receptor_id,

			SUM(surface) AS total_surface,

			SUM(surface_range_distribution_n2000_habitat[1]) AS "total_surface_shortage_70+",
			SUM(surface_range_distribution_n2000_habitat[2]) AS "total_surface_shortage_35-70",
			SUM(surface_range_distribution_n2000_habitat[3]) AS "total_surface_shortage_1-35",
			SUM(surface_range_distribution_n2000_habitat[4]) AS "total_surface_equal",
			SUM(surface_range_distribution_n2000_habitat[5]) AS "total_surface_surplus_1-35",
			SUM(surface_range_distribution_n2000_habitat[6]) AS "total_surface_surplus_35-70",
			SUM(surface_range_distribution_n2000_habitat[7]) AS "total_surface_surplus_70+",

			COALESCE(SUM(delta_range_distribution[1] * surface_range_distribution_n2000_habitat[1]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[1]), 0), 0) AS "avg_shortage_70+",
			COALESCE(SUM(delta_range_distribution[2] * surface_range_distribution_n2000_habitat[2]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[2]), 0), 0) AS "avg_shortage_35-70",
			COALESCE(SUM(delta_range_distribution[3] * surface_range_distribution_n2000_habitat[3]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[3]), 0), 0) AS "avg_shortage_1-35",
			COALESCE(SUM(delta_range_distribution[4] * surface_range_distribution_n2000_habitat[4]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[4]), 0), 0) AS "avg_equal",
			COALESCE(SUM(delta_range_distribution[5] * surface_range_distribution_n2000_habitat[5]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[5]), 0), 0) AS "avg_surplus_1-35",
			COALESCE(SUM(delta_range_distribution[6] * surface_range_distribution_n2000_habitat[6]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[6]), 0), 0) AS "avg_surplus_35-70",
			COALESCE(SUM(delta_range_distribution[7] * surface_range_distribution_n2000_habitat[7]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[7]), 0), 0) AS "avg_surplus_70+"

			FROM tmp_delta_space_desire_view

			GROUP BY year, receptor_id

			ORDER BY year, receptor_id
	$$;
	PERFORM setup.ae_write_summary_table(filespec, 'delta_space_desire_only_exceeding_per_receptor', query);

	-- Aggregate to N2000
	RAISE NOTICE 'Creating summary of confrontation deposition space and economic desire, per N2000...';
	query := $$
		SELECT
			year,
			natura2000_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface * coverage) AS total_surface,

			SUM(surface_range_distribution_n2000[1]) AS "total_surface_shortage_70+",
			SUM(surface_range_distribution_n2000[2]) AS "total_surface_shortage_35-70",
			SUM(surface_range_distribution_n2000[3]) AS "total_surface_shortage_1-35",
			SUM(surface_range_distribution_n2000[4]) AS "total_surface_equal",
			SUM(surface_range_distribution_n2000[5]) AS "total_surface_surplus_1-35",
			SUM(surface_range_distribution_n2000[6]) AS "total_surface_surplus_35-70",
			SUM(surface_range_distribution_n2000[7]) AS "total_surface_surplus_70+",

			COALESCE(SUM(delta_range_distribution[1] * surface_range_distribution_n2000[1]) / NULLIF(SUM(surface_range_distribution_n2000[1]), 0), 0) AS "avg_shortage_70+",
			COALESCE(SUM(delta_range_distribution[2] * surface_range_distribution_n2000[2]) / NULLIF(SUM(surface_range_distribution_n2000[2]), 0), 0) AS "avg_shortage_35-70",
			COALESCE(SUM(delta_range_distribution[3] * surface_range_distribution_n2000[3]) / NULLIF(SUM(surface_range_distribution_n2000[3]), 0), 0) AS "avg_shortage_1-35",
			COALESCE(SUM(delta_range_distribution[4] * surface_range_distribution_n2000[4]) / NULLIF(SUM(surface_range_distribution_n2000[4]), 0), 0) AS "avg_equal",
			COALESCE(SUM(delta_range_distribution[5] * surface_range_distribution_n2000[5]) / NULLIF(SUM(surface_range_distribution_n2000[5]), 0), 0) AS "avg_surplus_1-35",
			COALESCE(SUM(delta_range_distribution[6] * surface_range_distribution_n2000[6]) / NULLIF(SUM(surface_range_distribution_n2000[6]), 0), 0) AS "avg_surplus_35-70",
			COALESCE(SUM(delta_range_distribution[7] * surface_range_distribution_n2000[7]) / NULLIF(SUM(surface_range_distribution_n2000[7]), 0), 0) AS "avg_surplus_70+"

			FROM tmp_delta_space_desire_view
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, natura2000_area_id, natura2000_name

			ORDER BY year, natura2000_area_id, natura2000_name
	$$;
	PERFORM setup.ae_write_summary_table(filespec, 'delta_space_desire_only_exceeding_per_n2000', query);

	-- Aggregate to N2000/habitattype
	RAISE NOTICE 'Creating summary of confrontation deposition space and economic desire, per N2000/habitattype...';
	query := $$
		SELECT
			year,
			natura2000_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,
			habitat_type_id,
			habitat_types.name AS habitat_type_name,

			SUM(surface) AS total_surface,

			SUM(surface_range_distribution_n2000_habitat[1]) AS "total_surface_shortage_70+",
			SUM(surface_range_distribution_n2000_habitat[2]) AS "total_surface_shortage_35-70",
			SUM(surface_range_distribution_n2000_habitat[3]) AS "total_surface_shortage_1-35",
			SUM(surface_range_distribution_n2000_habitat[4]) AS "total_surface_equal",
			SUM(surface_range_distribution_n2000_habitat[5]) AS "total_surface_surplus_1-35",
			SUM(surface_range_distribution_n2000_habitat[6]) AS "total_surface_surplus_35-70",
			SUM(surface_range_distribution_n2000_habitat[7]) AS "total_surface_surplus_70+",

			COALESCE(SUM(delta_range_distribution[1] * surface_range_distribution_n2000_habitat[1]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[1]), 0), 0) AS "avg_shortage_70+",
			COALESCE(SUM(delta_range_distribution[2] * surface_range_distribution_n2000_habitat[2]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[2]), 0), 0) AS "avg_shortage_35-70",
			COALESCE(SUM(delta_range_distribution[3] * surface_range_distribution_n2000_habitat[3]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[3]), 0), 0) AS "avg_shortage_1-35",
			COALESCE(SUM(delta_range_distribution[4] * surface_range_distribution_n2000_habitat[4]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[4]), 0), 0) AS "avg_equal",
			COALESCE(SUM(delta_range_distribution[5] * surface_range_distribution_n2000_habitat[5]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[5]), 0), 0) AS "avg_surplus_1-35",
			COALESCE(SUM(delta_range_distribution[6] * surface_range_distribution_n2000_habitat[6]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[6]), 0), 0) AS "avg_surplus_35-70",
			COALESCE(SUM(delta_range_distribution[7] * surface_range_distribution_n2000_habitat[7]) / NULLIF(SUM(surface_range_distribution_n2000_habitat[7]), 0), 0) AS "avg_surplus_70+"

			FROM tmp_delta_space_desire_view
				INNER JOIN natura2000_areas USING (assessment_area_id)
				INNER JOIN habitat_types USING (habitat_type_id)

			GROUP BY year, natura2000_id, natura2000_name, habitat_type_id, habitat_type_name

			ORDER BY year, natura2000_id, natura2000_name, habitat_type_id, habitat_type_name
	$$;
	PERFORM setup.ae_write_summary_table(filespec, 'delta_space_desire_only_exceeding_per_n2000_habitattype', query);

	DROP VIEW tmp_delta_space_desire_view;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_sectorgroup_deposition_space_growth_per_n2000
 * ---------------------------------------------------------------------
 * Genereert een CSV met overzichten van economische groei per jaar en N2000 gebied.
 * De getallen worden gegeven voor de sectorgroepen als totaal, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * Er wordt ook een CSV gemaakt van de sectorgroep 'farm' verder uitgespecificeerd per sector.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_sectorgroup_deposition_space_growth_per_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for total & average economic growth (deposition_space_growth; only exceeding) of the sectorgroups per N2000...';
	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			SUM(total_growth_agriculture) AS total_growth_agriculture,
			ae_weighted_avg(total_growth_agriculture::numeric, weight::numeric)::real AS avg_growth_agriculture,

			SUM(total_growth_industry) AS total_growth_industry,
			ae_weighted_avg(total_growth_industry::numeric, weight::numeric)::real AS avg_growth_industry,

			SUM(total_growth_shipping) AS total_growth_shipping,
			ae_weighted_avg(total_growth_shipping::numeric, weight::numeric)::real AS avg_growth_shipping,

			SUM(total_growth_road_transportation) AS total_growth_road_transportation,
			ae_weighted_avg(total_growth_road_transportation::numeric, weight::numeric)::real AS avg_growth_road_transportation,

			SUM(total_growth_road_freeway) AS total_growth_road_freeway,
			ae_weighted_avg(total_growth_road_freeway::numeric, weight::numeric)::real AS avg_growth_road_freeway,

			SUM(total_growth_other) AS total_growth_other,
			ae_weighted_avg(total_growth_other::numeric, weight::numeric)::real AS avg_growth_other

			FROM (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_agriculture FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'agriculture' GROUP BY year, receptor_id) AS total_growths_agriculture
				INNER JOIN (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_industry FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'industry' GROUP BY year, receptor_id) AS total_growths_industry USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_shipping FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'shipping' GROUP BY year, receptor_id) AS total_growths_shipping USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_road_transportation FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'road_transportation' GROUP BY year, receptor_id) AS total_growths_road_transportation USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_road_freeway FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'road_freeway' GROUP BY year, receptor_id) AS total_growths_road_freeway USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_other FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'other' GROUP BY year, receptor_id) AS total_growths_other USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN relevant_development_space_exceeding_receptors_view USING (receptor_id, year)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'sectorgroup_deposition_space_growth_only_exceeding_per_n2000', query);

	RAISE NOTICE 'Creating summary for total & average economic growth (deposition_space_growth; only exceeding) of the sectors in sectorgroup farm per N2000...';
	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			SUM(total_growth_agriculture) AS total_growth_agriculture,
			ae_weighted_avg(total_growth_agriculture::numeric, weight::numeric)::real AS avg_growth_agriculture,

			SUM(growths_agriculture_lodging.deposition_space_growth) AS total_growth_4110_lodging,
			ae_weighted_avg(COALESCE(growths_agriculture_lodging.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_4110_lodging,

			SUM(growths_agriculture_fertilizer_storage.deposition_space_growth) AS total_growth_4120_fertilizer_storage,
			ae_weighted_avg(COALESCE(growths_agriculture_fertilizer_storage.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_4120_fertilizer_storage,

			SUM(growths_agriculture_grazing.deposition_space_growth) AS total_growth_4130_grazing,
			ae_weighted_avg(COALESCE(growths_agriculture_grazing.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_4130_grazing,

			SUM(growths_agriculture_fertilizer_use.deposition_space_growth) AS total_growth_4140_fertilizer_use,
			ae_weighted_avg(COALESCE(growths_agriculture_fertilizer_use.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_4140_fertilizer_use,

			SUM(growths_agriculture_greenhouse.deposition_space_growth) AS total_growth_4320_greenhouse,
			ae_weighted_avg(COALESCE(growths_agriculture_greenhouse.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_4320_greenhouse,

			SUM(growths_agriculture_other.deposition_space_growth) AS total_growth_4600_other,
			ae_weighted_avg(COALESCE(growths_agriculture_other.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_4600_other

			FROM (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_agriculture FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'agriculture' GROUP BY year, receptor_id) AS total_growths_agriculture
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 4110) AS growths_agriculture_lodging USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 4120) AS growths_agriculture_fertilizer_storage USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 4130) AS growths_agriculture_grazing USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 4140) AS growths_agriculture_fertilizer_use USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 4320) AS growths_agriculture_greenhouse USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 4600) AS growths_agriculture_other USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN relevant_development_space_exceeding_receptors_view USING (receptor_id, year)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'sectorgroup_agriculture_deposition_space_growth_only_exceeding_per_n2000', query);


	RAISE NOTICE 'Creating summary for total & average economic growth (deposition_space_growth; only exceeding) of the sectors in sectorgroup industry per N2000...';
	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			SUM(total_growth_industry) AS total_growth_industry,
			ae_weighted_avg(total_growth_industry::numeric, weight::numeric)::real AS avg_growth_industry,

			SUM(growths_industry_1050.deposition_space_growth) AS total_growth_1050,
			ae_weighted_avg(COALESCE(growths_industry_1050.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_1050,

			SUM(growths_industry_1100.deposition_space_growth) AS total_growth_1100,
			ae_weighted_avg(COALESCE(growths_industry_1100.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_1100,

			SUM(growths_industry_1300.deposition_space_growth) AS total_growth_1300,
			ae_weighted_avg(COALESCE(growths_industry_1300.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_1300,

			SUM(growths_industry_1400.deposition_space_growth) AS total_growth_1400,
			ae_weighted_avg(COALESCE(growths_industry_1400.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_1400,

			SUM(growths_industry_1500.deposition_space_growth) AS total_growth_1500,
			ae_weighted_avg(COALESCE(growths_industry_1500.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_1500,

			SUM(growths_industry_1700.deposition_space_growth) AS total_growth_1700,
			ae_weighted_avg(COALESCE(growths_industry_1700.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_1700,

			SUM(growths_industry_1800.deposition_space_growth) AS total_growth_1800,
			ae_weighted_avg(COALESCE(growths_industry_1800.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_1800,

			SUM(growths_industry_2100.deposition_space_growth) AS total_growth_2100,
			ae_weighted_avg(COALESCE(growths_industry_2100.deposition_space_growth, 0)::numeric, weight::numeric)::real AS avg_growth_2100

			FROM (SELECT year, receptor_id, SUM(deposition_space_growth) AS total_growth_industry FROM setup.sector_economic_growths INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'industry' GROUP BY year, receptor_id) AS total_growths_industry
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 1050) AS growths_industry_1050 USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 1100) AS growths_industry_1100 USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 1300) AS growths_industry_1300 USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 1400) AS growths_industry_1400 USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 1500) AS growths_industry_1500 USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 1700) AS growths_industry_1700 USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 1800) AS growths_industry_1800 USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, deposition_space_growth FROM setup.sector_economic_growths WHERE sector_id = 2100) AS growths_industry_2100 USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN relevant_development_space_exceeding_receptors_view USING (receptor_id, year)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'sectorgroup_industry_deposition_space_growth_only_exceeding_per_n2000', query);

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_sectorgroup_desire_per_n2000
 * ----------------------------------------------------
 * Genereert een CSV met overzichten van ontwikkelingsbehoefte per jaar en N2000 gebied.
 * De getallen worden gegeven voor de sectorgroepen als totaal, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_sectorgroup_desire_per_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for total & average economic desire of the sectorgroups per N2000...';

	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			SUM(total_desire_agriculture) AS total_desire_agriculture,
			ae_weighted_avg(total_desire_agriculture::numeric, weight::numeric)::real AS avg_desire_agriculture,

			SUM(total_desire_industry) AS total_desire_industry,
			ae_weighted_avg(total_desire_industry::numeric, weight::numeric)::real AS avg_desire_industry,

			SUM(total_desire_shipping) AS total_desire_shipping,
			ae_weighted_avg(total_desire_shipping::numeric, weight::numeric)::real AS avg_desire_shipping,

			SUM(total_desire_road_transportation) AS total_desire_road_transportation,
			ae_weighted_avg(total_desire_road_transportation::numeric, weight::numeric)::real AS avg_desire_road_transportation,

			SUM(total_desire_road_freeway) AS total_desire_road_freeway,
			ae_weighted_avg(total_desire_road_freeway::numeric, weight::numeric)::real AS avg_desire_road_freeway,

			SUM(total_desire_other) AS total_desire_other,
			ae_weighted_avg(total_desire_other::numeric, weight::numeric)::real AS avg_desire_other

			FROM (SELECT year, receptor_id, SUM(priority_projects_desire + other_desire) AS total_desire_agriculture FROM sector_economic_desires INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'agriculture' GROUP BY year, receptor_id) AS total_desires_agriculture
				INNER JOIN (SELECT year, receptor_id, SUM(priority_projects_desire + other_desire) AS total_desire_industry FROM sector_economic_desires INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'industry' GROUP BY year, receptor_id) AS total_desires_industry USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(priority_projects_desire + other_desire) AS total_desire_shipping FROM sector_economic_desires INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'shipping' GROUP BY year, receptor_id) AS total_desires_shipping USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(priority_projects_desire + other_desire) AS total_desire_road_transportation FROM sector_economic_desires INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'road_transportation' GROUP BY year, receptor_id) AS total_desires_road_transportation USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(priority_projects_desire + other_desire) AS total_desire_road_freeway FROM sector_economic_desires INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'road_freeway' GROUP BY year, receptor_id) AS total_desires_road_freeway USING (year, receptor_id)
				INNER JOIN (SELECT year, receptor_id, SUM(priority_projects_desire + other_desire) AS total_desire_other FROM sector_economic_desires INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'other' GROUP BY year, receptor_id) AS total_desires_other USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'sectorgroup_desire_per_n2000', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_deposition_tables
 * -----------------------------------------
 * Genereert een CSV met overzichten van de jaren, stoffen en sectoren waar depositie voor is, en in welke tabellen deze te vinden zijn.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_deposition_tables(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary of deposition tables (per sector, year and substance)...';

	query := $$
		SELECT
			gcn_sector_id,
			description,
			year,
			substance_id,
			tablename

			FROM
				(SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_no_policies_agriculture
					UNION
					SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_no_policies_industry
					UNION
					SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_no_policies_other
					UNION
					SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_no_policies_road_freeway
					UNION
					SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_no_policies_road_transportation
					UNION
					SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_no_policies_shipping
					UNION
					SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_global_policies
					UNION
					SELECT DISTINCT gcn_sector_id, year, substance_id, tableoid::regclass AS tablename FROM setup.gcn_sector_depositions_jurisdiction_policies
				) AS tablenames

				LEFT JOIN gcn_sectors USING (gcn_sector_id)

			ORDER BY tablename, gcn_sector_id, year, substance_id
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'deposition_tables', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_sectorgroup_deposition_per_n2000
 * --------------------------------------------------------
 * Genereert een CSV met overzichten van de depositie per jaar en N2000 gebied.
 * De getallen worden gegeven voor de sectorgroepen als maximum, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * Er wordt ook een CSV gemaakt van de sectorgroep 'farm' verder uitgespecificeerd per sector.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
 CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_sectorgroup_deposition_per_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
	v_policy_type text;
BEGIN

	FOR v_policy_type IN
		SELECT unnest(enum_range(null::policy_type)) AS policy_type ORDER BY policy_type
	LOOP
		RAISE NOTICE 'Creating summary for the deposition (%) of the sectorgroups per N2000...', v_policy_type;
		query := $$
			SELECT
				year,
				assessment_area_id AS natura2000_id,
				natura2000_areas.name AS natura2000_name,

				SUM(surface) AS total_habitat_surface,

				MAX(total_deposition_agriculture) AS max_deposition_agriculture,
				ae_weighted_avg(total_deposition_agriculture::numeric, weight::numeric)::real AS avg_deposition_agriculture,

				MAX(total_deposition_industry) AS max_deposition_industry,
				ae_weighted_avg(total_deposition_industry::numeric, weight::numeric)::real AS avg_deposition_industry,

				MAX(total_deposition_shipping) AS max_deposition_shipping,
				ae_weighted_avg(total_deposition_shipping::numeric, weight::numeric)::real AS avg_deposition_shipping,

				MAX(total_deposition_road_transportation) AS max_deposition_road_transportation,
				ae_weighted_avg(total_deposition_road_transportation::numeric, weight::numeric)::real AS avg_deposition_road_transportation,

				MAX(total_deposition_road_freeway) AS max_deposition_road_freeway,
				ae_weighted_avg(total_deposition_road_freeway::numeric, weight::numeric)::real AS avg_deposition_road_freeway,

				MAX(total_deposition_other) AS max_deposition_other,
				ae_weighted_avg(total_deposition_other::numeric, weight::numeric)::real AS avg_deposition_other

				FROM (SELECT year, receptor_id, SUM(GREATEST(deposition, 0)) AS total_deposition_agriculture FROM sector_depositions_$$ || v_policy_type || $$ INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'agriculture' GROUP BY year, receptor_id) AS total_depositions_agriculture
					INNER JOIN (SELECT year, receptor_id, SUM(GREATEST(deposition, 0)) AS total_deposition_industry FROM sector_depositions_$$ || v_policy_type || $$ INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'industry' GROUP BY year, receptor_id) AS total_depositions_industry USING (year, receptor_id)
					INNER JOIN (SELECT year, receptor_id, SUM(GREATEST(deposition, 0)) AS total_deposition_shipping FROM sector_depositions_$$ || v_policy_type || $$ INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'shipping' GROUP BY year, receptor_id) AS total_depositions_shipping USING (year, receptor_id)
					INNER JOIN (SELECT year, receptor_id, SUM(GREATEST(deposition, 0)) AS total_deposition_road_transportation FROM sector_depositions_$$ || v_policy_type || $$ INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'road_transportation' GROUP BY year, receptor_id) AS total_depositions_road_transportation USING (year, receptor_id)
					INNER JOIN (SELECT year, receptor_id, SUM(GREATEST(deposition, 0)) AS total_deposition_road_freeway FROM sector_depositions_$$ || v_policy_type || $$ INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'road_freeway' GROUP BY year, receptor_id) AS total_depositions_road_freeway USING (year, receptor_id)
					INNER JOIN (SELECT year, receptor_id, SUM(GREATEST(deposition, 0)) AS total_deposition_other FROM sector_depositions_$$ || v_policy_type || $$ INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'other' GROUP BY year, receptor_id) AS total_depositions_other USING (year, receptor_id)

					INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
					INNER JOIN natura2000_areas USING (assessment_area_id)

				GROUP BY year, assessment_area_id, natura2000_name

				ORDER BY year, assessment_area_id, natura2000_name
		$$;

		PERFORM setup.ae_write_summary_table(filespec, 'sectorgroup_deposition_' || v_policy_type || '_per_n2000', query);

		RAISE NOTICE 'Creating summary for the deposition (%) of the sectors in sectorgroup farm per N2000...', v_policy_type;
		query := $$
			SELECT
				year,
				assessment_area_id AS natura2000_id,
				natura2000_areas.name AS natura2000_name,

				SUM(surface) AS total_habitat_surface,

				MAX(total_deposition_agriculture) AS max_deposition_agriculture,
				ae_weighted_avg(total_deposition_agriculture::numeric, weight::numeric)::real AS avg_deposition_agriculture,

				MAX(depositions_agriculture_lodging.deposition) AS max_deposition_4110_lodging,
				ae_weighted_avg(COALESCE(depositions_agriculture_lodging.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_4110_lodging,

				MAX(depositions_agriculture_fertilizer_storage.deposition) AS max_deposition_4120_fertilizer_storage,
				ae_weighted_avg(COALESCE(depositions_agriculture_fertilizer_storage.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_4120_fertilizer_storage,

				MAX(depositions_agriculture_grazing.deposition) AS max_deposition_4130_grazing,
				ae_weighted_avg(COALESCE(depositions_agriculture_grazing.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_4130_grazing,

				MAX(depositions_agriculture_fertilizer_use.deposition) AS max_deposition_4140_fertilizer_use,
				ae_weighted_avg(COALESCE(depositions_agriculture_fertilizer_use.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_4140_fertilizer_use,

				MAX(depositions_agriculture_greenhouse.deposition) AS max_deposition_4320_greenhouse,
				ae_weighted_avg(COALESCE(depositions_agriculture_greenhouse.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_4320_greenhouse,

				MAX(depositions_agriculture_other.deposition) AS max_deposition_4600_other,
				ae_weighted_avg(COALESCE(depositions_agriculture_other.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_4600_other

				FROM (SELECT year, receptor_id, SUM(GREATEST(deposition, 0)) AS total_deposition_agriculture FROM sector_depositions_$$ || v_policy_type || $$ INNER JOIN setup.sectors_sectorgroup USING (sector_id) WHERE sectorgroup = 'agriculture' GROUP BY year, receptor_id) AS total_depositions_agriculture
					LEFT JOIN (SELECT year, receptor_id, GREATEST(deposition, 0) AS deposition FROM sector_depositions_$$ || v_policy_type || $$ WHERE sector_id = 4110) AS depositions_agriculture_lodging USING (year, receptor_id)
					LEFT JOIN (SELECT year, receptor_id, GREATEST(deposition, 0) AS deposition FROM sector_depositions_$$ || v_policy_type || $$ WHERE sector_id = 4120) AS depositions_agriculture_fertilizer_storage USING (year, receptor_id)
					LEFT JOIN (SELECT year, receptor_id, GREATEST(deposition, 0) AS deposition FROM sector_depositions_$$ || v_policy_type || $$ WHERE sector_id = 4130) AS depositions_agriculture_grazing USING (year, receptor_id)
					LEFT JOIN (SELECT year, receptor_id, GREATEST(deposition, 0) AS deposition FROM sector_depositions_$$ || v_policy_type || $$ WHERE sector_id = 4140) AS depositions_agriculture_fertilizer_use USING (year, receptor_id)
					LEFT JOIN (SELECT year, receptor_id, GREATEST(deposition, 0) AS deposition FROM sector_depositions_$$ || v_policy_type || $$ WHERE sector_id = 4320) AS depositions_agriculture_greenhouse USING (year, receptor_id)
					LEFT JOIN (SELECT year, receptor_id, GREATEST(deposition, 0) AS deposition FROM sector_depositions_$$ || v_policy_type || $$ WHERE sector_id = 4600) AS depositions_agriculture_other USING (year, receptor_id)

					INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
					INNER JOIN natura2000_areas USING (assessment_area_id)

				GROUP BY year, assessment_area_id, natura2000_name

				ORDER BY year, assessment_area_id, natura2000_name
		$$;

		PERFORM setup.ae_write_summary_table(filespec, 'sectorgroup_agriculture_deposition_' || v_policy_type || '_per_n2000', query);

	END LOOP;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_deposition_per_n2000
 * --------------------------------------------
 * Genereert een CSV met overzichten van de depositie per jaar en N2000 gebied.
 * De getallen worden gegeven voor de sectorgroepen als maximum, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * Er wordt ook een CSV gemaakt van de sectorgroep 'farm' verder uitgespecificeerd per sector.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_deposition_per_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for the total deposition per N2000...';
	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			MAX(no_policies.deposition) AS max_total_deposition_no_policies,
			ae_weighted_avg(no_policies.deposition::numeric, weight::numeric)::real AS avg_total_deposition_no_policies,

			MAX(global_policies.deposition) AS max_total_deposition_global_policies,
			ae_weighted_avg(global_policies.deposition::numeric, weight::numeric)::real AS avg_total_deposition_global_policies,

			MAX(jurisdiction_policies.deposition) AS max_total_deposition_jurisdiction_policies,
			ae_weighted_avg(jurisdiction_policies.deposition::numeric, weight::numeric)::real AS avg_total_deposition_jurisdiction_policies

			FROM depositions_no_policies AS no_policies
				INNER JOIN depositions_global_policies AS global_policies USING (year, receptor_id)
				INNER JOIN depositions_jurisdiction_policies AS jurisdiction_policies USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'total_deposition_per_n2000', query);

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_deposition_per_n2000_habitat
 * ----------------------------------------------------
 * Genereert een CSV met overzichten van de depositie per jaar, N2000 gebied en habitat type.
 * De getallen worden gegeven voor de sectorgroepen als maximum, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * Er wordt ook een CSV gemaakt van de sectorgroep 'farm' verder uitgespecificeerd per sector.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_deposition_per_n2000_habitat(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN

	RAISE NOTICE 'Creating summary for the total deposition per N2000 and habitat type...';
	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			habitat_type_id,
			habitat_types.name AS habitat_type_name,

			SUM(surface) AS total_habitat_surface,

			MAX(no_policies.deposition) AS max_total_deposition_no_policies,
			ae_weighted_avg(no_policies.deposition::numeric, weight::numeric)::real AS avg_total_deposition_no_policies,

			MAX(global_policies.deposition) AS max_total_deposition_global_policies,
			ae_weighted_avg(global_policies.deposition::numeric, weight::numeric)::real AS avg_total_deposition_global_policies,

			MAX(jurisdiction_policies.deposition) AS max_total_deposition_jurisdiction_policies,
			ae_weighted_avg(jurisdiction_policies.deposition::numeric, weight::numeric)::real AS avg_total_deposition_jurisdiction_policies

			FROM depositions_no_policies AS no_policies
				INNER JOIN depositions_global_policies AS global_policies USING (year, receptor_id)
				INNER JOIN depositions_jurisdiction_policies AS jurisdiction_policies USING (year, receptor_id)

				INNER JOIN receptors_to_relevant_habitats_view USING (receptor_id)
				INNER JOIN habitat_types USING (habitat_type_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name, habitat_type_id, habitat_types.name

			ORDER BY year, assessment_area_id, natura2000_name, habitat_type_id, habitat_types.name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'total_deposition_per_n2000_habitat', query);

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_other_deposition_per_n2000
 * --------------------------------------------------
 * Genereert een CSV met overzichten van de depositiebijdrage die niet aan een sector is toe te kennen, per jaar en N2000 gebied.
 * Deze deposties zijn opgedeeld in types en worden gegeven als maximum, en als gewogen gemiddelde op oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_other_deposition_per_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for the other-deposition per N2000...';
	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			MAX(total_deposition) AS max_other_deposition,
			ae_weighted_avg(total_deposition::numeric, weight::numeric)::real AS avg_other_deposition,

			MAX(depositions_abroad.deposition) AS max_abroad_deposition,
			ae_weighted_avg(COALESCE(depositions_abroad.deposition, 0)::numeric, weight::numeric)::real AS avg_abroad_deposition,

			MAX(depositions_remaining.deposition) AS max_remaining_deposition,
			ae_weighted_avg(COALESCE(depositions_remaining.deposition, 0)::numeric, weight::numeric)::real AS avg_remaining_deposition,

			MAX(corrections_measurement.deposition) AS max_measurement_correction,
			ae_weighted_avg(COALESCE(corrections_measurement.deposition, 0)::numeric, weight::numeric)::real AS avg_measurement_correction,

			MAX(corrections_dune_area.deposition) AS max_dune_area_correction,
			ae_weighted_avg(COALESCE(corrections_dune_area.deposition, 0)::numeric, weight::numeric)::real AS avg_dune_area_correction,

			MAX(returned_deposition_space.deposition) AS max_returned_deposition_space,
			ae_weighted_avg(COALESCE(returned_deposition_space.deposition, 0)::numeric, weight::numeric)::real AS avg_returned_deposition_space,

			MAX(returned_deposition_space_limburg.deposition) AS max_returned_deposition_space_limburg,
			ae_weighted_avg(COALESCE(returned_deposition_space_limburg.deposition, 0)::numeric, weight::numeric)::real AS avg_returned_deposition_space_limburg,

			MAX(deposition_space_addition.deposition) AS max_deposition_space_addition,
			ae_weighted_avg(COALESCE(deposition_space_addition.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_space_addition

			FROM (SELECT year, receptor_id, SUM(COALESCE(deposition, 0)) AS total_deposition FROM other_depositions GROUP BY year, receptor_id) AS total_other_depositions
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'abroad_deposition') AS depositions_abroad USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'remaining_deposition') AS depositions_remaining USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'measurement_correction') AS corrections_measurement USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'dune_area_correction') AS corrections_dune_area USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'returned_deposition_space') AS returned_deposition_space USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'returned_deposition_space_limburg') AS returned_deposition_space_limburg USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'deposition_space_addition') AS deposition_space_addition USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;


	PERFORM setup.ae_write_summary_table(filespec, 'other_deposition_per_n2000', query);


	RAISE NOTICE 'Creating summary for the other-deposition (only exceeding) per N2000...';
	query := $$
		SELECT
			year,
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,

			SUM(surface) AS total_habitat_surface,

			MAX(total_deposition) AS max_other_deposition,
			ae_weighted_avg(total_deposition::numeric, weight::numeric)::real AS avg_other_deposition,

			MAX(depositions_abroad.deposition) AS max_abroad_deposition,
			ae_weighted_avg(COALESCE(depositions_abroad.deposition, 0)::numeric, weight::numeric)::real AS avg_abroad_deposition,

			MAX(depositions_remaining.deposition) AS max_remaining_deposition,
			ae_weighted_avg(COALESCE(depositions_remaining.deposition, 0)::numeric, weight::numeric)::real AS avg_remaining_deposition,

			MAX(corrections_measurement.deposition) AS max_measurement_correction,
			ae_weighted_avg(COALESCE(corrections_measurement.deposition, 0)::numeric, weight::numeric)::real AS avg_measurement_correction,

			MAX(corrections_dune_area.deposition) AS max_dune_area_correction,
			ae_weighted_avg(COALESCE(corrections_dune_area.deposition, 0)::numeric, weight::numeric)::real AS avg_dune_area_correction,

			MAX(returned_deposition_space.deposition) AS max_returned_deposition_space,
			ae_weighted_avg(COALESCE(returned_deposition_space.deposition, 0)::numeric, weight::numeric)::real AS avg_returned_deposition_space,

			MAX(returned_deposition_space_limburg.deposition) AS max_returned_deposition_space_limburg,
			ae_weighted_avg(COALESCE(returned_deposition_space_limburg.deposition, 0)::numeric, weight::numeric)::real AS avg_returned_deposition_space_limburg,

			MAX(deposition_space_addition.deposition) AS max_deposition_space_addition,
			ae_weighted_avg(COALESCE(deposition_space_addition.deposition, 0)::numeric, weight::numeric)::real AS avg_deposition_space_addition

			FROM (SELECT year, receptor_id, SUM(COALESCE(deposition, 0)) AS total_deposition FROM other_depositions GROUP BY year, receptor_id) AS total_other_depositions
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'abroad_deposition') AS depositions_abroad USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'remaining_deposition') AS depositions_remaining USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'measurement_correction') AS corrections_measurement USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'dune_area_correction') AS corrections_dune_area USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'returned_deposition_space') AS returned_deposition_space USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'returned_deposition_space_limburg') AS returned_deposition_space_limburg USING (year, receptor_id)
				LEFT JOIN (SELECT year, receptor_id, COALESCE(deposition, 0) AS deposition FROM other_depositions WHERE other_deposition_type = 'deposition_space_addition') AS deposition_space_addition USING (year, receptor_id)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN relevant_development_space_exceeding_receptors_view USING (receptor_id, year)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY year, assessment_area_id, natura2000_name

			ORDER BY year, assessment_area_id, natura2000_name
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'other_deposition_only_exceeding_per_n2000', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_deposition_increase_per_n2000
 * -----------------------------------------------------
 * Genereert een CSV met overzichten van de depositietoename per N2000 gebied.
 * Het gaat om de toename tussen 2014 -> 2020, en 2014 -> 2030, provinciaal beleid.
 * De telling van receptoren met toename gaat uit van unieke receptoren. Daarnaast is er ook de som van de oppervlakte van die receptoren.
 * De minimale en maximale depositietoename wordt teruggegeven en tevens de gemiddelde depositietoename, gewogen naar oppervlakte.
 * De gebruikte oppervlakte van het N2000 gebied is de overlap tussen dat gebied en de KDW-gebieden die er in liggen,
 * waarvan de KDW < 2400.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_deposition_increase_per_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for the total deposition increase per N2000...';
	query := $$
		SELECT
			assessment_area_id AS natura2000_id,
			natura2000_areas.name AS natura2000_name,
			SUM(surface) AS total_habitat_surface,

			base_year,
			reference_year,

			COUNT(DISTINCT (CASE WHEN does_increase THEN receptor_id ELSE NULL END)) AS num_increase,
			SUM(CASE WHEN does_increase THEN surface ELSE 0 END) AS surface_increase,
			MIN(deposition_increase) AS min_deposition_increase,
			MAX(deposition_increase) AS max_deposition_increase,
			ae_weighted_avg(deposition_increase::numeric, weight::numeric)::real AS avg_deposition_increase

			FROM
				(SELECT
					base_years.year AS base_year,
					reference_years.year AS reference_year,
					receptor_id,
					(jurisdiction_policies_reference.deposition - jurisdiction_policies_base.deposition > 0) AS does_increase,
					NULLIF(GREATEST(jurisdiction_policies_reference.deposition - jurisdiction_policies_base.deposition, 0), 0) AS deposition_increase

					FROM depositions_jurisdiction_policies AS jurisdiction_policies_base
						INNER JOIN depositions_jurisdiction_policies AS jurisdiction_policies_reference USING (receptor_id)
						INNER JOIN years AS base_years ON (jurisdiction_policies_base.year = base_years.year)
						INNER JOIN years AS reference_years ON (jurisdiction_policies_reference.year = reference_years.year)

					WHERE
						base_years.year_category = 'base'
						AND reference_years.year_category IN ('last', 'future')
				) AS increases

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN natura2000_areas USING (assessment_area_id)

			GROUP BY assessment_area_id, natura2000_name, base_year, reference_year

			ORDER BY assessment_area_id, natura2000_name, base_year, reference_year
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'total_deposition_increase_per_n2000', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_deposition_increase_per_receptor_n2000
 * --------------------------------------------------------------
 * Genereert een CSV met depositietoename per receptor en N2000 gebied.
 * Alleen receptoren met een toename tussen 2014 -> 2020, of 2014 -> 2030, worden teruggegeven (provinciaal beleid).
 * De x en y van de receptor wordt ook teruggegeven. Een receptor kan vaker onder elkaar voorkomen indien deze meerdere natuurgebieden raakt.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_deposition_increase_per_receptor_n2000(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for the total deposition increase per receptor and N2000...';
	query := $$
		SELECT
			receptor_id,
			ROUND(ST_X(receptors.geometry))::integer AS x,
			ROUND(ST_Y(receptors.geometry))::integer AS y,
			assessment_area_id AS natura2000_id,

			base_years.year AS base_year,
			reference_years.year AS reference_year,
			GREATEST(jurisdiction_policies_reference.deposition - jurisdiction_policies_base.deposition, 0) AS deposition_increase_reference

			FROM depositions_jurisdiction_policies AS jurisdiction_policies_base
				INNER JOIN depositions_jurisdiction_policies AS jurisdiction_policies_reference USING (receptor_id)
				INNER JOIN years AS base_years ON (jurisdiction_policies_base.year = base_years.year)
				INNER JOIN years AS reference_years ON (jurisdiction_policies_reference.year = reference_years.year)

				INNER JOIN receptors_to_assessment_areas_on_relevant_habitat_view USING (receptor_id)
				INNER JOIN receptors USING (receptor_id)

			WHERE
				base_years.year_category = 'base'
				AND reference_years.year_category IN ('last', 'future')
				AND jurisdiction_policies_reference.deposition - jurisdiction_policies_base.deposition > 0

			ORDER BY receptor_id, assessment_area_id, base_year, reference_year
	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'total_deposition_increase_per_receptor_n2000', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_relevant_data_increase_per_receptor
 * -----------------------------------------------------------
 * Genereert een CSV met de depositietoename, de depositieruimte en de behoefte per receptor.
 * Alleen receptoren in relevante delen van habitats worden teruggegeven, waarbij er een toename tussen 2014 -> 2020, of 2014 -> 2030 (provinciaal beleid) is
 * en de KDW wordt overschreden.
 *
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_relevant_data_increase_per_receptor(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN

	CREATE TEMPORARY TABLE tmp_base_data ON COMMIT DROP AS
	SELECT
		year AS base_year,
		receptor_id,
		deposition AS deposition_base

		FROM depositions_jurisdiction_policies
			INNER JOIN included_receptors USING (receptor_id)
			INNER JOIN years USING (year)

		WHERE year_category = 'base'
	;

	ALTER TABLE tmp_base_data ADD PRIMARY KEY (receptor_id, base_year);


	CREATE TEMPORARY TABLE tmp_total_sector_economic_desires ON COMMIT DROP AS
	SELECT
		year,
		receptor_id,
		SUM(priority_projects_desire) AS priority_projects_desire,
		SUM(other_desire) AS other_desire
		
		FROM sector_economic_desires
		
		GROUP BY year, receptor_id
	;

	ALTER TABLE tmp_total_sector_economic_desires ADD PRIMARY KEY (receptor_id, year);


	CREATE TEMPORARY TABLE tmp_deposition_spaces_divided ON COMMIT DROP AS
	SELECT * FROM deposition_spaces_divided_view;

	ALTER TABLE tmp_deposition_spaces_divided ADD PRIMARY KEY (receptor_id, year);


	CREATE TEMPORARY TABLE tmp_future_data ON COMMIT DROP AS
	SELECT
		year AS future_year,
		receptor_id,

		deposition AS deposition_future,

		priority_projects_desire,
		other_desire,
		(priority_projects_desire + other_desire) AS total_desire,

		no_permit_required AS no_permit_required_space,
		permit_threshold AS permit_threshold_space,
		priority_projects AS priority_projects_space,
		projects AS projects_space,
		(no_permit_required + permit_threshold + priority_projects + projects) AS total_space

		FROM depositions_jurisdiction_policies
			INNER JOIN included_receptors USING (receptor_id)
			INNER JOIN tmp_total_sector_economic_desires USING (year, receptor_id)
			INNER JOIN tmp_deposition_spaces_divided USING (year, receptor_id)
			INNER JOIN years USING (year)

		WHERE year_category = 'future'
	;

	ALTER TABLE tmp_future_data ADD PRIMARY KEY (receptor_id, future_year);


	RAISE NOTICE 'Creating summary for the relevant receptors where total deposition increases, and exceeds CDV...';
	query := $$
		SELECT
			base_year,
			future_year,
			receptor_id,

			ROUND(ST_X(receptors.geometry)) || ', ' || ROUND(ST_Y(receptors.geometry)) AS location,
			assessment_areas,
			critical_deposition,

			deposition_base,
			deposition_future,
			GREATEST(deposition_future - deposition_base, 0) AS deposition_increase,
			GREATEST(deposition_future - critical_deposition, 0) AS critical_deposition_exceeding,

			total_desire,
			priority_projects_desire,
			other_desire,

			total_space,
			no_permit_required_space,
			permit_threshold_space,
			priority_projects_space,
			projects_space,

			GREATEST(total_desire - total_space, 0) AS shortage_space

			FROM tmp_base_data
				INNER JOIN tmp_future_data USING (receptor_id)
				INNER JOIN receptors USING (receptor_id)
				INNER JOIN (SELECT receptor_id, array_to_string(array_agg(assessment_area_id), ',') AS assessment_areas FROM receptors_to_assessment_areas INNER JOIN natura2000_areas USING (assessment_area_id) GROUP BY receptor_id) AS receptors_to_assessment_areas USING (receptor_id)
				INNER JOIN critical_depositions USING (receptor_id)

			WHERE
				((deposition_future > critical_deposition AND deposition_future - deposition_base > 0)
				OR (total_desire > total_space))

		ORDER BY base_year, future_year, receptor_id

	$$;

	PERFORM setup.ae_write_summary_table(filespec, 'relevant_data_increase_per_receptor', query);

	DROP TABLE tmp_base_data;
	DROP TABLE tmp_total_sector_economic_desires;
	DROP TABLE tmp_deposition_spaces_divided;
	DROP TABLE tmp_future_data;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_output_summary_table_analysis_per_sector
 * -------------------------------------------
 * Genereert een CSV met overzichten van de analysis tabellen.
 * @param filespec Pad en bestandsspecificatie zoals beschreven bij ae_output_summary_table().
 */
CREATE OR REPLACE FUNCTION setup.ae_output_summary_table_analysis_per_sector(filespec text)
	RETURNS void AS
$BODY$
DECLARE
	query text;
BEGIN
	RAISE NOTICE 'Creating summary for analysis tables...';

	-- sector_economic_growths_analysis
	query := $$ SELECT * FROM sectors INNER JOIN setup.sector_economic_growths_analysis USING (sector_id) ORDER BY year, sector_id $$;

	PERFORM setup.ae_write_summary_table(filespec, 'average_economic_growths_analysis_per_sector', query);

	-- sector_economic_desires_analysis
	query := $$ SELECT * FROM sectors INNER JOIN setup.sector_economic_desires_analysis USING (sector_id) ORDER BY year, sector_id, substance_id $$;

	PERFORM setup.ae_write_summary_table(filespec, 'average_economic_desires_analysis_per_sector', query);

	-- sector_depositions_no_policies_analysis
	query := $$ SELECT * FROM sectors INNER JOIN setup.sector_depositions_no_policies_analysis USING (sector_id) ORDER BY year, sector_id $$;

	PERFORM setup.ae_write_summary_table(filespec, 'average_depositions_no_policies_analysis_per_sector', query);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;



/*
 * ae_write_summary_table
 * ----------------------
 * Hulpfunctie om een queryresultaat weg te schrijven naar een CSV bestand met de juiste bestandsnaam.
 * @param filespec Pad en bestandsspecificatie zoals hierboven beschreven.
 * @param title Titel van de query voor in de bestandsnaam.
 * @param query De query.
 */
CREATE OR REPLACE FUNCTION setup.ae_write_summary_table(filespec text, title text, query text)
	RETURNS void AS
$BODY$
DECLARE
	filename text;
BEGIN
	filename := replace(filespec, '{datesuffix}', to_char(current_timestamp, 'YYYYMMDD'));
	filename := replace(filename, '{title}', 'summary_' || title);
	filename := '''' || filename || '''';

	EXECUTE $$ COPY ($$ || query || $$) TO $$ || filename || $$ CSV HEADER DELIMITER E';' $$;
END;
$BODY$

LANGUAGE plpgsql VOLATILE;