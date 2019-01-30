/*
 * ae_build_reserved_development_spaces
 * ------------------------------------
 * Build/export functie voor de reserved development space (zoals opgenomen moet worden in Register).
 *
 * De Segment 2 ruimte (exclusief stopperruimte en ophoging) wordt beperkt tot 60% van de totale Segment 2 ruimte zoals Monitor die voor de eerste PAS-periode berekent heeft.
 * De stoppersruimte wordt (voor zowel de grenswaarde reservering als segment 2) voor 60% toegevoegd aan de depositieruimte en verdeelt (via setup.sector_deposition_space_segmentations) over de GWR en Segment 2.
 *
 * Deze functie verwerkt als laatste stap de OR-waarde overrides.
 * De OR-relevantie wordt al eerder (deposition_spaces_divided_view) meegenomen in Monitor.
 */
CREATE OR REPLACE FUNCTION setup.ae_build_reserved_development_spaces(v_year year_type = '2020')
	RETURNS TABLE(segment segment_type, receptor_id integer, space posreal) AS
$BODY$
DECLARE
	v_projects_development_space_limiter posreal = '0.60';
	v_growth_corrections_agriculture_development_space_limiter posreal = '0.60';
	v_space_addition_limiter posreal = '1.00';
BEGIN

	--
	-- Bepaal de reserved_development_space
	-- 
	CREATE TEMPORARY TABLE tmp_reserved_development_spaces (
		receptor_id integer NOT NULL,
		no_permit_required posreal NOT NULL,
		permit_threshold posreal NOT NULL,
		priority_projects posreal NOT NULL,
		projects posreal NOT NULL,

		CONSTRAINT tmp_reserved_development_spaces_pkey PRIMARY KEY (receptor_id)
	) ON COMMIT DROP;


	INSERT INTO tmp_reserved_development_spaces (receptor_id, no_permit_required, permit_threshold, priority_projects, projects)
		SELECT spaces.receptor_id, spaces.no_permit_required, spaces.permit_threshold, spaces.priority_projects, spaces.projects
			FROM deposition_spaces_divided AS spaces
				INNER JOIN included_receptors USING (receptor_id)
		WHERE year = v_year
	;



	--
	-- Haal de ophoging van de reserved_development_space
	--
	CREATE TEMPORARY TABLE tmp_space_addition (
		receptor_id integer NOT NULL,
		projects_space_addition posreal NOT NULL,

		CONSTRAINT tmp_space_addition_pkey PRIMARY KEY (receptor_id)
	) ON COMMIT DROP;

	-- Bepaal het deel van de ophoging die in s2 zit
	INSERT INTO tmp_space_addition (receptor_id, projects_space_addition)
	SELECT
		additions.receptor_id,
		LEAST(total_space_addition * v_space_addition_limiter, projects) AS projects_space_addition
		
		FROM setup.deposition_spaces AS additions
			INNER JOIN tmp_reserved_development_spaces USING (receptor_id)
			INNER JOIN non_exceeding_receptors_view USING (receptor_id)
		
		WHERE year = v_year
	
	;

	-- Haal het deel van de ophoging die in s2 zit van de reserved_development_space s2
	UPDATE tmp_reserved_development_spaces AS reserved
		
		SET projects = reserved.projects - tmp_space_addition.projects_space_addition
		
		FROM tmp_space_addition
		
		WHERE reserved.receptor_id = tmp_space_addition.receptor_id
	;



	--
	-- Haal de stopperruimte van de reserved_development_space
	--
	CREATE TEMPORARY TABLE tmp_growth_corrections_agriculture (
		receptor_id integer NOT NULL,
		projects_growth_correction posreal NOT NULL,
		permit_threshold_growth_correction posreal NOT NULL,


		CONSTRAINT tmp_growth_corrections_agriculture_pkey PRIMARY KEY (receptor_id)
	) ON COMMIT DROP;

	-- Bepaal de (gesegmenteerde) stopperruimte en de huidige reservering (dus de reservering na aftrek ophoging s2)
	INSERT INTO tmp_growth_corrections_agriculture (receptor_id, projects_growth_correction, permit_threshold_growth_correction)
	SELECT
		reserved.receptor_id,
		LEAST(projects_growth_correction, projects) AS projects_growth_correction,
		LEAST(permit_threshold_growth_correction, permit_threshold) AS permit_threshold_growth_correction

		FROM
			(SELECT
				corrections.receptor_id,
				SUM(correction * projects_size) AS projects_growth_correction,
				SUM(correction * permit_threshold_size) AS permit_threshold_growth_correction  

				FROM
					(SELECT
						corrections.receptor_id,
						gcn_sectors.sector_id,
						SUM(correction) AS correction
						
						FROM setup.gcn_sector_economic_growth_corrections AS corrections
							INNER JOIN gcn_sectors USING (gcn_sector_id)
							
						WHERE
							gcn_sector_id = 4110
							AND year = v_year

						GROUP BY corrections.receptor_id, gcn_sectors.sector_id

					) AS corrections

					INNER JOIN setup.sector_deposition_space_segmentations USING (sector_id)
				
				GROUP BY corrections.receptor_id
			) AS segmented_corrections

		INNER JOIN tmp_reserved_development_spaces AS reserved USING (receptor_id)
	;

	-- Haal de stoppersruimte (deels) van de reserved_development_space. Er mag geen negatieve ruimte ontstaan!
	UPDATE tmp_reserved_development_spaces AS reserved
		SET
			permit_threshold = reserved.permit_threshold - corrections.permit_threshold_growth_correction,
			projects = reserved.projects - corrections.projects_growth_correction
		
		FROM tmp_growth_corrections_agriculture AS corrections

		WHERE reserved.receptor_id = corrections.receptor_id
	;



	--
	-- Limiteer Segment 2 (exclusief stopperruimte) op 60% van de berekende reserved_development_spaces.
	--
	UPDATE tmp_reserved_development_spaces
		SET projects = projects * v_projects_development_space_limiter
	;



	--
	-- Voeg 60% van de stoppersruimte weer toe aan de reserved_development_space.
	-- We mogen nooit meer stoppersruimte toevoegen dan we er in eerste instantie af hebben gehaald.
	--
	UPDATE tmp_reserved_development_spaces AS reserved
		SET
			permit_threshold = reserved.permit_threshold + (corrections.permit_threshold_growth_correction * v_growth_corrections_agriculture_development_space_limiter),
			projects = reserved.projects + (corrections.projects_growth_correction * v_growth_corrections_agriculture_development_space_limiter)
		
		FROM tmp_growth_corrections_agriculture AS corrections

		WHERE reserved.receptor_id = corrections.receptor_id
	;



	--
	-- Voeg de ophoging weer toe aan de reserved_development_space
	--
	UPDATE tmp_reserved_development_spaces AS reserved
		SET projects = reserved.projects + tmp_space_addition.projects_space_addition
		
		FROM tmp_space_addition
		
		WHERE reserved.receptor_id = tmp_space_addition.receptor_id
	;



	--
	-- Verwerk de override
	--
	UPDATE tmp_reserved_development_spaces AS reserved
		SET priority_projects = value
		
		FROM override_development_space_values AS override_values
		
		WHERE
			override_values.segment = 'priority_projects'
			AND override_values.receptor_id = reserved.receptor_id
			AND override_values.year = v_year
	;

	UPDATE tmp_reserved_development_spaces AS reserved
		SET projects = value
		
		FROM override_development_space_values AS override_values
		
		WHERE
			override_values.segment = 'projects'
			AND override_values.receptor_id = reserved.receptor_id
			AND override_values.year = v_year
	;

	UPDATE tmp_reserved_development_spaces AS reserved
		SET permit_threshold = value
		
		FROM override_development_space_values AS override_values
		
		WHERE
			override_values.segment = 'permit_threshold'
			AND override_values.receptor_id = reserved.receptor_id
			AND override_values.year = v_year
	;

	DELETE FROM tmp_reserved_development_spaces AS reserved
		WHERE reserved.receptor_id IN 
			(SELECT DISTINCT override.receptor_id 
					FROM override_relevant_development_space_receptors AS override
					WHERE relevant IS FALSE
			);

	--
	-- Transformeer en retourneer de temp tabel 
	--
	RETURN QUERY 
		(SELECT
			'priority_projects'::segment_type AS segment,
			reserved.receptor_id,
			priority_projects AS space
					
			FROM tmp_reserved_development_spaces As reserved

		UNION ALL
		SELECT
			'projects'::segment_type AS segment,
			reserved.receptor_id,
			projects AS space
			
			FROM tmp_reserved_development_spaces As reserved

		UNION ALL
		SELECT
			'permit_threshold'::segment_type AS segment,
			reserved.receptor_id,
			permit_threshold AS space
			
			FROM tmp_reserved_development_spaces As reserved

		ORDER BY segment, receptor_id)
	;


	--
	-- Clean-up
	--
	DROP TABLE tmp_reserved_development_spaces;
	DROP TABLE tmp_space_addition;
	DROP TABLE tmp_growth_corrections_agriculture;

	RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;