--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-04-27 10:09:34

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
-- TOC entry 203 (class 1255 OID 16405)
-- Name: calculpourcentage(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculpourcentage(numberstudents integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
y INTEGER ;
POURCENTAGE NUMERIC ;
BEGIN 
SELECT COUNT(*) INTO y FROM youcoders where campus='Youssoufia' and classe = 'FEBE';
POURCENTAGE =( numberStudents * y )/100;
return POURCENTAGE ;
END 
$$;


ALTER FUNCTION public.calculpourcentage(numberstudents integer) OWNER TO postgres;

--
-- TOC entry 202 (class 1255 OID 16401)
-- Name: nbyoucoders(character varying, boolean, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;
BEGIN
SELECT COUNT(*) INTO n FROM youcoders where is_accepted=status and campus = ville;
IF n < seuil THEN
RAISE EXCEPTION 'Trop de rattrapage (%) !', n;
ELSE
RETURN n;
END IF;
END
$$;


ALTER FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer) OWNER TO postgres;

--
-- TOC entry 204 (class 1255 OID 16406)
-- Name: referentiel(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.referentiel(student character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
declare
MemeClasse VARCHAR;
y INTEGER ;
BEGIN 
SELECT classe into MemeClasse FROM youcoders where full_name = student ;
SELECT COUNT (*) into y from youcoders where classe = MemeClasse;
return y;
end 
$$;


ALTER FUNCTION public.referentiel(student character varying) OWNER TO postgres;

--
-- TOC entry 206 (class 1255 OID 16408)
-- Name: student_false(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.student_false() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE youcoders SET  is_accepted = false;
RETURN NEW ; 
END 
$$;


ALTER FUNCTION public.student_false() OWNER TO postgres;

--
-- TOC entry 205 (class 1255 OID 16407)
-- Name: updateclasse(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.updateclasse()
    LANGUAGE sql
    AS $$
UPDATE youcoders
SET classe  = 'DATA BI'
WHERE nbr_competence=14 AND matricule LIKE '%2%'
$$;


ALTER PROCEDURE public.updateclasse() OWNER TO postgres;

--
-- TOC entry 207 (class 1255 OID 16435)
-- Name: updatecompetence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updatecompetence() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
 UPDATE youcoders SET  nbr_competence = nbr_competence + 1 ;

RETURN NEW ;
END 
$$;


ALTER FUNCTION public.updatecompetence() OWNER TO postgres;

--
-- TOC entry 208 (class 1255 OID 16441)
-- Name: updatecompetence1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updatecompetence1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
 UPDATE youcoders SET  nbr_competence = nbr_competence+0 ;
RETURN NEW ;
END 
$$;


ALTER FUNCTION public.updatecompetence1() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16444)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16395)
-- Name: youcoders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.youcoders (
    matricule character varying(4) NOT NULL,
    full_name character varying(15) NOT NULL,
    campus character varying(15) NOT NULL,
    classe character varying(15) NOT NULL,
    referentiel character varying(15) NOT NULL,
    nbr_competence numeric(5,0) DEFAULT 0,
    is_accepted boolean
);


ALTER TABLE public.youcoders OWNER TO postgres;

--
-- TOC entry 3001 (class 0 OID 16444)
-- Dependencies: 201
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (city_id, city_name) FROM stdin;
1	safi
2	Youssoufia
\.


--
-- TOC entry 3000 (class 0 OID 16395)
-- Dependencies: 200
-- Data for Name: youcoders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.youcoders (matricule, full_name, campus, classe, referentiel, nbr_competence, is_accepted) FROM stdin;
P400	KAMAL BHF	safi	FEBE	CDA	24	f
P765	Mohammed ahmed	safi	JEE	DWWM	17	f
P122	Amine amine	safi	C#	CDA	22	f
P202	Yassine yassine	Youssoufia	PHP	CDA	21	f
P980	Don Reda	safi	JEE	DWWM	14	f
P543	Salma Salma	Youssoufia	C#	AI	15	f
P307	Zakaria zakaria	safi	FEBE	CDA	18	f
P199	Omar omar	safi	JEE	AI	13	f
P387	Houssam houssam	safi	FEBE	CDA	16	f
P566	Imane imane	Youssoufia	FEBE	CDA	15	f
\.


--
-- TOC entry 2865 (class 2606 OID 16453)
-- Name: city city_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_name PRIMARY KEY (city_name);


--
-- TOC entry 2863 (class 2606 OID 16400)
-- Name: youcoders youcoders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youcoders
    ADD CONSTRAINT youcoders_pkey PRIMARY KEY (matricule);


--
-- TOC entry 2861 (class 1259 OID 16459)
-- Name: fki_city_name too youcoders compus; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_city_name too youcoders compus" ON public.youcoders USING btree (campus);


--
-- TOC entry 2867 (class 2620 OID 16409)
-- Name: youcoders student_false; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER student_false AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.student_false();


--
-- TOC entry 2868 (class 2620 OID 16437)
-- Name: youcoders updatecompetence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER updatecompetence AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.updatecompetence();


--
-- TOC entry 2869 (class 2620 OID 16442)
-- Name: youcoders updatecompetence1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER updatecompetence1 AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.updatecompetence1();


--
-- TOC entry 2866 (class 2606 OID 16454)
-- Name: youcoders city_name too youcoders compus; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youcoders
    ADD CONSTRAINT "city_name too youcoders compus" FOREIGN KEY (campus) REFERENCES public.city(city_name) NOT VALID;


-- Completed on 2021-04-27 10:09:35

--
-- PostgreSQL database dump complete
--

