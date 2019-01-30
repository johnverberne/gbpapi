/*
 * gcn_sector_corrections_no_policies_view
 * ---------------------------------------
 * Correctie per jaar, GCN-sector, stof en receptor ten opzichte van de doorgerekende depositie.
 * Ten opzichte van de gelijknamige tabel, aggregeert deze view het correction_type weg.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_corrections_no_policies_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,
	SUM(correction) AS correction

	FROM setup.gcn_sector_corrections_no_policies

	WHERE NOT correction_type = 'post_correction'

	GROUP BY receptor_id, year, gcn_sector_id, substance_id
;


/*
 * gcn_sector_post_corrections_no_policies_view
 * --------------------------------------------
 * Correctie per jaar, GCN-sector, stof en receptor ten opzichte van de doorgerekende depositie.
 * De correction_type van de post correcties uit setup.gcn_sector_corrections_no_policies worden door deze tabel weg geaggregeerd.
 *
 * LET OP: het gaat hier om de post correcties. Dit zijn de correcties op het basisjaar die pas na de schaling worden toegepast.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_post_corrections_no_policies_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,
	SUM(correction) AS correction

	FROM setup.gcn_sector_corrections_no_policies

	WHERE correction_type = 'post_correction'

	GROUP BY receptor_id, year, gcn_sector_id, substance_id
;


/*
 * gcn_sector_depositions_no_policies_agriculture_view
 * ---------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep farm.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_agriculture_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	GREATEST((deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0), 0) AS deposition

	FROM setup.gcn_sector_depositions_no_policies_agriculture
		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;

/*
 * gcn_sector_depositions_no_policies_industry_view
 * ------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep industry.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_industry_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_no_policies_industry
		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;

/*
 * gcn_sector_depositions_no_policies_other_view
 * ---------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep other.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_other_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_no_policies_other
		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;

/*
 * gcn_sector_depositions_no_policies_road_freeway_view
 * ----------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep road freeway.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_road_freeway_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_no_policies_road_freeway
		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;

/*
 * gcn_sector_depositions_no_policies_road_transportation_view
 * -----------------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep road transportation.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_road_transportation_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_no_policies_road_transportation
		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;

/*
 * gcn_sector_depositions_no_policies_shipping_view
 * ------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de gehele AERIUS-sectorgroep shipping.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_shipping_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_no_policies_shipping
		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;


/*
 * gcn_sector_depositions_no_policies_no_growth_view
 * -------------------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar rijksbeleid zonder groei.
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_no_growth_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition

	FROM setup.gcn_sector_depositions_no_policies_no_growth
		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;


/*
 * gcn_sector_depositions_no_policies_view
 * ---------------------------------------
 * Doorgerekende depositie per jaar, GCN-sector, stof en receptor naar vaststaand beleid voor de alle AERIUS-sectorgroepen.
 * LET OP! deze view kan traag zijn!
 */
CREATE OR REPLACE VIEW setup.gcn_sector_depositions_no_policies_view AS
SELECT
	receptor_id,
	year,
	gcn_sector_id,
	substance_id,	
	(deposition * COALESCE(correction_factor, 1)) + COALESCE(correction, 0) AS deposition
	
	FROM
		(SELECT receptor_id, year, gcn_sector_id, substance_id, deposition FROM setup.gcn_sector_depositions_no_policies_agriculture
			UNION
			SELECT receptor_id, year, gcn_sector_id, substance_id, deposition FROM setup.gcn_sector_depositions_no_policies_industry
			UNION
			SELECT receptor_id, year, gcn_sector_id, substance_id, deposition FROM setup.gcn_sector_depositions_no_policies_other
			UNION
			SELECT receptor_id, year, gcn_sector_id, substance_id, deposition FROM setup.gcn_sector_depositions_no_policies_road_freeway
			UNION
			SELECT receptor_id, year, gcn_sector_id, substance_id, deposition FROM setup.gcn_sector_depositions_no_policies_road_transportation
			UNION
			SELECT receptor_id, year, gcn_sector_id, substance_id, deposition FROM setup.gcn_sector_depositions_no_policies_shipping) AS depositions

		LEFT JOIN setup.gcn_sector_corrections_no_policies_view USING (receptor_id, year, gcn_sector_id, substance_id)
		LEFT JOIN setup.gcn_sector_correction_factors_no_policies USING (year, gcn_sector_id)
;



