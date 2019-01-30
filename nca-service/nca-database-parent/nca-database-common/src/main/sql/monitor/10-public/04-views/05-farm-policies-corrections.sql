/*
 * farm_emission_formal_ceilings_all_policies_view
 * -----------------------------------------------
 * View welke per emissieplafond categorie de emissieplafonds voor alle beleids scenarios retourneert.
 */
CREATE OR REPLACE VIEW farm_emission_formal_ceilings_all_policies_view AS
SELECT
	jurisdiction_id,
	farm_emission_ceiling_category_id,
	year,
	substance_id,
	np.emission_ceiling AS emission_ceiling_np,
	COALESCE(gp.emission_ceiling, np.emission_ceiling) AS emission_ceiling_gp,
	COALESCE(jp.emission_ceiling, gp.emission_ceiling, np.emission_ceiling) AS emission_ceiling_jp
	
	FROM farm_emission_formal_ceilings_no_policies AS np
		FULL OUTER JOIN farm_emission_formal_ceilings_global_policies AS gp USING (farm_emission_ceiling_category_id, substance_id)
		CROSS JOIN jurisdictions
		FULL OUTER JOIN farm_emission_formal_ceilings_jurisdiction_policies AS jp USING (jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id)
;


/*
 * farm_emission_ceilings_all_policies_view
 * ----------------------------------------
 * View welke per emissieplafond categorie de emissieplafonds voor alle beleids scenarios retourneert.
 */
CREATE OR REPLACE VIEW farm_emission_ceilings_all_policies_view AS
SELECT
	jurisdiction_id,
	farm_emission_ceiling_category_id,
	year,
	substance_id,
	np.emission_ceiling AS emission_ceiling_np,
	COALESCE(gp.emission_ceiling, np.emission_ceiling) AS emission_ceiling_gp,
	COALESCE(jp.emission_ceiling, gp.emission_ceiling, np.emission_ceiling) AS emission_ceiling_jp
	
	FROM farm_emission_ceilings_no_policies AS np
		FULL OUTER JOIN farm_emission_ceilings_global_policies AS gp USING (farm_emission_ceiling_category_id, year, substance_id)
		CROSS JOIN jurisdictions
		FULL OUTER JOIN farm_emission_ceilings_jurisdiction_policies AS jp USING (jurisdiction_id, farm_emission_ceiling_category_id, year, substance_id)
;