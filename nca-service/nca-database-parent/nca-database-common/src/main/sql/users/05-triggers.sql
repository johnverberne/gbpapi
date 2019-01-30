CREATE TRIGGER ae_trigger_users BEFORE INSERT OR UPDATE ON users
	FOR EACH ROW EXECUTE PROCEDURE ae_users_ensure_uniqueness();
