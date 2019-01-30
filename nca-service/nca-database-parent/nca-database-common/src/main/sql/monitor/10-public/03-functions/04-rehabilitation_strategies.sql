/*
 * ae_determine_rehabilitation_clusters
 * ------------------------------------
 * Bepaal voor een natuurgebied de herstelmaatregelen-clusters die tezamen getoond kunnen worden op een kaart zonder te overlappen.
 */
CREATE OR REPLACE FUNCTION ae_determine_rehabilitation_clusters(v_assessment_area_id integer, v_start_cluster_id integer, exclude_rehabilitation_strategy_ids integer[], v_geometry_so_far geometry, v_max_clusters_per_group integer)
	RETURNS TABLE(cluster_id integer, cluster_rehabilitation_strategy_ids integer[], geometry_accuracy rehabilitation_strategy_geometry_accuracy_type, geometry geometry) AS
$BODY$
DECLARE
	v_rehabilitation_strategy_ids integer[];
	v_geometry geometry;
	v_geometry_accuracy rehabilitation_strategy_geometry_accuracy_type;
BEGIN
	SELECT rehabilitation_strategy_ids, cluster_view.geometry_accuracy, cluster_view.geometry 	
		INTO v_rehabilitation_strategy_ids, v_geometry_accuracy, v_geometry
		FROM rehabilitation_strategy_grouped_geometries_view AS cluster_view
		
		WHERE 
			assessment_area_id = v_assessment_area_id
			AND (exclude_rehabilitation_strategy_ids IS NULL OR NOT (rehabilitation_strategy_ids && exclude_rehabilitation_strategy_ids))
			AND (v_geometry_so_far IS NULL OR ST_Disjoint(cluster_view.geometry, v_geometry_so_far))
		
		LIMIT 1;
	
	IF (v_geometry IS NOT NULL AND v_max_clusters_per_group >= 1) THEN
		RETURN QUERY 
			SELECT v_start_cluster_id, v_rehabilitation_strategy_ids, v_geometry_accuracy, v_geometry;
	
		RETURN QUERY 
			SELECT * FROM ae_determine_rehabilitation_clusters(v_assessment_area_id, 
						v_start_cluster_id + 1, 
						array_cat(exclude_rehabilitation_strategy_ids, v_rehabilitation_strategy_ids), 
						COALESCE(ST_Union(v_geometry_so_far, ST_Multi(v_geometry)), v_geometry), 
						v_max_clusters_per_group - 1);
	END IF;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_determine_rehabilitation_all_clusters
 * ----------------------------------------
 * Bepaal alle herstelmaatregel-cluster groepen voor een natuurgebied. Geeft ook terug tot welke clustergroup een cluster behoort.
 * Dezelfde cluster_group_id betekent dat de gebieden voor de herstelmaatregelen tezamen getoond kunnen worden op de kaart.
 * 
 * Cluster_group_ids zijn oplopend qua oppervlakte van grootste herstelmaatregel gebied, beginnend bij 1.
 * Cluster_ids binnen een group zijn oplopend qua oppervlakte, op het moment beginnend bij A (na Z komt AA).
 */
CREATE OR REPLACE FUNCTION ae_determine_rehabilitation_all_clusters(v_assessment_area_id integer)
	RETURNS TABLE(cluster_group_id int, index_within_group int, cluster_id text, cluster_rehabilitation_strategy_ids integer[], geometry_accuracy rehabilitation_strategy_geometry_accuracy_type, geometry geometry) AS
$BODY$
DECLARE
	rec record;
	--max clusters per group
	v_max_clusters_per_group integer = 4; 
	--attributes to keep track of what we've used already.
	v_cluster_group_id int = 1;
	v_cluster_id integer = 1;
	v_index_within_group integer = 1;
	v_exclude_rehabilitation_strategy_ids integer[];
	v_hasmore boolean = TRUE;
BEGIN
	WHILE (v_hasmore) LOOP
		v_hasmore := FALSE;
	
		FOR rec IN 
			SELECT * FROM ae_determine_rehabilitation_clusters(v_assessment_area_id, v_cluster_id, v_exclude_rehabilitation_strategy_ids, NULL, v_max_clusters_per_group)
		LOOP
			v_cluster_id := rec.cluster_id;
		
			RETURN QUERY SELECT v_cluster_group_id, v_index_within_group, ae_id_to_capital_letter(rec.cluster_id), rec.cluster_rehabilitation_strategy_ids, rec.geometry_accuracy, rec.geometry;
		
			v_exclude_rehabilitation_strategy_ids := array_cat(v_exclude_rehabilitation_strategy_ids, rec.cluster_rehabilitation_strategy_ids);
			v_index_within_group := v_index_within_group + 1;
			v_hasmore = TRUE;

		END LOOP;
		
		v_cluster_id := v_cluster_id + 1;
		v_cluster_group_id := v_cluster_group_id + 1;
		v_index_within_group := 1;

	END LOOP;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_determine_rehabilitation_clusters_overview
 * ---------------------------------------------
 * Bepaalt voor alle natuurgebieden de clusters (en groepen) voor herstelmaatregelen.
 * Wordt waarschijnlijk niet in de praktijk gebruikt, meer ter informatie ende lering en vermaak.
 */
CREATE OR REPLACE FUNCTION ae_determine_rehabilitation_clusters_overview()
	RETURNS TABLE(assessment_area_id integer, cluster_group_id int, cluster_id text, cluster_rehabilitation_strategy_ids integer[], geometry_accuracy rehabilitation_strategy_geometry_accuracy_type, geometry geometry) AS
$BODY$
DECLARE
	v_assessment_area_id integer;
BEGIN
	FOR v_assessment_area_id IN 
		SELECT DISTINCT rehabilitation_strategy_grouped_geometries_view.assessment_area_id 
			FROM rehabilitation_strategy_grouped_geometries_view 
			ORDER BY assessment_area_id
	LOOP
		RETURN QUERY SELECT v_assessment_area_id, * FROM ae_determine_rehabilitation_all_clusters(v_assessment_area_id);
	END LOOP;

END;
$BODY$
LANGUAGE plpgsql STABLE;
