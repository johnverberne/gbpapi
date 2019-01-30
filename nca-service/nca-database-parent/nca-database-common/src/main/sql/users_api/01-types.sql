/*
 * job_state_type
 * --------------
 * Geeft de status aan van een job.
 */
CREATE TYPE job_state_type AS ENUM
  ('initialized', 'running', 'cancelled', 'completed', 'deleted', 'error');

/*
 * job_type
 * --------
 * Type van een job.
 */
CREATE TYPE job_type AS ENUM
	('calculation', 'report', 'priority_project_utilisation');
