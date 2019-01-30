/*
 * ae_color_range_sfunc
 * --------------------
 * State function voor kleur bereik functie 'ae_color_range'.
 * Iedere v_value wordt binnen een bereik geplaatst.
 * Houdt een array bij met een element voor iedere bereik voor het aangegeven kleur bereik type,
 * en telt mbv 'v_weight' de binnenkomende waardes.
 */
CREATE OR REPLACE FUNCTION ae_color_range_sfunc(state ae_color_range_rs[], v_color_range_type color_range_type, v_value numeric, v_weight numeric)
	RETURNS ae_color_range_rs[] AS
$BODY$
DECLARE
	position integer;
	rec record;
BEGIN
	IF array_length(state, 1) IS NULL THEN
		FOR rec IN SELECT lower_value, color FROM system.color_ranges WHERE color_range_type = v_color_range_type ORDER BY lower_value LOOP
			state := state || (rec.lower_value, rec.color, 0)::ae_color_range_rs;
		END LOOP;
	END IF;

	position := rank FROM (SELECT lower_value, rank() OVER (order by lower_value)
			FROM system.color_ranges WHERE color_range_type = v_color_range_type
		) AS base
		WHERE lower_value = (SELECT (ae_color_range_lower_value(v_color_range_type, v_value)).lower_value);

	IF position IS NOT NULL THEN
		state[position] := (state[position].lower_value, state[position].color::text, state[position].total + v_weight)::ae_color_range_rs;
	END IF;
	RETURN state;
END;
$BODY$
LANGUAGE plpgsql STABLE RETURNS NULL ON NULL INPUT;


/*
 * ae_color_range
 * --------------
 * Aggregatie functie om (evt. gewogen) te tellen hoe vaak de waardes binnen een bereik voorkomen.
 * Eerste parameter is het type kleur bereik om te gebruiken, tweede parameter is het de waarde waarmee het juiste bereik bepaald moet worden
 * en de derde parameter is het gewicht waarmee deze waarde moet worden meegeteld.
 * Het gewicht kan bijvoorbeeld 1 zijn om aantal voorkomens te tellen, of een 'surface' kolom om oppervlaktes op te tellen.
 * Returnwaarde is een array met evenveel elementen als er bereiken zijn voor het type kleur bereik.
 * Ieder element bevat naast de laagste waarde en de kleur van het bereik ook het totaal van de gewichten.
 * NULL invoerwaardes worden overgeslagen. Als er helemaal geen niet-NULL waardes zijn, wordt NULL teruggegeven.
 */
CREATE AGGREGATE ae_color_range(color_range_type, numeric, numeric) (
	SFUNC = ae_color_range_sfunc,
	STYPE = ae_color_range_rs[],
	INITCOND = '{}'
);


/*
 * ae_color_range_lower_value
 * --------------------------
 * Bepaal de laagste waarde en de kleur van het bereik waar binnen de opgegeven waarde valt binnen een bepaald kleur bereik type.
 */
CREATE OR REPLACE FUNCTION ae_color_range_lower_value(v_color_range_type color_range_type, v_value real)
	RETURNS TABLE(lower_value real, color text) AS
$BODY$
BEGIN
	RETURN QUERY SELECT color_ranges.lower_value, color_ranges.color::text
		FROM system.color_ranges
		WHERE color_range_type = v_color_range_type
			AND v_value >= color_ranges.lower_value
		ORDER BY color_ranges.lower_value DESC
		LIMIT 1;
END;
$BODY$
LANGUAGE plpgsql STABLE;


/*
 * ae_color_range_from
 * -------------------
 * Bepaal de inhoud van color ranges voor een view (of tabel) op dynamische wijze.
 * Gaat uit van een weight van 1 per gevonden waarde.
 */
CREATE OR REPLACE FUNCTION ae_color_range_from(v_view regclass, v_column text, v_color_range_type color_range_type, v_where text = NULL)
	RETURNS SETOF ae_color_range_rs AS
$BODY$
DECLARE
	sql text;
	where_part text = '';
BEGIN
	IF v_where IS NOT NULL THEN
		where_part := ' WHERE ' || v_where;
	END IF;
	sql := 'SELECT (unnest(ae_color_range(''' || v_color_range_type || '''::color_range_type, ' || v_column || '::numeric, 1::numeric))).* FROM ' || v_view || where_part;
	RETURN QUERY EXECUTE sql;
END;
$BODY$
LANGUAGE plpgsql STABLE;
