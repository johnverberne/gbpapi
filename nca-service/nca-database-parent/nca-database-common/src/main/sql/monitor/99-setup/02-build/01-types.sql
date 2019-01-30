/*
 * sectorgroup
 * -----------
 * De 6 sectorgroepen die we momenteel in AERIUS-monitor onderscheiden.
 */
CREATE TYPE setup.sectorgroup AS ENUM
	('agriculture', 'industry', 'shipping', 'road_transportation', 'road_freeway', 'other');



/*
 * deposition_correction_type
 * --------------------------
 * Type depositiecorrectie.
 */
CREATE TYPE setup.deposition_correction_type AS ENUM
	('farm_stagnation_correction', 'rwc_correction', 'post_correction');
