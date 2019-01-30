CREATE TRIGGER ae_trigger_protect_table BEFORE INSERT OR UPDATE OR DELETE ON system.layer_properties
	FOR EACH ROW EXECUTE PROCEDURE ae_protect_table();

CREATE TRIGGER ae_trigger_check_new_layer_properties_id BEFORE INSERT OR UPDATE ON system.tms_layer_properties
	FOR EACH ROW EXECUTE PROCEDURE system.ae_check_new_layer_properties_id();

CREATE TRIGGER ae_trigger_check_new_layer_properties_id BEFORE INSERT OR UPDATE ON system.wms_layer_properties
	FOR EACH ROW EXECUTE PROCEDURE system.ae_check_new_layer_properties_id();
