/*
 * ae_update_permit_threshold_values
 * ---------------------------------
 * Controleert de grenswaarde voor ieder gebied op basis van de benuttingsgraad, en past deze zo nodig aan.
 * In geval van aanpassingen worden deze teruggegeven. De Java-kant zal dit zelf loggen in de permit_threshold_values_audit_trail tabel.
 *
 * Indien de grenswaardereservering binnen een gebied op dreigt te raken, moet de grenswaarde automatisch aangepast worden. Register beheerd de
 * ontwikkelingsruimte en is daarom het product die dit uit moet voeren. Dat kan door aanroep van deze functie.
 * De grenswaarde van een gebied is standaard 1 mol. Wanneer echter op 1 hexagoon binnen een gebied 95% van de grenswaardereservering benut is,
 * moet de grenswaarde binnen dit gebied automatisch aangepast worden in 0.05 mol.
 * Een aangepaste (verlaagde) grenswaardereservering springt niet automatisch terug indien de benuttingsgraad weer onder de 95% komt (dit zou bijvoorbeeld kunnen gebeuren bij het verwijderen van een medling,
 * of het aanpassen van de de grenswaardereservering). Dit kan momenteel enkel door de waarde in de tabel permit_threshold_values aan te passen.
 */
CREATE OR REPLACE FUNCTION ae_update_permit_threshold_values()
	RETURNS TABLE(assessment_area_id integer, old_value real, new_value real) AS
$BODY$
BEGIN
	LOCK TABLE development_spaces IN EXCLUSIVE MODE;
	LOCK TABLE permit_threshold_values IN EXCLUSIVE MODE;

	RETURN QUERY (
		WITH  -- Provides a nice way to combine SELECT and DML statements
		permit_threshold_actual_expected_values AS (  -- This gets the actual and expected values so we can see what should be changed
			SELECT
				permit_threshold_values.assessment_area_id,
				value::real AS actual_value,
				(CASE WHEN (permit_threshold_value_changed OR limiter_fraction >= ae_constant('PRONOUNCEMENT_SPACE_ALMOST_FULL_TRIGGER')::real)
					THEN ae_constant('PRONOUNCEMENT_THRESHOLD_VALUE')
					ELSE ae_constant('DEFAULT_PERMIT_THRESHOLD_VALUE')
				 END)::real AS expected_value

				FROM permit_threshold_values
					INNER JOIN assessment_area_development_spaces_permit_threshold_view USING (assessment_area_id)
		),
		permit_threshold_updates AS (  -- This does the actual update, and returns the changes that it made
			UPDATE permit_threshold_values
			SET value = expected_value

			FROM permit_threshold_actual_expected_values

			WHERE
				permit_threshold_values.assessment_area_id = permit_threshold_actual_expected_values.assessment_area_id
				AND actual_value <> expected_value

			RETURNING permit_threshold_actual_expected_values.*
		)
		SELECT -- This returns those same changes ready to be added into the audit trail
			permit_threshold_updates.assessment_area_id,
			actual_value,
			expected_value

			FROM permit_threshold_updates
	);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
