PGDMP                         }            nims_db %   12.22 (Ubuntu 12.22-0ubuntu0.20.04.2)    15.0 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16391    nims_db    DATABASE     s   CREATE DATABASE nims_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE nims_db;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �           0    0    SCHEMA public    ACL     }   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT CREATE ON SCHEMA public TO nims_user;
                   postgres    false    7            �           1247    17345 	   TypeGroup    TYPE     �   CREATE TYPE public."TypeGroup" AS ENUM (
    'Vehicle',
    'GPS',
    'Sensor',
    'Accessory',
    'Server',
    'Operator'
);
    DROP TYPE public."TypeGroup";
       public       	   nims_user    false    7            �            1259    17491 	   Accessory    TABLE     !  CREATE TABLE public."Accessory" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    type_id integer NOT NULL,
    qty integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Accessory";
       public         heap 	   nims_user    false    7            �            1259    17489    Accessory_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Accessory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Accessory_id_seq";
       public       	   nims_user    false    226    7            �           0    0    Accessory_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."Accessory_id_seq" OWNED BY public."Accessory".id;
          public       	   nims_user    false    225            �            1259    17431    Brand    TABLE     �   CREATE TABLE public."Brand" (
    id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_id integer
);
    DROP TABLE public."Brand";
       public         heap 	   nims_user    false    7    655            �            1259    17429    Brand_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Brand_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Brand_id_seq";
       public       	   nims_user    false    216    7            �           0    0    Brand_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Brand_id_seq" OWNED BY public."Brand".id;
          public       	   nims_user    false    215            �            1259    17371    Client    TABLE     ;  CREATE TABLE public."Client" (
    id integer NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    city text,
    state text,
    country text,
    postal text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Client";
       public         heap 	   nims_user    false    7            �            1259    17369    Client_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Client_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Client_id_seq";
       public       	   nims_user    false    7    206            �           0    0    Client_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Client_id_seq" OWNED BY public."Client".id;
          public       	   nims_user    false    205            �            1259    17383    ContactPerson    TABLE     U  CREATE TABLE public."ContactPerson" (
    id integer NOT NULL,
    client_id integer NOT NULL,
    name text NOT NULL,
    role_id integer NOT NULL,
    phone text NOT NULL,
    email text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 #   DROP TABLE public."ContactPerson";
       public         heap 	   nims_user    false    7            �            1259    17381    ContactPerson_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ContactPerson_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."ContactPerson_id_seq";
       public       	   nims_user    false    7    208            �           0    0    ContactPerson_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."ContactPerson_id_seq" OWNED BY public."ContactPerson".id;
          public       	   nims_user    false    207            �            1259    17455 	   GPSDevice    TABLE     �  CREATE TABLE public."GPSDevice" (
    id integer NOT NULL,
    vehicle_id integer NOT NULL,
    brand_id integer NOT NULL,
    model_id integer NOT NULL,
    imei text NOT NULL,
    serial_no text NOT NULL,
    warranty_plan_id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."GPSDevice";
       public         heap 	   nims_user    false    7            �            1259    17453    GPSDevice_id_seq    SEQUENCE     �   CREATE SEQUENCE public."GPSDevice_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."GPSDevice_id_seq";
       public       	   nims_user    false    220    7            �           0    0    GPSDevice_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."GPSDevice_id_seq" OWNED BY public."GPSDevice".id;
          public       	   nims_user    false    219            �            1259    17512    InstallationEngineer    TABLE     �   CREATE TABLE public."InstallationEngineer" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    server_id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 *   DROP TABLE public."InstallationEngineer";
       public         heap 	   nims_user    false    7            �            1259    17510    InstallationEngineer_id_seq    SEQUENCE     �   CREATE SEQUENCE public."InstallationEngineer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."InstallationEngineer_id_seq";
       public       	   nims_user    false    7    230            �           0    0    InstallationEngineer_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."InstallationEngineer_id_seq" OWNED BY public."InstallationEngineer".id;
          public       	   nims_user    false    229            �            1259    17443    Model    TABLE     (  CREATE TABLE public."Model" (
    id integer NOT NULL,
    brand_id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Model";
       public         heap 	   nims_user    false    7    655            �            1259    17441    Model_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Model_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Model_id_seq";
       public       	   nims_user    false    218    7            �           0    0    Model_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Model_id_seq" OWNED BY public."Model".id;
          public       	   nims_user    false    217            �            1259    17479 
   Peripheral    TABLE     �  CREATE TABLE public."Peripheral" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    sensor_type_id integer NOT NULL,
    brand_id integer NOT NULL,
    model_id integer NOT NULL,
    serial_no text NOT NULL,
    qty integer NOT NULL,
    warranty_plan_id integer NOT NULL,
    warranty_expiry_date timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
     DROP TABLE public."Peripheral";
       public         heap 	   nims_user    false    7            �            1259    17477    Peripheral_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Peripheral_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Peripheral_id_seq";
       public       	   nims_user    false    224    7            �           0    0    Peripheral_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Peripheral_id_seq" OWNED BY public."Peripheral".id;
          public       	   nims_user    false    223            �            1259    17395    Role    TABLE     �   CREATE TABLE public."Role" (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Role";
       public         heap 	   nims_user    false    7            �            1259    17393    Role_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Role_id_seq";
       public       	   nims_user    false    210    7            �           0    0    Role_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Role_id_seq" OWNED BY public."Role".id;
          public       	   nims_user    false    209            �            1259    17500    Server    TABLE     �  CREATE TABLE public."Server" (
    id integer NOT NULL,
    type_id integer NOT NULL,
    domain text NOT NULL,
    installed_date timestamp(3) without time zone NOT NULL,
    subscription_plan_id integer NOT NULL,
    expire_date timestamp(3) without time zone NOT NULL,
    invoice_no text,
    object_base_fee integer NOT NULL,
    gps_device_id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Server";
       public         heap 	   nims_user    false    7            �            1259    17498    Server_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Server_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Server_id_seq";
       public       	   nims_user    false    228    7            �           0    0    Server_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Server_id_seq" OWNED BY public."Server".id;
          public       	   nims_user    false    227            �            1259    17467    SimCard    TABLE       CREATE TABLE public."SimCard" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    phone_no text NOT NULL,
    operator text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."SimCard";
       public         heap 	   nims_user    false    7            �            1259    17465    SimCard_id_seq    SEQUENCE     �   CREATE SEQUENCE public."SimCard_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."SimCard_id_seq";
       public       	   nims_user    false    7    222            �           0    0    SimCard_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."SimCard_id_seq" OWNED BY public."SimCard".id;
          public       	   nims_user    false    221            �            1259    17419    Type    TABLE     �   CREATE TABLE public."Type" (
    id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public."Type";
       public         heap 	   nims_user    false    7    655            �            1259    17417    Type_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Type_id_seq";
       public       	   nims_user    false    7    214            �           0    0    Type_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Type_id_seq" OWNED BY public."Type".id;
          public       	   nims_user    false    213            �            1259    17359    User    TABLE     ?  CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    role_id integer NOT NULL,
    phone text NOT NULL,
    email text NOT NULL,
    password text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."User";
       public         heap 	   nims_user    false    7            �            1259    17357    User_id_seq    SEQUENCE     �   CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."User_id_seq";
       public       	   nims_user    false    204    7            �           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public       	   nims_user    false    203            �            1259    17407    Vehicle    TABLE     �  CREATE TABLE public."Vehicle" (
    id integer NOT NULL,
    client_id integer NOT NULL,
    plate_number text NOT NULL,
    type_id integer NOT NULL,
    brand_id integer NOT NULL,
    model_id integer NOT NULL,
    year integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    odometer text
);
    DROP TABLE public."Vehicle";
       public         heap 	   nims_user    false    7            �            1259    17405    Vehicle_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Vehicle_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Vehicle_id_seq";
       public       	   nims_user    false    7    212            �           0    0    Vehicle_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Vehicle_id_seq" OWNED BY public."Vehicle".id;
          public       	   nims_user    false    211            �            1259    17521    WarrantyPlan    TABLE     �   CREATE TABLE public."WarrantyPlan" (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 "   DROP TABLE public."WarrantyPlan";
       public         heap 	   nims_user    false    7            �            1259    17519    WarrantyPlan_id_seq    SEQUENCE     �   CREATE SEQUENCE public."WarrantyPlan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."WarrantyPlan_id_seq";
       public       	   nims_user    false    232    7            �           0    0    WarrantyPlan_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."WarrantyPlan_id_seq" OWNED BY public."WarrantyPlan".id;
          public       	   nims_user    false    231            �            1259    17334    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap 	   nims_user    false    7            �           2604    17494    Accessory id    DEFAULT     p   ALTER TABLE ONLY public."Accessory" ALTER COLUMN id SET DEFAULT nextval('public."Accessory_id_seq"'::regclass);
 =   ALTER TABLE public."Accessory" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    226    225    226            �           2604    17434    Brand id    DEFAULT     h   ALTER TABLE ONLY public."Brand" ALTER COLUMN id SET DEFAULT nextval('public."Brand_id_seq"'::regclass);
 9   ALTER TABLE public."Brand" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    215    216    216            �           2604    17374 	   Client id    DEFAULT     j   ALTER TABLE ONLY public."Client" ALTER COLUMN id SET DEFAULT nextval('public."Client_id_seq"'::regclass);
 :   ALTER TABLE public."Client" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    205    206    206            �           2604    17386    ContactPerson id    DEFAULT     x   ALTER TABLE ONLY public."ContactPerson" ALTER COLUMN id SET DEFAULT nextval('public."ContactPerson_id_seq"'::regclass);
 A   ALTER TABLE public."ContactPerson" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    208    207    208            �           2604    17458    GPSDevice id    DEFAULT     p   ALTER TABLE ONLY public."GPSDevice" ALTER COLUMN id SET DEFAULT nextval('public."GPSDevice_id_seq"'::regclass);
 =   ALTER TABLE public."GPSDevice" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    219    220    220            �           2604    17515    InstallationEngineer id    DEFAULT     �   ALTER TABLE ONLY public."InstallationEngineer" ALTER COLUMN id SET DEFAULT nextval('public."InstallationEngineer_id_seq"'::regclass);
 H   ALTER TABLE public."InstallationEngineer" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    229    230    230            �           2604    17446    Model id    DEFAULT     h   ALTER TABLE ONLY public."Model" ALTER COLUMN id SET DEFAULT nextval('public."Model_id_seq"'::regclass);
 9   ALTER TABLE public."Model" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    218    217    218            �           2604    17482    Peripheral id    DEFAULT     r   ALTER TABLE ONLY public."Peripheral" ALTER COLUMN id SET DEFAULT nextval('public."Peripheral_id_seq"'::regclass);
 >   ALTER TABLE public."Peripheral" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    224    223    224            �           2604    17398    Role id    DEFAULT     f   ALTER TABLE ONLY public."Role" ALTER COLUMN id SET DEFAULT nextval('public."Role_id_seq"'::regclass);
 8   ALTER TABLE public."Role" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    209    210    210            �           2604    17503 	   Server id    DEFAULT     j   ALTER TABLE ONLY public."Server" ALTER COLUMN id SET DEFAULT nextval('public."Server_id_seq"'::regclass);
 :   ALTER TABLE public."Server" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    227    228    228            �           2604    17470 
   SimCard id    DEFAULT     l   ALTER TABLE ONLY public."SimCard" ALTER COLUMN id SET DEFAULT nextval('public."SimCard_id_seq"'::regclass);
 ;   ALTER TABLE public."SimCard" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    221    222    222            �           2604    17422    Type id    DEFAULT     f   ALTER TABLE ONLY public."Type" ALTER COLUMN id SET DEFAULT nextval('public."Type_id_seq"'::regclass);
 8   ALTER TABLE public."Type" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    214    213    214            �           2604    17362    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    203    204    204            �           2604    17410 
   Vehicle id    DEFAULT     l   ALTER TABLE ONLY public."Vehicle" ALTER COLUMN id SET DEFAULT nextval('public."Vehicle_id_seq"'::regclass);
 ;   ALTER TABLE public."Vehicle" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    211    212    212            �           2604    17524    WarrantyPlan id    DEFAULT     v   ALTER TABLE ONLY public."WarrantyPlan" ALTER COLUMN id SET DEFAULT nextval('public."WarrantyPlan_id_seq"'::regclass);
 @   ALTER TABLE public."WarrantyPlan" ALTER COLUMN id DROP DEFAULT;
       public       	   nims_user    false    231    232    232            �          0    17491 	   Accessory 
   TABLE DATA           \   COPY public."Accessory" (id, device_id, type_id, qty, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    226   G�       �          0    17431    Brand 
   TABLE DATA           M   COPY public."Brand" (id, name, type_group, "createdAt", type_id) FROM stdin;
    public       	   nims_user    false    216   d�       �          0    17371    Client 
   TABLE DATA           m   COPY public."Client" (id, name, address, city, state, country, postal, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    206   ɱ       �          0    17383    ContactPerson 
   TABLE DATA           o   COPY public."ContactPerson" (id, client_id, name, role_id, phone, email, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    208   :�       �          0    17455 	   GPSDevice 
   TABLE DATA           �   COPY public."GPSDevice" (id, vehicle_id, brand_id, model_id, imei, serial_no, warranty_plan_id, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    220   ��       �          0    17512    InstallationEngineer 
   TABLE DATA           U   COPY public."InstallationEngineer" (id, user_id, server_id, "createdAt") FROM stdin;
    public       	   nims_user    false    230   ��       �          0    17443    Model 
   TABLE DATA           [   COPY public."Model" (id, brand_id, name, type_group, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    218   ݲ       �          0    17479 
   Peripheral 
   TABLE DATA           �   COPY public."Peripheral" (id, device_id, sensor_type_id, brand_id, model_id, serial_no, qty, warranty_plan_id, warranty_expiry_date, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    224   ��       �          0    17395    Role 
   TABLE DATA           D   COPY public."Role" (id, name, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    210   ��       �          0    17500    Server 
   TABLE DATA           �   COPY public."Server" (id, type_id, domain, installed_date, subscription_plan_id, expire_date, invoice_no, object_base_fee, gps_device_id, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    228   h�       �          0    17467    SimCard 
   TABLE DATA           `   COPY public."SimCard" (id, device_id, phone_no, operator, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    222   ��       �          0    17419    Type 
   TABLE DATA           C   COPY public."Type" (id, name, type_group, "createdAt") FROM stdin;
    public       	   nims_user    false    214   ��       �          0    17359    User 
   TABLE DATA           e   COPY public."User" (id, name, role_id, phone, email, password, "createdAt", "updatedAt") FROM stdin;
    public       	   nims_user    false    204   �       �          0    17407    Vehicle 
   TABLE DATA           �   COPY public."Vehicle" (id, client_id, plate_number, type_id, brand_id, model_id, year, "createdAt", "updatedAt", odometer) FROM stdin;
    public       	   nims_user    false    212   c�       �          0    17521    WarrantyPlan 
   TABLE DATA           ?   COPY public."WarrantyPlan" (id, name, "createdAt") FROM stdin;
    public       	   nims_user    false    232   ��       �          0    17334    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public       	   nims_user    false    202   ��       �           0    0    Accessory_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Accessory_id_seq"', 1, false);
          public       	   nims_user    false    225            �           0    0    Brand_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Brand_id_seq"', 26, true);
          public       	   nims_user    false    215            �           0    0    Client_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Client_id_seq"', 1, true);
          public       	   nims_user    false    205            �           0    0    ContactPerson_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."ContactPerson_id_seq"', 2, true);
          public       	   nims_user    false    207            �           0    0    GPSDevice_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."GPSDevice_id_seq"', 1, false);
          public       	   nims_user    false    219            �           0    0    InstallationEngineer_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."InstallationEngineer_id_seq"', 1, false);
          public       	   nims_user    false    229            �           0    0    Model_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Model_id_seq"', 9, true);
          public       	   nims_user    false    217            �           0    0    Peripheral_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Peripheral_id_seq"', 1, false);
          public       	   nims_user    false    223            �           0    0    Role_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public."Role_id_seq"', 5, true);
          public       	   nims_user    false    209            �           0    0    Server_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Server_id_seq"', 1, false);
          public       	   nims_user    false    227            �           0    0    SimCard_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."SimCard_id_seq"', 1, false);
          public       	   nims_user    false    221            �           0    0    Type_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public."Type_id_seq"', 2, true);
          public       	   nims_user    false    213            �           0    0    User_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public."User_id_seq"', 1, true);
          public       	   nims_user    false    203            �           0    0    Vehicle_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Vehicle_id_seq"', 1, false);
          public       	   nims_user    false    211            �           0    0    WarrantyPlan_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."WarrantyPlan_id_seq"', 1, false);
          public       	   nims_user    false    231                       2606    17497    Accessory Accessory_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_pkey";
       public         	   nims_user    false    226                       2606    17440    Brand Brand_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Brand" DROP CONSTRAINT "Brand_pkey";
       public         	   nims_user    false    216                       2606    17380    Client Client_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Client" DROP CONSTRAINT "Client_pkey";
       public         	   nims_user    false    206                       2606    17392     ContactPerson ContactPerson_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_pkey";
       public         	   nims_user    false    208                       2606    17464    GPSDevice GPSDevice_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_pkey";
       public         	   nims_user    false    220                       2606    17518 .   InstallationEngineer InstallationEngineer_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_pkey" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_pkey";
       public         	   nims_user    false    230                       2606    17452    Model Model_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Model"
    ADD CONSTRAINT "Model_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Model" DROP CONSTRAINT "Model_pkey";
       public         	   nims_user    false    218                       2606    17488    Peripheral Peripheral_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_pkey";
       public         	   nims_user    false    224                       2606    17404    Role Role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Role" DROP CONSTRAINT "Role_pkey";
       public         	   nims_user    false    210                       2606    17509    Server Server_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_pkey";
       public         	   nims_user    false    228                       2606    17476    SimCard SimCard_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."SimCard"
    ADD CONSTRAINT "SimCard_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."SimCard" DROP CONSTRAINT "SimCard_pkey";
       public         	   nims_user    false    222            
           2606    17428    Type Type_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Type"
    ADD CONSTRAINT "Type_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Type" DROP CONSTRAINT "Type_pkey";
       public         	   nims_user    false    214                        2606    17368    User User_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
       public         	   nims_user    false    204                       2606    17416    Vehicle Vehicle_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_pkey";
       public         	   nims_user    false    212                       2606    17530    WarrantyPlan WarrantyPlan_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."WarrantyPlan"
    ADD CONSTRAINT "WarrantyPlan_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."WarrantyPlan" DROP CONSTRAINT "WarrantyPlan_pkey";
       public         	   nims_user    false    232            �           2606    17343 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public         	   nims_user    false    202                       1259    17531    GPSDevice_imei_key    INDEX     S   CREATE UNIQUE INDEX "GPSDevice_imei_key" ON public."GPSDevice" USING btree (imei);
 (   DROP INDEX public."GPSDevice_imei_key";
       public         	   nims_user    false    220            -           2606    17602 "   Accessory Accessory_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_device_id_fkey";
       public       	   nims_user    false    226    3601    220            .           2606    17607     Accessory Accessory_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_type_id_fkey";
       public       	   nims_user    false    3594    214    226            $           2606    17643    Brand Brand_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public."Brand" DROP CONSTRAINT "Brand_type_id_fkey";
       public       	   nims_user    false    216    214    3594                       2606    17537 *   ContactPerson ContactPerson_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_client_id_fkey";
       public       	   nims_user    false    206    3586    208                        2606    17542 (   ContactPerson ContactPerson_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 V   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_role_id_fkey";
       public       	   nims_user    false    210    208    3590            &           2606    17572 !   GPSDevice GPSDevice_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_brand_id_fkey";
       public       	   nims_user    false    3596    220    216            '           2606    17567 #   GPSDevice GPSDevice_vehicle_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_vehicle_id_fkey" FOREIGN KEY (vehicle_id) REFERENCES public."Vehicle"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_vehicle_id_fkey";
       public       	   nims_user    false    212    220    3592            (           2606    17577 )   GPSDevice GPSDevice_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_warranty_plan_id_fkey";
       public       	   nims_user    false    220    3613    232            2           2606    17627 8   InstallationEngineer InstallationEngineer_server_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_server_id_fkey" FOREIGN KEY (server_id) REFERENCES public."Server"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 f   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_server_id_fkey";
       public       	   nims_user    false    228    3609    230            3           2606    17632 6   InstallationEngineer InstallationEngineer_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 d   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_user_id_fkey";
       public       	   nims_user    false    204    3584    230            %           2606    17648    Model Model_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Model"
    ADD CONSTRAINT "Model_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 G   ALTER TABLE ONLY public."Model" DROP CONSTRAINT "Model_brand_id_fkey";
       public       	   nims_user    false    3596    216    218            *           2606    17587 $   Peripheral Peripheral_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_device_id_fkey";
       public       	   nims_user    false    224    3601    220            +           2606    17592 )   Peripheral Peripheral_sensor_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_sensor_type_id_fkey" FOREIGN KEY (sensor_type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_sensor_type_id_fkey";
       public       	   nims_user    false    224    3594    214            ,           2606    17597 +   Peripheral Peripheral_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_warranty_plan_id_fkey";
       public       	   nims_user    false    224    3613    232            /           2606    17612     Server Server_gps_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_gps_device_id_fkey" FOREIGN KEY (gps_device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_gps_device_id_fkey";
       public       	   nims_user    false    220    3601    228            0           2606    17622 '   Server Server_subscription_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_subscription_plan_id_fkey" FOREIGN KEY (subscription_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_subscription_plan_id_fkey";
       public       	   nims_user    false    232    3613    228            1           2606    17617    Server Server_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 H   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_type_id_fkey";
       public       	   nims_user    false    214    3594    228            )           2606    17582    SimCard SimCard_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."SimCard"
    ADD CONSTRAINT "SimCard_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public."SimCard" DROP CONSTRAINT "SimCard_device_id_fkey";
       public       	   nims_user    false    222    3601    220                       2606    17532    User User_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_role_id_fkey";
       public       	   nims_user    false    3590    204    210            !           2606    17557    Vehicle Vehicle_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_brand_id_fkey";
       public       	   nims_user    false    216    212    3596            "           2606    17547    Vehicle Vehicle_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_client_id_fkey";
       public       	   nims_user    false    3586    206    212            #           2606    17552    Vehicle Vehicle_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_type_id_fkey";
       public       	   nims_user    false    212    214    3594            �      x������ � �      �   U  x�}��N�0��� V���U�480��e�
*�FZ[���$G��/vd�M���8��~v�s���WrO�N� *�Cg�*������?K:��Q��+�Uc_�>�B�M�5�t}/�W3f4�6�i3Σ�N��f7�E-�����a�\�R��m�D�lV%��0z�[�jbYք���a�<�@���Kx9���%e+A	Z�lk8��w��"$+k�1�~Fzd�������L���g�`{�\�e��[M�n��n���<-��K�	�;)I�F�yU)�O�0��e����D�h��k�����|��	t����/[�RZ�Ť�m�KӒ/�+I����^=�      �   a   x�3�.-H-R��L�(�L�K���Q�L��M,��aTTAé�(7Q�����Đ����T��D��R��������P��E�(feh�g`l����� :��      �   Y   x�3�4���L,W �F�����&&��f��F�%��y�y����z����FF��&���
�&VƆV�z�&�z�F\1z\\\ 	T      �      x������ � �      �      x������ � �      �   �   x�}��
�0��s�{���M���1�</E��:����,��$!Zh+�1�%�a�N�yZi[+��Wh��@^:�d0Eo���OA�uз��@��r�����D�u�?���ez0��I�r�"S�PK��C[�S�{'��������p���%��>|)/���y��DD��Y��w�      �      x������ � �      �   �   x�m�M
�@�דS��$�q�ĕ��-e@+�E��t#�o�������<8O>Ԥ5kEd�J�]7W�vh�n�{R�bԘ0��o0&�]>�*G�lB�$-��wz�y��m*n/Q�_w$�1*w�{sZvF�7���i� ���?z      �      x������ � �      �      x������ � �      �   V   x�3�H,.N�KO-�K��L�I�4202�50�5�T00�2��2��312�2�tN,J�W)J�+.�/*�������H��҂+F��� X0j      �   K   x�3��,.I�UpL����4�4���4550442�,KAdA������)��������������a����� �      �      x������ � �      �      x������ � �      �   *  x���[j1E�ǫ��P�z�"�C�'�g����N�Ď�@��i�TG�J�5�8J�5Ŭ3�PI`������IW�ٚI.eFə;Ԛ�N1#㌀�m��2v�$��q�t`9dڇ�=<O F� fގ��ew�����4�9@�~��U�V��$��yJZߘ$LG�&8��c5/h�v�R	�w�Q��kk�V�M���Z_�i�N�~��l�eppf����]�ݏ���Vʩow�>n�J�EE^ɤ�\TUL��Uhr"��7��;ri.U��g�J�Σ��hd�֟��{�b�����q>��ɕ9�%�g;�Lv>m�d\��3�_��j�
����lP�^)EH1Pk�G����4S�f�VV�Z��e`��X�(�P�����)�ҧ�A��d�F9�@�n��ԭ����x��"{�w9o����|*��6���f*�+��)&"%wnK�y�Vfj4E�KE�;����3+�� S����q�Vev��lƲ����<�7���0����k�0��w����η�w�'¯�˱ݎ�2Fv}e��_]]}s�     