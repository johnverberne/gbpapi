/*
 * register_authorities_view
 * -------------------------
 * Geeft de volledige informatie van de bevoegde gezagen terug inclusief register specifieke data (email/register bevoegd gezag).
 * De tabel met e-mail adressen wordt gekoppeld aan de basis view voor bevoegde gezagen.
 * De resultaten zijn nog steeds gesorteerd op type dan naam (en daardoor geschikt voor weergave in de UI).
 */
CREATE OR REPLACE VIEW register_authorities_view AS
SELECT
	authority_id,
	country_id,
	code,
	name,
	type,
	email_address,
	foreign_authority,
	submitting_authority,
	(foreign_authority IS FALSE) AS register_authority

	FROM authorities_view
		LEFT JOIN authority_email_addresses USING (authority_id)

	ORDER BY type, name
;
