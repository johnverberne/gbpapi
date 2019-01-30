
/*
 * task_schedulers
 * ---------------
 * Taskscheduler definities.
 * Een scheduler beheert de taken die naar een bepaalde groep workers gestuurd worden.
 */
CREATE TABLE system.task_schedulers (
	task_scheduler_id serial NOT NULL,
	name text NOT NULL,
	description text,

	CONSTRAINT task_schedulers_pkey PRIMARY KEY (task_scheduler_id)
);

/*
 * task_scheduler_queues
 * ---------------------
 * Taskqueue definities.
 * Een queue behoort tot een taskscheduler en bevat de informatie voor het gebruik van een queue.
 * Hier wordt onder andere prioriteit en de maximum capaciteit aan workers die een queue mag gebruiken vermeld.
 */
CREATE TABLE system.task_scheduler_queues (
	task_scheduler_id integer NOT NULL,
	name varchar NOT NULL,
	description varchar,
	priority integer NOT NULL,
	max_capacity_use fraction NOT NULL,

	CONSTRAINT task_scheduler_queues_pkey PRIMARY KEY (task_scheduler_id, name),
	CONSTRAINT task_scheduler_queues_fkey_task_schedulers FOREIGN KEY (task_scheduler_id) REFERENCES system.task_schedulers
);
