/*
 * deposition_spaces_divided
 * -------------------------
 * Tabel met daarin de depositieruimte voor alle relevante receptoren.
 *
 * no_permit_required is de autonome ontwikkeling.
 * permit_threshold zijn de projecten waarvoor geen vergunning benodigd zijn omdat depositie onder de grenswaarde valt.
 * priority_projects zijn de segment 1 projecten (prioritaire projecten).
 * projects zijn de segment 2 projecten (overige projecten).
 *
 * @todo hernoem tabel naar iets dat duidelijker aangeeft wat de tabel precies is:
 * het totaal te reserveren gedeelte aan ontwikkelingsruimte per deposition_space_segment_type binnen de huidige PAS periode (?)
 */
CREATE TABLE deposition_spaces_divided (
	year year_type NOT NULL,
	receptor_id integer NOT NULL,
	no_permit_required real NOT NULL,
	permit_threshold real NOT NULL,
	priority_projects real NOT NULL,
	projects real NOT NULL,

	CONSTRAINT deposition_spaces_divided_pkey PRIMARY KEY (year, receptor_id),
	CONSTRAINT deposition_spaces_divided_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * override_relevant_development_space_receptors
 * ---------------------------------------------
 * Tabel voor het overschrijven van de OR-relevantie (van relevant naar niet relevant).
 * Deze tabel bevat enkel de verschillen.
 * De override moet opgegeven worden per receptor en jaar.
 */
CREATE TABLE override_relevant_development_space_receptors (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	relevant boolean NOT NULL CHECK(relevant IS FALSE),
	reason text NOT NULL,

	CONSTRAINT override_relevant_development_space_receptors_pkey PRIMARY KEY (receptor_id, year),
	CONSTRAINT override_relevant_development_space_receptors_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);


/*
 * override_development_space_values
 * ---------------------------------
 * Tabel voor het overschrijven van de OR-waarde. Deze tabel bevat enkel de verschillen 
 * en wordt enkel in de build/export functie setup.ae_build_reserved_development_spaces meegenomen.
 * De override moet opgegeven worden per segment, receptor en jaar.
 */
CREATE TABLE override_development_space_values (
	segment segment_type NOT NULL,
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	value posreal NOT NULL,
	reason text NOT NULL,

	CONSTRAINT override_development_space_values_pkey PRIMARY KEY (segment, receptor_id, year),
	CONSTRAINT override_development_space_values_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors
);
