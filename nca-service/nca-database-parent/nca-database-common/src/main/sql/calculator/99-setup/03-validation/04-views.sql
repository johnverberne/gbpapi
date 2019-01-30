/*
 * system_years_view
 * -----------------
 * Used by the validation functions to get the full range of years from MIN_YEAR to MAX_YEAR.
 */
CREATE OR REPLACE VIEW setup.system_years_view AS
SELECT
	year::year_type

	FROM generate_series(
		(SELECT value::integer FROM system.constants WHERE key = 'MIN_YEAR'),
		(SELECT value::integer FROM system.constants WHERE key = 'MAX_YEAR')
	) AS year
;
