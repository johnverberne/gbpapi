/*
 * pronouncements
 * --------------
 * Meldingen. Een melding is een type aanvraag (maar niet alle aanvragen zijn meldingen), en is daar ook aan gekoppeld.
 *
 * @column checked Meldingen hebben 2 statussen: Geregistreerd en Bevestigd. Bevestigd wil alleen zeggen dat een vergunningverlener de melding
 * gezien heeft. Verder hoeven we geen onderscheid te maken tussen de geregistreerde/bevestigde meldingen. Het is namelijk niet verplicht om de
 * status van een melding te wijzigen. Indien checked = TRUE dan is de melding Bevestigd.
 */
CREATE TABLE pronouncements (
	request_id integer NOT NULL,
	checked boolean NOT NULL DEFAULT FALSE,

	CONSTRAINT pronouncements_pkey PRIMARY KEY (request_id),
	CONSTRAINT pronouncements_fkey_requests FOREIGN KEY (request_id) REFERENCES requests
);
