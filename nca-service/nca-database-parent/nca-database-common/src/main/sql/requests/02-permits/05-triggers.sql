CREATE TRIGGER ae_trigger_check_unique_dossier_id_per_authority BEFORE INSERT OR UPDATE ON permits
	FOR EACH ROW EXECUTE PROCEDURE ae_check_unique_dossier_id_per_authority();
