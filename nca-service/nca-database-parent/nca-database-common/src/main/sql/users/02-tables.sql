/*
 * users
 * -----
 * Gebruikers. Alleen de informatie benodigd voor het inloggen/wachtwoord opvragen.
 */
CREATE TABLE users (
	user_id serial NOT NULL,
	username text NOT NULL,
	password text,
	email_address text NOT NULL,
	enabled boolean NOT NULL DEFAULT true,

	CONSTRAINT users_pkey PRIMARY KEY (user_id),
	CONSTRAINT users_username_unique UNIQUE (username),
	CONSTRAINT users_email_address_unique UNIQUE (email_address)
);

CREATE INDEX users_username ON users(username);


/*
 * authority_settings
 * ------------------
 * De verschillende settings die een bevoegd gezag kan hebben.
 */
CREATE TABLE authority_settings (
	authority_id integer NOT NULL,
	setting_key text NOT NULL,
	setting_value text NOT NULL,

	CONSTRAINT authority_settings_pkey PRIMARY KEY (authority_id, setting_key),
	CONSTRAINT authority_settings_fkey_authorities FOREIGN KEY (authority_id) REFERENCES authorities
);


/*
 * user_details
 * ------------
 * Profielinformatie van gebruikers. Naam, bevoegd gezag, etc.
 */
CREATE TABLE user_details (
	user_id integer NOT NULL,
	authority_id integer NOT NULL,
	initials text NOT NULL,
	firstname text NOT NULL,
	lastname text NOT NULL,

	CONSTRAINT user_details_pkey PRIMARY KEY (user_id),
	CONSTRAINT user_details_fkey_users FOREIGN KEY (user_id) REFERENCES users,
	CONSTRAINT user_details_fkey_authorities FOREIGN KEY (authority_id) REFERENCES authorities
);


/*
 * userroles
 * ---------
 * De verschillende gebruikersrollen. M.b.v. de naam kan een rol eenvoudig worden benaderd.
 */
CREATE TABLE userroles (
	userrole_id serial NOT NULL,
	name text NOT NULL UNIQUE,
	color text NOT NULL,
	description text,

	CONSTRAINT userroles_pkey PRIMARY KEY (userrole_id)
);


/*
 * users_userroles
 * ---------------
 * De rol(len) die bij iedere gebruiker horen. Een gebruiker kan gekoppeld zijn aan meerdere rollen (N:N).
 */
CREATE TABLE users_userroles (
	user_id integer NOT NULL,
	userrole_id integer NOT NULL,

	CONSTRAINT users_userroles_pkey PRIMARY KEY (user_id, userrole_id),
	CONSTRAINT users_userroles_fkey_users FOREIGN KEY (user_id) REFERENCES users,
	CONSTRAINT users_userroles_fkey_userroles FOREIGN KEY (userrole_id) REFERENCES userroles
);


/*
 * userpermissions
 * ---------------
 * De verschillende permissies.
 */
CREATE TABLE userpermissions (
	permission_id serial NOT NULL,
	name text NOT NULL UNIQUE,

	CONSTRAINT userpermissions_pkey PRIMARY KEY (permission_id)
);


/*
 * userroles_to_permissions
 * ------------------------
 * De rechten die bij een rol horen. Een rol kan gekoppeld zijn aan meerdere rechten (N:N).
 */
CREATE TABLE userroles_to_permissions (
	userrole_id integer NOT NULL,
	permission_id integer NOT NULL,

	CONSTRAINT userroles_to_permissions_pkey PRIMARY KEY (userrole_id, permission_id),
	CONSTRAINT userroles_to_permissions_fkey_userroles FOREIGN KEY (userrole_id) REFERENCES userroles,
	CONSTRAINT userroles_to_permissions_fkey_userpermissions FOREIGN KEY (permission_id) REFERENCES userpermissions
);


/*
 * user_filters
 * ------------
 * Gebruikers kunnen verschillende filters gebruiken, die over verschillende sessies gebruikt kunnen worden.
 *
 * Van een bepaald type filter (de class die gebruikt wordt) is er per gebruiker maximaal 1.
 * De gebruiker kan zelf geen filters opslaan voor later gebruik of dergelijke, maar deze worden automatisch bijgehouden.
 * Content van de filters wordt als JSON opgeslagen.
 */
CREATE TABLE user_filters (
	user_id integer NOT NULL,
	filter_type text NOT NULL,
	filter_content json NOT NULL,

	CONSTRAINT user_filters_pkey PRIMARY KEY (user_id, filter_type),
	CONSTRAINT user_filters_fkey_users FOREIGN KEY (user_id) REFERENCES users
);