/*
 * sectorgroup
 * -----------
 * AERIUS sector group indeling
 */
CREATE TYPE system.sectorgroup AS ENUM
	('energy', 'agriculture', 'live_and_work', 'industry', 'mobile_equipment', 'rail_transportation', 
		'aviation', 'road_transportation', 'shipping', 'other', 'plan', 'road_freeway');
