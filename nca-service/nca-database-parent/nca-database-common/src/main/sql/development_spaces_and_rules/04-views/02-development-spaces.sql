/*
 * development_spaces_view
 * -----------------------
 * Retourneert de gebruikte ontwikkelingsruimte, zoals de toegekende en de benutte ruimte.
 * Voor de segmenten die hun initiele ruimte delen wordt (enkel voor de non-exceeding receptoren) ook het deel van het gedeelde segment opgeteld.
 *
 * Deze query gebruikt aggregatie om de waarde van het gedeelde segment er bij op te tellen, i.p.v. een selfjoin met development_spaces. Voordeel hiervan
 * is performance, maar ook dat de pending status niet verloren gaat bij het GWR segment (d.w.z. dat een GWR segment ook de pending space overneemt van het
 * S2 segment dat ermee gedeeld is).
 *
 * @column assigned De toegekende ruimte; alleen 'assigned' rekening houdend met de gedeelde ruimte.
 * @column utilized De benutte ruimte; som van 'assigned' en 'pending_with_space' rekening houdend met de gedeelde ruimte.
 * @column requested De aangevraagde ruimte; som van 'assigned', 'pending_with_space' en 'pending_without_space' rekening houdend met de gedeelde ruimte.
 * @column assigned_segment_space De toegekende ruimte binnen het segment.
 * @column utilized_segment_space De benutte ruimte binnen het segment.
 * @column requested_segment_space De aangevraagde ruimte binnen het segment.
 */
CREATE OR REPLACE VIEW development_spaces_view AS
SELECT
	shared_segment AS segment,
	receptor_id,

	SUM(CASE WHEN status = 'assigned' THEN space ELSE 0 END) AS assigned,
	SUM(CASE WHEN status <> 'pending_without_space' THEN space ELSE 0 END) AS utilized,
	SUM(space) AS requested,

	SUM(CASE WHEN segment = shared_segment AND status = 'assigned' THEN space ELSE 0 END) AS assigned_segment_space,
	SUM(CASE WHEN segment = shared_segment AND status <> 'pending_without_space' THEN space ELSE 0 END) AS utilized_segment_space,
	SUM(CASE WHEN segment = shared_segment THEN space ELSE 0 END) AS requested_segment_space

	FROM development_spaces
		LEFT JOIN non_exceeding_receptors USING (receptor_id)
		INNER JOIN (
			SELECT segment, segment AS shared_segment FROM unnest(enum_range(NULL::segment_type)) AS segment
			UNION ALL
			SELECT unnest(ARRAY['permit_threshold', 'projects'])::segment_type AS segment, unnest(ARRAY['projects', 'permit_threshold'])::segment_type AS shared_segment
		) AS segments USING (segment)

	WHERE (segment = shared_segment OR non_exceeding_receptors.receptor_id IS NOT NULL)

	GROUP BY shared_segment, receptor_id
;


/*
 * calc_initial_available_development_spaces_view
 * ----------------------------------------------
 * Retourneert de initieel te benutten ontwikkelingsruimte, rekening houdend met geleende ruimte en gedeelde segmenten.
 * Deze view verzorgt de vulling en updates van de tabel {@link initial_available_development_spaces}.
 *
 * Lees de beschrijving van {@link reserved_development_spaces} kolom `borrowed` voor een uitleg over geleende ruimte. Deze
 * view zorgt ervoor dat het de geleende ruimte nooit kan vrijkomen als algemeen beschikbare ruimte. Dit kan door het
 * bijstellen van de initieel te benutten ruimte, aangezien `available space = initial available space - utilized space`.
 *
 * Default is de initieel te benutten ruimte gelijk aan de gereserveerde ruimte minus de geleende ruimte. Met andere
 * woorden, alle niet-geleende ruimte kan benut worden.
 * Is er echter al meer benut dan dat, wat bij geleende ruimte praktisch altijd het geval zal zijn, dan wordt dit
 * getal teruggegeven als initieel te benutten ruimte. Op deze manier klopt bovenstaande sommetje altijd.
 *
 * Samengevat: Het "borrowed" gedeelte is een flexibel deel van de ruimte welke alleen meedoet als het al in gebruik is.
 *
 * In het geval van (niet-overbelaste) receptoren met gedeelde segmenten, vindt bovenstaande plaats op de optelling van beide
 * segmenten. Dit gebeurt middels een aggregatie i.p.v. een selfjoin vanwege een betere performance.
 *
 * @column space De initieel te benutten ruimte, rekening houdend met de geleende ruimte en gedeelde segmenten.
 *
 * @see reserved_development_spaces
 * @see initial_available_development_spaces
 */
CREATE OR REPLACE VIEW calc_initial_available_development_spaces_view AS
SELECT
	shared_segment AS segment,
	(array_agg(segment ORDER BY segment = shared_segment))[1] AS related_segment,
	receptor_id,
	GREATEST(SUM(space) - SUM(borrowed), SUM(utilized_segment_space)) AS space

	FROM reserved_development_spaces
		INNER JOIN development_spaces_view USING (segment, receptor_id)
		LEFT JOIN non_exceeding_receptors USING (receptor_id)
		INNER JOIN (
			SELECT segment, segment AS shared_segment FROM unnest(enum_range(NULL::segment_type)) AS segment
			UNION ALL
			SELECT unnest(ARRAY['permit_threshold', 'projects'])::segment_type AS segment, unnest(ARRAY['projects', 'permit_threshold'])::segment_type AS shared_segment
		) AS segments USING (segment)

	WHERE (segment = shared_segment OR non_exceeding_receptors.receptor_id IS NOT NULL)

	GROUP BY shared_segment, receptor_id
;


/*
 * available_development_spaces_view
 * ---------------------------------
 * Retourneert de (huidige) beschikbare ontwikkelingsruimte.
 * Van de initieel te benutten ontwikkelingsruimte wordt de reeds gebruikte ruimte afgetrokken.
 * Voor de segmenten die hun initiele ruimte delen wordt (enkel voor de non-exceeding receptoren) ook de reeds gebruikte ruimte van dat gedeelde segment afgetrokken.
 *
 * @column available_after_assigned De beschikbare ruimte na aftrek van de toegekende ruimte.
 * @column available_after_utilized De beschikbare ruimte na aftrek van de benutte ruimte.
 * @column available_after_requested De beschikbare ruimte na aftrek van de totale aangevraagde ruimte (dit is de toegekende ruimte, en de tijdelijk toegekende
 *   ruimte voor aanvragen die nog in behandeling zijn). De teruggeven waarde kan hier ook (bij een tekort) negatief zijn.
 *
 * @see development_spaces_view
 */
CREATE OR REPLACE VIEW available_development_spaces_view AS
SELECT
	segment,
	receptor_id,
	initial_available.space - assigned AS available_after_assigned,
	initial_available.space - utilized AS available_after_utilized,
	initial_available.space - requested AS available_after_requested

	FROM initial_available_development_spaces AS initial_available
		INNER JOIN development_spaces_view USING (segment, receptor_id)
;


/*
 * assessment_area_development_spaces_view
 * ---------------------------------------
 * Algemene ontwikkelingsruimte info voor een gebied.
 *
 * @column limiter_fraction De hoogste benutting (assigned + pending_with_space) als factor voor een receptor (de maatgevende receptor) in het gebied.
 * Voorbeeld: Als dit 0.7 is bij segment 'permit_threshold', dan is voor tenminste 1 receptor in het gebied 70% van de grenswaardereservering bereikt, en
 * dit is dan de hoogste in het gebied. Deze kan dan weer worden vergeleken met de constante PRONOUNCEMENT_SPACE_ALMOST_FULL_TRIGGER.
 * @column assigned_fraction_for_limiter_fraction De toekenning (alleen assigned) behorende de maatgevende receptor.
 *
 * Niet-PAS-gebieden worden weggefilterd zodat deze ondanks "grenshexagonen" toch niet worden getoond.
 */
CREATE OR REPLACE VIEW assessment_area_development_spaces_view AS
SELECT
	segment,
	assessment_area_id,
	assessment_areas.name AS assessment_area_name,
	MAX(utilized_limiter_fraction) AS limiter_fraction,
	(ae_max_with_key(assigned_limiter_fraction::numeric, utilized_limiter_fraction::numeric)).key AS assigned_fraction_for_limiter_fraction

	FROM
		(SELECT
			segment,
			assessment_area_id,
			receptor_id,
			COALESCE(assigned / NULLIF(initial_available.space, 0), 0) AS assigned_limiter_fraction,
			COALESCE(utilized / NULLIF(initial_available.space, 0), 0) AS utilized_limiter_fraction

			FROM receptors_to_assessment_areas
				INNER JOIN initial_available_development_spaces AS initial_available USING (receptor_id)
				INNER JOIN development_spaces_view USING (segment, receptor_id)
		) AS limiter_fractions

		INNER JOIN pas_assessment_areas USING (assessment_area_id)
		INNER JOIN assessment_areas USING (assessment_area_id)

	GROUP BY segment, assessment_area_id, assessment_areas.name
;


/*
 * assessment_area_development_spaces_permit_threshold_view
 * --------------------------------------------------------
 * Algemene grenswaardereservering info voor een gebied.
 * De view maakt gebruik van assessment_area_development_spaces_view wat de generieke view is voor de (algemente) ontwikkelingsruimte info.
 * Naast de benutingsgraad geeft deze view ook aan of de grenswaarde aangepast (verlaagd) is.
 */
CREATE OR REPLACE VIEW assessment_area_development_spaces_permit_threshold_view AS
SELECT
	assessment_area_id,
	assessment_area_name,
	limiter_fraction,
	(value <>  ae_constant('DEFAULT_PERMIT_THRESHOLD_VALUE')::real) AS permit_threshold_value_changed

	FROM assessment_area_development_spaces_view
		INNER JOIN permit_threshold_values USING (assessment_area_id)

	WHERE segment = 'permit_threshold'
;


/*
 * ae_assessment_area_calculation_demands
 * --------------------------------------
 * Geeft per N2000-gebied de grenswaarde en de hoogst benodigde ontwikkelingsruimte terug.
 * Aan de hand van de uitkomst van deze functie kan bepaald worden of een aanvraag een melding of vergunning is (of geen van beide).
 *
 * Indien er maar 1 situatie is dan mag current_calculation_id NULL zijn.
 */
CREATE OR REPLACE FUNCTION ae_assessment_area_calculation_demands(v_proposed_calculation_id integer, v_current_calculation_id integer)
	RETURNS TABLE(assessment_area_id integer, max_development_space_demand real, permit_threshold_value real) AS
$BODY$
	SELECT
		assessment_area_id,
		MAX(development_space_demand) AS max_development_space_demand,
		value AS permit_threshold_value

		FROM development_space_demands
			INNER JOIN receptors_to_assessment_areas USING (receptor_id)
			INNER JOIN permit_threshold_values USING (assessment_area_id)

		WHERE
			proposed_calculation_id = v_proposed_calculation_id
			AND current_calculation_id = COALESCE(v_current_calculation_id, 0)

		GROUP BY assessment_area_id, value
;
$BODY$
LANGUAGE SQL STABLE;
