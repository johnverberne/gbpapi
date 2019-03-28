-- insert test data for one calculation with 2 scenarios

INSERT INTO jobs (job_id,key,name,state,type,user_id) 
VALUES (1,'1', 'bomen maatregel', 'completed'::job_state_type, 'calculation'::job_type,1);
	
-- scenario 1
INSERT INTO calculations (calculation_id, calculation_uuid, state) 
VALUES (1,'1','completed'::calculation_state_type);

-- more than one scenarios more runs 
INSERT INTO job_calculations (job_id, calculation_id) VALUES (1,1);

-- create a job_progress to keep track of the progress
INSERT INTO job_progress (job_id, progress_count, max_progress, result_url) VALUES (1,1,2,'');

--- more than one result
INSERT INTO calculation_results (calculation_id, model, geolayer, data) values (1, 'air_regulation', 'TEEB_Afvang_van_PM10_door_groen.tiff',
'{"legendrgbmin": "ff0000", "code": 1001, "name": "TEEB_Afvang_van_PM10_door_groen", "min": 0.07163385301828384, "geobox": {"xmin": 140800.0, "ymin": 458580.0, "ymax": 459500.0, "xmax": 142170.0}, "max": 11.992888450622559, "sum": 38706.65625, "legendrgbmax": "00ff00", "legendmin": 0, "legendmax": 100, "units": "pm_10", "model": "air_regulation", "avg": 3.070981979370117, "class": "physical"}');

INSERT INTO calculation_results (calculation_id, model, geolayer, data) values (1, 'air_regulation', 'TEEB_Minder_gezondheidskosten_door_afvang_fijn_stof.tiff',
'{"legendrgbmin": "ff0000", "code": 1002, "name": "TEEB_Minder_gezondheidskosten_door_afvang_fijn_stof", "min": 3.132479429244995, "geobox": {"xmin": 140800.0, "ymin": 458580.0, "ymax": 459500.0, "xmax": 142170.0}, "max": 533.2514038085938, "sum": 1704185.5, "legendrgbmax": "00ff00", "legendmin": 0, "legendmax": 100, "units": "Euro", "model": "air_regulation", "avg": 135.20989990234375, "class": "monetary"}');


-- scenario 2
INSERT INTO calculations (calculation_id, calculation_uuid, state) 
VALUES (2,'2','completed'::calculation_state_type);

-- more than one scenarios more runs 
INSERT INTO job_calculations (job_id, calculation_id) VALUES (1,2);

-- update the progress_counter
UPDATE job_progress SET progress_count = 2 WHERE job_id = 1;

--- more than one result
INSERT INTO calculation_results (calculation_id, model, geolayer, data) values (2, 'air_regulation', 'TEEB_Afvang_van_PM10_door_groen.tiff',
'{"legendrgbmin": "ff0000", "code": 1001, "name": "TEEB_Afvang_van_PM10_door_groen", "min": 0.07163385301828384, "geobox": {"xmin": 140800.0, "ymin": 458580.0, "ymax": 459500.0, "xmax": 142170.0}, "max": 11.992888450622559, "sum": 38706.65625, "legendrgbmax": "00ff00", "legendmin": 0, "legendmax": 100, "units": "pm_10", "model": "air_regulation", "avg": 3.070981979370117, "class": "physical"}');

INSERT INTO calculation_results (calculation_id, model, geolayer, data) values (2, 'air_regulation', 'TEEB_Minder_gezondheidskosten_door_afvang_fijn_stof.tiff',
'{"legendrgbmin": "ff0000", "code": 1002, "name": "TEEB_Minder_gezondheidskosten_door_afvang_fijn_stof", "min": 3.132479429244995, "geobox": {"xmin": 140800.0, "ymin": 458580.0, "ymax": 459500.0, "xmax": 142170.0}, "max": 533.2514038085938, "sum": 1704185.5, "legendrgbmax": "00ff00", "legendmin": 0, "legendmax": 100, "units": "Euro", "model": "air_regulation", "avg": 135.20989990234375, "class": "monetary"}');


-- update job_state
---UPDATE jobs SET state = 'completed'::job_state_type WHERE job_id = 1;

