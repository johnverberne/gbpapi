/*
 * top_contributor_plots
 * ---------------------
 * Opslaan van verschillende 'spin' berekeningen.
 * Een spin heeft betrekking op de lijnen die van het berekende gebied (hexagon of natuurgebied) naar de top10 bronnen gaat.
 * Deze lijnen hebben (als ze allemaal in een andere richting liggen) een vorm die lijkt op een spin.
 * Het bepalen van deze 'lijnen' (eigenlijk gewoon de top 10 bronnen) wordt een spin-berekening genoemd.
 */
CREATE TABLE top_contributor_plots (
	top_contributor_plot_id serial NOT NULL,
	creation_time timestamp with time zone NOT NULL DEFAULT now(),

	CONSTRAINT top_contributor_plots_pkey PRIMARY KEY (top_contributor_plot_id)
);


/*
 * top_contributor_plot_calculations_by_site
 * -----------------------------------------
 * Koppeltabel tussen spin berekeningen en sites. Per site wordt 1 berekening gedaan.
 */
CREATE TABLE top_contributor_plot_calculations_by_site (
	top_contributor_plot_id integer NOT NULL,
	site_id integer NOT NULL,
	calculation_id integer NOT NULL,

	CONSTRAINT top_contributor_plot_calculations_by_site_pkey PRIMARY KEY (top_contributor_plot_id, site_id),
	CONSTRAINT top_contributor_plot_calculations_by_site_unq_calculation UNIQUE (calculation_id),

	CONSTRAINT top_contributor_plot_calculations_by_site_fkey_top_contributor_plot_id FOREIGN KEY (top_contributor_plot_id) REFERENCES top_contributor_plots,
	CONSTRAINT top_contributor_plot_calculations_by_site_fkey_site_id FOREIGN KEY (site_id) REFERENCES sites,
	CONSTRAINT top_contributor_plot_calculations_by_site_fkey_calculation_id FOREIGN KEY (calculation_id) REFERENCES calculations
);


/*
 * assessment_area_top_contributors
 * --------------------------------
 * Tabel met daarin per natuurgebied de top x sites en de totale depositie als gevolg van die sites voor een bepaald jaar.
 * Dit kan gebruikt worden voor de top 10 tabel in de webapp voor natuurgebieden.
 */
CREATE TABLE assessment_area_top_contributors (
	assessment_area_id integer NOT NULL,
	site_id integer NOT NULL,
	year year_type NOT NULL,
	total_deposition posreal NOT NULL,

	CONSTRAINT assessment_area_top_contributors_pkey PRIMARY KEY (assessment_area_id, site_id, year),

	CONSTRAINT assessment_area_top_contributors_fkey_site_id FOREIGN KEY (site_id) REFERENCES sites
);