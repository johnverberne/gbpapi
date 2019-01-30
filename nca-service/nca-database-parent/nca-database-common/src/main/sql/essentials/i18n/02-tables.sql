/*
 * messages
 * --------
 * Systeem tabel voor localized teksten.
 */
CREATE TABLE i18n.messages (
	key text NOT NULL,
	language_code i18n.language_code_type NOT NULL,
	message text,

	CONSTRAINT messages_pkey PRIMARY KEY (key, language_code)
);

/*
 * system_info_messages
 * --------------------
 * Systeem info tabel voor localized teksten, voor tonen van systeem berichten. 
 */
CREATE TABLE i18n.system_info_messages (
  language_code i18n.language_code_type NOT NULL,
  message text NOT NULL,

  CONSTRAINT system_info_messages_pkey PRIMARY KEY (language_code)
);

