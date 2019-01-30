/*
 * receptors_to_assessment_areas
 * -----------------------------
 * Koppeltabel tussen receptors en toetsgebieden (al dan niet natura2000 gebieden) met de gedeelde oppervlakte.
 * De koppeling is gedaan op basis van de hexagon op zoom level 1 die hoort bij de receptor.
 * @todo assessment_area_id -> receptor_id
 */
CREATE TABLE receptors_to_assessment_areas
(
	receptor_id integer NOT NULL,
	assessment_area_id integer NOT NULL,
	surface posreal NOT NULL,

	CONSTRAINT receptors_to_assessment_areas_pkey PRIMARY KEY (receptor_id, assessment_area_id),
	CONSTRAINT receptors_to_assessment_areas_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX idx_receptors_to_assessment_areas_assessment_area_id ON receptors_to_assessment_areas (assessment_area_id);


/*
 * receptors_to_critical_deposition_areas
 * --------------------------------------
 * Koppeltabel tussen hexagonen (met hun receptor_id), KDW-gebieden en toetsgebieden (al dan niet natura2000 gebieden) met de gedeelde oppervlakte.
 */
CREATE TABLE receptors_to_critical_deposition_areas
(
	assessment_area_id integer NOT NULL,
	type critical_deposition_area_type NOT NULL,
	critical_deposition_area_id integer NOT NULL,
	receptor_id integer NOT NULL,
	surface posreal NOT NULL,
	coverage posreal NOT NULL,

	CONSTRAINT receptors_to_critical_deposition_areas_pkey PRIMARY KEY (assessment_area_id, type, critical_deposition_area_id, receptor_id),
	CONSTRAINT receptors_to_critical_deposition_areas_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);

CREATE INDEX idx_receptors_to_critical_deposition_areas ON receptors_to_critical_deposition_areas (receptor_id);