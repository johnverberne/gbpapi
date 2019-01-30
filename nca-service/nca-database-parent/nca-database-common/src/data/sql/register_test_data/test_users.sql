BEGIN;
	DO $BODY$
	DECLARE
		v_authority_id_1 integer;
		v_authority_id_2 integer;
	BEGIN

		v_authority_id_1 := (SELECT MIN(authority_id) FROM authorities);
		v_authority_id_2 := (SELECT MAX(authority_id) FROM authorities);

		/*
		 * Temporary inserts of example users.
		 */
		-- Test users: each role one and AERIUS authority
		PERFORM ae_add_user('aeriusmail+1@gmail.com',    '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'aeriusmail+1@gmail.com',               'A.', 'AERIUS1', 'Test1',                v_authority_id_1, 'register_admin');
		PERFORM ae_add_user('aeriusmail+2@gmail.com',    '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'aeriusmail+2@gmail.com',               'A.', 'AERIUS2', 'Test2',                v_authority_id_1, 'register_viewer');
		PERFORM ae_add_user('aeriusmail+3@gmail.com',    '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'aeriusmail+3@gmail.com',               'A.', 'AERIUS3', 'Test3',                v_authority_id_1, 'register_editor');
		PERFORM ae_add_user('aeriusmail+4@gmail.com',    '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'aeriusmail+4@gmail.com',               'A.', 'AERIUS4', 'Test4',                v_authority_id_1, 'register_superuser');

		 -- Test users: old ones, left for testing purposes
		PERFORM ae_add_user('test',                      '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'test@aerius.nl',                       'T.', 'Tinus', 'Testaccount',            v_authority_id_1, 'register_admin');
		PERFORM ae_add_user('test1',                     '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'test+1@aerius.nl',                     'B.', 'Bing', 'Go',                      v_authority_id_1, 'register_viewer');
		PERFORM ae_add_user('test2',                     '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'test+2@aerius.nl',                     'S.', 'Sam', 'Bal',                      v_authority_id_1, 'register_editor');
		PERFORM ae_add_user('test3',                     '$shiro1$SHA-256$500000$gXBHk4Cvfhw9xWZJJaSDeg==$EbxbRqKxKZJw1DyT4n2BOH/0nJBc32PwQEwfHT+kGnM=', 'test+3@aerius.nl',                     'R.', 'Robin', 'Hoedjes',                v_authority_id_1, 'register_superuser');

		-- Users for register and melding workers. Needed to get audit trail when worker changes status because calculation results added.
		-- Ensure this has superuser permissions with at least UPDATE_PERMIT_STATE + UPDATE_PERMIT_STATE_ENQUEUE.
		PERFORM ae_add_user('register_worker',           NULL,                                                                                           'register_worker@aerius.nl',            'R.', 'Register', 'Worker',              v_authority_id_1, NULL);
		PERFORM ae_add_user('melding_worker',            NULL,                                                                                           'melding_worker@aerius.nl',             'M.', 'Melding', 'Worker',               v_authority_id_1, NULL);

		/*
		 * Temporary inserts of the authority settings.
		 */
		INSERT INTO authority_settings (authority_id, setting_key, setting_value) VALUES (v_authority_id_1,  'NO_PERMIT_NOTICE_CONFIRMATION', 'BATCH_CONFIRM');
		INSERT INTO authority_settings (authority_id, setting_key, setting_value) VALUES (v_authority_id_2,  'NO_PERMIT_NOTICE_CONFIRMATION', 'ONE_BY_ONE_CONFIRM');

	END;
	$BODY$;

COMMIT;