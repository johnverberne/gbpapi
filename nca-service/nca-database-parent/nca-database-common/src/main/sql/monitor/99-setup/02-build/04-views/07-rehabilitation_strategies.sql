/*
 * update_rehabilitation_strategies_geometries_view
 * ------------------------------------------------
 * View om de geometrie voor een herstelmaatregel te verzamelen.
 * Mocht de herstelmaatregel reeds een geometry in de tabel hebben, dan wordt deze overschreven.
 */
CREATE OR REPLACE VIEW setup.update_rehabilitation_strategies_geometries_view AS
SELECT
	rehabilitation_strategy_id,
	ST_Multi(ST_Union(ST_SnapToGrid(hexagons.geometry, 0.001))) AS geometry -- Snap To Grid to make sure all hexagons sides will join well so we will get only the exterior geometry
	
	FROM rehabilitation_strategies
		INNER JOIN rehabilitation_strategies_to_receptors USING (rehabilitation_strategy_id)
		INNER JOIN hexagons USING (receptor_id)
	
	WHERE 
		zoom_level = 1 

	GROUP BY rehabilitation_strategy_id
;
