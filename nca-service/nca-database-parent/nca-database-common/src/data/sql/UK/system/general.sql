/*
 * Insert system constants.
 */

--INSERT INTO system.constants (key, value) VALUES ('HELP_VIDEO_URL', 'http://www.youtube.com/embed/fnafyZ9Y2Uc');

INSERT INTO system.constants (key, value) VALUES ('DEFAULT_LOCALE', 'en');

INSERT INTO system.constants (key, value) VALUES ('AERIUS_HOST', 'https://test.aerius.nl');
INSERT INTO system.constants (key, value) VALUES ('WEBAPPNAME_SCENARIO', 'scenario/');
INSERT INTO system.constants (key, value) VALUES ('WEBAPPNAME_CALCULATOR', 'calculator/');
INSERT INTO system.constants (key, value) VALUES ('GA_ACCOUNT_ID', 'UA-36804782-1');
INSERT INTO system.constants (key, value) VALUES ('GA_DOMAIN_NAME', 'aerius.nl');

-- Calculation config for both UI and workers
INSERT INTO system.constants (key, value) VALUES ('CALCULATION_MAX_DELAY_CHUNKS', '1000');
INSERT INTO system.constants (key, value) VALUES ('CALCULATION_MIN_RECEPTORS_FOR_DELAY', '200');

-- Calculation config for workers
INSERT INTO system.constants (key, value) VALUES ('MIN_RECEPTORS_WORKER', '100');
INSERT INTO system.constants (key, value) VALUES ('MAX_RECEPTORS_WORKER', '850000'); -- higher will crash ops
INSERT INTO system.constants (key, value) VALUES ('MAX_CONCURRENT_CHUNKS_WORKER', '8');
INSERT INTO system.constants (key, value) VALUES ('MAX_CALCULATION_ENGINE_UNITS_WORKER', '100000');

-- Task manager constants
INSERT into system.constants (key,value) VALUES ('TASK_BROKER_HOST', 'localhost');
INSERT into system.constants (key,value) VALUES ('TASK_BROKER_PORT', '5672');
INSERT into system.constants (key,value) VALUES ('TASK_BROKER_USERNAME', 'Aerius');
INSERT into system.constants (key,value) VALUES ('TASK_BROKER_PASSWORD', 'antiallergie');

-- Proxy url to the PDOX service
INSERT INTO system.constants (key, value) VALUES ('PDOX_PROXY_URL', 'https://pdok.aerius.nl/pdok/');
INSERT INTO system.constants (key, value) VALUES ('PAA_BACKGROUND_MAP_ID', '5');

-- email constants
INSERT INTO system.constants (key, value) VALUES ('NOREPLY_EMAIL', 'noreply@aerius.nl');
INSERT INTO system.constants (key, value) VALUES ('DEFAULT_FILE_MAIL_DOWNLOAD_LINK', 'https://test.aerius.nl/downloads/');

-- Help
INSERT INTO system.constants (key, value) VALUES ('HELP_URL_TEMPLATE', 'http://www.aerius.nl/node/');

-- Emission result display settings
INSERT INTO system.constants (key, value) VALUES ('EMISSION_RESULT_DISPLAY_CONVERSION_FACTOR', 0.014286);
INSERT INTO system.constants (key, value) VALUES ('EMISSION_RESULT_DISPLAY_UNIT', 'KILOGRAM_UNITS'); -- Option of: MOLAR_UNITS, KILOGRAM_UNITS
INSERT INTO system.constants (key, value) VALUES ('EMISSION_RESULT_DISPLAY_ROUNDING_LENGTH', 3);
INSERT INTO system.constants (key, value) VALUES ('EMISSION_RESULT_DISPLAY_PRECISE_ROUNDING_LENGTH', 4);
