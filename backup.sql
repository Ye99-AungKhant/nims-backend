PGDMP  (    3                }            nims_db    16.2    16.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    51652    nims_db    DATABASE     �   CREATE DATABASE nims_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE nims_db;
                postgres    false            v           1247    51654    RepairReplacementType    TYPE     ~   CREATE TYPE public."RepairReplacementType" AS ENUM (
    'Repair',
    'Replacement',
    'Installed',
    'VehicleChange'
);
 *   DROP TYPE public."RepairReplacementType";
       public          postgres    false            y           1247    51662    StatusGroup    TYPE     �   CREATE TYPE public."StatusGroup" AS ENUM (
    'Active',
    'Expired',
    'Inactive',
    'ExpireSoon',
    'Renew',
    'Replaced',
    'Yes',
    'No'
);
     DROP TYPE public."StatusGroup";
       public          postgres    false            |           1247    51680 	   TypeGroup    TYPE     �   CREATE TYPE public."TypeGroup" AS ENUM (
    'Vehicle',
    'GPS',
    'Sensor',
    'Accessory',
    'Server',
    'Operator',
    'Full_Device',
    'Component_Only',
    'Partial_Replacement'
);
    DROP TYPE public."TypeGroup";
       public          postgres    false            �            1259    51699 	   Accessory    TABLE     �  CREATE TABLE public."Accessory" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    type_id integer NOT NULL,
    qty integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    status public."StatusGroup" DEFAULT 'Active'::public."StatusGroup" NOT NULL,
    installed_date timestamp(3) without time zone
);
    DROP TABLE public."Accessory";
       public         heap    postgres    false    889    889            �            1259    51704    Accessory_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Accessory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Accessory_id_seq";
       public          postgres    false    215            �           0    0    Accessory_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."Accessory_id_seq" OWNED BY public."Accessory".id;
          public          postgres    false    216            �            1259    51705    Brand    TABLE     �   CREATE TABLE public."Brand" (
    id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_id integer
);
    DROP TABLE public."Brand";
       public         heap    postgres    false    892            �            1259    51711    Brand_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Brand_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Brand_id_seq";
       public          postgres    false    217            �           0    0    Brand_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Brand_id_seq" OWNED BY public."Brand".id;
          public          postgres    false    218            �            1259    51712    Client    TABLE     ;  CREATE TABLE public."Client" (
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
       public         heap    postgres    false            �            1259    51718    Client_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Client_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Client_id_seq";
       public          postgres    false    219            �           0    0    Client_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Client_id_seq" OWNED BY public."Client".id;
          public          postgres    false    220            �            1259    51719    ComponentReplacement    TABLE     ~  CREATE TABLE public."ComponentReplacement" (
    id integer NOT NULL,
    device_replacement_id integer NOT NULL,
    component_type public."TypeGroup" NOT NULL,
    replacement_reason text,
    replacement_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    original_simcard_id integer,
    original_peripheral_id integer,
    original_accessory_id integer,
    replacement_simcard_id integer,
    replacement_peripheral_id integer,
    replacement_accessory_id integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 *   DROP TABLE public."ComponentReplacement";
       public         heap    postgres    false    892            �            1259    51726    ComponentReplacement_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ComponentReplacement_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."ComponentReplacement_id_seq";
       public          postgres    false    221            �           0    0    ComponentReplacement_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."ComponentReplacement_id_seq" OWNED BY public."ComponentReplacement".id;
          public          postgres    false    222            �            1259    51727    ContactPerson    TABLE     L  CREATE TABLE public."ContactPerson" (
    id integer NOT NULL,
    client_id integer NOT NULL,
    name text NOT NULL,
    role_id integer,
    phone text NOT NULL,
    email text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 #   DROP TABLE public."ContactPerson";
       public         heap    postgres    false            �            1259    51733    ContactPerson_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ContactPerson_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."ContactPerson_id_seq";
       public          postgres    false    223            �           0    0    ContactPerson_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."ContactPerson_id_seq" OWNED BY public."ContactPerson".id;
          public          postgres    false    224            �            1259    51734    DeviceRepairReplacement    TABLE     �  CREATE TABLE public."DeviceRepairReplacement" (
    id integer NOT NULL,
    original_gps_id integer NOT NULL,
    repair_replacement_gps_id integer,
    repair_replacement_by_user_id integer NOT NULL,
    type public."RepairReplacementType" NOT NULL,
    replacement_device_type public."TypeGroup",
    reason text NOT NULL,
    repair_replacement_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    user_false public."StatusGroup",
    is_deleted boolean DEFAULT false NOT NULL
);
 -   DROP TABLE public."DeviceRepairReplacement";
       public         heap    postgres    false    886    892    889            �            1259    51742    DeviceRepairReplacement_id_seq    SEQUENCE     �   CREATE SEQUENCE public."DeviceRepairReplacement_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public."DeviceRepairReplacement_id_seq";
       public          postgres    false    225            �           0    0    DeviceRepairReplacement_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public."DeviceRepairReplacement_id_seq" OWNED BY public."DeviceRepairReplacement".id;
          public          postgres    false    226                       1259    66916    ExtraGPSDevice    TABLE     �  CREATE TABLE public."ExtraGPSDevice" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    brand_id integer NOT NULL,
    model_id integer NOT NULL,
    imei text NOT NULL,
    serial_no text NOT NULL,
    warranty_plan_id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 $   DROP TABLE public."ExtraGPSDevice";
       public         heap    postgres    false                       1259    66915    ExtraGPSDevice_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ExtraGPSDevice_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."ExtraGPSDevice_id_seq";
       public          postgres    false    261            �           0    0    ExtraGPSDevice_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."ExtraGPSDevice_id_seq" OWNED BY public."ExtraGPSDevice".id;
          public          postgres    false    260            �            1259    51743 	   GPSDevice    TABLE     �  CREATE TABLE public."GPSDevice" (
    id integer NOT NULL,
    vehicle_id integer NOT NULL,
    brand_id integer NOT NULL,
    model_id integer NOT NULL,
    imei text NOT NULL,
    serial_no text NOT NULL,
    warranty_plan_id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    status public."StatusGroup" DEFAULT 'Active'::public."StatusGroup" NOT NULL
);
    DROP TABLE public."GPSDevice";
       public         heap    postgres    false    889    889            �            1259    51750    GPSDevice_id_seq    SEQUENCE     �   CREATE SEQUENCE public."GPSDevice_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."GPSDevice_id_seq";
       public          postgres    false    227            �           0    0    GPSDevice_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."GPSDevice_id_seq" OWNED BY public."GPSDevice".id;
          public          postgres    false    228            �            1259    51751    InstallImage    TABLE     %  CREATE TABLE public."InstallImage" (
    id integer NOT NULL,
    server_id integer NOT NULL,
    device_repair_replacement_id integer,
    image_url text NOT NULL,
    type public."RepairReplacementType" DEFAULT 'Installed'::public."RepairReplacementType",
    vehicle_activity_id integer
);
 "   DROP TABLE public."InstallImage";
       public         heap    postgres    false    886    886            �            1259    51757    InstallImage_id_seq    SEQUENCE     �   CREATE SEQUENCE public."InstallImage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."InstallImage_id_seq";
       public          postgres    false    229            �           0    0    InstallImage_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."InstallImage_id_seq" OWNED BY public."InstallImage".id;
          public          postgres    false    230            �            1259    51758    InstallationEngineer    TABLE       CREATE TABLE public."InstallationEngineer" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    server_id integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    device_repair_replacement_id integer,
    vehicle_activity_id integer
);
 *   DROP TABLE public."InstallationEngineer";
       public         heap    postgres    false            �            1259    51762    InstallationEngineer_id_seq    SEQUENCE     �   CREATE SEQUENCE public."InstallationEngineer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."InstallationEngineer_id_seq";
       public          postgres    false    231            �           0    0    InstallationEngineer_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."InstallationEngineer_id_seq" OWNED BY public."InstallationEngineer".id;
          public          postgres    false    232            �            1259    51763    Model    TABLE     (  CREATE TABLE public."Model" (
    id integer NOT NULL,
    brand_id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Model";
       public         heap    postgres    false    892            �            1259    51769    Model_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Model_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Model_id_seq";
       public          postgres    false    233            �           0    0    Model_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Model_id_seq" OWNED BY public."Model".id;
          public          postgres    false    234            �            1259    51770 
   Peripheral    TABLE     �  CREATE TABLE public."Peripheral" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    sensor_type_id integer NOT NULL,
    qty integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    status public."StatusGroup" DEFAULT 'Active'::public."StatusGroup" NOT NULL,
    installed_date timestamp(3) without time zone
);
     DROP TABLE public."Peripheral";
       public         heap    postgres    false    889    889            �            1259    51775    PeripheralDetail    TABLE     v  CREATE TABLE public."PeripheralDetail" (
    id integer NOT NULL,
    peripheral_id integer NOT NULL,
    brand_id integer NOT NULL,
    model_id integer NOT NULL,
    warranty_plan_id integer NOT NULL,
    serial_no text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 &   DROP TABLE public."PeripheralDetail";
       public         heap    postgres    false            �            1259    51781    PeripheralDetail_id_seq    SEQUENCE     �   CREATE SEQUENCE public."PeripheralDetail_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."PeripheralDetail_id_seq";
       public          postgres    false    236            �           0    0    PeripheralDetail_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."PeripheralDetail_id_seq" OWNED BY public."PeripheralDetail".id;
          public          postgres    false    237            �            1259    51782    Peripheral_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Peripheral_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Peripheral_id_seq";
       public          postgres    false    235            �           0    0    Peripheral_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Peripheral_id_seq" OWNED BY public."Peripheral".id;
          public          postgres    false    238            �            1259    51783 
   Permission    TABLE     &  CREATE TABLE public."Permission" (
    id integer NOT NULL,
    page_name text NOT NULL,
    view boolean DEFAULT false NOT NULL,
    "create" boolean DEFAULT false NOT NULL,
    update boolean DEFAULT false NOT NULL,
    delete boolean DEFAULT false NOT NULL,
    "roleId" integer NOT NULL
);
     DROP TABLE public."Permission";
       public         heap    postgres    false            �            1259    51792    Permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Permission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Permission_id_seq";
       public          postgres    false    239            �           0    0    Permission_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Permission_id_seq" OWNED BY public."Permission".id;
          public          postgres    false    240            �            1259    51793    Role    TABLE       CREATE TABLE public."Role" (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "canLogin" boolean DEFAULT false NOT NULL
);
    DROP TABLE public."Role";
       public         heap    postgres    false            �            1259    51800    Role_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Role_id_seq";
       public          postgres    false    241            �           0    0    Role_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Role_id_seq" OWNED BY public."Role".id;
          public          postgres    false    242            �            1259    51801    Server    TABLE     �  CREATE TABLE public."Server" (
    id integer NOT NULL,
    type_id integer NOT NULL,
    installed_date timestamp(3) without time zone NOT NULL,
    subscription_plan_id integer NOT NULL,
    expire_date timestamp(3) without time zone NOT NULL,
    invoice_no text,
    object_base_fee integer NOT NULL,
    gps_device_id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    domain_id integer NOT NULL,
    status public."StatusGroup" DEFAULT 'Active'::public."StatusGroup" NOT NULL,
    renewal_date timestamp(3) without time zone
);
    DROP TABLE public."Server";
       public         heap    postgres    false    889    889            �            1259    51808    ServerActivity    TABLE     5  CREATE TABLE public."ServerActivity" (
    id integer NOT NULL,
    server_id integer NOT NULL,
    type_id integer,
    domain_id integer,
    subscription_plan_id integer,
    installed_date timestamp(3) without time zone NOT NULL,
    renewal_date timestamp(3) without time zone,
    expire_date timestamp(3) without time zone NOT NULL,
    invoice_no text,
    object_base_fee integer NOT NULL,
    status public."StatusGroup" DEFAULT 'Active'::public."StatusGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 $   DROP TABLE public."ServerActivity";
       public         heap    postgres    false    889    889            �            1259    51815    ServerActivity_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ServerActivity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."ServerActivity_id_seq";
       public          postgres    false    244            �           0    0    ServerActivity_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."ServerActivity_id_seq" OWNED BY public."ServerActivity".id;
          public          postgres    false    245            �            1259    51816    Server_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Server_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Server_id_seq";
       public          postgres    false    243            �           0    0    Server_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Server_id_seq" OWNED BY public."Server".id;
          public          postgres    false    246            �            1259    51817    SimCard    TABLE     p  CREATE TABLE public."SimCard" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    phone_no text NOT NULL,
    operator text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    status public."StatusGroup" DEFAULT 'Active'::public."StatusGroup" NOT NULL
);
    DROP TABLE public."SimCard";
       public         heap    postgres    false    889    889            �            1259    51824    SimCard_id_seq    SEQUENCE     �   CREATE SEQUENCE public."SimCard_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."SimCard_id_seq";
       public          postgres    false    247            �           0    0    SimCard_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."SimCard_id_seq" OWNED BY public."SimCard".id;
          public          postgres    false    248            �            1259    51825    Type    TABLE     �   CREATE TABLE public."Type" (
    id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public."Type";
       public         heap    postgres    false    892            �            1259    51831    Type_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Type_id_seq";
       public          postgres    false    249            �           0    0    Type_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Type_id_seq" OWNED BY public."Type".id;
          public          postgres    false    250            �            1259    51832    User    TABLE     f  CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    role_id integer,
    phone text,
    email text,
    password text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "canLogin" boolean DEFAULT false NOT NULL,
    username text
);
    DROP TABLE public."User";
       public         heap    postgres    false            �            1259    51839    User_id_seq    SEQUENCE     �   CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."User_id_seq";
       public          postgres    false    251            �           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public          postgres    false    252            �            1259    51840    Vehicle    TABLE     m  CREATE TABLE public."Vehicle" (
    id integer NOT NULL,
    client_id integer NOT NULL,
    plate_number text NOT NULL,
    type_id integer,
    brand_id integer,
    model_id integer,
    year integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    odometer text
);
    DROP TABLE public."Vehicle";
       public         heap    postgres    false                       1259    55456    VehicleActivity    TABLE     �  CREATE TABLE public."VehicleActivity" (
    id integer NOT NULL,
    vehicle_id integer NOT NULL,
    plate_number text NOT NULL,
    type_id integer,
    brand_id integer,
    model_id integer,
    year integer,
    odometer text,
    changed_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    reason text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
 %   DROP TABLE public."VehicleActivity";
       public         heap    postgres    false                       1259    55455    VehicleActivity_id_seq    SEQUENCE     �   CREATE SEQUENCE public."VehicleActivity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."VehicleActivity_id_seq";
       public          postgres    false    259            �           0    0    VehicleActivity_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."VehicleActivity_id_seq" OWNED BY public."VehicleActivity".id;
          public          postgres    false    258            �            1259    51846    Vehicle_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Vehicle_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Vehicle_id_seq";
       public          postgres    false    253            �           0    0    Vehicle_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Vehicle_id_seq" OWNED BY public."Vehicle".id;
          public          postgres    false    254            �            1259    51847    WarrantyPlan    TABLE     �   CREATE TABLE public."WarrantyPlan" (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 "   DROP TABLE public."WarrantyPlan";
       public         heap    postgres    false                        1259    51853    WarrantyPlan_id_seq    SEQUENCE     �   CREATE SEQUENCE public."WarrantyPlan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."WarrantyPlan_id_seq";
       public          postgres    false    255            �           0    0    WarrantyPlan_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."WarrantyPlan_id_seq" OWNED BY public."WarrantyPlan".id;
          public          postgres    false    256                       1259    51854    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
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
       public         heap    postgres    false            q           2604    51861    Accessory id    DEFAULT     p   ALTER TABLE ONLY public."Accessory" ALTER COLUMN id SET DEFAULT nextval('public."Accessory_id_seq"'::regclass);
 =   ALTER TABLE public."Accessory" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            t           2604    51862    Brand id    DEFAULT     h   ALTER TABLE ONLY public."Brand" ALTER COLUMN id SET DEFAULT nextval('public."Brand_id_seq"'::regclass);
 9   ALTER TABLE public."Brand" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217            v           2604    51863 	   Client id    DEFAULT     j   ALTER TABLE ONLY public."Client" ALTER COLUMN id SET DEFAULT nextval('public."Client_id_seq"'::regclass);
 :   ALTER TABLE public."Client" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            x           2604    51864    ComponentReplacement id    DEFAULT     �   ALTER TABLE ONLY public."ComponentReplacement" ALTER COLUMN id SET DEFAULT nextval('public."ComponentReplacement_id_seq"'::regclass);
 H   ALTER TABLE public."ComponentReplacement" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            {           2604    51865    ContactPerson id    DEFAULT     x   ALTER TABLE ONLY public."ContactPerson" ALTER COLUMN id SET DEFAULT nextval('public."ContactPerson_id_seq"'::regclass);
 A   ALTER TABLE public."ContactPerson" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            }           2604    51866    DeviceRepairReplacement id    DEFAULT     �   ALTER TABLE ONLY public."DeviceRepairReplacement" ALTER COLUMN id SET DEFAULT nextval('public."DeviceRepairReplacement_id_seq"'::regclass);
 K   ALTER TABLE public."DeviceRepairReplacement" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            �           2604    66919    ExtraGPSDevice id    DEFAULT     z   ALTER TABLE ONLY public."ExtraGPSDevice" ALTER COLUMN id SET DEFAULT nextval('public."ExtraGPSDevice_id_seq"'::regclass);
 B   ALTER TABLE public."ExtraGPSDevice" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    261    260    261            �           2604    51867    GPSDevice id    DEFAULT     p   ALTER TABLE ONLY public."GPSDevice" ALTER COLUMN id SET DEFAULT nextval('public."GPSDevice_id_seq"'::regclass);
 =   ALTER TABLE public."GPSDevice" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            �           2604    51868    InstallImage id    DEFAULT     v   ALTER TABLE ONLY public."InstallImage" ALTER COLUMN id SET DEFAULT nextval('public."InstallImage_id_seq"'::regclass);
 @   ALTER TABLE public."InstallImage" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229            �           2604    51869    InstallationEngineer id    DEFAULT     �   ALTER TABLE ONLY public."InstallationEngineer" ALTER COLUMN id SET DEFAULT nextval('public."InstallationEngineer_id_seq"'::regclass);
 H   ALTER TABLE public."InstallationEngineer" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231            �           2604    51870    Model id    DEFAULT     h   ALTER TABLE ONLY public."Model" ALTER COLUMN id SET DEFAULT nextval('public."Model_id_seq"'::regclass);
 9   ALTER TABLE public."Model" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233            �           2604    51871    Peripheral id    DEFAULT     r   ALTER TABLE ONLY public."Peripheral" ALTER COLUMN id SET DEFAULT nextval('public."Peripheral_id_seq"'::regclass);
 >   ALTER TABLE public."Peripheral" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    235            �           2604    51872    PeripheralDetail id    DEFAULT     ~   ALTER TABLE ONLY public."PeripheralDetail" ALTER COLUMN id SET DEFAULT nextval('public."PeripheralDetail_id_seq"'::regclass);
 D   ALTER TABLE public."PeripheralDetail" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236            �           2604    51873    Permission id    DEFAULT     r   ALTER TABLE ONLY public."Permission" ALTER COLUMN id SET DEFAULT nextval('public."Permission_id_seq"'::regclass);
 >   ALTER TABLE public."Permission" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    239            �           2604    51874    Role id    DEFAULT     f   ALTER TABLE ONLY public."Role" ALTER COLUMN id SET DEFAULT nextval('public."Role_id_seq"'::regclass);
 8   ALTER TABLE public."Role" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    242    241            �           2604    51875 	   Server id    DEFAULT     j   ALTER TABLE ONLY public."Server" ALTER COLUMN id SET DEFAULT nextval('public."Server_id_seq"'::regclass);
 :   ALTER TABLE public."Server" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    246    243            �           2604    51876    ServerActivity id    DEFAULT     z   ALTER TABLE ONLY public."ServerActivity" ALTER COLUMN id SET DEFAULT nextval('public."ServerActivity_id_seq"'::regclass);
 B   ALTER TABLE public."ServerActivity" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    245    244            �           2604    51877 
   SimCard id    DEFAULT     l   ALTER TABLE ONLY public."SimCard" ALTER COLUMN id SET DEFAULT nextval('public."SimCard_id_seq"'::regclass);
 ;   ALTER TABLE public."SimCard" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    248    247            �           2604    51878    Type id    DEFAULT     f   ALTER TABLE ONLY public."Type" ALTER COLUMN id SET DEFAULT nextval('public."Type_id_seq"'::regclass);
 8   ALTER TABLE public."Type" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    250    249            �           2604    51879    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    252    251            �           2604    51880 
   Vehicle id    DEFAULT     l   ALTER TABLE ONLY public."Vehicle" ALTER COLUMN id SET DEFAULT nextval('public."Vehicle_id_seq"'::regclass);
 ;   ALTER TABLE public."Vehicle" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    254    253            �           2604    55459    VehicleActivity id    DEFAULT     |   ALTER TABLE ONLY public."VehicleActivity" ALTER COLUMN id SET DEFAULT nextval('public."VehicleActivity_id_seq"'::regclass);
 C   ALTER TABLE public."VehicleActivity" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    258    259    259            �           2604    51881    WarrantyPlan id    DEFAULT     v   ALTER TABLE ONLY public."WarrantyPlan" ALTER COLUMN id SET DEFAULT nextval('public."WarrantyPlan_id_seq"'::regclass);
 @   ALTER TABLE public."WarrantyPlan" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    256    255            �          0    51699 	   Accessory 
   TABLE DATA           t   COPY public."Accessory" (id, device_id, type_id, qty, "createdAt", "updatedAt", status, installed_date) FROM stdin;
    public          postgres    false    215   �B      �          0    51705    Brand 
   TABLE DATA           M   COPY public."Brand" (id, name, type_group, "createdAt", type_id) FROM stdin;
    public          postgres    false    217   *�      �          0    51712    Client 
   TABLE DATA           m   COPY public."Client" (id, name, address, city, state, country, postal, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    219   "�      �          0    51719    ComponentReplacement 
   TABLE DATA           ,  COPY public."ComponentReplacement" (id, device_replacement_id, component_type, replacement_reason, replacement_date, original_simcard_id, original_peripheral_id, original_accessory_id, replacement_simcard_id, replacement_peripheral_id, replacement_accessory_id, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    221   ʔ      �          0    51727    ContactPerson 
   TABLE DATA           o   COPY public."ContactPerson" (id, client_id, name, role_id, phone, email, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    223   �      �          0    51734    DeviceRepairReplacement 
   TABLE DATA           �   COPY public."DeviceRepairReplacement" (id, original_gps_id, repair_replacement_gps_id, repair_replacement_by_user_id, type, replacement_device_type, reason, repair_replacement_date, "createdAt", "updatedAt", user_false, is_deleted) FROM stdin;
    public          postgres    false    225   ��      �          0    66916    ExtraGPSDevice 
   TABLE DATA           �   COPY public."ExtraGPSDevice" (id, device_id, brand_id, model_id, imei, serial_no, warranty_plan_id, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    261   ��      �          0    51743 	   GPSDevice 
   TABLE DATA           �   COPY public."GPSDevice" (id, vehicle_id, brand_id, model_id, imei, serial_no, warranty_plan_id, "createdAt", "updatedAt", status) FROM stdin;
    public          postgres    false    227   Ѥ      �          0    51751    InstallImage 
   TABLE DATA           {   COPY public."InstallImage" (id, server_id, device_repair_replacement_id, image_url, type, vehicle_activity_id) FROM stdin;
    public          postgres    false    229   ��      �          0    51758    InstallationEngineer 
   TABLE DATA           �   COPY public."InstallationEngineer" (id, user_id, server_id, "createdAt", device_repair_replacement_id, vehicle_activity_id) FROM stdin;
    public          postgres    false    231   ��      �          0    51763    Model 
   TABLE DATA           [   COPY public."Model" (id, brand_id, name, type_group, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    233   G!      �          0    51770 
   Peripheral 
   TABLE DATA           |   COPY public."Peripheral" (id, device_id, sensor_type_id, qty, "createdAt", "updatedAt", status, installed_date) FROM stdin;
    public          postgres    false    235   �(      �          0    51775    PeripheralDetail 
   TABLE DATA           �   COPY public."PeripheralDetail" (id, peripheral_id, brand_id, model_id, warranty_plan_id, serial_no, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    236   5D      �          0    51783 
   Permission 
   TABLE DATA           _   COPY public."Permission" (id, page_name, view, "create", update, delete, "roleId") FROM stdin;
    public          postgres    false    239   �d      �          0    51793    Role 
   TABLE DATA           P   COPY public."Role" (id, name, "createdAt", "updatedAt", "canLogin") FROM stdin;
    public          postgres    false    241   �d      �          0    51801    Server 
   TABLE DATA           �   COPY public."Server" (id, type_id, installed_date, subscription_plan_id, expire_date, invoice_no, object_base_fee, gps_device_id, "createdAt", "updatedAt", domain_id, status, renewal_date) FROM stdin;
    public          postgres    false    243   Wf      �          0    51808    ServerActivity 
   TABLE DATA           �   COPY public."ServerActivity" (id, server_id, type_id, domain_id, subscription_plan_id, installed_date, renewal_date, expire_date, invoice_no, object_base_fee, status, "createdAt") FROM stdin;
    public          postgres    false    244   @�      �          0    51817    SimCard 
   TABLE DATA           h   COPY public."SimCard" (id, device_id, phone_no, operator, "createdAt", "updatedAt", status) FROM stdin;
    public          postgres    false    247   ?�      �          0    51825    Type 
   TABLE DATA           C   COPY public."Type" (id, name, type_group, "createdAt") FROM stdin;
    public          postgres    false    249         �          0    51832    User 
   TABLE DATA           {   COPY public."User" (id, name, role_id, phone, email, password, "createdAt", "updatedAt", "canLogin", username) FROM stdin;
    public          postgres    false    251   
      �          0    51840    Vehicle 
   TABLE DATA           �   COPY public."Vehicle" (id, client_id, plate_number, type_id, brand_id, model_id, year, "createdAt", "updatedAt", odometer) FROM stdin;
    public          postgres    false    253   �      �          0    55456    VehicleActivity 
   TABLE DATA           �   COPY public."VehicleActivity" (id, vehicle_id, plate_number, type_id, brand_id, model_id, year, odometer, changed_date, reason, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    259   (H      �          0    51847    WarrantyPlan 
   TABLE DATA           ?   COPY public."WarrantyPlan" (id, name, "createdAt") FROM stdin;
    public          postgres    false    255   >I      �          0    51854    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public          postgres    false    257   �I      �           0    0    Accessory_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Accessory_id_seq"', 1817, true);
          public          postgres    false    216            �           0    0    Brand_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Brand_id_seq"', 95, true);
          public          postgres    false    218            �           0    0    Client_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Client_id_seq"', 60, true);
          public          postgres    false    220            �           0    0    ComponentReplacement_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."ComponentReplacement_id_seq"', 26, true);
          public          postgres    false    222            �           0    0    ContactPerson_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."ContactPerson_id_seq"', 66, true);
          public          postgres    false    224            �           0    0    DeviceRepairReplacement_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public."DeviceRepairReplacement_id_seq"', 48, true);
          public          postgres    false    226            �           0    0    ExtraGPSDevice_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."ExtraGPSDevice_id_seq"', 1, true);
          public          postgres    false    260            �           0    0    GPSDevice_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."GPSDevice_id_seq"', 866, true);
          public          postgres    false    228            �           0    0    InstallImage_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."InstallImage_id_seq"', 94, true);
          public          postgres    false    230            �           0    0    InstallationEngineer_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."InstallationEngineer_id_seq"', 1624, true);
          public          postgres    false    232            �           0    0    Model_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Model_id_seq"', 102, true);
          public          postgres    false    234            �           0    0    PeripheralDetail_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."PeripheralDetail_id_seq"', 549, true);
          public          postgres    false    237                        0    0    Peripheral_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Peripheral_id_seq"', 535, true);
          public          postgres    false    238                       0    0    Permission_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Permission_id_seq"', 8, true);
          public          postgres    false    240                       0    0    Role_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Role_id_seq"', 15, true);
          public          postgres    false    242                       0    0    ServerActivity_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."ServerActivity_id_seq"', 77, true);
          public          postgres    false    245                       0    0    Server_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Server_id_seq"', 833, true);
          public          postgres    false    246                       0    0    SimCard_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."SimCard_id_seq"', 1051, true);
          public          postgres    false    248                       0    0    Type_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Type_id_seq"', 26, true);
          public          postgres    false    250                       0    0    User_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."User_id_seq"', 15, true);
          public          postgres    false    252                       0    0    VehicleActivity_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."VehicleActivity_id_seq"', 10, true);
          public          postgres    false    258            	           0    0    Vehicle_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Vehicle_id_seq"', 851, true);
          public          postgres    false    254            
           0    0    WarrantyPlan_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."WarrantyPlan_id_seq"', 5, true);
          public          postgres    false    256            �           2606    51883    Accessory Accessory_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_pkey";
       public            postgres    false    215            �           2606    51885    Brand Brand_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Brand" DROP CONSTRAINT "Brand_pkey";
       public            postgres    false    217            �           2606    51887    Client Client_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Client" DROP CONSTRAINT "Client_pkey";
       public            postgres    false    219            �           2606    51889 .   ComponentReplacement ComponentReplacement_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_pkey" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_pkey";
       public            postgres    false    221            �           2606    51891     ContactPerson ContactPerson_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_pkey";
       public            postgres    false    223            �           2606    51893 4   DeviceRepairReplacement DeviceRepairReplacement_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_pkey" PRIMARY KEY (id);
 b   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_pkey";
       public            postgres    false    225            �           2606    66924 "   ExtraGPSDevice ExtraGPSDevice_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_pkey";
       public            postgres    false    261            �           2606    51895    GPSDevice GPSDevice_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_pkey";
       public            postgres    false    227            �           2606    51897    InstallImage InstallImage_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_pkey";
       public            postgres    false    229            �           2606    51899 .   InstallationEngineer InstallationEngineer_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_pkey" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_pkey";
       public            postgres    false    231            �           2606    51901    Model Model_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Model"
    ADD CONSTRAINT "Model_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Model" DROP CONSTRAINT "Model_pkey";
       public            postgres    false    233            �           2606    51903 &   PeripheralDetail PeripheralDetail_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_pkey" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_pkey";
       public            postgres    false    236            �           2606    51905    Peripheral Peripheral_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_pkey";
       public            postgres    false    235            �           2606    51907    Permission Permission_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Permission" DROP CONSTRAINT "Permission_pkey";
       public            postgres    false    239            �           2606    51909    Role Role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Role" DROP CONSTRAINT "Role_pkey";
       public            postgres    false    241            �           2606    51911 "   ServerActivity ServerActivity_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_pkey";
       public            postgres    false    244            �           2606    51913    Server Server_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_pkey";
       public            postgres    false    243            �           2606    51915    SimCard SimCard_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."SimCard"
    ADD CONSTRAINT "SimCard_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."SimCard" DROP CONSTRAINT "SimCard_pkey";
       public            postgres    false    247            �           2606    51917    Type Type_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Type"
    ADD CONSTRAINT "Type_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Type" DROP CONSTRAINT "Type_pkey";
       public            postgres    false    249            �           2606    51919    User User_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
       public            postgres    false    251            �           2606    55465 $   VehicleActivity VehicleActivity_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_pkey";
       public            postgres    false    259            �           2606    51921    Vehicle Vehicle_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_pkey";
       public            postgres    false    253            �           2606    51923    WarrantyPlan WarrantyPlan_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."WarrantyPlan"
    ADD CONSTRAINT "WarrantyPlan_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."WarrantyPlan" DROP CONSTRAINT "WarrantyPlan_pkey";
       public            postgres    false    255            �           2606    51925 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public            postgres    false    257            �           1259    51926    Role_name_key    INDEX     I   CREATE UNIQUE INDEX "Role_name_key" ON public."Role" USING btree (name);
 #   DROP INDEX public."Role_name_key";
       public            postgres    false    241            �           1259    51927    User_username_key    INDEX     Q   CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);
 '   DROP INDEX public."User_username_key";
       public            postgres    false    251            �           2606    51928 "   Accessory Accessory_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_device_id_fkey";
       public          postgres    false    215    4797    227            �           2606    51933     Accessory Accessory_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_type_id_fkey";
       public          postgres    false    4820    215    249            �           2606    51938    Brand Brand_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public."Brand" DROP CONSTRAINT "Brand_type_id_fkey";
       public          postgres    false    217    249    4820            �           2606    51943 D   ComponentReplacement ComponentReplacement_device_replacement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_device_replacement_id_fkey" FOREIGN KEY (device_replacement_id) REFERENCES public."DeviceRepairReplacement"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 r   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_device_replacement_id_fkey";
       public          postgres    false    221    225    4795            �           2606    51948 D   ComponentReplacement ComponentReplacement_original_accessory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_original_accessory_id_fkey" FOREIGN KEY (original_accessory_id) REFERENCES public."Accessory"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 r   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_original_accessory_id_fkey";
       public          postgres    false    215    221    4785            �           2606    51953 E   ComponentReplacement ComponentReplacement_original_peripheral_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_original_peripheral_id_fkey" FOREIGN KEY (original_peripheral_id) REFERENCES public."Peripheral"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 s   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_original_peripheral_id_fkey";
       public          postgres    false    4805    235    221            �           2606    51958 B   ComponentReplacement ComponentReplacement_original_simcard_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_original_simcard_id_fkey" FOREIGN KEY (original_simcard_id) REFERENCES public."SimCard"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 p   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_original_simcard_id_fkey";
       public          postgres    false    221    247    4818            �           2606    51963 G   ComponentReplacement ComponentReplacement_replacement_accessory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_replacement_accessory_id_fkey" FOREIGN KEY (replacement_accessory_id) REFERENCES public."Accessory"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 u   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_replacement_accessory_id_fkey";
       public          postgres    false    215    4785    221            �           2606    51968 H   ComponentReplacement ComponentReplacement_replacement_peripheral_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_replacement_peripheral_id_fkey" FOREIGN KEY (replacement_peripheral_id) REFERENCES public."Peripheral"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 v   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_replacement_peripheral_id_fkey";
       public          postgres    false    221    235    4805            �           2606    51973 E   ComponentReplacement ComponentReplacement_replacement_simcard_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_replacement_simcard_id_fkey" FOREIGN KEY (replacement_simcard_id) REFERENCES public."SimCard"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 s   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_replacement_simcard_id_fkey";
       public          postgres    false    247    221    4818            �           2606    51978 *   ContactPerson ContactPerson_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_client_id_fkey";
       public          postgres    false    223    219    4789            �           2606    51983 (   ContactPerson ContactPerson_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 V   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_role_id_fkey";
       public          postgres    false    4812    241    223            �           2606    51988 D   DeviceRepairReplacement DeviceRepairReplacement_original_gps_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_original_gps_id_fkey" FOREIGN KEY (original_gps_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 r   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_original_gps_id_fkey";
       public          postgres    false    227    225    4797            �           2606    51993 R   DeviceRepairReplacement DeviceRepairReplacement_repair_replacement_by_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_repair_replacement_by_user_id_fkey" FOREIGN KEY (repair_replacement_by_user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 �   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_repair_replacement_by_user_id_fkey";
       public          postgres    false    251    4822    225            �           2606    51998 N   DeviceRepairReplacement DeviceRepairReplacement_repair_replacement_gps_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_repair_replacement_gps_id_fkey" FOREIGN KEY (repair_replacement_gps_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 |   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_repair_replacement_gps_id_fkey";
       public          postgres    false    4797    227    225                       2606    66930 +   ExtraGPSDevice ExtraGPSDevice_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_brand_id_fkey";
       public          postgres    false    217    261    4787                       2606    66925 ,   ExtraGPSDevice ExtraGPSDevice_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Z   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_device_id_fkey";
       public          postgres    false    227    4797    261                       2606    66935 +   ExtraGPSDevice ExtraGPSDevice_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_model_id_fkey";
       public          postgres    false    4803    233    261                       2606    66940 3   ExtraGPSDevice ExtraGPSDevice_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 a   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_warranty_plan_id_fkey";
       public          postgres    false    261    255    4827            �           2606    52003 !   GPSDevice GPSDevice_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_brand_id_fkey";
       public          postgres    false    217    4787    227            �           2606    52008 !   GPSDevice GPSDevice_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_model_id_fkey";
       public          postgres    false    233    4803    227            �           2606    52013 #   GPSDevice GPSDevice_vehicle_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_vehicle_id_fkey" FOREIGN KEY (vehicle_id) REFERENCES public."Vehicle"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_vehicle_id_fkey";
       public          postgres    false    4825    227    253            �           2606    52018 )   GPSDevice GPSDevice_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_warranty_plan_id_fkey";
       public          postgres    false    227    255    4827            �           2606    52023 ;   InstallImage InstallImage_device_repair_replacement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_device_repair_replacement_id_fkey" FOREIGN KEY (device_repair_replacement_id) REFERENCES public."DeviceRepairReplacement"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 i   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_device_repair_replacement_id_fkey";
       public          postgres    false    229    225    4795            �           2606    52028 (   InstallImage InstallImage_server_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_server_id_fkey" FOREIGN KEY (server_id) REFERENCES public."Server"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 V   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_server_id_fkey";
       public          postgres    false    4814    229    243            �           2606    55486 2   InstallImage InstallImage_vehicle_activity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_vehicle_activity_id_fkey" FOREIGN KEY (vehicle_activity_id) REFERENCES public."VehicleActivity"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 `   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_vehicle_activity_id_fkey";
       public          postgres    false    229    259    4831            �           2606    52033 K   InstallationEngineer InstallationEngineer_device_repair_replacement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_device_repair_replacement_id_fkey" FOREIGN KEY (device_repair_replacement_id) REFERENCES public."DeviceRepairReplacement"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 y   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_device_repair_replacement_id_fkey";
       public          postgres    false    231    225    4795            �           2606    52038 8   InstallationEngineer InstallationEngineer_server_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_server_id_fkey" FOREIGN KEY (server_id) REFERENCES public."Server"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 f   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_server_id_fkey";
       public          postgres    false    4814    243    231            �           2606    52043 6   InstallationEngineer InstallationEngineer_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 d   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_user_id_fkey";
       public          postgres    false    231    4822    251            �           2606    55481 B   InstallationEngineer InstallationEngineer_vehicle_activity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_vehicle_activity_id_fkey" FOREIGN KEY (vehicle_activity_id) REFERENCES public."VehicleActivity"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 p   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_vehicle_activity_id_fkey";
       public          postgres    false    231    259    4831            �           2606    52048    Model Model_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Model"
    ADD CONSTRAINT "Model_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 G   ALTER TABLE ONLY public."Model" DROP CONSTRAINT "Model_brand_id_fkey";
       public          postgres    false    233    217    4787            �           2606    52053 /   PeripheralDetail PeripheralDetail_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_brand_id_fkey";
       public          postgres    false    4787    236    217                        2606    52058 /   PeripheralDetail PeripheralDetail_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_model_id_fkey";
       public          postgres    false    236    4803    233                       2606    52063 4   PeripheralDetail PeripheralDetail_peripheral_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_peripheral_id_fkey" FOREIGN KEY (peripheral_id) REFERENCES public."Peripheral"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 b   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_peripheral_id_fkey";
       public          postgres    false    4805    236    235                       2606    52068 7   PeripheralDetail PeripheralDetail_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 e   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_warranty_plan_id_fkey";
       public          postgres    false    236    4827    255            �           2606    52073 $   Peripheral Peripheral_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_device_id_fkey";
       public          postgres    false    235    4797    227            �           2606    52078 )   Peripheral Peripheral_sensor_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_sensor_type_id_fkey" FOREIGN KEY (sensor_type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_sensor_type_id_fkey";
       public          postgres    false    235    4820    249                       2606    52083 !   Permission Permission_roleId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."Permission" DROP CONSTRAINT "Permission_roleId_fkey";
       public          postgres    false    4812    239    241                       2606    52088 ,   ServerActivity ServerActivity_domain_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_domain_id_fkey" FOREIGN KEY (domain_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 Z   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_domain_id_fkey";
       public          postgres    false    4787    244    217            	           2606    52093 ,   ServerActivity ServerActivity_server_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_server_id_fkey" FOREIGN KEY (server_id) REFERENCES public."Server"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_server_id_fkey";
       public          postgres    false    244    4814    243            
           2606    52098 7   ServerActivity ServerActivity_subscription_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_subscription_plan_id_fkey" FOREIGN KEY (subscription_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 e   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_subscription_plan_id_fkey";
       public          postgres    false    255    244    4827                       2606    52103 *   ServerActivity ServerActivity_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 X   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_type_id_fkey";
       public          postgres    false    249    244    4820                       2606    52108    Server Server_domain_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_domain_id_fkey" FOREIGN KEY (domain_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_domain_id_fkey";
       public          postgres    false    4787    243    217                       2606    52113     Server Server_gps_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_gps_device_id_fkey" FOREIGN KEY (gps_device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_gps_device_id_fkey";
       public          postgres    false    4797    243    227                       2606    52118 '   Server Server_subscription_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_subscription_plan_id_fkey" FOREIGN KEY (subscription_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_subscription_plan_id_fkey";
       public          postgres    false    4827    255    243                       2606    52123    Server Server_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 H   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_type_id_fkey";
       public          postgres    false    249    4820    243                       2606    52128    SimCard SimCard_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."SimCard"
    ADD CONSTRAINT "SimCard_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public."SimCard" DROP CONSTRAINT "SimCard_device_id_fkey";
       public          postgres    false    247    4797    227                       2606    52133    User User_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_role_id_fkey";
       public          postgres    false    241    4812    251                       2606    55471 -   VehicleActivity VehicleActivity_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 [   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_brand_id_fkey";
       public          postgres    false    259    217    4787                       2606    55476 -   VehicleActivity VehicleActivity_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 [   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_model_id_fkey";
       public          postgres    false    259    4803    233                       2606    55466 ,   VehicleActivity VehicleActivity_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 Z   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_type_id_fkey";
       public          postgres    false    259    4820    249                       2606    52138    Vehicle Vehicle_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_brand_id_fkey";
       public          postgres    false    4787    217    253                       2606    52143    Vehicle Vehicle_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_client_id_fkey";
       public          postgres    false    219    4789    253                       2606    52148    Vehicle Vehicle_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_model_id_fkey";
       public          postgres    false    233    4803    253                       2606    52153    Vehicle Vehicle_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_type_id_fkey";
       public          postgres    false    249    4820    253            �      x���M��:ϝ����N�3�i�2����i�d�!���H
���ւ�s�m-K�T_��_������;������?����?������g�ҽ#�?����O��jg�� @����R�Z�Q��J�0��]~r�Z_G]0�+5�Q�ϝ��4�F{��1�s��s��8�A>Fn���ku���<����j��#��hgTn[�O��M����qr�ӥ_��*Y�Ɇ@�w�.g]0��)�A�OW[��F}��0Ҡ�ל��G�a�F��k���A�������t����G�a���:Ec;�A?��T�z�����Bѵ��o�u��	]0ҫ܆Q( ~�}����`�WI�Q����9u�(��c����.�u���J1��8*W��F{��0
�2�UJ;�1^�9�Z���ڏ�`�W�՟|_��G�è����Z|�8�I�a�����Q���*�:GRK?i^y�.�U�aT�M���W=�Q_5%��fO��xUa���2&�6KG]0֫6��(�ߗ�]���_���7�v��5K?�AOe:��ʺV>ɂ@�sB��t��5J>��^���â_w]G]0��%��(���s=�1_�b��+��,�ժCH7�T�G�����5�A�z��5��`�W�1��Mm�8낑_���D/�^%��.��l|MR����F}5a�oN�O� ����M}�����n��/~�󛰷�,t3�C(�O�]Ϻ`�ʹ��'_���6>�`�ʹ1�8�p���Q�0�N���7�o�s���	���w��t���1�r_��J�=��`�͘�A��ߕ�Kj]0�f,��*�JD�E��_�v�㣷i�>>�`�W���Q,��.>D��ގNq�s�k�|�"�F��o�X��Fy{)�SDKא�T�Q_�x�)-����F{��0��(��z��m��5���T�1^��\�;
�u��.�5�?�B���q�c��uj;8�Mc��!��5m�~R�Qq.dA���EM3:�u�ȯi�k�O�VJ���FyM_�]�G]0�k������t�\?�`�״�E��qt�|�c��_����n�a��M����+��+�]0�kzJ�5]�}��0��<�5�>�Q���Z^�R���D�:>>����������S��~e�h�ecl���>*Z�G]B�k� �H4d:i�G�������2_����!�T(Q�.!�!�J�BƖ����B�|�K�`�c%D��t�'D��G��ո��M���6Ɛ�[=����Jy��xd>Q��Pv3_`x`�{f:I�t�%e�♉`��⟁5�u�ޏ��$P31��4f2��J#�uI)�3QL}�Қ�w^��:ɒ��p�D dAͤpc������%e�b�1�kI�8f�&�5�8꒲@q̄0����лu���*G]R(����7%�L���b d�(`xV~D�W��[��J]R(�J3�Ucf����=���$P��(��}L��P�+uI)�8fb�/�fމ��e�Y���g&��c���� o�.)�LC�m�U}�k��V�K��3�,���?kj=x�4�uII�xfB
�lZ7���KJ�7�P g�*��<ar�^���4P<3!��^�y���܏��P31��gf,�<ɒ����kH�9xmW����g]R(�����&<��H���KJŘ�b8x�Kr�`h�
�KJ�3�p���x�)�k�v�%e��	a(x�;��դM�K��3���b���0���4���$P31����3��ҕ�̳�%�����C�Vd�ס��ru=��@1f�����[�
�kfC��%e��	a8��c&�z��J���c&����3Ã�{/Z钒@�̄0��3�x�+Z�.)�L�<39���2���%��☉a8��gk�r5�_]R(���X--���QV���K��3�POj��Ӻ$�ʉ�]���c%�u�6���0O�'9͢tI)�xVB
��e�28����KJ�3��e�Zp�Y���c&�����/Og�kv��蒲@��D0<�Ym�-��Wʶ8J뒒@1f�`�}�rrg#uI)�8fb`�}�������>��4P<3!�;ܔ��JG]R(�L�(f�«�!���bw9꒒@1f����k�k�D�LJ���n�Ō^NV���ȏc�KJ�1Ð�2��
�;_��uI�3Q%=�����5�[g�%c��X	@xD\�<D�EE�+]R(�����{f�O�o�6���P<3!���`%W�S1J���g&��x���ݭ+U}I]R(��fp�,���:�>��$P<3!Ō^���^��+�z�%���	a(f��?��'�Y?�.)�LC6�r˧��%�K,�׺�P<3!�^�Y��_W�Zm�K�Ř	bx�I/ ����A���g�_#8p�+��4n^5�K��R@q��0�6�v|o��~�%��b�D1�6�v��I����.)�LÁk3/V9���=�Q���c&��%��UU�S�1Ϻ�$P��(�X/׭﵆��i�e"uI)�8fb
`�඾-�~-K��%���	a�K^?�oX���K�x���/(�z��Ӻ�Z��W���g&�)<��WW_`�nR_R���1�p�ڔ7����c>�R@�̄0�6�M^��˞���_]R(���l�E����ٸ��uI�8fb`��xy8A�|�%e�♉`xvI/�~Z�k���KJ�3�P �5��]B�x��:�R@q��0�z1y��}�r?yuIi�3Q�Ы��:#+�r�%c��X�@(x����q�N�]�Q���g%��%�F�i=PΓ�Q���g&���ٗZ/���iuI)�xfB^�};�;�YŠtIi��f��p�N��=�+�ߣ�%e�☉a8��c������:�,�J ³J��i���a7V��$P<+!�.j@�8O�|�%��☉a�K����O)�b�KŮ��@k�T���V>��tP�+�axÑ��N+S�)]R&(����WWk���"��]G�G�W2�_`8~��ݸ�{a��A���g&����Y�?9LW?ɒQ�0Vb^�1�5�:��A�0�6c�$DW{uI��xfB�l�f��(�����
���N֌b��m�,�!)W���KJ�3 ��Y�A��Y��_����;cu���>��tP31G�;ۢ�߻˒1�� �6�^7E/��un��£���8^����?���]B8v��I�� ��M�ʒQ�p�'a�^��X�6n�|>��4P<+!? /cR_�7x3y��K� �3���x���2��t�|tIY�8fB��zQW:����.)	�L�y�˘eb���G���g&����eL�AN�jZ���c&����S@9���꒲@��D0X�]Ă-��5����%#��Y	@�){Ɏg6��Љ�KJű�p�x	��4�{���@�̄0|km«ܹ��UU�W�2@1f��];����F}�K��3�𷹮�zZw���uII�xfB�-�&�������8�R@q��0dY�N=�;z��P~uIi�xfB�,];����}�/�K� �3�p ���� r�g�g�+K�ñ��!�?�t��Ӹ���u�%%��Y	a8xm����\�C�J���c&������Q/�/}{?��4P<3!��7^�R��P�K��p�T��oG]R&(抢~؟#��Ű�=���������_�rk�(�c5�KJ�1��f���6��r��}�%��b�D1�0uiZoB��-uI�xfB�U�Ҵ��ǵ�ט�K��3�P+]��ߥ��D�G]P��aJӾ��_�Ҵ�������+R꒒A�̄0����l9������RA�̄0���k{��KJ�3�p ���ms�ffr�.)�L�l_p����ˡ���.(�cLi�`��'����P~uIɠxfB
`]������&A|tI��xfB
`]�����n���dt0<+��.M��M��V9�2A1V��w�4����y~C�J]P��Ҵ/0��z    �\���r�<���dP<3!�;O<o�����TP<3!�;���I'sI���tP<3!�;����[,��.)�L�l�/���d�ޗ���,�)M��l�/�5�9���KJ�3�P+]��ߛ3g��.)�L�'V��5\��TDȒ��� r�F�髾�ke��?��LP+19�5r���;��uA�Y.S#��Z���>π^�Euͤ.)�L���e_>6㾺�T]R*(�����˾��,���9��KJ�3�p {ٗ?hx>�>��LP31��}k��;��.(<�eJӾ�p {ٷb���&?��dP<3!�?]���g�����G��
�c&����K��{3V
�Zt����A�̄0v�4�i��]��K��%e��	aȲ.M��`�m�/{�~����Li��k]����k��.)�L�l20�ƞ��K}�%���	a8�M��Cn^R���-�.)�L�l20�nܺ�~�%e��	a8�M歍Q���|tA�7S���Xe���Ε�:OrM��%%����C�t�Zg^�~�~�%��☉a(�u��xo�/�t�%��☉a(����ς��+]R&(�����>�b�7��ᡟ���a4�}:��!���Zn�M�m߯[钒A�0/ݘ���J]muI�3Q�K��̧>uI��xfB�����Ȼa��.(<�e���p�L�������,�J���f^�¨�~�]R*(�����1�z�B}�KJ�1��S֕r�>��r([�2A1f�>��f^�n��J��(uA��.S)���ZWʡu�<��}�*]R2(����Z�i�ܭ��.)�L�lV8��hCS>��tP31�}T���ၩ)]R&(����f_���Ⱥ��R��2�r_`8�m�<VqS��W��%%�b�D1�6����En<�tI��8fb
;]1�������g�KJ�3�P+]17�Ae��[�*]R&(�LC7w�<1�Ү�:�R��ZN�b�u��x��L��Q���c&�� ��nh����I��
�c%��	ob�<������%����@8pm~�Ae�rJ��	�c%�����eb�����Q��1�e_`��l�_�\��g6���KJ�3Wѵe����L>�RAq��0�U�����-���I��	����W�En�=����y��ߠ8Vb���0-ƣ}*CI]R2(�����&�ŋiy��:�RA�̄0�U��^�=(�*�J�Q���6�p��������K��3�p ����E�y�K��2nP31�ɾϠl��i��KJ�3�P �:����w�ճ��_]R*(���Xש�ufs3�KJ�1�P �:��56�LM_�G��	�g&�� ֫�Ѻ��m��eޠ8fb
`�N�i=��pP%!����\�yl�����Q��
�1�p���[�#�w��KJ�3�p���۰��գ.)c&���]ӧ��FK�巹�%��Ee�q��UqCV�(]R
(�}��Y�.�W�JJ���c&����Ew��/=���Q���1�t�~]t71��q�,�U��$P��(�bF�=����	+]R
(���bF�M����m�~�%��b�D13�3��Cv|�.)�LCYFݡ5up�3$�ߤ�%e��	apw�p{�RoG]R(���xxf�A2�?�d0<+�;%zy�~Q��@q��0�6�b��2��.)�LC�����{�^S�!�.)�LC	�誰�:��ձ���$P��(��WW�=�����KJ�3�P o�#��n��O���H���4P���0�[��o���hG��,�J B�����6�㹞uIY�xV"���������Ni�~�[]R(����w+��:s/���|tI)�8fb��\N�n��?��4P<3!�Lw��7��]_�G���c&��3�3��uW�]�`uII�xfB��阩XC�����.)�L�1�3�K|p��|tIi�8fbJx�f_�_x��K� Ř�b(��;\���~�4�.)�LC�S���<��[FϻuII�8fb
�f3�@�7}�TI( xF�5�����ǵ`�u9��@q��0�6��S*W��K� �3�p��̋��K��Y]R(���'r�ͼ�W��v�T���$P��(��fމM�y��z�%���	a8�m�}6�E���%��☉a(��ͼ�O������%e�☉a(��ͼ�;�4�̣.)�L�9�f�����KJ�1�P w�y'�������P<3!om30v��ɣu�%��☉a8�m��	�R�w���%e�☉a8�mF-|�e��K�Ř	bx"���2U����Y���c&�� ����I_�G���*���Q����f)E��)]Rګt'G1��d�d�O-��E����W6�1��d�g��nW��.)�U���Q̢ &�0�����Y���*�f�0�x��&Q����,�U�ͿA�0ٗ�	r�{��%��ʰ�7���5ٗ7N(عf�m���W6��1�&������'��%e�☉`Ot�}S���b:뒒@1f�^�7�mB��g���S����p ��˾+2R�G]Rګ�}�
�i�o�F�]_l���W�N��b(��;��-����_]R֫L'�1<�3m�+N����KJ{�餼(��}�u[W��/6]RƫL�U��c�;�ήE�ߏ.)�U�����ҙ6�����u�}tII�2��P��6��I%��.)�U����`��yiΌݻg�.)�U����`�:�0}��l(���P<3!���8>���T���,P<3O�,�����gYY;꒒@��|�� ^ɘ�Q0�\��V��P��(�xe�L�Y�\�Q���g&�� ^�1S� j��+]R(���xU�w�ƕo}?��,P3!�1�f��	}X1ZO�d$0�����{FoW�5)]R
(����w8f��R��O�d40+�t���3Q]�L�K� ű�p�.�o���[��.)�L��W�m�m�L��y�%%�b�D1�Uo�y1�[�}�K�R@1f������Iw��l=��.)�L��1ٟ��������d�H`+1?"�u�O����I���c$��z�w�@uW��.)�J�_���n�fTm�SA�.)�LÁk���q��.��K�Ř	b�Mv���LJ?ɒ�^�vR]B��l�{N�WUA'uI)���D�P�$۫[�������K� Ř�b(^��%-^����<꒲@q̄0��%�����S���I���g% �x�韓3��6f�tI)�xVBJvɦ�ř�w7*�KJ�1�p��d�ZCz�����K� �3�p��d�x�2U�G�+K�ñ�,\��������W���c$���6�-�_��KJű�P�fӣ�ɞ��E���tIi�h3an6Y��y�/���Q���g&����&��K�A��:꒲@q�D0���5����t�E��KJ�1�p ���>�(�:��~tI)�8fb`�yy�3ܩ�d�h`8V"^�u+��p�u���K� e����w:f�Īn	s�%c��X	@�2FN��ג�J�����P���3�O���W���g&���-ɘ���U��G]R(�LC�[�gf������P<3!o)�ގ��`*�.)�LC��Z�g��L�̘�,	�J ���#]�>��I���c$�Xi�8�8qR�����p�ج�/)�y9��tIY�xf"�±b���ڭ]��G���c��#8�ٌ��,)=�q�%����a(hu�VE/�W�^���.)m&�!DյI������$��%%����C�I���u��Z�q�%��☉a�1e�L�N�r�I��@�̄0�_t��Ӛ��Z��~tI�xfB�/�j�[毩a�G���c&�� ]���[]�B=�u�%%�b�D1��1�φ+gM��R@q��0��3�����й�%���	a8��c&g�����cuI�8fb
`]��0���;��.)����i=x!P���
O��:)�~�ٛ�K
ů.pB��0�!    �p�.)s{�?�7�z	ÄkuI��3Qů��j��B��{��.)�LC񫫮ڟ��|�Վ��LP3!~�ڢ��'�{-��
�}�ڢ/0�6�㣵�r)�KJ�1�P �r��٢�%L9ʫtI��3Q�.�i�+z�r�%���Y	@(xu)O{=7^4���LP+1�.�i�M��lG]Px�۔�|���ե<�],Vx��8꒒Aq��0���4Qʇd�dɨ`8V"\�ⵠ<E?�,�H k����׫*]R&(�JÁk;B�	���G��X<�m
x���E��+��Z�Q��
���P�袃���tx�d��`xV��5�8���]�ף.)m%��X�e����9TE*]Px���P|��G�3	}���Q���c&��;���֍w��rշ��ǦL��J���	�3N��6+]R2(���XW�u�wn�atI��8fb���5@j��
�Q��/0��t�C�q���Wn��KJŘ�b�ה3�q����.)�Lÿ��)�Ǣ�ݎ���H�)���^�"؍g�C��ҏ�d����=1����K
�]�����~&�N�d0�M�A������qk�`y���.(<\a�����J���:�KLF_S��=!���g�A�,���a���ܯ\�����A�0<Va�����2�Q��	�c&���/l��]�~��Wu��0�Wp<�1�2�8꒒A�0������,�uI��8fb
^]ā�9�Hsh�G���c&��k{��j>�v�%e�☉a8x�/i��j)�=�
��ډ/0��t�Z��J�Z:뒒Aq��0��t�D�0�����J]R*(�L�^��/ȉ�zi�q�%��☉a0��K�|���E-��&ו�q圏��dP�[�`�[�����^G�}3M���r�y�%���ݘ d �ݖ d>N��r֫�"������Q�P�M���*�o8	sc��������/��>�%�~�7Lƻ=1Nǻ=1N���uq�N��E�����G}�L`���,p������ו8�U��ϙ�)]�\�����o�7��~{�����__G�2��9�5]e��Ӂ1�'��������__E�.(C�ڃ5κ����9	��9�����EѬW.<���	ʽ���a*0��	r8��	r��篯��YW F��WNg}�L`��	s8��D9�~���u����^yI�E��P�&�ܞ ���ܞ �>~���8��G��R���Ifx�o��~{��p���g>~���8��s{�t���+KH�qnN���_zɠ878D�(��m�]M��e�o�
�wcb��wQ1N���uq��,�0K�`~�3��nO����nO������^W�H�����S�Oh:�&�ܞ ���ܞ �>~���8��s{��S���o��s{���s{��������aӵ�h^y��4�A��7Lƹ=A�]��4�tw�J�0�.9�B�y?���.��5�Os��|�7HĻ�������>^���7�k���4�:�{���7Lƹ1A� ǹ5A�|���uq{�R^C��aiV��u�ݞ'��ݞ'?~���8�m���ZeޔV����a*0���9=��SP4[�{֣�a&0�� ���vN�0�n�-J��#ݦ�����<;�+���&��	r8vl���������S����8�u�;����:�`>����8v�
e]��4��Z�z�7��o�	�g'ơP���뽃�#�U}t��anS���BY׻?�q.�h��o��g'ơP��hޞ�O[9����	r8�-����__ǲ��x6[��S_�f�ݞ�c٦eT൵U�ﲄ��� N�8�/,2MIa��L�&�	r8����lJ�ט��7LƱ�p�7D{oE�Uj+}�t`��0��XW�y�D.�k=�f��	r(�u9��֟7?�|�%��M5|�Ba���֍O�FW}�d`<31��޵ ���%%���a*0�� ��XW�?�)=��ϸ9���ىq8�m6�X�����Q�0�N��al�1o1����:��CۦD����ȃ�8Z��lG}�d`��0�C�fd���|�������ىq8�mF��u�r9����	r(�u��Ӽr?DE��7��3�P�r�.�lL�7H]bxd�����X���KPK�z�7��o��g'ơ0�<�;��S������ىq(�u��z�J�w�G}�t`;A���ȃ8�_Gy�L@<3
����}>iu��70�L��al�1
���<�&�ىq8�m6Ʀl�^�ԣ�a*0�����f���5���}�t`;AŎ�a�gr��Q��q��	r�a�v��9ϣ�a*0�N�CK�Gg�Y���h3Q
��;Z7��W>�f�	r8nL��su02V�v�%�'��	�p(������o��ʦo��g'��06)��'����q��S�q�9�&�gE�F>���ىq8�M
LX���u'}U}�L`;A��.�~�����֢J��.2���p(�u�"�W����]�">����8v��]��8��{�+o��c&D����O�ɯ���}�3����876#?#Q�2�Y��3Ef��o876#ce#�2�Q�0�N�C)P�E�4�|3k3�_}�T`<;1���ȍS�����_}�t`<;1��������('y�L@3!
����;��W��K��]@��P�m@М7�W��o��c'ȡ0�Ǡ>�gK5����ىq(��٣h^B�T�M����	r(v��O��*�}�c�%��e��p8v컪�y�n)}�d`<;1�Ξ�Ӎ��	泾a*0���8;ݱ�'��)6�����8v�J�jC��9�i_]�d�o�	�c'��P���ş�]찠u��}*�W�e�p-:��X�&c�9��`�ws�������a*0���BYm��4�T��H����	r���ޝƣ΍'�Q�0c'̡PV��ps����Y�"�u����/�W
e����<a�-�y�7LƱ�p(W�N�M�p$�A�0�N�ál_��o�X�g}�t`;A��/�A9�9�l�3�q�9��%����pQ�K����[��p(ۗĳƼ���k}�d`;A��}I<�1��}U}�T`<;1��m���)X��z9��c�97�}IL޽-勇BO����xvbzP�������.��K�g�f$_q���6+O������Q�0�N�CVn���ꐷ�)��S�q�9�6+��JS%k�G�0�N�ál�2υ��Y�0�N�ál���W"e�~�%�]�~_q8�mV�3�p�\�7��o��g'��P�Y����m��ݎ����;a�q�Yya����o��c'ȡ�I6+/�Ú׽�Q�0�N�C*٬��'���K�X����8tg��ʼ�>V���o��g'���1Y9a;�W�ԣ�a:0�N�ñc�2�?+F�8�f��	r8vLV~O�t����%���u����y�>:Z�G}�d`3AǍ���|��2�Q�0�N��qc2r�Y'�&"���a&0�� ��d���y�.{�i��pW[�5~š��&#s���{������8�������$�cW2�_}�T`<;1�r6�^7�YO����8v�
�l32�����3��f�ىq8�mFƔi]������p�DW~A�0�ٸ�����W=�&c̄9�6#�0�����7LƱ�pی�x�g��X��o��c'��0����O>uD%v�o�	�g'�!+�f��.���`~u�᤮���P(��1ײ�����q�9��f��I�Z3�_}�T`<;1�r��!��1��&�Ӂ���8��f��]jޫ7��3�q��87�n/��V<|Ԣ|�)}�d`v;�p��"��'Q3���¡�a����Q��i�8�p��NÊ����G�0�N�á3=;89����a0�����T 7/���/�*�,��a0�N�C��* �9�I�z��o����P(�
@n�x�/�+�q�7L��	s(�U�Ӝ7d�/>%�o��c'    ȡ0VU�O�ֹ7�JÃ�a0����MT 5�L���z�7HD��R�A��έy�}'��3����8��LF�3Wn�"�'y�,@3
ψT����>د���7L�3�p�1٘�&�����o��c'��6٘�����U}�Ӏ���83�dc~���AO�o��c'ȡ�L6�O(L��#^��A �L�³!�d�����V[(}�$`3AYQ�)���W��J�0���7
cU���1��ڕ�8��c�9��������r@[�f c�9�ݳ��\��d�	Px&DU�=��P��rY�&�	r8��g]�j.�o��g'��0^����y���7LƱ�P��k��q��kU�b��a0��o8��T1����r�7�Ƴ��Ԍ*F��כЧ�-�J�0	c'�!+��ݼ��/��J�0�N�C��
��w-�� �o��c'��Pn���P��9J�0�N�á�;��d?�F�f��	q*���ħ9ϖk���7LƱ�p(O���я��E|�S����8�˱�7YY?�a0�� ��fج��08��˵�J�0�N�Cjج�[o��R�Q�0�N�óE���<J��Cc>��I�8v��2����cq�z�S����8��f傃����q�7L��	s8�mV.�V��{������xvbe��1tX�u�~�7�Ƴ��|ѰY�`c�zݽ���q�9�6+t�o#�o��g'��P�Y;�򆅷��}�4`<;1�ʹY;��n��o��c'ȡ5mV�.���jG}�,`��(�gO���XƐu5�o��c'�!+�fe|%�};G�� c�9��fe�gFϖ�N��i�;a�����b����o����p(۬<x�8����o��c'���"]������W_G}�$`;A���ʼAw ,叼A
 �����f���t#GG}�4`<31Ō.JD�g�+��?���8v�zH�(��K����T��Y�xvBe�U�Os[k9�&�ىqȊ�D�Z��ս�)�8fB
c]X���̅;��o��g&��0��q��Ֆ��|�3�q�9�^6���֏��Y�xvB���Os�C�����&�ىq8�m6�������o����p(ی<���^�գ�a0�� ���� D�@U�_�d �	Q&Ql6����?�S>�f�	q�����)y'޶��o��c'���1٘+Px����M�0m'Ω�1��c{���Q�0�N��al22�v��m�tƦo����p(��̓:7�Rf>�f�؉q&�����Ŭ����o��I�xvbe��+�gtM9R��S���|��P^����)G���a0�� �BYW�=�q(�L�o��g'ơP��hN9�w��\�f�؉q��?t��Ӽ�ws��=J�0	�N�C����М~�\Q.gu��a
0�� �BYW�=�q�B����Ӏ���8�ͳÛY\e�g��7� Ƴ�p(w�/��W����7�ƱⴛCyxv�bB�o��g'��P��2O�s	�����a
0�� �C�f��k-yK���A �L�Ba����u�WI�o��c&ȡ0��O����u�7�Ƴ��Kf�꿧9v"(��o��g'ơ0��h^�!����o��c'ȡ0��Osy��J]R�0�N�á�2r���KK*}�`v;�p8��g�7_��X���Y�xvB�̡<<;�����\կ�a0���Cy;�x�2f9 ��S�1v����Y|3�/G�o��g'ơP��h�
�e����3�q�9ʺ�i����6�M��f��	q蒆� |�?K@�Y�0	�N�C��+ �<'.6M����S�q�9ʺ�i�S��V$J�0�N�ál�r�n5G~֘��a0�� �C�f��I�G��:�fc�D9�C�f���y�>���I�xvbe��'fn�y�R�0�N�ál���k�>��Q�0c'̡Pֵ{Os�.�jG}�`<;1����Cs���W\_G}�,`;1N�Pֵ{O��j0���I�xvb
e]��4G�_�e0J�0�N�C��k��������Ӏ���8�*+���3���.T�f ����á�=;(���&��Y�xf��a<+<������a0�� ��x;�����EI}�`��0��Xe�?����#�N��i��v��P����y���*�c��a0����X���9~�RԶ�D�f�؉qx�O��=�;�1���I�xvb
e]Ç�Ҩ�5TJ�0�N�C��k���
�����♉P8����yp5�k�#͵�a0�L��a܍�)�_mCv��a0�N��3|���9���d�^Z=�&��	r8��g�;j�jk�o��g'��0���j�73T��i�8v�
e]���?��fYG}�`��0�BY����z�%M��7��1��잮�{����6��� q��(ºv�>{=�{�S�1f�
a]�����J��Ӏq�9�6?]�r�U����xvba��j��h���a0����B�v�i��7��I�xvbe���'���&�S�q�9�6c�l�����i�xvb
e]��4��U�]��3����8ʺv�[�9���ů�A ���g�t�����p��\��������8ƺn�i�oԭ�X�� �ىq(�u��_��k�'z�Ӏ�v�c�����e�3�q��8<�����ͅ�#QE<s�o��f�+��p�<5�]�i��S�q�9;���?�ت���a0�N�ñ�<;g9�Į�3����8�U���<g�aR�o��c'��4U��n�'�_����&�ىq(vT��Ӽb#F}M�рp�3�^/����UZ�`|�7� �X	s8f�c����!���o��c'��9+U��4o7�G�#a0�� �c�fc��}�m�K��c�9;6�w����Q�0�N�ñc�q�1:꿦l0���Y�xvB�$�6W�����I� 	�L�B��e3�����>�� �	r(����X`I�e͋�7LƱ�P/��+���4�_}�`<;1���r��=�f��	qx�hٌ�%cؗ~����q�9�6#c�)�L����� �ىq8�mFn?؁��D�A�0c'��P���`�j�-,�3����8�6#?'��k�z�7�Ʊ��$Ѳ��Lm�Wk'y�$@�� %��m3r��py��֏��)�8f��N����B�Y�0c'̙�y��<����q��8��1o���?Џ�n��g��38fl&F�>%���R�0�J�S�c3�p�����i�8v�a���e�jCeP�o��c'������y\Sl����q��8�C�fb�~�~M��I�xf"c����������Q�0c&̡0N6Ol�͋*�Q�0�N�Ca�l�8�!]y��3�q�9�ɾ0��0�:�f�ىp�:}&��y�:,9-�o��c'ȡPN6#���;%k�G�0�N�ál3���jnM�">��i�8v�e��'>4�z>�f �ىq8�mF�����b���7�Ʊ�$e���Ɠ�l�o����p(۬�5�5m�Z�0�N�C��mV��q۩Z�0�N�C��MV��;<�#���a0�N�C��j�r¬I{�g�G}�,`v;_p�OU��4���א�gJ�0	�N�C��j���'6Ыg}�`<;1�r3v2>��Y�p���i�;a�rw��߽�3�q�9�ó���5���Y�xvB�¡<=;8/.���o��g'��P^�^�����Q�0�N�C��j�2�J�!�u5Z�0c'̡PV�zܜj@oM���3�1v�
�b�2V釘V=�f�؉q*�r�Y����A�9�Q�0��fS�@�q���������
s(��ͦ(��ϩt���a*0�� �C�fS,���*9�Ӂq�9�6�ri)����o�	���p(�ײ��]by0��%���xvbe�M;����8�&��	r(��ͦ��W��7L��	s(��ͦ�**�?�����xvb
�j����K}���Q�0�N�C�\m6Ŗ���R�G] 	  b��c'ȡP�6+c!?'�T�����xvbe�����[SW?����	r8�mV�������>����xvbe��0�	I?�a&0�� �C��q��.�v���%f��;a���ʓ�����q�7LƱ�P(7��'N��w��EH}�T`;A�r�Y#��)^�U}�Ӂ���8��f�}j��V�Q�0�N�C��lV��p|��r�%�'�t��W
�f��ĺ�}���7LƱ�p(۬�;{�.ף�a*0�N�ál�����}�ܥ�a:0�� �C�fe��xmiG}�L`;A���ʼ�&6�U#R���ӵv_q8�mVF1H����7LƱ�P(w��q|0���y�7LƱ�P�t��yYbzܯ��a&0�N�C��MV��ϲ��cv��W�L]q��b���̻�e^C�K=�&��	r8vLVƦ|�=*�$o�
�g&B�\�X|\yo�%3��74�b�/>�su	I�U��<o�ƀ�>���_��|C��zM��sF�n�u��濯���?�����      �   �  x����n�8�����������9��KI��7ڔp��V ��f�~������ ��o���ZKV�o��f��yZF���g)�J�[|7A1�hŦM�׫S�ɵ�V9b-�h��I��Vq�S�v�lV��ۼ��].2��@{vS�N�R��=���| *ɵ2v}?�N�Zr�(�Qlr[��k��u��&72W�+o��ib4+���VC �ְ�C5��l�a[V�%�m^jvy[�ϪT�܆\�!*��]��f����8���������yi� �s��� �XTܬ��_M�|�7��ra�k��e�Qu�V��y�.��+����"� �����SۭO�� �h�&�{�?bz��$[*�I-i�������X��*�_�v���/u�� �J��F��J�8�z�IT���T\`R�J�d��%Io4R�5�������_��we�yy�n��D	n�1�f����=�[� �;!�U(u=�7HC��h?�o���⻲���"�3�OY�=ޝȋk��RS^/�͸���YK�I4�s�d�B�f���(�1����C(6�uYӣl ̈́�UT�f��aV���\g�a+����Ɵ �%��7�'�}f�aNp��%��9/� ������@����1�+ۭ��yP�6hI�m]���n�����"rp���a�2����a1J���~+8�i&ټ}���}\m�ݼ��0�H/�$S,���E����hx�s�V�H24�y�5ouZ"����NYZ4?~0�c̻ͻ�̡��Xv
װ���Q1M��.���ӵ%\� ����E\-N�0��XP���oM]Ջw�;d����3<.z�޳��xz�*��{���^ye�VK���6�R!sJO�Ik4V�=���{�-�=�(�� &�����4- e���.����،�w(騝A���L/6q�.�/|�ۘ�P9̍��UF��^T�b�eG�m�q^F冷oFuU\�e�s�����
���y�$�Dt7�      �   �  x��Z]s�J}�~�<�p�Ҍ>yZp�׀���.��e
��WH!�������K��H,�������[ ���9}�ǶІ;�eʮ�8�Q�l����l�Y$�(��~��e&�x�=�xK�R~Y�,��7��1�0�t�ӵ,ô����pK6�E1�.sv�&�+k??]h�����h3��dm�f�0���l�1ϙ�.�^���J,{�ћ������t���@�Mv����d%36���E.�9�-aZ���m&�9��J��MA�'l�l����$e�w6�����9���2��H�F�w*�!}+�,��6+�{�)�{��u,�[V�]��A��A� ��d�N�
��f-Z��t��f�d���|�
Y� 7��;��dr.�t��~���u�ݵ�a���i_�Y���4y��Yr��0Mѱۦ�t�6�#�~��&�v��#��\�V+u�]����|�+�/�2&��ҭ�W��&7��?�յL�q�S?N�z�6ΟWь�%�{����L��$� Cd�d�E�І�uHU��G�f���d:,\�<���eb�-��{4���ъp�e}����<����G��]@;�����6ࢄ�o[l��Ȼϒ"��M�FrŮ7���_w�o]���p�dױu�2�h?�2޼&iVp�k��-{Y�|�G�
�8"j"�&���5L��*W�5�z�³ڔ#]�6��Ae������w�:�ۓ(^Ó"���}d�+�յ=�5�&�n	��@�=!�.9��Rn"��fH`ɞ��杖����ā|h�o�떭��8�30�ߑ�yj���]�` {!,�Z�;J�oK��nW����#�ڜ�ٮa�����k0떣�W���$])R�-����^{B���9��`���VX�w�~��ڮ�B��u��P#�-I��ʿֻ~隬Y���;X�2d��;�1�=�/���Q��X�'U����El���d�-�RI������;1�:���#eA���"u�d�ͮ%��&�UEΨ��b��\o����^ �d��x�d׭@���$�h�̈E��Ol�,�M�P\��|�(*q�"�"U?T��2�ʍ���t��I�؂q_4�unj��XpȓA���p���Tc�hn��5)�<V�\ทk�˳��}��r�7�u�� x,�<�g��L�n��T��^E I��P_�Y�z�U$c�۵\���g��%��2��_D�*�mT�K��F�m���\%@�l�o��ɪx������a����0E���(	 6R,P,9I��kW|p��;u�(TXbϭ#��:w��߾==��0�U)�)6�A�F��@����9%+DL�@�Z��vt� N��!�̮��V��:���4��w�=-_)()[��Ql�R��R�G��C����Il�(�I�F��J��g��x�	�T!w���A���	,�8��:w����p��k�"V����0����1�+uy�m�	��6�m񓨊��**�:����$���XS[eL�e��� �,�v`�^=�]�>=
�~[��6EK=�Q.ɽ݅V��ϵ9d;�7�uajq���I���rs��w�&���Vscf�n2䠖�tm`����+y*����*��w�V<SW�j'���K�Mv]p�X��V�Y/M5Q4ť,-��[(�?��RyQ]�A��]�+ڊ�]X����V�,
v�	Kt-�px�]`����	�	�-�A����Kѷ�߳��}��C��_��M4X�#�&�.lm��-�5+���|γLV"��G+%Z�+�ԋ��w�}�m�^b�e������5�u�lFu��B�n�2,���]nQ�F���������	���B�1Pj��`��e$�^�C�a2�5~lcW���ª�S�uA$�y�4���������$�����X�ע0�f�;���:�$���x�ɮ_���a�&+���>�?��-g�%�E\V�f� �S"[����Vt�S����m���.�תt���lx�=G�K:��z<���0�g�u�` �N�5�u���)�2:��q#��������6�TS�O��"d�!Z��C�A�	H�R.+zt���7I1@�Pk�o�6��˦jI�$^�����yu��M�U�̶+�n�Ue�IV�C�Vo���wWS����l�tֲ|�A�m��fn�a%hj96�4�u���t�5v)�0�������:�3E@��]�w}����a�]ΰ���qӭ��; �d�m�^�K�/UT����%����( e� ~Y�M%�ś�}u��$�F�r�I��e��plG�%P�~��E≸��V����^f�:��y��a.�1���.Y�B��F�B���f�{;B^6�:О�|�7��Z>Ӑ�C7TW~O@�!�稊�T�
�PSP��ޮ;&��l'+�ry��@(�U<�)N/.ޜZ���R��oxUM<��؍=5�(2���뺗���v�J,��f��^�T!�`���e�o_��X|\.8�{�8Q�u��>;_�E��4a�E��lp�����e���l9��0¯`D[�S����n3:�Vꌎ���CUݱ!�&����^jZֳ�cA<��s����_�9�l�X2���������=���E������d�W�lزo�9���偘��Mv������ݰ����Qoz�0����ÿ�v��Y����C�F����!Ҙ��&��Vq��a7�Iq�'��4DE�˧#���c�ܮf�''^E�{t�/:VD�-t�Mv��=�$�U�T��^���#��hD2J�y�� ^BVBe��/!��̘(K�n�]wM�a����,Y'�P)�@Pm�ݛ7s|����Jo���p~�Y�Zlϛ3<p���{�g'v�6��Y���h'[�c�Dڐ��h�S���5�P{N�Ȝ��D<��j�-=+��a��?�޽#      �   .  x���Mn�0���)t��wA�m�2�e�H
����m+f8B H~o��Z-S��:5�~ض
-����H6Z�X��4������(�8��%u�A`��s��q�>��|xy�������4Дt���x�"�/��+��9G��x���7��Ĭ�Z!�W�s���J����]M������BÈM��`����*�Ý .\��$�P��������?Iٴ�ka�K�Rd���@05O�̺T��c��M�T�5�"���1�&Ƭki(�s�(�@24��L�AA=�k�Ĩ6d��+�Z��؛���ޤ��կ��X�~�놼������gp��Xn=���kie��on�׊q�X��Ñ����Ԟ6h.���C�`��yÎK��4���-� ������kSu�Z-�/�l��@��h�Od]K���n��:�M_�n�as��ֆ��u-��N�m6��o��O��gd�BI���)l��n��,���\ҵ�'V($Lap[eu0���k�f���Z��h�      �   �  x�uXێ�8|&��?�����`�,�=	� ��¶KcK2t�W��-R���6��&,�[�:*�&�U߯�X=���T��ٯ>M�L8#��F+��.���U�ջi��f_OU3�c�mk"��OL=�b��Z����6e��ؐ�`U������jFSB��0��g��W�K��P���<�f_���X�5�D�Sv���s�[=�al� ��V[��cu�G s���k��Jf�锝rNl�y�Z|�շr$�"���B�\�zjc���v;��ມ}q�m� ��5g���{T�gL�%)bT��%��)��J�I9��	��[ϔ��$=�&dJ�[�v�U�`ϓ"bȥ� �:���E7ٯS���׌�E��H�)�!r��:����8�"�8y�P��:�������� L��YƬM�)75��}>��j������g�M�����컧}׎�X����L���[��E���ׄ����iD���c��k6��MCW�Ǒl�.C}g��);��E��u���_�U-xyQH�.�c�ǹj6�_KP�0՚�x�V��y濫�2�ex���~��}V��t�s�w�d�:_+��m��`�GN�z����o����s���C;�ø9�g��v����
#Sv���F��� C��Lf
��%��9d��{�8��g6�Sv*$A���v����և�ݲ���!���p�-���*���'��y�W�Y�P��|7lF�n����i������
�	����V��9d�DH)�%�ն����+�9��˸����N�K	�?���)���������k�޻����-n�s���I٩ ��Ke|c�f@�&��ɚ��5�;���2�&B��M٩(b�`}k/&�b�ػfh}�~d����0V);(L��i��uo�Q
e!%��g��;�n(��P��zǓ�5��q����������x�3&fH!��9�0�b8c̦��k��J2e�Z!���*l��� ��=�"�ZY!y�Nq�x��G挤G̎�of�1#�$��ř�y�N�X���JF+��J���K�5~8u��U�r<=3);��H�p|���/e�>�9ɹ��_���O�C%p1�c�@���T"ck+A#s�l���8�*���j��]]'��\�<�6O�)T���Õ�n<���]=gN�\s�9�;�m��/����}A�0S$R�^�x�������k� PRaDo��m��'�C�<`�g��);�8�fv���� WD��h���aNF/�F�);�SK��
�EGP�B���
���,�C۟ܫ,���s�1u���Nq$�Wa�,5�D�0�ޤa;��'?$k�X�I���֎�b#o`����|mf�2��*�<Vʡ��d�6�Ѝۡj�p�6&2cm�N�!����"� q/f	`�׈�o�B?'��Z�k@�N�%HV\�V���Wax��z�|!�a#{9m�V{���'�TV��B�v�r��[Ɵ����0}�s�3	Z��P���ک*��s,H�EE}<���f�\ΰ�����7]�=`�M#ڰ�(nRv�Q���f��o?.�$��5@��G�\ĭYd�FY��S-�2�VͿޭ��`��O5������G,�Y1ܦ��	�5�4>����(XP��ݧ:���k��7�����}�_/�"����3���ckE�"��r���"�mR�9#�48��I����$�w(;Ն�(|�I�5����o˦=�f��z̀#2�����Y5�n�m1�,g�]���p�^\sx_ ���
�����;;����^��dahr�G� �l�7a�&��E(t��"�Z��~V߱�V�b�'�{
�/Ӂj�Θ�);5���׳��<#h�<(�rh�6�1	�1�T&n.f
	��<��ν�XX�/p>��(~;��B �Y��os�R�3~��wv
Y��H㒡8T�ˤ	��Q5��~�U��'��J�)6[�r`�O��
t��`?�ב��Z���@wv��Գ�Ϲ� ��c�d�ɱx�{������գr��/h1������h��7�ky�Ajs;�StTT"�W'�HЭ썏7vjA�]��K!פ�g9��X�ZW�O��h����b����N1GT��������2�,�ϳ�8�{��g�+�+�4 �:��4����|Ⅵg����bys      �   �  x����nE����c�p���gn`d.�D�B��םd�zƚ�M�A�8��#�P�^fބ����z��4�Zr����U�ǿ�,3�q�3�}a����^ٺ��mW�˧��Gug�DC����3��C�.c��c"��FT���4��)8+��:WQ����ّ� 87	�tv��r�B��L	��k2�m�Isu�����z�����f!uL�
CD�>�1�MT���}�ŖU�>�6��}Y����r���*��t+S�V�:&eW �$����C��T�7C����6����C����_�Q(�QHSɢ��ƅA3!�8�3[��}\v�m_��e��^�'�U�\��7��5�1�"��@��m�Ao%8gz�U��8�.��2�_���ľ�=n^A�'��������2!a��\���<������B�,���(2���" ��s�}�9�!!1��Ϫ��`��K������8U�&fsYp��ȣz`�{`Z�	�Ɂl�LM��2�|��N��p�&��ͣ��������}0���������콙���rOAK1�%)��R���l�����r��mBؒ�ƚ���7���k~���3=�[;=��>���J�������ȝ��L4&{3a`�zR�o��ꛄTiA�G�A��``�F�a�\��r��v�We��z�{r`I聄Q���V'!3�`��z8R����S��4ޯ·���e�F��p����Crs�}h-�\)`����g�s�u�[_���ƚ�����\0���&��}���\]0��t��zಃr�ke�eu�YL\�¤�N��n��c�hTt������t�K.�z��@��{x�k��&
B�&��wz��kJ=���jٵeW55Z__�]BUp͛[�DT��p�B���.Ѧ�^��=xh�����ѵ�/!�����C��z��dr:Q�Û�~H��(��p��Ɂ�g�O��f`�g�jo\���Q�ha4�"&&�qY�wMƴs{um�da.�����'`�vw	��u�����>}ט�K��
���ȮM�mWfj̳p�*��^c�_w����>@�&�M ��ޭ~�~8"�.�K�F�	O��}��ۡ���\%D �����!���H>�����.V	|��v���Ɂ.���+�X�:�f{o���R�7�Y8h�a*iTp�
�)P/��vq��Ɍ��/�C�u�..��� j����b1���/�G      �   =   x�u�Q�0��T���[)ӂ(�>O�ڨ'�(P�	����t��9���;#��      �      x�����n8��S��*���Y<�Y��\=�c�A*.ۃ$��� J rU���r��'� A�/�J���˩�q�������'�Յ?����*����?��������~�3�R������_]��������?t�?7]�����b��b6�.���k龼n�\�K4�.��'e��1'��?��P��7���8���'��ן������uWJ�;�)�R�/�_$���1j��_9�w�~���Ǜ�'������C���Z1���g�o�<��Ew��'�+Wo�7?�/�M�	ﻦ�z�埅?����'%������~������������قo�����6������n�����xu| ����4���}
~�v4�RZ��sA3��L���N�>L���a=��a&����(�Ȁ���y*~��?�^��qg��}��<����+�.z2������{�o�=n�9�C�z�&������o�R�e�\�c#��'t�h'��~<�����ZC_��\ty�R�b���!�(�C��/�1{B�Q}��&�9�6�[{y����+K��G ��ː�˸��2�7���qi�ߗ�m�OtW^� �?t��m�O^����e��ӟX���&���V�̜�}y�Vy�H�_�	�?th�y�0�qy�5��x�M��Cg*#p��+x�m0p�CkW����w8]M�����f��G�"��*t01�h����]���/6�Խ���-�LCl�w��;}j�ˬ������~��	%�����ѢjIϡxb��ІM��O�q��+�k�7?�zX�5x��]����/C@'�k����jh��;�ݹ+do�;Ƨ�va���d���Z�)8E��8W\3��7���o�ZM��h"��K��������\�/�Wu2���DrG����1��C��6����cK�[����?�(���cQj�7/�����.��֗������}z=�9�����& �+�N��?0"����xj)��z�%�KF����K�j����n%G3��6�'�K<���'o���e��C�����&��U|1�0n?��qOֻasI��K���IR�pb��f��G��M�a��@5���˱�Lc�*�VM�a�హ`��>\0�Ţ�����9���_�j7��\��M(����iX���&��_n';��bǍ��'���~tX��/�����;���_��ov|�����\�sry�O4��.����e�@�V�3͊�\��J���᠅��'dn�~�����˅j�?F�xx=�{�����?S�^T���?�p�דd��.��؁A�w~��!�{������L4�?��?z�#�K'�'���#�o������{P<��kǀyi���ӻ����A�)Xx����+m�sq��#{�y��Z'��1o�V��]b,t��P���<>qp)'�������+0M�0�.�B�?}�Ѡ��9����`X)z�T̆���/�������{m��)4�zK�@�7?S��{-�!���}Mԯ��
]3'��0�_�ߜ�������1n`�f�w�ղq7j;�'�ԡ�ӵ�M�ao��6O���-�i�P���t�������"��><x*��-���M1wr��?vq��:�\��?���t4��]4��	É�&�Ї_�B���3��&=z���"��CMϢ"V��(�|�����k�`��S������]�7�>���*�@�ҿ��mI�����Y� M�L�7������� �-o�?����Fߣ�fW�ƍI|�B��f�;Ͳ�GѤ��h������k����׻���z�ͮ&~�cb�w���ů_�n�K�:��?��׵��y7��AG,M������{t]f���M��?��!�?�C�T{�ӯ�\u��m4F��]3�.��\~�HƗ7]� ���V��?sy���u.���m�N�;����v�[�,as��w="��E.�7����B��L̴�����8h%_���;����e�-^�),�b��M�}���IC��Dn�E���W�⦑[����5]�6��)Z���ej3�k�&����ń��k��/L?���~G��W|����qa�����ǿ�ǿ��?��_��؅�Н��D��b�������/��5�a����s�NnS�^d<���Fv��Y~�l���0_�6 s�.(�V��і�L��{���ٙ�ՠ��/�����g.��'t���Cau�.k��{�-Vz�����������JS�D���c�t]����e��
�Oh���ћ�b4p3Js� S�Z��`bC	k�@� �ß�Ö\;�&»�M���E 4�)_RM�ܛjʴV�1!Z����u���Z32��h�������tK4��	_/���{��)|����
~byz���}фiL�Wx����ե� F8�L9G��=KǀRS���?s��sG��	�o�x!��M�����s��V��`�ė7a�vּ֯�!�(�@$FX����c��-�Q�ML�S�?x�.��2����W|�)��?kz����u#�P
B.E�W>��(��2�/o��#@����,�gLK�T�.�Mw���&���\.Mȉ��B�j����9�E�/׷_X)� ��`)"f
U���f��3�������e6(r)�\�z.a�u�7BZ�\�5d"�/I�8�6�o&.���e�<�i��42>��F(�´C�6G�"�� A��Dԫ�� y�3G!ݗ׍���Õ\1q!D7�|�1Ӕة���BH.s�\��R0�)D�c5qqXaHK�{UE7����&����o �u��A�#�&.�0���Q��/���@�4��l\�I��i�-^�����!i&gTj���>�7RN���%&�!�rbH�������D����/���fH�t�O�h�Pp�|3q�E�������;ŝ��B&.�0�����w��o�!��k7q�Ǐ�]��^�e#���.�(\�e񫒓�._6�F�]��BXU������Ģ�Q#6B|��h��e���.~�fиª$����W��D`����98����R�یt�B���f�/�/a�p�8x�B�J��<����Dr4(�ཉ!L(���u\4!�4�t�ą6�����˴�ȋ:�1,\�a4i�L�#o��<'X��88�ỉ?�->�q�z��n�A�i���⩳�ʧRsn��ئ��ìp��i �#�uc��&,X�` y e'�E8�x�\M\)�~zg��uc��ԫ7Ř������|_��h�)M�0�2^\� �C.�.�a���8[������ܹ����u�Wh^�B��m�A_t<	#�X�݃c�_�&9���t��}�7���}��K�
m������n��r�Y`��N\Ѩ�lԔ̗׍����L\ѬK����WB�q!D�.K��E�Hn0�t�N\�
��������>|��M\��^1�U;ZYhD��xM/���Qi�5������UB4�ҕ�Uc�9��$e+si��&H�,����&��ɛ�b��2RTΫLu'�X@��ą���Ր��E�D,9�_8q!Ļ������w|6qOɋ���g�B�/Q�2�\�z��m\i����e\��Y]5q!D��K<��hB�U��q!D���W���}#�*I�6+�R�E���I�l�4��?����mwB���%����J�E�։=��f�l��&���dtB��m΁iM�4�t�֥�bB�L�K���vc��օl�B�W��l@}\6�ʙX>���f���9S�莲�Zf"�ƅ6Ӧ�^��,7�"u��#z3q!���ӿ(�E�H��
zmS`��Ŵ��B����31�1���O��}�`�}�n씶Q�:�!L�/.�sQ7&O��FްС�wi�6%�EݗO=Z7q!D�Iͨ,ܥ���&Û`[�d����[���km_�B�����>3�Z�?2B�����{�����t�yW����Գ�!~V_�v_�w��Y(\iO�<    ��拾1�0�
~Gk���P~¸�3�!b5q!$/b�}δ-��G��Ex�:a�BIs� �qY��:o{n�-Ğ{B�\�G淲͟��3V�˝����p�"j�j.�d�W�xz�b��O��!��;�{�c��m��p!��D�P�>_��h^��!����?�hB�2x��l`Ҹ��\��mi|�7r��t�'.��}�1�J�P���M�s��ͼ&��x��R�,+�+�?���=(\ic�!�#Т�ٶ"��)m��?���=�)	ڃ�q�t��}����Q��j-� ;�P����%��y)����c
�x_�a�t�t3���Ӧ��)r��H(D�q��� �o�$puR����z�A��j����ɻ/wD�Ƭ[�ąF����1~|�a3w�O,��N%����*�S��}	�	�d4��[��~�r�B�$�~*��[X��'�V.-X��_=��fOg���{#��ą�.�d�H��4���j�gO�/��=��1�7���hĨQ���?�P�s�`�����S�#K)����e%>R�&�͇|������ą6��G��Wg��(�Nѐ��:��ŭ{�O�皾:�T_	���ٯ^v�Z%�k��u�z��<Ս�j���Q�h\����>O���^�qu�|՞M\���3�7Z�_�]k(�+����"�Vg$�q�Ŝk&.�T-eY�	�E݈�%�'��Xq!$��@��|�7�Ղ�/}I ��:�_�-��ҟh�B��K��}cӝn�B�g����ܾ��=7�`�B���5S�+_�ySa���L\�qYb��Eߘ�ƴ
��}i��([�T=p6^J)W�mF`��b:YM�cʙL��Ơ?�ąf��>�q,�*y�@�
�'I{��F��^�S�h�^��� n�{ 0.a�nUM3X���UR+��DR�̩xŜM\`diOZ��l}QN~�ޛ���m�#���V�&�z���+.h�iF_x'X�-�3�hˆ�B�`���n�k��"���&1�0��T��r�kϽ�}&d�c^�H�qt�~�t#���?ɻ٥��*k�D{�
����Ev�7�/棙�ě墶�?nE&^�j��&ٱ��	,�T�K��_6�Bˇ���1q!D;��8e\6B��7N�ډ!�a>�Y����W@��Z`�" ;ˇ׬m׃(������� ����xI٭��
�}�6ĉ?
�2C�6�a�ᢱi�<AGS*���" ��_�m�e�R-.q�͇��uw:qQ@S�_��}������բ�
���z*>T3n��i_�=n�_��1	����A�)��I~� S�_� pl׸�I��)�����E����@U�R:��2��S~N6q�GC�_��\U��)S���Eo�fړ�3�<�����'.��O�����܆*/1&�]����#�ie�� QkF��	��z�5K��C���P�m��D�V�J;W������#OQ����]�" K�QP	�j�?�w&��ix7qQ��5;��(x��~>�g��(�!Բ��л����Z�x�ָ(�Kռ+��>�(��\꽪E;3�(#��m��V���^l��q�&.��7rS�Vw�LT�_�۸(�-�ma�"{�W繗�?��6k���^�y���iO�.x�m7h*�?$�=���M\$Р�ɤ_��w��^�J+.
���4,�=v4b��@���E��ͪ᦯�"�����ѭ�H�I�6:��*V���CG廖�	������-[�f��p����^e;Mk{�_߂��P�L\4�����{�VU��5x�c���E���s��G��w�ܘ��?
h���#5��k��b��H�⢀�징��3l�.� g�&.�}���y�_
��5��?n�����w�3e�Z�������⹎�����K7qQ����X�]�T����l⢀��wk�х��m�{׶�_Y`�z�'c��_j<Ѥ��`�DtTc�0ҕ��O�C�xߡ�4qQ�?�����k��Po�su[��H��w�0�Z�_���1\.	��XJnçmǃ#��Ӡ�ρ.����M"���$k�����D�����6+G�2֒�{��(�_t�8r�v{�f�ЋF���{�KY�J'��q��M\$�/n�/�������r��Pm\�/ni@<D+,S�s�<�f�������燠5T�W���Փ�b��zP|h�+�&.
��kbP���1��#�F_�(����I)��Ϸ�jnt��EV�O�+��.���QyW�{R��Ef�w��~u��Y�����(���΀���.�w�^4q��]�)Hd���G�w���}}�"�����q��k终�:�6��&JD�ˡ �d�$"�I*�j�k4})�'��]a4)����C6Rȹ�S�vo���h&,0�CRL%��vOz0�-k���4"p���:(b3k���}(.4E�OXu����j��$��c0q��Ym־6t~�k6�x������:BA~�Y{P\ۯ��EV���ɷn�LE���>�b�"�Uu��b����PՈX�.��m���3�������Y�p��U���Z�8HdG����?t�K�VM��j��|�j&,�0�x2��hi�F�K�o-6.`�9���%x�s�>��E�����C�+>�G�԰n�z���~ua�c@B|�m�zT��ғ�y��CN;�?ԉΩ�+k������9������d��qѠ�spaR�牉P�I�nF	j;��.�K����,ٌ;.t�����5�&���[	^}8.w?DT�c��L\0�ì�Rl�*'c�Ў� �����o��xG�**.et��?�
�����r������������O�?��?�pt腉RݮT�K��H`8������8��Wm������CDu��RKg���N����?��w�S�{I��q��A��A�fh�/W���E��4%i�Xx�b���K�T��l:m:�)�=�Z�qQ�CôM7������C�g1x-1q��U�Ce�^�G�Ty�*��?�:���kS�ӜZ�&.�ys����|��OW�K}�	�u>-�57���e��	'փ;�Nۏ�Q`� ��υ8�H��+��ֲ� �;��琕���M\�w�am�Ӣ��+Om�~���%g��Z��(�PQ%x��Z�Hp��iɲ���8¶=��E��\N�{J�z�����#;��BԛmW9f"&�?N�֝M\`�K�hQ���_
���y�0qQ�Q/U��3tg&��s.���è�ӎ��6�]#Q|�q4*{9�h&���t�Q�&g�"�.{")z�?Ĉk�|�j��_�Ə.��}+E�+��߽�𖲿�����D��;.
��R����@=NW�S��CL\$`֥�ZS�{XJ��G�=�z�@���Ij�-ѐ��G_�Hж�SY��1Lxo�s���(P"�4�{a7����CD^`�˦�	����5����k��=�qy~mm?Xuk��&:q����酋��z'	w�
������-��sM��؛�q�AĴƐ�
.;.���O6a�����o��cO\$%��z?��bɳ �"G���H�X�|��X��
���{l�nN�L�|N{=��1�Kz�&.\���ǳcQ���D�M\����.�rՅ(��&)��Щ�����w>�A���l�y�*2����/�G�cbl���:ঢ়б�?��!��i��۸h��h���i�H�,�I'��Ի5�p� qێ1��M�T��!f	.�$�EH��)�ƈJ?\����R�h�Auӈ!{�[���b⢑�ؽ�ő
�v1�8G/s�8F	�����tB�����)�6o����B�폹�#���?�ƽ����(PV�~���O�:�hxF6�CE�?i�@1�gd���~2���529�x�e��V,�s���wؕ�,6.h�]o���PS����p��q�G�퇺!9+@    ��0u)��(��z�_R4�h�&�	U)�Q�x9͝r�g1��?�C�Z�u�F��㙨M�Ĵ$�FLK�w{K�Nļ��oi�o���Q��~ΣL��{p��V\�t��v͖��FS���P��?e2�b\T��/�.�'M'��Q)�YO4�qy�u�<,PL\yK� E4,��1c��a�b{�$\�/��L��YYʊ!�rw*���9'B�(�𪥚�H�L�lS���P��ύ�1���!�C8�E5�	��r�ߓz��xֳU��:��~���O\`�P? ���u��Җb_;�HP:�ף^Q�)��A��0>G��K^�F�N��6��"Mk�`��ej��F<+��
��E�Kl�3;�h��y���|�n�"�W�$�=	`Յl�%�j����.xI^��}�!�/��"N�0�n��E�����e̐jߏ�9��S0q��.RK`\J�**.�﹬h^��.xKa�'��P�=�x'��jk�@ᢁ���gN�H�\�k���$�4(1(ăF;�&v��%�7,��5BQ��ӗ��6Ձ���E"�Rأ8��d��Oal��ӂ���Ӻ+�����I���ӳ�}�:�)\�X�=P�\���nw�kgG	<@؃8�"?%�Q�[*!�H�3lu��`��)�J�K���KG��7�)=/E=���ǜ;ݞ��,X� �*j�H~�";�U��	|�x�2g{e���S�\��,�P<�s�_]W�C}����aݥ�����/�
nﰣ�E7��yĀNN��t���-b�t.+<��W=%��C�'����?WoEKx�ı88��8�!��\��k&ꋠ�M\� ��
5Ds�c*J(�WMZb�"����c2���������������������)e�����.Jx����)��m�}R+'GV<Ǳ�VNV� ߧ��S暉?
��i\8T���m�g'.X���V��7iX�������\M\�qsʊ:.���[[�&.Ը9�Q�H�y3��<U���ynv{8��w�>�|.W~?C��_��@�t��h���;ŏj0�l�" >Vj�xI#�/\��G��(�>M.����,i����t��RvM�'_���w!�/Y��V1�+��3:���Ь�oWS]���3�G�a��a�|��Kk}�\��>�j	�pf��{����n�
t�[ι�:Q�˹,�8/�TE/�����7��1x.�vZ"�_c&{�tfu�`��^ws�������#��w�����@��Y7)�|�_�0�����L\��A=	��j,i����@���G���);{+��_�<�V���@�����$3�&��jn�1�;.
T��]�f�K~
/�+�f�e���O�}��c�%�G
��E�K����YϠ������(�?��%�����U�/<p]�}��*��xȘ�\.��KN4x�?OM����
��6a�����
T����W�u=E��T���S[�J�/��5_���� 㚲͸g?c]������Ot��V���	����GY�io�\�<5��n5ԙ��֦���\�O��tQ�WD�-X����(�T��q���t�l9D��h��~g����ӎ�{���s���qѝ��ہ���8b�����3��iC�����&�����m���>qy'��.������ƣS�r�Ŏ���	�-��	(�7\�����/�CoS�{�@e"/���
�o���S�¸�N��-5��'��\m�!)ce)�6�ޕ��?��T��7��B�s��e-���2�'���L[�w���މ�0��R�s*іb��$��@+�Z#�)��֖D��
�.G�g}�w	����vn���|R��tT���߲	qd����0Z�!�/������������$ٝ�C��~�y8�]w2�6ߡA'E�h�zƗ�C���ݏ��_��'./�FXy���j��忿�(��uv􆅾���EO� h&��"���5�	H}\�/d�S�W~1��o��>�|�萸�C�&.o�42�c�����w&��3Q���� ֖��
o����jL6qyQt��!�&3ۖ���q̠c1q���3��C(	s�Ov��QOK�����M�{Y�٭э��.#��_s�A�����^IyR#/��;�a0tt�x/�����o�g���?:�����7���?�#��+��;�y;̯Z6�a<L�K!D_M\$���l@[��y�C��U��Z�!]�dWMg��FΘX����/a�O��4��qbV����I>$���@d�����L\p��G
C���uc�JTA���⫶C�w��c�Vh��Y���v=w��͜�q���ߩc
	���w	�ׇ����]���6��B��i�>{����U-X��h�a�kVf�pY���p+.h#}����T��sEɇ���-WvZa⢀F�Ӧr<��o�:�����~�� >qχG�����$,��ś��nh���
�۫_L8S��#��E7��O��;���\+'߾6�+\$Ўz;|�mߟ#!>�L��@����H4�K�5؝M�}�o���/g�wW�E;�)�:��$N\~2�Nw��Q�J~��v�v��}�VL�ָSn�X-N~�7ܪ���3�?���t�2�:��0�\y���J&.��)�>V3����g�W�ם�H���s\u��0p\Pa�ۼ�BX|Njm\4!����l�BX~dJ��Yøl��������6ܒ�G�Oڏ����sy凉�q�
A7�fR�����i>�F*e�oy�b�h�~�[j�m��`��M�B��Y|��;� �8o��I�手Zs����y��C汻(�1q!�Si��}#ok5�����0�:���u#���~��M\aA����S��]W��p��ąm7��0G�&�\��*�Zq!DS3�=�qy�{^�����eR�e�hBϞW�ą�š*\+�Yq�~WBW�|4qQ@��w��t�W1Lޛ�H�]�}������=VOk���W<l�%}�:���R�n� ��N���n��L�w��.��pQ@����t�>���G�u�gX`�K"��E
�r^;O��?f���В�Lo��q��pU�T�͊�lj+���@�\�Mر�&�HdX��|�RlŨ/-T�z�7	�EvO۱��8��(r�SCڊ� �:n�qEsk��y�P�&!�H���i-�O�=(� �I�����:�k�È5_�w�(:�L�Q+.
�;�Q+���#ڨh��.��p������R����34ʥz��Jq�C��c{@��H|�Es	mICߘWP�	+.
}�}�H����4��=��	|�|HzK�|��K
���=YqQ �\�7����;v��z�����&:��
K�TxO�nr�v�yS���d2�䂉��nKc���P���	��EVw���ڙ��k��z3q� �pƲ$�B��,�#"�bs��ݒ�"��)f*�u5�]�
� M�._��� �>�J5U�H�z�ǧ�m�sD�R�{7�G���E=��N1�(��Ev}H�+���K!u���-X�ɑߝ����v:ʊz��@q��3|ԍT����&�E�8�H���"eT�'3�����dZ�,�.�겅�f���Kp`��K���(���:e�to�+T���+�W�"��˔QIo��D��~ٟAp�Y�c��˹�4)����__�H���:eK���0�̻4�;�\�B�Ym���
��D������Ef��)�<2H��8�M?��EVw�S�����(.:^כ�$:S~_O	�3>M\|rO���ࢁ��P
��|=D���-����d&xg�nqx�`T�/󎳤�
Xd����T��j���`
�^F[r=4.
0�C�2L+-�L�ÔR������T�,���ć�`� ����L�s��:Q��3yxф*Qi�ή�v3і�˧f�"�������՘"�u
W�
�CCI���V9��k�Jvm|���)/�L�L�i�ƒ�2C(����T��n|-$k\`����R� Ǡ��K�A�"�����@+v��M�(�    p�.ָH��8���}E��� ��~9�E&."�9�����S57	:<��~ظH��8�(K��'_�b	�7��'.�;N9'���� �'�%ȡq@ױ(��=~t��>[�j�O���ݵ�����D��5Fز��q�@��N��W�]�SHݫgXq�e��	O�8��a������qQ�e7��,��~�[��J�qQ�a�C���Ynkp�M�G����,m�����^���<q�Mo�u��7�'�@%�˫���EF�T%[y��ԃ�\<�n�qQ�M蓼��fqכ*�7�~Q	Xu���׍�O`ϯ�.�?��C�xң,;��"*��WlI�"#�O�H�?bK�*q��Zb�"3Q��;]4�(�Z1q!��v)�T�oL��ٺ�a��S3��M&��+^�W��G�U/�.u��:��/�0��{�`�+?��W���.+��)Wk�ą���R��&J�v�n��V�`�B�/��QjӢ���'�s9�X��YmD�J���9��u)`Kӡ,hw>�]��ش�M\� ��?s�5��BqBo⢀6�'`A�幜$��晛��"�Vr�4���u^��������q+���K1|��<��MApQ@�����>#� �u{�&.0�C�4��VR=1e.���=5��V<�<�W��M����,���n�����0�� Q���&.
0�%1i��ysI���bJ��h�D�Q{mԔ��D��~#�ej\�a�^;��{W�� :��@ylո(�����+[��7S��g��(�������ʛ	'7�Q\�*i\$`�3ي���EݘyY�zB�(�FU�s��Q��*$���򻈥�w1:c������1�w���+W�}Q7�����.�0֙{E��q�7f^Ni,t0�Q�l}~�F�,Ua�}��ظH�:O�����	�:�"������&�>C�.�*�ALM�u�,��Υ��R�v�<��SS��&.h$�Mg��uc�����4.�h$A�>R��ne7�r�a4G�wn�.Є��t�-;zW0ayX{t⚍��/���x�y��]��%5�}�rO��z~\����-^�i\a�Kb�,f�j�4"^;�Z�&.0��إ2������{��_L\���Į9s��׫7�0���o��5��H��ܙ]�DNٞ3*������$2�I<쭠�?%hG[l����H���}o|;�����\=ڸH�������T�{��l\$�-l�]\��:�ȇ���z�f�@��Nu�4��.*��o:��`���v�������EG���|ifd2���[A�=�
J��l}~��ϗߧp��v���L�;&
~�6S����{�rW`O�.
B�7N���!6���y)���P�?bWU���"Uy1~�ʀ��"�k
^�i*z�T����"��E�<�ù�����Tݐ<�WZ�ANa�uh*����7W�{YX׸h���21e
u�#�I���M+L\`�#����1�����:��E���6K�Ӊ�_OA!���3.
��Ϩa*���1Mm�z�~����z?��fr�M�g��&4.�묓M��i�b�̻��G�¶�2J�+��=� �\֒��������>l��#�vJ5}�k(\`��0h��.|�h�g褬���E ����7R�o�JQ��´�E f]��c��^?�3��S%U���A6:�����9��&�U���� lz$������yL�Mŧ��M�E &=���q4B�*2�(�;].k���L�F�@5�>�!�S�_G�h\4`�#�����:�xW�rW���7Xt9������Sh�v�z-1qрA�C�;���Լ�,�׾&��LzI � ���hǦ�9I��KG	�V�e����Ø܃�� ���F]|1��}�7፿�.������}����֟�q�U/	d3�⿜��篆�6���z$��6g;�r0�:V��?�����_�#���_�TX�!{,��d���TT��I�q	����c��b-?0ӈpy_M\`χ�1tJ�Z�wJOV�A���y9{��	V�����FR�`�-�ΝL���T{�¢pQ�1/y]˙q�_!��X_l\`�M�о�bLT�.|��y� cn:��{<s&:��8�^�Չ���mc4>rJv�ʧ��r�d�" kn�]���cBFh�%����m�o��`omA!��d���J0qQ���}�{�_�Q� 9�j��� {[����*�@�*ʍYq���~赳U�׏ӊx�L���(��N�Vh_�g &�N��� �(��|+��z�]1��
E�ۋy� �[�fȖ�	ag��j� ��ӭ�ۘ��O�RZ��Wi���{�V�w�}!�b"������V
	��}��skV[e"�IVmɳ��#�a�]t��`�58&�4�� ��E=r�V���D3w�.t��h�7(\4`�K�9Ϧ;!dP�Ӛ��p��Q��#�>/0l��O���?����P:Cʌ�*����D�Uwr�K�O$(	�mr
��nE�uG<��u׭����KU�y"q0����Zcܾ��E���PjM���]烳1-X�����=�V�rgēi�0�w6����~u�x���3Gf��+�h���U�Q��69�6}��t��=��E$��;��yK�M�i��u������b6W��]C~�+�C�"�9^}6W;�>��j�����E 6}H��Xj��s�������E6�O�l�'a�L�?��L]� ���47��1SD|,HI�#.0i^�lm%����Vt��EF�O��E�1L�gk�ϧ�G!ª�q�*{1�|$�k=S� ������G�͠*T-%���l��>z����ɪ?��EF���Xͽ��*p������:��+��v�A�Ϧ�b�"�^NƜ�1��oW����U#4.
��0G�q,�Ђ�@=�z��W	�u��4�����)r���7qQ�]��l�*,t3��v=AG���>%�5���(�Λ��՜7�?��Þ�zuV��`�|��� �(��OGb�d�4�(9��8۸��u�|HvY��+��\W\4`ӇB^1�R�v�:KM���� ,:,:&�����iCnZ�
��<̒��}��S4ɴ�Aи(��O�aړo}��52����E}:�e��f&�U�oq�)&.
��[��Vm��k�TB5��(���pL�R�8�T�K���]�\��U��.T+v2�
M���Xu<X�sv���۪���p��]��H휵�nj�u��p�Q�m���p(�ƻ��E F�6���?vރ��!e{��?e=L:��.��Q��S����D��L���EU�>�Τn=K� �N��#�J?%��0�f�B[N���*�}��@w(��(���6>��ޑ�]"��]��cN�#z]2����O���EƜN%G����;����W�0qQ�-�͖A��:�ƹ�ݳV��(����u�y����~'A��M\`�y�f��nD���7�\^��+.0�|0�Tq�4ؿԸH���^G�>�t����A��~�\�f��&��貍��:oFM�`�3��q�~I?L�\,~�o1pj�R�:������:�x�`J�#L\`��0:å�&̔�S[�&.
0�|:�"}��cWp~U
ոH���><�Q2w�&v�b�Xt�-݊�����V�d� �.�I�^�{e]+�m!DX�H�z���o�l:�|������0|��q��,{���W�JN�0�A4��J��s�3@b|�����,��p4.��ǻs�f屛�q!�e-Q�D�I�S�bu�������E6����L4+`��,��l�b��ގ���Ӫu��`�f�wY'<�+/\��W�"���Cpw-|4X_����z�=:Mֿh)�_-ڸ(����.*��mӃ);��E�4.
0�z(�S쳒��N5�j�n��,�3���v��깘�}��P��͂E v}��]M�]�7O���/Ճ4.��z�՜K�⬃j�����G�ê�]�Eo�k��t�P��� �  ����y��`J�2�L� �ގ��O]�5G���.\�CL\$`և�]��bL�n��S6qQ�Y�=��d��Dp+�$�~I=l�t�[��T���ݽ).0��ݭc������o�j�`�E
v��֛̄�<���	���`Wj�a�
���b���>��
���&P��s��2��%��Io���sHkT�+�\8�=uXۡ�Vs�+!�Qo�犉?��C90|~���M�8�ki��ٮ�_����=�Rp��������]@pQ�1��u54Q�~#�;����b3qQ�=/�c�����[�5�Y>��h��G���)zf�ՠJ���ǘ�H���n������٥t���&.
0�^�,��.W�5؜�����EF�w����s7�:u���W���?&ݷlL�^�]`��������z{����q�嵮�H���1:�f�뻹8&YU�������:�?��C�eU_M\ү�{��Ip�j���N�����n�k�J�jL�g�9�4q(��tĻQ����se�t[����_s����aW�<V����E���"����=i�[
&.�����ޣ�e�g��<t���~�p�_IM�7�N��M�{+.���˦�w����0J�q��F��k�~����9���ղ9^��w���`�{+z���]���L����.
��BF���Y�j�g,l��,�;X��5wE�x /+�	ش?e�PjŇ���^9X��a��������5�dP ��EvM9�ϋ�	�&F���k���V�6.
0�%�ln'���L�ħ���?�?{I �$i؅4\��s�L��Ef��	�~�7��D5Ί�*�	�5�X2b�Dh�1%�l�{4<\�]H_���,ݬր��AE��+��q��i���%B�����'��^eY�ӸH����no*b�6#�N����Ӹh���,2�x��+�v(i�)8Z�~�
�6z��)m"�_eR~ci��E���v�)[���Ty�_��i\`�!�TH�����0i,�����`��h7��]���Ks��	� X��n/�S1�;Tr�Uu�q�@
�i�V_{�7�@5����E�Άm�T�+�4�M\$`�w*�j���L�����I�`�ˎ�e����oO�x��&�i\`�q�kz�n��\�¸�Z�(������->����U��Ǟ�(���Ѭ��ƮG: ��Efw�&3"���9^M�+�Hd�u<�u��:�dP7:�n�"�;�l�֡�w�s�`y
J.q�&.ན�Ts���>�"�k�$&.0���6�g�8��@8�A?��E��ӆ[��v	f�����������E�����Y�&p�Az��%�� ,��=�[�����칫6~�u:�u��C<7L�M\$`�w^���H��=�7U��ƪ_q��e�C(<����@�=w�-�?�����*���m�B�4�,x�۹�\���~�J���p�׷�E���t8>���0���4��{�E 6�;I�s5ٽ�V|�eЏ0qQ�Io�N����XG�z�6�n
��
�N*T"� u��0��ű���J�V�Py!������L��꣛�.m+��uF]��U�Ȑ���F����1ّ���Ґ0oo���F�5�x���t>@������_����/ .�����?����p�����;�?<t����?��������      �   �  x���;o7�z�)R&�ʜ��v������R K�%�O�������@r�hJ�������������XcE�l���m^^�_68�Af��9�L����o�?��\1`ʚ���f�Y�1#쭆tC4G��9����1��jv�S����{�����n�}��޸4Q�I/@�D����&ԙ������ǂn4/#����Ye�Z&
=&�*E'�{����,��*�"ƴ�bb�;̘(q"굚Y(���G�Ԇk�kԟ1�k���i<�i�S�8J7�,��;�P%�A�CJ	jNm�i��_�V;-�YeI��X9Mȴ����Q�������*RR���v���r���oG��)[-$���k��U�NE�G�1��ښ�Z��5	���E[�G��=䨭����ύV;�P�ka�V��Viu�6-���Mg���_�o�ۧ������Au@���,`�5(� �]�[]dl��܋��_� C�o�G�	��6�:`� H��&Bl5&�6:P%Ū��%��̛�$RQK0�tu_��WH����42��UL���;��h\�88m(8�^�d���,.I�7�=�nx"Crx���h�m6�+2S�2���������i��	�ÉfO�2#�S���ϲUM�?gJ�A��Uf{L�d�$��F�g��Dyi��G� I���t7�Z����K�����Y�o�!	β����)�k�0�����nv���j�N�����@ +����=�KǴ~�*�� 1��Z<��#E֛�U4�p̳glЙ������`v��TI��b=h�"�������P�kZ��6��Z�5+���S���W��.���C�8�3�e��p�`q���a�� �3���Q�:��V ��g�Vl�|n�������B�@gNΊ�a�j`u�%@E�@�����y�`�6Ǔ۵l��S*ϱ���Ps#r�R�p.57'm���4v_U'���5�j;hr�`Y�5�4NZ�i��)���7�/���Q�n,yy��ij~�Z��"��<{��;��������������1��c��
�K-��n{�FYa�0pj�+�F��mFZ���ai*����H)�K;�;���ݝ�W3��@{9�j���$'й&j��['й&�"��[���r�	�qPĹw���:����2���뢅&"ɢ)-|��}}��c����ٿV4�nID1PQ]��ݑj	D_���mw�%��t�[���~��w�wO����o�I�n�����t� �      �      x���Y�$;�D���n���!�+����f���"�(�ǁ{8M)QT�#ʟ��'̿�oH?1�Hx��?������O�oF��'��X�!���0��ϛ���S$~��TzQ�'䟔i�Ke���r�	�P��(�{�o�o�T�_�*%�J�ϊ�YM�j��S�##��ol�*J��#�	����?�ꆒ:�S��,1^�4�1�U�Z"�5����SC�RE�h��&����Ƥ�J�P"S�g�Rj��_T�)�'�g�P[D*���#}�k(u�^`�<[��·qe5j��4���ը���<m���#�+vV�������?a<%�7¨�E����AǲިF��Eu5?�-J�����l���k���+'C����kլ���PR~R�M���E��V���^��p��+WC�MuCj�|��Q%������Y�+������**vO��5��pP��xQ���A5-��n��!�!�P�g?��0/���A��%J��R��K�>�J��e����C���w��A�u���b�R�x�j��x�T�R_T�)Ӱ�i�;�UU�N�B�Yj����d���T7��&�������%$�(�]��hߢR�P1�k��,m��5�9����]M����v/�Eu펓�w�U�ZU��t�*O^
5���!Z�P�vz���gݨ�C���j�gO����_)ؾY��L;ҷ�u��J���P��Pe���R��0T?�=aM0��Rj�,%:������J�}�����1S������Sj��,5��ݾ��P��)��Ѣ#�����X��Љ�N�^�E�9�W��ת��Q1�`��f�@�kȌA��Z���ɚ�ԇ��h����ʰ��R� Ss�V��?�>��E��bE?����R��ꜚ�V�gǼ�M�b��S{�h�9
�9���0�GK������Px���{ӱ`�m��۴�b1�J�p �~�5��}� W�U���v��i�Y,aV�+R��B��-���(�KaR�q�=*B�LX�AA�KQ����d1uX戶~nE��q��#n5��b�����#�n5��nF"}i�Ը�j0��T4��4��V��ù^OCl��֝�gR�l����F9_�vT��o��!b��hc��#L�<��R8��e���4����-I�ˎ�n����2%����mT�Uu������F3����݊���_XҰq�y�zQԼcl6����\hWON]c5���� :d�� �L�i������D�s[�B�����ƵyEұ���?��*����������Q�lN%��W���p������}�r�k\K:#��Ćψ�rhQaGޫ�׆k��=�5����7'���X��F��7ݏ�rK�֣���yXp��z��%��^���rc�>8�1���5���j�yP#vˉ��!-u���8,�t���w�)XN]�)�j}�KZ�pQ��#+�r�/)��΁v��ߋpj���5���)�jVz�0N�a��7=�e��]'��K��t�q,�|8�f/��=���7t�{^���X�!����G8��X�I�����,��q,Ȥ�ݴsZk�Nn<�d��io6�|�����r����*��V���{���٪1g4}�2ʀي�N[y��x�7��#�X�u�1r3�.�i�[���bMG�~^���[��������X�6���Z�r{tnP�1V9���=5����%Nb��\�-/�s�u�|�u�����r���x�����z���`�s��|S=�<�+�;��/�َ�G��2���/$.��q9�e���s��1���%�w;��#�%�����W�%Y��J�!�gm�-��?����-WץX�cޏ��E���)i[V��#Ɯ�|��\/�pY���oI\��n�92ϑ%��<�!o5t=Q�����X��tFH��&�?�5ZN֜��N�-&XX9����:����w����k85���zP��UuG�n,��c�u��im-����n�-�����o>�f9����2��S��iqscNG�ٖ�ސA�hoq�~FЮ��E[4\���r�5[��h��qP�e�5,k�'a!�b9u\m��p+�P��{�:R�m�#�3���kz�6��U��,9�����T �V�n�=�#��g`n��S���d��K�X�<��ӄ(,�8��9��v������e_�*	qX<C���䛭���19��}���Q���!�g�M��sǞ`�u�/�r��@�^-W���� ���r�e9I G�����9�>,7tH�#�@��#}}�XB�-����=V1��r�[���Q���+��B��-���m'�a簚%8�m|�;�V��%u}w�
-��l:��Z�B�a5��H�3R�Ű��EɶŰf�5���O�S�bp���.��8+�n����D\��5�N��y��#.N��yz#:�� &!.N�m�}H�=a5�W�%�^��aW=4�U]�h{�B`�B7�n��'����Y�r}��^m�)����=!0N1.m��,w�q��rU��^H�S̆�^��y�S,��r[;r�N���Ng��ef������Z_��p�#�Z�I�S��D��j�yP#�[AG���ö
�h���n-�jt�u,j��<�17'6��y�S
�����┢���=�f��)%��;-aqJ�p�.��G*�ú��CH�Y'b9�["㔬sLg}��qJV���cQ0!2N�V{�QwkFh�Ұvx�NR�9XLtU8��<c[)�h9�/y�t3"蔓�v���A'����g3H�-r�b9�Iڿrd�\Q?m�90�Z�j�������Z9��A�l՘c՜+��u#[1R����2��R�jd�{�"#�NŪ�	A�R3��T�Y�$f���5�UC;�� -�բd���av*V��u��� F�b�V�ψ�S�Z>��c��B�K�ӷM�Eyi��4�N�4�e'	��z�X�\F��$Z��{ ʈ��$�iܩ��S�$[N�+;A��qR��E����s��!"*�]���_j����@^��ሳӹ��>닪n\r0��\}h߈hN�a���t�pڪ�Ķ|�5Q��A�s��}B�9�o�E�@�����u��_�}g��[�;���#�r`Mk�9w<���~�zF����vZ`?G��i��t����w�О�n�Y'�5�j6�pqԣN'�1������Q�w{.�~�ds���Q�n��0!�v ���Q�a�����¢�ƍ�-X
ᮬ<�,���A�7Gz�g�;�cKK����56K�{�Ɩ�n��8�|,+dxޕCd�ڻ-7��B|,�qW#}�1�7��\3w�0ҷj9����{���ƻ%��H�Y;v�R�;G5����ƕc ݆�fϐ��d��(ǝc�t0s�e;�H��pУG�e�5��z�d8�MoO�39$=���r�1ۃ@���c ݋�4�82�3%=��鮝Δ�W��{�RD&9=a[��zw�֫����ɗ�����7�4�ײG�ޝ���尠��O?h�;��<^��~��o?m�5;8�1��:"�u�"3��p�(�30�:8̻#[N�Y�%`ڽc�uG���^5{�,���1\j܋������0�j9����w4�edh�L��;z��k�!�����35=����J�w�>B�\�Ի�U��w+�y�#٨Ă�ݹi�?�j�!	�x�3(Q���]��3B�o�r�Q��ܿK����*)�ywg�%�����J�0���c8��V�:_i��Z�*	^�W-��W���.�z��i��.H��w�h�n9,��їL��9���K8�es8|��4"��<8�`�#���+<���ǹNn �k��=�O��d8]�ױta��A��&A���[�����X�k��[��G�zG|����Z��]�f�q0G5�����j�j\9]Y������;[���xB�1G�u�_�9@�CZE��6V�6MR�����Om/�"#>>a�d�^�ʆ�-��:g��ʖw�������s�lzwMo�,��}UD ������ʗ    K:#L��&� ��A���8=���uz�  tp��ګ�rY7��� l��+���9�,��w�h?1\�I۵�[�w�h�j8Q/�Ȑ.���r�rz�{$t�!����90���g��܇�)���`Y3r���Щŝ�9XNt�g�w�Z�h����?R\19'�i'z�v��y8h���z�:(Q�y8���-��p�<m���j����<�Ɲ��p9!ǈ6(ǍD97�}��V^� ��pԣ[�lkA��<���V« ��pH+�rz�؟� �����+�pE�^�m����(�O��P��*A���Ey�e�x�q�|�~Z�b8�%��LF~w�J��񍕹&�J�9*QWtei�+�ŝ������9���#�j�9��-�<�5iH�W�Z�i5��Ķ9�q砆�%l��J
r�=Ԑh��lו'	j88�!�pz@p��k�F���᠆d��8���-��zȫ�����گ�w�j�ڼ�#��ą�����p�{��T�+�Ɲ��r���3
ŸbԢ[9�m-H�w_[��
���
�}I�oc2���"��;�B,�rY�{��Ƥ�C˫�pܼ��ؚ�ph{����'�8��UM<�(��8;R7G9���b���+EP)��Q�j9�`��܀T�q�����~��n�z�9��_2��V��>�J=�����
�v/����A�W��*+��k�pУE�鈫'��Ԡ���-�8=t����i6���G˖�R����j��A�V���wy�=���X<�q��	w�q�G5��Wj��j�z�9��n��ɴ��c�ҩǝ��v���N�S�+���ܣ���=�|�����w�B���kA������{{0\�ʽ�.��������)+�c��sh=N�(ȓV�ueD��ǻ�w�o	�_��R�z�9�!��(���}e@yǨF5X�W��񤃣�ޭt���w����77}�Wa�����z#XNtQ}goW���r����TF��y$��V_�p�.������Ȗ�\���ԛ�(��A�Q�Q i�������u.�2tpԣNP�pG�q����Q\�Y�|�vf��G�*���zS:8�1�E��I+)�2tp�G	�p��3��A���!��xh(��Y_��d8��L��
���C��p�{ԏ8G)��BA���p��]f�_v.��x�֠��/��p�%�*v)=\�� ������k�"wn��WGLKh/��HG�\ċ�\�� �H��.�>m�(Ta�s��A��p�W8���]�M��:_|�Kb�\����Y���E���R@2���Nў6+Kܹ������5e]�_�J*v6܌��;�$f�U�/���"|�p@ �X��o���U�W��8�8@ Q����LtE ��8��A얖�h���v�S�
A�v��� � ٝ�n'Z9IӨ���^�ӝ�t�;���f8-ب�e�-`�����wˡ�uX�Ju�߹O?����gf���ɮX��x�Z`?v���g
8͏�G�WC���؏ ��k!�c_%�@-�;8�c�~|&e��W�,�a/с�_9��,g�|j�i�J-���ű;@xg��|ʁM�z-�7��>���Z���� (	��/�6�͂(`"m��`7 O+����J�4ǳ�mW`F(�ᴇ��/LP�~`����T�v�@��������{3�V�ǜ�˺�9xd9N����j�#K��c�.1АYi>C7�u�^��bCqb���X�bȫ,�X��:�ِX��~Ѣi��]����~��7UN������Tqc����[3W��`����ٵ�|φ�ʒ��"ΐ�uΣ���FH]Nt�������XKTM8�;��B{@U%�����`�r�0��l��˼}��6�*�ݦ��J�
���J���t��T�"�_�s
��>�ƈA�����;5�B�i�n����Ɔ!��V�_m�W�m�Z�wl%.�9��+�>{�7|Ϡ����C���h!1�}vp�����3�3�杣�|n�ca�=�L�ϻ�v`�Pj$\w��L� �Ze9���=�kS�C�V516=��
���vZ��2��)(�0�Z-�4x�cÞ���an���Icz��O�7~UVs���	m�j9A�}�)�L08ˡ:Z_i�m��1���OoĘɱ�.��L��r(��,<�4���/Ƌ����ebp��$$r(�WNj��o��G�4ի���99���c�f����#���ç����篟�p[JĘ����?���+8v���u��olz1�c�MZJ��PĪ�q�����az��3�$��/]��꣣N ���/F.�����"P����������q��/1#C��kr1��K[b�����Sf[J��f�W��UN���~+���h�QfI���{M��n����^y}�u�����U%�����Cd��0(�i;�{��<u�{�]��	�O�����;j��)�u���_���Z͢5%2�0Nd90�s�Y��X�v9�<]U1\�q+��g��w�:�P�Cm���u>���U?��Z�peF�}Ա��ӗU��Fu�< \Ej���v��^��� ��r+��6~�D��p��4��ˡ�T1���kTV��G��cHڳo��pGuw������v�	���!��C}����Q ���fi�p��3[�Zi�^��`����ǵ��e�i/��^�E��$���!vp�_{�޿�Ż�n8���h�b9���������ib8��[1%}9�jv������u�0�v��99g��*���2�z�w�zt��~Ʊ΂�F=���+����q�Ǚ��>+^3�Hi�z88�qfp�K(@��E`8=��֝\�sQ��WBb�v��g~���ߦ~�#�8>��ƙE�7@��AG5�rZ��Ia[�j�9�Q�pi%��N1nؠ�`�VY�}P�;�_w�3����#{��>ȕ���!��+�c�1Gu���oFܵppP�̷��Z�u-j���p��m�@���h�+�m��n��{�����m��`�!����7��^����~�r8et\�i�;G�U���MĒ�����\���嘿5F�]1����q��.�8oŻsTcX�j�[esT���.�W�Y�j(���p�f��Ù����
j88Do����a��owj��y�c�*��<���V��SƳ����́Q1Xf�̼��j�9�Q'(P�����ƕ+T����se�	�P�;G5��"��=��qŨŻ�W,DL�VE�Q(Ɲ�1X��-gs����1��>ا!�i88�l��ʴ�?���;-b6�����3b88���p!{�m1����6�t��r�B9�����(�Rj�P�+W�G3\���ޜ�z�9��-�{�v��Q�ǝ��py�a�qlsI
�CS79R�X���k���J@�維5R����"���*I���1�㶎�P�XE�w���m.I�r�nT�W������6y�u�˸���"yu~[y���#e �M��ʚ�,�{����p���y�8%�e��h�
(����r�u:�m�h���b��#�+7r`Nr���>��8��Жs3\B&Ⱦ�i�F��-7pO����rÕ�BG�5���w�'%N[˲NTy8دˡT�.�>p����~�ݬ8��'��ފ��9دd�13���ȁU͹�U����_8R���X�P]-a���R�j@�_��]��8@��,��\�]�!PH]�5Q�=�N|O��8@*3,(,m}�-Ne ��`���6�q�7l�@�Ql�-�+�x5��aG��(�
�Ov��t��R1-��.ȍs��c1`긽m_"�� ���z�#k&���L� ��@*� �L{���)��r�T�R�n���)�����9�2���ӑ�C�.�l+�A4�GϮिr�Y��2=��#Wr��*�Pb)?i��p��B�cO�`D���-��B�c;��2��<�p��B���{C��	N^�@t�Z����q`8\`���� � ��PHe�?U�a*� �L� E>@�    2�ʼ.���tl�N��8@*3,��=��f&T�B��	C��%�2ʴhAl����	BeZ2`��O��;��r�P�ef=�p8��2ʴb�����;B�HeĀ�'hf�RHe�����1T�R�wW�iG�[�Fe ���`Q�6m���9�2��UZ�uQ��8@�҃y<to�L�x@�ң��}?}�A0���_���.����.v�ـ��)�x5��i�WG���8}C� �(̘2�쁙�d ܫQ�%�5#`H;6�B���-C`G+v�e�I�(c`H+V,^���{@�#XP�,%bd��ˈ�$�z���a��.#Y�ER�BeF� ��F��ʌwG�FOǫ���2b�y��j�a��2Հ��.���12��T�Y�b�����2݂؞�rN��8@*3�w\��f�	R���,�y��68k��hAb	�_���f<1P��ߎ7<�Ι,��^�˒�����wv�K���Q��@v�0����~a�ў8��>\����!����01�~ʢ#N��ŀ	�����'�K�{�*"v�T�Z�v�E�sl���!�}6��x����]���J�~Z����.�j}5] OG+��B�cW�`�]G� t�����%8��9U����⫏��	��niO��I �t���lA]�}M�¯v���b@lN=��WW~�D{�b�Oy�=|"�t�h��P�h��v�[�@*�,��	R�y*�q�T�PC��;>��8@*��
Z�ɯ�l�(̝�.).���� G��.�{�1}̭'����.�vtL�Z�,��1��B�c�ZA,�N���mnĖ.�[�M��u*] �&��h;���8@*S-��h�p3A*� �L3`Ɩ��-a�2��!����He ��Mj�0Ϡ2�i �nyX8A(��̑1�+��c�@ ��̑[@Po�t����2G��0�^����] �9��¤�X��@*#��=i� ���2Ղ������	RHe��09�RHe��6SW2QL�Z�yXPSb�\�'��"o���Y���Ԝ��D���"�^�H1������q�F��䘐�+��-��}_��� �L)čM�������F\���IJT�R�jAԌ<fה���2͂��G�IT�R�n���< �y�$�p�� ���H��(Q�d�ΝH���8�u-4��(��C���w�\H�ֹ��W�@e�n��{5�n���2)���=���)�b< ���=�{:1���T�Z'b�^wO�= ui�Z5OK�2���ԥ��r,Ha �,zng�4N��8@(S�q�so�&����h����S�I`[�B��,���c�<a[�B�j���}����.�T�4n,ǅ�11�����v�%���{@*��]'A�x���= �i�f���T�R�n��������Q�a�
wg�$���`�ٱ����D]۫}�V#6/�pmq��b�oɂ��o�IZ����ڷ�7���.+�Dy9O.����ĂCO��x�3��T�h�Eg~�O?��Ne �i��e���t*� �L� �x���Y�2���.�Y���֩��2g
���I�f��Z���L!(�j(�t��8_��̙B@����C����2g
A�U{���w4�@(s��OeF���F�[] ��ZL>Ne�`T�v]��#�~��>�ʼ���+,7Ga�u�CvǓ��)��R�aA�?�ۇʁ�8@�2��^�w�cf�� ��h��¶挭�:�5@9nw�[�.����:8��u����1���5����-fl}�@��gf AT��x5������(i�}�u�c�����T�Yp���g�[���tF\$��s��R�a�����o�'*� U�vf����1�Mw`O�K�������#��,�$������f<10��i�+q�<��pc�<{W;#�w�TE,�	?O���9SHe�5�x�*�s�2�ʼ���T�<<�\���2݂�I��v.T�R�a@ݨӺZ����8@(��}Dv�@���L��޻�=� �w�P&&=�R�����2�Ny��'�QH�beΝr�ȳ�{�<#�w�TF���0�o�0w���'�	��3W�� ����Jxb=@�� �K� o�<��J] uԽ����+���B�s��`�F֎o�.�����tiR��݌=]�}r���������˹O�z��썎�M]�}r���-�ㆴ������0��w?��Fa ��D��xP��8@*����;�7�r�2�ʼ;���Gk.��8@*3�w���n���8@(��5CG3��WCe�+�O�T�Ym��.��d@����Ʀ��29[p �ro�dl��@(��u�\Lo�88�"�É�����.��T8�y��@] ui��;� �o�[i�e'��.���À����=Q�N��V��
�i�/ָ�v<Ѷn�/��<�"�o�պ5�EB��6�.��l@&���Ml��@4�c�<��O4扸��E-�!$dZB;�;�@��/��k;�$��������T>>-���v�54z��l�M���j���F�X��D�vl�,��a�C�s����§��t��8^;z@���z'�k�Z�f���\ �x��O�<�VPN����P�&�3/�vt���P;����
�vt��c� �=n� ����fVٍ�Ўw���tfl򆸻+���@*3X�Z���q*� �L,���h�(��L�l,o�'v�s�P�&��PϞ��<P��*X�ق����
��y8�R�ApQ>*�ł�`.���5�}�0w�.��Tj�����.���;BE�rܙK�.w�Q�n@������P�q��c{7ۦKۨI�6;z@�q�?%�� �آQY��6�= 6�[K�Ŕe�e+؈v�h�-�s~/=lD�@*SX��r싖Ne �ib@����� ���.�r��F7GY�ܠ*�n���~$��2���*݂�X;G��� ��0 �ァRUz� �F��h�	��K�L�M���V�	� �Э'�Tn�N�`�B��Xx������2�X��F��qp�E'���%���Q�w/����k�%^a(� ��fA]M<jCGa(��J���d����8@���8@��/��.��8@�r�Ч�@Tp.~�wr�] �9��	
/e���@���������[;8�rl�'�mƲ���.��3�vߡ�0���E,�M���ʄ��.Ղ����R�;��K3`A�Ƽ�$SHe��p�S�IHaL���x���C7�7Ga���C0\�Ñ�һ �v�O��JW� �F����Bw�~ ����F��D�Lxb6��,ǭ�Q����'&�,qNm��] �yw���$���PHe���E- ���Be�5d,O�g�D���2��༵�heBa�u�Ӌ����E���.10�jU�]< t�р'T��h!B����{Lĥ3�� Dw��%fx����1��2�XPt!h��R1��Pw?����9���L�ת�U�rui�IC�qt�F] u�LX�;��I�.���1*ǫ�������3�|>Aݙp�P&E\�,GG@�����((T<�1��2��x�X?���B�T�NB8�	b~��Ā)":9\�.��T� �G@�S�;8�L3`�ۓ�tO�p��"�|`����q���y����}�мs������Q�_���+S�_�aŜ,�%y�EG�]��؛ҿ��ڜ�w�c�	q����my��z�����7XpA�
,�)���V���*Z�'������?L4��K��B��a���hnS&��3���Ы��0�//k��f@$�\����ˮ��~8��2<2=���, e   ut��%�ǩ-�2�׏����<�Y��Y-�b>y����Ѳ�����_��xwq'�Tds��%�yy�ĴDI�������h6�I�/P�ؼQ������N�      �   �  x��X�n"I}���z�ՊR�/�V�bJ�`vO��yP����L����c����/�#��'Jp�+��xZ�g����I.M�����q���.���L6��R��ŧ�̸,L(T�EH�$���>�m�A��Ih���6�W� `�
ecrne
'a�^p�[^����u��pL{v��)����n�i�2a
.
er�u
'd�h6zݵ���7�t��!���L[v�z]gWϻ��쏷����e@�C�02�\�p��A6ټ���|!L�E˭�pwư�l+9&:֒�y�!��T�j6X�.J*�~J�ܝηp�:V��~w�������Ű2	c��	��$+�C9�$���0�)��ei����E"n#r�+%S8!�H�yۯ~$H�+�˥
)�P��H�(�υ�)��fֱq5��)tm��Թ�.��2�z6ؽl����>�/z�e�|�Ѫ�*�-�N�p�ھ�^���0�����������B�<��[8
OKA�1�uu]vƧ
�ns�D
'�c���Q�M���K�)�p�H��$A`xl#J4	N8i3�m6�2'.�*r��I�j��rYN�4١�D�y�&�6�6��e�g��dRf�j8�Q���ɍ�)���l��o��6��k=��^0in��MVU	����NZ3��o��Š1:��C
'L#�T�z����J�w*��78Fղ�?%c�%R8���eYu'ɗ�.��)�P,���j�v�/������N{�t9�2-���tq�FVC�*����?��~��b��1Ϲ)���n�N;�rm
I�uΕJ�d$CCn�����h�o'd�J���e&��s�_��_۾�X	��⼭\�Ł�V-��'8�s/�<�K�0�Q#U���q1�ql�2�M?>`2(ԀkɆ�;}y/�C�@�q���@���,��T�x��iFt���1�q�Ui���hBn�2����9�����G�:�.(7�����ʪ�z����Z�R8Yq�˯�a<�b�Z�p�x9�	�J�A�!&�� m�L�Z�{z�����s��޾�v&��_H�>��U�nI����;�����<2�+
(s�!8Ys^����(�¦p�u�����z���k�9�&�b9���eԾm^6o?���dX�n���;���q����w۷��9[�|}[�t���[�!�N�r^�>6J�V�gQO9,=�gs���X����f�N�����!S8a���3�T�s�u
'w��L�:���\��	�.��v[,Tߟ�:�2���s�0a����;B�z:�5�K+I�pr��_.�mlDX�C�)��9��ǈ.xl~����r��&��l��믶x3��zR�g�y<�8a B��Kmz��Ԩ�:A�9y��	j<�L*�W\������}Z�I�Nȍ���f�\}?ˋ��B�?�:?i���f<��ܯ���<����m�v�0N���lz�I�n!��\�p�C;������Lg�iE��e�8I�N([�3v]n��bt	���@o��5k�/=@M�	`�N���n�����o�N�8���%��|
'�j�l���/�t.��`U\��)����E�?�=���ip�2�\�NX�Q����YR8!A2�7V�w��_�~_���~�����c����.����/���Zg{�����cE
'8��Yw�l�l~�8���mrq�N����r8���@���Pk������9�`,�_��;�-�±��m:q0�0��}�6�v�)�c���2~S��[�.��	���e�e8��s�K������n�i�,�Y9ʚ����C��Ӓ��)��҇�d2��M�mk5Y��/<'���	j�؝����*�,8��гg���	O�1�/z��X��㭘j�KS�l�)��_���4+o�C���y��'���/�}�x뼉�T�����9��9�      �      x���=��8r��ӫ����7�!{�hEȐ����Ud_&�P��v3p��I��p�'����O>s�������g���-�h}�������������~+�47�ܾg:���~��!淖������Q�h��V��l�� �'��u<�Q�E<��@{e�(�\����1?�8��oG�3�ګni��1g	���j��}S:V�ub�Pw���[:ھ�:1Pٱa��M�d"�O5��K�s���{$�}jv���TB��S�_I>���:*�o�1�|Q��X%ԉ�>M�����o*Rv���ȟ�ej��Qr$�|�r�%-�Z��:1꧟;F��a�X'F���a$T�<z��xtb�O�F9�egi�N���e�h�*�o�:1���e1tZ#ԉ�>�;l�g��Yu�,�N�A�t�����\�Yp�cu��O���]�J�����(�>�VO�y�g�]�Չ��#U�щ�=ݳ4�iJ=jˡN�(*�/���֓�{a8��Nx U�P�g��R�(p�H;
l���<-�щ��yKY�ڎB#��)p�ӌ��Ԃ�����щ�?uK�ő�u��P�=ʐOm��e�((4ږ2���_:Q@cG�nc�P'
����R�-3�P'��n�]��z�F'
�17��?Rzت���@-�ƹ���1j	u�4Q��q.>�)m���6:Q��s�\t ��0���D���������]]�(���x���9"���ܸ�a��}F21P��qm�h�m��-���:̍g^&	����Y'

͍g����E21P��q,
KP��9���2k�Xy�8�Vg����X�N�0���(?:Q��k�)�n�h-���Z����=-l�B�(���x�Y���~Ǭϲ6N�:GJ#ԉ�
��S�S�q|��D�rn���K�?���!!ƹ�
�q�ڶ}t�,P6��O �?M۲N��������(��DI�l�����=j�%���Jwy�2k����=�jc�H�8�O�҉RA�=�����Չ�@�Ε&�������щ"����!�xJ-ԉ�%�\)�x-c����e�⽋�Y'�QC�(�n��:QI����i�M�@颓����щ�&�])=d���>ѣ�M޻�f�*�x�Nx7m�[eȑ���:Q�ݴ�n�1���Ǣ�N�.Y�N�@Qs�s�E\g����F�<2�
F'
\��w�FIKj>�uZm�_�����$��;*�x�N�%[�^��{Iy�:Q��l�;%�H�1��H&ܒ�s��KF��"��J����YW��yˬ�\���ҥKߚ�
u��q���*�$��6ʣ����O��f�E���2G����щ�~�l|�!$��Ym]��xaܲ1��⟎ꌁs�ƹSǋq���^,�;���,Y��?k
^g�[_s�_���Pg�[�����2���ּ�4	$s������-fʂ�������&K�6��8��-#�8����j�a0�"T�=��ձ�L�U���A�Y�#�E�P~�K�����a�Kzd��<:c`��q�U�Gu��~m��+��h9�����%��&�/�Pg��6.�:�I�X���1�_۸x�Z@�����A�6.����)�P'���6.���O0�����&>�1�ꌁ����(�%ۙ���茁����S��D�{�3.�O��ax]�������%��H%������+��ꌁ����S�w̍fu���}�b��N�\m�1pq߸X�8]A�6��)V��o\,K�2i��댁����Kǣq���:c��q�d"$��d�����o\�$n�[G�u���ûXSz�������5�?:�ꌁ����L�1`�-���a�������^:c���=,�%�����:c���=��b���i�tN����{ť�=�zẒ3�Ø%I"M��C_:c���=��I�X)�Pg<<���nQ��Pg<<7��K�;N���ύ�un�2C�1���دhL���[�3����A��u�@�m���8��&�vyt��3s��r/�f��茁g���U��Һ�茁g����,��5�#��8�J� ����l|�[B<U"�!���5^�ԧ��眡��{�O�W]azr^g��l�:$�e��j�3f}�i?ʢ{dE�+�:aa�s�6:_��{�6:c*0��Z��<��2:c0��E׈$eq�-�:c:0����9��^C�1���T�$h	u�L`6/|��6����m���1x����3�	�P���ji[e�ב��LI�����G�[����`�7C�4�К�Vz�3��27Y"�Ǭ5ԙ���(C��3��7�3�-玢VO�Q~t���%9��ju�>C�)�n�;�L�Ν�љ疲�H:=���X���K�Q9�7:Q9��7�C�wKyt��u�9��Hd�6"��\��]2��y��̀��풵�&1nu���o�}up����̀ߪs��J&Ԙ�Pg
�q5Ni�K�-I�-�)�N��ީ���W
'֙�Լ�$�FV[�3N�uG���X+���Զa���r[��pJ펑���g)��8��E���su��Wֆ�e[>mx�:S�75�ٝ��;^:3:S�75�~teU6ŭHf\�����U�ѧ�<�C�Bm�Q4$�[�����߳�5E��F�3o���,����,�����H�CD&�D23�~�����V��D��L��U��9�]�u�$�+õ����c��:SЯ��R��^{^�4:SЯӶ���
�UB�)�Y��MC�%�+2�u�T�H��/a`ݕ�#]�:m��:S`�6���ҏ\r�3E:���`.��o�Hf���c]�Ƅ9�Pg
�������jp���D�,�.o�qO�2�Fg
L�|�����1C�)���sC�q���B�)��⪡���Δ�:&��0���L��%'��L�J�T��0����f�ڈdb`�t��� �#/�VD;z���PgJ�\���q���ֽ�-OG�љR����/a�v��Z2O��,i�:S�R6��5����l]O�893:S�Rޕ�1�r��6����H&F=���k�7���Hv���PgJVʦ*���yS�T��b�Z�Δ��Me~��*�$qv:�u�t����*�MeS�_����љ2���̯a`�d�����&��kbct��S)���	��m*��o�+ԙ����̯a��cW�%�F����)U)���Fl�*-�uATF�{��y�����:Q01�v�8b~��C�1h�|n*Sue��XgJSʮ2��A�d�)i��Ng�Gg����dU;��:S�Rv��%���me$M4�S.=ԉ2�]�I��N��R�)rrz�(z�k��L�gm��ZZ���8��L��3��^2��Ƈ@g
�;҆��L��)��(���G��a�3�yGѝ�%G23`��{�C�h}�Pg
<7\��t��W�N�	�م��t��׺B�)�]��JK���C�)�]������0o�u���s�kΣ٪��̀��m���@��LA�9�o���Ӛ���vz�5=���ҙ�͝㪞�jþ�Gg
7������N��(��oߦS��+����:S��7�]���x��L�"Ɔ"���g��L����Q�����3E<�E�Y$�/�%Z�)��:wI���Pg
\�҆��;��ʏ���f�N
��Y8mdf���l��G����L�o�w�����Ιj�?9�ؖw�����h-֙�.�8�����
u����;�Z	C��-�љ"��x�]
ς������M���m*��:S(�oSOO�#��L�x��q��_[�Δ����}-�gu��O7~W�,�D:��u��O��-2~���_�%��8�ȀS��R�)�Ӌ{�I������^:S��d�^�"�ȶ��)�n��RZ��H������d�����4��љ�6G��lb��gu���-9J��F�c��L�m[�P��<�23`Z�1M��d9�V$3C�橎Quf�x#�����X7�R)����rTڕju���&�y��=��/�3%�26�����[�3�5�ۻ��G��L�3�5I��t�	Ok�]�)p��/� ;  uuI<^e�����gG��a�Wgkt����n(r�a	e)����L������x�3�5�﫴t���O��DA����.=��Ŷˣ3E.�Z����X9֙"�S�7���gB͛m�Gg
�k��wi���(�M?:S�ݱ��o��ՙ�I�]z�"FN��xwx�MaZ�j�3�5�~��Pg
�;�wuԒ[�u�����E��#�Z�R�(��~��\���L�w���JG�CK�Ff�;�[�6I8�Xg�ܬ�ݢ}4&�k�Pg
�;�[�}X9��L�s��Ww���b��L�s���ڟ<$~���u���v�{�+>����B�)p���^�����O�D��8�N{��Sj>����DA���WK�7 ��L�s����S���+_*�[;��ꮀZ\=~t���vګ�k�$A�M�)r'��q��ch�o�љ��	k�w�~d^�0:S�[;a�v�W��L��:S�[;a��2K@�RG�3���D-��)�Ju��v�x�d�>�����N���4����4�g����L�gO��%��z�:G23�"��Y$�<%@/��:S�"�s�=\6�z�LA���%����=gt��}�kC��G;&��Fg
�Ĥ�n#F�?�2:S�&&?��Y���:S�&&�~��2��b��љ�61�t�]��YʣE�J�ʾK�1��üљ�619軴ފ�r�љ�6I}CAT,'�8�3:S�&&}��m�ŵ�3m�v�E$*W[���LA�$���s�>�:S�&�{�i
��`#3-��s�����ɣ3-��s����M-ԙ��޹M"�1r�E"�읫����E�����9�tݪ��:�W�mt��Mr�Q���Vg
��.^�u�j��F�3mb�	�ĳׅ��PXg
�Ĝq�K/�t�u��M�b��Nz�_�cu��M�����m�{����9�t�V���ɏ���9�t�FT��/۶�N�p�	����X?��ˣ3-R�s��ez'­��I��ի�,:du��M�w�n\m�(<�)h��;u&V��-ԙ�6����M�/#z�3mbW��}�$Ɯ�)?:S�&�;w�=h��z	u��M���ҫ���ju��M����2�0q�3���!�{w���Ҽ�ht��M�I�4�o�r*��LA��,�UZ3��MFg
�Ĝu�J�(�o%x�)h�:��w���C�)hsb*-�t�>�o�h���r�ef�=l�*��m�	�3�a�ZZ�!]��u��=l&bݿ7�$1�C�(��\�҃^I�k�L�љ�v���u�k�|������E��
������:Sв6���bx�t���@��LĺW"0���bt��]m&b�]7H̒C�)h��};�v������LA��|��.�k/�|B�3�ڽs��A�������͊hi��s��Đ��{�^���g>C�)hW�Y�ҒAIt%�י�v����t�����Gg
��fV�t�(�$�D����ͬ\��n��.����ͬ��r&L�j����ͬ��7O0˝��:Sв6�r��p�����ͬ\�u�K��:Sв6����(=�u��D���fV�}��l�,����ٔ(���P_����ٔ����s{��[�)hY���KO�~E޵:Sв&?s������R�)hY���l����i���LA˚�U�ꎍ�,�љ��5��w���.^7?X�)hY���J�jQ:h�fdbH�n�3W�v�L��Hf��dg�pU��W�nu��=��mի�']I�u��W�o�"��"����*���c��y�)h��]{�+.�}5�3-��k�S���ou��E�wmUwʅ���3m��k�8��%n5ԉ";��w�W��e{Vg
�dy�꺢��ӆO�3m��s�fh=�[#�h��}�?Xuʏ��Pg
Zdy�^��WwKyt��E�wn�Ԣ�Δ�wː5+=2QC�)�\ݬ*ks�:S(�=��qh.�ND����Hs�Z��:S�g��魱U.t����Lɠ�w��ƶt���(��|�����<Z�3���߳�7N��B�3�}f��4��|��L��^aޛ2K��Gg
���[��a�|����L�s���6�����}t����{�~�=Yʣ��L�s�f%;|Z$3�M�q�b�Y_�`u���ُg:�*�V����L�s�s���}��:S�\�W��K��W���4:S�\�W�J˛��"z�3�5y����>�o�:S�\�W�~~���vef��&�r.�f�����T�º�hnfu� Z�&�r����|�ՙߚ��U�ꑮR�=:S�[�Sɺ?:�۬��:S�[�S�~�2���s�Pg
|[�o5R��L�R�)�m��͆s�:S���}�AfO}�Pg
|[�o5�Z�+�cu����;WW8�|�I��x�x����t�UB�(��g���z�Q��L�w��n�h�=�:S���;4(��#��x�z��D�';K$3έ޹���Y_#�љ�V�\ݗ&�Gh���L�s�w����9-�Z�)pn�ν~�`uZʣ3έ޹��2r?☡�8�z���������E.��;��U��<�L�s�w��_sT&��ͻVA@���L�k�w�Əz�}$3�m޵S�6�/+9ԙ�6�کG�9��<:S���];uu��z�)pm��Ӂ��u���ͻv��w:�����y��j�D����щ����]��zr�'��:S���"KDr��g	u��s��庩au[+ԙ�u��e����w��t��u��E�*]���Pg
�כ1�C��}��ՙ��~݅�g}[�Rew褽�/������?�����(c[�_��-϶.zC��k��LO�glz�~pt�̔��H����)uK�z�3Ｖ:?O��d�"7b�fE�Y�:>�v�P�� �ra�_��Ouo�W���~v�����r&���C����o��?�U��      �      x��}K�+�r�X��@����Lս��z��� ���$����T�]{��OЉ�#|����!��H�c.��W����ʏ��ԶÃ<�R�3��'�#��Ã�+E�����4_��Q�E���"+���=b,;<�G��,O�5:�RQ�C�g�����Pc��R~��:;��ї2�V�%��OnG�}�����,S��ѻ����֖(ζ����!i����e�j�]-I���#_wxH�HF]�%g\�O����cҵ.K�U9�O�G�8����WEj� "����d��*�S�/Xz�o�) �?2�u�8<d��$��H��،qሂڐ8��$6h��������9{���9�š'�lm���(�Az��E�Ou�+j�ua�C���hLu�t�;<dt���m��n���+_.)�g�P�xT����_����V⏴#��������ˍ��(�o���n8�ٖ�љF��=6���(����\x}�$=?0���e��8M�?8�W_����BQ^J��_���j��r>rL;<�OJ=&i��>I����O����U[w���mֹ����H��m�cG���'I�$���h~@*IҦ�$Ig�t#��r#�m�}��Ŷ5ޓO��AI�����1fX�C��n$�A�=I���A?�������ۺq�3��gu��ɶ����,�&�Os�@���8k8S8�=˅��вx���Ճ[<aX��(*�p��}Q.<���_X*FܑV�g� �A�!]��0\�.x@$�Q��Y��6�������&F�G.���Z��`��_�#�S�ѳ���E�z�9c4a��Y<��.Ji�n�$/8�9�|���GS���x�,8���&L�p�x�+(7�y����l�-0��K>F�O��V��>�g��ˌ���P�W��(�Ƶo���/Z�Q��|a����G��Y,�׺Ս�-bI��+M�C��F�g�q<<�X��ϒe'"�;��0$�M�7�ƀq��X���N�S�%�l��ʣ~l�eJ�$���M��F�~(/x���M�7&ڑR��.��t{�)��G;<4D����6ȷ�<ဵ_�,�N�X0ըo�\q�dgi��ht������EwX��$E�c�=�u��$��Ϻ�?S�ͼ�	��X�����d��J+z{�/ʣ}�gM}:<`����c32�8|q.<�����MጞR��aD|n���-5�
���H���o�:�L�Ytx��>K��s������@_��a-3�#�������T0��<|�.<`��}'?E9�����@G��4�s&�-	��=d��S���V<t���g<���_�RD}Z�L{tj�hȲ���N�I��(�(}׶��#������d���d�,}�OQ�i?GNZsOy�S9���3�H�'c&����i���t��I{�B�gn3�._p���(�*9{�t������Kq�ڬ��o�)��hߊ��>�����ѿ��e�V_�O~��su��p��c����9�(���|6���s*iGo[<p�Iq.��������_�+��w�+�p�AS���i_攍Hf�������O�ɲ��p��G��3��p��������~�7<������}��D;����P����L��x��n8� �t�� �\�4�nq�;"o��h��p�L�}�a~	n�ʰ�p�@��1����}q.<�ۭ�??�8�2=�t��	JL���f^�%o������3�`��`��!	������@���_����H�1���ѳ'�p���7"��#���AM�/�nݤ`Tnqq�`�]����W��T�o����<�������S�[�E��)�
u��[9d�T�<�ģ�"]8�:���T��(���ܥ��#3oߺ����_t�g��U�"�~�u�Q���[�.<0���BT���6_�Mx]s�+�.)�|T��z�I�1�T-�Uͭ�K�=�Z>;����me����Ϛf��e@�o4����e+����P/.�1K`M\=υ�T i�4pm9E��fq�����S�^vx`�=�gA����ͺ��/A�r<4z���$m��<������p�X3�9�r��v8� i�(�4φMɍHZ�H�ŧ;n�F��|$�"�f�X���I�E����ղ�A���q�?� �~�牞���z�o�>\>�G�����\8xx��Gdv��E���R�,&�0��[<�O�"e�����A���|n��3����>�B#s��I�#���Cj����4??�3����� ���}��L��	U(���IsW�g	N�B��������Us_��\yi�������>�G�2��v���Y�'�ư �E,y��}_�Yg��O��Yu�����})���	+;<�x��3OAK�#�`�����N��DQD��wx` IM���f���j���=���g)��@�jt�:�4G�� �ky=�*�`k����"u��>��)�:AMs�d��;4PqӋ������L�p���S�v���O�F����{�MӪm��3��Cj��!��p)ͺX����QWWaq�@�t[��o�,<T����[���+�]����uQg�C��|�4误��2l���|m���F}�go]�{h7�'x
�C�"A(&�Y��Lmx��׋-�8s���,/$�t�C۔��������5�j\�:M��pp�o���⠁��T)Gg���H���J���\�do���6-;4P��kiD�7��9V!$P̐g���5�4�y
Y���AŌ�b�,�~c~��";,�(kQ�gg�-Lx���A��	��H�y�u�����FF�$�{��6�M��a�⠁�}�i�X�\��$��x��/��l���G���A���$q�j�e�Aq����A�җ�&eNs� �KZ��e;d�Nae���C�ï-4��-O爠�����%){�13��F���)ɱ�t���>
��v8hx��ދ)7�s	We����I��Ke$��|��)}��=����uߠ�+��aF��A�Ϥs�^cΤ��lqР!ҹ�=o0D���%v^�������Q�T�0ՙ�ZYY����y�$UCӭy���y�nJ�����SGw�X"���a~A���Y%�6��X�����YMf��9�fʥnq���Sz�����s=�e�p��39�٦eg����P�J�M�5bq�(�<���W`̺+���y�w.z��aV9�4ƺ�O��!��)S*ξ(�%�w8x�7�3S���`l��g�Е��A�6�x?�+��%[�9�`�Zw8�x�.(��XPR���8�U��?0���~#z� �0~,�/X�@񷗳� �６��p���O��>#�gq�c�)q-"��le�k�X��Woz�O���X�2�%d�7wg�M�r�5T�8�й���Yxk��8���1�\8�P����,�f�]���]�X��7<d^�׭�͂��K��!gg�� ����u>�8���IƿcAC���.���+��2�� B�Vȿf���M��}`�0m�"Թl��k��/N��PR���p��VʿfAQK�Ȓ���g4䆦,&#k�9�嬿�j^8hPH(�SA�����=����R�,�f�.˝���y��~n�_��z|ݎ�i]���x̅�����^�̾�C�����V�c��,�u�J4#�{[��Tw8h0�[4u�Ù���ٚ��p�@Ogr�I#�o>oµ��ÌXlz�<g���q��v8h�3�ѬgWN����^�$܌���0�!2S]��y�q�D�+/,�Q�����5C�}ۜg���_`��OͦQ���yT��|/;4�L��s�4�E��ն�ü�УQM�޼��c��y��';.o4\����۵f��:S�-�6�pР��-��67�V|a^0HP�3��.���&I�u��A��b�ɷ��    ����Zΐ�(���V4�yU[/1���J�}�A[v#=Q_%>�����A���������gjw�=��5FzyIќ��P��j�6��Ft��/�朢�A��mY�WO�y+�4/4��X������D�L��2,���Țc{�s�x?sÃб؝����C|a^0HP~L4{�������jͶp��Ye�P�p��b�6A�[s��i!5l��x�̴��&�|4�������?�ym���R^x�6�ɔF�3G�&=r;4�!1����9SiX�-���_K�|��!�B�`���.5$ն��*ͷ�J���k�l�v���wx�Ҳl����Μ�B�9��pФ�r
#�����K~H|{�?�m.�]ݪ�A#��ۦ�Ԛ�%�>v��,��=oT�u�r�`���q��ɒ��|ȤZ�x`V\��	����.K�æi����fx���p0A��ƟK$A��nG����$� @Ŗ���MY��A	'{�dI���<��y��-D �d7���?�t�8��$��ɒ%>��,����� �٪˞V��o%�
QP��6^zD��hIt.e�z\�� �vs4$�&�:�%�.�q>����/y�y��8B���u���ho�硄�d8��%�N��i>_[\צJ�u�Q3����C,V�o�ě�Z����<�y�(/���7�r]KS��������Z4���4<)�ix�a˪H����v�n�o��冊�p�@��SsQ�����������`A$��Ѵs��B^8h�aIo�:|�p!��Xǵ��	��.b��zk.�Z|�^x���e����FÇE����N~�별�axƿ����c�~��R,�ͷ̅�^RM79��j�B��ߝ{G�S��3.�Rv8X `��8����U��v8h `1>�������i.4||�}�k��$�|3 �*]x�zB�=�{�:�4l��e�?�7p`,��Dh�s`�ƭ��`���.5������ica=F��c9�_�a։�>�}g�hXףDe�;O����2��B�Z�P�9_�浢|D7�,��Z'�:����b�y����ktki�[󵬣v_�_O\ɺu�4�,{K7��5��WI�{)���m|�oG,��	9W|=�%_}u΃*���p���D1�,*�lH�7ʅ��2���M<5�IU}?_x`v��{��w2� ��#���sp_C2qHv���g��}Լ��H�Ky4g�u"m;<�G��;�M���ʻ��;4�o��5S|n�M��VM+"(�F�"��}>�S���慃��L�̂�0ʬ���	T�Qh+U����0^Z���@����H3xօX+������m�I��3��G_%hq��-�W2ͽ�2�^J9�:y[<0��q��4ӛ����W�eq�@��N�IS�3�yn:_�<8́�.Z�����T|�\x�Rt���G�[�Y<�	0uK�\�y~`^a�5�8�����%jl�1e�Pih�����l'^_�ϼ�W�8h��&k_i�e�y�Qn�|��r��n��"V>.����2n6�H���z� ���丬7]��OΜ���w�-��5�V_.��!��\x��� �f�,��l�s*;<�`�����O#3M���v8h����t3g�x��wx`�K�;)1=��4��i�/��n���/=/�Ju��Ӽ�|���p�@�]�*5z�y����������m���}mq4x�Gz��ix�1áq��AQ��D��Ҥ�D�����A�g�]@,ޜ��G%-�������k귲������U���9���X~����g�eĵJ�o���7��B��XK���Wy�mw���$l��g0�D�r��`����歹OH;<0��q���[Yo����(���fHΓ�|�s}���2�Jc\v}��iH�4/<�o���rZ3���W�8X����`�{s�	+'�ܨ�1L�ԛ�|T�����f����m��6��5���k�fW����n�uw��_�1�q��H|��m��h��A�>�bF�*�i�%S:̌n����kaY��	�"y�.�4�"�/3\���9��A���F�y��5�/ڱ&�0�^W�N���i]٧�M �Fd��k^c�3Q�'�ox�X�F�y�H����$�xm�@}h��l۱2���X�vx�OViz��R��ԍ�|i���f�7�4�8x6����/EOၛ0zmʝ4#{s��#��QR� ��V^��zߗ��M6Vې��|f��Ã2u����@Ns����#P�7��ٖ)�\��c����oj�Q��������iMÊϛϓE�S�	�(��y��xk�}�n�j61Do�K�)�[X<0]�ٺ`�U���Xo4/<�F�fる�1����-�J]x�-|]w�X_)��3q�4�$�lsk�Q>�}h�M�;������)�!��7����5�曘��1��-�����6eN�i���pР��հ�p|�k�+���x��T��ٛ��2ɒv8h�Kb����U�T��T�M��D��#Ęϋ���'84�%�~8wo����A�^���z��4��|E��\x�Rw_�<���%���̼��__Ƨ��"ex��1 �U~c9�r�6_�~�y2��`A�U�8���3���	�V�����T�u�\�U���)�9��qP��N����t�<��L��|_~S��n��!�κ7���̲�aa��a�vX�U�3x�7��t�V;&�3�x�h�;<��.�a��=�ν�uC��A���}P�|��F��A�>R+��޼�3�e�>r͕��6��|�~}���A/�d<ĭ����o=x�A/{�~�6�S��n��CsX.U��[�#+��p��'���+�����WOs�A-�b��l���o���|�H����?3^�r����7ĵX����y�k�pРy��DL�eg-3�:��p�̟�5{��׉��=��nM�i�7�i�cM08<�5j����c>�[���	���Ms���湕tQu��i��6d�S�j�g�U�e&����S�6ll�R�QI���AÌ��p��\� ��셃}T�����{(�M����B���.B�3�qM���A�^��t=3�V�3���Ee�&�^7��$�[s�o��px���j�M����z�T�7����e��~:=�մ�sv�tW�4�\*�-�u�Z<��*��y� -�u}:�4go�%O�;���
v?��}�-Zvt�Q{�l�����s�E��䣶ng����B�	:����Y���z���av0��-�|��^�r8h���n��\�U�u��p���R����2gV�&���3�-�8���yɞ뾺���m����:��Ws�\������#rڋ�ɞ�|E�;E.x(3�]-M3�3�J����AÍ�f+U�9Oo��5r8h�G�miԙ�y�y݇u8h�I�ЬBz�Z��c=w�pа���Iޜ/�m��2s܋�S�Ҝ9#^=j�4�R����o3^h�U����$�Fn�e�J��	��}�4�u�/m����,��p�e�y��;�ef�����V�/�8vx(3�m5�=���p���pа������?��([��aYg�!e���ѷͅ�F%�5����<ن�o��e�ɔEՙ�<���h`V�D�^-�8�s̴��(��y]�Fs��߰)ѪW����y�n]p�`��V��T���*�Jx�D�^�U*�f���<�']J�ꍶ���A��n4�Q�UoRg�)1������%Z��/MN3�;4�ڮ��r�t�ǂ��K��-�K�����Ųl>�&�hf���Q�⠁���'^��ލ����ٶ͊��s���k�:_ �;<���<�͟�z`崖��Ih�!���]�����|0�,��#�/��5β�ubmϻ�ɾ��p�@|�
�h/�`���OKϋ�m������yN�k�9��7�뱦�����CQ�-�8�z!�䇂|e�j9����~+D�Os���⁏��N~������³�� #�me����ޒ�� 9   ��k��fA���sY���)��⯉��?<�PL1C�K����y�Wt���<B�[� 2      �   [   x�m�A
� @���aK��Q6�1(�t��Ő��@LU6f:ּ�䥂�0{�))ʃ\�JCJfj���Ûq8~Ί���f=+-"�3�1�      �   T  x����N�0���S�ٱ�4�!�I�9 7.�h�J]�� �O�����0)�O�}v?�(n��m/�^!+�p|�Z#���Xu]�C�n�]����W�R�2�Ӆ�g�xE XjG���x��/H�� �<CzM�@��];�v;����vs&�4[3kR�K.V�����h�yrw]]���r1j`7��-'D�y���eޤ	J��7ҋu;��x�M,k�����K����㹂@�	�ui5增H�3��Ԭ�Œ�Hw���F(X��z#�J�OM��Tf���N��l^�)���)=��e���Q���^���z�P�]ԣD+þ���x��7-�����      �      x�����-9�%f�}�� ���x<r��mO�F;jAz|1�C���.��:_&�V�����_��������.�q�O��+�/DB��忽��T����o��!�o�X������ߎ������Ԓ�J��������������_�������dB�A�O��oL�HJ����+��?r����#|ڐA�P`���h����T���Đ���A�������o�?��q-h�ҀzP����}��7(dP�1 ���J�}�|�����Z���
@Y�S�wx�[��|���bKq���w ����S��;��;�#�'��+d[����}��ф�'�?���V�f������c�lB�߄?P���v������? O��I[ �mAMʂ���'��n����Τ@{.੒B�+�����x�7�O���k
����~����c/�U�l�2!�q��ߓ���`�Cn/�����];��F�;���O�6_/�bB���/&l�M�ք������~0&����lq����Y&@��~h�!B�]�!o��8��S�$��B�o!��.=>�K`�\���|�}k?�ɷp �`���H\��G�k�W����m(�.C�l26(�m(ʆ�'�	���t��~��i͇����>>���|�B�_�����S:`�MhƄ~0�����D��2�GK��{r���H?�`*�ew_)�o �q�)ߠ?o�P�����ylY,��{�kC?��-H#�]��ck������l�gӻI�1��~����ND�Q��B���ȏ��͌�'�t�{\�1�?���[��#���=�i��,��|�T؍�����c1fH$eܤ�F7�6 ��W�ö�ɷ�K��뾨�����5�o"���羙���݌v~��0p=2�fHD|0��:}�����fF���տ}����ેeF��O|	^EXd���)��Z�\���?����?�Y�O����o���ø��,<�$b��h, �{��=�xa�7<|x����Q!	�8-�"VD�z;���4�
i����� �(��6�DR
0MhƄ@�g*�oA� � �����y~G^o�GT��͹�����n���㚗?߫/����w��`��D� ��c�K5}��ӄa���=���b�>B�	'�-�𔒧SE���U�L�N,�=��H}��,v�ER��$��݊����\�d{���p�Yǁ�>L��`��7�~D��oJH���L�Z �@Hq���R��`��0cԾ�!F�"VB5+!Ft6C�]	G�!c��7��w������F��;��)߁���s}1�_0�UG��8�m��DL���ɵ(�qͿ>v����(�z^�#.��{��e�>l���8
��_��c�p��C"�M���Y�����ݪH�`bAX���Gz-�[���t�ū�_�(�O�3�^�B�KO����a0_�ւ�W�u�o:B���U���lW��M�0���0vg�(��Vn����d�E8��Pf��kh�}�6ԗ$c߽��3�'�eB�I�أ����~����V�@�<d�4�)��>%��N�_k�/������B؁d����;T�`������)������妻#��g��)�K�!#"�ӗA�ة�/_��77=�dk���W,Q���"��M?��SV��
��	�� t�(�0H�$�� �Y� ���=Yh��
H��g�K���0��_|�Y~�@�fܤ��7����ӊsy�0�L�a�1>��)��)�oɱT�
�2�/��\���<m�T��Q��U,B:�/<Fʶ��*ſo��U)+�ᛣ �ß������Z41��dަhe�M��������<}���9���L�ú7���E_�5'�c&�2 wc��z��1��naw�C��Ez��h['��P���7���K��̝gnw�E���XKO�����r4����-b>�jk"z��<�rւ�|��t�*�!�js���'s�Y�#!�K����qö�Z KB����0� ��@"lA�P��|ds�s�w	����6���
��B�U>k!g�X�\�©�yƎ��s$����5?_��� ���)�w�wh�[��������*�����u�@,�`=��p���X0����~�?�ԟ�����<*�>�Q?3x�x�TĊ��&o>�D�q��bE����'p�w_7���?'����VHt=�!�� �J�s�؋8 �G�7�pY�/+�A�.�WD�i8�����۱WT�Àl�wh�"ٙ��k �� ־���q0�/��%�(�����C��aA���KrF}�� t/�*�����c��9���a�R���TOr�2T�����	�ݝ�~[�����l:�FײC�K>�1FbI䋔"nr�0��-�q
k��QA����]m�J!;��sWD��!��D�b�x
����&�WG��3 �����nˠ�H��tA�bՑ�cd'�4Q�JJ6�[�PJ���V�с��$Q�"���Ka�"��:���/AtLY(�΁��KdZ����ڙN��rJ�xr���)�,��p?@�_��|	�AgΤ�@�%x� K���{^T�CR��4����xvJFJ3a�o�۔fJ�/������Ag��P�Kty������!��&�'��C��-+B"LYӬ��1R7n��8;,诲G!�[ʚD�$���Kh?EK:L@�1A"L�/0L�Ȉ�[1��{1OO���.�6B����Gy��+��}��\w4� �o���y��RA����T�@�4��4 g�g]����14��1$5	4��Yl�@?Ab[�2��#ٟ6`j��>F0�VDcE�+�ymE�|���녲�IRc�Ev^Uy������uO�2cb�C�zVÅ��	3t
��]�X)��y�{s���H�ӈ0AS�q����K#�f�BwK��]���Z����@3=�^/�H�i@?]~\���l��$��叝yZ��"+��ND�44�$ }����6 0���G��� ��u�.�)|"+��^Y@����de����wz�� �ʙȈ�@�mVZ�ٷ�?�z6e+�\)�+�,�{yvVϮ�E���u�$��0/yO��N��b��W={��M\��&Q[�G��RnAi�0H���+�������.�?�	�nL3����^F����(x����d�0�Uo鱩z
����s�j�K�"3H���"�(�q!����L"�D�W���$�E���A;�������A&���%�Qw&�٩dQ��=���AG8-H��I%�~�c-q.�H����!����n���9��"��oG� >��Z4�����T�Pf$L���@�9�xС"1�k���g��Ӗ��H��"`�߉E�����pT*�����Hh#���Xa2}���ej[U��r�m=�� ����uiH��>m��ڏwP{Gh�
��nm��/HwO��Z;Ga�/�V�z�A�_A���y��??���� �S�����힎�b�r��x�յ���Sn���$(\HD���{}'�f��� ��U���^ݏږ�-��h�#��D�P����� vA��$"��w@LW�����&��#	Ddx�o$�D�,���ο����E0JhY���ޟΑwMm@*n�z�=G P�m}R�%&� �}� �#�<��I��A�ׄ_��km��g�V_ni�&���Jr�*x��|b"I�{D�� ��c���kTY���tM���^�;&��-�Z@'ЭKTZ~9~�=/��F����7�_����LK+҂�F�Ԫ�� ��f��K�{��������#F������S U^���@|��)���9� l�W��V��҂*	i��o1��@";:��_G���v�A���G�J�@Ҡ�$Pi�͠a\ !��`DJ�S��sa��Aq��c�r��o,    �:���x:#���H� ��x{@�ւB�ξ���$�xc.���MDYP%�o��Û�v
`/���6�yp}y~�R%&���$�Y$"3�����S��#y{z��H(����*fd�=��Z �}���$��lo�-��0�PJ4ׁD��DE��Ȱ�����Nh�!���{Ha��@�N�t�?������u���6DW$L6o����g��Ș*�\~���lR@$�(�����o���\ӑ�����\�~�L�f�DIP�
��@�R;�����5˔�3����._yg��	b,=�G�N�Kv����XbXVP���9J��['���9� #��/�-��ي�g��U\*^	��0!R�-�vJ��"2��o8"k�'�>�_��K(�o"�)~�!N ;��j��!��+�x�# -(�����q�������FP�X}	�_�J��r
;�����Zx�gn_��"{-F�����Ҍb��Ӊ�J	\�f� ��h�<�|0�����p%��w�8=>�� �J��e~��D"c�9�II��:i@�4��m���*w��U����*_��)��Cj�a+����T>vûp$�
Q���s=CF�1�	"�����}��3���@�X�!^��!BV�g�M$��m{H�łHWs���l������� ��$�y��6j�y��Z��Ω��F��S�n9�������z҄�$��Y�|�A�0����!O�REy�u� ӳ?�}?)$6����!�B|K���?8o/&0{�]1Έ$�@)�!�B���it0��\ǩ�V�LO��]�\�d%uT$�D
�/�6��=�=��t�����H�&Q����f-v7��>ڈ�Pͅ�L���}<����h�tf��@qwE����6$�X�(����͔��`�[N8˃���/���&��fc�h!�ɒ�����(^�I���}qSp��е�X]�򆭧׏��O�?����Zf�7dy�9��p��T���hB	eƆ0a�^��	�RE���Y1���-���;�N����]}��YO�)�@M��R�݆���u��J�U�
o����?�����Մ�AA��u~E�
 �C5�ȕu�`/����(��b���Qs�q0�W�zLuٙ��%Z�ن�al���ih�o�D��`�Y�n�����|���_��^2	�N����]���5ے!�}���(ࢄ_?*n��P��
�^i<$���ٛX��}�-c
G�/A�,)���5Fb�,��#RS��͍���=�@�OQW_���e�H��Ձ�.q������/ɛ��o�|��OGyJ���D���%���mJ̢v�fk��X3zX�!�H���T6�G�搈#�m���`d��@=ޟ��gh�
�)o��*�U�(�:���3�<��Ex�<(��ڨ#�wT$�� �4_
��n#T��?�dG��Dv��%��M��������D,��������� Q�)�۰���~�(�i��Q�S5��`��­`Bn�\��Af���r|%PN�BT��R����j��Z'���{(,�]^��g�1�H�J)�[��o�R�����"3���Á���?�,�Dr:�=h��r�,�bJ8��,���/G�Z�u��qR.�A�e�Id��E�H�H����m�%�"I�Tn��+�((K��薃H���8|H��і�i
$��'�p�)�4����PK�Ѯo,h��fM�oy�^,�[ ƂFR���t��<���������l甗k�B���:fu���q��RB����q(.hs�l��X�EV�u�LW(hx�&��*$g�A��>�b�Юn�[�WTA�@vہ��ձ\���ӗ]lP��m`Yaf���(���y�0{�Ķ�����hڮ�j�*,�#���_�UUSK�I�hg=	�E'���y1��������s�.�(O��CSu"���<��� ,��\��!�a҅B�b	�G*��X�7� m�R��m�\ ��C��łtZ�����i#��,�Rj�>��/j�,�$R�IC�̯������H��tyU�0�9����@#˂�ZP�7Cm臏l��b�B���L�|�� �iL�t��Mb��.mR�Ut{�^T��1����:d���2' ���F2�T�c���g�m�@8�;�8��X�x��S�b����C5��X�J!�52�T�f��k$�
r���~�Q��Ze����O�4&\��f�%�Y{!�@�G���G]�h�i���s$T�`�Pq��8��u��˓��y������s#���KJ`������M�{��S��-��������2U��XC-�Ld/��cȮ��k(Qy����2!��%l<�� L���L�������b��lL�c��)b�Ev��E�lJ
ϭ�]�*b")��/:�e0�k��1@g�VK���p���3�쐫�����BRq��dA���m���Y�" ᰖ,�C"�(>9�ӣ���rHSY✨#E!NY�C ���Ǐ�J��HD�N��Ν��p�VB�T���µ� x�O�@�ʫT�EXSL�?R��n뗰5�$���_��]�e�٠��a�":ܓZ�=}S:�Z���ճ���m�U�A57r>9K3���B�ʯ)L������bF�f����
�w�̻HyLK�F� �E���uIGmH�*��w5�������!�%[Oe�s�ǅf<�OER$��W%�o%�#�I�iP�p�a_]��#w����ꏎ����C9jF����rf��n���SX��p�)�l�-ւY໕��{3�\�PU���.���@�5N��*�u:W����i��v�8f%�khS4 aB���G/6M��&a�Pz���6�$�_B���6'��0�[�_ޯl����EK��
"�J�C<��{��_��E��D�#5�}_/}]7�7�qg�
��� }1�b��D�nȺ�FՇ��G@pYt��UC*��E����A��b!��Cr�e-
%�J����5ɽAx-F�3	��(��U��u~K�7�ұ���hJI�E�����n�Ub	�z�4�lb����� J�a��"��rj�2!��5{CJD���	8�Co�36�cw���ܟ#��מu��w�>��}�;{�_�L�:8���T}{�����j��l���g[v������F��CH$�w?nC���&0}���ygsH
Y)T���i(`g�e�ecc���kvЮU]�3y�����[�u�VSr��Rs:��Ȏ�`���?h&�>��1�2>p�Cl��!�OThb_��Y�(�%��hY~�rc����fxD�v��Ɨ��GH�@h �����#*k��#�e���~���m�������<)��V�K"	�dEiZ���0Hi?R&��i���4\��N���e5��� L�\�
6U�q�4�H�$�;H#�]KH�,�~:�:��M,Δ��W�����/F�,�j�Yڼ&�� B敄�E�C�ntlפ�#)Ժ��'��0u �������dKˉ[xF@�	�6N�x�ئMGC׃`a� �iSN���Mrλ��c�
s�\]{n)��"'7�N�D?����vy"W'*��^����`��$�E~-n�*'$/pE�w��L,8�&�p�ī�HN)�]��y9Ej��T����Ss��k�'�J�=����h�
����\t��v�=���A '5Pg�H�=�o�m�5W/�&?^z�O*I`�DV�E���@�io��Ry�!F:�=�Jk�@v�C�-JSV'�R���!�I�(kXd��"P�Ж3�'+�R��P�Grv�!��`���jp ��)}ub��}�[N�vl��$t �#�����'���c�zL��P{D�� �Ƞs&C:ë�0ii�*a/ۘ������<=��o���E{*Ӱ��h���SY0N�T�8�$�(R�ޯ9�ctO(��
�|��i�#��^�B�V���N$ ����u�\�fE:�h.�^�8q6��x��'���-�7���Oax�+^ћ �ZЫF�cn    �;�t{���m*Y��$uW�GƵH�7�@d!�4ܓ1>�����D!�� 	p	��YН������5�@�hCʑ��.�`�h���t�*&���N��E{�2]{��ĕ������:���������ӂ��a���bh{ݭ���
K�{T
��a$��,I��AVxs��J�)ڕ��.֖s�=�
���X��v ��������ֳ��φ�p�3X�3k�c"NV�xvo���D߽m q*��DFő��L���3{Y汛�H�a������J�%��t~|�}?��l`�Z����Xn]�5�R��x��f�U��̓,�8���C�S�I��;)#�&�'7�@�Ⱦ�䴔8w���my�,����ɶ��\{��C����I$������1u�a�l-O"�
�f�f�~􍛩��xQ�9d0�q^ZQ�����u����8�v��/N	�� -�0��,���c/��=]X������-b����5�Y��Ã���$,Y$�ˠ�=@|Tt_oóp��V*�5��D�;��P���Eᶤ[�p�%�;Ԫh��T���r�"�BtT��L�ƿ�W�@-a��&�� -Q�,�KY���o�2A˿�ШS=�ӄ��	٘0(?_={/&Hfr������`� 6�i|�}3��o���L2c�M�*��e��9b��@llB`�)��Gh�A��~+���#Ob�qD�~�dL��	D�pQzɉ~T�?�7��c�Z��7���� �-��%�վ�1�^d����IG�%�fl$QG:�Q�$r���6Ԡ�a��-&����3�5#S��)��'5��%N#�a^uZd��	��Q���"�L�ջɩ����w�b�?1�O���\�� M���
di��i2h�`|�Y2�A���2G�Mn3Zi�H2:���� F��PI��6����>�4����'X@H~��D�u~TCx�-k9$��Zz{���� �d+��v����m{�֌�� �����'��,�Y$�0��I�D�G��� ����Ǌ��Z��c�w�>6jGn�m#�O��p;#���� Jw������ȭ�B��V�$���z"=�}�-
ҋ�J��H�a�� � ��v�V���tx��=��L�J�S�)�oȱL��x������F��ue�؇����[>R�Ӡw�JꞭ�3��H&�"�ƾ���i|��	�T<�h�eJD�&�ݍ�%��Zn��sJ����MQ"]-#�'ڋ�\Fj*R�o;��0�S�90q̨�I%�pVI�G*Et��6��*/��(�ƱȚ�l�dM���,?�Fw-?C����	1	��Gf�Ib�!&µ{�i%;=��z%�
=���{�^���[^j85�;����^��4�2v�V�(�q,7�+�S^,`�-hւ�nL-��X�=���P�9$"���M�(���5K�(3����S
G���B�D67K�3����A���L-�ZQ4͙� ť�ᡛ��Y�0�]���bǸ P��Qȡ>�H�$�P����&g��d;U�{��9����~p5�h���<�۹54e�_�ԙJ���l�/-.���}=3
89����(0"By}.{J/�Zп`F�p$�����?g��pϩ�0�yr`�G�t���/��_�)d�ǥDܐAd���A{ɉCa�X�:�v�9q21�iO)ƌ�m8r���u�"�l@�O�y>����H����E� C>Q�*i(5Ip�9z(�0���l	��]{�PT�oh�J��*ɢYU�(��d�chw=	9^Z�i*�d(�K�W_��FDI���65�U��w��C���-�w=i��k$N��QJ����z�ZY��aOU�_��D�����.��٫��y��R� �[������6H/��6C��fĥ9���`�k�@t��}>/�15��D����&DY��{*�;-����7+!� Xp(iw!�U*�
H�h�����֦F�`�Q�=�7�-+���f�bwt���0%K_Dc,$����p��S!1c܏�8��R�"���UD��r�S+ZH�~G�Yl�*��Yב�+Γ�������{��=�B�#��}�>�k�4*���n�R��Fb&�z.)� ,C"��tF|�.�;�t�;��� v(#��B(i�.�Д��$!c�h"@1ӓU�C�o��h:��ڡk�I�I�Y��s�|0�	���~��ͤh����nFv��t���{��T|2�x�=)���"[!RW؈���M��q�����rW�t?9 �\CY�@��W�M�q[�N�W�Z;/eF����Jq�9�m�$M|dHr&ei@P �
t9D(^V��n�YdG�E���"K��Ȋ����o��d1a�ϔ-@�<�-`��C� ��n�hdYV����2���'�/��~��0�~[U�R�|Q�=������"L�����J�'�݄<��;�NRc6��,p\��q."k80Y�+���KBZԹ���*]��DUV��ƫO�M`ofld�RI��E���{�W��lZj�w��-|{�h�>���"C�D���l�Ԕ�l�+�%�9D�8m|a�@�s�Yt�ղb�bk�-@�O����"�a���Sf3�hY�4�y��֒���ZFv{�if���}	��U��c�2*1��K�W8����~i�ʎRX�2�;HmV0���:$�ia64���O㆗���mI��a�� ������,���#fa#���z�a�p�;�h(�#��]��y(s�#�Ce�H&߅������h�'M���zǳ-�HDTS��+3G�g���xNw[�����m��!M,����|�$��H=땶MD�GC�;�	�/�0|��QwH��Wdsl��C�!�-t�Ff��B"�T����&� ˂d���$L�]Z�#G����iEN62R��
�6���Q����A���+k�c�2>��6��
�+L��p�1x+��^�"�"��҈ը�2�f$
ԩ�!o�W@�B���J>�1��2;y�IN�[���$R%������S���I��ҏ��h�.Z��q�-0��/�ǱKܑQ��rE�8�<����<�ӂ��<��Ӹ���k%�#3�|dQ��b*���~x�o�l�&$�i��Y|�l�4�2�{l�>��o&�lJףآK���	��M����]��nz�:(�`M`�MƄ�|���L8����<�~��	ޘ0�p}΢~1!���0�-�I�	�,Gli�G���TȢ�^�H#��U%�Z�E�R�7���(�ֲa�����͏���(�0Ȟ.��p>�Z�	�����Z�悺ʁ�tr%��I��Ⱦz6ޭȧ87!q�&�`��E3V���F�`���\%S�
�Fd��|$F}�t>��ӊ1m/88�`���Q����o�+��b� �Grn+$�Vc����}ݜ�V�ӊ@���È����m}�^m�8�i�+n4����O}jrt��E��&Dډ%؎"��	`L@��������S����=����6#l���ɑƼڇV��~\$��r#�$­]����ݓ��7�A���hب6A"l��@>g
�J�	�I9F9n�p�	FxS4�)b���_N���T"��Y��NBMYX���JDwte�o�+�y�:�m97(#l��V��q�(�|Xqܠ7@�p��]a+�������"�[���=�1�,՟��F�e��`�Ͽ��^~0�3�1��B"l��6�7$������MV8��7�h-�_D[�I���)�V�Ⱦ��{b�%'��,�Aq�H���Do�iߞ�0��.��D)��Z��g$:�ғo� ��9�Ad`�)�;�J�r���#�?<\�^"v�̟,
}��,�A��p��̌6)�w���"�Q^�a���I$�J뺧�|*�\瞝�}���@ׁ/�(Y4¹gM������љ%�z��w�6�l3�D��(�)�S��Z�6�p��Lk�}tRa$X����H�|�}���O�q_q���da�@�:E�1NN��
����ȝ]<Z}�5QRӮh    �ej�dԮJ���eG�;z�����,����Ii9߮\A�1ȞA�"�u u5�o*��rI�4�#	\���%EhP��H�rh\�T!���-���s$ǯ��)��@"\��_c����˽x�#]�����Q"�k�ui/�kp�W2���cʤ>�%�$��8F�a
�ǉh,84�IeY��7k�  ���V*ů��d�zj����D��3���.֨o#g};�/=ǁ�R�ȩ�F���5���I���D���II�0}���7�}��Tγ7��mU6J��U�
`V-�p �:* 8�o�VGϧ�AIS�9�$��Q���y_��-b' �@�v�6 Zh*��w�;vc�$γ��^��ލA�h�7T6������Lc̢�[���Հ��f�"(k�<��)<B'fU�X.z=�t�р��~P���T9�c��Af����(_�l����䘡���X_� �4!��_#ۂj��^�D��������-`d�����)O��F���H}"���l����qY[�ˤ/���C��Z �m�]�@�A� ���.��]�v���8����lOrO��̒�ޞX�� �[�wK$R��^��I\?���k�[u��S��H�
�ӺZ���>c�:�r��U~mc��d́�H0�HDo�m���?4��,�g�Xksg�_��TPɊ�[�i�%a_f�(���5���rx���p�����y��ѻM�� F%پ�3������>��q��ﾰ�31>.H.�l:��8��H�M!eI]Y���my�U���cA<�[g��~L�88(�M{ �C%�<���b�F1 jn�l��\�a�EX@�qh���t�������P���IjKmP�Eg���"���\v�d9@sua�ug���� .;Mt^��ۑF���M�X��O���r������S0�Y��D69�dt����TK��&�y-�1F�����#D�uq��s0�\��|G��DJ/P>Yd�i� ܦk�O��J?i�~aNi2����ɔ�4N�Z�aϯ�O<�z L��*4�>��/�4��5�����!JZ�E2�QI�F�$�W����+�\���t�Yس��#�쎿�d�V�*@_L���g�	�f�.�0�	��� �[^7~�tZ�HǠ�H=��P��S�e
#ʯ0�dO�ڎi����!�N��C"��3_gf��@����p� w�0$�,�No+���[.H�y&��z	�/�<d���x��`w�Df7P�jv9��"΄<��Xh���^������G��"Zw��F��O�dw(f�~�Md�3F����(N���6�S�P�������&Z}<y�F�<���%|����'���:�M.c�}��6]^�!�^�z����n��cQ��@�M�}	(�����C�CgH�ݶ{�Ҕ�:�&��9_ͅ vPu}��Nz���4$k��IXv�� xz��PfS\��9� ����D�׿A�¥�z�.-��^V� zkA�#�Gg�%EfE~%������(nGS����MjI:&A#=T]|5Z�Q��D�-�1N�Qڧ�x8f�Hd[irr#��sYrPi��PHj�UD	/��wgS���$�ۭ�!I��q���|�����@�W�lI�A�O���u��VD�A;��뒫���۱�U5��Sf��a�E6堉�
��&�R���̤84���4mKG)��Z@��r'���Dg^�C8�é��e�7p���j���6@�J}��4�<�v��g{�l�A��g7��!�O��g�l"*a'�~�p���9�o�*��(�Xt��Q4�og9�#$ʔ�êh6�D��*B"
��@��H�K���!�d��%��}�~`%�4T?��'�Hu]�ԯ��%>`��i}q��P�A����?j�C\[p"��zm�w�c�b�� ֥���8��x��Q&J�}S�_(��H2?ILzAv�g1`�N5��PS�����ԝ��4;���nIw7�Z����GR�S���F%��#N���d|�'v+�K:�@93��@�˩o0��K-w���f�%��z/�D�a�L=$��r������[-�8#,�&rT��>;�%�$P:��zDI�Ee��"B	E�H����w��=QGcLg-�k�t1�1ٜ���
F�	g�_T���b��{Q`a
�(��t%\�pv'�Ѽ�ee�aq2�i��1���N0,�^���[J
P,�_@Q/����}y!Ť�gC��:S�T+�p�Z٘��p=���4��G�������8���5�t̠����QP���ѐ`����!NՊ�����.��)%@�����&~~��oH/���Q�&>q���F}O"$���P%L*hSͭS"���$�1I-��udM.!A@ݦ�2r�/��#"zC6���>��N�*�~�(��Lky#��2"�����A�Q<ԡQ>C�I�>�?�F�_�OK�c�[��,n�8/��t�K���,���p�}ݣ��b�:O{�P��Ӛ뭐� �C����ٜ��\\i	h����ऄ�;�i��[m���7�mVV��!���r5��QB���mP'����R�vHm�8$�fxuU]�Cχ�"�B"5�6®�� Pִ�*0&(�/AA&�#WϨ`#�(��گ�|�s�_a���m�M	x̑"��͑n:�D�˫���O��C��Gd�E�z���!j���[ʰj�P"�i���ug ~���r�	�׸�]X�[��:p#@�6�:ɧH��H
�ODNO� +>�wS�"bxzyEY��5c����YmiQ�ȧV-�ͭt76?�,�KQ��@"�L��j!ަ8]�V+�?M@�6� 
k#hL�n�ĺ-\VE�4��/28[1�� �K�ZQ�G�щh��&���&Tcvr:� �Y7�4�Hs���]��	EDAtH���
��@�5�Qb��FI$a�6U�d�0EhPif�-���Qi�;��_� \:��yu�<�?�4:y��&K���>�� ���"��ı�����%��l��Re��5H]!Pf��+u�)�'�� �q����6�R(��A���T���v|�s-k��ԱP=m���HSi�Jk\Z�z�R���q��1�%��>���j��VY�<w�V�)I���@� �ԧ粆y&�
���#��Y�CR"{+&��#�0���"��6��.KGsGM��6�Kth}$��[�G�T�I�Y9џI���.��ߑ���tBm ͷ�i��� -������=��P�_^�Ç������HXS�p���I�g��1r�rK�)�ZN�t*Q��:���c�E�i��wwa9(�C�
�6�q$"�	�p�4��LY�Q��v� 7ӿb�OQ�_cXk���4�@J��ɱ���H��S��'咘>����[�.�-<�E9��#V� �70�o���X����l�-��<5�z����l���A7R/�H�-P������8�����u�D��"٣E���m0|pi�q0ъè۟0�Dk C��K_,8����ך��������鼞���Iy/�V#�#����ne���ǵ�ѵ�DUB2,~g�N�*�m��f��M�� ����}�P�G��\�M���.[0�OU	�����N��G���F������@#ۂh-��t�������ϒ"
i'�B3��8����|�[ꬃTx�`#������o��ew�
�o��T�'͗��ꑃ�� ���m�������W�t�[Д��O��e�T�X&e=��j�1�����x�x�V/���KQ��{�V�F �H�:6��h�<�[�i�|��b�95��@V��i�{�M��k��r�ޟ�\�$�<��ڌ8+<�{�jF�� SZ$Бj����PUu-�I�z��9|�D�D�_#�eXL�H�˜Q��*� �t�\4�Y#Au[���?�]�ǐMF���1��*    ���h��E���
3��D��zb��3ͻЀu�{��6�x��J�F����d��d��[�z $i���48��R�kG�}-$�$��@%�l|�*>pE#	�S�W��u��[n����k��U,�zk�D8_f�$X�a�=
�>��L��{K�F�<�$Y�7��iX��<�:F����A8q��o�,����j��/��跊S:Ba�_@, �q[^�I�n��7��d�_�{�
�;����\�;�R�q���;I!��.�$*�#+1�6c�g^�)~� M�K�߁B ����kq~����_��'��^X�r������z��6�gRn=�}y���bCe���������I���D/���D��)����	�!�G��!]�ρW��%>��AY�t1�wh��&�1�s����0!I�{0[ѕ�?D�ь�X9��U�0#�j��:g���Yܧ(�'�?����~��Q���H��N�X�ې4���W$�NAj���W3����|ClCC�O����yV3;�~�}o\���0��O��������濌��?o�ؾi�6��x�"�k_QC���E ��C��MxI^ﭼ8k4O��r:kag�[�(����8ۜ:��Q��,R�B:������&d�*dK�<�^�DX�WD�mJ��b�-�i�� ݛR4�xc��So=V]��dL���#f� �O�?d�C�E��[��b &�"~lb/U;,���B���q�S~�1ˁ�I���R��OB|v�ȴH�G�D��OrX�t��>�v;@���E�7�����z\��p�!jq� ���`%;�d�2�u �*,���)�ЏB�I �3d��6�k%��N!���u�P���E��� +=,�W`���3� _̟�YH&�d]&ݪ�#d{I��:�%>jw�5��T��A����>�[ҍD؂`-hcP�-)�1�j �[�YR��` #B0@�A��A���Vج$&m�|OZ®(鐠���_u>7.��[Y1<u��
t����=����3D�6�ȉ�~d�Ռ��k8֒�(���^=���0��Q�0�A��/� l��O�Ѭ?��x�N��0��E��zF�N~��Dv�&���%Ea|��}{:$��"T�����R��� ��:V�/�Gy3��G_F��g��A����v[`MG�����mqQ",C�����T�*�8ұT��g��N(�<��t���(ޞ�Y�Ɯ���C�h�k� }��1NY��!��v�F�r����繧2ٵ����1+Ǘ�����Q�n��Rh�F�G�Dvx :�\�I��;��c%�r�3}�[�Ԧ����b��� Jݑg��e�-HւL��kn��2Q0�3r�r���eD$�ĝYG�}�R?����x����fo$"�7٘�(��>(�f��5$Z7)3�O�f�g���,�<�](�w+�Y�D������qCH�-��-\K�I��ݾJ$�_�g7�k�oQ5��t�
x:��[0NG��؆��0C;nuGD��F��=.�V	�0-W&%� ���! ���{M�4[�����]�[}:*��b�~׻��(��=�j��F_�?zx���L&(��atv=O�x+;��q<�T�~�j��a��A�bXc���
G�Nݰ�� ���>�Z����Ԙ�)y��ȟ=�"[[k7b̍����K�׿�h3E�&^�l�3$�9�b����o����Hb���oȊ�����i���y�/�s��s)G"�9!��Od�n�8JK&����ےyS�TG*9p�/a�h%mKگ��x'La�HD�~�`%S:�
�X��e&�6�{�"}�ǭ~�>=.Z8�9[v$�uK�C��mCo	� ����2��F�K�ʫ�v~N��l5OK�QX=�a���R��DN�H(A�f�[`���tp������$�#lA�`.����������J�U1��H������5r��R�pK���F��C��ʎ)d�D�ش��{�m���pO�z�ג��;������:�o>�v��\��$��
|���v�ibO���W��gj��XW]"lA�����XD��9T�vToz%":xD[fJ}�:�9��yER��C�qu!�"�~vN�@Lbld��Gm�9���THss�f �H��DH-�8 ���Q�
�+���H֚��E�iE�H�~C� iA�)1��T���&f� KnEx�n���^���<J2hg�г�N�y�������( ��1$hD�/-R����m2\��^��M+�\�b�(��ޅk��6�W���q��A�yG����*#�t1k��gD4���.G�<O*�d�� 0'��`�GR�0���h��	ѯ���P5���BJ�R��kqJ��f�@��[#��擗����ZU�G�,|��/
�ӄ�5�%�Dg��$�i��IY@�����k����/ݳ�4���bCᏐ�����{Z/�ԩ��h&z��0t�/P�[q[��]��Ō%�eԒ��@xY��1�\J�\��U��mT�x"�g#|FxsF�d�X6���;-z>A�,a�� �M��lQ�<�|(�ج&�[V�ID�!��B�'CdpjK�ّ��
�|w�@sC�)ko�ĥ<N��!�S�Oϙ��jE-�@��7{+�D�?̽��j��D���tW���8kS}�m*#$��dl�iIM�}U�-�i*���Sn�Ʀ�\^"��K��h��vOMZ��HY�v�u�|Un
�9��"1OOR�W�~L���y�l/�(����c��AvR[(Ƈ:�@����笧Lڨ엲�%��4���η�08�b��_��W�[P�i���|&���vi ���D��@��T~���$b���J�sl�ׁ�T̠�۔*4AI��YK�=��vW�2��G��B�b�J�Hr��09�Kψ�̠����sp;E���u����b3�]�2���;>��z�^Q�>Lo{
=Q�[!�#p�x�>{�&rW�Nc�˘�Xa�������Kd$[
�Dxt��f������/9>�����5.��6�Is^�z+�����P^/6�j�ZP�D�����AE��,�ł���Z0��j�k��з��^yA�B�Y��C��~P�LM�GqJ�� ݓ��~>��k�,�8�+�z�Jt�7��X1V�ED*10r�{ᣕ�̧�vƉ�$�[�E��8��;q"
�U����`�N0W��:`-`�-ƂH#��5Mx�;ɂ�@q�DC��a��aT B�	��\��`ʢR�:�j,�G��6I���SW���)�V�X�}d��x�XB���%���>��c�7�i|�n�@V�Tő�p\Ķ�.�1��(9�O�*������K�NQ��GmL���s�k9������-d� %�W���r�H�o���7ȱ�шIDH o��Y�z!x*
��e�w���5�fЂ!��FR*��Dǻ��/Ȩ�A|]��[H[�4�'��Eb�-xm�B���G��]���{06�&mp����KE�6@G+�8��[@���y{��K��ϱ�_b#�-���]��Lv��%90ҏ����ȃ�d�LM-Hj� J�m�
o�[��%�|FnaZ��{Iz8!O�҂#�P)O�6v�[P�$DrMǁͅ�G,�',`�-h�O���ǌ�F
*�<:�F�,���0!H��J����q�mˑ�Y{R:3����We�tō<�R�UFJ��6?�r��K�HB7m�����hʤg}m��%נ�z*_��A`,�I���UJRCww��5�rh<��"��O������i����T����
��vf�]"\zUg3�^���OF?H�4����Z��P�a�.'.�R�cք��o��C�a@4���[�o��G���x&g�)$¹q5,9�~p������!���6�Q��ӳ���4�Du;�I��)r�����u&#ΌZ��5��2()V�^� v!h�,�\�a���3�?Gw#�0�S��0��o��݈OjO�q7��@�@��4�Gˋ �  Y��b ^�����̚~�̭��[������RI��Y�DC� ?�� ,�s���$���d��)0�
;���1#�lIʣ�[�ڷ����(��tg@=Hn�j���xc@���%
�)HL��T�K@�RP���,
RU��T��u�g�ϵ�g�cY����������r������5�[���#�f⁰�X�H/�^�U���aA$ڡ{0Z����?���_=\/�O��a�H�0���P����l��8����Ձl��j,Z �6}I�G��	ȁ	��@XK\+��|0N ��Az�	�t�=	a;�?�� ���`�s�q]��(�p�lJ}M��~ɼܷ=N���^_F��"͢;��(_�E u?��'��H���<�����ɾ�1x]�ya�{-1���4���.t���6��Ҋ���ZQ���C�Պ$�A�t4ڹ:7�]q[v:r�0?�������E\�MSɽr"��(�E�O���8��%b7^F��Z8G���Q'-���)�ψĠ�6c��c�w�;'{����nY9MdY=��)\��5��;�y�l�v�p�c'�N�k!CA��z ���AGxA����#= ��T�!$��M�ܒ:�H��`+�
Y�!��`�u&e��vZ� �=:+��VG<-	�v;�ė�M�N㫶�R"\wւ���_R�ʂ���<K����exȳ��v4jn�� 7�<1�u5Sb�Si�?�@v��n�j��"���҂��(BKS;�G�Mq�B<�zj}C����nEH�@X���Ok���b�M�>�	�G��GK��&���gk>b��P��ݳ�#���nP	�C����� �t�cL�#��-O7-��`��q��D*x�KıOm�����ۖ��'S�:�J��~�;�7t ;bUs1�nNɽUZ�S�i��.�_H^��.H�<<�v�Q;��}t1����M2�FI ��$�Y��{@Ynż�Ng�Y8}u(�?�Y>�f��+�X ��m3H�mJ�'�ȶ ��^��![�W��1�����- k���C��X�a�H���]{h�^u�mܭ��Ϥ����.�ȾwC�������/� �r��1�śdY'����e���!|^�E��3��e����)�\��CY��ѿn���9wW$*��XtX1p��;��?R��,ꄁ.Zb֠��iT�P}�R�EU�Hvo%"�ew@���$~��щ�`���g�*Mxi�(��i�����0�aB�&P�/^'з������p���j����lV��'�p,Ͽ�ۤ5��D�{�.��{s�|�I8}V���b������/�T�y(�Ю�&�p`X�� K����6�5�FLj�ˉ욒L��R�~���GS�Jf�5���/��x����|�~x�kNfV}��iء�@���F���G~��|�z�G���)O���\����Z@� ~���`(*8�ء��dpn�H	Ѐ����i�ᨅ��V	�.N����H�U��@"�ީ��R��е� O�~ ��F؂b,���p��\����v3��zb�+a���T/�����bLWq��%E{�O2���z
�����R�hQ�1�:�'I] ���F��oh�C���"N������d�̽��E01Q�So�W����p	5��UM"d�
F�*0J�Mzz��-�$�a@��Z��o��㑐���|��ԥfۂ�N�Eĥ�o`\�80/PX���Q�f)7R��q��Iamb��c*[�kœ��6�R��ȥO�F��Ԧ	U�@�jm/�(�md�i��~���z [V_L5�2x�?,���1�\����QRi6G�%�h�s�,?�FC�H�,
��@3�o�,:6!p�O~��i2}�G�ә�A���m��D��6�=��%<�W���DT���X�n'�f�X�v�F���11�H�Ȟ����6k�v+41�t�f��{��u��1�rL���i
O�T^�^/ZǱ�}8��x���+����k=8A6����Z��ـf���V0q�~l#`�G�7b��Y�g��wЗ `���+�#F#� )ʲ#l��ݣ�GH�Z��^Ҥ-Tt�|(� �c�y8��C�ؓ4�a�F؂h-���s���g��D�8��a�5���mS�hcE~̔8�T��_i �ċb�����	�Ѡ��8d�{M%��-��X����%cGs q����=�:�*z��z��� ��Gc⬷$��)�(e��ˁ�[_kط��RU���4��Fc�HD�;Z��� �O����Y �ɑ>��J�Ϥ.D��c>i��X����[�4I.�h�2E%t��$��J���/��>=R���?O�Y�(]�&c�閅Sf��$݋Ph,gw�09��u�6JJ��͛I";HJ�X ch���4 H���x��$��o���=fEZI�%�ق��`-�d�/}cAx� ��	���-�[���{�n�	pZ�Ǫ�K�-H�:���m����V��@"l���Vj���<�тtZ0z�B�[A"lA��O�n���H�y�:���
a���8��6]��w*-��E˙2a�-h���ߏ�N�9�!`'���ᤍ���v'���9����a���M��3�zRs�=�S�K�/�ODR�����<1��J��_$��U��H$a�,���:��*��J.Y��s�ܮ��u +m*�i�)�0��ƀ�5�p% <�K�1�D������Vzld���Q�6��s��96BQ����Ѵ�h��6]�3�w�Nu�$F �H�tY���wi?���zf8L�:����`~�Z�s�~���KSB �)�w �mA��!�t�� ��0�	O�	|��W��:s��G�n�LM��2�k9�$�;��E���T�H)ǣԥ�W(dS}�� �-��m!-���ڰ�yj��48�m����S�Ñ������?���      �   �  x���9�,7���)�-����8u��e��؆a>�I��=5�T���R_�I�*�`�2�LȷD�$��g�XL�~Z����LiNi$�Mӏ����_��Qb��|�l�Q�!�r?��L+�����=���������7��q%w.����E<63R�구:'�ĔK����*��ג�Ϙ�vd� .E�O���<��9j�������f��� ���\�k�{��Ц,gSW;���ĳȜ�����k��G�C�H�݅b���P�-�urb�5\���:�kR2LN��x3�-�4}���P.z�e����GX_J t`Ό>S�e�>m���w�E@���=�&먢K��C���� �̑�`hQ���l�݇|�/�)�)��J�C�"oJ
�Ny�E�
������9@����V~�j��DVux��D��!����29�@���Ɔ�
�N�'�hS���H�B2�z'��@9�H�P� =(S��P��k�C�� '�Uf#�4ƒ`?�/��T�}\����z��J�u}��=��	�%�B4s� ���씇v.��u&�@t�i8Hj�ny��-]�B���)o!P��Q�F�[�y���Q���!v�fݽ�''y`;P�vp\���.��`ʃ��;X4��s>l�s��M�@�F�<��>qko���%�v�gld��/q�=	=�[ t�[�g'��Re�[kO�d���7
��i5�(�<>���u��~_�/�sC�@\�%���)?���B� ��h�=�M!�>;͢A�0�*f.�_)\��
5��O`XFi����N�c�s��1^��P���SЪ��Z[�m��ld���8�1��#'�<�����J�$G�1���W7
!+r8+���PGh�)��o���_�(��LiZA0;��I[�([~}�t��[�]i���`�5 ������g�r����E7/;(gD�i�w�X�`ݻ�7� �X!p���ݮO�ʰK`���Fz�,��$�8>��c�Ev����F�.aSV���I\���fu��[�h)��+��Ԭ��붞��X��4�� �����]E��>|��f��pRl5vaUHv��=�X�fŭўɤ:H��-~y�֔*Ū�T�<^/{�fW{\�H�.��y�u]-��}1f)_۰f�w|N���B�XiY�P��Eڊ�e�T?*�� 7rϊ.!À�A�`�"c���U)}:̩h��5���n�.����!�V%�������F�.,�5�S���k@:_H�׎e�.�� mQ���@�h�����9g������uAti��AV�)n�Ðj�b.W��e_Wye���+�Gօm~y���9&(�$�<<�kv1�����C��!F��X�K���آ����{���A(�7
��O�n;��!��#�R����r�\�!v+3��,��U]���>7܃	� �#��U�,�vϊ� �O�z�-��v*f���]'N��)���?~�/��J����B��k       �      x�����v9����?��z፼�f=$�&!�I ���AC�$ٖ�d�jt���,K��rz��ZΡ��>�����	.�p�o�����ܛ�^�����o��_���U*@���o�����*����<��U4�!HյoոPLb|!Z��',>V[*���6X���ޔ�U�0x|b�/Pc�,��_h��OX~|�?���������x�\�	+��R3_N������>a��Mj��z��?�T�U���/�f5:�k�6�*�O���U��� o���r=�R�����E�����`�o0ln5�U�0l�(��^3,Q��򦚮���_��Y,�/X��_�	CKL�`)�S�-ԫ>a�#�L#�`�Y��O��j�OZbQ������������E��*F[�i�����xs�W}��6�f�d�%�jR�W}����^����'�7������f��������~�'
�֏,��,|����r�',=1*����i�7�t�',?qu�8�`��������'&��y���gQ�y��>h��H6rBH��F}֟�^��U�0�Ī�n�F_��ɴ��'ͬ��y��H*�<Q�'#p���d������^�	��Ϯ���ν!�>a遰F��7f�:��o�D���������y�bLW}��{@YX�ͽh5W}��e�%�k��� �q�~�2�O����0�b{�����,��C,n�����-�]�	�OrX�Ï�#�2�^�>a�I~���#q,C�o��OX{R�?]�m06&��WSF�XvO�Y����B�qg��O�R5�-�����?��)��9�MӚZ���<�V\�g�^�|�'*>�ȯtq������F���>a�`8��~ee�o���OZzR�(y��F�<v��OX~�2ZZ٪5Z�����OZy����-O4�i���m�V���7;-�?���tZ����|�\�@K�se�Z��,^@�݉�� v���U�4��$��D�x�'->9��N�.���9]���h?0����˚l����������\�	KO�+f�A��uث������+����	恗�!_�	+6� ���V��>��j4E�)J���}wP޾�!�N͏�>`� �2�+n�b����o�7y��SxTN��,�P��<������y��7f���R�>a��qIA6�$��' N_N7�U�����4���;�p��8�ū��Β{J��f�?�p��KW}��S�
���
u�hP�ū>a�)��LŎ�����}��',>e9g=|3,T�ï�\�	����;���S�SѪ������&8�O��M���Ե߂��	�� �yCMy��S��^�X+��V���է�ڈK'��<�����;s�i���_?x�L�U�j�b;tX��#8�ڶ\���S��������b�҅��< ��+K�	�V����j��t�h�f)y�ڥ-=ͭm��wi�:i���,]h�i^,$�}$(�S����.]h�iQƕ�v�pn����f�{���n!�{B�E>\u�y�׎D�i�=)ߚo����Ī�m�xS6��>i!>d#���?�]�-�c����K�����i�;�@���/�.?d%bp���b���A/�.����ٮZ�XJ�:�9\u�U��5��y�څ�h�����G6�!8�f}}K)W]Nh���r��҆��rJ�W�F6��kyP첊�%Q�[+\u�a[��~�]X��SN˱v���M���إP/�i?�'��Hy�����e����X��~�X��T���d����$��£����[�*u�ha���.8��~h����GQW���%���>�9���� �ډ.8:�t4�_Ϯdz9>:��F^@��:���p��h�^=��=h����>�����UOt����r��nH/G��o3��օ�]rX{e.�u=���u.X�[��#IMPN�/�~i���]��Ѻ!��T�F[��o�D�E}�������vՅ��T/_�A�Ѿ NX�p�.���a9���5Z|���A��C�Nuˇ������V����9��H�݃�r�Ư7鵉х��Ú�539�<��'�*"��C爲Di��g��?:�WOܿ���3�@�Gk���7�b��cѷ�V�]#Ν�R�cڌ2�z�t�������Eb/E˛�V}7]p�Q�&���^��2΅�,4�(��h��Nz�B�q����h�n�)H8�.�!p��'���/��⠕��8��5�N��C� ����b;�X��-]x?#�\�-%��W�wV��_������B��mܥ=ԘQ�t����~V�W]x��@<T�6� W:�q�.8�ȫ�߆���l@F�}���C� ��к��6�ss����s6qC�X�)v	��K�����	 bT���U�rҶ��F�=:����B3N������@�m�Z���(L��v1
���)�^�]ph���k�3L�8����C+Nj��m%�o�>��C+^g�h���E޻��i�.<��u��\�Q�*G�W]xh����D��ミ�"֬>y81�I���U�׃�-]xd�M��L'	���v�7V�.@���9��z�F�Ao�]xh�rI��M�`0��C�?x��C{�k�����+S����9�%��AoH�х����ٕ�#�Xp�)W]xh��D��_��$�������W]xh�y�T8{��x��. j��v�Y��e.��3�=}5���=��d��� �^g�83q�\u��w���F����Q�G�zՅ��Q�B�����i&�Z:�8���4�_�(b��\u��d�6�h��t�ՅFA�ʒӡk.���i���إ=���u8|�J�Dt��n���/J^~�횯�X�vNt�_��-Z�������U�8�~QT�I:�X�J$
��[���1ʲd�� �I�x�\u�g������l/F{�o1��u��c�<��#~&ag��U�EU�x6x��sk�ǌ�"Nr=�ɍ~Zl��=��❺ڒ��ׅvՅG���T�]��b��.L�j]p�Uu�yo[,�(b7�|���Q�2{P�y �L'�Q�O\@ϨU>g}>�����}�bt�gԹh��5۸y,�<Nd��х���T�����w�bt�k4?��xae���'���l���'�ֵ�y,iy�7��BC�hj����p9h��U�F[gi��C��~�iÉ.8t���N����Uo]xt�d�zW4ً�x����D�F+s��˸l����5bK��O X59s)-ǭ~�g��V�����9�6���^�𕮺�蓨����%���pՅG���ۙP/W�����c�����]�^���)�r�G_D9G>~>�d���Yh�^���F{�H=�g2����	ձ1<�}�`c�£�5����(�WYX4��ݤ��F���'����'���O����>��:Ua�59��d$8����ǖ.8�8��!�Y��+N��[���'�:����^�'������ԩYc��D�cE��_7�=��R�B��U�.8l*}�����qU���]p�3~���x���_q��V�t��{�$ȧK�N�E�����S���	Wx������V��y$+��h��%14��C��)χ��X��q�&��?*�At�T�p��o�����2�a�|k �>��.8��~��e���X摥l8��>�/T�fH��J�Cs���o�m{HЯ.9�K���t��G�u|��&|/����UzDX�=��W�u'Ǜ<a�N!�+j-�S1����������W��ެ�]�p���U��_�m8��.8��U���J(<�t��\b��h�xeѓ,o���?�zZg�z2_�M��bt�)�za����>=.�c�W]ph�Q��n�v��[j���C��*�d�3�GL�����H\;�b��C�ƦO����u�i&v���w����ß�Q�f�G���\u���S�~js��U��Ivl�.@���fw����0\[�hx    �������3/q9��t�ѥy=�;��BcM�Ot��OP'�aX�#�'���zՅ��Խ���D��Lsh]p������(!Zm֛,4�u��h�<��||��>�O^E� Y���и=J(�1��.<��kȵ{��X�;��/պ��9`%߰�$z1����V��]�j���r���7Yh�yae ��K�Uk'"?FR^q���2ap�۔Fe����E屽���M7�u��/H�+�>o4g��a3+Z���\4<���zx��/Z�Ϸtb�'P����"�`c����������g^�S���U�SR�G���6P!~��������t���p1[M(�х��WWyis�ċ4urۏ]���3�:*�.��i.�s�X]x�^y������������.]ph��B�?vz����������+��M�Ɨ8�[a����C����q����/Zv�诺�Р�:b���ǔQJ��>x��xBV�e��_��_W���_�eFU�a����6�㷖����e5�a>J�������O�g*�����
��`qK��:Eg��T��I�%.K����_���c��O�T�s�WϤ����ҋ�Hy��*H)|�p��Zal[�e�7�����6/Q�v�|ˈĹH�c�хG��-wJ4s��q�g��G�9=ǩ㶱]xC�MwOF�����o�����|F�I��e�C���M;v%]u����Z����Q��V߮��Ȇ�`q��g�u���C�Z��5�|�|��h����RUΒfg܅7ڸ�,௺�����`�	�b��O=��.8���v��M@.�a���>q��s��U��t��_�&����,J���UֿjG;6��i�T,o��C���x��&G�ufZF����|�������F.|��������]p��뺿��)#���A����_М�~����|'�n<х�����m?�L�@��C�hA�\;���
�^[�x�]����-<��p�D�d��O{M��v߱�,9�M�_ֺ�(w��H�f�\.r�t������~줻��p��tw�B�K�ƍʓu:u/W]x�D��o�.c���NWfu�'��n�E���_����хW��V��d�I������&�>���{ײ/�ء����i]x�Tc\���4�6Æ�'���9%e/��bK����Otk
߶�2V�3=�G�b,���՞�����Չ���/��瓋Pl��.<���S�5�2��">�U��Wq�[�F/�3��ot��'z5g٢��\(=���o��C��A}�c��{��[���;��o�ms���ˢ�W]x��D�`�b��t�'�ġuD���7�q��S���C���;�����>�׫.<���8�s>41��Y��к����sl���C�gt����S[Dg����FZ_p����U�C�wU�mtᡵ�v�Qyv��niW}�2��:S����b줟���%h��R9`��iw�;�FZKX�?��s��\�l<х�})V��5�T�.L�jhT��]uaR�۬L��ą�q���q������6L/�����]phѡ����ʇ��@��,Z/y�M�-� ��.<�O����᭎	<z���=D�٦;=�ҰT�v�'�z1���vf��qDc���Mp!���p�5�g���Ǯ���G%�V��v]xh~�q��U��דd�v�Gi�����z��.�li����@��/P_��͒�.<4�u��|9֏�،�Oc�'����CD����у/RL훷�X��G=�<6/%��ر�߻t�a�
U���=�v��t�9�u~>~?t{��^m��.<��p1�������0��`yl
S�#�������������C���Lq��:߳�^��E�"����{i�Py�>��f1���$�.�L��ZX̙�g��P��v]x�I���*��K�������(���Ss��s��)P���;�
h'���}���������d�|-���zՅ�)K�̆���U�؛����M�M~�2R���{��k]x�ES%�C�2ﴭK�.<�A��n��'���o��C����[��3���U:�:�L���"Ǚ�Ү���9�z@ v뫼��n�W]p�Y��;�Z ^0כ,0��mǦM=D���-}���kd�CW����>��u�kd�H�ڂc/(�s��BC��z���h|����rՅ���'�=�^{S4Z����?v�C�P�{iH���Քt�[��.<�u:�ۇR��+�� �х��Q������R(A���]xe�pʂ�� ��o@t�u�Y9��^������]x�Eo���A�bϔm���������AX��ebׅ�ޡ�Q��8������?��60?cڝ���C�(�6�'����T����C��}���~��OW]x�Uy���|Յ��Q�m2h^ޭ�%��Ot��Uy������w��'/��U�%�Լ\�N�����.<z�T{�y�/T���.<4��"+ӑ��Z
W]xh~UE���={w �kW]ph~U�E��~Yͩ���.<2�u����e����t����=�C�����lت'��wn�q�R�[�8^����p��=��3��y�{)����*\u��g4u��	�i)�	��'.�c��|��.�f�*׾�х���T��m�ܓL�Z\Ta��G*?[���� "��.<t
u����R��M���.<�V�ف��p�@��>��.<�ro�Ҷ��	\�琮���+��?_�G�s����n%�Ma�]��	~$����>�֝�w��3��vY�ON�`Q�
�K܄��U�������0ًq�x���v���piv������,��.����"���n��b��l8��Py���2�%zz��\u���Tեة(�r��P������R�˕n�x�iI3��,n�k�g�����G=�.!c�ng�qfZ����-Ye�n��K5��=e���BCC�Q�����p
����U���w�'�o�zՅ���SIǽW!�$�(�&�gU�C��ȟ(f4ƫ.<��ut���R�b��k �٫[u�(�)��c�.84d�޳L{���fU��w}�pt}�쓞Ɨ�qЊ�t����iв��B���,����+�z?8o߮��c�j]p���4��-������C���C�j�vk)v����+���9D��q��iI�ߺP�������={��"�D.q�
Za���|��^�O_��8���l7I]p�|��3��A��fgef����W����f�e��b��\�S�P]p~�rK��yV���' zF�u���:y���ހ�pl�8;~��C������P`?�y��V�v^�0`��ov�������l����p�W]xe�hs������:�5]��ŗ�{�'v�%\u�����֠�O�����.·��z8.�z�_���U����Q�����ׁd�j���E)�˽	g���.�4x�>"\*��,Pžo�g0��|%��.�2x��*�
�
�$,���Nra�>qRQ��]xm�rk8*�^�`#Ts��7ltzK��k����K���fթ~? ���9c2�Pé~d�E��ܥ.\��t�7/���.��ه�70u�t�昮�������v��0�B�wZ�Wt(m���l� >�צ�,8l`�ə�*��y��'�����8�7�}��8l`PcҶa�ƓUt��U�E�؃����u 50�`���^�F���4�.�W!��.��ׁ���R�As9z�6~��.�:x�-�N��] �A�.AҸ�	����O�w�G��[�' �H�s�b�N@^���[��H.R�4'-�f2��z�w�.u�%���c��:�|Dm��]�4������1�����CZB���}�C��j�ؼpzqit��cp<Չ�9YSW](�Fu���F�֫.�62��.�3�>q���� 9;�OB�yۨ�Uz@���}zܫ�zt%��Z��_�b�5�Gz    g���>��jg��O��>ū>q�䃤�zo��i�?igƥ�.<�xye�����^������+?]^	E2���Ɛ�����뽚VN8�76���;���$�ݟ4�C��W]p�qde'�p=d��x���F^�5%�fǯ򅨞��u�a��R&����y/W��۲K�$y�ȝ���xE�t��]z�z�n�gi��~�U�8:��K�͊�#�Q�U~�u���àO�z|@��B�O�֮�����w��ќW]pm��y��{��xt22��s~p�c�����M�lY��q�\��c����ǪS�j̤���M��(��y�S���KGG�N/u�.u##YԂ=�J�	!]u����TT�c�fw8WVx7M���V�nt9=�O��>�F��=r�~�����g�m�	l��%>�`>�?[��u�~ץ�h(e��vc��8׾�����eG���nu�:!�D�����ˊ�n��~d"����.����20�P�io��q�O^E[�!�����m͞�&>�u4��u!b�Vv[��c0E��������v[����!������௺��TT���.r
�ȯ
�R���h���n�^�/P5؀��f��83��^�?��U-��ct �a�W]p8�4��Z���Ш��U�8�\O��o�#)��L%�UvT�u���xQ8ޟ�C��.8t��շ;�Xz�.��.82d���F�r�4��i]phȒ̡:��q9�ХX�҅����.�ۭ.��#M�~���<ɩ+Ay��*�Eũ!��.��$������eK�5]u���Ө-��7=,�z�P_H�S�-ҿ�9F\�Y={�+��2a�O��{N)�_�t����ճ��_yd{����z���h�U��z��im��5\u�Ձ�6<�'�޺�_�:9�g��R���K�8\�%�"�aF��?ɭ~����Y����W]pa��׳��+�\C-1Rު׳j�o���7��m�_y�^ͽ�Җ��iz�4����ͯg=�W��~=#�C��A����.�:pc��N��kp\]0��m:U8R5�՚V��7�����w�s�<��7�~��ch:���7���C�_y����6^9OU���u�����kODős��w��������#�X�|��^�b�_�+5����5{��+���Ȝ`��6^M���W��.�6p�zv��G^$�X[�ή��X�۱49���7/�ٍ�_y��c�vXkc�#蔹�.<4�0kqNp�=�]ߤF�n�s���6&�LI7YhظA��Cc �m���w}� �6�n�^@i#c ��a�b�ö��T'��kr)��!��v;�w�t�\�^W]x�K��fn�^*r��ҹ��>*�^�F��b|;6�pՅGv��q���m�7D�[�ఓRo����l/�C}��]xh�q���s���꯺�Ў�HU�E�6_��o[��O.�R�W���#3�Vo��CC�:����r|���.^��CK��&�vE�˥~AL�A1��p��*G�?֯_%��q�.<����;sw��.�.<t��v��ߚ��sQ�௺��7z@X�p~�<��ԛ,0�"rۻ�4�9�W]p��T�N8�k��U:F={S��˼����U������4I6ԾK�� v��C�XO�Ԓ�2����@W�o���+@=rjìz��3ǫ.8t
Hjl<}�ďq~nx]p��Nm��^��Q3�h]p�+Q,�%�ƛ��f����Z��JE�[�ml~R�9�x��b�"�
�r��oW]x�ɭ�@v��돯G����B�jB���
�3��'�ÔԂoK~��v*.�s��BC�X�� ���)�4��xKz�z�$���8C=���U�FRt�пr)��'c�х���T��v[��qڛY�օ�αN3����u;]u��o��5�lB��^3x+Y`�3m����m%y^�v]ph�+ˏy[w���a
�O�I��P¡e�H=,������L�Ϲ�"Q"���|t��e�C��n�bp8J���-O�@�E�4������U^�!!�+=a��]phxy��
�0��y�@Q
\u����p��_(��n��.9����v���HO�8[��M��Ũ�<֋���7�r�'�a�\�g���ŠqJȔ���В����"U{,����t(_������c��!��)��m[E2 �'��А�oܖ�=0�ԛ,�<`㍮�E��C3^Ϛ�fM���Q����Ќ���h���b��@��#+�-͞��b<�v�\qd��gO?���p���{Q������[�)ٟ�t��K�@)�X��QdoySjW]p�UEp���"�p�\�0���#�����8q�%ȇ�.84�6��������K�.84b�b4��쵸^��Y�G,]hh�U����r��^l�c�eu��W�-p��o�*���GG�U]�5�N/F�WݛU����V�2�)�(��s�?v�#+^�G�����+�������W�Z�'ݳz��ǳ��Њ9�i$ӫ{�FN,���jk�t����Ilw�~�ũ	�YHQ�D�De�����]�������8�'��C�X�C��Ԏ��Ueu��c4�b��v���m�F��M�*�w;.��$��N�QC3��nŅ�i��ް���)8ш�>t(}ao�������1�p�S_�-n�#��q�Qj���!f�c�.��d�rz����3CM5ū.��d��z����V�����<�c�F�O�[�S���I�cu��';u���Q9'��ET���'��WY�=٭	g��3б3��E�,�����UhOv���r��mҥ.<٩g�I))m��V\|�z������ �k?�҅O֯��Dӣ�t0���K9�:�-��ƏH�OP�Յ�������[E�}6�.8������������Z��C��+T�kדk�Z����+�r\=��8Z��h�^%6��\�?|��U3y��CK�+�L�'\�;����В}V���v���[k��CC�+�M�v\�4}����*���g���ƫ.8�;�X��F1����-n�C��+jئ�T,�h��v��vٜ��e��q�O^�9����^��(���<\u�!��J[R�^��g�M8�{�.<��AK�G^Oi�}��MY���w�}���qgk�K��<���C{$�?�^��Uv�A]����z9�������9�[4���_�7��3^u�wp�  .-2:Xs�7����'���;��9v��4�vsNW]p�Q�`����#!��>q���Q]�I�ڑ��7%۶K�FT��x��s`������^E���%>+�\u��%Guj��~��Q�0�������+�SHY]hh�q�@�6�q�o�}&�FZ�
5����o6�]#���X�x���׬W*FY�l�{g�~�܌�jTa�V���Vk�S�./��Z~�W]ph� xeۘ�������Њa���=Ћ?!���Y]pؿ��G�mV��q�Iz�nt���Z�T�&���(�I����k�R�I�(F��oiNt��ၺ�m��{1>�\8�����`E��z���i��<a��N������Fs� 򒯺���֮�����8ˏNyku���%5��C��y�[�V\��bѾA�3;c�Pm,��<}�o���G^�y�u�áW$ua�njq��]G0^�u���i;�����C�X�1�Hu����&�`1���/T�ڇ1�N�fC����3t`E�{�x�'K��gF��
������r�Y�v����7��,�{��X��PEϢ�.8��ƶ-ƹ��.x[]p0p|�#Ӿ����H����2l��z�ȇşy���pf�����<t��:��~y�L9���@F�G^��|���w}?�lt�{du�q[���%Y�7/�>xա��,㾣1�^,��U��J�BQw�B�^��X]pa�fk�ӯ������
<�dUԊzY`t�d��r˶��n*��\� � ������C��ꮉMI����׊�_u�{ �  ��!G��ndj���.<r����c�����-]x���71
rDZ��y�pʘ��j���7:�|'�O�������B����̠l��~��Pdt�Ł�?�h{?��9z2^�±/��o3�0���5t�s���7W8��i
%,��X�������ЭDN�W?wC�.<��}�Ϙ_W�ډ.8r��	T\��Q�'�.��-}�yEU����#/Rp.�U��
���Tq�ȉ�m����/��O��Wr�RI��w��CǨ��g�7��q-�z������f7F�k�c�Ӫ�ʌ�[�f׺��;�u��%6ϯ�>	i��׺��=���fr��8��^O�CߨjB�v=|>}�X]x�UFܔ�c���>��V�<:v�9��g�n�b��h�䓳���7���'$�_j���ڥ�\c�ج���|���j]p�m���.�7���4�C=�e��G1�;���.8�ֺ69�(�I@ �U�E[4���b�ƪ/7Y`�=�oƳ�ޅ��U�ES7��vL�-�纉Յ�~��������M֐�>y�~�VR�zZ��� �m�.<t�V�.��G������3�JG���3Q�\u�ŧ8����Ė��G9_u��S��+�T��x/�yfVZ`z�j%�ŭ�'��_����0?E����A�λyp�����St"{ZՋq�?�N�邫Oqi5�[��_��=t��������޼?�p�W8f4���{A�&�k�⯺ � N�ػ��x�)*�M�{�qH��:���CO!���L�S��5���=Ԏu3=3�F�OJ���Ҁ��\۰��«|\[�܋�du���BC�P�:ٺ�<�t��ٺ-]p����j_2�2M�@�]xm�ft(����q�����۸$�)�/Y���N�Րkb|�X�p����'��M�S�^�bKߨ�X]x�*�7bz1�ԅ����7��c���C��+�5���'j�[�.]p�U��m�80n�sh\u�g������x��	q��U�J�]#�`���r��y%���C�P�D������7�v�'��o�h�XN��J���pՅ���S���ݶ5/�ttg�~���#�sfߋ�r�m%]u��o�kv��D���*�C^V:GP1�=�Q�b�ߢW�F�FP��hw�z9N��xft�s�d#Ş�fZ�~p���t��x�5^�'���5T���:\�G~���
���p���?�*zD�HQ5{�f���d�V��Y�C���C�XN	���B=0��������?��#�Z�M��m�`�=bEL�f�|�b��;l�vK:DTW��"���=ū�d��;���;T~d��^u��;�3�l]g.�T?o�Z]p��ej�oދ���h�knঝlG"��/��}E��l��_u��.ܜ����<�P��콇^�p��'��`��4e�g���~����P�<��<ի.�<p�u�,�W��m�Dϊ�|�7Y`u��m�|~��_�Z�CE��|����>p��r���w;����n���D�B��eG{�����T̯�cV��	�w7����ͦ���_y�y���[4���H�mt����av��+��b�y�6���Ѧ"�2���Ky�~L6\�pJ-خ���/�t�<��g&+p�דE���\�X7����Q���gp�b��`t�@��ܬ�����C�Hj�g�bg�.�=����=#�|�n;���29�����BC�HQѬ!s1:���0���-�z�ڞ��R�4������^�Tع����vy:��z���+7z�S���C�HYU�nգ;���P���)�:�3�${�ȏUU�����p��]\-W]p~���s0��x�MUo�Q�
��0��C��o��!|���᭡]u��S��J)�tmQ �Y���n~�����C���/;�Z����W7Y`e�f���4t�U��vm#���gdt��Sdݟ�V�����כ�X����Ub�gۜ��E�t��N!�o��n�\���(A����C�Ȫ�}�htF�r�F.�: ;1��x��U�nn��'��� l�PW8��h�+,�\T���o4�d6H/ŷ!��.�:p���ٯ<���Ϙ휾\�w�ޚ��-}��[���l�.+~�S�9ٙl����'M���>���|�ϧ}�o�C�艨8@�ދ2��&΅����8w�9�o<��*A�ZW�ӄ`qKٲ�T_�S���}d^�FIgu��-�I�	�C!�#�V�����=���p�Zy��H���`���n��x��*�D�b�.�΃�-]ph�+�.f;�
3s���\Z]xq��<'���@�CkP�/~/����,n�+7����{��U��m��,㸂�%^u���Uq۸]�����ӿU��X}��෮���fG�咣]��U��zo���S9N?� �_uᑹ�ų׊z9�Bp(T�Z]x��Uu��i���\u�a�W��~��^4e��BC[n�V�y�������W]pe�f��T�xh�M�D����u�\갺���Ͷ����uԶ���l��(��k���t�aO�Ե�t�5~����d��g4���='�ܡ�_�t�g4���||OF�z�҅���Ե[�7���-1_u��c4������;}�Z]x���-�1��Ȭo5��u�o�g!l�%�˜�>w��.��T�|�.G{����@�W}�p�N�;�
sj[Յ�ꖳ'f�8:$�pՅ��2h�f��F9�X�[��Ou�x���h�*0��օOu�=�}�^n&���BKO�/��ۊ�@�_o���O�(�1�/�zf/H�ky���[� �SW�_�6��(��E��t�9��!�>Q��?�gX]p���7�)����7�ɭB����Z�2�����ȉ�>o@[]���!�jR6�b�X�M:�Ӎ�q�^W��B��`k�t�wx��!��:�Do�������b-�S�B��]���;��F�����< �ے��K:ǿ����v�`�>=��O�D��w�}��Ǡt�U��MS9��\��\��� �;�Z��uy/���<`ޡ�֠r̙�(��W㍭�]!|��C���;���N=�T�ꋇΡ�ڊ�ģF�׀�U_<���V1��F��w������#�f�ڽ~�'<8AQ�^V_<�W�~o~�}��x���j��r��l�D^4�PU�4NJ�c'V_<t���Ϯp*��/�F\K��׋<��؊�����c�L�/��π�O�C�/z]�ʍO��2����������m
O*�cV_Pt��ա�6�/PJ	K�z����}h5�T�'�P>7ܬ�x�'t�k�p�u�$��F
m�����,t��Cu>h�u���=�n�	��FIH�����D��U!�,<W������u�Mͤ���h%o���K_<��&��ϕ,<c+��p���+�	�PG��7h�S��U_P�"�_>g!����}Aы@yvKh��.�3����C >�)��\u��	���xޯ������H���Eq�N�uŶ��	�2���W�ct2L�/(��+%J�}��˄����/(�4�X)�ƥhm��EJN}�x��x,��@qp�+
Mך�>�
��K_P���Ͽ�4�ы~m�����ğ��|�����(��=*��N�Ť*��[������D�����ytG��i}AѣRV}���7�v��7����G%�L��h�<^[ӥ/(zT�
z�����W3�h}Aѣt�I�����ҷ~��x�L٩�}"ƹiu�\��pL�Y�p�kڞ���z���xh�Y%}��D���ѠN�c��CC��!�m�MW��}��ꋇ6>3@U6�(�`c�W}����b���w(||ty��%��-?*6g���W�R����R��q���xՅ�}��ͱ�e>��_�wʌ�hdx���B��'ߟZ��{�z��^����������/�"e      �   �  x����n�0���S��L��Q�N�uQ�r�E���PY$9�߾+�	R�FA�|3�Y�<{8���e�}��n��@(��:�<X���X�3�7���ǿ�
�z�{�C�]1;���BA�����5��Ihx�j�����ku����M4ytFjȹ�lե�DU�)��3����*��Fk��\�/S�������k��R�n�S�,��Q��-��z��v�7Τ���W-{�}U��Ɓ*�.����Z�s�-�m!�m�N�b>�l���kb��r�)�2Á����N����E�WZ�5x�Lࠧ_R=җ�@-T����� آh�i��9G3^��>��u�$�������L�cmK��lU�=6;
r��e���@�-���vb�����e�"o/3�s�l�R�jv�{ڢX�o�m[��'�X��?��	(�T�qpl����+�}+3����I�n��}��h�J��_����      �   �  x���Mk�0���_!�B�����ir�B��"v�Đ8!V��Xn�ekuA���wF#�ǡO͞��ٷ �1Q������������V�[�L��Ϭ�
/���Sl�C�ul9��$~�k�L�15G�E=�,<����jX�c�Y�ZA?��ջ�>�;�����N�1�A�,w�X�ӄ��*��2��HM�(n�s�{��x�QlK���I��as쳃/�|�b�� ���teT~m�md�s���z����R�<K�hڎ=Ĕ�����%2QSg+������b�!�i��Zɢ>�$5{f�H���<;�QuQ�x
��ڌw�#l��E}�iX�2m5��?DjK|�_=%����7�H�e��� �;��A�6�^��s��D�ySgWD�T[��12�k{�O�S�o���TS:H��5E=�^xUU���      �      x���[���qޯ����K�>�Nٝ��xvf'�CK��Bl�"�>�<M����8+�᙭��%��X]��?-�x�p��>��F�����?��^Y�*�5�����^�2?҇%�Z�j���S^��ʆ���� �����>��~�sM߀?��bK����a}e�+�V�7zF��K(��OX_����5�8����G��D�����%��f����lZ�+�.���#ʫ)�ز�%ϧ�����xS����Cy���T��4�ay�ST���s/9>�#}Zlt��ϟ�?���?��*�Wί�FU���/9	+|\�7Ie�W�ȋ_K�.,� ������&�2ӷ�?(�Wѯ�zU�.��_��#�� )u ��2&��k��F�U���9"?��� ��d ��Tܖ�f�S�ZSN��y�{Ĝ����1O�b&/>��o麷����@>.����(+"I�cY1��-��/�5N�a��H��VUu/0�D�#�����I�/T����ж����}��s������¤	�����ĭ��|_;�E���s����u}�� �������4�l@���n����?�Y����3Ћ���f�CK��G||��% �$&Zf�az��ҧW�JHxU��ey@t%�g	=��?�����x�hV�j]���}4/���C��cz�B����U�%r])/}���$�4�d�Y)��;U/�X�����% �-m�_<�������.��z4_5&�"�|�K��޾q�z�^9����tD1�i�S�����tIx��Y`i� q��&]����"1�����#�G��N���{y�5D��5֒_�Q���b}�L�_	d[V���R��/�}��q)1��W�3֓e@�#�Iե�
l��+=s�Q�v~���Mz�d������m,/������S�ZN�J�¬�5^��,�	2q��aq)nC��G�Y��Ҭa���s�'� ��&/�l��X�M�3�ْ�]�2<����싼��'���Q��+bH�|]�з�:>	L�\~x����^��](i҃|��f��C��%���8D�xCF/�.���^�݁���N���z6ѥZo@��m��6fU�c:��T�<��↭r�u��`� ��R#��Ÿ�f2֕�K.N���u��������O������!}@r�>S�H��8j=� J�<�O���5����l0�z�Y��j����u�Ҭ�n�8Y�AC���_�bm�8�����8�Uua%��eq΄�ɞYӃR���e��� �ݰl¨"yM�q�+�B�I^Z����1u�<X2����<��J���v,���q��Xh,i�7�%�:X���QS��,������V�����~�����'��Ǵc�d�e�l��mҁ+����?��_���vX�a����q$?�U�>��o����/���o��y6p�<6(��٤���?��0�<�0���|XИuĒc��N�O�+����I�1o4y��{�U�2p��:Lu�Jd2�ԩ.f;�nz��рJ�l��BP@�L��?SD�ʤ5g������wK������|p������\o�����ʀ�XѮ9$U�㱾-�Dǒqj�1ePu����Ň��2$t�Vz�<����%M��ʻ/�+MV�V��\�4�-��t��6�TT,|���R��e9�-��^]��^R�Y�Ɉ�����u����%�[������:t���ǥ����p�$�U+O29���=�� Y~�&���e����̢���+v��<5W���yj��<U�Υ�_�5׼���:taUxj�,#���hX����<m����ַ�]�.�d:��vzb:X��c�c���k�����`a���wV����+㚘T=�S������V���Ê�ߖ��wh�6N�[��� ^��/��a��~:��<B�����]Vuy:+MWƲ���T7�������N����W��F1bliǎm�	��Y}'��8�����8��3G�0���KpQ2�6F��y��I��%��t�Fiױ"\}��c�I��e�	H<��m*�+"Е����F���Z�\�2}Y|䆆̶���k�9�Y�4a�*%.z'��$/(���2��S�2�B��FH�B��)��`�
���d2�1�%#�	X5�́P�S�X�J��O�4�X�n�-"J�N��D��k�E��	+	���ן���_�ˇ/��۔I�YN��oe��j��u\����3<6��zt�8�qVsᴸ�ϛ0|�0�/�jp�q�9(���'�4\ќu��CCb?/�[�!)x
i���M:a�E�OZ�ی*�j��NX�`��U➞uk�I'�4X���,bL`LRu�АX	�E�e|�꟞���һ�����f��K5��v��k���dU'k�2�v�(?ӳ���ܰ�<���<n�S> w�E���dU��m�=����vb�2F����o���Ƭ<�8�8�D����Ŧ��1�9����X�N�˚!��H[1$>MC'������ems�a>R��Y'��̃�%�w�f�u���aV��mgq�ء����+��[� ;�՗�˺N����K^����l�����6�r��}M�~^:��ꄅ+Q�h$cc���`�:a�hª׭�a:d@;�Y�	�P�)���X'�0�dU',7Xr7a�\�P��V�HFZ7=6=Wo���u����Lw�5a�Q���X���7KLQoejb�e\��t���*�ɼ��~4���:a~2mV�w����gN:aa����ddZǉ���L�rsأ�v��:ap�(�Y��F�����A!�:a��r�JԌ�*�ƙޤƍ��2eѦy4
�E��u���.�kkhͨb�����6n�j㸧jH#�&�M2��t��MK��'֡�,��o�y	�\Tu�B��X���Ul�̪���� Mc�iy�j���q��~I���2���A��-G��������<��dΚU�����X��3��J�mf�!U[Bb�Iw�apK=k2P����$�n�uOid��Y]'̶�z�7�ąO��ꃪ�O������RƩ�u���_�/�(g���Q'>���� ꯿p]dZ}�t�r��t+X����8��t�J���LzFi���+�(�X~�����q�?L�:�.
�[d���x�*��R}�:a��A�L[ۆo�����N�k���|�QY������V��Q9�fq�LTh�Z�2�j6�����Q', �\�Ǧ���	K���*��3��	˭�A%�n����d'�0z�'�J�c��nuq�u���`ҍ+mY��VF_��:`�4X�ڰ�U,��y�񐉢����i[m��"d�8��t���{��pX^�7�u�BK�+A7#暗qkm�	���Rՙ\�2�%��ӷ�:a\~x�D_�#n&��"�N]�_Yi˘!g^t�V�	+�j��f�m�2���NXm0_��[��2��3K�4XHAi3�Q��{U'N[�,�De�ٌ
��B�N��a��f3�MD����0�ô�a��֒��u�B��I��<�Sߤw�M8y��I;���sWf�b"�����U��cd��l�C8�⸛ŧ�i=��~R�?B��S����%�T��u¸���b��Ғ���1E��n��@�����W���Pg�0|�@ǽ�q|�R]'̵�����fT�]g_�:a\ϐw�����?�uؤ��69D������OE'Mw}�xg�\��E���gv�0.A�[Ji�Ƚ���(�:a��L��~���1�yb�2Q�
��Gt2%�:`.k��Ȃ�مWܸ]c��Nضo���f�^��f�T�0׺��U!�T���+u��66U����Bב��Ɲ�����{���֔�;��v�'m�%�4��k2Qik�r�{��lK0_U����S�i1�<���|����{?s�N�̎�u��m���p��/ޔU0$�D�&�&�
�(�s*դ�f�����#�2����:in�Ż�3/ެ9?��4��l�����٥EU'-���/�zlE m-=���Z�_�n�ږ���`����v�]�    ,�bk����I�͗��s7�	n����V@�_�)����^ ��蒪�VI��8��(-X(��ϪZ`,D��M�
���yyc�Ic,�_�`�>L`���J���i�IsM[HH[�k�E�I�-����̘�)ƨ�Z��E$��i�1��Nӣ��?��Uu��F�Y�nV����:i��ȸ��٬At�8�����X��\�����S��4^u�V~��i�0^�ZKIO�v�Es���/M�6���x�Ic,Xi{k�{y.���<������轶�C+�L�ڤ�1�W��y�é�ո��v����!ѧ�_�9<�S�;�1d��m�✫y�Q�:i������D�*sdu�4�B�����/E�9�.N:ie{o���R�S5�y��]'������]k)�4!��l�Zb,x��h�ش�<C���M�NZ#a��m�6+~��f��:i��6��� U�����:i~�媷�<!�9TvE�Ik��[���jX1_��{��NZ#a�2�q
+��Vk����IK�ȡX}1ֿ�y�z�Ic,TyoN�F�*�*�`O:ieq��/} o�뜝�[�I�8ȊC�(ޛ�;pd��Q?��4�㮥��r�YK�d�,X��-�#o)P�TM&�,m�)�q�c3��NS�#o)P2��c+>餅NS�*o9P2R��LV�,�kb���X]g�I˝��@�<����U���iJ��
��:9� �U;K���	��:h�4-�>o�Lb�mUuҺ�j����_�gU'�{�ѽ��&�m��NZ�\�(�d�.3������=W[�iV�r��v��N�}�k'2Ψ��:i=�Z����Z�p�d�8��-�v��|�/:�q��# #��eU'�v��y���}QuЪ�4�?2�2F6��v��N��N����{u�\���Q8Ë���I'-t�޶1'$")g�u���w����c�v�i�u���w��7�<�2���NZ鴻��Ey�f~���V;��+f��v�B���7um okN�~\r�N��4=N����^�Ic[����t�V�[��F����|��,�>13���N���b�+���v褥NSiq�L�M&+,m�یJ��T���ij�b��`.;U'�v����x;b�~~���f�AӣV2v�*�L:i���ޛc�3�����:��:&�s�v�I�-�1�)����N:i=�:v�U�	��D;t�z$h��b��7�5��o�NZ�}�
������X��G�T�/>��'���{��ӗ}ӽ��pN:h�t�eK�g@�M'�𷢭������&U'��f�.Q-xP��j�UX]Tu��N�Z�۬���ǯ0��N������[oU��tд�}Z!]!�v���LV�,���/N��ÓNZ9hZ�#����Vl~k]'�4-�lǌe�2]�uм9hZ�[�Ѩ���/�:i��t�(�K���:i����Pؗ�Ģ��N�j���&��2�(�NZ�����
� e�VU��	�}�a�(8���H�<�tX�����I�p9�ܭ�Ey?3���X�\�<�2sZ�]�g�н��7ݭP�Ѯ!���uҺ�^��V���M�7�:i�{/�=w+�GG=�X�:i�{/O
4+�@A���ƳNZ������
��p��Y'�{����ʷ�:i�{��MY�$��xܳNZ������*�����u���{�e��a���:iGK�/�Kv���%ο���#�ev�*,�T���vĂ�!V<Mj���Is�v�/�V���"�:iG,�����j�}I�I�v�K]ۓs�LV�,�?P��<úNZ�4��)��\*�o����.�:v�83�V�Ic$x���<��*�l�4ӺNZ=h�c����0���נ�uВ9h�� �����v�d��;�̵�`ST�:i�]��v���u���L�?Xz��v
�u��JR��K}���`�P��Y'-�ߨ����gT���ݳNZ��_��m'Nz$�ړNZ�4��oubXf~k]'�����♗����u�z\��w+��f�5�:h����nu��[�9��N:i=
.O�6+�u�(sO���(�\;ڭp�,%S�u҆8н�u���ϊJR��{.g��S�EU'�{�>����79zU'�{�>{�L,Gf��g�IZ�;Zۃ�a~����=���`�
�#npO:h�{���a�YFk��Q'm���gK,j����=��T�a�K2�y�v�Icg�m	�r�'m��������v��:v�*u���;��NZ�h�]�~V	k�k2Y`�W��2i7����ˤ���d��/WSv+��y�c�6��}��R�6�o�X#ׄ]Qu�X�<~C¾�mͪ"�#��UV"G��x�b�[9Է^mp�Nːۏ��u�l2'�8m]U�4V׍o����VȭE���l]'M�p�<��.w�U��@�O(�LnaN�yki/��4�������IE~���$U�<��o��ENVK��-`�O���b�6��{-���ZT�4˷�"�7�^X��zE�Is�n�ɢ�@+Ϫ�=��Y'��
G�F~?=_���u�"h^"�\f�5���ˢ��Su���l�:�d8ūG������)#�f�F'u�Joz��A��r
�NZ��vGs��]n�u4k�eV�a�t��(|�I���w�ژ�V�5��{�:i�]�/�V�ٜu�G�4z/��]�ح"/��n����zd�����.�:i���Xh�;��:i�9�H!�ދ
����e���UV��+�~�����;U'� ��,����nxۗ�a�LV壡�Z�w���`��C�ʨz��Q|���,��g�,�~���e��n�˸L?鄹���}Z2�+5�:a��)�q	W]���NX8`�(w���S�j�	�L��b68B�����Oa�(��N�u��ط����,YΦ�:a�x2%6�v*J?���`?��\�6�����U�,���~�6�5�N��I'��,�����LT�,z�_n�����5���du�P~dD�U$��T{�	�[��Oo�'�Q�o���&��r�� ��6���I'�0���-�=�S#{��
��_?�W}�6l�J>�:a��)�E܊�cW������Y}�������ɾ�㷻����Wt&��p����:�ֵ���x�����Ȓ�����X>�@�N)e3?Z�9�ؑ��%�ZA�i��{�b8?Zb�T���)9�V���P�YP����y�Gs�i�ū:t���ѣ�
��nM�c2Y������*������=^�F�I��x��2ː����T~�8{�K�������x<��Uq�)�&��1��ۤ�%��%��,���2ܔ��e^�fI���c���ґϿ����%_WDݭڞC��u�4y��x���?���������K��.���lH#�>�:��lw�V{��zXe,+���u�x�b�"���:,͊Q'��l����K��fm�5��q�KRu�*hV&l����Z���ࢪ�����%xmY�Y���s;z���yAY��T��m�{��qQǽ�\G�"�'EW�V�$��G���ӝ�nzIؖF���������_r�2�K/̉���Z$�������5���K�ut���Z_P�I ��H��ך}
7�8U��}���� x�~G�������S�Xc/8�wȃ�~�s�̖��|&Z�H��T����/!)�ǭ�ՌC���
&��%:'%YQ��{�3�4j��'��2i���6��u�*�����/=�2�W#�qF1��*���?����ϟ��_^�ן����,ؕl�A��$�
�˙�����5yMf�P6��}L�ik������ӬF�����v�tq��_/��e�"�_�:aq�1�o҃5�Td�1��o��O����z@�<ei��~B��C��Z.;^m���5�}��.�V(h��<��NZ�ij���%X�ʹ��7ZN�g�w���~AӳNZ�h%i�zi�W\6ԙ�u�ep�f��H�YfCK�蝪�V��;���%x�~3�&�j\�+���n����GVU�0�'�����O����Q;�Iӎc��M�ϴ��U�0/0�n�岤�n�j�Hc�a]',e��ҝ������FHܾ�u��fЎ��Տ	p�NX��U~^ޮ���    'A�N���(({Y�d7
�c�cO3��Y������;��RU��*���'�1��c�iשׁ,z�ϸ�A��ڽ5(P<��L:a�|i���f�u[�p��d�:a�|TVJ�U��vY��_6���뇥D���e32Ʋc�ϯ��Y-��F�ٙ��O�u�o^~��������O�a�ܪ�6d���Ə;�`�k�!���6	��) i�N�Ǥ�I���5%�>�>)k���t�����"��6�#0Kj(X����g�]V�!rLn��h]�"$�뛤ܺ�,�ҹ�ً�N��W����V^3be`�nM�2�����Ѯ+�VX�GΊUu�.��eY[���e�֮nܽ�t�"h�3���͵���C�t�x�d��d����JfY�u~�ܓNo�_��/�9��i&�D;t�
h�5k�,u�:28#=ӺNZ�~Z��׬�1�����v�_���*����T�4˯�Ӓ��s֬��V�}�Is�9�u�����Ĥ���٪z�n�Q��U'-���˭*�F�<q=9� ���hYەת0#����Ic$��KQ�Yu�WE���i2Y-����Ov��Û��)�NZ���2j֖�����U�4�A� ���;Rw�`���Su�<�@�55k'�v���
ɳN㠾�8����,�~:{3�1�G�.�aU��X���u��I}�Ye�$2r��:i�T�ʗ75V��i'�u�	2���u��3vM&�q`?.�\��8�x�Z�^�I�H��ӒÍ�i�%�y�u���L����W��:���t�I��e�]5��nGsq��Ԇ�:h2�Z}�d��3��D��Ŭ�Y�d<c��_V(m��:{[�Is-ݍ
�t>76�y����E-��n�v���@s���SFuKv���Ω:i��&1o�{��⋪�F�u�o�U�v+�B��zU'�nޛ�ގ#�'�KO',&�H�e��{�*�<��U�I���o��.oJ�2��x��8�����n��]�}Pu��F+�W~�V�5�r�����d�V��v�����l]'-�_z��pr����F�IK�"y��a{X!ys�q^$�:i���?��cTˋ�pN=$U�Dr���&N�	�Uu��7��:7+�c)U'-����)�*� ��ͅQ'-v��42iМ7�'��tдsشB�B^��߇L��Ek�V)�+d7?Y�I+���`�e�m�a],��u�C�͊��bʪN��T�eY׶Wǻ��9u�N��~h0�zl�r�W�9���{��
I���4�:i����͊�K�c�N���˂t͊7��+�I�I\W�I�l(�j���Y'-�R�U䞢Vzg��i����b�?���[���F�^��7$C1N�%]�z�d'Xz+r�&�b^;y:�0������_e��,o5+���3�����&������w�/A�I��y���T�V�R:cfZ�Is�v�'���d�}��(k>��e�M��꤅�v]/����=�6�ߠ뤥�ٔ�V�u�ųBRu��F���&��
��W����V���ԬP�%���f����Ҫ��7��3YU�����ts��9��U�f�i��R�r�Yy$����f�4Z@j��&�YefN9M&�s��]K��Y�6�C��ҺNZ�h!(���*�����uҰE���C.�C~l;�9U��k�^�	K��vI�������_����������Q��7"�N��U�:�pܬ���f�U����U��B�{�m���y3���NZ-��$rs���v�BK�!���.�+;Pb�����`����@�yo��m��N9��N�w8%�Yy�*�<(9����|S��a��[LRu��~2'�Q������?��ߒ�'���xc]ͪN�MZ'��dܬp�l�d�Y'����9�/�ޭP�$��FU͚-�JQ6�7��J��>���F�M?I���[ETF���t���?/�(��<�eNY��NZ��w���e�[Y۪�δ���K�,Y�)hV޷T���1�D�u���*�tڠ�1���i5u6+����U�4�B�y�����\w:S=뤕�E����y�,���Շ�����"��O�=�n�<>:ћu@�������M�G���e�Y'MB�[�,Y�|:�䐕c�~�Ώ�I�ɶ��O� ��5�o*�	-��MHCnƬ�=h�A)ZѬ"W����I|��.��a�b*��
0�dI3瑒��R�F��Vz�q�f�IK��Ϩ��?���G�U����XI��X�� �z��nN:i.�ݼ��u��oc��NZ-�Ž�/�M2��a=h�AC5���W��m;!��w(�1�a//q��k�B�s�X�Zs��N���]|R�˚�ג����AK�
kc6�V���'����VƈD�^$�;�==[�I��
�`�^i�����I'-1}מ*;��
cS��:�Ү�����+��خ�UU'�t��K-륗����R�(���H���y��Uu�Pٳb�d����m�?��]�Y&�G�M��w�W��o�H�IsM�ڳY�Ґ�1����T�kVȥ��Uu�B�)1�r�����1�����f�O���I'��P�/�hk��J��}C�ì��7�Ug�͊�����2�1ʏ�+Jv�eťVE�L�Q'�����S�f���Q:�E�����~�j'�澙�u�2��F�y��{��vg�4Ƃ̷�:C�֐���$�3���f��<nƋ�N� wgiU7��ڜ�{v���iJ�F���46�g��t���G3�}
�;�:i����~�_wD^m���E�Nb�Ļ7תh�8ӺNZ=h�L�Ye���ߺ� %���u�Vx�g�R�N� }Z���Ѭ�4>f��:i���(�(٧Sn����HH�/OɓlV�]�g�:i->,������t�T��	oQ�Y��5+\�W�NZ�������������O�NZ�4�s��LRu�J��1�5�LV�X�*��,˘9n�֡>����	��H�o�s�v���N��4�w�|�(oU�4wД�S�
5^�)�u�I����������:M�]��Ŋb�d�bg��Z�Ƶ��l����IK�v��L�N-�����r�y�
8����C�NZ�4�m��1���h�NZ=hJ�B�
�;lr���r���+�a�����l�LV��oDm��o�g�����뤵8�q/m��o�Q%=xU'�Ł� �=������l�N� �G��{}_M������ku��N+ڌ�Vܔ�Vg�u�����D����1a�Ǭ��}=�*9N�U�e�q�:i�]dZ�s�Vʌ�u8�PO:h���^���]T���>��4z���$��+�"�=��0��{��(y��
���|��I���OKqJ%�ͪ"K>�'ڡ��r�����l�k�Y'-4�O�����hg���Y�4�V~8t:�僦��6+�xc��&�NZ�4%�U�� �딓N#���]�G�[yV���'8daec��Y�_�ϊ���2YG�u6ڌx���o'�4w���v�V�ի�|�Y'�w����c��~t�I-$���q�4$U'-4m�=�N�!�U'-m4n"4�lZ������乴��٠�:.��e��Ʋ^y���0�0Q�Ik%�>,Qy��6
ni�V�A���;��d���kM���:iv��U�-k\D�O���N�����h�l�
)n�3^�N���YR�fU͊w&�q�p�I�LY�� ����y�c�1�1
��%%mM�YU�h�w�IK;M�w�YY��4���u��AS�7��SIq�WM:i��n���T���u���iJ�����;�41�9���=���*���e~���f�7UZ������#�N���T�������d��d���F,�\�I'-�o���¹?��-�N�	Y[�l57<��kRu҆H�}�w����Y�I둠��V[�5��!�~'ĜN��:iC��(*�;�!Ͽ��y��CY�J[�n�U��g;t�l����m�!~���N��1��A�jY�,m�Ik띯���5����3�u��	V�����N�s�NZ<vH��@v?��������"���[W6�v�ȸ;7�壸�6��F�����O:i�ikm�*���P#x�I����Mi���y�Y������|i��L�=X�x������o\�t�\�� 8  _���F����r��Zl�n8��o8餅NSz���U+~`�Uu�b��z$p�.�m\��t�R6�+����⬪�6D��m\ϑ�o��u�z$(�x��F�Z��������IW5��c�%j�@ȸ1̰��������J�C�{/�O��g�4w�n�r�׮�;U'�4-��Y1��L-Ѩ��/�{o����Y'-�gSV��%f���I'-u��u�J�*񤓖7Z�� ���*G��7�:i����ơ�T�`�I����{�8����޺ڶ,4u���Ƶ�V�I�ͩ���9s��:i̤��,��w2	C1PgX���Ґ2��T�dh�B<�(�Q3l��ca�Y���K(59��rd�y�p�I�ǻS�6��Þ묓v�CQ|�Y������Y'툇��Un?]j��R�Y'�pᐬ�c}'�����\��u���d@6+�Iڵ��ꤵ5�o��J��f���δ���;M�8$����U��pД5�͊��XST���i�-I�rY%�T���Ӝ2lV޴*Q�I˝vݒ4��� ����u�J��Xn7����u�zye�f����&���]K�]la��JJ�N��N��mV�U{��Z�Is�v�78�>f��鎤Y'�w����+N�N��g���iz\���t�Ҭ��H��f��oX%V-	k�"a�I۳3���׬bb�R�N}7��\�vb���[U�I�[~U�Jm�fey�;��꠵���W�����0E験�r��L��x����������s��~;�j����f�?��M�g��d��T�4��<Ē��zJ�y-&�:�m���v���Vʋ�[�:�q�Z�Fo�yg=��O�Q'm�*�F��nV-"lPu����K��w�f�Ia�����:����a���)-��XU'���2�pJ~A�r���֫��Jۥ%M�iV���7�/�:iC���)�$��hN��u��N.���i>�����~O�Ƞ�-uzz]'7��Ϳ��gd����䶵��T�j����d��U��6F�1��"�����a�Ik99������U�[��NZ��2e��YN�b;�U������g��b:���:hۮj��6�¼�!�x�I�M�����F�?��G�t���K�\�f��mya�u�4дq��r�Q�p��1뤅��kV�ͻ5���Y�8������H�	'�_�Ӑ�~\Uu���딌X�j��t�z�Ik#.#c�Z��_߾S������߳NfݙՇ�2۝�e��u0��.��}���x8��4�dڃ����0��Tb��t�9�w����O�ޤ��;�|��{d �bU��p0��~{b�~�JVu2cg~�91���Y'3��d���3�oy5&�:��?��`F�Al���Y�72�e:^�Uu2{��3�my��svL?����;w�p�P1k���q����$���=�d�������7��'桓�����G�y�u�F]'��Q���l9��<�t2{��OV��Yj�bs��L�������5�:�C}�9]3��9�N��}�)�`���i2��{������IO6^�0�`�E��OY�����u2�(��s�{kʩ�ά��{����^9�0��rg��E����x�f�Q���Q��>���l}��$����%m=�n�t�s�ΰ���rS?,�(�<�^�s;�����5�J���ݪp&�Gp'���ђU�e4+�[��9�N:hm��4eoq�b�OE�I{D\p����?����ˇnq6״�L�`}Xl��4��f}�������������ȸ��tyO|܃�%(�����9q��,+���2#�z�2n/������
�uFtk������e���Y�b��
�)�I��'n�w�xaY���{��
�u9�#�W5G=��[i����>8]?�R�=��$S��Ֆo���������?G����G��V&����,�������5����C'�'���C�+�?����$��mU���B~�o�-�i�ï���O��kF���Pm ����WnF(��QD<���L���*q|<��N(�G:���e��/�8`,�����2�fQ
d�,|�$���+9�i����gl��|���0#;;T<`,^��Zg$������;P^�?�"��o0F��%__�v�"N����V��
�3"��M]�#���}?���ڡo��ا%\W�ߍ�4 nv��=�����^�_՚���5qS�a/Bh���Q�)\.��U�� �,TJ'���[#���Fׅ��U�uPu�%M:�-��e�E�R=�^�=��r��vp���v�����J��\^�լ��i)�tN�q�j����:\�v͋ۮ�Ay��\��R�1}n�J߾�GW��3�m��I,��5�K�}_�C��V�6��i�����2�[�u��+N�l4�y�'X�kز�y�,<޾�U��>l-N��cH���;%��oi��������o�1����(��4��X��z�(���t��ӝ��嬐��m�P������^h�N�T�?n����v{g�9�s0!`kE�-ذ8k�n�4\���[�p�m�d�-�d��v��9�랯/�,e����o�Q��:]��|��l�v/��lUC*��:h�'\K����8���E��ۯ�[iG1c}���0��?
hW;^���:������%2'��_"�>'�!Ż����ύe+:�~A�y�n�pĦ5�M�2�3�_���F%.��L�������ks۝����.v��W-L1�^��I�ᚌ	c�n�����.�<��ZE��[�t˜c�/4R�~��ը����'���]4���m�n�G�mXA�X��]�y#���n�_����Zbz�f�����L���u��Wٴ[�.�<&䦫E"�'�iۻɘ�L�����~�X��Y����� 3���r5I���{9W��F&kf��FK�����>Z��Td;�5�̖D�[%����֤��k���SM�C�g�[�s>r��[G[��z�Zb*徃�[��n�I�ٱ����-e�Q(P���hˇo��ݺ�'k��JK�������&�;�A�d����	�یu\	����Mₘ���}���a�߰#�N,��b>��6�Cy�J�mu���~x�=�S20��t��p�����}����������y*W      �     x���[j�0E�G��"��"����؉MB
i��w���5Q�!����� ����`��'��sC���!x���aw�]�z>tc)�7�V�O�#?�b!�7�RH�P�����{L*ظ�:I�����П��~7�W��L�(�7�K�X�΅7�p>T��M���S�,	���S�??�?/�77y�c7�2��ŔӅ�Y�����i[I�7z�o����"�hՍF�Ӥ`C�jA���\���k��J^J'n������      �   u   x�e�1�0@��>�/�v�r`EH,��@+�Yz{: 1T���WPz����<H���eOأ�A��2��z$���0�ez�ЧO�#�G���	n�Kke��yP'9�A��	���_U�      �   \  x��Yَ[Ir}��⢞��I*�ȍ�<4�~0l���DV��RM����O�*�j�gF��T�Kf�XN�H:�Q��K�J�/<>���g�f�X�:�X�J�fiep�j_��)����*s�.7��TJlϴ�VHZ�-�Y��K����$�Y�HR$�$��j�:�>����~���xgO��w2{�0:A�[DH�b�����ib�@���a'�]�F�Z��l)�\
9��oޕH��R��RM�obP�H�kA"+������#/Wx�y��u��U^�!28�+�&d���@I/�d-�LQ4"���X�UM�(�`�KN�3�q)���h|5$q��Exs�%���6��t�A����n�>r�6��s ��!�	������)�:J)BSAˬɨT5KF�Ѫx�|BV��DӒ|N%JeJҚ���4�rUΆh�4DkxH]D�zC6,�k�S�����m���G�g�8�{�YED�	��-k�i��l��̴ꕌ-{�L-�Fo�/��)�3�����f3"�@�]�\B�h߶q��gT��Ⱥ� ��e٭�6��?�ʚ����#2O!�EH��X�Y �R�e6V6���D�Au2Xh3�ֹH�J�W���0�)����Vxmjg�@(kW,X��Q�dͥ��RɕS�Sv�����N ����#�H�q��P�D�|?*�`c��an�#�߇J.��^:� 5��J�T���|Y�\��X��R�]X��n�T7��.TrZߣ۹)G�LlJ��eD���b���RV��/���>X�+����m��16�)8ӄc/�%Έ�R#���U���V�e��sJJ�&����oXM�j���A�D�
9z�7'C� �BɅ5sK��b�ʑ'�,i{�/��MZ����혼O`?���[�hCʆ3Rd&��Z��RIQK�����jF<��
2iȚU�p�k5����l��P��_8�V[�6���(\�[��.�	)r7���kK�6�3�'`}3�[8g.Qk�%Z�A�HPlhŜ��47������d�	J*5���-��2�\q�;(%*�<�Ӌ���� ;��7P���Zs��Gޯx���5����R�#"}��zBiȉ�R�5���MYݚIjSdj�]Q3�������ʐ��C�A�֊���H�l}��,����m�^�Ej�|FL�鰼��/�:io�V���%FtJ�"='m�"T2"��R�f%�B߳��m� ��E�P���"]D��*@�H:C��
Z9��?��%��:�x��&��n��V��1Gs:�2���]��O�fu�O�N���q��!=>��̇_��t�0����C���
�fn�=�x����a�s��S�����|�����Xʻ����ܷ��a���ۯ�'>�퐆���>�������p<>��?�W��������e/�}�~���y�m�ॿ�1}�~��������}}w�q����a�Ǟ�u�*{�^��v��W�߇�;�|7m��������?�˿-��/�����᧺Ym�άOpt�*u>�M��������e1܍���exL�#q�w~E��a|�ǿ�X��o�_�ظ<������n�Ǐצ�3�|.����>�����:L�V=V�ϟA"�<}:����O���<]�Fݍ�z'=�z�����=�Ӹ���,�VӢG���������tzG�
X�8]��6�>G������g�5�o��0r1~[/���o�\�Ț�Xi�s�.
�8�z��yu|��e4��wgv�]�<���l��{�z���v���������������WV��u�A�8,�o7/��O��j{?�����l������6�q-}vϋE�����F�oo��q����<���b� Ղh���z9�����2Cw8��/�c1Ŵ({�m"w�(�O|F#���d�6,5i-.��J1��X%��f�  �*khJ���1�
5�Mf&C���к�4s�i&\�}�net�ܿ��/�����z�k�R��x�6C��4u6!+\�ZPr�u�6q+�j�����Ux4�c"�+�{[�����L_�VY%̨x�]��c50`4��������B˕11���^{[<G�,1��l`*IAn�69\
�H�s�1����*������s��aK:�Ty�k����_l?�iM�Q*�+�4R�gD8f�c�u�$	i]�>&Z��O���A�GR@!TU�*P�� �-��$gsӡ���5�k�A��<JG��q�6v�-o�6�|���_��봟�#�+K�tq����E-)�Z��fD�|(zd����5F�Q�8����2��P&G�7rj���z��YN�F��֮�4��Y<l/�S��y=�����b�ҷfO:��:�SO���*Q�������L�R閨jX��
˄$�����j�'0��r�c�KOc��E��WA� aȿ |���1�#M�4�G��uQ�z�|�E4��.֔��#Mg��� c3n+�1��P��3�"F_\�2#_c Ħ��F�w�Cś�Nz�*L(�Oa:e����y{�ʟV�k�*1��i.E�0J��h�Q� Z02��ƃ�>��F-�`��I�B�~F�S4��ȹ s�DS=b�RM�AF����8V�ᴐ�1�^��E!�sɭ/�R/�T����i����S�o�o4���$�~R=&��T�tD���-�ۥW��1y��`5Ր+x��B��S&	��& I8�*��ȳ��b�M6��9� ��W����I�5����ݴ^�~���-�:�C����B�Eb�B�����@4��&�Xc
�Uop�#�0�I�R�?PI�$[�`&���q]�3��G	cv<�'��q;�Q#���2�'���0�<t���|e\��G�a�[�)��F'��T6/�#^�l���O�iV�`2J�P�iݿ{��H�l��T\�/RT>p���c��?s6�v����sO���c���y;Gt���vQ�o�w��G�>���Ŀ6lܔ�h� '�E EE���c�9�6�eԿ�J�ۛ�/6��o�q��E��r�
j�/�� }�gC�쁑�8��h��#YG��3cF���n��������!��Nmlh��Ti���"��-	q��66t�RC���.��L�P��%W�'J�@r���fd.�\��Ԡ���4v��v��JO_nL����[(�.��I�r(}���[j��"�F��*C3�,��TS�lP�u���lь�	�DN��їtG)���o�Dt�~�R+��3��-=���Oi��;XRj:�S�B��C�6��*#��	L �<k��1�TkF˖��d|4���jt�T#4I���>�,Ѵ�`�`lڜ{��V��CUٹs�vչ@VkO�}�O�lvӞ.�D�l5'�P�"�����Q H,�f�'F��)OHL��.��M�n�N�"�+4S���gȊ f�~������A�q��[K����N[��J����]�w�S��!9_�����j
a�ճda!x�M��4"�1�5�3��2��Vr>&D�1� �����8�!rn�I\����%����k�E5�н�^����B��bȿ�����BAS?��s�B��8��,�����uʅ-�Z���)��޽�? \~A     