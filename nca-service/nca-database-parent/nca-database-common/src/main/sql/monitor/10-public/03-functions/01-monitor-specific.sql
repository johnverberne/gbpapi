/*
 * ae_get_nitrogen_load_classification
 * -----------------------------------
 * Gegeven een depositie en een KDW, retourneert de bijpassende stikstofbelastingsclassificatie.
 */
CREATE OR REPLACE FUNCTION ae_get_nitrogen_load_classification(v_critical_deposition real, v_total_deposition real)
	RETURNS nitrogen_load_classification AS
$BODY$
DECLARE
	v_delta_deposition real;
BEGIN
	v_delta_deposition := v_total_deposition - v_critical_deposition;
	-- Class heavy_overload has preference over class light_overload in case there is overlap.
	RETURN (CASE WHEN v_delta_deposition >= -35 AND v_delta_deposition < 35 THEN 'equilibrium'
			 WHEN v_delta_deposition >= v_critical_deposition THEN 'heavy_overload'
			 WHEN v_delta_deposition >= 35 AND v_delta_deposition < v_critical_deposition THEN 'light_overload'
			 ELSE 'no_nitrogen_problem'
		END);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_get_delta_space_desire_range
 * -------------------------------
 * Gegeven de depositieruimte en ontwikkelbehoefte, retourneert de klasse waar de confontratie in valt.
 * Uitgebreidere versie welke gebruikt wordt in de Summary en een WMS laag.
 */
CREATE OR REPLACE FUNCTION ae_get_delta_space_desire_range(v_space real, v_desire real)
	RETURNS delta_space_desire_range AS
$BODY$
DECLARE
	v_delta real;
BEGIN
	v_delta := v_space - v_desire;
	RETURN
		(CASE
			WHEN v_delta >= -1 AND v_delta <= 1 THEN 'equal'
			WHEN v_delta > 1 AND v_delta <= 35 THEN 'surplus_1-35'
			WHEN v_delta > 35 AND v_delta <= 70 THEN 'surplus_35-70'
			WHEN v_delta > 70 THEN 'surplus_70+'
			WHEN v_delta < -1 AND v_delta >= -35 THEN 'shortage_1-35'
			WHEN v_delta < -35 AND v_delta >= -70 THEN 'shortage_35-70'
			WHEN v_delta < -70 THEN 'shortage_70+'
		END);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_get_delta_space_desire_range_condensed
 * -----------------------------------------
 * Gegeven de depositieruimte en ontwikkelbehoefte, retourneert de klasse waar de confontratie in valt.
 * Ingekorte versie welke gebruikt wordt in de Gebiedssamenvatting.
 */
CREATE OR REPLACE FUNCTION ae_get_delta_space_desire_range_condensed(v_space real, v_desire real)
	RETURNS delta_space_desire_range_condensed AS
$BODY$
DECLARE
	v_delta real;
BEGIN
	v_delta := v_space - v_desire;
	RETURN
		(CASE
			WHEN v_delta > 0 AND v_delta <= 35 THEN 'surplus_1-35'
			WHEN v_delta > 35 THEN 'surplus_35+'
			WHEN v_delta < 0 AND v_delta >= -35 THEN 'shortage_1-35'
			WHEN v_delta < -35 AND v_delta >= -70 THEN 'shortage_35-70'
			WHEN v_delta < -70 THEN 'shortage_70+'
		END);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;