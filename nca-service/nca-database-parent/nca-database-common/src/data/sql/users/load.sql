/*
 * Insert the default roles
 */
INSERT INTO userroles(name, color) VALUES ('register_viewer', '7BD148');
INSERT INTO userroles(name, color) VALUES ('register_editor', '4986E7');
INSERT INTO userroles(name, color) VALUES ('register_superuser', 'F83A22');
INSERT INTO userroles(name, color) VALUES ('register_admin', '8F8F8F');
INSERT INTO userroles(name, color) VALUES ('register_special', '9FE1E7');


/*
 * Insert the permissions.
 */
INSERT INTO userpermissions(name) VALUES ('view_permits');
INSERT INTO userpermissions(name) VALUES ('add_new_permit');
INSERT INTO userpermissions(name) VALUES ('view_priority_projects');
INSERT INTO userpermissions(name) VALUES ('add_new_priority_project_reservation');
INSERT INTO userpermissions(name) VALUES ('add_new_priority_project');
INSERT INTO userpermissions(name) VALUES ('add_new_priority_subproject');
INSERT INTO userpermissions(name) VALUES ('update_permit_date');
INSERT INTO userpermissions(name) VALUES ('update_permit_handler');
INSERT INTO userpermissions(name) VALUES ('update_permit_dossier_number');
INSERT INTO userpermissions(name) VALUES ('update_permit_remarks');
INSERT INTO userpermissions(name) VALUES ('update_permit_mark');
INSERT INTO userpermissions(name) VALUES ('update_permit_state');
INSERT INTO userpermissions(name) VALUES ('update_permit_state_dequeue');
INSERT INTO userpermissions(name) VALUES ('update_permit_state_enqueue');
INSERT INTO userpermissions(name) VALUES ('update_permit_state_enqueue_rejected_without_space');
INSERT INTO userpermissions(name) VALUES ('update_permit_state_assigned_final_to_rejected');
INSERT INTO userpermissions(name) VALUES ('update_permit_state_reject_final');
INSERT INTO userpermissions(name) VALUES ('delete_permit_inactive_initial');
INSERT INTO userpermissions(name) VALUES ('delete_permit_all');
INSERT INTO userpermissions(name) VALUES ('update_priority_project');
INSERT INTO userpermissions(name) VALUES ('delete_priority_project');
INSERT INTO userpermissions(name) VALUES ('revert_priority_project_assign_complete');
INSERT INTO userpermissions(name) VALUES ('update_priority_subproject_state');
INSERT INTO userpermissions(name) VALUES ('update_priority_subproject_state_assigned_final_to_rejected');
INSERT INTO userpermissions(name) VALUES ('update_priority_subproject_state_reject_final');
INSERT INTO userpermissions(name) VALUES ('delete_priority_subproject');
INSERT INTO userpermissions(name) VALUES ('view_pronouncements');
INSERT INTO userpermissions(name) VALUES ('administer_users');
INSERT INTO userpermissions(name) VALUES ('confirm_pronouncement');
INSERT INTO userpermissions(name) VALUES ('delete_pronouncement');
INSERT INTO userpermissions(name) VALUES ('export_requests');
INSERT INTO userpermissions(name) VALUES ('override_priority_projects_reservation');


/*
 * Assign permissions to the roles
 */
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_viewer'), ae_get_userpermission_id('view_permits'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_viewer'), ae_get_userpermission_id('view_pronouncements'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_viewer'), ae_get_userpermission_id('view_priority_projects'));

INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('view_permits'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('add_new_permit'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_permit_date'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_permit_handler'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_permit_remarks'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_permit_dossier_number'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_permit_mark'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_permit_state'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_permit_state_reject_final'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('delete_permit_all'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('view_pronouncements'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('delete_pronouncement'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('add_new_priority_subproject'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('view_priority_projects'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_priority_subproject_state'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('update_priority_subproject_state_reject_final'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('delete_priority_subproject'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_editor'), ae_get_userpermission_id('export_requests'));

INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('view_permits'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('add_new_permit'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_date'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_handler'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_remarks'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_dossier_number'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_mark'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_state'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_state_enqueue_rejected_without_space'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_state_assigned_final_to_rejected'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_permit_state_reject_final'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('delete_permit_all'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('delete_priority_project'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('delete_priority_subproject'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('view_pronouncements'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('delete_pronouncement'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('export_requests'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('view_priority_projects'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('add_new_priority_project'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('add_new_priority_subproject'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_priority_project'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_priority_subproject_state'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_priority_subproject_state_assigned_final_to_rejected'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_superuser'), ae_get_userpermission_id('update_priority_subproject_state_reject_final'));

INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_admin'), ae_get_userpermission_id('view_permits'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_admin'), ae_get_userpermission_id('view_pronouncements'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_admin'), ae_get_userpermission_id('view_priority_projects'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_admin'), ae_get_userpermission_id('administer_users'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_admin'), ae_get_userpermission_id('revert_priority_project_assign_complete'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_admin'), ae_get_userpermission_id('add_new_priority_project_reservation'));

INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_special'), ae_get_userpermission_id('view_permits'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_special'), ae_get_userpermission_id('view_pronouncements'));
INSERT INTO userroles_to_permissions(userrole_id, permission_id) VALUES (ae_get_userrole_id('register_special'), ae_get_userpermission_id('view_priority_projects'));
