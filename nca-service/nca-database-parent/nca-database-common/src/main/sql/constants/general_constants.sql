/**
 * Drempelwaarde. Als een receptor meer depositie heeft dan deze drempelwaarde, dan is er op zijn minst een
 * melding moodzaklijk. Onder de drempelwaarde hoeft er niets geregisteerd te worden.
 */
INSERT INTO constants (key, value) VALUES ('PRONOUNCEMENT_THRESHOLD_VALUE', '0.05');

/**
 * Standaard grenswaarde. Als een receptor meer depositie heeft dan deze grenswaarde, dan is een vergunning
 * noodzakelijk. De grenswaarde kan per toetsgebied worden ingesteld, maar dit is de default.
 */
INSERT INTO constants (key, value) VALUES ('DEFAULT_PERMIT_THRESHOLD_VALUE', '1.0');

/**
 * Deze factor (percentage) bepaalt wanneer de grenswaarde moet worden aangepast van 1.0 naar 0.05 mol (oftewel
 * verlaagd naar de drempelwaarde). Dit is het geval wanneer dit percentage van de grenswaardereservering op
 * tenminste 1 hexagoon binnen een gebied bereikt is. Bijvoorbeeld bij 95%: de grenswaardereservering is dan
 * bijna op.
 */
INSERT INTO constants (key, value) VALUES ('PRONOUNCEMENT_SPACE_ALMOST_FULL_TRIGGER', '0.95');

/**
 * Als tenminste 1 hexagoon binnen een gebied minder dan dit aantal mol vrije depositieruimte heeft, dan
 * zal dit worden aangegeven op het Register Dashboard met een rood kruisje.
 */
INSERT INTO constants (key, value) VALUES ('ASSESSMENT_AREA_NO_AVAILABLE_SPACE_THRESHOLD', '1.0');

/**
 * De gestelde deadline (in dagen) waarbinnen een aanvragen in Register opgenomen hoort te zijn.
 * Na het verstrijken van de termijn mag Register en vanuit gaan dat de wachtrij niet meer zal wijzigen.
 */
INSERT INTO constants (key, value) VALUES ('PERMIT_RECEIVED_DATE_TERM', '28');



INSERT INTO constants (key, value) VALUES ('CONVERT_INLAND_SHIPPING_LINE_TO_POINTS_SEGMENT_SIZE', '25');


INSERT INTO constants (key, value) VALUES ('WORST_CASE_Z0', '1.6');
INSERT INTO constants (key, value) VALUES ('WORST_CASE_LAND_USE', 'bebouwing');
