/*
 * sector_priority_project_economic_growth_limiter_factors
 * -------------------------------------------------------
 * Aftopfactor (voor waterbed) van de projectbehoefte van de prioritair project.
 */
CREATE TABLE setup.sector_priority_project_economic_growth_limiter_factors (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	substance_id integer NOT NULL,
	limiter_factor fraction NOT NULL,

	CONSTRAINT sector_pp_economic_growth_limiter_factors_pkey PRIMARY KEY (year, sector_id, substance_id)--,
--	CONSTRAINT sector_pp_economic_growth_limiter_factors_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
--	CONSTRAINT sector_pp_economic_growth_limiter_factors_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances

);


/*
 * sector_priority_project_demands_growth
 * --------------------------------------
 * Ontwikkelbehoefte van de prioritair project, AERIUS-sector, jaar en receptor.
 * Dit zijn de resulaten van de projectenlijst die voor de groei (puur segment 1) gebruikt wordt.
 * Het veld demand is het deel van de behoefte dat afgetopt wordt, demand_unlimited is het deel dat niet afgetopt wordt.
 */
CREATE TABLE setup.sector_priority_project_demands_growth (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	substance_id integer not NULL,
	demand real NOT NULL,
	demand_unlimited real NOT NULL,

	CONSTRAINT sector_priority_project_demands_growth_pkey PRIMARY KEY (receptor_id, year, sector_id, substance_id)--,
--	CONSTRAINT sector_priority_project_demands_growth_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT sector_priority_project_demands_growth_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
--	CONSTRAINT sector_priority_project_demands_growth_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances

);


/*
 * sector_priority_project_demands_desire
 * --------------------------------------
 * Ontwikkelbehoefte van de prioritair project, AERIUS-sector, jaar en receptor.
 * Dit zijn de resulaten van de projectenlijst die voor de behoefte (puur segment 1) gebruikt wordt.
 */
CREATE TABLE setup.sector_priority_project_demands_desire (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	substance_id integer not NULL,
	demand real NOT NULL,

	CONSTRAINT sector_priority_project_demands_desire_pkey PRIMARY KEY (receptor_id, year, sector_id, substance_id)--,
--	CONSTRAINT sector_priority_project_demands_desire_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT sector_priority_project_demands_desire_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
--	CONSTRAINT sector_priority_project_demands_desire_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances

);


/*
 * sector_priority_project_demands_desire_divided
 * ----------------------------------------------
 * Ontwikkelbehoefte van de prioritair project, AERIUS-sector, jaar en receptor.
 */
CREATE TABLE setup.sector_priority_project_demands_desire_divided (
	receptor_id integer NOT NULL,
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	no_permit_required_demand real NOT NULL,
	permit_threshold_demand real NOT NULL,
	priority_projects_demand real NOT NULL,

	CONSTRAINT sector_priority_project_demands_desire_div_pkey PRIMARY KEY (receptor_id, year, sector_id)--,
--	CONSTRAINT sector_priority_project_demands_desire_div_fkey_receptors FOREIGN KEY (receptor_id) REFERENCES receptors,
--	CONSTRAINT sector_priority_project_demands_desire_div_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);