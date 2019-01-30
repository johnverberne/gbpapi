INSERT INTO authority_email_addresses (authority_id, email_address)
SELECT
	authority_id,
	'aeriusmail+' || code || '@gmail.com'

	FROM authorities

	WHERE type = 'province'
;
