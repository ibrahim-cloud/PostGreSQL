PGDMP     :    	                y         
   PostGreSQL    13.2    13.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394 
   PostGreSQL    DATABASE     i   CREATE DATABASE "PostGreSQL" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'French_Morocco.1252';
    DROP DATABASE "PostGreSQL";
                postgres    false            �            1255    16405    calculpourcentage(integer)    FUNCTION     =  CREATE FUNCTION public.calculpourcentage(numberstudents integer) RETURNS integer
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
 @   DROP FUNCTION public.calculpourcentage(numberstudents integer);
       public          postgres    false            �            1255    16401 0   nbyoucoders(character varying, boolean, integer)    FUNCTION     V  CREATE FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer) RETURNS integer
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
 Z   DROP FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer);
       public          postgres    false            �            1255    16406    referentiel(character varying)    FUNCTION     ;  CREATE FUNCTION public.referentiel(student character varying) RETURNS integer
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
 =   DROP FUNCTION public.referentiel(student character varying);
       public          postgres    false            �            1255    16408    student_false()    FUNCTION     �   CREATE FUNCTION public.student_false() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE youcoders SET  is_accepted = false;
RETURN NEW ; 
END 
$$;
 &   DROP FUNCTION public.student_false();
       public          postgres    false            �            1255    16407    updateclasse() 	   PROCEDURE     �   CREATE PROCEDURE public.updateclasse()
    LANGUAGE sql
    AS $$
UPDATE youcoders
SET classe  = 'DATA BI'
WHERE nbr_competence=14 AND matricule LIKE '%2%'
$$;
 &   DROP PROCEDURE public.updateclasse();
       public          postgres    false            �            1255    16435    updatecompetence()    FUNCTION     �   CREATE FUNCTION public.updatecompetence() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
 UPDATE youcoders SET  nbr_competence = nbr_competence + 1 ;

RETURN NEW ;
END 
$$;
 )   DROP FUNCTION public.updatecompetence();
       public          postgres    false            �            1255    16441    updatecompetence1()    FUNCTION     �   CREATE FUNCTION public.updatecompetence1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
 UPDATE youcoders SET  nbr_competence = nbr_competence+0 ;
RETURN NEW ;
END 
$$;
 *   DROP FUNCTION public.updatecompetence1();
       public          postgres    false            �            1259    16444    city    TABLE     e   CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying NOT NULL
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    16395 	   youcoders    TABLE     G  CREATE TABLE public.youcoders (
    matricule character varying(4) NOT NULL,
    full_name character varying(15) NOT NULL,
    campus character varying(15) NOT NULL,
    classe character varying(15) NOT NULL,
    referentiel character varying(15) NOT NULL,
    nbr_competence numeric(5,0) DEFAULT 0,
    is_accepted boolean
);
    DROP TABLE public.youcoders;
       public         heap    postgres    false            �          0    16444    city 
   TABLE DATA           2   COPY public.city (city_id, city_name) FROM stdin;
    public          postgres    false    201          �          0    16395 	   youcoders 
   TABLE DATA           s   COPY public.youcoders (matricule, full_name, campus, classe, referentiel, nbr_competence, is_accepted) FROM stdin;
    public          postgres    false    200   ?       1           2606    16453    city city_name 
   CONSTRAINT     S   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_name PRIMARY KEY (city_name);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_name;
       public            postgres    false    201            /           2606    16400    youcoders youcoders_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.youcoders
    ADD CONSTRAINT youcoders_pkey PRIMARY KEY (matricule);
 B   ALTER TABLE ONLY public.youcoders DROP CONSTRAINT youcoders_pkey;
       public            postgres    false    200            -           1259    16459 "   fki_city_name too youcoders compus    INDEX     \   CREATE INDEX "fki_city_name too youcoders compus" ON public.youcoders USING btree (campus);
 8   DROP INDEX public."fki_city_name too youcoders compus";
       public            postgres    false    200            3           2620    16409    youcoders student_false    TRIGGER     t   CREATE TRIGGER student_false AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.student_false();
 0   DROP TRIGGER student_false ON public.youcoders;
       public          postgres    false    200    206            4           2620    16437    youcoders updatecompetence    TRIGGER     z   CREATE TRIGGER updatecompetence AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.updatecompetence();
 3   DROP TRIGGER updatecompetence ON public.youcoders;
       public          postgres    false    200    207            5           2620    16442    youcoders updatecompetence1    TRIGGER     |   CREATE TRIGGER updatecompetence1 AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.updatecompetence1();
 4   DROP TRIGGER updatecompetence1 ON public.youcoders;
       public          postgres    false    200    208            2           2606    16454 (   youcoders city_name too youcoders compus    FK CONSTRAINT     �   ALTER TABLE ONLY public.youcoders
    ADD CONSTRAINT "city_name too youcoders compus" FOREIGN KEY (campus) REFERENCES public.city(city_name) NOT VALID;
 T   ALTER TABLE ONLY public.youcoders DROP CONSTRAINT "city_name too youcoders compus";
       public          postgres    false    2865    201    200            �   !   x�3�,NL��2��/-.�/M�L����� a\      �   �   x�]��j�0���t/�|���ikj�!$t�!6�"���>}-iH�r��q.C�9^U��ئ��Ѥ�k7-����0%CY���LƌgF�{i[4�CQzLH	e�ed�52ۧ$=!�đ���ot��9{�4a��Gc/�c<Ӻ/�ʳ��c�}LZZ�"�X�K�蛮��_��KQ��u�wCWf���4�T%:_A����9E�U�Z.j����_���$�?`h�     