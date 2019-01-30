/*
 * ae_percentile_sorted_array
 * --------------------------
 * Basis functie voor het berekenen van een percentiel op basis van een GESORTEERDE lijst.
 */
CREATE OR REPLACE FUNCTION ae_percentile_sorted_array(sorted_array numeric[], percentile int)
	RETURNS numeric AS
$BODY$
DECLARE
	array_size 		int;
	index 			int;
	percentile_by_index 	real;
BEGIN
	IF array_length(sorted_array, 1) IS NULL THEN -- No empty arrays
		RETURN NULL;
	END IF;

	array_size = array_length(sorted_array, 1);
	index = FLOOR( (array_size - 1) * percentile / 100.0) + 1;

	-- an array of n elements starts with array[1] and ends with array[n].
	IF index >= array_size THEN
		RETURN sorted_array[array_size];

	ELSE
		percentile_by_index = (index - 1) * 100.0 / (array_size - 1);

		RETURN sorted_array[index] + (array_size - 1) *
				((percentile - percentile_by_index) / 100.0) *
				(sorted_array[index + 1] - sorted_array[index]);

	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_percentile
 * -------------
 * Berekenen van een percentiel op basis van een ongesorteerde lijst.
 * Opmerking: Er is geen AGGREGATE van deze functie omdat deze veel slechter performed.
 */
CREATE OR REPLACE FUNCTION ae_percentile(unsorted_array numeric[], percentile int)
	RETURNS numeric AS
$BODY$
BEGIN
	RETURN ae_percentile_sorted_array((SELECT array_agg(v) FROM (SELECT v FROM unnest(unsorted_array) AS v WHERE v IS NOT NULL ORDER BY 1) AS t), percentile);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_median
 * ---------
 * Berekenen van de mediaan op basis van een ongesorteerde lijst. Identiek aan percentiel 50%.
 * Opmerking: Er is geen AGGREGATE van deze functie omdat deze veel slechter performed.
 */
CREATE OR REPLACE FUNCTION ae_median(unsorted_array numeric[])
	RETURNS numeric AS
$BODY$
BEGIN
	RETURN ae_percentile(unsorted_array, 50);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT;

---------------------------------------------------------------------------------------------

/*
 * ae_max_with_key_sfunc
 * ---------------------
 * State function voor 'ae_max_with_key'.
 */
CREATE OR REPLACE FUNCTION ae_max_with_key_sfunc(state numeric[2], e1 numeric, e2 numeric)
	RETURNS numeric[2] AS
$BODY$
BEGIN
	IF state[2] > e2 OR e2 IS NULL THEN
		RETURN state;
	ELSE
		RETURN ARRAY[e1, e2];
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_max_with_key_ffunc
 * ---------------------
 * Final function voor 'ae_max_with_key'.
 * Wordt gebruikt om eindresultaat in een type te vormen.
 */
CREATE OR REPLACE FUNCTION ae_max_with_key_ffunc(state numeric[2])
	RETURNS ae_key_value_rs AS
$BODY$
BEGIN
	RETURN (state[1], state[2]);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;


/*
 * ae_max_with_key
 * ---------------
 * Aggregate functie voor het bepalen van de maximum value in een lijst van key-values waarbij zowel key als value worden teruggegeven.
 * Input bestaat uit 2 numeric argumenten, 1e wordt opgevat als de key, 2e als de value.
 * Output is een ae_key_value_rs (wat ook bestaat uit key als numeric, value als numeric).
 */
CREATE AGGREGATE ae_max_with_key(numeric, numeric) (
	SFUNC = ae_max_with_key_sfunc,
	STYPE = numeric[2],
	FINALFUNC = ae_max_with_key_ffunc,
	INITCOND = '{NULL,NULL}'
);

---------------------------------------------------------------------------------------------

/*
 * ae_weighted_avg_sfunc
 * ---------------------
 * State function voor gewogen gemiddelde functie 'ae_weighted_avg'.
 * Verzameld totaal van gewogen waardes en totaal van gewichten in een 2-dimensionale array.
 */
CREATE OR REPLACE FUNCTION ae_weighted_avg_sfunc(state numeric[], value numeric, weight numeric)
	RETURNS numeric[] AS
$BODY$
BEGIN
	RETURN ARRAY[COALESCE(state[1], 0) + (value * weight), COALESCE(state[2], 0) + weight];
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_weighted_avg_ffunc
 * ---------------------
 * Final function voor gewogen gemiddelde functie 'ae_weighted_avg'.
 * Deelt totaal van gewogen waardes door totaal van gewichten (was verzameld in een 2-dimensionale array).
 */
CREATE OR REPLACE FUNCTION ae_weighted_avg_ffunc(state numeric[])
	RETURNS numeric AS
$BODY$
BEGIN
	IF state[2] = 0 THEN
		RETURN 0;
	ELSE
		RETURN state[1] / state[2];
	END IF;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_weighted_avg
 * ---------------
 * Aggregatie functie om gewogen gemiddelde te berekenen.
 * Eerste parameter is de waarde, tweede parameter is het gewicht.
 * NULL invoerwaardes worden overgeslagen. Als er helemaal geen niet-NULL waardes zijn, wordt NULL teruggegeven.
 */
CREATE AGGREGATE ae_weighted_avg(numeric, numeric) (
	SFUNC = ae_weighted_avg_sfunc,
	STYPE = numeric[],
	FINALFUNC = ae_weighted_avg_ffunc,
	INITCOND = '{NULL,NULL}'
);

---------------------------------------------------------------------------------------------

/*
 * ae_distribute_enum_sfunc
 * ------------------------
 * State function voor enum distributie unctie 'ae_distribute_enum'.
 * Houdt een array bij met een element voor iedere waarde in de enum, en telt mbv 'weight' de binnenkomende enumwaardes.
 */
CREATE OR REPLACE FUNCTION ae_distribute_enum_sfunc(state numeric[], key anyenum, weight numeric)
	RETURNS numeric[] AS
$BODY$
BEGIN
	IF array_length(state, 1) IS NULL THEN
		state := array_fill(0, ARRAY[array_length(enum_range(key), 1)]);
	END IF;
	state[ae_enum_to_index(key)] := state[ae_enum_to_index(key)] + weight;
	RETURN state;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_distribute_enum
 * ------------------
 * Aggregatie functie om (evt. gewogen) te tellen hoevaak de waardes van een enum voorkomen.
 * Eerste parameter is een enum waarde, tweede parameter is het gewicht waarmee deze waarde moet worden meegeteld.
 * Het gewicht kan bijvoorbeeld 1 zijn om aantal voorkomens te tellen, of een 'surface' kolom om oppervlaktes op te tellen.
 * Returnwaarde is een array met evenveel elementen als waardes in de enum (en ook in die volgorde). Ieder element geeft de
 * optelling voor die enumwaarde aan.
 * NULL invoerwaardes worden overgeslagen. Als er helemaal geen niet-NULL waardes zijn, wordt NULL teruggegeven.
 */
CREATE AGGREGATE ae_distribute_enum(anyenum, numeric) (
	SFUNC = ae_distribute_enum_sfunc,
	STYPE = numeric[],
	INITCOND = '{}'
);