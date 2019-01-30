/*
 * road_type
 * ---------
 * Type van wegen.
 */
CREATE TYPE road_type AS ENUM
	('urban_road', 'non_urban_road', 'freeway');


/*
 * vehicle_type
 * ------------
 * Type van verkeer.
 */
CREATE TYPE vehicle_type AS ENUM
	('light_traffic', 'normal_freight', 'heavy_freight', 'auto_bus');


/*
 * speed_limit_enforcement_type
 * ----------------------------
 * Type van snelheid handhaving.
 */
CREATE TYPE speed_limit_enforcement_type AS ENUM
	('strict', 'not_strict', 'irrelevant');