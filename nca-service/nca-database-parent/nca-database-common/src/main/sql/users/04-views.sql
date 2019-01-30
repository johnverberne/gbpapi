/*
 * users_view
 * ----------
 * Haalt de gebruikersinformatie op, inclusief bevoegd gezag informatie.
 */
CREATE OR REPLACE VIEW users_view AS
SELECT
	user_id,
	enabled,
	username,
	users.email_address,
	initials,
	firstname,
	lastname,
	authority_id,
	authorities_view.type AS authority_type,
	authorities_view.code AS authority_code,
	authorities_view.name AS authority_name

	FROM users
		INNER JOIN user_details USING (user_id)
		INNER JOIN authorities_view USING (authority_id)

	ORDER BY authority_type, authority_name, lastname
;

/*
 * users_with_edit_rights_view
 * ---------------------------
 * Haalt gebruikersinformatie op van gebruikers die een subset van rechten hebben waarmee
 * kenmerken van een vergunning aangepast kunnen worden, inclusief bevoegd gezag informatie.
 */
CREATE OR REPLACE VIEW users_with_edit_rights_view AS
SELECT DISTINCT
	user_id,
	enabled,
	username,
	users.email_address,
	initials,
	firstname,
	lastname,
	authority_id,
	authorities_view.type AS authority_type,
	authorities_view.code AS authority_code,
	authorities_view.name AS authority_name

	FROM users
		INNER JOIN user_details USING (user_id)
		INNER JOIN authorities_view USING (authority_id)
		INNER JOIN users_userroles USING (user_id)
		INNER JOIN userroles_to_permissions USING (userrole_id)
		INNER JOIN userpermissions USING (permission_id)

	WHERE userpermissions.name LIKE 'update_permit%'

	ORDER BY enabled, authority_type, authority_name, lastname
;


/*
 * users_roles_view
 * ----------------
 * Geeft voor iedere gebruiker de gebruikersrol.
 */
CREATE OR REPLACE VIEW users_roles_view AS
SELECT
	user_id,
	userrole_id,
	userroles.name AS rolename,
	color

	FROM users
		INNER JOIN users_userroles USING (user_id)
		INNER JOIN userroles USING (userrole_id)
;


/*
 * users_roles_permissions_view
 * ----------------------------
 * Geeft voor iedere gebruiker de gebruikersrollen en bijbehorende permissies.
 */
CREATE OR REPLACE VIEW users_roles_permissions_view AS
SELECT
	user_id,
	userrole_id,
	rolename,
	color,
	userpermissions.name AS permission

	FROM users_roles_view
		INNER JOIN userroles_to_permissions USING (userrole_id)
		INNER JOIN userpermissions USING (permission_id)
;
