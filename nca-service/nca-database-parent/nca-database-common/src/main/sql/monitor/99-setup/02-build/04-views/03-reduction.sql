/*
 * gcn_sector_reductions_global_policies_view
 * ------------------------------------------
 * View voor het bepalen van de reductie per gcn-sector wegens het rijksbeleid.
 * LET OP: ivm de performance gebruiken we de subset no_policies_agriculture ipv alle no_policies data. Landbouw is momenteel de enige sector met reductie.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_reductions_global_policies_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,
	(np.deposition - LEAST(np.deposition, gp.deposition)) AS reduction

	FROM setup.gcn_sector_depositions_no_policies_agriculture_view AS np
		LEFT JOIN setup.gcn_sector_depositions_global_policies_view AS gp USING (receptor_id, year, gcn_sector_id, substance_id)
;

/*
 * gcn_sector_reductions_jurisdiction_policies_view
 * ------------------------------------------------
 * View voor het bepalen van de reductie per gcn-sector wegens het provinciaal beleid.
* LET OP: ivm de performance gebruiken we de subset no_policies_agriculture ipv alle no_policies data. Landbouw is momenteel de enige sector met reductie.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_reductions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,
	(np.deposition - LEAST(np.deposition, gp.deposition, jp.deposition)) AS reduction

	FROM setup.gcn_sector_depositions_no_policies_agriculture_view AS np
		LEFT JOIN setup.gcn_sector_depositions_global_policies_view AS gp USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_depositions_jurisdiction_policies_view AS jp USING (receptor_id, year, gcn_sector_id, substance_id)
;

/*
 * sector_reductions_global_policies_view
 * --------------------------------------
 * View voor het bepalen van de reductie per sector wegens het rijksbeleid.
 */
CREATE OR REPLACE VIEW setup.sector_reductions_global_policies_view AS
SELECT
	receptor_id,
	year,
	sector_id,
	SUM(reduction) AS reduction

	FROM setup.gcn_sector_reductions_global_policies_view
		INNER JOIN gcn_sectors USING (gcn_sector_id)

	GROUP BY receptor_id, year, sector_id, substance_id
;

/*
 * sector_reductions_jurisdiction_policies_view
 * --------------------------------------------
 * View voor het bepalen van de reductie per sector wegens het provinciaal beleid.
 */
CREATE OR REPLACE VIEW setup.sector_reductions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	year,
	sector_id,
	SUM(reduction) AS reduction

	FROM setup.gcn_sector_reductions_jurisdiction_policies_view
		INNER JOIN gcn_sectors USING (gcn_sector_id)

	GROUP BY receptor_id, year, sector_id, substance_id
;


/*
 * build_reductions_jurisdiction_policies_view
 * -------------------------------------------
 * View om reductions_jurisdiction_policies tabel mee te vullen.
 */
CREATE OR REPLACE VIEW setup.build_reductions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	year,
	SUM(reduction) AS reduction

	FROM setup.gcn_sector_reductions_jurisdiction_policies_view
		INNER JOIN years USING (year)

	WHERE year_category = 'future'

	GROUP BY receptor_id, year
;