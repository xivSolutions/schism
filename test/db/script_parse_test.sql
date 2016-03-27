--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: schema_one; Type: SCHEMA; Schema: -; Owner: xivSolutions
--

CREATE SCHEMA schema_one;


ALTER SCHEMA schema_one OWNER TO "xivSolutions";

--
-- Name: schema_two; Type: SCHEMA; Schema: -; Owner: xivSolutions
--

CREATE SCHEMA schema_two;


ALTER SCHEMA schema_two OWNER TO "xivSolutions";

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

--
-- Name: increment(integer); Type: FUNCTION; Schema: public; Owner: xivSolutions
--

CREATE FUNCTION increment(i integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
        begin
                return i + 1;
        end;
$$;


ALTER FUNCTION public.increment(i integer) OWNER TO "xivSolutions";

--
-- Name: multiply(integer, integer); Type: FUNCTION; Schema: public; Owner: xivSolutions
--

CREATE FUNCTION multiply(i integer, j integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
        begin
                return i + j;
        end;
$$;


ALTER FUNCTION public.multiply(i integer, j integer) OWNER TO "xivSolutions";

SET search_path = schema_one, pg_catalog;

--
-- Name: say_goodbye(integer, integer); Type: FUNCTION; Schema: schema_one; Owner: xivSolutions
--

CREATE FUNCTION say_goodbye(i integer, j integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
        begin
                return 'goodbye';
        end;
$$;


ALTER FUNCTION schema_one.say_goodbye(i integer, j integer) OWNER TO "xivSolutions";

--
-- Name: say_hello(integer); Type: FUNCTION; Schema: schema_one; Owner: xivSolutions
--

CREATE FUNCTION say_hello(i integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
        begin
                return 'hello!';
        end;
$$;


ALTER FUNCTION schema_one.say_hello(i integer) OWNER TO "xivSolutions";

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: albums; Type: TABLE; Schema: public; Owner: xivSolutions
--

CREATE TABLE albums (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    title text NOT NULL,
    track_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE albums OWNER TO "xivSolutions";

--
-- Name: artists; Type: TABLE; Schema: public; Owner: xivSolutions
--

CREATE TABLE artists (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE artists OWNER TO "xivSolutions";

--
-- Name: album_artists; Type: VIEW; Schema: public; Owner: xivSolutions
--

CREATE VIEW album_artists AS
 SELECT ar.id,
    ar.name,
    al.title,
    al.track_count
   FROM (artists ar
     JOIN albums al ON ((al.artist_id = ar.id)));


ALTER TABLE album_artists OWNER TO "xivSolutions";

--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: xivSolutions
--

CREATE SEQUENCE albums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE albums_id_seq OWNER TO "xivSolutions";

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xivSolutions
--

ALTER SEQUENCE albums_id_seq OWNED BY albums.id;


--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: xivSolutions
--

CREATE SEQUENCE artists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE artists_id_seq OWNER TO "xivSolutions";

--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xivSolutions
--

ALTER SEQUENCE artists_id_seq OWNED BY artists.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: xivSolutions
--

CREATE TABLE users (
    email text NOT NULL,
    last_name character varying(255),
    first_name character varying(255),
    created_on timestamp with time zone DEFAULT now() NOT NULL,
    search tsvector,
    deleted boolean
);


ALTER TABLE users OWNER TO "xivSolutions";

SET search_path = schema_one, pg_catalog;

--
-- Name: actors; Type: TABLE; Schema: schema_one; Owner: xivSolutions
--

CREATE TABLE actors (
    id integer NOT NULL,
    last_name text,
    first_name text
);


ALTER TABLE actors OWNER TO "xivSolutions";

--
-- Name: actors_id_seq; Type: SEQUENCE; Schema: schema_one; Owner: xivSolutions
--

CREATE SEQUENCE actors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actors_id_seq OWNER TO "xivSolutions";

--
-- Name: actors_id_seq; Type: SEQUENCE OWNED BY; Schema: schema_one; Owner: xivSolutions
--

ALTER SEQUENCE actors_id_seq OWNED BY actors.id;


--
-- Name: movies; Type: TABLE; Schema: schema_one; Owner: xivSolutions
--

CREATE TABLE movies (
    id integer NOT NULL,
    title text NOT NULL,
    release_date date
);


ALTER TABLE movies OWNER TO "xivSolutions";

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: schema_one; Owner: xivSolutions
--

CREATE SEQUENCE movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE movies_id_seq OWNER TO "xivSolutions";

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: schema_one; Owner: xivSolutions
--

ALTER SEQUENCE movies_id_seq OWNED BY movies.id;


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: xivSolutions
--

ALTER TABLE ONLY albums ALTER COLUMN id SET DEFAULT nextval('albums_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: xivSolutions
--

ALTER TABLE ONLY artists ALTER COLUMN id SET DEFAULT nextval('artists_id_seq'::regclass);


SET search_path = schema_one, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: schema_one; Owner: xivSolutions
--

ALTER TABLE ONLY actors ALTER COLUMN id SET DEFAULT nextval('actors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: schema_one; Owner: xivSolutions
--

ALTER TABLE ONLY movies ALTER COLUMN id SET DEFAULT nextval('movies_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: albums_pkey; Type: CONSTRAINT; Schema: public; Owner: xivSolutions
--

ALTER TABLE ONLY albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: artists_pkey; Type: CONSTRAINT; Schema: public; Owner: xivSolutions
--

ALTER TABLE ONLY artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: xivSolutions
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


SET search_path = schema_one, pg_catalog;

--
-- Name: actors_pkey; Type: CONSTRAINT; Schema: schema_one; Owner: xivSolutions
--

ALTER TABLE ONLY actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (id);


--
-- Name: movies_pkey; Type: CONSTRAINT; Schema: schema_one; Owner: xivSolutions
--

ALTER TABLE ONLY movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

