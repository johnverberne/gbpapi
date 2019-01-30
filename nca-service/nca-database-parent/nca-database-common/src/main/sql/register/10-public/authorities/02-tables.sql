/*
 * authority_email_addresses
 * -------------------------
 * E-mail adressen behorende bij de bevoegde gezagen. Alleen in het geval van provincies is er een e-mail adres aan gekoppeld.
 */
CREATE TABLE authority_email_addresses (
	authority_id integer NOT NULL,
	email_address text NOT NULL,

	CONSTRAINT authority_email_addresses_pkey PRIMARY KEY (authority_id),
	CONSTRAINT authority_email_addresses_fkey_authorities FOREIGN KEY (authority_id) REFERENCES authorities
);
