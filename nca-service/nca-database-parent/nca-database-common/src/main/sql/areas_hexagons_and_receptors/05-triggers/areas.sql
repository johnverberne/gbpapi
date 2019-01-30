CREATE TRIGGER ae_trigger_protect_table BEFORE INSERT OR UPDATE OR DELETE ON assessment_areas
	FOR EACH ROW EXECUTE PROCEDURE ae_protect_table();

CREATE TRIGGER ae_trigger_check_new_assessment_area_id BEFORE INSERT OR UPDATE ON natura2000_areas
	FOR EACH ROW EXECUTE PROCEDURE ae_check_new_assessment_area_id();

CREATE TRIGGER ae_trigger_check_new_assessment_area_id BEFORE INSERT OR UPDATE ON natura2000_directive_areas
	FOR EACH ROW EXECUTE PROCEDURE ae_check_new_assessment_area_id();