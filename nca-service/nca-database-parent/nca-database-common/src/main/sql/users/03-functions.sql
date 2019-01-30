/*
 * ae_get_userrole_id
 * ------------------
 * Hulpfunctie om het gebruikersrol-id terug te geven op basis van naam.
 */
CREATE OR REPLACE FUNCTION ae_get_userrole_id(v_name text)
	RETURNS integer AS
$BODY$
BEGIN
	RETURN userrole_id FROM userroles WHERE name = v_name;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_get_userpermission_id
 * ------------------------
 * Hulpfunctie om het gebruikerspermissie-id terug te geven op basis van naam.
 */
CREATE OR REPLACE FUNCTION ae_get_userpermission_id(v_name text)
	RETURNS integer AS
$BODY$
BEGIN
	RETURN permission_id FROM userpermissions WHERE name = v_name;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_get_user_id
 * --------------
 * Hulpfunctie om het gebruikers-id terug te geven op basis van gebruikersnaam.
 */
CREATE OR REPLACE FUNCTION ae_get_user_id(v_username text)
	RETURNS integer AS
$BODY$
BEGIN
	RETURN user_id FROM users WHERE username = v_username;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_add_user
 * -----------
 * Hulpfunctie om met een enkele aanroep een gebruiker toe te voegen inclusief alle profielinformatie en rechten.
 *
 * @param v_userrole_name Naam van de gebruikersrol. Indien NULL, dan wordt de gebruiker aangemaakt zonder enige rollen (deze zullen later toegevoegd moeten worden om het account bruikbaar te maken).
 * @return Het gebruikers-id.
 */
CREATE OR REPLACE FUNCTION ae_add_user(v_username text, v_password text, v_email_address text, v_initials text, v_firstname text, v_lastname text, v_authority_id integer, v_userrole_name text = NULL)
	RETURNS integer AS
$BODY$
DECLARE
	v_new_user_id int;
BEGIN
	INSERT INTO users(username, password, email_address) VALUES(v_username, v_password, v_email_address) RETURNING user_id INTO v_new_user_id;
	INSERT INTO user_details(user_id, initials, firstname, lastname, authority_id) VALUES(v_new_user_id, v_initials, v_firstname, v_lastname, v_authority_id);

	IF v_userrole_name IS NOT NULL THEN
		INSERT INTO users_userroles(user_id, userrole_id) VALUES (v_new_user_id, ae_get_userrole_id(v_userrole_name));
	END IF;

	RETURN v_new_user_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_delete_user
 * --------------
 * Gebruik deze functie om een gebruiker te verwijderen uit het systeem.
 */
CREATE OR REPLACE FUNCTION ae_delete_user(v_user_id integer)
	RETURNS void AS
$BODY$
BEGIN
	DELETE FROM users_userroles WHERE user_id = v_user_id;
	DELETE FROM user_details WHERE user_id = v_user_id;
	DELETE FROM users WHERE user_id = v_user_id;
EXCEPTION
	WHEN SQLSTATE '23503' THEN
		RAISE EXCEPTION 'User could not be deleted (ID = %)', v_user_id
			USING ERRCODE = 'AE201';
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


/*
 * ae_users_ensure_uniqueness
 * --------------------------
 * Deze trigger functie wordt aan de users tabel gehangen, en zorgt ervoor dat het email adres in lowercase in de database staat.
 *
 * TODO: moet username ook?
 */
CREATE OR REPLACE FUNCTION ae_users_ensure_uniqueness()
	RETURNS trigger AS
$BODY$
BEGIN
	NEW.email_address := lower(NEW.email_address);
	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;
