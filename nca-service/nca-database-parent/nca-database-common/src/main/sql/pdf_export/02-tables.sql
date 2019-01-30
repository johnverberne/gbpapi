/*
 * pdf_export_receptors_to_assessment_areas
 * ----------------------------------------
 * Bevat de relevante receptoren per natuurgebied voor de PDF-export.
 *
 * Van de PAS gebieden moeten enkel de OR relevante receptoren meegenomen worden en moet er nog onderscheid gemaakt worden in de wel/niet overbelaste receptoren.
 * Van de andere gebieden worden enkel de rekenresultaten op de stikstof-relevante receptoren meegenomen.
 */
 
CREATE TABLE pdf_export_receptors_to_assessment_areas(
	receptor_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	pas_area boolean NOT NULL,
	exceeding boolean NOT NULL,

	CONSTRAINT pdf_export_receptors_to_assessment_areas_pkey PRIMARY KEY (receptor_id, assessment_area_id),
	CONSTRAINT pdf_export_receptors_to_assessment_areas_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);