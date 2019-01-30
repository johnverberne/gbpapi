/*
 * development_space_demands
 * -------------------------
 * Tabel waarin de berekeningen vanuit de functie "ae_insert_calculation_demands" gezet worden.
 * Het bevat de OR-behoefte van een berekening bestaande uit 1 of 2 situaties.
 *
 * @column proposed_calculation_id Berekenings-id van de gewenste situatie.
 * @column current_calculation_id Berekenings-id van de huidige situatie. Mag niet NULL zijn maar wel 0.
 * @column development_space_demand Benodigde ontwikkelingsruimte. Gelijk aan het verschil tussen de gewenste en de huidige behoefte in het geval van
 *   2 situaties; of enkel de gewenste behoefte in het geval van 1 situatie (delta_demand). Kan echter 0 zijn indien het om een niet OR-relevante
 *   receptor gaat of als de waarde lager is dan de grenswaarde (en er zonder afstandsgrenswaarde gerekend is). Mag niet negatief zijn, wordt dan ook 0.
 *
 * @see ae_insert_calculation_demands
 */
CREATE TABLE development_space_demands (
	proposed_calculation_id integer NOT NULL,
	current_calculation_id integer NOT NULL,
	receptor_id integer NOT NULL,
	development_space_demand posreal NOT NULL,

	CONSTRAINT development_space_demands_pkey PRIMARY KEY (proposed_calculation_id, current_calculation_id, receptor_id),
	CONSTRAINT development_space_demands_fkey_proposed_calculation FOREIGN KEY (proposed_calculation_id) REFERENCES calculations(calculation_id)
);
