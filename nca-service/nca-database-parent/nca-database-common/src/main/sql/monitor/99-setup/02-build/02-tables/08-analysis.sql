/*
 * sector_economic_growths_analysis
 * --------------------------------
 * Tussentabel voor analysedoeleinden, met de gemiddelde (AVG) generieke groei per toekomstjaar en AERIUS-sector.
 * De groei is opgesplitst in de 5 losse onderdelen waaruit deze is opgebouwd.
 * In de varianten met space_ prefix zijn negatieve waarden per receptor op 0 gezet.
 */
CREATE TABLE setup.sector_economic_growths_analysis (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	space_source_deposition_scaled real NOT NULL,
	space_priority_projects_demand real NOT NULL,
	space_deposition_future_base real NOT NULL,
	space_deposition_growth_no_growth real NOT NULL,
	space_growth_correction real NOT NULL,
	source_deposition_scaled real NOT NULL,
	priority_projects_demand real NOT NULL,
	deposition_future_base real NOT NULL,
	deposition_growth_no_growth real NOT NULL,
	growth_correction real NOT NULL,

	CONSTRAINT sector_economic_growths_analysis_pkey PRIMARY KEY (year, sector_id)--,
--	CONSTRAINT sector_economic_growths_analysis_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);


/*
 * sector_economic_desires_analysis
 * --------------------------------
 * Tussentabel voor analysedoeleinden, met de gemiddelde (AVG) ontwikkelbehoefte per toekomstjaar en AERIUS-sector.
 * De behoefte is opgesplitst in de losse onderdelen waaruit deze is opgebouwd:
 * priority_projects_desire = source_scaled_priority_projects_desire + priority_projects_demand_desire + growth_deposition_future_base + growth_correction_priority_projects_desire
 * other_desire = growth_correction_other_desire + desire_deposition_growth_no_growth + (source_scaled_other_desire + other_desire_correction)
 * In de daadwerkelijke berekening is (source_scaled_other_desire + other_desire_correction) begrensd tot ten minste 20% van de RIVM groei.
 */
CREATE TABLE setup.sector_economic_desires_analysis (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	substance_id smallint NOT NULL,
	source_scaled_priority_projects_desire real NOT NULL,
	priority_projects_demand_desire real NOT NULL,
	growth_deposition_future_base real NOT NULL,
	growth_correction_priority_projects_desire real NOT NULL,
	priority_projects_desire_correction real NOT NULL,
	source_scaled_other_desire real NOT NULL,
	desire_deposition_growth_no_growth real NOT NULL,
	growth_correction_other_desire real NOT NULL,
	other_desire_correction real NOT NULL,

	CONSTRAINT sector_economic_desires_analysis_pkey PRIMARY KEY (year, sector_id, substance_id)--,
--	CONSTRAINT sector_economic_desires_analysis_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors,
--	CONSTRAINT sector_economic_desires_analysis_fkey_substances FOREIGN KEY (substance_id) REFERENCES substances
);


/*
 * sector_depositions_no_policies_analysis
 * ---------------------------------------
 * Tussentabel voor analysedoeleinden, met de gemiddelde (AVG) depositiebijdrage zonder beleid per toekomstjaar en AERIUS-sector.
 * De depositie is opgesplitst in de losse onderdelen waaruit deze is opgebouwd.
 */
CREATE TABLE setup.sector_depositions_no_policies_analysis (
	year year_type NOT NULL,
	sector_id integer NOT NULL,
	deposition_space_growth real NOT NULL,
	source_deposition_scaled real NOT NULL,
	base_deposition real NOT NULL,
	future_with_growth_deposition real NOT NULL,
	farm_lodging_correction real NOT NULL,
	post_correction real NOT NULL,

	CONSTRAINT sector_depositions_no_policies_analysis_pkey PRIMARY KEY (year, sector_id)--,
--	CONSTRAINT sector_depositions_no_policies_analysis_fkey_sectors FOREIGN KEY (sector_id) REFERENCES sectors
);
