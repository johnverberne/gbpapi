/*
 * gcn_sector_corrections_jurisdiction_policies_view
 * -------------------------------------------------
 * Correctie per jaar, GCN-sector, stof en receptor ten opzichte van de (eventueel) doorgerekende depositie naar provinciaal beleid
 * of de (eventueel gecorrigeerde) depositie naar provinciaal beleid.
 * Ten opzichte van de gelijknamige tabel, aggregeert deze view het correction_type weg.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_corrections_jurisdiction_policies_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,
	SUM(correction) AS correction

	FROM setup.gcn_sector_corrections_jurisdiction_policies

	GROUP BY receptor_id, year, gcn_sector_id, substance_id
;

/*
 * gcn_sector_depositions_jurisdiction_policies_view
 * -------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar rijksbeleid.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_jurisdiction_policies_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_jurisdiction_policies
		LEFT JOIN setup.gcn_sector_corrections_jurisdiction_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_jurisdiction_policies USING (year, gcn_sector_id)
;

/*
 * gcn_sector_depositions_jurisdiction_policies_no_growth_view
 * -----------------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar rijksbeleid zonder groei.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_jurisdiction_policies_no_growth_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_jurisdiction_policies_no_growth
		LEFT JOIN setup.gcn_sector_corrections_jurisdiction_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_jurisdiction_policies USING (year, gcn_sector_id)
;