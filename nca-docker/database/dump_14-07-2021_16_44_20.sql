--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE nca;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md53175bce1d3201d16594cebf9d7eb3f9d';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "nca" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: nca; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE nca WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE nca OWNER TO postgres;

\connect nca

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: job_state_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.job_state_type AS ENUM (
    'initialized',
    'running',
    'cancelled',
    'completed',
    'deleted',
    'error'
);


ALTER TYPE public.job_state_type OWNER TO postgres;

--
-- Name: TYPE job_state_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.job_state_type IS 'Geeft de status aan van een job.

@file nca-database-gbp/src/main/sql/users_api/01-types.sql';


--
-- Name: job_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.job_type AS ENUM (
    'calculation'
);


ALTER TYPE public.job_type OWNER TO postgres;

--
-- Name: TYPE job_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.job_type IS 'Type van een job.

@file nca-database-gbp/src/main/sql/users_api/01-types.sql';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: job_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_progress (
    job_id integer NOT NULL,
    progress_count bigint DEFAULT 0 NOT NULL,
    max_progress bigint DEFAULT 0 NOT NULL,
    start_time timestamp with time zone,
    pick_up_time timestamp with time zone,
    end_time timestamp with time zone,
    result_url text
);


ALTER TABLE public.job_progress OWNER TO postgres;

--
-- Name: TABLE job_progress; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.job_progress IS 'Tabel om de voortgang van een (Connect) rekenjob bij te houden.

@column progress_count Aantal scenarios doorgerekend
@column aantal scenarios in de berkening
@column start_time Tijd dat de job door de gebruiker is aangeboden
@column pick_up_time Tijd dat de job opgepakt wordt uit de que om te rekenen, of NULL indien nog niet opgepakt
@column end_time Tijd dat de job voltooide, of NULL indien (nog) niet succesvol afgerond
@column result_url URL naar het bestand waarin de resultaten terug te vinden zijn, of NULL indien de job nog niet voltooid is

@file nca-database-gbp/src/main/sql/users_api/02-tables.sql';


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    job_id integer NOT NULL,
    key text NOT NULL,
    name text,
    state public.job_state_type DEFAULT 'initialized'::public.job_state_type NOT NULL,
    type public.job_type NOT NULL,
    user_id bigint NOT NULL,
    error_message text
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: TABLE jobs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.jobs IS 'Rekenjobs die opgepakt zijn of kunnen worden door de worker.
Een job is de verzameling van (1 of 2) situaties in een berekening, en er wordt bijgehouden welke gebruiker de job aangemaakt heeft.
Dezelfde gebruiker kan verschillende jobs aan zich gekoppeld hebben.
De job key wordt gegenereerd en gebruikt door de worker om de koppeling tussen de job en de worker taak bij te houden.

@file nca-database-gbp/src/main/sql/users_api/02-tables.sql';


--
-- Name: job_progress_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.job_progress_view AS
 SELECT jobs.job_id,
    jobs.type,
    jobs.name,
    jobs.state,
    jobs.user_id,
    jobs.key,
    job_progress.start_time,
    job_progress.pick_up_time,
    job_progress.end_time,
    job_progress.progress_count,
    job_progress.max_progress,
    job_progress.result_url,
    jobs.error_message
   FROM (public.jobs
     JOIN public.job_progress USING (job_id));


ALTER TABLE public.job_progress_view OWNER TO postgres;

--
-- Name: VIEW job_progress_view; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.job_progress_view IS 'Geeft voortgang terug van alle jobs van gebruikers. Koppelt met de berekeningen om daarvan de status en aanmaaktijd op te vragen.

@file nca-database-gbp/src/main/sql/users_api/04-views.sql';


--
-- Name: jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_job_id_seq OWNER TO postgres;

--
-- Name: jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_job_id_seq OWNED BY public.jobs.job_id;


--
-- Name: measures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measures (
    measures_id integer NOT NULL,
    key text NOT NULL,
    name text NOT NULL,
    version text,
    user_id integer NOT NULL,
    measures text NOT NULL,
    validated boolean DEFAULT true,
    active boolean DEFAULT true,
    upload_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.measures OWNER TO postgres;

--
-- Name: measures_measures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.measures_measures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measures_measures_id_seq OWNER TO postgres;

--
-- Name: measures_measures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measures_measures_id_seq OWNED BY public.measures.measures_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    api_key text NOT NULL,
    email_address text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    max_concurrent_jobs integer NOT NULL,
    CONSTRAINT users_email_address_check CHECK ((email_address = lower(email_address)))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.users IS 'Gebruikers voor Scenario. Zij worden uniek geïdentificeerd op basis van e-mail adres of API-key.

@column api_key De API-key is bedoeld voor gebruikers die berekeningen doen via de Connect-webservice. Aan de hand hiervan kan het systeem dan de user_id opzoeken.
@column max_concurrent_jobs Het maximaal aantal jobs dat de gebruiker tegelijkertijd mag uitvoeren.

@file nca-database-gbp/src/main/sql/users_api/02-tables.sql';


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: jobs job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN job_id SET DEFAULT nextval('public.jobs_job_id_seq'::regclass);


--
-- Name: measures measures_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures ALTER COLUMN measures_id SET DEFAULT nextval('public.measures_measures_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: job_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_progress (job_id, progress_count, max_progress, start_time, pick_up_time, end_time, result_url) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (job_id, key, name, state, type, user_id, error_message) FROM stdin;
\.


--
-- Data for Name: measures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measures (measures_id, key, name, version, user_id, measures, validated, active, upload_date) FROM stdin;
1	M1	M1	1	3	{"measures":[{"id":1,"code":"GREENROOFS","description":"veel","runmodel":false,"layers":[{"layer":"TREES","value":50}]}]}	t	t	2021-06-21 14:17:29.39829+00
2	M2	M2	1	3	{"measures":[{"id":1,"code":"GREENROOFS","description":"veel","runmodel":false,"layers":[{"layer":"TREES","value":50}]}]}	t	t	2021-06-21 14:17:33.572638+00
6	M3	M3	1	3	{"measures":[{"id":1,"code":"GREENROOFS","description":"veel","runmodel":false,"layers":[{"layer":"TREES","value":50}]}]}	t	t	2021-06-21 14:34:13.234291+00
7	M10	M10	1	3	{"measures":[{"id":1,"code":"GREENROOFS","description":"veel","runmodel":true,"layers":[{"layer":"TREES","value":50}]}]}	t	t	2021-06-21 15:58:19.109139+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, api_key, email_address, enabled, max_concurrent_jobs) FROM stdin;
1	7e58f7214f694cf09d31556cf884dd49	johnverberne@gmail.com	t	9
2	f3af1658365446fd98665f31bdf03281	john@gmail.com	t	9
3	0000-0000-0000-0000	true\n	t	9
4	45d6efcb6aae4ff2b1d212b6dee05bce	b@b.com	t	9
\.


--
-- Name: jobs_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_job_id_seq', 1, false);


--
-- Name: measures_measures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measures_measures_id_seq', 7, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 4, true);


--
-- Name: job_progress job_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_progress
    ADD CONSTRAINT job_progress_pkey PRIMARY KEY (job_id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (job_id);


--
-- Name: measures measures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures
    ADD CONSTRAINT measures_pkey PRIMARY KEY (measures_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_unique_api_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_unique_api_key UNIQUE (api_key);


--
-- Name: users users_unique_email_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_unique_email_address UNIQUE (email_address);


--
-- Name: idx_jobs_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_jobs_key ON public.jobs USING btree (key);


--
-- Name: idx_jobs_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_jobs_user_id ON public.jobs USING btree (user_id);


--
-- Name: job_progress job_progress_fkey_jobs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_progress
    ADD CONSTRAINT job_progress_fkey_jobs FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- Name: jobs jobs_fkey_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_fkey_users FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

