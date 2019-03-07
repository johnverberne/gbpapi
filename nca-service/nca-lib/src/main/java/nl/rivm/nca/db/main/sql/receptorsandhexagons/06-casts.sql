/*
 * Cast definitie voor land_use_classification naar integer
 */
CREATE CAST (land_use_classification AS integer) WITH FUNCTION ae_enum_to_index(anyenum);


/*
 * Cast definitie voor integer naar land_use_classification
 */
CREATE CAST (integer AS land_use_classification) WITH FUNCTION ae_integer_to_land_use_classification(integer);