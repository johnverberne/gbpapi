/**
 * Adding permissions specific for the TEST environment.
 */
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_state_dequeue'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_state_enqueue'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('override_priority_projects_reservation'));
