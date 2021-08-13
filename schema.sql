--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4 (Debian 13.4-1.pgdg100+1)
-- Dumped by pg_dump version 13.4 (Debian 13.4-1.pgdg100+1)

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
-- Name: authtokenstatus; Type: TYPE; Schema: public; Owner: authpass
--

CREATE TYPE public.authtokenstatus AS ENUM (
    'created',
    'active',
    'disabled'
);


ALTER TYPE public.authtokenstatus OWNER TO authpass;

--
-- Name: version_significance; Type: TYPE; Schema: public; Owner: authpass
--

CREATE TYPE public.version_significance AS ENUM (
    'firstOfHour',
    'firstOfDay',
    'firstOfWeek',
    'firstOfMonth',
    'firstOfQuarter',
    'firstOfYear',
    'firstVersion'
);


ALTER TYPE public.version_significance OWNER TO authpass;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_token; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.auth_token (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token character varying NOT NULL,
    status public.authtokenstatus NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    user_agent character varying NOT NULL
);


ALTER TABLE public.auth_token OWNER TO authpass;

--
-- Name: authpass_migration; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.authpass_migration (
    id integer NOT NULL,
    applied_at timestamp without time zone NOT NULL,
    version integer NOT NULL,
    version_code character varying NOT NULL
);


ALTER TABLE public.authpass_migration OWNER TO authpass;

--
-- Name: authpass_migration_id_seq; Type: SEQUENCE; Schema: public; Owner: authpass
--

CREATE SEQUENCE public.authpass_migration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authpass_migration_id_seq OWNER TO authpass;

--
-- Name: authpass_migration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: authpass
--

ALTER SEQUENCE public.authpass_migration_id_seq OWNED BY public.authpass_migration.id;


--
-- Name: email_mailbox; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.email_mailbox (
    id uuid NOT NULL,
    address character varying NOT NULL,
    label character varying NOT NULL,
    client_entry_uuid character varying NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    disabled_at timestamp without time zone,
    hidden_at timestamp without time zone
);


ALTER TABLE public.email_mailbox OWNER TO authpass;

--
-- Name: email_message; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.email_message (
    id uuid NOT NULL,
    mailbox_id uuid NOT NULL,
    message text NOT NULL,
    size integer NOT NULL,
    sender character varying NOT NULL,
    subject character varying(200) NOT NULL,
    read_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.email_message OWNER TO authpass;

--
-- Name: filecloud_file; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.filecloud_file (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id uuid NOT NULL,
    name character varying NOT NULL,
    last_content_id uuid NOT NULL,
    owner_token character varying NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.filecloud_file OWNER TO authpass;

--
-- Name: filecloud_file_content; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.filecloud_file_content (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    file_id uuid NOT NULL,
    user_id uuid NOT NULL,
    bytes bytea NOT NULL,
    length integer NOT NULL,
    version_significance public.version_significance
);


ALTER TABLE public.filecloud_file_content OWNER TO authpass;

--
-- Name: filecloud_token; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.filecloud_token (
    token character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    file_id uuid NOT NULL,
    token_type character varying DEFAULT 'creator'::character varying NOT NULL,
    label character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.filecloud_token OWNER TO authpass;

--
-- Name: user; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public."user" (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."user" OWNER TO authpass;

--
-- Name: user_email; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.user_email (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    email_address character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    confirmed_at timestamp without time zone
);


ALTER TABLE public.user_email OWNER TO authpass;

--
-- Name: user_email_confirm; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.user_email_confirm (
    email_id uuid NOT NULL,
    token character varying NOT NULL,
    auth_token_id uuid,
    confirmed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.user_email_confirm OWNER TO authpass;

--
-- Name: website; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.website (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    best_image_id uuid,
    url character varying NOT NULL,
    url_canonical character varying NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    error_code character varying
);


ALTER TABLE public.website OWNER TO authpass;

--
-- Name: website_image; Type: TABLE; Schema: public; Owner: authpass
--

CREATE TABLE public.website_image (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    website_id uuid NOT NULL,
    url character varying NOT NULL,
    mime_type character varying NOT NULL,
    bytes bytea NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    brightness double precision NOT NULL,
    image_type character varying NOT NULL,
    original_byte_length integer,
    filename character varying NOT NULL
);


ALTER TABLE public.website_image OWNER TO authpass;

--
-- Name: authpass_migration id; Type: DEFAULT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.authpass_migration ALTER COLUMN id SET DEFAULT nextval('public.authpass_migration_id_seq'::regclass);


--
-- Name: auth_token auth_token_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.auth_token
    ADD CONSTRAINT auth_token_pkey PRIMARY KEY (id);


--
-- Name: auth_token auth_token_token_key; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.auth_token
    ADD CONSTRAINT auth_token_token_key UNIQUE (token);


--
-- Name: authpass_migration authpass_migration_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.authpass_migration
    ADD CONSTRAINT authpass_migration_pkey PRIMARY KEY (id);


--
-- Name: email_mailbox email_mailbox_address_key; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.email_mailbox
    ADD CONSTRAINT email_mailbox_address_key UNIQUE (address);


--
-- Name: email_mailbox email_mailbox_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.email_mailbox
    ADD CONSTRAINT email_mailbox_pkey PRIMARY KEY (id);


--
-- Name: email_message email_message_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.email_message
    ADD CONSTRAINT email_message_pkey PRIMARY KEY (id);


--
-- Name: filecloud_file_content filecloud_file_content_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_file_content
    ADD CONSTRAINT filecloud_file_content_pkey PRIMARY KEY (id);


--
-- Name: filecloud_file filecloud_file_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_file
    ADD CONSTRAINT filecloud_file_pkey PRIMARY KEY (id);


--
-- Name: filecloud_token filecloud_token_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_token
    ADD CONSTRAINT filecloud_token_pkey PRIMARY KEY (token);


--
-- Name: user_email_confirm user_email_confirm_token_key; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.user_email_confirm
    ADD CONSTRAINT user_email_confirm_token_key UNIQUE (token);


--
-- Name: user_email user_email_email_address_key; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.user_email
    ADD CONSTRAINT user_email_email_address_key UNIQUE (email_address);


--
-- Name: user_email user_email_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.user_email
    ADD CONSTRAINT user_email_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: website_image website_image_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.website_image
    ADD CONSTRAINT website_image_pkey PRIMARY KEY (id);


--
-- Name: website website_pkey; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.website
    ADD CONSTRAINT website_pkey PRIMARY KEY (id);


--
-- Name: website website_url_key; Type: CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.website
    ADD CONSTRAINT website_url_key UNIQUE (url);


--
-- Name: mailbox_address; Type: INDEX; Schema: public; Owner: authpass
--

CREATE INDEX mailbox_address ON public.email_mailbox USING btree (address);


--
-- Name: website_url_canonical_idx; Type: INDEX; Schema: public; Owner: authpass
--

CREATE INDEX website_url_canonical_idx ON public.website USING btree (url_canonical);


--
-- Name: auth_token auth_token_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.auth_token
    ADD CONSTRAINT auth_token_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: email_mailbox email_mailbox_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.email_mailbox
    ADD CONSTRAINT email_mailbox_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: email_message email_message_mailbox_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.email_message
    ADD CONSTRAINT email_message_mailbox_id_fkey FOREIGN KEY (mailbox_id) REFERENCES public.email_mailbox(id);


--
-- Name: filecloud_file_content filecloud_file_content_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_file_content
    ADD CONSTRAINT filecloud_file_content_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.filecloud_file(id);


--
-- Name: filecloud_file_content filecloud_file_content_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_file_content
    ADD CONSTRAINT filecloud_file_content_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: filecloud_file filecloud_file_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_file
    ADD CONSTRAINT filecloud_file_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: filecloud_token filecloud_token_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_token
    ADD CONSTRAINT filecloud_token_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.filecloud_file(id);


--
-- Name: filecloud_file last_content_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_file
    ADD CONSTRAINT last_content_id_fkey FOREIGN KEY (last_content_id) REFERENCES public.filecloud_file_content(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filecloud_file owner_token_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.filecloud_file
    ADD CONSTRAINT owner_token_fkey FOREIGN KEY (owner_token) REFERENCES public.filecloud_token(token) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_email_confirm user_email_confirm_auth_token_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.user_email_confirm
    ADD CONSTRAINT user_email_confirm_auth_token_id_fkey FOREIGN KEY (auth_token_id) REFERENCES public.auth_token(id);


--
-- Name: user_email_confirm user_email_confirm_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.user_email_confirm
    ADD CONSTRAINT user_email_confirm_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.user_email(id);


--
-- Name: user_email user_email_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.user_email
    ADD CONSTRAINT user_email_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: website website_best_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.website
    ADD CONSTRAINT website_best_image_id_fkey FOREIGN KEY (best_image_id) REFERENCES public.website_image(id);


--
-- Name: website_image website_image_website_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: authpass
--

ALTER TABLE ONLY public.website_image
    ADD CONSTRAINT website_image_website_id_fkey FOREIGN KEY (website_id) REFERENCES public.website(id);


--
-- PostgreSQL database dump complete
--

