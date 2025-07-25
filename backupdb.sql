PGDMP      (                }            nims_db %   12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)    17.0 �    r           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            s           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            t           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            u           1262    16391    nims_db    DATABASE     s   CREATE DATABASE nims_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE nims_db;
                     postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                     postgres    false            �           1247    18154    RepairReplacementType    TYPE     ~   CREATE TYPE public."RepairReplacementType" AS ENUM (
    'Repair',
    'Replacement',
    'Installed',
    'VehicleChange'
);
 *   DROP TYPE public."RepairReplacementType";
       public            	   nims_user    false    7            �           1247    18026    StatusGroup    TYPE     �   CREATE TYPE public."StatusGroup" AS ENUM (
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
       public            	   nims_user    false    7            �           1247    17664 	   TypeGroup    TYPE     �   CREATE TYPE public."TypeGroup" AS ENUM (
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
       public            	   nims_user    false    7            �            1259    17811 	   Accessory    TABLE     �  CREATE TABLE public."Accessory" (
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
       public         heap r    	   nims_user    false    695    695    7            �            1259    17809    Accessory_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Accessory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Accessory_id_seq";
       public            	   nims_user    false    226    7            v           0    0    Accessory_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."Accessory_id_seq" OWNED BY public."Accessory".id;
          public            	   nims_user    false    225            �            1259    17751    Brand    TABLE     �   CREATE TABLE public."Brand" (
    id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_id integer
);
    DROP TABLE public."Brand";
       public         heap r    	   nims_user    false    7    727            �            1259    17749    Brand_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Brand_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Brand_id_seq";
       public            	   nims_user    false    216    7            w           0    0    Brand_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Brand_id_seq" OWNED BY public."Brand".id;
          public            	   nims_user    false    215            �            1259    17691    Client    TABLE     ;  CREATE TABLE public."Client" (
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
       public         heap r    	   nims_user    false    7            �            1259    17689    Client_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Client_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Client_id_seq";
       public            	   nims_user    false    7    206            x           0    0    Client_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Client_id_seq" OWNED BY public."Client".id;
          public            	   nims_user    false    205            �            1259    18197    ComponentReplacement    TABLE     ~  CREATE TABLE public."ComponentReplacement" (
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
       public         heap r    	   nims_user    false    727    7            �            1259    18195    ComponentReplacement_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ComponentReplacement_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."ComponentReplacement_id_seq";
       public            	   nims_user    false    7    244            y           0    0    ComponentReplacement_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."ComponentReplacement_id_seq" OWNED BY public."ComponentReplacement".id;
          public            	   nims_user    false    243            �            1259    17703    ContactPerson    TABLE     L  CREATE TABLE public."ContactPerson" (
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
       public         heap r    	   nims_user    false    7            �            1259    17701    ContactPerson_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ContactPerson_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."ContactPerson_id_seq";
       public            	   nims_user    false    208    7            z           0    0    ContactPerson_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."ContactPerson_id_seq" OWNED BY public."ContactPerson".id;
          public            	   nims_user    false    207            �            1259    18184    DeviceRepairReplacement    TABLE     �  CREATE TABLE public."DeviceRepairReplacement" (
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
       public         heap r    	   nims_user    false    708    695    727    7            �            1259    18182    DeviceRepairReplacement_id_seq    SEQUENCE     �   CREATE SEQUENCE public."DeviceRepairReplacement_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public."DeviceRepairReplacement_id_seq";
       public            	   nims_user    false    7    242            {           0    0    DeviceRepairReplacement_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public."DeviceRepairReplacement_id_seq" OWNED BY public."DeviceRepairReplacement".id;
          public            	   nims_user    false    241            �            1259    18327    ExtraGPSDevice    TABLE     �  CREATE TABLE public."ExtraGPSDevice" (
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
       public         heap r    	   nims_user    false    7            �            1259    18325    ExtraGPSDevice_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ExtraGPSDevice_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."ExtraGPSDevice_id_seq";
       public            	   nims_user    false    248    7            |           0    0    ExtraGPSDevice_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."ExtraGPSDevice_id_seq" OWNED BY public."ExtraGPSDevice".id;
          public            	   nims_user    false    247            �            1259    17775 	   GPSDevice    TABLE     �  CREATE TABLE public."GPSDevice" (
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
       public         heap r    	   nims_user    false    695    7    695            �            1259    17773    GPSDevice_id_seq    SEQUENCE     �   CREATE SEQUENCE public."GPSDevice_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."GPSDevice_id_seq";
       public            	   nims_user    false    7    220            }           0    0    GPSDevice_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."GPSDevice_id_seq" OWNED BY public."GPSDevice".id;
          public            	   nims_user    false    219            �            1259    18173    InstallImage    TABLE     %  CREATE TABLE public."InstallImage" (
    id integer NOT NULL,
    server_id integer NOT NULL,
    device_repair_replacement_id integer,
    image_url text NOT NULL,
    type public."RepairReplacementType" DEFAULT 'Installed'::public."RepairReplacementType",
    vehicle_activity_id integer
);
 "   DROP TABLE public."InstallImage";
       public         heap r    	   nims_user    false    708    708    7            �            1259    18171    InstallImage_id_seq    SEQUENCE     �   CREATE SEQUENCE public."InstallImage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."InstallImage_id_seq";
       public            	   nims_user    false    240    7            ~           0    0    InstallImage_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."InstallImage_id_seq" OWNED BY public."InstallImage".id;
          public            	   nims_user    false    239            �            1259    17832    InstallationEngineer    TABLE       CREATE TABLE public."InstallationEngineer" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    server_id integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    device_repair_replacement_id integer,
    vehicle_activity_id integer
);
 *   DROP TABLE public."InstallationEngineer";
       public         heap r    	   nims_user    false    7            �            1259    17830    InstallationEngineer_id_seq    SEQUENCE     �   CREATE SEQUENCE public."InstallationEngineer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."InstallationEngineer_id_seq";
       public            	   nims_user    false    230    7                       0    0    InstallationEngineer_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."InstallationEngineer_id_seq" OWNED BY public."InstallationEngineer".id;
          public            	   nims_user    false    229            �            1259    17763    Model    TABLE     (  CREATE TABLE public."Model" (
    id integer NOT NULL,
    brand_id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);
    DROP TABLE public."Model";
       public         heap r    	   nims_user    false    7    727            �            1259    17761    Model_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Model_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Model_id_seq";
       public            	   nims_user    false    7    218            �           0    0    Model_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Model_id_seq" OWNED BY public."Model".id;
          public            	   nims_user    false    217            �            1259    17799 
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
       public         heap r    	   nims_user    false    695    7    695            �            1259    17995    PeripheralDetail    TABLE     v  CREATE TABLE public."PeripheralDetail" (
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
       public         heap r    	   nims_user    false    7            �            1259    17993    PeripheralDetail_id_seq    SEQUENCE     �   CREATE SEQUENCE public."PeripheralDetail_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."PeripheralDetail_id_seq";
       public            	   nims_user    false    234    7            �           0    0    PeripheralDetail_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."PeripheralDetail_id_seq" OWNED BY public."PeripheralDetail".id;
          public            	   nims_user    false    233            �            1259    17797    Peripheral_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Peripheral_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Peripheral_id_seq";
       public            	   nims_user    false    224    7            �           0    0    Peripheral_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Peripheral_id_seq" OWNED BY public."Peripheral".id;
          public            	   nims_user    false    223            �            1259    18056 
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
       public         heap r    	   nims_user    false    7            �            1259    18054    Permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Permission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Permission_id_seq";
       public            	   nims_user    false    7    236            �           0    0    Permission_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Permission_id_seq" OWNED BY public."Permission".id;
          public            	   nims_user    false    235            �            1259    17715    Role    TABLE       CREATE TABLE public."Role" (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "canLogin" boolean DEFAULT false NOT NULL
);
    DROP TABLE public."Role";
       public         heap r    	   nims_user    false    7            �            1259    17713    Role_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Role_id_seq";
       public            	   nims_user    false    7    210            �           0    0    Role_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Role_id_seq" OWNED BY public."Role".id;
          public            	   nims_user    false    209            �            1259    17820    Server    TABLE     �  CREATE TABLE public."Server" (
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
       public         heap r    	   nims_user    false    695    7    695            �            1259    18122    ServerActivity    TABLE     5  CREATE TABLE public."ServerActivity" (
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
       public         heap r    	   nims_user    false    695    695    7            �            1259    18120    ServerActivity_id_seq    SEQUENCE     �   CREATE SEQUENCE public."ServerActivity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."ServerActivity_id_seq";
       public            	   nims_user    false    238    7            �           0    0    ServerActivity_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."ServerActivity_id_seq" OWNED BY public."ServerActivity".id;
          public            	   nims_user    false    237            �            1259    17818    Server_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Server_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Server_id_seq";
       public            	   nims_user    false    7    228            �           0    0    Server_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Server_id_seq" OWNED BY public."Server".id;
          public            	   nims_user    false    227            �            1259    17787    SimCard    TABLE     p  CREATE TABLE public."SimCard" (
    id integer NOT NULL,
    device_id integer NOT NULL,
    phone_no text NOT NULL,
    operator text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    status public."StatusGroup" DEFAULT 'Active'::public."StatusGroup" NOT NULL
);
    DROP TABLE public."SimCard";
       public         heap r    	   nims_user    false    695    695    7            �            1259    17785    SimCard_id_seq    SEQUENCE     �   CREATE SEQUENCE public."SimCard_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."SimCard_id_seq";
       public            	   nims_user    false    222    7            �           0    0    SimCard_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."SimCard_id_seq" OWNED BY public."SimCard".id;
          public            	   nims_user    false    221            �            1259    17739    Type    TABLE     �   CREATE TABLE public."Type" (
    id integer NOT NULL,
    name text NOT NULL,
    type_group public."TypeGroup" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public."Type";
       public         heap r    	   nims_user    false    7    727            �            1259    17737    Type_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Type_id_seq";
       public            	   nims_user    false    214    7            �           0    0    Type_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Type_id_seq" OWNED BY public."Type".id;
          public            	   nims_user    false    213            �            1259    17679    User    TABLE     f  CREATE TABLE public."User" (
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
       public         heap r    	   nims_user    false    7            �            1259    17677    User_id_seq    SEQUENCE     �   CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."User_id_seq";
       public            	   nims_user    false    7    204            �           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public            	   nims_user    false    203            �            1259    17727    Vehicle    TABLE     m  CREATE TABLE public."Vehicle" (
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
       public         heap r    	   nims_user    false    7            �            1259    18289    VehicleActivity    TABLE     �  CREATE TABLE public."VehicleActivity" (
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
       public         heap r    	   nims_user    false    7            �            1259    18287    VehicleActivity_id_seq    SEQUENCE     �   CREATE SEQUENCE public."VehicleActivity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."VehicleActivity_id_seq";
       public            	   nims_user    false    246    7            �           0    0    VehicleActivity_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public."VehicleActivity_id_seq" OWNED BY public."VehicleActivity".id;
          public            	   nims_user    false    245            �            1259    17725    Vehicle_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Vehicle_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Vehicle_id_seq";
       public            	   nims_user    false    212    7            �           0    0    Vehicle_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Vehicle_id_seq" OWNED BY public."Vehicle".id;
          public            	   nims_user    false    211            �            1259    17841    WarrantyPlan    TABLE     �   CREATE TABLE public."WarrantyPlan" (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 "   DROP TABLE public."WarrantyPlan";
       public         heap r    	   nims_user    false    7            �            1259    17839    WarrantyPlan_id_seq    SEQUENCE     �   CREATE SEQUENCE public."WarrantyPlan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."WarrantyPlan_id_seq";
       public            	   nims_user    false    232    7            �           0    0    WarrantyPlan_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."WarrantyPlan_id_seq" OWNED BY public."WarrantyPlan".id;
          public            	   nims_user    false    231            �            1259    17653    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
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
       public         heap r    	   nims_user    false    7            8           2604    17973    Accessory id    DEFAULT     p   ALTER TABLE ONLY public."Accessory" ALTER COLUMN id SET DEFAULT nextval('public."Accessory_id_seq"'::regclass);
 =   ALTER TABLE public."Accessory" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    226    225    226            +           2604    17974    Brand id    DEFAULT     h   ALTER TABLE ONLY public."Brand" ALTER COLUMN id SET DEFAULT nextval('public."Brand_id_seq"'::regclass);
 9   ALTER TABLE public."Brand" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    215    216    216                        2604    17975 	   Client id    DEFAULT     j   ALTER TABLE ONLY public."Client" ALTER COLUMN id SET DEFAULT nextval('public."Client_id_seq"'::regclass);
 :   ALTER TABLE public."Client" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    206    205    206            R           2604    18200    ComponentReplacement id    DEFAULT     �   ALTER TABLE ONLY public."ComponentReplacement" ALTER COLUMN id SET DEFAULT nextval('public."ComponentReplacement_id_seq"'::regclass);
 H   ALTER TABLE public."ComponentReplacement" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    243    244    244            "           2604    17976    ContactPerson id    DEFAULT     x   ALTER TABLE ONLY public."ContactPerson" ALTER COLUMN id SET DEFAULT nextval('public."ContactPerson_id_seq"'::regclass);
 A   ALTER TABLE public."ContactPerson" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    207    208    208            N           2604    18187    DeviceRepairReplacement id    DEFAULT     �   ALTER TABLE ONLY public."DeviceRepairReplacement" ALTER COLUMN id SET DEFAULT nextval('public."DeviceRepairReplacement_id_seq"'::regclass);
 K   ALTER TABLE public."DeviceRepairReplacement" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    242    241    242            X           2604    18330    ExtraGPSDevice id    DEFAULT     z   ALTER TABLE ONLY public."ExtraGPSDevice" ALTER COLUMN id SET DEFAULT nextval('public."ExtraGPSDevice_id_seq"'::regclass);
 B   ALTER TABLE public."ExtraGPSDevice" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    248    247    248            /           2604    17977    GPSDevice id    DEFAULT     p   ALTER TABLE ONLY public."GPSDevice" ALTER COLUMN id SET DEFAULT nextval('public."GPSDevice_id_seq"'::regclass);
 =   ALTER TABLE public."GPSDevice" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    219    220    220            L           2604    18176    InstallImage id    DEFAULT     v   ALTER TABLE ONLY public."InstallImage" ALTER COLUMN id SET DEFAULT nextval('public."InstallImage_id_seq"'::regclass);
 @   ALTER TABLE public."InstallImage" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    239    240    240            >           2604    17978    InstallationEngineer id    DEFAULT     �   ALTER TABLE ONLY public."InstallationEngineer" ALTER COLUMN id SET DEFAULT nextval('public."InstallationEngineer_id_seq"'::regclass);
 H   ALTER TABLE public."InstallationEngineer" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    229    230    230            -           2604    17979    Model id    DEFAULT     h   ALTER TABLE ONLY public."Model" ALTER COLUMN id SET DEFAULT nextval('public."Model_id_seq"'::regclass);
 9   ALTER TABLE public."Model" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    218    217    218            5           2604    17980    Peripheral id    DEFAULT     r   ALTER TABLE ONLY public."Peripheral" ALTER COLUMN id SET DEFAULT nextval('public."Peripheral_id_seq"'::regclass);
 >   ALTER TABLE public."Peripheral" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    223    224    224            B           2604    17998    PeripheralDetail id    DEFAULT     ~   ALTER TABLE ONLY public."PeripheralDetail" ALTER COLUMN id SET DEFAULT nextval('public."PeripheralDetail_id_seq"'::regclass);
 D   ALTER TABLE public."PeripheralDetail" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    233    234    234            D           2604    18059    Permission id    DEFAULT     r   ALTER TABLE ONLY public."Permission" ALTER COLUMN id SET DEFAULT nextval('public."Permission_id_seq"'::regclass);
 >   ALTER TABLE public."Permission" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    235    236    236            $           2604    17981    Role id    DEFAULT     f   ALTER TABLE ONLY public."Role" ALTER COLUMN id SET DEFAULT nextval('public."Role_id_seq"'::regclass);
 8   ALTER TABLE public."Role" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    210    209    210            ;           2604    17982 	   Server id    DEFAULT     j   ALTER TABLE ONLY public."Server" ALTER COLUMN id SET DEFAULT nextval('public."Server_id_seq"'::regclass);
 :   ALTER TABLE public."Server" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    228    227    228            I           2604    18125    ServerActivity id    DEFAULT     z   ALTER TABLE ONLY public."ServerActivity" ALTER COLUMN id SET DEFAULT nextval('public."ServerActivity_id_seq"'::regclass);
 B   ALTER TABLE public."ServerActivity" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    238    237    238            2           2604    17983 
   SimCard id    DEFAULT     l   ALTER TABLE ONLY public."SimCard" ALTER COLUMN id SET DEFAULT nextval('public."SimCard_id_seq"'::regclass);
 ;   ALTER TABLE public."SimCard" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    221    222    222            )           2604    17984    Type id    DEFAULT     f   ALTER TABLE ONLY public."Type" ALTER COLUMN id SET DEFAULT nextval('public."Type_id_seq"'::regclass);
 8   ALTER TABLE public."Type" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    214    213    214                       2604    17985    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    204    203    204            '           2604    17986 
   Vehicle id    DEFAULT     l   ALTER TABLE ONLY public."Vehicle" ALTER COLUMN id SET DEFAULT nextval('public."Vehicle_id_seq"'::regclass);
 ;   ALTER TABLE public."Vehicle" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    211    212    212            U           2604    18292    VehicleActivity id    DEFAULT     |   ALTER TABLE ONLY public."VehicleActivity" ALTER COLUMN id SET DEFAULT nextval('public."VehicleActivity_id_seq"'::regclass);
 C   ALTER TABLE public."VehicleActivity" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    245    246    246            @           2604    17987    WarrantyPlan id    DEFAULT     v   ALTER TABLE ONLY public."WarrantyPlan" ALTER COLUMN id SET DEFAULT nextval('public."WarrantyPlan_id_seq"'::regclass);
 @   ALTER TABLE public."WarrantyPlan" ALTER COLUMN id DROP DEFAULT;
       public            	   nims_user    false    231    232    232            Y          0    17811 	   Accessory 
   TABLE DATA           t   COPY public."Accessory" (id, device_id, type_id, qty, "createdAt", "updatedAt", status, installed_date) FROM stdin;
    public            	   nims_user    false    226    K      O          0    17751    Brand 
   TABLE DATA           M   COPY public."Brand" (id, name, type_group, "createdAt", type_id) FROM stdin;
    public            	   nims_user    false    216   ��      E          0    17691    Client 
   TABLE DATA           m   COPY public."Client" (id, name, address, city, state, country, postal, "createdAt", "updatedAt") FROM stdin;
    public            	   nims_user    false    206   ]�      k          0    18197    ComponentReplacement 
   TABLE DATA           ,  COPY public."ComponentReplacement" (id, device_replacement_id, component_type, replacement_reason, replacement_date, original_simcard_id, original_peripheral_id, original_accessory_id, replacement_simcard_id, replacement_peripheral_id, replacement_accessory_id, "createdAt", "updatedAt") FROM stdin;
    public            	   nims_user    false    244   �      G          0    17703    ContactPerson 
   TABLE DATA           o   COPY public."ContactPerson" (id, client_id, name, role_id, phone, email, "createdAt", "updatedAt") FROM stdin;
    public            	   nims_user    false    208   ��      i          0    18184    DeviceRepairReplacement 
   TABLE DATA           �   COPY public."DeviceRepairReplacement" (id, original_gps_id, repair_replacement_gps_id, repair_replacement_by_user_id, type, replacement_device_type, reason, repair_replacement_date, "createdAt", "updatedAt", user_false, is_deleted) FROM stdin;
    public            	   nims_user    false    242   ��      o          0    18327    ExtraGPSDevice 
   TABLE DATA           �   COPY public."ExtraGPSDevice" (id, device_id, brand_id, model_id, imei, serial_no, warranty_plan_id, "createdAt", "updatedAt") FROM stdin;
    public            	   nims_user    false    248   U�      S          0    17775 	   GPSDevice 
   TABLE DATA           �   COPY public."GPSDevice" (id, vehicle_id, brand_id, model_id, imei, serial_no, warranty_plan_id, "createdAt", "updatedAt", status) FROM stdin;
    public            	   nims_user    false    220   r�      g          0    18173    InstallImage 
   TABLE DATA           {   COPY public."InstallImage" (id, server_id, device_repair_replacement_id, image_url, type, vehicle_activity_id) FROM stdin;
    public            	   nims_user    false    240   &$      ]          0    17832    InstallationEngineer 
   TABLE DATA           �   COPY public."InstallationEngineer" (id, user_id, server_id, "createdAt", device_repair_replacement_id, vehicle_activity_id) FROM stdin;
    public            	   nims_user    false    230   -0      Q          0    17763    Model 
   TABLE DATA           [   COPY public."Model" (id, brand_id, name, type_group, "createdAt", "updatedAt") FROM stdin;
    public            	   nims_user    false    218   r      W          0    17799 
   Peripheral 
   TABLE DATA           |   COPY public."Peripheral" (id, device_id, sensor_type_id, qty, "createdAt", "updatedAt", status, installed_date) FROM stdin;
    public            	   nims_user    false    224   Y{      a          0    17995    PeripheralDetail 
   TABLE DATA           �   COPY public."PeripheralDetail" (id, peripheral_id, brand_id, model_id, warranty_plan_id, serial_no, "createdAt", "updatedAt") FROM stdin;
    public            	   nims_user    false    234   ^�      c          0    18056 
   Permission 
   TABLE DATA           _   COPY public."Permission" (id, page_name, view, "create", update, delete, "roleId") FROM stdin;
    public            	   nims_user    false    236   t�      I          0    17715    Role 
   TABLE DATA           P   COPY public."Role" (id, name, "createdAt", "updatedAt", "canLogin") FROM stdin;
    public            	   nims_user    false    210   ��      [          0    17820    Server 
   TABLE DATA           �   COPY public."Server" (id, type_id, installed_date, subscription_plan_id, expire_date, invoice_no, object_base_fee, gps_device_id, "createdAt", "updatedAt", domain_id, status, renewal_date) FROM stdin;
    public            	   nims_user    false    228   C�      e          0    18122    ServerActivity 
   TABLE DATA           �   COPY public."ServerActivity" (id, server_id, type_id, domain_id, subscription_plan_id, installed_date, renewal_date, expire_date, invoice_no, object_base_fee, status, "createdAt") FROM stdin;
    public            	   nims_user    false    238   V<      U          0    17787    SimCard 
   TABLE DATA           h   COPY public."SimCard" (id, device_id, phone_no, operator, "createdAt", "updatedAt", status) FROM stdin;
    public            	   nims_user    false    222   �H      M          0    17739    Type 
   TABLE DATA           C   COPY public."Type" (id, name, type_group, "createdAt") FROM stdin;
    public            	   nims_user    false    214   8�      C          0    17679    User 
   TABLE DATA           {   COPY public."User" (id, name, role_id, phone, email, password, "createdAt", "updatedAt", "canLogin", username) FROM stdin;
    public            	   nims_user    false    204   Z�      K          0    17727    Vehicle 
   TABLE DATA           �   COPY public."Vehicle" (id, client_id, plate_number, type_id, brand_id, model_id, year, "createdAt", "updatedAt", odometer) FROM stdin;
    public            	   nims_user    false    212   ��      m          0    18289    VehicleActivity 
   TABLE DATA           �   COPY public."VehicleActivity" (id, vehicle_id, plate_number, type_id, brand_id, model_id, year, odometer, changed_date, reason, "createdAt", "updatedAt") FROM stdin;
    public            	   nims_user    false    246   �      _          0    17841    WarrantyPlan 
   TABLE DATA           ?   COPY public."WarrantyPlan" (id, name, "createdAt") FROM stdin;
    public            	   nims_user    false    232   ��      A          0    17653    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public            	   nims_user    false    202   N�      �           0    0    Accessory_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Accessory_id_seq"', 2622, true);
          public            	   nims_user    false    225            �           0    0    Brand_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Brand_id_seq"', 105, true);
          public            	   nims_user    false    215            �           0    0    Client_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Client_id_seq"', 60, true);
          public            	   nims_user    false    205            �           0    0    ComponentReplacement_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."ComponentReplacement_id_seq"', 25, true);
          public            	   nims_user    false    243            �           0    0    ContactPerson_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."ContactPerson_id_seq"', 66, true);
          public            	   nims_user    false    207            �           0    0    DeviceRepairReplacement_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public."DeviceRepairReplacement_id_seq"', 72, true);
          public            	   nims_user    false    241            �           0    0    ExtraGPSDevice_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."ExtraGPSDevice_id_seq"', 1, false);
          public            	   nims_user    false    247            �           0    0    GPSDevice_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."GPSDevice_id_seq"', 1106, true);
          public            	   nims_user    false    219            �           0    0    InstallImage_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."InstallImage_id_seq"', 265, true);
          public            	   nims_user    false    239            �           0    0    InstallationEngineer_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."InstallationEngineer_id_seq"', 2398, true);
          public            	   nims_user    false    229            �           0    0    Model_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Model_id_seq"', 122, true);
          public            	   nims_user    false    217            �           0    0    PeripheralDetail_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."PeripheralDetail_id_seq"', 897, true);
          public            	   nims_user    false    233            �           0    0    Peripheral_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Peripheral_id_seq"', 852, true);
          public            	   nims_user    false    223            �           0    0    Permission_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Permission_id_seq"', 8, true);
          public            	   nims_user    false    235            �           0    0    Role_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Role_id_seq"', 15, true);
          public            	   nims_user    false    209            �           0    0    ServerActivity_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."ServerActivity_id_seq"', 150, true);
          public            	   nims_user    false    237            �           0    0    Server_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Server_id_seq"', 1073, true);
          public            	   nims_user    false    227            �           0    0    SimCard_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."SimCard_id_seq"', 1472, true);
          public            	   nims_user    false    221            �           0    0    Type_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Type_id_seq"', 28, true);
          public            	   nims_user    false    213            �           0    0    User_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."User_id_seq"', 18, true);
          public            	   nims_user    false    203            �           0    0    VehicleActivity_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."VehicleActivity_id_seq"', 5, true);
          public            	   nims_user    false    245            �           0    0    Vehicle_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Vehicle_id_seq"', 1092, true);
          public            	   nims_user    false    211            �           0    0    WarrantyPlan_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."WarrantyPlan_id_seq"', 5, true);
          public            	   nims_user    false    231            u           2606    17817    Accessory Accessory_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_pkey";
       public              	   nims_user    false    226            k           2606    17760    Brand Brand_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Brand" DROP CONSTRAINT "Brand_pkey";
       public              	   nims_user    false    216            `           2606    17700    Client Client_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Client" DROP CONSTRAINT "Client_pkey";
       public              	   nims_user    false    206            �           2606    18207 .   ComponentReplacement ComponentReplacement_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_pkey" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_pkey";
       public              	   nims_user    false    244            b           2606    17712     ContactPerson ContactPerson_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_pkey";
       public              	   nims_user    false    208            �           2606    18194 4   DeviceRepairReplacement DeviceRepairReplacement_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_pkey" PRIMARY KEY (id);
 b   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_pkey";
       public              	   nims_user    false    242            �           2606    18336 "   ExtraGPSDevice ExtraGPSDevice_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_pkey";
       public              	   nims_user    false    248            o           2606    17784    GPSDevice GPSDevice_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_pkey";
       public              	   nims_user    false    220            �           2606    18181    InstallImage InstallImage_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_pkey";
       public              	   nims_user    false    240            y           2606    17838 .   InstallationEngineer InstallationEngineer_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_pkey" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_pkey";
       public              	   nims_user    false    230            m           2606    17772    Model Model_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Model"
    ADD CONSTRAINT "Model_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Model" DROP CONSTRAINT "Model_pkey";
       public              	   nims_user    false    218            }           2606    18004 &   PeripheralDetail PeripheralDetail_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_pkey" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_pkey";
       public              	   nims_user    false    234            s           2606    17808    Peripheral Peripheral_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_pkey";
       public              	   nims_user    false    224                       2606    18068    Permission Permission_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Permission" DROP CONSTRAINT "Permission_pkey";
       public              	   nims_user    false    236            e           2606    17724    Role Role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Role" DROP CONSTRAINT "Role_pkey";
       public              	   nims_user    false    210            �           2606    18132 "   ServerActivity ServerActivity_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_pkey";
       public              	   nims_user    false    238            w           2606    17829    Server Server_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_pkey";
       public              	   nims_user    false    228            q           2606    17796    SimCard SimCard_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."SimCard"
    ADD CONSTRAINT "SimCard_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."SimCard" DROP CONSTRAINT "SimCard_pkey";
       public              	   nims_user    false    222            i           2606    17748    Type Type_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Type"
    ADD CONSTRAINT "Type_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Type" DROP CONSTRAINT "Type_pkey";
       public              	   nims_user    false    214            ]           2606    17688    User User_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
       public              	   nims_user    false    204            �           2606    18299 $   VehicleActivity VehicleActivity_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_pkey";
       public              	   nims_user    false    246            g           2606    17736    Vehicle Vehicle_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_pkey";
       public              	   nims_user    false    212            {           2606    17850    WarrantyPlan WarrantyPlan_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."WarrantyPlan"
    ADD CONSTRAINT "WarrantyPlan_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."WarrantyPlan" DROP CONSTRAINT "WarrantyPlan_pkey";
       public              	   nims_user    false    232            [           2606    17662 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public              	   nims_user    false    202            c           1259    18069    Role_name_key    INDEX     I   CREATE UNIQUE INDEX "Role_name_key" ON public."Role" USING btree (name);
 #   DROP INDEX public."Role_name_key";
       public              	   nims_user    false    210            ^           1259    18070    User_username_key    INDEX     Q   CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);
 '   DROP INDEX public."User_username_key";
       public              	   nims_user    false    204            �           2606    17922 "   Accessory Accessory_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_device_id_fkey";
       public            	   nims_user    false    3695    226    220            �           2606    17927     Accessory Accessory_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Accessory"
    ADD CONSTRAINT "Accessory_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."Accessory" DROP CONSTRAINT "Accessory_type_id_fkey";
       public            	   nims_user    false    3689    226    214            �           2606    17962    Brand Brand_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public."Brand" DROP CONSTRAINT "Brand_type_id_fkey";
       public            	   nims_user    false    3689    216    214            �           2606    18243 D   ComponentReplacement ComponentReplacement_device_replacement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_device_replacement_id_fkey" FOREIGN KEY (device_replacement_id) REFERENCES public."DeviceRepairReplacement"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 r   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_device_replacement_id_fkey";
       public            	   nims_user    false    242    3717    244            �           2606    18258 D   ComponentReplacement ComponentReplacement_original_accessory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_original_accessory_id_fkey" FOREIGN KEY (original_accessory_id) REFERENCES public."Accessory"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 r   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_original_accessory_id_fkey";
       public            	   nims_user    false    3701    226    244            �           2606    18253 E   ComponentReplacement ComponentReplacement_original_peripheral_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_original_peripheral_id_fkey" FOREIGN KEY (original_peripheral_id) REFERENCES public."Peripheral"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 s   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_original_peripheral_id_fkey";
       public            	   nims_user    false    224    244    3699            �           2606    18248 B   ComponentReplacement ComponentReplacement_original_simcard_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_original_simcard_id_fkey" FOREIGN KEY (original_simcard_id) REFERENCES public."SimCard"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 p   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_original_simcard_id_fkey";
       public            	   nims_user    false    222    3697    244            �           2606    18273 G   ComponentReplacement ComponentReplacement_replacement_accessory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_replacement_accessory_id_fkey" FOREIGN KEY (replacement_accessory_id) REFERENCES public."Accessory"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 u   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_replacement_accessory_id_fkey";
       public            	   nims_user    false    226    244    3701            �           2606    18268 H   ComponentReplacement ComponentReplacement_replacement_peripheral_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_replacement_peripheral_id_fkey" FOREIGN KEY (replacement_peripheral_id) REFERENCES public."Peripheral"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 v   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_replacement_peripheral_id_fkey";
       public            	   nims_user    false    224    244    3699            �           2606    18263 E   ComponentReplacement ComponentReplacement_replacement_simcard_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ComponentReplacement"
    ADD CONSTRAINT "ComponentReplacement_replacement_simcard_id_fkey" FOREIGN KEY (replacement_simcard_id) REFERENCES public."SimCard"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 s   ALTER TABLE ONLY public."ComponentReplacement" DROP CONSTRAINT "ComponentReplacement_replacement_simcard_id_fkey";
       public            	   nims_user    false    244    3697    222            �           2606    17857 *   ContactPerson ContactPerson_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_client_id_fkey";
       public            	   nims_user    false    3680    206    208            �           2606    18090 (   ContactPerson ContactPerson_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ContactPerson"
    ADD CONSTRAINT "ContactPerson_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 V   ALTER TABLE ONLY public."ContactPerson" DROP CONSTRAINT "ContactPerson_role_id_fkey";
       public            	   nims_user    false    208    3685    210            �           2606    18228 D   DeviceRepairReplacement DeviceRepairReplacement_original_gps_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_original_gps_id_fkey" FOREIGN KEY (original_gps_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 r   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_original_gps_id_fkey";
       public            	   nims_user    false    242    3695    220            �           2606    18238 R   DeviceRepairReplacement DeviceRepairReplacement_repair_replacement_by_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_repair_replacement_by_user_id_fkey" FOREIGN KEY (repair_replacement_by_user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 �   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_repair_replacement_by_user_id_fkey";
       public            	   nims_user    false    3677    204    242            �           2606    18233 N   DeviceRepairReplacement DeviceRepairReplacement_repair_replacement_gps_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."DeviceRepairReplacement"
    ADD CONSTRAINT "DeviceRepairReplacement_repair_replacement_gps_id_fkey" FOREIGN KEY (repair_replacement_gps_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 |   ALTER TABLE ONLY public."DeviceRepairReplacement" DROP CONSTRAINT "DeviceRepairReplacement_repair_replacement_gps_id_fkey";
       public            	   nims_user    false    242    3695    220            �           2606    18342 +   ExtraGPSDevice ExtraGPSDevice_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_brand_id_fkey";
       public            	   nims_user    false    248    216    3691            �           2606    18337 ,   ExtraGPSDevice ExtraGPSDevice_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Z   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_device_id_fkey";
       public            	   nims_user    false    248    3695    220            �           2606    18347 +   ExtraGPSDevice ExtraGPSDevice_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_model_id_fkey";
       public            	   nims_user    false    248    218    3693            �           2606    18352 3   ExtraGPSDevice ExtraGPSDevice_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ExtraGPSDevice"
    ADD CONSTRAINT "ExtraGPSDevice_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 a   ALTER TABLE ONLY public."ExtraGPSDevice" DROP CONSTRAINT "ExtraGPSDevice_warranty_plan_id_fkey";
       public            	   nims_user    false    3707    232    248            �           2606    17892 !   GPSDevice GPSDevice_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_brand_id_fkey";
       public            	   nims_user    false    3691    220    216            �           2606    18095 !   GPSDevice GPSDevice_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_model_id_fkey";
       public            	   nims_user    false    220    3693    218            �           2606    17887 #   GPSDevice GPSDevice_vehicle_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_vehicle_id_fkey" FOREIGN KEY (vehicle_id) REFERENCES public."Vehicle"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_vehicle_id_fkey";
       public            	   nims_user    false    212    3687    220            �           2606    17897 )   GPSDevice GPSDevice_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."GPSDevice"
    ADD CONSTRAINT "GPSDevice_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public."GPSDevice" DROP CONSTRAINT "GPSDevice_warranty_plan_id_fkey";
       public            	   nims_user    false    220    232    3707            �           2606    18223 ;   InstallImage InstallImage_device_repair_replacement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_device_repair_replacement_id_fkey" FOREIGN KEY (device_repair_replacement_id) REFERENCES public."DeviceRepairReplacement"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 i   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_device_repair_replacement_id_fkey";
       public            	   nims_user    false    3717    240    242            �           2606    18218 (   InstallImage InstallImage_server_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_server_id_fkey" FOREIGN KEY (server_id) REFERENCES public."Server"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 V   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_server_id_fkey";
       public            	   nims_user    false    3703    240    228            �           2606    18320 2   InstallImage InstallImage_vehicle_activity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallImage"
    ADD CONSTRAINT "InstallImage_vehicle_activity_id_fkey" FOREIGN KEY (vehicle_activity_id) REFERENCES public."VehicleActivity"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 `   ALTER TABLE ONLY public."InstallImage" DROP CONSTRAINT "InstallImage_vehicle_activity_id_fkey";
       public            	   nims_user    false    246    3721    240            �           2606    18213 K   InstallationEngineer InstallationEngineer_device_repair_replacement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_device_repair_replacement_id_fkey" FOREIGN KEY (device_repair_replacement_id) REFERENCES public."DeviceRepairReplacement"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 y   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_device_repair_replacement_id_fkey";
       public            	   nims_user    false    230    3717    242            �           2606    18208 8   InstallationEngineer InstallationEngineer_server_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_server_id_fkey" FOREIGN KEY (server_id) REFERENCES public."Server"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 f   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_server_id_fkey";
       public            	   nims_user    false    228    230    3703            �           2606    18100 6   InstallationEngineer InstallationEngineer_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 d   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_user_id_fkey";
       public            	   nims_user    false    3677    204    230            �           2606    18315 B   InstallationEngineer InstallationEngineer_vehicle_activity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."InstallationEngineer"
    ADD CONSTRAINT "InstallationEngineer_vehicle_activity_id_fkey" FOREIGN KEY (vehicle_activity_id) REFERENCES public."VehicleActivity"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 p   ALTER TABLE ONLY public."InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_vehicle_activity_id_fkey";
       public            	   nims_user    false    230    3721    246            �           2606    17967    Model Model_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Model"
    ADD CONSTRAINT "Model_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 G   ALTER TABLE ONLY public."Model" DROP CONSTRAINT "Model_brand_id_fkey";
       public            	   nims_user    false    3691    218    216            �           2606    18015 /   PeripheralDetail PeripheralDetail_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_brand_id_fkey";
       public            	   nims_user    false    3691    216    234            �           2606    18020 /   PeripheralDetail PeripheralDetail_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_model_id_fkey";
       public            	   nims_user    false    218    3693    234            �           2606    18076 4   PeripheralDetail PeripheralDetail_peripheral_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_peripheral_id_fkey" FOREIGN KEY (peripheral_id) REFERENCES public."Peripheral"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 b   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_peripheral_id_fkey";
       public            	   nims_user    false    224    3699    234            �           2606    18010 7   PeripheralDetail PeripheralDetail_warranty_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."PeripheralDetail"
    ADD CONSTRAINT "PeripheralDetail_warranty_plan_id_fkey" FOREIGN KEY (warranty_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 e   ALTER TABLE ONLY public."PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_warranty_plan_id_fkey";
       public            	   nims_user    false    234    232    3707            �           2606    17907 $   Peripheral Peripheral_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_device_id_fkey";
       public            	   nims_user    false    3695    220    224            �           2606    17912 )   Peripheral Peripheral_sensor_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Peripheral"
    ADD CONSTRAINT "Peripheral_sensor_type_id_fkey" FOREIGN KEY (sensor_type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public."Peripheral" DROP CONSTRAINT "Peripheral_sensor_type_id_fkey";
       public            	   nims_user    false    224    3689    214            �           2606    18071 !   Permission Permission_roleId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public."Permission" DROP CONSTRAINT "Permission_roleId_fkey";
       public            	   nims_user    false    236    210    3685            �           2606    18148 ,   ServerActivity ServerActivity_domain_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_domain_id_fkey" FOREIGN KEY (domain_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 Z   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_domain_id_fkey";
       public            	   nims_user    false    216    3691    238            �           2606    18133 ,   ServerActivity ServerActivity_server_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_server_id_fkey" FOREIGN KEY (server_id) REFERENCES public."Server"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_server_id_fkey";
       public            	   nims_user    false    228    238    3703            �           2606    18143 7   ServerActivity ServerActivity_subscription_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_subscription_plan_id_fkey" FOREIGN KEY (subscription_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 e   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_subscription_plan_id_fkey";
       public            	   nims_user    false    238    3707    232            �           2606    18138 *   ServerActivity ServerActivity_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."ServerActivity"
    ADD CONSTRAINT "ServerActivity_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 X   ALTER TABLE ONLY public."ServerActivity" DROP CONSTRAINT "ServerActivity_type_id_fkey";
       public            	   nims_user    false    238    3689    214            �           2606    17988    Server Server_domain_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_domain_id_fkey" FOREIGN KEY (domain_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_domain_id_fkey";
       public            	   nims_user    false    3691    216    228            �           2606    17932     Server Server_gps_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_gps_device_id_fkey" FOREIGN KEY (gps_device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_gps_device_id_fkey";
       public            	   nims_user    false    220    3695    228            �           2606    17942 '   Server Server_subscription_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_subscription_plan_id_fkey" FOREIGN KEY (subscription_plan_id) REFERENCES public."WarrantyPlan"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 U   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_subscription_plan_id_fkey";
       public            	   nims_user    false    228    3707    232            �           2606    17937    Server Server_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Server"
    ADD CONSTRAINT "Server_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 H   ALTER TABLE ONLY public."Server" DROP CONSTRAINT "Server_type_id_fkey";
       public            	   nims_user    false    3689    228    214            �           2606    17902    SimCard SimCard_device_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."SimCard"
    ADD CONSTRAINT "SimCard_device_id_fkey" FOREIGN KEY (device_id) REFERENCES public."GPSDevice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public."SimCard" DROP CONSTRAINT "SimCard_device_id_fkey";
       public            	   nims_user    false    3695    220    222            �           2606    18085    User User_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_role_id_fkey";
       public            	   nims_user    false    3685    210    204            �           2606    18305 -   VehicleActivity VehicleActivity_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 [   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_brand_id_fkey";
       public            	   nims_user    false    3691    246    216            �           2606    18310 -   VehicleActivity VehicleActivity_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 [   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_model_id_fkey";
       public            	   nims_user    false    246    218    3693            �           2606    18300 ,   VehicleActivity VehicleActivity_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."VehicleActivity"
    ADD CONSTRAINT "VehicleActivity_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 Z   ALTER TABLE ONLY public."VehicleActivity" DROP CONSTRAINT "VehicleActivity_type_id_fkey";
       public            	   nims_user    false    3689    214    246            �           2606    18110    Vehicle Vehicle_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_brand_id_fkey";
       public            	   nims_user    false    212    216    3691            �           2606    17867    Vehicle Vehicle_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_client_id_fkey";
       public            	   nims_user    false    212    206    3680            �           2606    18115    Vehicle Vehicle_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_model_id_fkey";
       public            	   nims_user    false    212    3693    218            �           2606    18105    Vehicle Vehicle_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Vehicle"
    ADD CONSTRAINT "Vehicle_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."Type"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public."Vehicle" DROP CONSTRAINT "Vehicle_type_id_fkey";
       public            	   nims_user    false    212    214    3689            Y      x���K��:���yGq&�⛬�'�ܞ����������j-���R
�(>����*�~�Wz�;����?y�s�?5���Js�������������r����S^usB��?����4���Q��IB῕ҟv_��������kR���'����Nz8�DAc(5ch���?w��XG��a��6�{R�?�^��uae=V�o�y!');fJ�S�Uk9껙E�;Wy]�?w�S�?��f.G}�_�/�ݎ����Q�啚�(�ϝ��4㣋�3��#/n��W�Lz��.b�q�7���0rc�79=��~���O-W���o�&~��27��k͓,(���K�P���P�He�O�ם�Q��=XF�t�-���dC��DL������A�<���Q�/�+W��葟ל�o�C�a�F��ZE3>�Ơ8�1����t���ￅl���\R�a���U���7����m��o�C��k�Bi�u{�R�.��7�Ж5�o�܆Q� �\�棾1�K�����s���|�7Fy�l�O*�rJe��Q_��D<���y�7F{��0
=��*�uc��1��bAVƫ4�L-|#S�G]��Mi^�ӽW����e��p�4j~_�r���g���h�o&f=���Ն<�f'����1򫪐��d��#��A�d�����G}c�W͆ѸEo���Qww>w����͵ LD�����s�zy�������\���l����.��7ɟ�������}}_��#��	��ԓ�(�=���q�4��C=�*�|�}ݩ�q�ҏ��2aE_��
�e�T�B�s�'V�G}c�W�=�C��u���_-9�F�[�z�G}�&�o�tnOI�<�y�7+�Պ����+���֫U��n��Z?�}���0�wJ���Q��պaLN��v���1��`���׫�r�7Fy��0j�S2��G}c���ŗ?'
����r�0]��K_K��]�t9m�r_��A���@3;���$|׳�1�b�]��\��i}c�Ŵ1�8���.G��t9m�.�ܶ.�7�.ډ��Id���^�]�zB'w�[r�|�7]�a�?��?��o���0����h}c�E]#U|�o�_�o�������5��o��j�c4��k;���������ɽ�?y]�䣾y�m�t�;�o=�o�`�+y���y5���H/{k;=[�~�����ȯᙨ���m?��(��]J�-]c�(}c��(�z�B�0~��^�:z7���G}cP�6�Ao�S�ܮo������#����Q��5�0�p�>���A7i��2���o9�����/o�uͻ��Q_��j�~W7�㣋�v=���˱�v�״7�&��w�G}c���np��֕�F��i3��4�}�i�G��5��D���>������6��s���u�wHz-��'
��u�}��_�f���<
��G�c�����x��^���
�z&��=$����S3����-���C�k��f"���K��w�`��[���ײ��ѶT���Q�!�!�J����=^�w���V_G]p��1�9Jt��M���i�2�\���܂	�tc����!��R@�f�cTA�y��RF��=�*}�P��/04�3�y� ���S(����m��L�ɍB9m��(}�P��(���ɴf(�Ӥ��I��JBԼ07�8~[�m*H�;e�b�1���c�Qi\s���S(�����I�w���U��NI�xfB
ޔ<3�gՊ���wFó��-�OQg�����v�w��X�a2�/�iFd��|���L�[���]��a��t�U|>ʬ�]�BUK�"L�!�K��Q�)	s���<�B�ܝ���W>�;��☉a(m������B:�;���	a8u�>1 4����N�xfBz.��㓇�t�m	��w��3�,^�c��<_���?�NI�xfB
�l�8Z�D�8�;���	`(��}�Qk���Nn=�;���	a�F���3�r�~�w� �1�p {y�a�+ϓ�3���7�����7^���g%��x����ƅ����S(�Lë��}���:
-ͣ�S(���k�6$��St�u�m݀�wJE��C�I-2�X�FױvJ����1Ő�Z�ݚ]3ʏ�S(���k�Z%�]uH��>����@q̄0��{fx�Q�:��S(���xxf���)���g&�� �����kd����wJ�1�p /����j(?�N�xfB
`�0(�]�JY)���S(���P �FOk��>%(坑�p�D �h�f_P���O,*}�P<+!o��o���+���g&�!�˾��ȗq���2@q��0�^����zͮ���S(���r���[����M�;%�b�D1�6�,1��F>�;��☉a8fl�ܺ��q��
(�L�D�����12oJw�i/u�i�2���i�ѫ�
�+?�.G}�$P�Չb(��uaXf�V��;J�)i���K���׿3}���2@1f��5z�Z����)��c% �[��V�},Z�;%��X�a(���w���=S׽���S
(����wxf�$+�3J�)�LSx��Ӄ��,�xHZ/,��Y�A���6}�,P�_���y�#����g&���Ӌ�֋�h�}m��wJ�3�����3xO���
h}�P31�6�i�aM�-W_+}�,P�� �ߓzf}�
�%�u'$<#���b�w�&�yդ�G�)�HC�J��<ğh������@1f�@֋(�{�ǥ��Tb���R@1f��2z�`}/#+�Z����g&��/���lkò���G}�������B�^�����N�eC��w��3�B��+��c�aZ����1�p��gib9 _�|�wJ�3�p����ՇtS1ay�wJ�3�ܳ�{������S(����vx�+w+k>�;e�♉`x�ڔ7y�}؏����@�̄0�Ӧ<li�2����c&�� ��{+&)蛨m{Ь�S(�LC6�:a���J���1�p�D �z��Ӹ���.����g%��Q~���i=��"���S(�����f_j�x�sN���g&���Uٷc��Z�ו+}�4P��/0��1�����Q�;e�☉a8��c�p?�ڿ���3�� �G������u�#���wJų�P�����]���4��}�P31L}鹻�k���m��wŮ^#��ԩ�Х�|���Aq~Q�R�g%f澅G�;e��	a(z�j��.ABo��u�~��c�f���_�f7��^X�q�wJ�3�p�ڬ�{�9LW?�;��a�� �6c�*�k�u�wJų�p�ڌYxO����	�g&�a�6k��Y�ڎ�F����ɚQ�o�5���Ug=�;%��	aزMx�.�����wJ�1��ʹ	���G]M)�	�g% �x�Ɏ�q��Y?�}���%���:^xu����}�p�xI����Ft���;�������zI*cEθ����;���Y	a�xI���\�Τ���S(������J�S�Փ����S(��C�^ԕί@�3\�;%��	a�S8{f&��w}�?�N)�xfBN.^����I6��Ni�8f"��[e��w��ƕ�ʝ���t`�N�8��7�W������wm"-�NbAe�y}�䝑�� t^6�:o~��R@q��0�^�m#M����S(���/�ͿEA�UU�w�w� Ř�b���-O��T�+G}�,P<3��-O��{�F�G}�$P<3!������P�RG}�P31Y�[$����a(?�Ni�xfB���w}���?��X`8V�=��w�ޕ�4���u���@�0/6�����qZ���c&��x�	ƨ�ܗ��}�4P<3!/]6^0��k(Ȯ��u�3�Wbx�G}����|(E126�7w�$���wJ�1�d�-�x�!.NC�"���n�f�,�]g��W�����MQ=z#K-�5�:�;e��	a������; �ES��F����������    ��ߛ�d�JỾS2(���K&�7�S���)����wJ�3�p ۷����X�G}�tP<3!�}L.�z73װ�;e�☉a8��� �+WG�?�o��l6�|�� ��s��kn]�G�)�LC�7�<��²I}�TP<3!����߻ K���3:�� �BNod��28y]����2A1V��vz#K�9�#�jls�7
�����o�������r�<��NɠxfB^�}���J�G}�TP<3!�;<㎲����}�tP<3!�;���[,���S&(����f_l��C3�{�7
��T'�F1�6���,ϻϡ���S2(���Z�M	�]6S�0���RA�̄0|�;XeDYI�A6ygt0<+���-���	\�����}�LP+19�[{�{�����Bfk�j����w�zz��5����Aq��0�^��3L��wJ�3�p�zٷpyB� �9����g&�� ��/�p}+�>�N��8fb`/����8��o�2a��p {ٷ���m�ɏ�S2(�� &s<?�C�8ȼƫto:�����4�G�]A]@���R�עs�G�)���0xz_�Ӛ+B]�����;e��	aȲޗӹ��3�?d�^��g�̾�/0������5vįَ�NɠxfB����<�QR}�}�TP<3!���|����D�\"���Aq�D0��L>��z*3/]H�=��]8Vk�X�G}�Y�&s�Nl\�rU��7
Ou����a��q	xƃ�c�:
���4�d^ց+�m-\��S��N��_���B�gz��S�6���;��j����z�g=i(����.�1��u]c̣.8��CQ/��K7�*nq�����;�WH�r��K��4������]����%�:�|��*ީ5���r>�;�k%�i�D)�U��&ypf����;-܀�O�7׹��� �!o��Ÿ�������RM�Nz8���.�0�/�L�-g]p��1���C�v��{;��ꂓ�1q�l�1�3y;��ꂳ�c(j<W{7{�F��u�z�g<c(
B�]��;�K�弝3hu�ig3��7/ݢ���=�K���κ������Pj]l�۞��+ہXV��pC1'�[l��۞���s���%=�N�-6�>ͱP�X�.8��;Q˹�h,v�"t?�EV��pCA� �Q�}�"�Ԏ�ଇ�
�P1z�'�9_�V�W��Ny8�� �lx�����}�?�ഇ���p˖1T9g�!ڳu�Y�����ʽl�X���N������	a����6N����Z]p��q��@�-���D󺗾�]p��qA8i�t�'���w?���c(�^6�NQ�W���z8�P��M�m���P�z0v]p��1� � Լt��>�^�.8��8�B���<�*O{����+�|�'=c(�s���ҥvo+m�.0c'̙��$�ga���.0c'�I�զ���Ky����3���`��/8t�8��xഅ�׳��L�2��.�D�q�U����Wzt�Ny�����VhG]`*0��g��̞��cy�3��.0�Ufv�8��ʷ�&B�D��|^V��p��(/�dF�y8�qF�G]p��q�KC ^�^�<��l���]���qK���p�/9\w�.��.�K���u�����(��,�=��:�n�:��1�1�S���Ĺ���8�ސ�g��q�쥩8Wm\���>����i�@����1�p��Ny8�����w�'�v���5�Y��p���q7�n�1ĥ����~�'=o1����k<'3�Q��p���B�����{|kg]p��q�b��!M�����z�E}��ഇ� �@�Bv�,c�I�j�]p����@\��ޠoyN/��>�ഇ�i�@8'qx��e|W2��?�����j�@����\xZ�r!=���g=gH*�I�[���i����G]p����@����u���aF#t����0�7�3�O��Ϻइ���p��c���R������"�@��\6��{�KS�7�.8��x�1��l��"�[}Z�N{8�Hb�q2;V_yL�w�+��g=o$1�e#���\Q�Ny8����^P7� ���t��1-��٠�\��+�o�肓�3p�y����y��Ņ�.8��x#�1�z۠�&zT{�g=g$1�7mP�tt��w�C�]p��q�� �⤡�Q|�v�G]`0��'ݯ��lq���y�&�m9�5���G�q̀ޏ��`<;1�|���9c�6j��>�A��i�rPP�����y��<�b�������)� rA�����tW��8��L��S��}$�>��ଇ�%�@x�$3���-����$�x(f$1��m��.v =e�9��(��|?3�^���ͺ�{����%���S(��7��*j��.�⒅_����1��WY�3�y�y����S(����U3|��ڶ
Q�;e�☉a櫬꘡�@{�������c&���͘��{^
��;#�a�� ��3�x�r�u�wJų�p�����Ӑ�I��J;#eb^,ϣ�S(���w9f8g��v}�,P3!L�_�����[�nh]���1��W�m���<��X}�P��&�wlR;x!z}�kw?�S�1ݣ���v�͗���q����JE8��W�m��e|c�:�;e��ܪ�sۤ��xK��O��H`+1�}'�*a�k|�yg0#H}�۾������u�wJų�t��� �������c&��\R 5wB��R���Q�
�7�����k_����*�$���z�CB����9�enG%Z}��W�_KqL�X�[M��Y���f6���S�7� �A!�l7|q?9���[}�P�Չb(�&�p/�����>��NY�8fB�I�l�[8J~^��䝑�� �����^O�~�wJų�P�M���8Y�&����Ni�8fb^��T�[yE���g&���]�Ń�|@���?��X`8V�Łk3�B��y-}�䝑�p�D ��fޅ���%S�Q�)�JC��M��)���,���@�f�
�l�.��<T2{?�;e��	a(p�ɺ����`�{���@q�D0�f�uy�3ݹ���S(����d^�t�������}�P31�ɼԺa�pj'yg40+�ʺ8�<�P�����N�H+_`8x�c�f� :5�G��J �8p�12P�2o�[��S(�JC����߭񕙲���;���	a(pՐ���xR�E6�Q�)c&���-�33Q�u���S(�������Ao0x��S(���ޱ�T�Lǉ��$��g�_Cr�ғjG�*Ok�|�1��ഇ�|��#��B�{
�v_�c%�fx���|�c�B��T�w]p���V�F@��r��j�h�Y�eu�)�1�!�w��Ƽ*��Ջ^?�इ㬞�x����U�u'����z8���(Ð]��QPc\�գ.8��xkCC������+����g<omhT�z�ۮ���U/X������0j��m���u��Ϻ�����fn�eN���Ɍ�+������J�z��N�+Q�DmwCL�I:����g&�)���QJ��֌��NH 8F�=�{�+�p/�ߚ�Q�)�HC/�j���7��=����@�f��̧��iʄ񂉁	�v�wϊO-�p��7%�k`���,G]p��q�D@�~WU[����������Q�)	y���P��yR�����c&��0Ξ�����:���g&��������������}�P<3!���3�S�"��쏾S(���g�k7fP�R�����S(�L�<3o�P���c&�� �����^ڧ���S(���x9f2�Ӻ�V�N�;e�☉a(��m����Ý�Q�)��f����_ض��Z�(<��l���d_�\g}�P�6���L�������QO<��ߥ�G}�TP��&T[�f�ljؘ�    />$���z8�z�h���ٳ�$m��jG}�LP���d^�B����̨Aܯ^�Q��p���((cWv6�
Wf��Վ����獁x[e6eyQi�<�(G}�_<E�l2��.t?��g�u��o0�-�;C�l=���S2(����E���C���>���RA1f�z�u��'�Tzݗr�wFó�P��6�c�����y�w�ű�P�v���؃>��NV�(<Kݝ�gC��m��?�\}���Aq��0��I��I������3*�����<''��݅��3:�� ��&:�4.�ߏ�N��+Q��u>)q麓�a,���՝��X&N��^��Z��N��h+a��0��T�ᣁ�I��J ±b���2���z=�;e����1+Cn���{C�'���QxNm���÷h9f:�9壾S:(����̼=3�i�[�e�o(��6}���?�c&�Э�o\P�Nɠ8fb
��]���������;e�☉a8��c��0��jPk}����>'�%�ioS��ȧƵ~�wJŘ�b�iʎ��ԸR�Q�)�L�OSs��s��V,J������|��+�Fǹ5���q���L�o}�5�y��
�����6��6y��+mW;�;����� ��m�׶ᛌ끘����g%��Q�Bi�!�o��G}�LP31=z�eG���wa?��w���aW�Yj�A�y���A�0�z�%Z��אKe���RAq��0�z�%Z�ğAch�G�)�LC���<����-�v�w��1�p��'i`����4�o�1{���W�{њ�J�<Գ�S2(����������x�e���;��b�D1��n��ǩ���s���S:(��f���W������~T.�={�1�g���6��u���xs��Z�6	Oޞ��V��;%��ܩ� �ܩ�>n~��8��绷r�y�wFû0�x=��~������E��� }��V����nJw�l�����1&�ɏ�_�.�_��^�r�+�~���]����S�~�鏟_�.�c�'_�5���P���.0��9���KN�?��]��Yu��ߓY�u��.0yy���Sa���������h^��T^�_�U�Y���<a�x=��˙��_�.�f���Yy�qk���o`���׳���������h��"М��/~�t���8�'�i�g��o9�����EѬ���W��WNg]`&0��9sy��r?~~��
Gsq.O��
e_Ԩt���8�'�)�8�'ȩ��_�.�f���ʤ�`�3���#/�7��zs�-g>~~��8��sy�nz?�A�;�ހ8'DI�^��9��w���].�&K|(]`*0ޅ�q��)��[N���wq��,�0K�`~t���x�'�Y��\�_r������j�ӹ<����};W���q.O�S^���r���׿��y9��<��vл���\� g��}y�����o����敋�]-� ����q.O�C�GW�x�cz7��m�.0�*9�g�8�~8��]<Ю+����i][�%%H��QJŻ�J}����3�+��uÄ�=����Ӂq.L�3^�Qӿ���ϯG��+�5����u�]�'���x~�ɏ�_�.�d�+-�67�q��c.O���c�;�ʅ���L`;A������^JL��OQh��7��)X��\4�LƱ�p���E�]6\�\�.0�N�C�P�_A���>]�`>��t`;A�����4�!����f�ىq(�u��������W}���ܦ�7
e]�e}v��֏��d`<;1���Â��)���Q�
�c'�i��L��r���׿�c�{K4.�)��)]`&0��q8�mZ����D9)��6E��c���9-(ף.0�L��ql��gS���Ԙ�.0�N��ql�\����8�Ӂ1v�
c]�&r�`�.0�N�Ca���/T�y�y擼Cxp�l��S(��N��5pD�Ń.0�L�Ca�K"�y�yCI�LƱ�P��O���K�9���t`<;1����X�88U�3�q�9�6s%f����Q�1<�m����P�yਫz�َ��d`��0�C�fd,@��J�`~t���xvbe��y[<�E�u���8v�
e]�i^��"p�d♉P(�u-�.(���v}��ȶ>g�+��.J��+bK�z���LƳ�P��O�Υ�J3�]`*0���¸ٌ<8�Ӈ���Q��c'��0�y� �v��, �L��al��D�_)���c��1�p�l��ŉ��:���d`<;1����(Z��J=�S����8�6O�|��Y�E��Ӂq�D8�wI�c�h�����S��%8��(�uY��^R�g��v�w̸�q�N�C��,�a��<���T`��0�bG�'X(d���(HD��R(���h�E��p�|�f�	r8nL6������r���cx���'��C)P(x�c@��i�LƳ�p��L�y�E�.0�N��al2rz8N�0�u���xvbe���u�I���.0�N�C��w7����$Y[�;�g����o8�zc'�W> �]?]`20�� �bGo�Fs����5����	Q(n�����7m��}t���xfb������A�o��Wf��7����В`��LƱ�P
ԥ@��/fm�LƳ�pی�8Eы��_��LƳ�p(ی�ޅ�F9�2q̄(�67cr_����cx�����Cq3m�k8�x�ah�LƱ�P�L�s��ەTwi����	r�f�zOs��nr�C�;��eL��o8|�d�I7VN>s�.0a�+߬���÷�Z��c'ȡ�\U�x���&�շ#��.0�N�ñ3=;����VaA�;�'C�t��8���������S�ŻZ����P(���͹��ţ#']`*0���BYi�4�гX�u���8v��۫�x����:�3�1v�
eu�:7�/U^���Ä��cx:D���BY�x�'Lu�>���d`;A�r��T������T`<;1��}I����s,�u���8v�
�e_�r�sD�:�3�q�9��%�Wq(��wO��C׿�p(ۗ�S
c^i��j]`20�� �Cپ$���};�_����ىq(�o�'C�4��Q����P���%1�<X���t���xvb�Q�����u�v�w�gt1��8ten��'N�O�H��LƳ㐕�fe����wJ�G]`*0�� �C�fe��Fi�d���Ӂq�9�6+�)��G[κ�L`<;1�����e�5�Y�1<��(|��P�Y����Q�U_�.0�N�ál�2�庚�nG]`*0�N�Ca�lV^��|_5�u���8v���d���§y�ku���8v��Q�f��>`�^g}�peT���+]�d�2�o��O�A�������8;&+'ԫ�y�F=�Ӂ�v����yS�D#��.0�N�ñc��{���C��Zo���qc22�2�GG+��L�1�pܘ���'��(�u���xvb���N.�E�u���8v���MF����e�I��pW[o$��C��MF����<������8�������c���I�
�g'ơP�&#��K��|>�I��c'ȡP�6#�ۻ\���.0�N�ál32&��kf�w�N�ֽ/(�67^��g��z�&c̄9�6#c%>���5�LƱ�pی�x�e��X��LƱ�pی�x�%k����Ƴ㐕b3r{�q��`~��I]o���C�\lFƴW�z�J���q�9��f��I�Z3�]`*0���B�،ܐ���D}�?��t`<;1�r��q��k��.0�N��q�6ʥ��}�'�=�LF����g�xn`>m���.(:&�����:J������iX�4����3����8:ӳ��y�8�����8��Mm�K�Qٓ�\궭Q���1v��d�厛�4���Z���`��0�BYm���G�r�rG]`0�N�C����=͹
#ޏ��`;A���v�4o�{�m;]Q�    ��q��8��Cm����0�X���4@��(�o���ܚ���.0�L��7�dd>��:�y�d☉PxF��l����qe�!+]`0������|�U~
���.0�N��!l�17��ۭ�_����ىq(f���|_+烞�Q��c'ȡ�L6�O(L��G�(Y@ �L�³!�d������-�.0	�L�CV�v���av����J������Xm���Dj�Jeu�i�;a�q3v�"��/�>��t��;a�q���!�W�HY@ �� �gB�v��uƑ�cAV��$`3A����+]͏��S����8�˱S��`?.\�Ӏq�93z�Z�s¨�Zղ�� F���C7Jm�{7X�Rκ�,`<;!Oͨ�v�<�z�Խ��S���1v����۽�w���>��� �ىq(�Ֆ��y�2�oq8�Ӏq�9�ͳ�j�h��f �ىq8��c�כȣ_�.0�N�Sy�Hm�{���l�ƭ1]`0�� �CyzvN������ �ىq8��c�Yo����]`0�� ��fج�y�k*W��N*]`0���n԰Y�k]��R�Q��g'��٢�ee���1]`0�� ��/+s=*�Vϣ.0�N�C�<lV.8)�]}_�t�i�;a���ʅ�*Ur��5�.0�N�ál�2�K��Տ��,`<;!���*Y�����LƱ�p(۬\0С���.0�N�ál�2J�r��[_�.0�N�Cq3mVFiR./Yκ�`;Aݨi�2�����yu�Y�;QϞN����!-�<j�G��c'�!+�fe|%�]G�u�)�;a��Y����6��.0c'��<yP�=��+>o=_�@���"�D)��8�mF�L��G�z�fc�L��EzS"�盫3��']`0�� ���fd���/K�+H�3�p�l<xw']ȑ�Q��g&ơ������JE��.0�N�C7IoH,�mMM�U*]`0���Ǒ��;4��O�P}�M��c&D������ߣ�y�L>�Ӏ���87�C����=���|t��8v��/��t�Y�G]`0�����v��9O�^�b~t�I�xvbc��&��y乜u�)�;a��M��V�[=�Ӏq�9�5�v;4�(t�zٛ, �L�2�b�����͜�Q��g&��k�vhN�2qQ�.0	�N���c�1o+�.�&G��.0m'Ω�1���Z�J�LƳ�p��̟��gI��;��`��0�C�dd�A��d�.0�N�39�MF~���B9:.t�I�xvbe��+��+r�}XH�S��v��p(/�N�V��)]`0�� �BYo�{��ȇ��Q��g'ơP�[�Мr8����f�؉q��=�V��y�ԺϬ(]`0���BYo�C��ԴO�*]`
0�� �BYo�{�� �R�=��Ӏ���8�ͳÕ#�2�=��3����8�ݱ�+��U�~@?��,`;!N�9��g�q^(&?��$`<;1����y^��K�_��� ��	r8�mVn<�֎��4@�� ��Xo�Ckl�JG]`0�� ��Xo�{�7�Ev��.0�N�C/����=ͱ���.0	�N�Ca��ڡyA����Q��c'ȡ0�[��<�{-��v]`0���CYe���&s־cO�3��v��p(w�W:�.0�N��9��g��v_��_��LƳ�p(Oc��jj^3��(]`
0�N�á�<;�/��rT��4`<;1���n���'Y�?�.0�N�C����=͟��LƳ�P���mhN��:�{w[�S�q�9;z�Ӝ'ne��LƳ�p��4عˡ�5�� Ʊ�P�;�:v�$?�u�fc�D9�C٦����y�>���$`<;1��M�����]��g'��P�ip��X���y��c�9�zg�Ӝ�篚�Q��g'ơP�;�М��;���.0�N��(��δ�y��j0?��$`<;1��ޙ�4�F��o�P��`<;1��ޙ�4_\ݶ�r���ىq8�UV��Vz�^S�3��v��p(w����%��, �L��9��c����,ެt�I�8f��i�4���WS?j�� c�9�*#�=>���Hu��#�|á0ֻӞ杇��> �t��xvb
c�;��i����Z	��Ʊ��ޡ�4��8������8�z���Z�&w)]`
0�� �BY�P{�c��k�#H�3�)�wc����+��O�g]`&0�
� '�)C�N{NA�@��;J���6QO��j�A\q�zi��LƱ�pO�w��Zb�LƳ�pی��=��R}J��c'ȡ��w�=�١l�,�� ��	s(����^�@���)?��,@3
O���i��q5[�I��c��S2��%�2¯�4��w�2�ޒ�$.�>��4c�
GW���L�\�0�C�yv����u��xvba��v���@g]`0���+}�3�i�ʒ��G]`0�����ޙ����(QB�S�q�9�6�|

¯�.0�N�C��w�=�Q;��ٕ.0�N�C��w��y�<�<�I��c&B�4�+m�-�K)j_�t�I�xfb
c�+�i�oT��V�S���8��ӫ�]i����4Lb��&� ���v�ޕ�>]rG]`0��9�O�.���ק�x���]� 'qM١6��w�W��-�.0	i���p�< �V@D�S�q�9;���d�T�o{Q��`��0�R�ڕ�4ϙ��cR��Ʊ��T�ڕ�n�P_|j�I��g'��ܛLw�=S��	�\�����c��(���P���u�E��
D¹6���q�U�Q�{�f c��9�ձË����~�f�؉qxM���4o7O��'�i]`0��'s�tg�]�+�N�pS�[O肓�� (q1�1��O�ULj]`0���9���K�9'�Տ��`;A���t��l0?��,`<;!O�M����9���I��c&D�7���gE,�<}�� �	r(��}Wa�'5߷�h]`0�� ��x�WCE_ך�� Ƴ��ղ9�����<���q�9;6'c	*o��g]`
0���cǦ��%o.̍t�i�;aǎM�������û.0�N�C)p���=�9�Q��c'��y�eS`���R��N��$@�� %��mS`���\ ���.0�L��y�0u	T�L|mP�s��u�g>i(J\Ue�6	^H�g��.0s}���}E�hQ^��Q��c'ơ/�y�n���
U ���� ��l�Ϸ؀�u�)�8V��J�jΡvZ��c'�������Y�J�R��� Ʊ�p�W6��qͭ���f�؉q��}5`Cz�����#H�3�p����Ωi�q�� c̄9�ɾ&
p���~���ىq(��M}�<�+ϳ.0�N�Ca�r��<-/U�V�j]`0������d31�ò�R���$`;A�r�y�O�)Yc>��`;A�����O�\˥5�D|t�i�8v�e��'���Z=u��xvbe��'�h��ڳ�|t�Y�8vb�ġl32��r��6���$`��0�C�fe���I̩h]`
0���B9۬���2ĹZ��g'ơP�C�ρ��>�wKi]`0�N�C��6愩����֏��,`��/8t���@�4����ؿ�.0	�N�C��6��O�Ыg]`
0���C�;c
���պ�4`��0�C�;vʍ�u��8v������g]`0���p(O�N����$�LƳ�p(/�/[YWi��LƱ�P(��G@%<���#�L��	s(��y}ܜ�j@om��u��;a�r�Y��$Z�ҪG]`0���R(���pr�1���P(�M1$Z���:���1�*̡P.6�b�?}N��u���8v�e�M�X���r>�Ӂq�9�6�v����Ϻ�L`��0�Cy�����Gk}Ǵ�N�ál�i��G�zG]`20�� �B��l:0P1���L��	s(��ͦ�**׃G]`:0���B��l:8    �R��y�f��	r(��ͦ(L�5�J>�;���8v�
�j�26;pO��LƳ�p(۬<�?�ݚ��Q�
�c'��P�Yy��K��{�_����ىq8�mV���g�%}�?��L`;A����>�7�8KZ�;f��;a���ʓ�.6���LƱ�P(7��'Τ�w�z"v]`*0�� �B�٬�I�/�W}t���xvb
�f��D�ꭕu�f��	r(������o�R����	>��+�r�Yyb��\E�u���8v�e����	wg�G]`*0�N�ál�����}��w]`:0�� �C�fel����Ҏ��L`;A����\�Ո��������̧��w�xaR�U�) ��ʂ��6��C�q�<���U��&e����Lƹ8N��,�̺����|�\��H��'��T[�1>���a�ݼ%x�$�3z�{u������P,w�����~�q-��Km��%���r7o	.�y�Y.��LƱ�p0��*rw�̓, �L�B)Y��CىWh�[E�LF����a�=;Ե�r���f�ىq8���������J�h}��L��#���xzv�:�5V9������8�˱ï[�������؉p2���Tj���ri�����|�aLs��.~�ڴ��?p��>A�t���x�'ơ`ևᜫ�1��*+}��\�9~��޻���*���Q��c'ȡ`V7�攨���Cc>��T`;A�e�q�i޸$�L�LƳ�p(��D��R}?�B�21f�c������D�;����.�o8��Qߕ��ʥ�.0�N��al_�+��v�r��b�)����q�2�q���	r(���ͧ��a�7��2��D(�z���cL�)�cx~�l���C!��F|f�N����d`��0�BX�Dsz��}��u���8v�
c�G�+܏V���t`;A������8b]�3����8�6/�!<�^����	>�%����Ƌ
�Nj}�?��d`;A���Ƽ��bw�G]`*0�N�ál2��_�3���.0�N�C���%V�����_�J�	����BYoKDs��m������|f[�7
e�-�iλ��5κ�d`<;1��:��ݜ�Ջߵ.0�N�C��wI��S�h�3aJ��c'��Pn�.۵���1+]`&0�� �C�;Wȼ6��|f��7����ڤ]��ֺ�d`;A����,�i�LƳ�p(/��cK�j>�Ӂq�9��NɧyA'��.0�N���c�2J^RoM$Q���N�2;��$�ج��>��흏��d`<;1N!��ʼ��#��y����	rqlV���2�Q��g'��P�Y�����0?�, �L��al32F��qͱ���Y70�� ���fd� ���e��R��d`��0���fd���\��u���8v���z��i�3g�z8w]`:0����ؾ ��s�ͯ��3�q�D8���I�~�1\0�,��.8��9�(h�!�o�7��4�zԷ�p鍠8�q�W��Q�
���a%S�������g=�Ӂ1v��B��3�o�w]`&0�� ��^W��~���п���Q���á��C��]����κ�d`;A��}�u��B��LƱ�p(۷_o�]��.0�N�ál�����|嵎��L`��0�Cپ��zq�̓�c��g'��P����>�0��LƱ�P(덠Os��{��4����ىq(��FP4�ӹO��t`;A��^>T�%;J�ƪG]`&0���n�����q ���{>�;������o8�U�v��9��c^�.0�N���f�K"el���u��c�9�U�c�r�Ү��Q��g'���Lޡ�Ĭ��iJ�	�c'�Y����>�q]��z�ىq(���������;�u���xvb
e�WN�}y/�W}t���8v���*z��Ӽ�6�)�)B��g'�!��de�T����L`<;1��}�&l��潏��c����p�j�ɢ�cmW2��LƱ��"y�w
�dЇG;�R1f���jz�Z�e�u���8f�>��|c%`��5W?�3�1v��N�B/���������%HĘ	R8Q�+����*�K�.0�L�3�%��y����LƳ��5�+ќ��,��^�S�q�9�Z��Bs.1�e�Z�LƱ�P����U����No�� F���C�%����>�]sJ��c'�ἥ_�o���{RW��$`<;1���R��y彃w6��G��g'�!�^���_�{{�_��LƳ�P��K&��3�M�o U��`��0�BY��9�M��}���f�؉qxQ�^��4�S
�VϺ�$`<;1��ܦ����S��|�� �ىq8��c�9��g]`0�� �BY�pn�ii^J�W�R��`<;1����4X���Q��g'���}��.���o�4N��$@3!
�yW���kiȏ, �J�xݱ�k��5� J��c&��A<���([�{��f��	qxjE�X���u^}֣.0	c'�ɯ�+i=��e��v]`
0����XM>�'�%�u�i�xvb
e]I͟�6r�G]`0�� �BYW�j�:`<%m~�G��g'��]I�iΝ�k�_Y@ ����XW�zZ/$��L�3�p�l��i�=����]`0�� ���f��.fqe�xf"a��yLYCW����̄8�C��Ƽtj��d�, 	�L��!�e�z�(�� �	r(�u����/¢���, �L�B�+p��Tq�lu��8f�
a]��i>8��m0?��,`<;!1�3R��\v��
D�X	1�&ٔW�W֪IU�.0�J��7ɦ<��C�9I�Gv]`0���Q��31Os�~�6���$`<;1ǌM{�ʒ��L��	s8����1����Q����P(�RWh^2/D,cu��8v�
e]��iޞZ�g]`0���S(�RW���;fI_�.0	�N�C���ۻ�f��;k�G��c'ȡP���+C(Ԋ\��t�i�;a�@���KE�p�E��3�q�9�,t���y�;Y�Mv]`0��g�WuoV�Xl�>�w]`
0�� �cǻY��}��Q��g'��4h_�(��%q}�?��`<;1Ŏ34�z�|@9���1v�ޫ��:���-�=�S����8;��1�Q�^X�LƱ��}IL^���"���3����8�dĆ�z��U�i�fc�D9�~U���f��J�.0	�N��s�f-T�*r������	r����dOs���J��g'ơf���Ӝ�ۛ>��Ƴ�$�s��=6�'쵗�B�������kgጳ����`<;1N}�%���<�u��1]`0�� �g�];��a0?��`<;1�|;~����c-G]`0����8��h�oL��|�&��	rx=���z�V��(����S����8ʦ��T,L钣C�, �L�BY��Zc�D�pT��`<31���¸`��������q��8�����7Gԏ���LƳ���}��:�k��_��S�1v��@;����a�5�Y����p�n;7Ǫ4��T�3����8�����7oO��y�w}��8Ρ�{Xќ�/Y�'Y@2 ���Ҩ�Ï��rW�G]`*0�� �>���X>�a���Q�����>�ua��^s���}hQ�3�1v�Zz�&��.U.�׎���7�2�7��P�V��FsN�]�ߧt���8v�J�z���{x[���LƳ�p(7�N�hx�OrV��t`;A�rw�4^�s�}s��f��	r8���Sx[�=�:�Q�1<�c�|��P������v�$�	Q8��c�OwQ��.0�L�Ca������ݯ�R׮LƱ�P���Os63�Y�	�g'ơ0�ps���}�^PL�;�'{� �7
c]G�i���VS?������8�z9=�?C@=��.0�N�ál3r�N�����.0c'��P����>8z?�3�q��8�cǦ@z�uԅ���L��	s8v���Q]%�] Y  �
�g'��رY��N��>)G]`:0�� �b�l��(��X���Q�	��Ya�A]S���*P��Q�1\'����C��G��{���W��Q�
�c'ȡ���f����z_w���LƱ��Ͳip`�W_?�;������o8�wt����.m��G��.0�N�ñc�2W���ɞκ�T`��0�cǦ����)�(]`:0����}IL��h�}k�G�	�c'��P�Y�'��~̏�a2O����o8�z�����~צ1]`20�� �BYo������}���LƱ�P(�OsL��^�&H�3�P�z�hM)���N�}t���8f�
c]O�i��S>糾cxϋ�'���ؾ &q�����d`<;1��������[x��c�9�6#/�瓮��Q��g'��P�� �v�u�d♉P��"]��s�Aq4��wN��c'J�p��V�9O�����	a��(�ࢿg�y�T���.8��h;q#���ў+�k�~��?�P4^E���\Ъr����
]`&0�N��KIL4'�G���Ԙ��cx�3��W����|�\��8������8İ�|���X_i�.0c'�itӭ��c��u��L��	sx��>�
�<Pv�d♉P���y_%��9��Q�1\J�T[��Ca��_>ͱ�0�מ�&�ىqʫ��4h^/�[�$H�1�Pۗ�p$.�+��T��t`3A��ٸa$���)�.0�N����|��1��q(�!T���"� \�C�]O���i]imP��d`��o8\���ͱ<�)]`*0�����s���ԫ��w]`:0���רޞ���'�~t��f�ىq�Ni��Ln��E-J�1���1}���(ͳ��[t�k%�.0�N��kTm=��Q.��C�LƱ��rk/v*��w���ىq8����	�򛬝�t���xvb�\8�'^�@}؞t���;�K�y��9��/yv&u��J��g'��΅��W�H����Q��T`<;1�����/�Mr��Ӂ���8\r׻:=���=��3�q�9\r�{�6��Cgӏ�c��g'��P�y唹��J�.0c'��r���8�oʓ��.0�N���];X�"j(]`:0����!z�i>x��P�]�	�g'���ڙ8�a���c��g'���}�3�1�N�G]`20���BY��Ds����]���T`;A�����^�FI�LƳ��&��<��w����Ʊ�P(��$O{>�Z�YV���~{ѫ[������0�II���]`20ޯ�q��ϋ�_��<�����ىq(��t�x�������.0�N��Ej�7��B�9�_���Ƴ�p({o�r�Gk5����c��c'ȡP�S�㽺�'��Y��g'ơP֫��\�N\�t���xvb
e�\�i�xꢚ{����ىq8�ݛ5��D�D|t���xvb
e=����M���u~��[�����6yʾ���9�~�g=c(
�9΀b���x�Oo�<,�0���ޟt�iG��j�YSs�?��/�r�� L�겆+�1�p�v��>c(
��GҕGˍ#�pb���J�Z�u�9Ozb�p������9�Ｕ�ߕ��]���t`��(���N�M�qdz�S>��_j.�ݺs=ϴ�׺�����i��շM�Z�)8 RM!=�:إ��.8��KM6�����O����Z��p��(h�Pqq����U0��p��kH�9W4�0���H�$J{(��&�1�2�s��gPo�'�X]p����|²�c�i���ݷzV��p��(��!�c�۞�������इ�
���!6��m_3WG�)�cdAYű��1�}��������L      O   �  x��V]O�H}�
��f4���[6�@���V�J+�Z�"�(v�e��k�[�H��̝;�s��dE���%�\�շ�)��D�������q��VlYw]�ÚT{n�#�e�۾=
��U���T����7��ch���k5�=�0�JɃ�L؇�+@%��C���?�g�q��\)�i[\,{�6e�n^ Mjd�W޲���h6-��+X���-����W�FpF�eE���}�N/�?X�ڐ��5H%�c��^Wm~�t�P���Y��w{_��N5fx� dd�q�w�ouww ob����Ԩ8�K�G�e\T�wM�nWO,����[�[�n��|d�w���?
5h�Hk��6����;.9��dK��|��%�Q�BPfY�:ϛ�ܴ�ǎ�á͏��!K��F��J9�:�Ʃ��}���R���d}�D��h��kօ��k��wq���Dj�����g��]K i� ^��d���Mہ˗��E�&�����_�\���1P����üȮ.���(���d���e˓�A��
S����Ȱ�<�.b�D��UԂfEv����:6�	w�;`�C�}H�h�%�D�Ȼ�l�cP .ҩ�pY"ވď��}z��dT������}��k<4�$��W"���ݿB	��� ]G�J$�l��u��j������$�)�L�D��K]�����k��Wa)�'"J0����~*�'����K&'U�T�\�k�a'm�z_5��`��1j��eQ���Ce&E_��֔��g����4��-Ow
�<�Me���-�7{���B�T�A�+&7mS��e�Ч�!P69`����0X��|�l�8�T���!lB�(�t�w��r����:^W?�����`E&W	�u��S��](-��QJ
�[����l�<�e��z��b*�(��q㥒$/,R
��������,��%l=E�%⮸�|��>������!�L���G�R(6�+�U�����z7{w��XBӵCFH�^��<�Wu��O]_=tϴ���n����5����c_��H��`�'$�mZ\Ng_�wtƋ5���a"�f �lZ�9�hq���a������ƮY���@'6�"�	�����?��03���;&�,�g�K*O�"��P{z��~��6|�YXӌo�,�.�'Y��{�d7��b��ʣ(�D�M      E   �  x��Z]s�J}�~�<�p�Ҍ>yZp�׀���.��e
��WH!�������K��H,�������[ ���9}�ǶІ;�eʮ�8�Q�l����l�Y$�(��~��e&�x�=�xK�R~Y�,��7��1�0�t�ӵ,ô����pK6�E1�.sv�&�+k??]h�����h3��dm�f�0���l�1ϙ�.�^���J,{�ћ������t���@�Mv����d%36���E.�9�-aZ���m&�9��J��MA�'l�l����$e�w6�����9���2��H�F�w*�!}+�,��6+�{�)�{��u,�[V�]��A��A� ��d�N�
��f-Z��t��f�d���|�
Y� 7��;��dr.�t��~���u�ݵ�a���i_�Y���4y��Yr��0Mѱۦ�t�6�#�~��&�v��#��\�V+u�]����|�+�/�2&��ҭ�W��&7��?�յL�q�S?N�z�6ΟWь�%�{����L��$� Cd�d�E�І�uHU��G�f���d:,\�<���eb�-��{4���ъp�e}����<����G��]@;�����6ࢄ�o[l��Ȼϒ"��M�FrŮ7���_w�o]���p�dױu�2�h?�2޼&iVp�k��-{Y�|�G�
�8"j"�&���5L��*W�5�z�³ڔ#]�6��Ae������w�:�ۓ(^Ó"���}d�+�յ=�5�&�n	��@�=!�.9��Rn"��fH`ɞ��杖����ā|h�o�떭��8�30�ߑ�yj���]�` {!,�Z�;J�oK��nW����#�ڜ�ٮa�����k0떣�W���$])R�-����^{B���9��`���VX�w�~��ڮ�B��u��P#�-I��ʿֻ~隬Y���;X�2d��;�1�=�/���Q��X�'U����El���d�-�RI������;1�:���#eA���"u�d�ͮ%��&�UEΨ��b��\o����^ �d��x�d׭@���$�h�̈E��Ol�,�M�P\��|�(*q�"�"U?T��2�ʍ���t��I�؂q_4�unj��XpȓA���p���Tc�hn��5)�<V�\ทk�˳��}��r�7�u�� x,�<�g��L�n��T��^E I��P_�Y�z�U$c�۵\���g��%��2��_D�*�mT�K��F�m���\%@�l�o��ɪx������a����0E���(	 6R,P,9I��kW|p��;u�(TXbϭ#��:w��߾==��0�U)�)6�A�F��@����9%+DL�@�Z��vt� N��!�̮��V��:���4��w�=-_)()[��Ql�R��R�G��C����Il�(�I�F��J��g��x�	�T!w���A���	,�8��:w����p��k�"V����0����1�+uy�m�	��6�m񓨊��**�:����$���XS[eL�e��� �,�v`�^=�]�>=
�~[��6EK=�Q.ɽ݅V��ϵ9d;�7�uajq���I���rs��w�&���Vscf�n2䠖�tm`����+y*����*��w�V<SW�j'���K�Mv]p�X��V�Y/M5Q4ť,-��[(�?��RyQ]�A��]�+ڊ�]X����V�,
v�	Kt-�px�]`����	�	�-�A����Kѷ�߳��}��C��_��M4X�#�&�.lm��-�5+���|γLV"��G+%Z�+�ԋ��w�}�m�^b�e������5�u�lFu��B�n�2,���]nQ�F���������	���B�1Pj��`��e$�^�C�a2�5~lcW���ª�S�uA$�y�4���������$�����X�ע0�f�;���:�$���x�ɮ_���a�&+���>�?��-g�%�E\V�f� �S"[����Vt�S����m���.�תt���lx�=G�K:��z<���0�g�u�` �N�5�u���)�2:��q#��������6�TS�O��"d�!Z��C�A�	H�R.+zt���7I1@�Pk�o�6��˦jI�$^�����yu��M�U�̶+�n�Ue�IV�C�Vo���wWS����l�tֲ|�A�m��fn�a%hj96�4�u���t�5v)�0�������:�3E@��]�w}����a�]ΰ���qӭ��; �d�m�^�K�/UT����%����( e� ~Y�M%�ś�}u��$�F�r�I��e��plG�%P�~��E≸��V����^f�:��y��a.�1���.Y�B��F�B���f�{;B^6�:О�|�7��Z>Ӑ�C7TW~O@�!�稊�T�
�PSP��ޮ;&��l'+�ry��@(�U<�)N/.ޜZ���R��oxUM<��؍=5�(2���뺗���v�J,��f��^�T!�`���e�o_��X|\.8�{�8Q�u��>;_�E��4a�E��lp�����e���l9��0¯`D[�S����n3:�Vꌎ���CUݱ!�&����^jZֳ�cA<��s����_�9�l�X2���������=���E������d�W�lزo�9���偘��Mv������ݰ����Qoz�0����ÿ�v��Y����C�F����!Ҙ��&��Vq��a7�Iq�'��4DE�˧#���c�ܮf�''^E�{t�/:VD�-t�Mv��=�$�U�T��^���#��hD2J�y�� ^BVBe��/!��̘(K�n�]wM�a����,Y'�P)�@Pm�ݛ7s|����Jo���p~�Y�Zlϛ3<p���{�g'v�6��Y���h'[�c�Dڐ��h�S���5�P{N�Ȝ��D<��j�-=+��a��?�޽#      k   �  x�ŕ;OAF빿bʤ`t�n#�L
(i,X$�D����Y�֞�1�����Z:�1߬7��_�z���6��K���bu7�F/�[JU�"��o�g�W�����w�J�C0��$TI.�����}!��"5z���8qȆ�_�!T��3�8����«a��_ݝ!���+�[H�`�v@�e�[��>2/��KQZ��N����Ń1N4s�=dR�aq2��P�w ub���<������"do1T��KiqЄk���j3�r9�׃ݡC;����ЧC�p��B����a�����8��Y~4�:�@XI�M-zb���q�_@1�i�۹�N�xRK�☨Ł����>��8<��ny7������n4J7�e�Is�jӌz��40�K��w��E�f��y�W�)-?��������̊ �� �R�K�"�S	�*"�p4ٯ���{�c������v �|�o�      G   �  x�uXێ�8|&��?�����`�,�=	� ��¶KcK2t�W��-R���6��&,�[�:*�&�U߯�X=���T��ٯ>M�L8#��F+��.���U�ջi��f_OU3�c�mk"��OL=�b��Z����6e��ؐ�`U������jFSB��0��g��W�K��P���<�f_���X�5�D�Sv���s�[=�al� ��V[��cu�G s���k��Jf�锝rNl�y�Z|�շr$�"���B�\�zjc���v;��ມ}q�m� ��5g���{T�gL�%)bT��%��)��J�I9��	��[ϔ��$=�&dJ�[�v�U�`ϓ"bȥ� �:���E7ٯS���׌�E��H�)�!r��:����8�"�8y�P��:�������� L��YƬM�)75��}>��j������g�M�����컧}׎�X����L���[��E���ׄ����iD���c��k6��MCW�Ǒl�.C}g��);��E��u���_�U-xyQH�.�c�ǹj6�_KP�0՚�x�V��y濫�2�ex���~��}V��t�s�w�d�:_+��m��`�GN�z����o����s���C;�ø9�g��v����
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
t��`?�ב��Z���@wv��Գ�Ϲ� ��c�d�ɱx�{������գr��/h1������h��7�ky�Ajs;�StTT"�W'�HЭ썏7vjA�]��K!פ�g9��X�ZW�O��h����b����N1GT��������2�,�ϳ�8�{��g�+�+�4 �:��4����|Ⅵg����bys      i   �  x���ˊ�F�ך��rqQ��v�glB�`��iңzz�x�@ �d�GH������Mr�N_�*�[ndhL�����?�T�LgB��d_U׋rV]U�:{X���r�}Z���.���m�k���槶y�q��]��r�3SZP��lNm!x!41N'�'���g�e]ݬ�r]�xA-a�%���Y�{���^����z�:����@�.e}(h<����#�٤���y�-�+�����̿����^9_ܮ��(r����L���I��T7 d4�����M]î��6o�淶��m~h���� �k��F�aEa��)���/},����xT�7�U�Y�^W���ŷe�����/no�˫j��;G	���C &�67�ic�8n�\]HC���\�1����^��Ϫ������|��`��w��	K�-*%㺋Lj��F�c8.
�?Di��(3i>�F뜂 
!��vG2�� y�~?�_m�A�`\�8Ɠz��L�N����:��G`KVPM�H�H�@fS��?���g�ב�;nو{��tm�k�4����~D�k�߃�A�{���ޛ�^�Qi��=]тI��A/�t��x�/����bp��a6��E�`�FL��J�n�gk�#����UV/��Z~�ܙO�T�Rr0&j���-��Ϳ1UV0�(0(��jU��O�\,��q��r](�wɎ�,5��zd6<��d��)uR�-�#��㩰c�t��L3)4)G�TpFk��:�}(-�\%a����g��\p]��W\(��B��s��!Vؤ�Y�������x�w:r��\�K(Y}{�ґ+W�1���-dv�5K�H���Zz<ݻ!%J���t�tGO�.6��
�e�����:��5��{���b�*��e��^_��Y�o~d�P�K�~K�"�m��7u�����~��� ��I~]՗0��u5�[g�:Fc3w�d���MB�ctӨ�i�"%#�eZD�p�0c����.��Z#0/jS2���+j�WW��,���/�݁j���Èh�8��E�����DG۷Y�}�D��2�ҟa��t"�#�g�F�m����󃂇�lҧ)��7+.2��Q�*+���z�*hhM�K��K�9v�W��(�CA��%Q&%c *3&�n�M:Ԙ��w�q_��Yv�'u�a���O��aM�"
Y#�p�t$��h�>�XTeF.�E��?C'7�0|{��1Ȓ*r�������'/+�6�c .s��nwW��yxꁊ�D�L��x��t�Pl��k�i��sd��ꤾ!���:zzO$�w����Z��u^S7<ěm*Ű�9�ϙ��z*&�8�V%�pٕ�����&�ssugl<p���k)�:�#G�DQ4/%Nꤎ��������f�U��v˺�f�ʊ�+h�3�A�(�:��1��S�p�d�>��:bM�hd��c�p��bKꈵӑ���*���l�:b,�TX���"�,ԩ�GV{;PV���0�M�e��S)�3�jҺ��X�����p?���2,�#VdLF/��c���tRGl��b%�bc�NG,���k
ŉ�&�#\�Nv��'ERG,���po�(%����:b�V�I�=�=��h�O��[�tD�pbK�D��m��^�,!�C�'�低�G�̸��x�T����|��MS�8��p������Vn��ѸpE����>r�#�C����?DZ!wz@>!ggg���1      o      x������ � �      S      x����-;n%8����H=Ϭ5l���
F:�6�tU�~�T���H�����gsEH"EQ|�_�����ÜB���)���_�A���@௡���'֫�������������˿B9�>ˏ�~��p���of1���`�r��c�,�5�?!���꩸��7��Jn�����+av����?�����g�O�? W.��v4#y����ӟ��-�I��_�������PJ�1�	C�)��}3�b���i,�����?{���{}��7���5C+.����g�߰<��0�ο�Ix�]�͟�/�C�k"�5�x�TR�D�����_C��Obm>��?���c����}��#I�G��C����m���:6�� �?�N���4zQ��� �w��YJ�;�\h�\�\��~ '�&�j����'�p����`�����OL��Wn����˴񏭖�?�6�����̣?�i���{b�(�[rǍΤP����$}��o������K�1��'�DZ'ͥ?��W�C;Mk�+c�� `ؘ��'�[���
�w��9��{��pO�6j��$��j3�U��, �-K�� �߮[Z.�a�esȱ���}+�-�����������d����)���c�!��ׇ,��˟�I�K�[�2s�����*�D��M�ÎV >�IB2ovM$ /,��v�Lu޿ ڹ���Z��K�e��vy<,�$e�Z�4�u�Bڷ��#��e�i�W�ť?���Nuo�$;�aϼ��Gý���33���������k��P
���XH�VT-)�w>����a�~�O$���\S��T���Oz �
��?}�KH�Ě�tyF'�Z��N��9��;�O��0z_$-Yj���1A0�ɀ	�ϕ�\�c௢�B�)�/ۀ�H��-�yw��\��:�*�?��h����aN�lE���b���.�̊@�\�Ý6�j�1�^����%���#!Ȟ_�d��:���5.˼��?�D���3��c@��!'�K:���<-�V�J*]��1"RE�%St������̒z^(�&���Ubq�{Z��~$�:yc#�9�+.j�wR��p'#h>�d�ѥ?�YY�U�Z�3�qU.t� K����7�-�҇�DhX��J����]�ÿ�r��8M-[F�.^^���OI��X]�ÿ�r;Y� �ƍ?�3H'`���'��BN���+�K?Z�͝���}�[�}�����z�.��e?��VBpŊ�P6�
Z����'�	��O���|�AI!�+@u�R�x�p��3��b��J���u���3Hm�O�����=�ÝB>q�yxz�n6���#?�ˏ��g���\:��=��\�L������{.��#��������籏��[w� ���}�������t��Q4�h���g�w:�L�m�.i/P:Tgp�OL��p�]~� �t89k���/�kg��?:��E��	Y!]N��fXٹ�KET~��t��'6ǬC(�^�?8�7U��.�zK��?�
�f��{��s�>�L��J�� �\!LO�/nK���F�p=�>�In���挬(��'�����Zصdg��&V�� ����B�1��9�c�V��`�VG�A���.�Z6ލ���
+�A��Z�.���~�m�{�)z&���n��X.�s���oHVk���cO��������k����|G Z����� ��#z�5}��X�%D���Ͽf�mc�_�O���-9��	���
�U7���;G�6|j�Q��+�a_�n�;��*����Վͤ?��h��<���y��ݾ��?������`��D���K���i��m������I����&W�����n�����o��ဲr5�{���HOZ!wfSe�Iy�FڝO��z��_O�#�#����Oͥ?���;;R��x���y�x53�+�9a��Ϸi<�C ;�7�G�����Z������l�֗1{;�o���#A���Ů��S�d��b�8�
��Zv�;�/��%����Vb���6v9�I���2�,��jӷKb��Χ��Z�N��v�����/��Y:��a��G�r�������(6+�e(��BJa^��"~DZ��-E��$�����2=�?��[��J��~���Q�=�&��쓦�����j�̧�a���Z�T���Z��#�y$���z����n����5Y���#�*�����c=���^��(��,�Q4U��+�["{~�������?��/��z�콐}�ag���!ͻ����˲��r��͵t;�A�)u6��6��7���{�V�#c���<��"T���~����1Y.X���K;J�B/i�y�1��
�$-�җ����Òǋa${�&�]�2$9ӛ4|�t抭zKxp��?����jh���%Մ��XQ��mb葕;�ݼ#��{A�ղ�t�м�MAђ���g'���uC1t��\��-��0��"DC����Z]�����1�rv*�}�'Q�	,�,��y�eϊv@��^-"���a��s$,Κ����Eo��_��Zt��P���6Z���=<ҩ��WH��e�T�l�� �c��5���mH|�I+��;b������ː��ż@&��ǛY�L�h���4�%&
XE�i���e���e(���%VD�2��a�?W��V�'��'�&�@+�͖`'�7dV\m?�<��2[W0ﰞ��0��u��!�G��v� �u��G2?W$a��te�k]w�,�f'����7�JW�$�P�����&��3�է+ I=4����n���`��Jם����0����[
g,�IW���f�A�~�"�4��ɧ+C��Qߐ7�-C�OK��_v�ʐ��@�<_�e��?丕���4��Y��2��D�[?�w�&��N�2�e��2ʥ�b8����}!��5���IU���%S#����|�ۀL��U�;?f:k�A}c�[h�ݥ+{zI�j}�:C������5$��*U,d �cc�x��5�ҕ!IUR�����0����ӕ!�{��K�xl?�;ĸ��[�2$�� ��|?�����%+;�������.�|�&���i�������ư��e� ��ʎ$*�G"���	A�f���KW�$B����ar��ǀ.]ҢA#RH���Z���7�+�aE�.]ÔiE��Y����WB�zu�ʐP�����:;���$xdeG(��l��GT�]=W��90{�����C�ū7p�ʐ�DV.��aG��9�-Z�(wI�Q�!��\�+�a��ʠ,{deG+2��������\��<ц�I��6G0����,�����>�D։5�in��a8��6%��nҊEm�������C:C�n�pҕ!-�25Ǩ���Cq�_
�KW���K�����8ҡ�teH˺,���!'e��$�7�teH���fd1��4�J���!�9�W���x�P|�$�9E��IuUU]U��R��ѩcw�ʐ&�Now	�a��3�+�}�IW�4)unV4��6%Qr�79]Ҥ��@ׇ�aa��ݧ+CN$�a�����C���AxteHʡ.��aҾAj�D��I9TU���K��̗ĬF�Q�+�a�7�m�k�������P�����l�
}zl7�l��:(�]']ٓ"k0Wd�7�����]�2$E�桉��J��_�I����ʐd�M�/������%@v�ʐ��幀�xl�ĿDt�ʐd�MO�J�����ӕ!�L�&^���Pn��\@o.]r���P��0?��r��ފ)YّĴ�{0S)�Sb�M�H�R���T��e��c�a�k��F.�2$Q��<�Sd�[��o���5�u��Ԓ��]b��ҕ!��n�,IxHu��F2[�`��0ĿOw_�����P��n]��_����C���܅�y��6Γ��I��,%�{��	�٧+Cz��X��~����˔6teȉ�s�`M-��$���P�O�W�K>5b8gn<���[��te�V�\��X줣�c��){�=��	�I���O��z���:    -7�|eVĲ�W�˕_�OwmJ�0���\��W�0��H{�b�Ӥ�n�̊�3�o@ĺ
#�c�ϱ�¾��96���%gi	�+-��eC����:� �u�!�{�b#}$�ſD-�Gˌ�}�󎊯�_!mX⮾���f���q��c�{X<$di�C��!�ND9��,�o�D^���%�(�Tj�3Ot���o(�B2�Z�mIZm����I�;D���G��"YV�� rUS�z'���}�0��a�3��]�����v<#4@�<h��RJ�~,��婸t��?�&_�����!���V�Е!�݈
'���P�I-Z�4�ʐ�JO��;yX�d�ӧ�%k�ҕ!c���E����x�K�c8�ʐ���L�����o0]Jl�Ǥ?0�������}��ἒ)]r6�AY ���k����_�ʟ�)n�͹$p¾�&��َ��+����n��r�� �t)Y��B^�0<�� �����7��.�IW���`�uR�Г;q�*�R�� $8q�ud�'� �M����=�`��1�����;�*�lW��+{�h7b���W�|b������Ý�$@�ƆT'���@@2�Kv�
C� v	��[?oǃOḒ�KW�\/a�0��Nq��32'�#+{�`7��NXr�c�Ŭ�.]�����#��A:�@`�^Ѿ��+A�C�HȜ������I	\��'!Qs��u;�<١�|N�2$�k^An�/�������b�v��X�O���J'���8�_UF�j�sݒ�|���ė���5��/�F�Î�薲3��r)�ГÅ��JW �f�^2��1l셯\�2�#����e7��JW��i���*�Ñ�Q=��#�[�p��h#��}�٥+CZ׸�����?��<�]�2�o�r	I�K���#�,�N�ҕ!2>_��Qyl?�\��v�L�2����ҩ���,?LC�?���4]|�.��<M.��v�(Y�b:IDײ�� L���IW�$	��A*GyR)������ �W�5��|5%�	v�����~:�`<6����GVv4f�Z���d���o@��]����=���ͨws]�]��!��-������(�.`���� �h�t�I*X�+\b�81l��I�ʠ$����͇(�U�b�Ĥ?3�`^����?,�x���2�a��YR���	䢅Vlv�M�2���w�K5��Ʉ'�:Kv��$wy�;�40��dˡ��IW���Q��r���� P,S�#�de�������6;	�/��Ǥ+CZ�NA�A��!'~��eW��+CZ�� g9֯`��c�-��+ �Y>x�B�#Cn�IW �+��h�rX�����I؇C�r~O��ZB�� ���@��&]h%ѿ��Z?�M]����Ҥ+ ����D�N2N��S+zdeO?����߽���Hb ��&�EW�$��| ٝ��� Y8�c�����A��O)o��G5p@Qv�ʞ����QO�E���8oM��+�+K��d|~=�p��Ĺ�k�KKW��#\k9���Ŧ�J�b�d�.�L0ꥁ��Xܪ0ҲQD!q-x�+���Z�C+�L)����W�(�X-���D�������Q%ɵ����/�_i�(�pWΕ�Y�
ж)@�RY��}+��2�Q$i���)A�ێ��Jɳx55�|��-�Wj:�]\�p �7�����F��<K�;Y5a��H��P7�%I��3J��"Ȗ�T&N�''WƠhE���<������q�V]��+;�]J�vVI�����!fI�\������H5L��!d>�؂E���p�(���v2�{{Vk�ծ%���5X�E�3�3�%V��J������L?�lZ� (�ƩQ9���"���1�yWy(��hƨ1�ӏf�����_Ь�H�Ү��Z��'��ϙ�|#Vˎ ]��D�����+f�V�ε��c	��h�4�pX��<(&\��ÕS���iEB=��[+:J�Uv�p����Q*��##��$ĉ}m�h.�1�*�m�Q��$�a� V+u�����#�\.o��6�9��DW�J�}.k�����=�9�]��Wﬁ��n���X68��۶�h�Z��;�}傶t(X.o�����`�ms +u���$	���j��&!�K���m%�y��4T�泳�e���7E���V�G��@ǝ>?��+	%4%�w�ɓb�&.�f��RsYkW��5�hX�	>��K��^���"8j/�)R�� >L.��4`@J��u�����{b���[#�U������U��I���w�Gꢫ��%H�H��&�8�0ԅ��.�^!���'��-K�PD��P�7���X*pq���p�Iy=�.R����5��MV��W�\��}�X��u�
k���+����9GY�G~X�^���y�T��D�����L�s��+��0�J\���J�6��n�%�֡d��$�i��@.���lE	��#���mt2���u��.��|$��`�O����s�	�-����}��{#�e��s�= 4��l�5��[���(K��(n�\���i��ѐ����R�}�Z�Y]f�'�o?��75\&�씬+e�K�� V�t���c: dI�-�dUP�����u� �����o8����:Oj�̴$(�8��r��W��e�����s�ǃ�k�pZ�/�"��JӼ�S=��q6��8k'�IH8�˱ ��QK�$f��i��:�y9��F �'����x��Ǚ��d�b:���`9�<k�oeq���� �a���-�X���>�O�u��X@�!6�Y�.��l��˟��m�fa�.vW�F)')�D�[��������]���Qܬ ,"A;v�8�n�F�	�Ic�AW�),�m��p��a�A�`���}V��5i�@�����Q8;̃?�cy�H��;/�vɋ�B��)�Csiv�)Q����v���+/��9�O)�y\����|f��a�Q��ҫ�;?�9�B����>���)H��T�A ��jl$ިw�zP�N�/H����
^(�b�O8J��	i��I|y�Z3$u��;5g[�;!�2�T��k�y��R#U��.������?.n��ڠ��u���C��ĭ]e��Ԃ�<TX|v��X��oo!#p��5����!�Q:lB�Mb6 b3]��#�v'�ϕ?v{��J�>H�#�i�g��~°A"ARqkٞiE���XB�h���s��:�'6BhM�Uݣ�r��2	r�JM��3��w��[��"���{H����K��#����;H�R�M'B+B7�H�6�ű ��{��=̞��6]�v��^It��� ��ZZ�����}Ns�$����~/���K��ʈ�4w�~T�E<�Ue{6dj���f�&ZH[�A@%\�R��v&V�y����(߸�3#4��P��$y�1mn����{i���2M����PF ^���}YK4J[	;vRuX�`y��Ĵ��͖8�������k��*�}
4�� �Ҽ���Q�#/�@��4�����tk(k��cs��r�U�¨��j-?�m�a �Dطh�,��~�"H�����N �O�m�,]cZ� Y�̥���1�\-�M����0Ov�X��4������i�hB�y~C�${����4 �:�zwX8��0�i.ֲ� ��9E -��^��l�Ԏ�N�-�7:�Co���r���䳅E-�}�a�!.�|�����4I��sNy
\��� ���m� 7X!-�!l5�*�~���	 ;�SX�+l�G) Y��x��}�\�R����[P�b�`���2�nx��kq��dC8I�[���2Z��<�sGn�b�8��iQ{d�.�眾!Ü�j�o#3��d��y`KcMx���!&����T8j���I�ƽ��>7p���� 3`�I�Q�7jY��Y�T�1[�2X�l\���8�0T7�R]��<H���	� �ˇ.E���H�� ��5k��L����R[G�0�}�0�����5����q�v�����N�A���ӉХs#`ߌ%���u؂�i��e��n�0�Iu9���M    8i�\uHQĤLk�r�	8 ���!�I&��B��M�����J9`� e�g��&k*I�e����B��TB�<|������Z�ҟ./:���W���P�D�7$Y�5�E��U6��p�Ŷ�$B�:�a[���Q=ŎR�}YΠ�U��1���&�.oA
����D�Jivab��K��Y�8�R���ο
}C�r�t�u�%od��`�d��wě�z�P��s�~�ƵꍰO��k׶!����A�{YC5�Z-#)t��~�����&n��F��Yݞ�r��� �cK���Kr}�j%��w�i:Juu[�QJ���I�V�R@���8��)�ڷ��x����I��A�\�?�a=�~)wm� �����t� ���K��o��(����+�t��z::��*�2�o���HI!�Я��M,]1� v�0�\}��ͺ^�����.or�?�*IT[[��w�Bp]g{���?_��c�����D���P��!��-���+Y���Wl��HR�~Ƥ+7���s������RZbq鏚��~��=Y���Zv�A"�U!�n�?>�<�~��+��n$a;q>YN
>]�Ӣ퇄p:;<N�)��ؐХ+�[�� !�f>ƈ��hW�j`�%Yz�s�У#՜��T	�K$��(5}�l��%nC10-�\�(e�vA��4�ʟk���Z�c������l�E����0Kq&�<,�$/�,;%+;��5�(b�7�������%�L���pC�C���te���ج����a�PS��W�2��6�*3�>��%�͒Z�KWZ�A��*�3W�C�I�K����9���j+�U%~�^���+r�sb�w�Gx�6$��|�Q]���Rf�?|�^AC������o�B���\���@�H��*�P��GV ��xH���k3'0�W0��+�$���1��{��/Yn�OW���q�����R�!F�;cҾ�
A��Y8�
�_�&���xD��+������6���,.����+��HA�Zz�z+����RM1/���4J0�h'%(�7���a1]m��tŠQ8X���F�������N �m����KK4�!+�)�oK�O9a���ͥ+�쾉�sr��S�+U,y"����N鮤¡��}�<U���#�u��f����v�G)�[h��)�.]!�`w�"ǎ~Bpg����
AӰ���2�l*F0[H��$a�u	����E�q"N�eE�[mY�0�S�b�Z�����YO+]!h����>!xȹh�GVO�������L�=�=�"w<8�{���|߸s��z�6tŠ�TK��Vq �� >leC��ϜI2{-�>Ȉww���%�˵�%�|1p�&/IC5p���w�|�Y����> ێP�O�Q��BL�B�d�>&ǿ������������������������e|[��H�!)�S�ն���'�ե+}Ǳ���G��  F�k�G���4�7'V������t�NxdeJ?���f
���1�r�9W�����)ָ�_����m�ո�+k�q�}t"u�A�i���f�W�����aw6�򪮰Q�z�N����.�*l*>��-5|Èڅ�4�0�����b
X\ ?��G��7Ǟ0Ŋ�BR?�z����a$��^�����P�Bv��dvN�0�L��M���X��S�G]�\�[�A_�Aʿ��bo�\[[�@)���v����Y6\^�,���T�~����-�$%�{{�W��bkuq��R
�K�M�z��vǋxg�wi�X֍�}��6����3���u�48�{M���s&�2�a�v���Hk�"��)�k_����MZ�ډ��} �k���ܾK�e�f�(2�����S���G��~�F��ji�0���%FA��.��r7�$Ej�!;Y���r�$cݍ�a�R�=F�{g�+��,�ø��5iuB��ఔ�?*�I�-��~X��$� v)�&]��Y��^mQ�q���C����p#D��R��ta�lT9-s2P��
 ��w�C?qR>y4���{���G��В��}�������}����IW�g�>�/��#�p�"����
��|�ȥ��@�H�٥+@���� X~���۫ڽ�+G��ސs9�sSN�C�so.�A`uT�M/I[��u,��4	�KW)Hz�@[p����\\��?��K����#���7��}9OU�5x�`��;���Z���t�ƒ��\�.�C�����'T)�+����.�~�r��ԖȁGƶ��ΉK��G��כ?�t1xo��;1X3.����d(���S�F��ٝ3��]5�r��?���K���/[A��A����OP4���+�e�,#2� �+���D�db�:.\By^��2V)��6�A�c\�xh�̖4:��;s@��G���1��p���H|U��>�:&�̸�@⪵���t����|�{%~A��I눿������A�ԑ��������k�:�үg6���k���-�����X[4$�o-��f��ژžta���R�O�]J�.��[�4��/6�?7Č�[�¨��s�ة�U�����H�0[��uf�%n�v#܅D���+D��Iծ!���K���9c ��mb���ڭ>�t�����~�5�i�0��}�V98T��9�:F��(E)\�8�'AJ�
�Y���"�|���(�K��,@�b����= �eI��s���1�lo\��^��.��{u�:*���� �RIFEL���/����׿����"�Uv�YId�Zj��oG�M�8Zb��w���xX���Lz�$KIJ��-8�ƍ#)�!ne��)��%[{�f�p������+��Ļ�o�"�r(����_n`���!+w�v8E���
�(�H�KWZ4m�E����;��.W-Y!h�B�K���ӈ4�!+ �p����
��NI�Ϊ��W���<#`��p���q�Ko.]���ܓ�ޏ����r�ť+C��v�Ya�� ])���<��)��B�>$��8�% _Z��]!h$Z�!Hо&��9�=���b1y�A�f�O�9z���v@��zd�O���jB�<��$��9��t�5ҧ��԰Ø��)O�r�`&]h��!@��=��G�W�������'����	Z��N�%�t5{h���#��ߩ
+���������^��i'7$��]�cU��t��u��a"b�-\9�G�ܝ.�� �����b.��K�3��Z�վ"����{��a��r���W���L[8$%��#䫡�i����!(->�)���`�x�ζj1F�����l��.�懡�;.qGHk�O�b�_���
�{��(R�e��IW��cYxZk���Y2��&�;]҉:�6����eȑ^�7�]�2,?��Ȭ0���*�{3��ǒ�O�W��bq4V��Y���(�]�r�zM���i�V;ʓ�RI+<N�B�㱝z@����ԣteHl��Pt�tC���KZoM��']!h5�6]	�}"��(KveL�2��]���C��k\�2��0��������p�.5�<�2$a m���z'8��4!�k�ե+CZ�0{�2�a�
G�H�JW��Ta�L�6o���b��\��0��]�\� ���(�Bv�ʐ��C�h+<B�˝�*o]�"�J���0���`%%�R�.]!h,��s	��?]�R�k�KW�/����ƽ��S井��w��'7�1_���'�$c�BI��a@�>�
	�=�[@�Hh�Y� ��JZ�"���!�$�O��H5�z�&%+ 	�:�� y�q���Y�"��.љ�	�y�8��XpM/cA�tE ���<G�hd�A�ᄍ٥?��c}'���k� !5�z� ���:���й�F(9��+]Hs�f~W.x��(����4���y@(��ɎҤ+鍴_�ک�#i��s�(��tE`�dw��\L���Jj��5C,]!�]��jk�}C���\F�/de_ٵyp�}��;#��>{t������    �+���q�Rpٸ�W�"�o|7K���#F)��}Ĥ?4��a'�y��$�*��5�JW��m���O�w���"	]2�ԟY4S�d�]�2�EF�s�2�o
����n���asp�����������C�SB�x�� zs�
���t������yRw#��5KW ��%D]���-����~�� |>M; ��e'�ф=�o�t�`���@S��D�������-M��.�Fs"QХ+��!J�p-�/�ԥ�q��ʟ�
�}\{z�Î�JXC�o�t� vE���������Bj�ᬍEF�/o5ʸn׫��Z�,Z�p�]!H���t�3!�C�`�����z/-�G?!�ߵai<^����$�{�5����:J��GW �rt����,׀~ۯ/�B�X/�����sw�4jgt�	o�3A�����Gs&1�
A2q(�E���JɱE�� �pb�맃�yU	����D��!�ީ	+D��$�1/-]!H&N�
f��58q��p�%����D�P��e�r�8��#n��+��)�>Etv����H)���D��&ߟy��
%��%��
!���?�L�+����;�v����bB)��IY���8\N�:jqr1���_�I�fN�*/���^������z�e9�:��̩J{|��Z�"�v]O��uVQ�Vq9�[�B��h�Vڊ�k�Y%f[�\-]!Ho�5h��� ܮ�_!X�IW�[�� ��{wL�؋OWR��q��2|ROt��>�
A���J9_*F�OV\\�� �:��q���C���E\c�.�I�8�'�]�h�ܒ-�J��"	�r�a�
A���N���R;@�j��V��d�݄��uv�����/�+����$��T�T��o�Qΰ�tE �)�T�h�p��%�"�\j�Iaяi�L�va��<�
@2��;�I7��O@i���+	�R*n����x'6�Hv�OW���$7�h_VJF�-hj����?�K�k#���]:b�Wؕ�?��GdHG���v
��5X��$�<3��$�wdHVh����Dp�n!&]!H���TT�$��pԌ	��teHR۵FWч�a���]�2L�r�,����S��*�t9,��
�.+��0����<��+?V��H����3�n�6���teXe)N�����Ŭ��ӕ!�x����x]�fN��6���ĺ �
����ԍ�h��Bw�C����h�cȾ!ɜp��d��� ��1���P��-�tE�5�GH��r9Ape���B�
A��
����}+NG��ͥ+��V3/��>�)���aCP�"����>:@Hq�^Х+��h�o�H3s�R�-�zj.]�������ȗ;#I��g�V�3�rH'r_�t�V��O�2��pǾW_CV��!�r|l�6//`0��4��]�"��X"�f�]t/,oVE�r���I ��F�J�C�a�$�ٱ�.�k�ҕ?��h���c�ѹ���c5���Z�"�ʈ�����'�f��&]HcD��+} ݈�����\�uY�B�Ƙ�V|96�Y.�k��ʐĨ�ǥ�3��5�\D �"��ڨ1�5�����;t)�^�$�0��BM����l{� �2$a��W����,��#+;�QOo�~zG�H�y)>]!H:O�������]�����i�D�%��ӣ�]�W(�9���O�=��'�\��-��}�1J��4.��]�B�"�6��v?���[�.[�2�E6��+ v�\��)ަ3���m�';���k�(�aĐ��%�'��cP�o\�ޘk��`�~'�ֵ3T�WM�ؒq<��!'��rY�2$�^®�2�s�0����*�t qaW&���^��$�s������v5O�dH�];OXq\�z���P"���+)��j�E 2-<$Wp��O>%�w�����d��n��mQ��ru��
AJ O�]�V �OWR[�TOk�5���z����#y�QƼ�p���7;9��	8.�v��0|&;w����rEh�4��	b�J.�oj�
��l�����>A��|�}�� �mwp���Y�#�#�t�=%�Ô�W�;�X
����.�=s�/���ظ��J�&��?������;rB.f�?Jn����.���7��i���c"��@����]X�B�xhZ�+�aÀ�����m��Faׁ�'��	u���ͫ��^.�-]1H���.ev���Ҩ�_�Y�IW�����n:����t�*��Cs�A����K��g	'v�׷�a�@R��5�
x�9�;�I�(���$�{�Nv����7+�i�t� ��6�GiH���'ߣO*����aj��a��NG#��\L���x�}�� �v0�@�����+ 	w>l�5G��]땲��IW ��|�@��|ߌ*{_߆� $��E�):�(�n1_%U��$�K|�P��9W�0��Bs�
@2=»^zR_J\�X��!<d ��]�>������h��-��+�t9�����>�Ũϯ�=��$�#��5LU�9Ӝ�W����H��a�����3X��*��BL�b�@��w=��E�E��Rx%6Y�B�H/d#քλ}��h�%_}�B�Po���YV�/b�ړ;�t ���P�X���w��������n��n��e�U���KW��?�����p��iTSZuo��'���o:�WK���䓗����<��-��;�U�
öt����b�R���>�ည��tE q;��qSs�l�w��$
���静�!$��xG��"�,,aWK���QJ�Y�OW�����b�▌��p7Y�h�a������Q�A���9��]H�ڶ�щ:%_%I��ĕ�}����m��4xn��I��fsX�7D$mۀ�F��H�.]H�~\����L7��g�ΜV�"��͙�_��7 ��
X�
@��A�f�0l=�d�I��tE �;�C���9I�L����n�bS�7ߒa����-���]H��x�Y-�e���>� A��tE �ۣ�Dm���gߔ/�U��_�*o�����R"�	�;1����3y�h)��E'��¸9[��F=��օ$Y�_b{H�����V������bͭy� ��Y�%���H�[����y���$� ��`2tE �1b�V��on���EڇsqV��+M�R�G��B��V]ZC�]!Hk��bŘ����q�c3t�~5�4�s�냕�k@��
�u�d��쵴�A�o�6t�(��m����`����l�
Pu)�:�D��_�f�y��6ӓ��WOE@kj��Kw!����ʿ�X����#c>��� ��q���#������'	��0�KW�����ʞPNrXe� ���/�>c�~5��0!��nFv���t�_=�x��ٽ5Kw�K2�^��$�#ƫ����O����H|_.��LB�h����Pg�Z����d:�ګ�nN��q��$m�@B�s.�$6��7I����OP��Hǃs)g/��9��RI9T��$���6]�{p�bl�F��?HR�w�^ш�����WKTKW�xH����{�jGi��$.κX�4��
����q���$�������Pz�6���$sK��[�RL;���]���D�6:Z�q�����h^}�B������!y�I�S"4�כQCW�S�҆^͜��l�.+���I�N�U-,q�{��Z�.��H�`���^�|28U�w�#(]h=�)m��3qd�@��
@}��!���o^I.Č�[�A2}(������$d+5;J�� $�x�hL^���S�lٴ�]H�O=JK�Z|�vێ�$Ӓ�o�@}jQZ8�ܛ��k����CW��S�Җ]�-��SEFE�_1�@��DGnz�#d�������d�[W�2r7��f]
W\OԆ� ��UqJ���P=���4z�-�7-]H�� �!�~��N�V]�oCW�k<��!x�p�Q�_�L]CW j�6j�B��F|��`�
@B�6��I<*��G	e��IW�$p��%.O�1͜��    �gmjd�@�N�.��Y���Ys�ʜ$-����+)}��m��t�@����J{{Awn�W��hC 
�Z:45��@�SH=��W��$j�TM\��o�37Ϋa��$-m�F�ӗ�hZHyZ�IW���K���L�ĕd9\�裕� ������d�Gˊ��W37KW������o��y�;���b�@Ҷ�#s���܃������D.o"���uM�������?	ܹd~H�Ķs�g�����M9I�[Jv&]H��ag��F���'l]�"���SǄ��w�t��* i�
A[[޷622ܔ��I�����+	\�zi��]�%��� ����m���{��F�w�y���@�F�0vI�t��G1�f�K9q�����`4b�J� ��$e�����ZN j����,K IC9Ն(��N�'�t*5tE q�k9� ݚ��
��U\�b�@l=�YT���N<�dq-w'J�cn^t7�uϯdK�;��]��VS,ͥ+�p{�(�|F�B��x5��@�t�~��J;8��В�+I\=�|)~�f�]���y��G�62�zƵꑒ��%|�ͫ&6�� ���}8��z�)��ť����GK)��=:��i34F������]e�g"*��k<yL��h�����vE���5���M����]��ZJ��4����v䰛���Ku�vq�@��}����K���c�GS�ť?�t�!.�4�n ������tŠ�8DF!���$����|����Ꭓ�u5�#��*I{�b?b��TS�#5JON�����
N����deO���=�tӊ2ZNuTt������u�N�@ud�Ę��_=��'�t(Drp)oN�y���t� �t(D�Z�;�(sI"W<��'�;ա��3c(R����~C�@���ҿ�V�L4�r�8��]��,�D��ᘁ���hI�KW�$͇2W4�nI��U���n�9��]S��Mu�J	��wr3��_eP�"�0�����/q�v�:8�4�K�\�"�</aWϽ���Q�1�bP�g���z^���Wp���$!��}Ƥ+�t�e��U�0�$,�{���������l���)|~sJҿ%�;�@B�w�&aOg(��kA:����J "�tߢ(��:�� C7����D��L����VRz�cy�t� ��;h.��'�y�ð���亟�F��w��C��X]��_;ԭ��wV�T
;N��t��\�V��bJ�B2';H�� �ׂuG7��\�;�wݓ]K���믅�١��aGȲW�`ga����V��!��BN�J����Z��=�8�*C.S���+�A��k�r�86��A���{+]!⯅�LC!���b���[Xѧ+�Z8]���Q�<YJ7-Iٖ����G��#��<��R�s����k�\u%CW����zݓ�`�$W	6�+I�(X��6 �Fqq������d:��48*���u�����+Iu�~�f���I-/�f`g�GW�k�=}�&���.��wg�"N}�"�`/�Q3O��Ǹ��԰Y3���Gz�%0J�I.<�1H%�(3�OW�>մ���fV�I)��3Z�B�\��e!���,��I����iw�JbB�Z]�b�d���d�G�z}��ʻ����t� �&-�C@��g��<S��r%g�
A�Mzv)�����;��l��蜥+���E�6}`�=���w�����@/����d�4�������b?�핖]�B�h���  e��78U����5KWmȧ�1������%�� $nR�B��zfA�ϥ�^�%+ q%=�R�"�<T6�W+��
A+v���rv7�Z�o����΂핷�P*���]�B�`�QX�D��zp��x�6�����$w�|�෯Hr�\c�,]H�q�k����ܼ2;YC�Ȋ@r�������&�Tײ�=�@b�G�.�G��6ѧ+�5�b��G.޵�3^�h���@d�k<�u��u�� %�]�B�;k�k(�]��,X9��I�����qXf9q����@��-Ĥ+�6�MvA�Z�V�h�V�_7�
A���&���:ڰ���ɉ�]���$�� ��z* �'<�%�GV �lR��qZs��d���6���I��I�׺�� ��0cw�
A�}}���DJ�I��YuI�5Z|�?tnh[���݋���!u�#+ ���,P
��{9����h�R�m��U�k���J!D�0��	x%+ ���+�o�j򅚓�@����IW���S g��Z�i3��!(]H޶F�\Q7�s���]2گ�?CW ���{�jv�
�S��Ү^CW����䒺o��]�b(�d y�[wN.��T~����[�y�����l}���6^���ʇ��7��W[����=تx��P���톴Jc���ǎOw����Ȼ��{��A��q�W)�9o0�
��CB�{n?��8(��yd ��5	d��n����E��KP��+����!p�z�p������t�H�5��j��}C�����]He�]e�L;1� �}Fw�ͥ+ ���U�c��!�6P{�.]*o��"T_������t �Q�{�J{�{1juD�C�ť+)�Ch���?�ɧ?M<���1k0�[�+����-��
�d.y;�S�#��gp���!.��^�+���ٕRt�
A2]���!5�8�`����d�b��d���I�U�1 ���k����dz	���N������ㆠtE ���H-a���T�Nq�@B}����K[��+���IW�=�-<R�Evҫ��q��$�[%,�زg��m�&����NB}�������ĖW�W�6t��\|��n:��Ž ��5����{��0{��oNYJ��ֽ�+��f3�^�j���Ԥ+��!�,��ݫ}a5^�CW����5Y��5����_i�$ۧ>��y�a���W\�b�to�e<�ɿ�IO��B����t� ������
47�*n�5V����{�1c��~�����g:��`1&���|?��A�|U�O0P��5����D|���(�sYI�S�� �KW�%�mlJ�w^�N�˞�]�\����m��`��EC'�6�>]H��
_�C�Û��	��>]!H��p1�ܭ{p�L�Z�KW�W�n���:�:�;Փ�$��_IZ��J�Q	G�a��$��<�A_ ��/��������g����T `�$���7(w��Ww�Aʓ���)�-���Q
�N�~uC��J��\�Is�]s4l╣))1�d$����Z�C�������8�r��ȗm&��	ݬY!�o?9�s��I'�H�5��������(��Wv8H�w��
�~=�h9%���q�J��;E�EW���w,�{&h�p}��a�a���z�����"�]B7q���IW�������{7M�@����\���_׈�9!�����U�OW���wL�k�K�n4��հb�_1�[�Am/(1~P���^�nJW���a�I�� ��Tx���T�KW���Kw更�!��k�0�~c$�춳��~x�
C�0�W��l�/��>ki�ꂬ���D1�Z�.��W��9��e �k�^�/ɥ�W�!�.�d	�OBv�*��D*!lWh� d�p-WD�_�E�f����!��;�PI���� %ғ��,��-�s�p�x��#JoŜ-�]�u���+��A��Z��A瓘}�B�������h�|7P�"�^d�
@Zv)�F MN�:��	�9.o琡+i�%�P��V;<�����d�
@6Δ���ޥ��J�W���n�@
v�-��n�����2�եl��f_��n�[�[(p���5d�@�5���%7B8��NHa��tk��Qsh!gw��w$$[�\�B��-��t��-�|s*|���tE ��TحW�X�ͨK��>JJW ��CY����ͩ�&{����D�^*Bq{�ݬ$�$���$�KU7U�ȡ� \����#+{襤�� ���F(�t_.'CWh8�z�l#It��u���D��" �  �%?%f�\��ea�A[�n��e��'��Yٓ8���L|*�,�IS��0�VI���Bvkv}�����Tφ����l�a�����X �78�����vt�5F+ߍǸ;;�����W;y~�ʅU ���P��X��8|+�1Z[O:�k�ۡ���7t� ����2A�Y˟iID&�1��m�+)�E��y��nN��t�d'a��t�^]��{��eɀxb�OWRx0Y�+�� ��]=��>��XJƍ/�`���	���G�.]!Hc��`@Ɣ߾��Gdyu�Aj�� J7	��rj���g�+wոP�f�m��-�>!�4��x���^9/���~OR r����VS��_��z� � I���W�ѥ�@E_��"\*�������)�w G�q��E�.e	'2)`�ζ��]�ħ8�.#Do�ớ�/�9~7�P�e#���!��T�3�2�t����r��t]���h���Aa�7D��ރQ๱�҉b�bVH�#w��9h�.�K�AC��ݔ�N\b���/����"t�Z�f*�P�k���F�*�h�
���f��5�>�"�ũ�7^�Y<q܏�A�:��� ��B�WCz���Z%�Xr�_��Eޖ.�|=�����.X��b���$������(��Q�ť?H����2'���ߎ�]=���&��+�9[�,҅�ӯ������XCWtn�p�X�c�#�f�/w��+ G:w�li��^`�0��Y���L��d�M�G	�H��H\�y=U������=�Bm�-Ĥ+i@��jw#���5ϙ�1WZ�k]H{d�t��7�E����Ri.]1H}�t�h�eiy�+�+�	+��$�K��3���&6���p�G~�ӊ�K�����k>6e�.�V����:W+nĳ�/n����@�
@��&	���]3��ƶ���:��N����')��}CP�"�D��6�&�jCn��P�;���ę����P��Ɯidm�+Is{X�m�g�YY��WL�>]H����<ݔ^���47��]H]�M]��a��]�$R�MP�/���;�fͺ#��.��|�*��#?��2��!u��U��f7ƻ`��+	s�|i�"J|?`�+�s��@�������'��9��N���
YA?֪b����ʝ�NN���N��W7J{�+�i��:>���k	'vb�w��+)��,$MC�/������Y�A g.�Թ^��S��s�J�b��t�]����Bv�ABW�6v:ן�B�X���bY��ּ֨�@F}�Z�MN�d}w��$Շ6����	P�]�G~���/��Z>��J����,L�B�T�c[d�SV�lHz��KW�	u!+�|X{R�����N��+I�!�'���o���K��-CW ������HnM���[5\�'L�"��hVk�yي{i�4w�x��\�"�Ho���J���+ �F;�t� �n�Hc|������]��L�]�9��?^I�+fڧ�K���f��Ү��6xA�|�� ��z�rI��WE^(eZ�5����mR�1��x���a Rq���n守��+8钗�գO�!h�0lR�#6�$������}���K*��h�(�q���P7#��Axǝ�G��:8���Eҫi&������r�l�������ƝYkt������<�W(���r�_a�4�@��7�e�N~
�`���Y]� �^"R����T�c���TH�z��aȓ?��=tlwC��,��xXe��"�����b"-_�!�ee�Bt}b����1�>�>Ŏ�XU�WL�D �q�~�ګ��A�wE��K��;�v��c�j�:OV-z䉐�r?���F2ջ�,�m���ok���|����:K�f3+}�����=��GߓU�B�|s�������=+茂\# ���R�#�����_U5R�o~����0���������Ư^�I�Dt[�����!_X=������Cf�k�	+l��ѥO)���H�O:�u���o�=!z�KW���*γ�~�a�o\.���'��������ׅW��!�ѥO��"�G+��PDiʽ�su�������\G_Mx�G��	!�J��ҴmW��I:X`���O�(�B����\�k�ĝ�_��,}b��x�{F����+�$�,Jq��2���<�Ei�:]���h-��-��~�*��W琡O�v��2ޛRKuw�v����٥O��ǧ�����W������3taOP�["9��~`�0�m�5p��5�
¾�p;@bU'�����e�  ӑa��a�r�`f=ʀ�h�����I8��:�6+o��W���\��I��/�
���	�*e��Ի��f�g�X�d%C�I6�׬ Y�F��x�4IF=�9y��P����0��<6��q��&��'K����d�ò$e���}�I�,Y9��%�`�Ǜ��,�Կ�[�d�K�T�͒/o�1Yb�>(\یN�˹��'K�{��χ�>K�nq�E_Y��LbHeY��Ʋ˭~��R�%�	�Ò��<,K�M�>Y�x�j}XB�S�������'K&R�ό�[�ò�̾nZ�dɲ�a�%���R��W��J�Yv�Z�\�����͋����>AX�P�)g��O�]�z�Z��ɒ�	q.�4�6|�>]Y��,��W4�S����<�W+ѥϷf��C��sI8^�`�R�1�ÓW�`��w��ޫ^�����|յ}7R�b_�"����d��L�_6�����,Ɓ�OH<��b�^��ͬ�����'�(LhZ����@�jV�J�,��*����ְ `W�ťO�4�XsB]z��%�vy���2�6�-�^�nY�b*�#&}B�L�͹���{��J'K����cvk������l�Ӑ�R]��`O��s(^��� (�GVN'	[}DM��A�F��5���'
��R�q64����aGC" ���'��a�	!��o2Xɩ�;p��N�,�ism�JHN���Y��Y�Nv�a_
2������ʖ��
�w��`�'�/`A@*�����|+��m��DPY�ļ;��>!Xʗ��"B��N�0��?c�w��`1ϛ��J����UfU��F;�>AXгt�@1�U����h�KW�	��n��~�h�W�;J�,�ysd��7�DK�]��`1϶b�4_c�vt���!O �~�Ռ_ I�i쒚�	�"��O�UU,��������r���'�d=�|w���"r�@�=�u���x�O�bm�߽�7)9�755���{��8�ES����D��U�եO�%nJ71������tU����{��I���5�h�3�6,/��d-�K��)���&#0�Ӝ���xGȒIֻK�,�#ZmE u�������'�v9$ɥ���2Zt��Ż�ѧ	��Ɔ!�g�N�,�����K��{�^9�U;��\C�t.jJ�Ǧ��ܟ#��|�a�65ӱ�,[v6�IҘT+}b���!k/�*���)�EyI�d�J����([���FL���WH^M�W�ͥ+��pG�M�y�����W��]��'�_�~�g��u�)�DY��7�B����nᒹ@��4���Ud�<QX� 3����������'��\�B��#��5f(ms�樟��2x��(��/�;1_mK>AX��w�9%�)/�}�C<���v	����9y�%)"����'
o�w�ٔ���'@n�-Wc.y"���M�e���|��6���D�ȿc�h�*
��v�W:��È���ݕ>AX��`�7H�k���r�Wju��e��f[Az��χ�w)i�7Kx�Lh�[����w�C�����]�pT��������f.��	�B>B��L�M5����?�	��F��<�D`	�]�bkN)��a��Q^!�K�A�sy-{aB�
�u���gԕå��ݵ�K����QRN�|��v��/�� g�      g   �  x���Ϯ���)�l'I��#t�E�.͠M1IM����{l����.�%J%ه��������}���O�O-��R�D,o�����o������q��H���F�(���ݿ��c��?����<��Sy0?Do����iH߈���dc��b��^C����Ļ�/߾~���_������F]7}�R�V��#����L�3��~���ë����MVۤ��ҌI�J9�����{{H����1�0�X�X�	3&Kވf�W��v�GJ�ǬԖ϶k4�1�k��bo�N���%���i6�}K3�V��]�CJj�ܺi���#�ki3�f�LZm��P��L�o���3�֑V
��$%�Z<�Nmn)'�����昲ͅb�7�ZgbU�R�c�j�ن�M֚�υ���g��9��\
�p��ki�Z<��ols���th5�*���!GK����|����O;��	��
�x�y��<(	�`�e[ R �yQ#pT$�^����
2�T|�APD �p�= 3� ̣"�1G�f�������V�E��T@*J	F^K��>B�O�!	R� kHڌɖ��D6+�[[g��u's��2<�B��N;�ax2Crٗ�'���V�vGV�ܖ3���Bܗ� <����@rY���/+"�r�dܗc��F�v����	z�j�ɐ��r�q_*"Ѹ4R("K�$��^��э�D#+��������$��AjH�u��e�1��f���e̝��\�6�V�Qi�4��e,:�ͥT��$Љ�>�ś66)�ۻh�e�g�ؤ�AcW��� [���*6�6U$:�x����^�x���I�	j���]k�fӣ��:�lia�Z�"Y���0�&�;�dU �l�� �\��AY[WY�� �	R��2&�z<��>J6���C���N���e�`�-AE�� �4�
�ӼW�g��)�Z���(�y�w��F��ʼqn�0��-#��]ե���V�.m��6,O�B-��6����$�L�ƾ�����sc����M�P��pjs�o���x���5�'���Z�?���������qػ��0[Ԓ��mǬT�	�@�l�	=#43��D冕�ٖ�5#�4��$�H��fkw	R\����Qp���Ar��2�;�q��2������l��� ��� (J�A�`�QF`|�u�A�����o�+�D���c0�Q��Ϻ5C-3OM椧j�xis�ӊ4�G�Ss�W��m��<i�R)��-�q��n��#�,����D�
�x����J	r� ~r<�dJ���M���^Q[��}�o�)14ò�4Kx�C��!EX�u�334�x�ᱥ��cx�M!+�8,E�i�]��f��퇹xΆ����2ÃJ�ˡi&�
�WS��_fܟ���̲��'4��|7�z"�&K�x��H��c�eh��ɋ�`�Q��+�ɬ�ͫ�e^R[`y^��*�]ypsJ'j�[�����Nr˥u���H!��k��	q����\c� �K6`g�d\ ׉k�[G4��z[lNN_\��p>r�,sp>r˅ZG-��fŸGn3G5K�`�EG��r �e\,:NזY����7� ��g d�@F)����!&Y�^�Aƃ�͛�|*[R�j{�$�0.���^��(��}��Y9IE��8�`�MҠ���B�w1��Z�����>,
�x�Mx/!n��897�m�Xm�X��j������ſ)Ȉ+�h��;�D n9�w.�e�j)�ũ��|c���rr��r8�l�,� .~����@�[����ϡ��ݚU�f�Q���=�Pd{�����e
��~�/�!�̣���`d�s�OɐC���E�R /�'��]��C���[P'7����4�r����r��K����JG�z�=�����Bq��C@�&(.��.�4���D�A�],����nu���U��?����(��V��n�aj���0�xItqnT0{|��n����W�"s��<��l�6h����h{��r�f|VZ�˄{\����2y�u3n{#h�K|^���i+�'��U��s#�/�Y�MJȅ	�����2�J؋'G��ir�bsqnemu�P�N\��i|688�D�[��2���!���}���K��s}�䖡88�Pw���7���=�j�x��u]g��;�S�%N������(�i�.��|���!747]�M+GJ��"̋�h7^d	*��-ߚ���翯����ª�[���\կcB��Z�Iס�9�h�Q��ɋsy]�#���9�-G�α�f�-����q�q��}q.��kv��\/�r�S?��kC\��{�r���0��7�Hr�e���PpJ��np�S�q�80�羠K6+,wVr�&��]	R;'�hl	r;���7�@nY��\�Ei�E��'7�
�*O\/Z����Ym��p�[fホS '��2A��~��
�[�����?��An�����ܜ���F\���Ź@��$;8
ʐ[&���5����P��X���.8`g��[���&��p~�t�-��ι3g�5q`��������f-z��_�e&ȡY��]3#n]���w,�C������Zqp.}�m+,�ϛ�^��u$t��q�+Җ�84��u4��b���y�k�T�哎]��5f��2;���$�-����T,��"{p.�_� �r���"[��N2)}��}$8^��	4~ŕO�!,�7��QX
�W�l�\0a��� D�ι�4X���q>�B.� w��l; �T�9m��蓛'��;��lwr�Py�a�������ǥ���^2�s��2��0��9
&ٸ��d�Rp �G�o��;m�}JM��pY|r�b��Rp`�H��!�Kq��I&�ƥ�����;�B1.�����/��@����o���X�c~�o4sdEG{�'7~��7�B����6ȁ�����U ���B�snV�\PA�9�ؚ "k��E�1H�����`V�l�*C5�;(�#��56C�,=� .�j߹9���ݧO��B�^      ]      x�����8���D�	�!Q��F���q�C�H�j`����]�ыQ�F����F(Q�o����D�M�Z)�����?�P��
�x���?����f���5Ƈ����~N�[�z[��Ə�_/,��:U;����˃�o�W�禦����4���7�k�q6���a9����<W��R��N��46��7�Ǖ�m��횭|G�8z<n�� ��vC�����J����R՗�����Yˢ�����1?Tg�9��4��f�΍:j��\m��ӈ߹f�?-��4��v�5d� t�����o�W"Ձ�����^�|�� �zP[4o*�����F��iWO��x0��>�����:Rqk9j����Wm�����JK���G�e���O�k�K���h�〪{Z�ù_m����,��_#}Fs�֧Q���+�0��F�[���G�­O�A���Ӻ*�7��׃s�a��y#�~Ij���Uơ0eG��w�U�%
��B����1�O��A�Qm�}�x<�3d�L���zn���a�tG��}Z!n�b�c��y^4??k�
Ph���*���Uҧ���wֲԞ+�N���7�qCT#�b���ܝ���+@�ؕ������?ݫ��N��UŦ����Y��3�t^I�)n��T��4/��~&�έ�Nq���ݧ��h獼:�騽�6�z��������~:�^�7���i��<��j#G�%dO�3}~���Nq_m�AMB�Z���U�)n�V�K[�ʙr��;��jk���o��h�.~�5y�hO��=�����'���B�OU^���DM��+����ʝ'�������~9���e\�,
m�Jq���ƣ���D>��_��m߳�x;�.ʟ�����)n�N���R{������♩����.�1��,^��)�W}P�7{�I�Ӫ��F�kl��u���x.��a�b�i04�p�;���������X�nj�a��v7���aN��z�p߯E���v8����_c�C�i��*7�X��
җ��^���ϦV�H������3���_���^��v���V�]Q>�+c<���yeK���6�F�o_�ɒ�A�t�ֽ�=���1����g<e��g���՘���a��C�ٲe��'y��{�:�[���c����3͊a3}sp/����0g��g�X�	�ϣqg��a����-]��vx��>�<���l�m��t���O_�a�?�KI�Pn��l����\�����Ec���=c���f^�1:�ђ��\���͖t�]x�0���:�̜U��Fl��}x9vWn	��v�ܻg3�M�y�r��d�(��9�m#���:��6���������P�X���,Ǭ�]~��s;?���Z�s�����&��|~_����{'7���.�oxN�����R�ǈW�z6y�3r��J:H�n��D���K?�	\d9�7��{��X�[d{/���7%�֓}u*���d�zvM}/���s����ޯ���.^��@�jS\L�q���Վ͕'��8%����Q�|w�I��l���~o������b7�>�k��.��@w�~�l�b�7���ͧ�cS������)I'��3��x�-��f�z��#l�R��B75����v;�q�fl�q?�ו���y�8��s�?�n��(^�2�{��A����K��4ʂŋ��zM]ݱ���)F�1Yx�׏�e8�=]��n������ƃ����q�%�r6��K��� �>y�V`7���G�U�x������X\����������h����{����K�+غդ�E�Y@��c�;����� �	�\�{�	h@l-����
أ7��6���ȅ�<��ą����t�܏1M⚶� ����n��S���M�fU�3ڹU�a�U�qh���A�yUүE3��s]����f�ϯ�s�j������֞��.��k5uPÉ���x��;`�'�U��:������ȓ�<{����g�{�\�7�h؎��<�����á���=x� ROaC������1=�;�kd�D��8��v�@OqF�|��F8��8B3�3��y��w>���1���M'x��[�P�ysU"(F�����Q�Y����˓c�.�f�c�w/O�p��}�|n��2n��4tʅ���mn�"�ly*o~�X�JtV,�!��	n��Ę�D�Fd���ے��D�
9������sh<rL������훃͑�!	��6���.�����săr��5�1��6�DA�9<װ1�%�A�9=7��K9��J�㩴?"`h�=W�[M���(Z�9lf����s��{L���ʫx���e\,��� �I��h]"�^�=�8��c����c���4q�h�����}Nv��� Л��>�7�잙�/�� �m�7{�f� b򪉡=u����U��6�u�H��G?O9l@J^��/�I�	��S�ʣ��]��s��H���<�s��\g�}�#��t���~/B�iy�c��E;��8J�OG=�%���s�;��Є���8	$�r�7�ιz� uA��ϟ��׶M�f�Li��,���,lE��q������OsB��k?��H���4�Z^T�)�<=7�r���v^�ۋ�y�E��9q{��!0���:�K͆�"yna��D�q-�j4A�z�J�DӒ��N��E�������`/y=g���^$z�'#m�M���<�x��4�Q��;#�,�A
*�s�ap�ӭ
�J*久x�YTK�nS�x缻�q8�Q��ki��r���{�cݕ$	#�c���R�3�F���ʤ�_�>�x5�,�����b/U���dUՠ��(�$��/�=�z58%$�ղ�����(ClY}/Ԩ^�{sp(hQ���\�T��T�^ڤ[�寳S�d2�;�vبT��[M�I�W�����*P�>�د�%P�ނ�
��9���٨�PQ˞��U����5r1O&Yj��"�T���Y�,#I���;\�������WN	$Je�a�ن	��}]��Y�=�+��9�� Mv�
V��?�$�0d� y9n��g#{8v$ډ�w�{�=��T��X7ؿ^��un��[�����5y�3Ӯ�B��=~X�S��%�|�7��x2�[?��=Y���1�|s��{c nc���q�՞e�7'a��dE�jX��G+F�͟�rd�E0��$My�;	C8����N��tщE��+F���x�-7�!�<3@���H�)���+$dR�HiO*�lh���ԥ=�v=��w6c��!� %Ȓ�Nc�7�;��ؘ�9+� ����Ȓ�ו��E��[!R6D9���Cr��2��[�"Ӕ��Gf/O���u}y��+(�k�X1YV��L��H ~�Y�e��9γB��vdN�3����q�Đȣ���:��zuk	2�
�߈�5YK���j�z�-��DB�˃���t����)#}|����y�?����$K<�G��r�5�s��`��vO���������!��߿�̳��<��dQ�4*�Cl��xO�Ɂ�*���{�$eB��A6Xڼ�3��L�R\�)?�G,���]"�<�s(9�T޶O�y* JkRu`C���А֌���4�dF�`��]t��靔�z:��g�%l�S3�,Or���dG%oSu�]�3_I����2%VekxI��kB���_U��d�(B�Y0ӑeH�GA���(`jف��˨K8�:+Hʯ<���#x�����wP�m��O�g��MU�wE�P���t${�ٿ���+_A���ȇ��U�s�4e �>ԫ+�%Ʉ��@=�9&�]e�D���y����*k�n�˽Y��Җ��D�vwe���lIQ|<����IW�ro�$�׳�~�Bl\�=�!^�\���ǩ�y{+��ͱ>�'�Su~��C��~�x+�|����ni��O���]:�q
1�_o�a��f䛣�6��!���2 ԟP`�����vx�v�����~s�î݃!���,.�f�������KVr_"\�|a���6;���r�L#�vX    Dr�ؐSV�bDvA�il���3_���?�a��ɧcn���M?���������+/��{�c���x"}ڰX�?�e[o�e�'t���x�MÉ8Lֳ��P���IG����lRL=q��
��N=�&��ps�3�XO# ��k�WOl8�H�s��
�����m�o�aH_�o��O>R���6<�1իj �θ+�"��"M�"�������?>��0�p����	���c��5�JjY��l?�/�%����2˲idG�#�7�\w�&"�Q�{6��=/�l'svdC���s�&�*I%)?f��?��3-eGr�g�����do�J�.s�6�T8h8餱��e�y琰��C��,>]�u�Ap��<�9@����%��Ñ�����j��g~���*/;t�@p�8�1���dH�lR�"�A�Q<��Gs �ԥp�cT��ĞYK*n�=���2��Г)դ�E�=��8������D�g�o�������&Kr�=��^�%�PnS�x�H����y�b����r;���%zZ[8��;k�3i�^�7���Zfv��п���kXk#t����Ss�~J�P;t	p�e&������B� '�dy��PW���8y�0Nfq\㣎�$��0N^9�$�m������F6a�i_ɞD������t�!ړH�"�a_��=�"oI����龃��I��u�ٓ����7>�Q=�*�帽%}�}�YF�;EV���h�S��?�A��=�i3��<=!C� �Q��q�gU.sqz5��z��9>Ӽu;�L�#�A�UWp�\3B;A� 'z4�Ud����I�x�D��0����$z�s��ccSG*�h;���Ή�s8�:O͚^D�wN�X��r�"�����α5%���e=��KE5�wGYRv\EM�T��Y� 7�<r\�S#k���9¡�K2�'�2�	4-��PZ��Z6�q��1O��W�f��!VNN��������%�ຼ�E��?ф�^E�wnɋ_A��&^�>�8�q*���w�����9N�����M��;���� ��� �8�'����S�pS^�b��8��u9zu:��B
p���$��9U��,>�̨�3I�%@�;���±���d���_�5[8���{�|�;8����i(�C����^�ʍ$/~1}��9q����r�p2}@L_�:����'E�Ó��Q�w�қ�$�9��H.t�-"�v�;� ��6�$'�_z�����w����g��3�na��;� ���r${S�^�4�qg�D�;*J�,P���� yW��>�p>��d��!���O��#���~��L!��{��B���xpWsĭ��d!|qڧ�ǂɋ��u�O_G%�'�+HI|7]��;���=�L�Uqn@��3�/趬Ic[	6x ̰Ж�'0�w�^�
����)��Y4��l�&Mst�/Y߹{1|	/���ˡ{PT�pU^��:8=�Ҟ���d|��u��:h��nn�VP�-u�0{�F�u0 b4��8�Y�qN���F8Y �A�Gw�>�b��u0��� 1{�<i�`�]g�?V`2w�r�ݯ&���P�H ��
q2u@���W8���$������߹��`���n�T�3݆�S�����'�)v9����T��ʕ��D8��XC�ޅ�i	E�T�)�6��3�ٌä��p�u%$%l�8��T��XD8^%=7:��%�6,6�l������QO`�%J87�5���VV�a�e<<�PϩՔG)�(;����H��3���P�lj����/(e��?�>F�߽����}8Y����k��/j���m�	�r}��~�����5G�6��O��0�r�O���C�	p��gߗ*�{3���.==�x](�訵,Ǳ���g�R,9y��~��Ѥ\rv�$'��MvE�X��)���*���qڼR����A�y�!���S��9�5��Z��8������ ����xME�6��`���M28U\F�_}2���Ά����W_��I_�C}O���-�9���ʹ^�O��Y����_�C�u>^�d��1����`�Y�v���Ή�պǤȂ.�{����A?� #�zY��Q����9���,��z�x�Ƕ�ѫ6&]���
�'�٘~R,��}0��s��
�=�����O�s�� ����@lOz�``w)�ϖk����Z��`��<���9���L�y���3e�^����0��v8�8-��r g��x�����`����l�S�O[��\>E�����7�~���a�_[�X�ق�t��wp���y8�Es�K����_�5�A�����t����!�c�7V�?e��r��c�`?�,�+s�����?��b�����~�'��%t/I�Al��+�E��ڮ?ؤ�3�G/A��g�PDzI[������̯����S�{�¾�~���v�n��E2&�k(��7['kd�l+�����T4��Ƿ�D�o���D{��`p���9)�xVYNSX!N�x�qUn%:��Yd����U[��#ͻ��t��W��`�wzp���UNi3nޑ��{�;� �y���G@(ҋ����8���+ 6��w�˷��C�����q\g�^|aև���q��y�$�M����8I�#]�:�>ǖg�+�Qҧ�T�<Vߔ}wN0z�ؼ�d$���?���Ӣ�7�q|Y�0E�8��"��Ց=��jK9ؑ�7��@*�j|8�� '�W=7�ܟ��h���GrV�X���=L�wQ7�Z�;D�WN��`*��9~}���<���Ή�qr�:���=�9�c9���m����;=l��]n{N��z���q�6����7��2� '��M,]w���ǣ9�1�a�6��@�i�%M\i᠆�h��亭��p�F���QNI[E�x�D��8B-�ScN�[��pX�V9��D�7n�N�|�Y�Cnw�W��Ki�Ŋ�kuy�p��)u�̵ 'Waf��ngXnP��|��m6t��${�j�NK���/���^�P�����q+�Y���f�I�[r�N��2=��+�?dI�)�a�ؔ�u_9����D&V�	p���8�z's�J��+'����9�c�w�c䕣��ܳ�z��i[yŀR�\0.�j���m��_E�(R=�0y��XYy�D��89<G�t�d��H����u0���X�a�hŻEr��;'j,ϡhCoʉ��FK�q�$�~T#\��p5]ʞC\g�4���e6uK丆iI{���+�G|]-{���4\R�pM]z�R�|a]ga]0����V�%,���;'jt��],v�^UD�W���N�nl5��zUQ�5��2�
�ī���>�Qilkv�}�*b�sP#'��.�c,�/��E����!��b��t��9q���jrm�;-rq\C�vM�\(��F�����U�<,�'j<��@	�jj}�&r�s�G��enYM�x��1��&gau��=��p��:�:����Wpx �GԮQ�,ˮ��.��l #�Մ
�C[jP��,���D�p�go��
�9;�`�7j�C楪!jר{��5��������z�9�"��?,N�i�����/�[��{ b�fK������ ���c&�i!M���n|ƥ=/^[r�l!��٤~�S�y�Pj+�2���	��8Xr�l���
؎Ѹ�� AJs��|2�`��R���K�g�p���(�q��#��fɕ�ezn�b��[S�X���D;u| �����=�Ϣ�r��&��;�`"��ݛې�zZ&r��"5yn�H�B4K
�8(R�U�㢥��x�;Ejq�$�i�օӨ�V�u$���@Q�yse?}k�"I M�%sp�PLz�@Qex���\ٚ���R�{E�1A$e�o�iW2�����p̿r��\D��Ǩ^�b �iɁ�"ds)/������w���ﲦX��HK�.��;�M��qPQI�-�)P&�M�ON�mM)]Ko]LH��ҊՁ\�*��v�ҊP�d5�A�tu��3���
�Ҏ݃�^�J;@�<&�A9��[*bꉀ����    z���TD�wNtY�k�d����+�H=s�D�\|h�ܽV�l�����4"�_�*fp���r�����
���0� ��|d�����o7�Գ�B��!L/��鴃#�!�W�������ee�+r<Ȍ�*�@Q�;�7M�2P�D�(l�L e�w��O&i ��Ve�jO�fM�	�Pf$�������!ʌ�A�O5QUXW�2��U�Ҟ���8���(,|�l0q8p�@(3�����e�B�(�ȻN�3�( E�����|�( E��PX��֮�U�!�@Qf:���tU	C�y�D��8v��O���� ��L��.� t���efV,�Iw[8�Qs���@��vR3e��}ю�8���S̫юP��1n3���CY�n�@i����%�U��Ţ�b ��A�L+f,p�v���5��%H���P7�ITl�(��<���:��
���%V� �Ok휜����ee6���⛜����e����D@(��Q�l�K@r38B������+'�j(E����Q����\�E���"�ٞ:�Y�H	���� .�� F���!P��DMoM�r";�2ˁ|y0��òD�C +�S�`A����:f<1{�R�Wð�O$6��ys��9�~�?�ٿ��9WZ�ɑr҆Ł(�e���r�N̿~��۞��X��ѯ_��Cj��{�0Z57˱����Ձ��f,��8����g�:�2,�(�t��ڌ��(�����p�`w��U�*�: J����J�շisW��PtY�����L��K �.&�,���xB�]L�Y�m֢~����6���Րu\5k��m嫋.}3�y�����Ձw]s꫻|u D�̓w]f�>a[�@�����8�W�E�-C�(3<���k�tQ& �2Ӂl�p^��Q& �2����4�6mV�!¼sЅ����t�aZ�@�b������s�f�2B2g[�m<�j>�D@�b���yJ|=�67l�]L��%��d�DE��@B5���X��L e��ա�u�2P�,¶�NQ& �2f Td�K��E� (�,���i�,Q& B�X�Qc��8�x@(���A���)�,0�C �1�
f��C�>ޜa�@(c�n������a�@(c2d��0�Fd�E�������e�(�=80I����( E��@qL�b@Q& �2ӃM�(
N�˃��c��gB�vD�v����uu��+B ቾ�7T� �vP.xb �xⳇ��Cn&o:�u�!��Ń�������� ��Ճ7��ZHHڎ�$�4r^X��FO�D� (�t�X�Y]�N�(�.�(�1C�L e�	�aá�Ya�#��5��Y����H��-9�s�����ޞ�:�v�)
fu��T֞�y�������$q���#'b�\�wȉO���r!wo�΍+�860ͧ`���XbZs ɍ>��KYC���=�sE]��$�u]��<�5H��KL�{9Wb������ ��2I�Y.�����Xʌ.�a��v��A�웘6!ю�8��q4�%�T��h��;.�y5��v�����w܆��,Zb�G@Q��q'/Zl���b�G@Qf8���E� (�Lr��E�wNtY��؞h�Bn���e$�M�C�s��}<���Ɩ8�Oĉ���z��&B�qf:b�����ygoB�@��t�B=�9����ߙpn:b�̓�O��l^��: NQ���zWl޽q�}�e�(3��ܿ�3E� (�L���$�fS�	���r �n�^k�2�ؐ����UB�1����݆�T~�f����!�ؐ��8�U��e|C ��!9��*K�ق2�ؐ����5���D@Q�y�q7+��E�W�$Q�v��\_�&Ve�C�9Ú�a�9�e:�W!�)�K ]�QG�螧$�% B��<�t��I�E� (���,H�:1�5}�٠���vD�:b���|T<j00���o#�r"�5LoD�:b���|Q3�w�j��뿍�w��KC��� �2Ã�?�d�	UG@Qf:0\.h\b��C۸���nk�F�:���ns�{��OA�:f<�<��	��V`T�@\ݚ��z���v�\ ���5eɞ�(W�@Q�y��k�v�"�@Q�{�w�W>Պ�\QE�g�]w��?)U�	�����@���*�@Qf9��`�����er� o�����P&g"�ݒ~�C �����@�Y:`��@(c����M�NђN'��C ��qh��P4]`��@Q�9��彼�oa�9ѥ?��8˼�ڃ��.Pt1�SS��+w�.Pt��l�T���K ]�9=�a�P]t	���ơDU�a��8�b������l�� ����B�]^7�!�w�$Ut�_�\�t�9@�;�B��F��<P�ŗ� �E���Ҥ<�v�!�@Q�{�c����( E��@���U�u1��L Ĉ��@�*����<��@Qf9���dw�J8E� eJr �p��y5�yI�0�|v������$��!�Q�CA.v��N/��@(c����khX� ��L��(4GV�8ѥy��i��] FL��ش��W�!Pt��[4׷�JezI�U�Y+��X�����ţ/]�+���V���s5��J�O��^������.c�Ki�d�~$y��`������'�N/����w�2��,cK�.diS�)�.ND���$<��}��D���k��.F��4C��B���a�����szʨ"���MP�p7O����(]|:��1ڛ(=�XI�x �.�<�a̅¹�t�7�2�Ⱦ�MaTlp2F�Z�̆	�˫+��{� %�B ���(�]�no̲n�+���@(cB������h���Y�2�t������g�*J��������_�*��(�P��[�����&�*�@�9�����ت"L a�qõ[U�	�"�p a�ܛ��*¼��`3�t`At9鮾��Me�+rPH�յ�2������c�H@u��v�����i>� Q�l��A�R\EA��V��n�p�S1E�rEE�(��<Ȧ��L�ti� ��ݻ�(ϼ�4 �w]�ݶ�^V�Z3�-���Ct��V¶;��:�!¼�$i����>�&��#'�HK�8ީ��#��_]Ƴ�����/�.PtY��y�d�Yt	��ed� �0�������@�p�ꑷ��wĈŁ�1��TĿC�(SX�'c±u�2ʌ�@^/���r&��.�sU
�*'��rKTy+.�e����\�� E��A��J_�� E��@����OU T�Ƀ��L�i���efRC�Ds�*b��!�=&9P��"4ľC ��ŁU.��巉U�̬DQ�5��0Nti�kX6����U�� q��V_u�: fQex��;F�\�E� (�L.
U���8g��]u�߲� ��udص���qӐ���� �ɥZ�|�	�bR���H��o�:�A{)�������K�.�$d�\Đ�a��D���K� ��K�ٚ��Pt�\rQ�RPty��2XQȱh�C+"L e�,�\����&&ze���^8⯜�α.3%�Ul8Hcz�xbv ���v2���gz��u�R��C �Ł|
��{�s��+�XH���.m��C�(�����w��D_E� (�t^�L��UQ�l��p ����zT�5Q& �2ρ0�y��eM�y�D��9�y�*�hMt	��%'.�m݀�%B��Xp�u��,��f� n52���?B�\X��o�Xj��C ��Ճ��@Z�<7��!P�il8�=ͷ�0������u����p`&6A�XCt	���t ��g��!�@�eyP6FռZt	���X�2nr�#B���d��� �?��Dl�g�̖6�2�r��4Ws��?B��MB�E�l��Ć�a���?��(�t    "��ɓ6E�7���ײN�vTܪ���G,}�tOl]�1�W#����{5I5�5� V#������I�1�q�7߇��qɐy�0bJ��nzS{n�����'f���7v�C t)�A��)jiu4w,x�1R� ��3i*d���]L�}j ���|����L{��w�_I}�=�2P��D��)�=�2P��y"ۙ�gQ�$��>H�>����f����Y����C�;�N�E� (ʬ���R�d^-�@(c2'�k�"���a�O�!��7n��?b�1g�o�q6��
��y��9*+�	�zз#�=B�Z=�]��I���y�2�y�+�L}�p��*j�w����2ÁG�^C�{e�(3=8qlQ�i���_�Ν���?b�oώ����'�ͫ��G@(Ӳ��b���b�@��9���C�-���6���C��!c�U�F*#���9�>�4+�#�~�Gwd7fE��}3�LĐiÁ�=�iU�.ƿ��W�p�]��|&3�����Z���o#�r8֖�H���$�ⶇ��b]��(�f�@���jp���l�.ֿ@�{m%�'b�D@�����A�\��;�觍+�{9b?�}"����z_ܻ��i����O�eKD&}a�R�����o��Ƀ:�'�I?Gv`A��|����Ad�.ctd��Q<8�z'��̨܋0�tޑI?�S����ޑJ����cX|tAA����?�!�rw��o�u�V<��v� [��5"�˯sn^�+����4��_��-=[E��u�ޛp��&#`���X�ɍ��jь�.V�����g�c�]�� 8�ál��'כ��|��D���	D�+��)��s&bn�tV��gv`���c>3X�8������m��Y�H2cuЋ�?��z椋� ��9�pu#_���lvv>\h�Gv����#Ȥ�o_��� g��Ps_��r��b1�����+y���w�#�O�ɓ�`�k*RuX�%W�ȞJ��C .TO��Ψط;���0�#�R�K~�	�wG�E4�/�;��\w�"�!�����M��wB�!���Ƀ��NI�����#�Vu����ռ�GLD���Xy���,z�����V=`0��P&�W���u�D�C`���3��ڦ*�8����5���$��ȗ��+�K��;H�+LF\wOd��� ����
c���$�1��� Қ�f���[����hh ���o&}!�%����pP�T$5�;��b� qԼ����,IȺ�8j1%S� T�n|N�D@���|�H�Jj���!�`[9XQp�8��YzZC�&9pC�Q���)Ժ��mPȐ�̈`v�h�������M;.4�;{��=�>�;�c���@0;bq�_���S?�@0;.�q���G����.P����f��C�,mŁ\�p��j4�&K�;�`6Y�N@�qs5=�3����uJ���3�,m��1R���8�ҳ�
�?jĲC �KZ�l[ɀ/P��˿Z�7�>&F��u�v�.0R���5X�����)b����	���B�y?�+��R��!��>�� .���Ȧi��
-W��4�!��Z����p��JɃb��Q Su��A�m�e�s�^6	�}j�v8 4��@�·���Օ��Oټ�l�#�W3_���+ya

�u�1��"cqj��cu%�[�{`	a�����u���mQ?}e�LÍ#��'2>ۘ�9��{��DN�u�7���������=Ё��q���H�1��Ɂu 3U��!rq`CE6s��D��Ճ��t�����9������,W~�1��zw�b��}��""`��;Ȅ��r��u�\s���й�t`!v�M��I�{y������	�rQ���$A���m��3ȷ:]`W.z*�j�yoM��aVF8�nÁJ�r/P]7����tc�!�������Ii����k�����E��=�y�����<~
J\o��[?��/1�Z��������oi(�c��L�|C &n�DD̄�'b�!��)2�8�_;"�L�='%���0����@^[�~1եH���.��AH��Q���7JA�|��	%�"��YWĞ��a�F���Q�bO��K�P �2H���t�_Z�O�qN��j&�C 6ܳ{{��	SL�([n��B�)�f�q�s2?^,��rPX��ju�Q�Z5���q��Z���Nh�G�N#�hR<�5�\�3�<���y�z����̫�� a���@�wO���b�@��%�8t�4n�<�P�!�<���d�:��!P<�_���b���5 �2ˁ�������2j���f�}��Y���gF�12G��3"�����Yn����7X�g�����<��Ů7����IT�9�$͊sFu�
@�
½����S�Bc�x!�+��0sJ\( ʚ;�7Ls��r��s��/��r/c�Y��ݦw�4��nZfs�Y���z���&ډ8�;E��+��C|"����`���˘"ȝ��{�d^�6g�'������:�6�L�ω3�!v��! 6v%]UC\S�X���p�t��km��0j��.6F�? �����K�F@�e8�Ͼ<�7/IU����t`�V���K�7" l��<(�i4ks!w:B���Z|)M6a" ��كR�U��B�t�2�(��nA(�L}�oT�,�X���L�$��2̫�L�v|v܎�&�W�T@��Ҏ̓\���ZN}Ijy�v��,i���c �v|�����b�ˁ����W��k�%r*/Y/�k6�/ֲkb[?�꿐��խ8�e9D�>:��rj���02�9��J+>�7
x�w�XUZ1 J+6�
4iB�J+@���;�p�I��u0�.Ã�63xa�(3XP�v�2�`e���ͫ�#r5Q& B��<GQ��%u# ��ف��n�:��
�6B�N�r��Cw���P�Nd����`�F@ص�?��B޸��P`׆@Q�y�a_6(�@Q�{�E��.���2FMJ�|]T	���t`��w�|Z]TyŪ�a �vKh�dQ% B��H�n��VN�@�6<:-H�ue3�x |s�)/�߃iVj����)\Fr�v�܂�3n�ťy�j��!���ѻ3
�s�3^P�;4x� �Ҙ����+xe��1|�%}�K�Y8A%����Z��^#kJb�;��o�۱�GS�h-�@�~�|���H���N���<��C�{0ͳ$�' �?��V�C2|7��=K�PR{��o�L�`�صZ�ƿ��Sw�`�@��p ��*�!��5r'��^V�V�N��C����>e�\�N�u��7
�������mp�7@�˼��!O��,S�;'3�o��2�soN&�w��4�q��BŤ8"�f]j���F���p�DO?Z*����Β� �����=f���D@I��nX��I֣D�: �u��4��
E���8I��uf`�( �L��KǧN&�'.���LO���
 ��(&r��k1ER "�����t�*#1����k�T�$A�(���@�X����� %�_�G�Bf��L Ę����^đpW�È�V�p|����o#&ʞ�x��V�ܠ�� tI_��a.8<1b�<�TϽ�������Q��Y����[�B ��~�K��:u ��e�����t�:�qW�2�KX8���� ���b�|�\��ŀb�@Q��c$�{h�tQ& ʘ�S��V��e�@(Ӽ���m�D@(��%	*f>�5\�4?�>��b���!�4?X+�3�&��
�2b���R�v���3dļ�Y"<�9X�'��y�A� �����	��Neq�Y�d��(��2��hǜ��<�k�2�6�"�J����M��&��q�R��n��O6&�}+�B��s���j߯�]ޥh2Ƕ ����0N����.��)����4� 6��<����ɷ����@$��R��ҏ*� �  X88����o�ЄӃ|H�8Y7ץG�YQDo����;!����t��8��vy�+��GN&;[��]T�a�"�唟/Ǳ5�ԧ~���ˉY�ԩ�Jʧ�!�n�՘D`���ue�cB+F�PL'�b�7��U!\�pH�"�gVGJ˕S��xþ���;�'�x^ճ@������ˑdі/���R��ٳ|Ȋ�K�%I_
�2y���	Y0���Jr�v���yv��lbߐ��?$�F-9����V ��:F�F�:��\��&�.:Fʷ���(���{Z
�U��'Gn��b$W�H�K�8R�{�e�.})@6�K��CP	�ԋ�$�������Ar�I�|�M&���4�#�.uCJ+EHQ�x1�Dr@I��{����Lr�pg&�������޾����m��r{{ |�8қ�nIl\����Bq�zq�a`�����
�q      Q   ;	  x��Y�n"I}���z�ՊR�/�a�MmchvO�VZ!�چYkz���d��%{$�ry����8�Δ`��߿m�cw�o��[&�4�R��J_��r8	ɴaW7BJv�q�n(.�&U(E��$�i��_�m�A��Ih��<�n����*;4��V�p��������u�a�i�n���j�{�?�[�B�!CeJ�u'D�hv����nB��JWr8Iδe��mq��^,~?<<�>57T/rC#K�U')Zd��ö���)�������^���B�\R�<�p��Y�.WW��G�\�WI]���NR�L������h�7~��m�H���pB~*�F���h�K�Z�����$-�C�^�>tHD�6v�K�d'�%�<�7�3$��+�
9����H�
_
gs8)ìg������.��A�<d��q�VC�J�]'x�Kt���O��lR�"8�OO��'4z(l��Y�� �캺u�����|�m����<��}\.��~=��P����CP�}�e�5@�6�	'�cd�,�?���y��hor8�D�a��Gy�:UD܀�K&mim -�/���lT\U���dٻK�4�6����m6��v��0)WP0�%�V��f��PTU���轷2����q�+��4�n�a��V��Wwո�%%�Sz�r8����Z�2�d�Q�D'\5�w9����"�2�w>��mﲚ�&=�c8lq��:�zv�^|��Ɠ�t�_�VTC�*J����{�8H��'C4c.D'#����=W9���s]r�r8�P���⥾4��
td�c��2�Q�96-������	�h^⼬4q�\@y�V�_n3�:�|��&Nh�ȑ�@m�9�d�,yۏ7�5�X���^7�%�I
�,ns8���֗�y�&�EP�Bwvt���qGӪ/�$���˄ҞE���	�s6�\�/G�:R[�غ �\'{�����q���r8Yq��Ϛa\�b�Z�pB{�Ʉ���n���%$H�%S<�UTO�Ҳ�s�X�mw�/�AJ�	!���p���-	�zw�Se4}���������U�N֜g�Ͻ1
��9�l���|U]O�5���Ci��N^F�������g���.LJ��U\�!�F��ۗ�b�������ϗ����g\��ߢA�p���1⻺>���0�@J���N(J`Y��V�v�M�o(2���?:�L5��Z�pr�;d��P���KmT'tB�t���0}�v��ʤч�Vg`B�����Z��I�U�$���麾4�m,D��C�9��9���5xll~��h��r��:��lv7ov�3��4�����|?M��!\o�6�ꪟ:��"��xf�Tf��P����uZ�I�N������f��z�f:p��tpB�L3]|Z�θ6�C���{O�N`��	�����-�׽D�"*`�u'\���?>�~-t��Ύ��I戓D�����;S��n.Z�@Y?	�N�����r�GM Cwj��p�>��xy{�u����.��s8�Tg�/��t���H����8'+r8!(���x!\]���$e(�t9�0^�Q=����^r8!A2�i0Uh������}����>���7��n�һN�D�x4_w�:;I@�"7�9���f�.�������P�i�6�8s��Sx{*l 'C�:�0��u��?v��v[��8>w&V;8�c+�v�6D3��}�6�v�)�c���2>��-�~��	L���i�a8��s�&N��7��M5�G�btU�$.Qq4�B�!��S1�w���Z���Mj�����z��5z�N��B76{�w��ٳ�hᄫ��X�W��j���Ξ��)p�����\tT��>���':^-���w����c�xg���T�������;��v>oφ6	t(	t\.�s8H4C����O	kۡ���1%J�7]\�R_�Dq6�����z[�D���f`�s�B��)���y||F�p����|Q8��>� ����ԮA�R!p��q_�ݞ�f�AO���"�a���ʍ�.1i
\r\���۞1�6��E
��94!nJu��L�#�I3E9���,ޡ����[φ`�T���J��A#z�M��S-�9�D�?譽y璞Ɖ����A��i��$�Ay��[8h���_���m�f�$�ϕS�������ǡ|��Ϥ��p���fg8�lh/Z�N�>��	�����b�Tn2j˴�Ϥ=�ځJ�`,�-,��2лn��t!�ہ8=�tp�m+�
��Z6�6���GhO��up�k�a�rh��2���z�����ϕ���N�!�u�&�/�"�Y��$��p{      W      x���;�����bO`3�~��	Ȑ}��1!C�B�WV��LPF�%7����$^U ����'�O����ߡ���_!��U�5Bs����������������_!}����U[w��?q�~�x����|�<!�<p���DE�7�H�2�j�B��� P_�?�*�"�A��������f�`�A�O���W�W�[����*D�(}��]�A���S�Z�b�f�ub�P������P��թB'�{���5]�LW�G�o�G��+68ɓ�P>Ÿ��O���'�~J��������\��VZ<���7O'���0p�a�����q��ַ�R��h*�m���#~����ʎ����l�Չ�>ulρƦ}�t���Dȟ:7_�"�equb�O'�6�3�:1��#��Պ}�G'F��t`���ruub�O�'F�*����c|Z90j�O,���Ę��;lʇ^�7�[�����u���m�ړ�Sw?MZ~���ɔg�$}��g�E�Д���#�x1Q�P�����:1��y`Ģㄍ���@����TiBs�JM�N�(�CU_A��#N7������?z��30�%�����ꌩc�_c��H�'�$=�k���ׯ������S����b��l�ꗜ,]��=��(Z�Ѧ'3E���G�Wi�,JK�Rsu��-��U<��f�Wo��	��J������tY�?����&3m��{F��O����L��R%��p��X]�F=c~��9�p��h
<�Nb�p���k��-D��)o��.�߈����64�ň_b;�H��C�ؤ�:c�����/11,��$��Vx�ԿҼZ��Θ�0{C�;�\�CC�+N�f8m#w��Ч�y�V]�1}a��-f,���~��@�LӘk+Y��J[(�Δ���F�x��껝�p?��VOf���F8�M�
m�:�|x�9n�'�O1>;��^s���6Ju��\�)h"�8Q�4���:Qj�����j��������<n�,��ېu}
�|�1\�10��pǠ�Đ��:c0}�y���X��3���JMb�Yfru�`�W¡n0;�21z�ΘL=ad.����ְ댩���'2�5�:c0�IvT̲��3��px�]W3>�����(^�^�����|��w����de�b��\�)�SR=P��,����@��ޫcA�Q��e��ՙ��7���X�Q��3�Ks��
���3LWg
\g���gQn^1n��)0]�e��O����L��r:Q���)�:S`9ӟ��9J�&�ә�&&�����Ӊ2��Y���,�љ��Q��j077?�df�syw.
7�����̀������������q��۵
�[ȏ���l�S�U��ՙ�w\�S��9�,�On�N��֩���{�u��)%�(2�ͺ��8��E>��V��8��CV������̀SJ��^=��3N)�@�5��)�:S�+�@ICK�]�)h���"��D��ՙ�սn�煯��6����=j����ş����LA���i?�Z졻:SP�mGCf��<뫻��n��6e����@�����²h���X�)xC}�1V��.��:GG�&��V�R_��gWg
ڄ,%e�L�C�ՙ�6���m�J**�_yfWg
�s����ڕrru��W4�0Ó���<���UAa^��:S�g;PR��ho��9��74����D!q?dt�Ȭ~����PhZ�pu��O�@�c�P]�)��Q�8TƠc�:S�R^+�Ӂ)���E�#)&Wg�P��a~������ԯ����&s�2(��(��ď�4� �*�����:S�gY�1��;��)��46ʏΔ�����
#���)B	0���LiJ9<��0b^�6���.���Fg�P��a�F�;��)2����ݓ9P��=�� 0o��8c�fK�Δ��ã���xx���Es�:S�R�;�kRM��pȪi�(�3�)e{��b`^wY���*3/t�)C)���捦�:k�(�{ot��Jy?�?�����at��Ny�:S�R�;���fJ���I�Δ�����
#�M�O�a�����������S���|�Ș7� c��La��3F��a��,@L�-V[�~��5��A�ut�$Wg^R
��)� W��3�*��0���=%�ak�*ɞW����A+�N����4_g�P��a~�A+Ӛ}���*��W-�Չ��������H���k)��I�'������3���kit�����3������Fn�ՙ��x��_�m���)�]�
=�\�We��خ�eH�pN����o֍ѹè��x�o�I�NY"D��:Q<g�,V�&^�tu��sv�b��i��Zsu��sv�AK�U�n��L���]����Q~df����d=�Y�x23෱;���^��c|�L�W��+�@��N�ju���v�C20'E������
נ�ՙ"���@�����:S��8Q�0��)hY��(��"C�L�:S��N�@\�r���e���ѯl�GfZ��6F��]ɕ���|`H\�_��GVg
Z��;N�m$�bq���|;w�u�J���L�o��.o3�+���L�o���~��Gg����[����`#3C��w���%jsu�TPv�Yێ�=�:S(��0��A��r|�:S:(���^D���3e|����Ig�j��<:S槥�-�gE��㩞Չ(�[������a)�Δ�iy{�QW�1"hoϽt���	�EMW�o��hI��ɟfB�R:�ĥ]�Q� ۚ�k�t��C��}�3��Er%4)��^:�3��q��/��_�Wg
l[Ӂ��ɓ+3�5���4���_uz23d�D�Eg�RdO&�@̈́��nH���Og
k�wi79Y�)	�~�$\�T]�)p�	uޥuO����ք�V鬓�Zm�<:S�Z���Q<^��i������"At���[�3�m�@�2c�"�����Ly�-�Q��;x�3�5S�UZ��|�Y]�(h"���ޥ��Xl�<:Sd��<Pd`^��|�)��g�(-3��U[���x�Ly��C�<y{ӏ�x����6]O��x�L���]R�u���}w]������:S�]3�K��/���L�w��]��d_���x��~�Y��洔G'
z�6v�������)����R�5���	��8w�n)2��C�u��^��-�Fcz;gwu���cwK���yI��ә��	��~�����3��֕�t;g���x�NXW�"_K�ՙ��	�*-[��7ʏN�����j�e�+���L���5ߓ���T&�+v��e��.�b���љ";�6�k��b�ϣ3���$�;i��+�R�љ��Ib��S�q���Yg
g'�ZZF����L�sة��ƛ�-���L�sة�J��ﶼ��N�ة�*��3l��)p[�޴�ܚnVM���H�����\�)����垀M;ny�LA��0�}T�|.�`��)�+w(��/�⪫3ub��?gN`l=�e1:SP'&*�J���೹:SP'&�}�n�ʗl��љ�:1q�U:kbd����D���	 ߥ���s�jt��NL��.��^�3:SP'f�*��h-W�1�љ�:1�߻t_�v�)��x�.F'��)���{W�����\�)���{�j�]ٕ��I�s�Kr~ޞ�љ�I�suQn��vי�I�s�N��Փ�EF�iw�F+R�&�Z�)���ez"���n����Ij'J�Ҝ�nu��N���*�	�����ԉ]�k2�\�&dCa�)����.=��_��љ�:�|Z:f�%[�)�5f��]z�����3��l~Y�ѣ'�����G'��+�旻t�=Q�>ˣ3�˻�t]|k���ع�nh::Zz�/bu��N��:M���܏�)����n�̥��WWg
�Į¶�-����3ubWbW�.�E�)?:SP'f��*-+��^Zvu��N��]�Xt��Wg
�����r*&�c��C�}���ޝ���4���)��	&���-��ot��N��*�+��3Fg
��l�Y�e����W��ԉ9�AJW]����LA��    �4qj�����5�ef�F캽�%��y�'3�aW�W�&o�7XX�)��n��e�/I	�ՙ���+��>8+J '��C�SNF	�qGY�%ӎ>]�F�v�~겈�Go�:SP�v�^KˉQr��pu��j�����#��U#3k��罌P�'�X�)�W�t?uҭ#'Wg
���2u��Gvu��^m @Kg=�o�o�u��36�m�ы����0�ZG��*J.��'CF����u]mWg
*��"���$Y��:SP�6�J�ń�Q~t���6����sr���љ�z���U�iRA����LA��X�*=eTx�ft�ȑ�u��64"�gWg
j��"Vi9���י�����UZ{�8��?��ԯ=�Wrgu�E]���ad�n�S��`�+e_g
������v�����LA��`DҼ'��
�[�)��X�S�=��R�)��H��`Q�1�ՙ�:1�U�hzB����L�aL8"i�T���׎~�35k���,�ċ�WF&��M�*\�L��s523P&�!�˗n�~������'���"�$�:S�+�D��/�8ѷ�q���"�$m�{�)����v-�M:�vי���k�n��Zt�:SP#swmQw�k���E\��"�����/zt�����q�'K�|ƒљ�_3w��/��s.������qzRe��{��3Eι��2��5��<:SP#s�\�11�m�x�u����{�̣���ՙ2>#�ӜJYB�ՙ2A�߳C����]�(�{zs��eIγ��Δ���UZҎ�.l�<:S�g��3+�?^=y23�gĽn����ԫ�3����g�>�xיR?�E�2�.8���Li�aG-Zz��h)��8���I^{����Gg
�k�3��*�jk�љ���sC�i×ۢ�<:Q0���p/I"J�df��� ���1U�3
���6�=�N[�LȶQ~t����������_g
�k1�zpK�t�ɭ�љ�P�*-oB�4h��8ׄ"��C�P�\F�3�5��u�r�Ynuef��&�
��T)Of\k�wa]l�4!�:Q0�&q��^>���L�oMb�.��'���)�=�V�x���R��3�5'y�3��柇�\�)�m�}�;��:㰔Gg
|kO���됸�}�)�m�}���{�H���6��8d.���ՙ��ݹ����+�hu���y�n�+� ���D�h{�ݻz�-��|�)�n޽�t4[��|�)�nٽ�~��:���L�w���.#�"�oOf�[v�v�9Z�W�jt���ew�&aI�-,[�)pnٝ����sZ@�:S�ܲ;WwȠ-*�R�)pnٝۥǑ��pu���ewn����ˣ?9�f���w"�����8�����--��2���k娹��tWg
\[w���Q����̀k��ڡ� h�rru���uw��s脓�=�������X1z�5��L�k���u��x��mt���uw���+ir�)�3���ku	ZF��>ˣ%µuw��ɷ�Svu��sms�,��֔��Fg
<�6�Hi]��s�:Sຶ�Es����������m~���u|Lsu��u&��&�(�x��J�3�3A���ܗtE>���L��L"�����r�:S�:��K���<�2:Q0�&�J��ѲFKyt��u&q��K��:S�:�H���N�x���L��Lb�ƨ�b6��3�3�3A�Uz�TN�ייw�*����̀���ܢ7R�+�j�љ��ݹ���^sy�3��q�U�i<tl��(����;w�ɂh�Squ���ѐ|��ҢU_g
�k�!����=ˣ3εѐ�tk=v�:S�\����f��9Vg
�k�!Z_��q-�љ��h��.�7{��x��CV��OSsu���6"�J�5J)��x�FD�t�z�J�N�B���h2�NR_i�Vg
�kc"��1�H�י�ژH�^'��6��3޵1--{������L�wmLd������gyt���f��]ZϪx���x�FV��J	��R�)𮍬hiɷ�w�o�p�����GOW���8�FV�����n��N�D�����/�5��Y�)p���hi��u�h)�Δ��awn�ٲ��Ó����}��
SxG��Δ��[�T(c�Y]�)�ݷY�sE_�kHFgJe���sd*�"FgJe�m�#T�$���L�����R评�3e~��7�M.yme�u�� ��\�á5Wg
��&D}'֧�%Vg�P�놝@�Jy_��0��Ii�gz������������cQ��~Gi�O���i#z�N��퉽�:UF��F��t҈N���R6����ޤS�pu������^���3E^��U7]����<:S�U�_u�c1��:S�U�_u�`L���u�����z`Q,Wsef�׸�F�޸c=�:S�5ڈ�*-�{��6�N�!�1���w:o1na�)p���{���/>6ʏ�|��\9��˫�P��3&�܅f��$WgL���NG׳+��]�1�S�!fԅ�,�LWgJ��n��ad%���LY�1��[�ݥ���X�1rm�8b����-�3f~�4�f��l��:a0����'���:v̏��o���ѡF����>rb���L��|�1�5���q9Z��l?:S�����k�u+t�ՙ"y�[�5�.�kL_(r.�l��*Fwkɲ�1댉9���\�26̏�4��Y���d�1�c�-�dGJ��4l�X7�����ztƠ�h���J�)+|���V��V��V�A�\�1�A��ɲ�9�d��A+�Θ"���a�e�H33���kݨ��=ˏ�i#���I�rD�puƠ��5_w��m4�#�Fg~а�Yū.0���A�i[�zϥep�?�������Jr�����L���{:���LWg<�Θ��Itj�����M2��9M��c��G'J�AV;Pd�� N�1:Sd��O���W�}�Gg
�6�����k��:S0=��=�t�]���:S0=��=�>�Hφ���LlrO��)���b)��LlrO���d�8\�)���UZ��k���L���&7��\�Z��<���iSꝐ����W�3�����d_��Fg
<gS�N��.y�n�u��s6�A���\�+܌�8�&7hᬷ����Fg
g�V����3�������'\��Mn�wrT
�o$�h�ljC��y��Hksu���O�g�t%I���ՉR����e�ʹq�3~�i��n�-u�:S�7�fQ����_�X�)��M���Ŗ�4��L��ߡ^�)��&�u��m����M����.�u���϶c�n|��jru��}Ǉ�$�H�7͸�u���55�}���	A8c����Gg�L�u#�ҦuWg��0[��5v�}I�љ���P��sOR\c���=�|��T����<c�Y�\�N���h�_�J
��-OWg��8>�:j/����� ��\��-��mu���eɯ�"�>k��Gg��|��F�_���ꌩ]j�1YצB��Y���R\��+�ot�`LU��C԰c���Չ"�����(�9>�d�k�z��~9� '˞�����ۭ�W>MxǞ�Ε�7��I�}�L�ʻ{y��ԭ\\����O��A{c��_�S��n���3?�^���[1�{z��	#��欆�tFGd��j���m�d����乱љ��͓l��UE򞺫3�#�*���+n�]<Fg
�6Or����$�23�Y�,�v���{���t�6G��W<a�Rx��љ���H6��6Y<,��:S�Y�I-uQ9��LA�gs$�}�J��?\�(��9�����X�����H�Қ	�Gqu���6G�����γ1:S�[�#�J�#��tu���v}��;�aжQ�)p�͒l��>��%5Wg
�k�$�=����#?���`S'��"*[�y#���Q`]�$������^۩��X�&l�;Ȝ���/b�~R���\["Q�һ�3ֵ!�hX/%}]ibu���6ղݡ]�.��g�_R��A�����۵w�=:?��͘�='�8.9*#`\����m6�I�60:���~���߃V�.=��nw�9T\�)���m��\9�+zt���6_��wԔ����D������Ҳ�R��o��n|Y�пeF	�3��y��Rk=.�� �  kt����y���e��Ybwu���6����zzqu���6O��pE�WC����LAkk�4�o�ư"m��љ��<���%�"6Wg
<k35ױ�I�K��ՙ��L�U����:Q$�a35�/������g���iz �m~w ��{�;�ݫ�Z�)�̐,��vkIA&���Kg���d�,�����5�'3S�ha�$���������#�5;���r�h~]qju���N�Vq��x����v���D��)��:c$����1�x-k�09|�~�F���a~t�ď�v�$=y���I���ѐQj��Y�q��}�{~g]�1�#��0U�{�3:cdI������\jtƈ��zE����*f�1�n���Y�2��	��3>r��	��$|T���g���Zū<�kӹ�	S��`��U�K�er��茑�M�����u����#��~����)�2CP+Ӯ�h�<���� Ʊf������xx[���'c[�1�#7ם0zZ�kit�HF��0�}h�̉��3F珯�Ȍ���茑�����v�i��0URŎOS���þ�GgZ�z�0����6̏�x�|�	��]�|
�3-q;���}TO��������7̏���9|Sr��,_��NVg�����N��Z�1pq8��g��+l�-3��%=�D�����x8�E��JLվ�G'��`��Ӭ��5E6:c��-3p�}��DP�3FF��\�uv���Gg<�u#�$Lr�pu���[Ԭ�IX҉d_gZ�v迿3sSܞ�Gg<�����K� d���o�x�^���q�U�茁�� r��j����Q��ɚ<c�,�����A�ȝ7'�&6�F�Fg\����:l�v/�3.>��z�d?o�ͣ3.����*�y�茁��Qh��8��/<:c��ӸOvC�̻�n~t�H���i�R1̳�}���xK��w�C�ʍ�3.ng�n�h[/�茁����~�Y��n:���ۂ�*�G��Fg�����T��Ԋ}��q��Ӕ5I��uƈ��]o��T4���~tƈ��f��{G��#.>ԍn`�񊹸:c�->�)MC�[g���q�n�}�_�nuZ��r{��3��K�������W�`��Ȭ�O8)�cw�u���}*MWgL\��~�I����r�p��8�J������aa���-GB56Cz�+��[��N��c|����u��JG�i�w�1r�e�(zJ��F���]'�\��f��jR��gX���H`�?b���������
�      a      x��}˲$���:�����l�/���F&�6��c6���˝�	����UV+?H>@�A0>�#�G��(>�0���/��?���p��v�K��)���ǇÏ��]�O%E\D�ONGi�t�ʣ<*(
(z��D�3�s�)���pWu���<�Wo$KE��-Å��ho��[T��'�Yg� p�]����$!�b;J�;܍�Pe�F24����l�bdK�	�)�p����٫���5I���'U4|��.�GP��Z0�e��
������h��"�����v�<��U�Z�&�{�~i���ۣg������>^��O�@�e��?�դ�"��$����v��&�������V�$�M�F�J���D�Q�w1Z���9ҋ#�i+���/�2����9P���p��m]r�I�Hq;�NR^�jBЄ��]DGf�Q�l��!�p�ʗ�#�P��(�?j��paa���F6����,��;���T]����-�8
��HF�D��0�w���(u��؈j�r�.�J����YL`y�i�G���wh�/M�T���3-^�G�a�;��IBU�!���:I[H�_'A�&���
՜t�a��������kH|��$0Ȇ$��N,I��Ձm��\$!�lK�\0-$�rZHl�|A��$oe�
�I�%	�$u����Fsl�G.[�嶐�/~A�-I���ɠ�������-�8湈X���:Vc��L�"h꟱O�@�S�%ɂ�����{h�o��<�sR����j�=���-�B�*f�8�uuջ<>qō�7��_sӂ��P,,I��DX����f�� B�`"�D�)s7�:��w8�"��FO�<�-������5�7w<X$N�o������Qu�é߽�ꂃ�bLJw<(<]F%�p���F<br.���w+�Pۇ�p���gI;<���?�`�X�w0X�Y����^{�)�\�L�q���o��f0go�������A��P�r��"F����%b
�;4X�����Ǌ#���A�k��Y���	��a�h_+�8m����B��A�߳��4��F�l��T�w�f��K�f4+�}�Q��8h�{47�&ٯ�@cǯmp���`T�J+�hG�i���ӕ����8������\8h�]�_MC�����9�����ו���t��=����7RI�9#��EiÒ_8h�z��$#��C�-�	]��Ve�vu*XMc�;Z��qӀ�4�6᠓hH��q��\���Ϟ�c˖��A��Bc`�S��W��4fDY�����9�")$И15��gg�j���LG�Ey� �ƌ�ƠY��b|n�}J;,P�QdQR�Fݚ`��J1��Q��>Z����]��p�Keb�~����-lq�@��[���?%�����x�>v8HX��$	T�Zu�Քc���r�`�?L�ι�|��aI��)[��SݸpQ^�.Α�����iװNhi�����^V_�t$�/�/ܝ�4$���6ũ]�ϩ�p��什�eg������2������I}��=���.t���� [�i��"]^�*��Y���b��r�i4�Ͷ�sl�nı���g���Х��+�F��S�;4�'5�ތxtԷ�ű5�����W[Ð�+e�,�цwY02�-��)�r~�8h���lшg�����A��F�|�qZ}�}�����C+�5�*��n�;��*C�1�q�~�.�_��[ˬF���8wڰ���_�傻�i=6]�P�gK��,�������ƨ��hr���┟���60h�H���ȁ�b��DM3M7洑���Ma�cAI1���Wq��A��߾�pA�01���T�Ǹ�� [Zz�C��.�;���|Âߤf�#�K�v�4�xz�H�8�Тi��_�@��Uci��<����Hm�j��j�%�8/j܍<}��r�q�s�V��f��U�0���~�a?p� B�V��f������ʜݪ8hYp��j�5��_j\��l~�m :WN�� ߩ�w,h�l�Xz����^��C� B�V��f�*�E�����'c�;D�s٪��,(jI�8��`pB	����A���*͂��r��d�G�5�bCS�Hr<��Y�d�y�A!�9w���;d�~�`A�Ԭ�d~�����ҿp����U�`a�@ݎ�)]�t�Ea.,�MmzMk����x�пpР��vl͂a\�r*x5�C��.ӣ��A��ݼ�SF�Y���tx?iRmŊs�{����\�h��ވc2��o;4�[Ӈ[-[���~�셃*ܔ
w����ac��W�.�h(�����X{�|�h{��A�O��h�m��ڦ��A�?5�h��<P���^v8h𛦕��Ӝy�T��X^i��V���9���=.n�Z�������J��m�]8hP��V��6�x�#��¼`������UJ�*f���Q�^�؎F:��vb�8h"}��,V7�$+^�.8hPС-�87~N��EC���A�O��Q8hNq,���.�F�6tgo�yjEw}��A��:Uq��<��j0���s��Y�"<��`p��o�_3V�83� <@w�CY���"^��G��y� A�1�8����o����t7�`������
�}+�C�v��jh[���Cz��Կ���w��>�S�z�[�v>�Ҥf�ѫ!1����ؔ��E�>0���MMR�i��쐥�/$Ί����i�(u�;�?]�g��fЧZ��.a^L�<`vw7��C���� � 1Y��3h��p��G�o������)��\8h�#��ͧ��d*�`�,E|C.ݲ��1ܺe�p�@��2�2��)>�\�Z�$��O�m����&+ј3��qn�$�	��`���s7��_���((�$!�S:]�6E��*t|�p�A��3̼�-�R�
}��U�ѧ3x�9�p�@���ok�S<��K#�`�M$��[��L���el`P@{�+�!<<F��$yn���� ��F�H�Nĩ��9�������V|�+C�q�f��;�=�Y�t�G�M��	'U'���ϋr7hpР1��&��xX�b���A�E��xQ�4�=�^�8b6�K�U��DMÃz��+��qРsb{�0^���� 5R㠁�F}H7�Wihy��w8h��2��g��=�i!�Q��8XP��u/4�6���p
o�uؖ�
>C�k��*�ą��k��e�z۾�⑒8��\h:�Gi��w��8��}�0���������㔴�-���T'Z6�2�Ra�{U�d48��lK��a��{�:E+=ׅ1�(p�r��x���z�᠁'e��ia�̹��\8h��9yX�8�q��Ӹ�~"���z�:Ot�2-�?9n`ǵ$��X�yˁ���<��V�Y��K?�6v�c�����*}�F���Ōc��wU�I�&���=���U�1�K:��X�5c�ۼ�o������o\*�^�i2�;:8¯ѝKV:s�՞v8XxmC��$yX��,{���\�f��o!����l�mGl��ZrJ�q���MN�ˇfks�.��,�v�OFna6̶�.���Q)��Z����wt�sT^c)p,u���3��5nq���(OÈs�%Gn;�1��R�lf���X����A�+�ث��ϓ�i
�V���W����FEϹ������^}���J���u^�� ����ѕ*��'O��Z��~<ͫ�I�m߰k#�;:mS��6���y�����R5�*��T7	_�<v(G����}��Va�sʋx�B�K[�q�@�kS4���~�R^�c�)��mt+]9��d����5�V��-N�q�j��qen"q����4���qǉ�C�����6f�N+���MnQ�*o�uo�G*[4��d_�h�΅/�~i�*Ӳ2붯���"<�Q�q�@�[Qu
����;�|��^�$/Jp��8mK=�	��5�t��,��#-e�pG�A~�T1��l\��Pv�c    phjC��}*�&M���68h�_�;���sy��T��ު��ބi�E�̀Q�5�6�w��GQ�P�WO�Fq�op�@�{�n�O�[�B��#aSϺ�u���Fn24w�.�z��iX��«9S�.��W�]Jg���M�CY�������w<eO]]����cX?�6�x;/+��"��]��пp��Z&e+s���A�Qm�u��o�/.@,о�K��<�>R;����!$��R.� e�;�qKC��.��F�0M��x��F�4�ڞ�3H^i^���867�ܔ���nq�@���`�[�<�DF	�x��PMSq^�8r_�_8hf��۶�9l �4��;%g��JJ��Ϲݚ剄�?�����E��S|��e��A�>�I�J�dS���`�/��\� 4K�J���ɾh!>:�L?C��t�`��0�J��\�Mi��Cn��;�"�g��te�ʋ$w\Le�,p���)N�#)lE/���c�J���g��S�-����l���6��@{�8uhX���rxo�B�C���Wy�Qc�F���D9�%�6S�9[`����pǃ�|�=oD+N�t���A�>
�jBV:�n��1`pǹ>��YkM��E��R��.�]��R�8�85���xc4��[��4�a��š5Z�Ks�d]�����}ww���0���6`N�o$�h��Js:�ʥ�p�c���7�Q�0�*�pРU�6��V)f��мp�m9*\L*7[�V���_gy"���J�:� �-ͅ;�s�n��C��>)���x:���KS"�����x�8G�þ�&�J���a�;vK����mʜðM�ʐ��eU�ÁY�f�`
;4hޤ��pJ��
ϣ�*N�KҖ/j��f�S��A����XB?N���ȅ���s��Oa��+-����p��ΞT����:]��򨳉@��L7uRz��f��j��e��\�cʞ����� yx��,褤M�X���턣�tQ~�/C�j���n�����YϹ���X4�F�Z��q��5/Xq�<'����)�����D���0HаfQSl��\uԅ��]��Z�r����"��;�,dqx4���y'���(�{�M@5�h���I�*�l�J2�L���pРyKPbi�%:Ǘ��pРy��=t��ό8��yÎG�s<�*�h��'��w8hиE�bi�ݏ^-ͅ��'ΐ�K�L��b�O���`r�+���{h^�;4hܢ�&6#Π�~�U��A��-️X�F:M��i��e�U'��։��=��n�i�g��!��t�j�g�>�J8Z�� Aդ������Gle��]T�ٳsk�F���8�j��l�b�������j�V��L��\8h���*�����b+{���96e�l��k���3W=�%�?s�`i.4���ӝ�ux��CS6�c��|�z�T+]����5�xф(���҃QA�.,/�ѣ�Ł�9*�8�t�)�����^���0a�)\����q��L��3b-��و�7�����x���[�Mx�S��q�ipР��;~�F>�y��7�cZ�ܺ�q��N�l\$����u��[�q���u�+>c�e2���i��?�x�W����a`Nԥ��iά�?��]�>�b?t����<s�;,<��&���FϤ�s.��\�c X�E�DKsf��F#���)WMӔ�\a�U{���rӕ�F�1�Y��4<�4و�yyVZ4줡h��(�JFW4�%�i�g�ƣ�qW�WY(qh15#�o>j�4�Rԥхos��T������MZ�ݿia®L���ao��L��f\��2��Z��-K����8ܕ�uI�p�_M�f|�c��2��Z����su(�����aco'"&�k}���}�u8�)��A��m.4|]��Xzꢟa`Xc�-��,>���l�C��$K�D�x�k���G����A�ſ�w^
[h�Y>m`��(�k�M�H��2�f8h0Gz���~��1;G[�wu.^ko�U*�ƫ��t����u�ϔ4Pv3�4�Q��ސ�8�D�h������ڛmib���hKs᠁�m��B��G2�Cࠁ��KC�/�@��w��"�{H��#-z�I4P?q�ë�ں1h&Ҍ�m$��8�)V���m�w%A�T�7?��:o�z�4�w̗^āJ#S=���!���xB[BW������ʼ�+sc4P�0M]hΫ۽�p�@��ץ�F�J[,ͅ;&.��Z.��mf0�[��\�Z���ļ���I��A�:�dKFK炭_�;4о��oX��궼TjpW2�/��>gil�K�b_X�0H�{���*��fM=���h4н�u/V+>'E��׸���cSo��<p��w�))I�^օ�3Q#�����-�.1n$�87���Ԥ$m@M��_����ANZ�k3�)��v�T8emkti%&���ࠁ҉S#�a�8�Ks��p�.���x�_m��p�;�%5sl?J�m�5�;��K�:����&�p���%i.�4%�|ݧ��A��~��г��c�-�pw?rԶ����5�ٲ\8X��9��0�ۙ��[�;��Bg�f�di��y�T8g���V�̫N���lV����l�Q�Th�<�M�M�3��yKs᠁禺�J3�cr�`p@��<��y>��p��8���+/I�����\i�1��*��t�N��,��#*�kf��F��1���ࠁ����O�ab�f!a�E^��1�������cr���{�_M?y�Ɋ�.�Qv�c�KQg*��O3�I�7�+�ڢ��-�5/ᖱ��Ǖ�wO�[�~f�Z�_8h��E^��6$�P�����ګ����x��I�Uް���5���P���P��w�'�-�}.��W���k����TtF�+�����[�����[K�!?s2�r�;ܕ���O�%y��4a��,P������4P����&��&����AC��|ץl����8-žm�aA)`(���X�&M�:���;�l��w|����X�����Lf�18X8�bF:� Qm/ܕnҖc%Ot8��;,�`q{*_lY�c�q�e�p�@�[Q5JVzv�V�o��xj�6��G��`�zҬ�L_�'��G,T�z#|^���Q��K.�����lI�(U�T������阣�>ì���;�.i�d�f+=�����pG���<@&�c=�����*�Y�V��Ǟ?s���+q��u�W�H��$'|���(p7ތj�y��z|H�1�-��9��t)u�����U�fݶ��c�*��AU��m���������h���>>����v8x�ϼ�
d�糂}�yᎩ+i��o�=0�f��"��Xt���}��-�j�R����ۖC��58hxH�2c��U1=���\64Z��]u�C�ztmM%��G�� ���1�#p��Q�xf�G��wL��Qv��ufl���$�x��Av��s�d0x�;�� �c잇�����V����q�m�|�i��#'<��!v�Sf8��Cw<J��֫�a����pG*�ؾ��d��y�l?J�� ����p��&��z�����w8x8�����.�|6I�jhp�'l���}����GIy�;f<�;�x΋��V��O<�v�s^�U�{�;�@�t�<V<�����d���3ס�?'��5�H�W|�F��p�%�p�ġ�@�l�=˳����K�`�
� ��і�
T�5�;�wW͡�fI3>����w<���w֨X�2/u���]�5�Kı[�gB����dk,�n�r�˜8w����(��?��t>�����Z�x�]�zJ�~�ր���'��q?��93c�|x���Υ�����E��KT�a�;���([i��c ��:'S�yyK��gn�~3E	���K*�N:���w\�E�䠆�����в�i>FY�V\�y�i��ᅥ�aey�;�뫩*�E�O�X���դ�6 �  
_��v�|ÎGr4.L�'!��&�����Rw8h���ʐ�QgV-������ �0��ı�f��̌̍��sw�o�,���~�j��s;ܡ9�<����`%,�|�W�k.J�tW�و���k�1�f�c���4}��h�0,P���f�>�c�k��A���JO����+q�;@Z�ݛЧ|�{�aV w���;w+�1CO�+�w�)�ʲ�Z��ڛ�؅;Fts|~(И��RO����r�r�T)O��G�}�����.z
��S���j�3�\��w|{����yn��'!�p�@��aX���R'"w\�p���9Έ,Z�4v�cR n�o:~�n=7��pǄ���-t�gK_^��]�ݯ���e���.�����CK�9k�]v��P��Jӭ�s��1^4z,͞QQw�%Đ� {���/�b��8���A�^NA���C���u�Dw|���U������_����������������/�+��7L�^�Dg��� w��9�o����"R<���$�0�P����P�E�p�-����I���k�@�.�0�2�������;�-�8�
!�����e]���wLtW��c�y4��\֧���Un�5�gā�W��|�,34�~��3�r$ Ⱟ�r���#9�?�#5�"Q�ㆸ�w}d֯S:�-��(��A��,�;�#�ͳ�A�'q�LS���Jene�;��#��ܟ��qǡ��D�����;�1b�)�?����m���+Z������tz|��9,��G��4�~L����L���w�MM����\uօ��A�Z����L�KLq�;�l�Q�-�ܶ���y���ա߫�Z���Bu�q�@�U�~�Ԏj�#p5f��D��a�Gnm��������g�d���1��ˋ��Q�Q�٘{�;�H6o;�8�d��:n'i>>�%{n�U�	�;fk�m��0��>��o'i�1k=��u�=TH{}���h�s�`���U��0u�实?78h3h�:�f��&)���M�&���������Kxg٧�2�4����f����RTO�����8��9�B^8h�rA��՜l���PWX4�](����(�����\8Xң�R�
�}�H�y;.}t᎙�[Ъ;l3�RS����k]m�u�ƌJ��;,P����Gua)s	���p�@s�;F����J���Q̜)p�@�x�!W31�G�g
��Z��]�	���/�u��w��߮�U�4�r�1�t.ޜcU���>_��Z'q�@�=�Z���5�m"�]��Ҝ?�J�w8��o�4un��̲Q�w<�����21G+����7�-4��K��腃4�1�)δҽ�&�r�q!�gn~L��nq�
�9݅�WV���4�x�B�s_�2��P��4hu�[u+��2���A�N������9�-�,p�@���ݞ��LP%M��A�ߧ;����g��"ht���S���ꪽ���΋F[�ƣ�H����B���)?s����^8x���.�������;ص
m�7�S<χ<U����8i�>��;h2���e΋�^�f�L6np�T��f
4S멭���}�7��D�������|tw���}�R㎩gh�>TlN�q(t����97�n���A�.7q\�؆�-u�y�+�V��a�!��ь�;>s�ʍO��?��jq��J]nBI��np<Tv	��J]n��<�i�G��ẍ́��O�������^�y���9��<a��������x����ߵo�.���=��������!��:�j'�q�a��F/D���75�x���#=��.�6х����;�lO�+w4��p�E�W�9a�����^�y�̨��"�p�����"�=]���&�H�@�Y����	��|�<Ȼ<
��`�~}-�|t^�I��M�G�0ToO��+�}KV�.D`��Q�����L�#��m�wLj@�[&��L�t�w���*1��ML3(R-�5�x����C�9Q�|(pǔ#4�������*^�kc�}�5�]����8x0�ڧY���j�p�@���Y�z��-���6�����!:���������[{�n��b_�^8�h�>Ne^Ũ˼z� �J�*]��.᠁J�+���-�v�t�߯�f�&˟m�_8x���&6�����E[�u���Ss��y�����A�^��h�4�fD}OX� �N�{����S8B�;<���V��g0��n�j����;5V~�0u�y��!�M�K{�(�W"��y�k�m��g�x?r��������)�|�S:�LHm!�p�W.h˄7�XX+��l�\�cv�v��{�u#~>듭҅���#)w�m^��G˶0���PY9hm0��ڪ^8X���=�����B^E[i����6��'#�����O��O_�qw��^��yy����O&�[�X�E3���x|$�Xv��c����i�����ߠ�3��X��<����_{]v�f8�0��n;�;�1���y��̔޸ "L24�7���3��;~nϼ��A1+�;���Fp[��X0��wL�/�3Q9��f[*p�;������XVU���̶ժ��y�ܿxҿ�Eaid�t���}Lk;�1��̻V��%�h2[e��_����V����*�3ϓ�^J�qZ��M�|��U�~h�/x�տxv��U�~&���̥�^�HD�䛙�K��[X��㶑��)��׍�49�����W*��� �&3z�y�a鿅�̌(�����Ϯ���&G���F�����Z��8�۶��%��q,Z��"xv-���~��K�e]�$"���R�K��[X����������u#�C5�Yw��Y�^?4�����j�n�]_�d��k�ox��\{ɋYo�>�O'��������Q���y�n6yR�qǧ�t8���|ć1��#�y�����qG)cZ�e�7�FGoz�<��E��B�v�x�H�� ���dЏ�z��px�+��<Yi�o��I,8h��S+�E���L��p��P�b      c   [   x�m�A
� @���aK��Q6�1(�t��Ő��@LU6f:ּ�䥂�0{�))ʃ\�JCJfj���Ûq8~Ί���f=+-"�3�1�      I   T  x����N�0���S�ٱ�4�!�I�9 7.�h�J]�� �O�����0)�O�}v?�(n��m/�^!+�p|�Z#���Xu]�C�n�]����W�R�2�Ӆ�g�xE XjG���x��/H�� �<CzM�@��];�v;����vs&�4[3kR�K.V�����h�yrw]]���r1j`7��-'D�y���eޤ	J��7ҋu;��x�M,k�����K����㹂@�	�ui5增H�3��Ԭ�Œ�Hw���F(X��z#�J�OM��Tf���N��l^�)���)=��e���Q���^���z�P�]ԣD+þ���x��7-�����      [      x������8��gw]E_����<r�+O3�8�B�����D�����ۨ��| $�����
.���������)����|�$�o_���o���CL������B�4�}�J����q��>�M�p���������������������]}�O�q�?>�ە1�ߩ^��5����`�.�X��=������?����������f�?$�!�� ĉP�L�ALc��~�� �Eě �Ǎ���wW�u!���l$ϛEA���x�e�U8��>	��j��(�6�{o�k�c�����g�O�;����˯0~�X�sX���{�3��=~��g7�]>�^u�?��Ŏ)˗��_���d]:����~��=ɯ����V���wpc�\�ձ|O��@�OO(�FO��/�]���r�������!��U�w��p7������k�wő��w���Er	88����r5�c��9r�9"Fs�v����m�a%�&���O"���xWW��`>J�k��j��v����9%T�a%�͕ZC\���Mc�]�c2����١A��*Ǐ/\^N��ÿ��V[^4����w*W/�'��^���i��>^l� X��P�F�yM?v�7�R�z��>TZ^1GIa%��Q�>9^G��_w�Wl?6��Q���̦U~�j�J�O#�+��sBo>�ٻJ��wh���P?Έ+��'�*�:�9�$:Z~|!��0D�>ǆ4����8��,�8���k��z��t�����ߏo��?E������D�0DC7��V�j����is�#$�Z�!�g�ܫ���Ϳ���x~|���o�� cM�q �����n�H�O	�N0�C�Ǫ�	�dDC}���̀ ����P�r�	X��%(G?��[�N%���ӧ2tG�&ВE�{��7��K�� �9xF�;�k�����Ŏ_�����x��-�����EP�8Z�U�	�%Ϡ�z�l �`����yL���Waώ���T(�C�U l���7�%�Ҷ���1k8��d�7�v���G/�6S�Əf��h+r����s��У�3"�C�u�?o�E�,A��~�C ���qH�G���	|����EP�$p�?�#������n�r#�i�<�P�:#T��PE۸��>:5BZ��6&��$��J�WS����lC�M����N͡:��Im$��:�8��ضS�z�}6}���"�	�������$���M�`)��<^����C_w������(%�twDC06�0��vx6�gKht�6��X��$�on2$�@j�Pw���{-X��3����%��1	3dː��!C���`��;}���@��JT7�Ә�x�Lr#+�[�Q���c����l�d�o��Qլd���r��cu�]�G3�3��q�2'��0G��gƹ[|��wv�\H	
.o,�pf�1��o�G�h�=����.8i�q]Kb�ع�V��MW��9��x��p�L�55�B2LR\���&Y6��m�7�q���oƩ�6=v���3�!�T��n�$`� �b:��>L��!I�l�t��]0lf���f����U��3>��Ng�zՋ��a��M��a�\�#�>��,<��4�l��+o`��"�Y��6_�����Q�eb���B���J�6�rOn}��Xp��wOo7���Jk)��o%L��X*!^�`�Q�OS3j�gH������Z�8��=�+�ːCy�#�*²�6�`�[�2\����2��0��a��ㇸ�7��n�t�2TuVt<��4W�r�D��2t��������������Zy�D0�0�}����3xu�'#����}�w^%���:n���,�����)��灼{c����K�<$ː�k�/�s�����h��q�� t�M�NˢO�@���a}ЧD̋aܱ}���j-=���ez�д��z0兡������f膁���i�o�0T�@�62.�=�AHXsq����(|Y�C���ɿ5��*��^$��-]���>���_�F������f��!�C��Ū,b�,?��ֶa+Y61a���Hא���m'���)mB�Tg	�i��MP�2{��<n���k^$�h���g��W�1O�kg�i'�{��^�X�E�2:��pzV�q�������l��	�! ��а��E0��IkḾ�0A��n31��J}!h��8�<��������|����m?x�������;g	"yIz?�Ӕ���8����	�"�dDk5��ݠ:K�C:p�@J� X���ت�	�1H㴲��	�!���PWi5�7s�[�&H�����?�Æ �8����	�%�'���!Z�;b�����ނ�0A1d �c�8���b	E�2��h��	�~�^ O���X�~�okR̤�g6w�IO�놀�)��C�Ɩ.�	\FL�����Iւg|�����]��ceS ۄxd/c��O^W~VR|ss|}&Q ��KCS��K0��z��H	4KP��8��k�� ��X�j�@J����1A{!Ȥ��#�%� 8K�I=���r�;@��;&�������#�� s�;��0@� pm��[�v+�m`�H|3 B��)?��~�z� �`g �!bl�=��%L�A�
��1�8�Lx�]�fV�t�n�g+
�4�c��9x��j�M�cӗ��]R��g (� {R�걊��N@f�x�GA.o&���"l�x;��D�h�g�P��0AS�6P�v�%��HW^��N�$L�-A&%=���^
m(�����,�h�߾j8���B��NI�plߚ�)���8T
��Y��=�y/�O�����?���{bw�exD`����(��O��qVKO�T�v�،�K��!&K���|��G�$����@���`	dC�x�c�$fT6������J�%a�b2]g�G�!�/S �
B�-��0A�C��q�+;ADĀ��K`	�ݐ�i�!4���T�Ryy	K��۽0���`2���sBB�� K��f�:����7ϛiF����ؔ��J� �̀�L�C��ݸ�m3H�F��Ŕ��$C�(��J��r�q�ʐ��?ms $k�!�IN盁O
`憑kb*�Z`%�X D���C�\U;A��֝�%��Z�F!F�ԂKnzC�q�lW��(�"ЛAƎ<��S�!]v%A�3�JEY��d�����u\e���.����y3�Vρ�<�����x��ۮ ��@�yD�E�J��6�p�%�BPh�k�z�IA��ɗ�O��N�����dDC�Ȕ}��O!�(-���i�w��7��K��+�89>���%h�:��wݪ%�@o's�j�����ɇ��@��I�%�@o�n�C���Y��2����p�P�o�s�%�@m>�*Ѯvb�}	^�p�`���< E�9X���K0}'Hu��Ҹ	��^�����ƞ���n�3����+Fo �dC(i�b/˟>��� b O��F��E�xO�J�O������X6 !Y �P�ۀ<]1� �=��%�"Ȇ �i�;M8�i'ZX���X��/f�L�#�[��O��;��9�!*�CP� �8�!���i���q����"(�`����H����.D��m(�"��`�]�Up�� wH(pP{� �d4�H��a:3u'Ȏ��c�	�dtC@)b�J�x!n'�x��^ +�F���(~�A����o�N��(�"���#�+G�f>��<)`����*��m��uå�䒟��y��ld��������
�ԝ�"���t�*�5�C��ϱ���r;˟�Cmo��4�ʘ�_)�!h3�|�3:8.|���V�xC3I2��	�y��x�z�7@��Hp���J�	�"�諺K֊�fE��}(i����2	z�U�=����ڨs�^$������N�T?="W��R�#-1���6�M�BO@H��z�*���!B���z)FcWF�!!>��n�5��p���x�bƟq�.�j�+�B ��Ζ7!a�j0T��-��    �@��qҾ ���Eh�W�w���SXiϸ$#�J,�$ց�{U#7(���W�l����uH�$�`�ɂ)L�����Q��a��L}�(K�l��]�ֿ�+���Vľu�dmQZs�x)�8�,r1����j��NZ� ��!��D�� bE7^$�[���H�4텀~����N����;C0�N"��1A�	"�o�]i'�E�%�S��!@�g�H���� K5����X��U�E��!�s"���P�N�qeB}�,�d	����!�/��!Idy�HA��8���zI/P��f	X��U��_���K�l	:n"C'�v%*�"�� �{��2[����f^o���,�f	�?���%��J��,|H;� {zD��4`�[���Oޭ��>�C��x�;,_'"���Z`}�7fE��z�#Nt��?�yA��/1���'�7>�UL�-&��f$���B����w�W����+�%�?��9/PF��9<I�K�jrw�J7t��?��m[wr��Ɲ�%�Мe����\߆��0䩪��aI���.�+J�0��}�.��]p�y�&Ȟ�2�"f�B?~���!�
��D0D�����i��0��c���z���#Y���󤺜ؚ�D��61�0�X�i��`SЩ��Џ���C~a�}d$�A'�և����o
3�owz���G�G-�d]����r����j��v�d�֣��>����O��)C��0C()_U�ᵀ'�C�s����1AA%��#-:�ok%�u'C�ɇ�D�;C$���[�X"�a _�P��h�k�Q�u�D>U���k�
,v�e�,A��� ��X"V��(3���?X�ĞQ@����c�7|��<��2�=���?`·Y�k���UXɸP��>�Qgv|�"@i;%OEY=f1�D0x�@'�?_F����������D0Ð(�����ܻ�X;a�KC�uf���^6�� ��r��Ah{B����һ�f�ht|Z�W�@FP��F1�p��(�.�̧�m�(�$�L#IT7�.���AJ,��+�U~�1�0���/�Q�C��Nu�p�_���HP���UU|-7���s*��`�K�ۿFDu��s�B�����K�(X��PPš����S��7f����Œ,
᧽�Ԍ�W"�+D�5�ɤ5����P�!�&�F����"�/g�;E�)2�A�Ǭ�)���tp���I� o��)���-�.�0�?�<�~��O����c�G}���_�?A���7��a�������_T��:ʎ}��+�����N��T����zطk$�_zxju:ݶ��S��9#S�v^��[TKh���_56mqO�٭���E*g�)G��h��$M�����/���ߛ<�	2��;�����,w�N������j~�o/�����Eu��IxOT��ǥr�~�E��'�bVE�\`Q���Ħ(�q���L������|(H���&Ṉ�"EDX�lx�H��T�>%MQH	ST�F���ź�o���"�ެ���Qޚ�)Eө��ψ��u�ͅCt���oDJx]��HF�<��F���8z�H#�'��0��F�A�pJeQĆ��߉�Ρ��X�FRpK��B�f����T��w�6����̺IC��F��y��Ɓ��^+V�{~,`�o�\E���NflOMb`�?;���j㸎R���������W?����Wҟ�r�Q�vm�wy0?��$j�>:J�x�ӱE�Mx_<�z��y�r�c73vB@G?���6�t�֎ a���x��	�����(1臲~v.�j�v�����Q��V����ҩd�0��
VR����� �UYN]��� ��J�w �xܢ@� ���>j�h�Ƚ  z9�L���>#_�]��jf��Q5����߯$�$ �X�� O)}�x(Ո̦��.LE��Ir�e�ʿr6 �R�v�^�����1��v����I��p�֫� Q�f���q`�����>M��4�.g9�w�]Ī,޷I��f͌O�_��v6~Q��;��
dq�M�����qT��t�_�É��}�K�7��(Ύ��i����O�pG�r�Fg�3�7�S������ѻ�����K^�I���R���5N�0~q���*kzo�g�h�GY�rj�-^��kB�aQ��3z2�S�C�ۣ�e���	�V�(��+DR��_˒=��
�t���J���_�+�Pbg�R�Sf�{
�%�u��寲��0Ҭ"*�.�;�no{4U�8��Xd��|�N_S��(�#�m?X��A���I����W�,JW�%WZ�i���e$��÷��G	'q���a� ��fsUgs��b��$6��I��ӄy|��J���ږ���%�54���BN0،���x���9~mb��_��V���{���>��k��C0B��\�w+��_�����K�E�n$%L�-���/��z���2�!j
)a���^==��/滁��I��={�}&,�I3�IFs˟�^Fތhh'Gmv�n,a	��h^�,o-�6��ꕄp_|��oO�kIl	�XpB{*�-U��o�s�B��������bɓ��3��?<��SQ������/NK�_�PȂ��{4� �I;Û�0A���p���_`�5�s�$LA���MV�v����*j�=�%L�,UԺ��5�����no�%L�-T�v� \x!���|dM7x�&(��a�~�4q'�H���LI	TC��j��߂+~�7R4�TU|�DD
�0Ƅ������J��dlL(9P$���lP��à������6K�� ����%�\�䦓w�ǒꨔ�o�����q����x-��"]���mՂ��?��	]0M�%�Y)a��22(%� � ����}J�%a�d�Z���B�P�ީT��%L��GZ�/��P, �Ҩ��f
������)��xV���>$�-A��del�j�i\��h����R�6,�hf|�Z��>����d��+�f�K��+�����.Õs�f�瀳MH�"��P*rz(�,�����y��`�$���Y�M�!�R��}�[�Gmh�xgz��cU�|+YW�"�����@�k���~uؚһ�]be�ߺ:����)�C O�گ���Ni}�3ˋznv%%��V>g����?���%6��j�U7	�)u��\=T|�Ī%{���&z��M��L43!\?�oI7��KA�{Y�,a���H�6�Q4������8m��\^CKk/�Z����fqR�Z����\zQd�T��)�,aEVl��Nqߡ�F���O�9�Ȥ��bAKVsL�o�"����Ŏ�'��)�s|�%ܜ�����6�9�^�g�;/������*R�!j�E����9By���9V\.�Be%�`9�j����C�ԇ~�Ү��R��j'ŏ_�¦>��]L6?OJ� Z�;j���7�~.rF��(%L�,AF#��{���&P��m���0@� uZ�O�@:hqm�&=24J-��E���h�����'�����X8���K�)�7C;䡔
$:�;��k��ۣQ�l�{{GA����I�qv%�	P�]ރ�D$�7�y��������N��@���^1��;:�5�G�3z�GO��5�?���ӦV��?Q��G�P*D��_�';zA�n:�6(��E˴� �]���	�KKV�s��ؘN����J���U��c$��(�y���o�?�9iZ_����B�$L,zR�c%�ם���:4�,a�h""c��SA{! ��H�%a�d	*Z�~�%7� m�q��9�&Ȋ 1d���X�½0۴#l?�+?m��������4��z�*���^�(W��~ń�/gq~���M/?'A�;I˩"�G�D'���\��+�i2����_yE�KG���6�_�K"<�"\`��MBe8�����^F��D�.��`bhkF���;���7#Jl6((E]�DU��h�P���bT�YG�/�J�y%���O��A�    /?�7g	��ddt/�UB5J��1O�k��8Ż��:�?2lt�<�:w��0Z3|ڇPQ�0v������>�ݙ�3����gŎ�b�pZ�s�7B5���]�4�-�HF1T##r�m�@���Z>J��8J��gC3�c8����%Y?���`�>b�w#u��UN)����M2�@A4d?��GM)���60me0����F"v#=	THݷ>R��� ˍ`��
RUZ�K"C	��n~Ku��&e;!<ʇ����{v_��N���=�2ѵ?�-�E�=M)_����nv�m�2�4�˭�����0�G��$ڱ+
����q�Ʈh<�>����uu��������}�r^4vTc7d�vu8�߇�(�&�Y�����������e��r�{:��&��C�:�C�F���8�ŌM���ml�a���_��?�]�؉n��tcI�˛�m�������V�vB���y+w�}���f:Q��!��Lg\�$!���G�P�HOyc��ar}����fbA��s���B.uXTC��3��m�ÅҜ����/�:��2
�?Q��Jk��]�"�f�Ka����,Ǯv��]�k�H��<vyjJ�+|T��c���IŢ��t1��D��W�'�rW8��c��U�rļ���6��O����f�Z�!V�K��z�3]ס�D���Ԭ���_���	��"���_8�c4[M����n'���"���7�bw���	���2c�yq|���/��.WQ�1��y�%�;�:�s��N뱴(�nmߺ^tZ��c�"���+�v�,>*��|@����c%��"@�%�z�_�Bw�B�o�	��Ԓ,=_V�A1�>�>Bw��:�K�t�v�zՎ����p�)^�g�D�]:kZS�?#�y~�E������a�M�椧�u�I�䞃��;��$���t��&�D��;�s�7N����ٯ͠�͠�}㏻�F�t�>����^�7ɳD��0�(����QD-!��Th7�Ȼ��D2��<���i�7��+^h�=*{a�p��aw�-�xU��0�LDh(��1k��� ��?��CMY��$����� �j߯v�E�_	LEʡ��s/K����"�|�
A�n�?�4��F����V·�c]v&�}�ߥ	��J��K�%9��TY���+�B�_ ᅀ*�].��`I� ��ʧ'C]uR'�I�K� [�z�Az!@W�_��	�"���	̅K��<݌��N��}�<ǣ� %rOմ�Ƈ�!?݉zZ/�g|U6`F�%��ܫ��R��w�8�5�_��di��G>�p@��i��sIO��h�U�� �$@��9�������\�Uc\��0�HV�`5>�8ʪ=/���P`B��6�\V`u�1�3�$\�c'4�o�ixFHJ?�%��;K@-ZQt�@����*6�"��`��/�3����q�Qs���ZE���%L���	zh�m��N�QCEB���(%��%�!��z���c��E!��q:������C��%��$LP,�f�FxL������ߖ�!%L`��fu����v�-�d9�E)a��Pμ�l[��A�1�]R�6��c:�N����(g��d�i:gЖ2~��7�n��&T���e %L�-AC��ikPY�!�73��{_V��[�d����ͨ��i�""e:>��?q;��*Y � �;Rə�Ӹ>+���Lӟ�Jv?4�L�dc����U�f�E�t�����8�
T��E�%賁��Ո�^y�=��QF��pW1��P�&�Φ	�>b���[�h�c��*̴/�tC�W1�nVǮ�G����^��ܖ��."��g#��u�4�ڋD���I�#hV�����w�ۗQZ�+r���Y@䀾|j<v6cG���ǺFRo*�$Ɵʫ��2��\,��ԦrC_]IT$^��9jC�0,3��K
)i�m/�r�Rb�.�w��
����Vc��m#`	C���Ssdk~��0U��K� ��#�+-��� ��@U�v	$C��*#Gd>��"��/�v�%a�lr����!H;AF��K��X�U��W�Utx|T�T�E�����y���[�@��t����ub��;V��@IA3�hc����['�Y��!)��"� e飬����d�X�N�fo��
� �D�l���+ū��k|oǧD���� ���AO�q>�W�$�@��w�*�N@�;@Bg���%Y �Pݕ>:4����({�]��!ȕv��Q�@�S\;���� ��u��	?[�ES� �?�Av���K������d������\kP��e���mi��_4�g�"�I�=���]X-:l�ipe����1�y�u�m�u�fheW�-�!xp1�����[\^��{D�z؋��'���+һj���z�ԛ<�-5UU24�*���2�i(�Z#j�����Ә�ѡ9F��z��˻���zz:����C���]&���$�@^.+�������GH�Aha4t���]�� ��{��=D���K�`j%a��
�<�j�G������I���i/���A�8�*���d�G�2Yze�FgN�7"��&th������(	���b���A� q�E���k�'�ۖe��&a���ݏ���ػ���.����k	TKPg�Sc�T��U 7^�2=�JV�/Y?�j췏�Ն`s?���=�d�}e}PC��*}���0���5 <��4�ιC�8�~����� n<a�:/������WZK���OǶ�W'�&�e�P��Q8�i�tR���(�#O:5�X�$�Y���� �
�iu�6��s٨n���C�p��gڜ�+��^�%LP-��i�v���=��3������z�Z���yԴ�ٿ�r�uj��/-�$�£qu5��Y 8������q���qVK"���&ۿ�Z0Deˇ��g*/�Q�6樿����D-�
V��"B]���_ͽ�Y�o�%K�^,�(�p#�J�����`�?�o�G'�W��O"4;�_-�DT�Pgz�"��Z��k�F�ǿl�m?�����[k�E��J�O"�y���^��8�?�5��G�-�#S�'�0���j��=Ē�3Q�DH*>��D��t7�Q݉0��?���'�a��?�Q�����_�e?�Teʣ��:�v?�-￲���:|���u�?E�.mHa��K	��|%b-I��*�Si]T�%�$%\@�Y�>�rO��B�?�d	��hzE�C&���6��E9�]Y�:Ѻ�����~R)��M�����ʦf7\�i�Z���h%��q�-l�6�1��m�vR��x�/:e��3bcӃ$X&��������N�)���ƕn3�&h� ̂鏆`S�ۭP��`I��[��I�鷾lQ>�%�b#X��t� ��ԗmK|YS�ہ�0�7 3,���l�u�g���b����0��s�v�8���#�{-�fס�0@4 �Q;����ft����������i�{=o�Z�����M�J�h��I�]:$P��>�Ϡ*?QCX�"���v�d��5�\��o%��Vǜ��cKl���8�<�T�&Y*�wz��\8�M��|F(h���d$K�L��
�� �������- Պ���j���?�HJMw�y�m@��If��K�%�������O�U�|Hw�	�e�Ă����"a�db�?�`��n*�L�Wެ`R�V�PG�"@�c��"�iFulK���YP��l9��F������Ȓ��Y���{��3q' ePG��HA�H K��A("&�Yp�N���dx-������9��;8������q��F�(���R}=�{���8z5��G��������©{���͌N�	������i�}���w3z*��Q|̌^��3��R���K���N2I�蝡LUi�5�W��� ���{�*��;_ZM~���yr�|�oz)j��mt�k�hF�B��:vZ�"���=��۟GOv��zڹ9    �m���d��A�B�5z6���������N������y�3xF�[9|u��2R����4���
꒎�^�G�v�J���ql�����ƒ;��V�}n�M���罛�g��x��#j=�����ۻ�����?��u���Z��?���7:�9��?�ܶ�Y�j��y�`GG��~l�r�T�H�c��"%�]eS��]A ��9��N���/
z��=�ʡHI~Z�Qyk6�A�����4�mI"���wԏ�������4�-Ŏ^��?�q�*���o�a`�@���ٸ�4�(��z��1�K��@���,�lrxܯ>�H<
�BP'�f%�2A���9�H�ٛ(@�\���`$� �����)�x)�H����t�_��gm"#��42 x��:��N��D�v�]2WD~? K�S|� ��s�	��@��O�ex�D��	V��C�M�Ҙ�T��}|
s��&Y� `�4.��P��"G�e}�M��Im讅�ӒӾ� �[/��,@���FX�o��L�*zX�����d=-��j�w�7��O�Em<�ggǇI�d ��:gHC��}��D%Ygb�� N���n�Ty�r%m ,a�``�._�^5�!H�:y��`I� Z�2K����z��4�	��	�!H�t\�:ĝ ��uy#`	dKА,t�)�d	���kg;R�J=�U��R�a{T�m~�x�r�^1)a���v�]��3�n� D�ơ��?_N�m�adÝZa�f��tq"�=��g��|�n7�����i(5)�q�bF��A��-FCیF�q����ћ����u�f@Qi2��˺<��k�) ��D=��4��9;8�]�I`ی(H=�~2�����B<kt�^��х1��F2rʋ�i����__��>��8��o�#���ڕ��~����EK0���
���o�����$3~@=�����><�G�Wii�%<��KOC�Cw;A.�s���	��g�_�P۱�{Cp�p��N�h<~��Y��x��2~C+oU��J��*$; O�ބw��'�o K��w;~&ϋ?o�^�/4�]��0n��,ԓrC��!H��H9��H	�UHa��ʞF�^��x�f_��0�^���<��2�%RaT�f*	�u����]��>�]hu�
N�n�R�d��v;3�ߴ�)ʮ��`:D�m<n&�� �W۱_"�b	
�3c5ˠ�I� (��h�p�&GGٵq�	�� �@sr
�d�	QPqڴ��?0ʆy^u���H	$K�VL��IA;���J�Eص���	�!pl�S��h;A����N�$LP��S[���Pj�PVW5}���	�%��%��	����?T ��gZ	4C0>F�?�)F֊Zh��Tʺ�0A7�A���s�v��_��X���tyGp�!A~!��0ž,	�-�RC6�!A�f6���M���Y��� -Sy�E<߿b��+�����>�o��||���G�/ ������  ,�%��?�;-=�(�RU)��D�QO���s�'����*%a#{.�	=�\��u�%9ܝ{�t�M�J���A��vO��@w��X�q�BS(C-p��ѿ�ȧB�]{<�d}���O�5�����v4�ڠ=���	�%���f>�`;�z��q���YJ� X��Ӹ��� %�ֳ,	DK��\95�İ���Tv�MR����l��`��\�L��w�G��g;~E����1l�sA?�����%a�bf�p:�v8��l��0X	TK@ַ�z�1l�s��Շ�m�zH	4C0��}�t�O��L�W��M�<x��������N��C-52�c"EXIP�
�Q,�X̩�3�~召K3z��υ�Н�O�{5zA��C�����>z��=��)��*ztQMs��r���a�lG�ޞVN�����|EDnzd}_��l�g��FG�=69>E�5:�	e�����Ռ�Q# �f
D�(|d����~�k�S�j+Y}�\S����t��$�g ��h老��sZIK
Z��jm�ɐ�pç�w�"��t�����$2�L�"�]h��v�
��|�G2�0#'�=��%+eC�
��)���q��KN�x�xIgd	K�e�Ok�y��S��0b��"%L�����B��Ӣz)	7�ƙ��g��s���>H̔�|;*#tՖR�	�t|��� ��Ǐr��iF���(4~vf|���l�W�뭄	�!�+j�>��N��m��t9�!���!�Rp���r�7�9
�M;��I�ᾙ�jbC�ӫY��|}�cJ!5�YVJ��,|I�ái���Gm�4�P%�R����@�5�*���Z�@'ӓ�By��E�V����9��7�@�
a�Rx�iDQ�I���=R�e��Kf:�@Ƽ�I�#�@#T�TǨ4Y���YR�vLE臄0K��C1��|5��m�ҏ��_Z����?n��=ݒ�H�XM�C�H��%i��"�l��]9��i�y�oF��U���&��������t�i�y��d|<�)���H�ʛ$�p7Ys��a̛���(ơ~���B?ɛ��JJ*�b�(=;.*��i��Y�0�A�!kI�i��8	��O�0����*'i뛖�A @|��n�J���/� X�bCɠݎ	��D�,���N�O�˔��G����䝚#	��/!+4�:B��KQD|3A�*"���du,� �c�P�M�A;h+��HsG�-Y=�Ļ2�+:�b�z�C�.��T�Zj�V�� ���v�Ƅ�YN����!j��翇�����c�%P���at��T�����o#�=�I�,A���"�m��$�}'X&膀2 �~u��Q�]x zO��6 �, ��rd��VN��K��+hO������PIB��J�S����f(�`�褄	%u�R*��Q��V\�,;b T��{�ͩ��J��$�>м"@0
e�|T�����g��6k)�n�6I�� � ���WQ4C��V���TrYM�QK�V���@����
##c,��.�� qq�O�#�M�՝%|u&��栌܏�A�]�sPW�Y��zHƬ��J��D�����I@e�Lf��o��{�%��L� 1�8J�<���jHW�BKi}T�M�N����	���L7Wj
}�������G��p��\}B6��e%S6`�>�Y�t�U(<�dtsg��H���_ߢ�.�xb�W�9|�u �?�������{�U��׺+�.a�nO�ɞ�压�<�E�H�d�B��w;>������&UT�{��, ��0�9����(v���X���0�7�7.��Շ������j�.%y�H�x�VI}|��I��":�θ�n�`�����
�:-ϸn(r|l$��#��L��c�� �q�Ȱy4Ч�������A6�IPU��`�h�HE����0A��y�������(�ت��+%��%�%����v��<�RIQ��%<�d���9��C<�
To}!��	�%@���)�ێ�G�|���$ 9���p�J�N�P%���`I�����H�:�J��R��Q����H��%�M�[P=���$��+�ow*ɐ-��$�s��W��|�tzSա�ho'gr(�sQH�9�N����!ď\C��;�{���U��&Y��&x:�WQD���-4��\3/A"�0~0��g�G� 3�W��;�py/�d̀����%�9�mj�	����,	�>��X���A��hk%l�5�tE�g��S�&5t;�Ŀn��@�k��oȫ�Y��d�������"�� ]Zʱ;C����.��k/m�HzA�A���Ǐ�]�@�tf�O��ͲIz��$R�tK��-�cbo;�G�YS&\+Y����&�G�� �"��,	xKP�tZ>���#&�j&��F�$L,��䟆�W�_f�Kx��%a�hȴ.�'Ҷ�D���?��GOv� ew�T{�F�����*d	dCz��1A���������0	�~83ߩ��1A�	f/�ջV    ���ZXm�ͪ��BPf	�,	4K@5�ƛ:&��C<�J��%J	��pw���CFu�~H-���s���@JAr� *T:������.;ڳY�d蠸.�Ů��鎋:&��s7W��8�M%�ZI��M�d"��i��~��^��>�S�9Z�\ss�l�G1��.�!�X����I�O6EJI��ѹX�:K������$t�q�<�2��h�M��!���az�i'H3hF5��$��YT�r�� ��{��,Y�d���S�U��]3\�Q$_ZEE�)V��tuc%?r��vM�����������/�������;�8�Z��0��fO�"O�ǾA�Mo>mF������5QJ���n7��c=Dj�u^��µ�2�w�H��B�W���@eq�G��w^�<P��2o������P-҉�iT�`ȫ��,�G�/�{sW�גThU��j�3n._w'�c�םa�9Jqg`	3�`0b(8���y�c����D��	�t*5ޤ�h%��1�h�5�}9|�_�@'R�2.�9�&V�zM�X��@;5�u�.��񼋎�dTs�TXN�`XdKP������(	� �)p�7	3�@�sC��S��f!�!�� Kr���e ��O��h�m��6C��}~0��.+Ժ�|�]x�Xu�G����a��u����a��]v�G�RW��ӰICq�a����>g��2c��9�l�Uσ�0�8��#�+z锡+�~?�b�����n�.$�p�<Q��y���(I�"` ی��,���a/	|}}�KR�W	3�f<T�i\h��A� Iw��Cb�T>�L�bdC0+�t�YƸ>�E���9��M��2�4D�*ʩ��G�#ž���v@i�x����7�/�8M�[X��0�u�GDxE��8�ܲ{�Y��#�"�p��||�Sy�r�E��0����a��*<$�<�k󵹣�����p�M�r78}����;���O��L�)�V*�q��Ļ)������Y�Z���!���(
>.��c�.a�G�1�W6�"�n3�#C����8A+aC�6�#��^��1�of��Cю��'%L,�Q��Q�nlfw<��o�F)a�h	P�����7�{�K�W)��aZ�by����r�MH	�S�n�	�s�!���,�:�&(����^�#���q�C5'�yWYMYK�|�*���ǡ��W�(C�Fg���x�lqߥ��J%��̫�t���Bj�f^+=���H)���$jo(��:��:�D�E0�A�}�m,a�`	`��'�!����Ϡ��e��0A4��嫞��v���ݦ
M�&H��2��r�'�:87j錳�ms %L����z�E�� �"�8EWC�Z�E̄XZ��������i�w�0A5���ixH}bo�Z࢈)۷ %L�,����oq����4�9L���H^ՒD%9h|����G��c�����K��[�]��Ʀ��	��L���F�&� !����������J���;K %L�`i7���d��H<�����N�������;{�)�B3�U![���L�RZs�L�l2:��LS�S7���Ж�����u����Ӓ��N�\ўj(�j0 B��W3>�ՍO�4��vT1���xD�%���`	4K0�؝�G���Z�TY�`I���3���|ӆ�P:Ͻ�KAw� ��f옠���M���K`	xC��b��Π	��	Ʃ�~�R��P��Տ���}Ӂ�������C�w[�|>~y���]��$L�5�_�ia�Z�/U�e��)���M���rwɧA��	��;�a�kh��r�In�xs�d�s�A��tI05ьVaӒ�$Sv&��0�������	�&����K�EG]&��Ͼ��7�U�wM�(>�K2ՖA4p�]�8d�E 5�Y�AX�Z�*$|�Ƒ�'6c�9L'/Qq6JIJ�%d@��F_מM���g�\-��5�P��X���'��&�O?/�|(��g���I7�Cy8�L|}1fӭ3^�Šϒe�l:J)�BW������%���`��`I����DƩ9{5�����=3u#%�iL��E|��i�l�EU�|C�%�, ||���}�<Kx�'����ѳ���z�oN���r&��%P@@b9����)=?y+��"�j�x��D
�¹�``���=��;L ��Y�qn�7�p�5��5a�ߔ�7*�}�o<�6����x=�#W��J R�c���ю_Д�:��j��nG	Έ�Ʊp���ُE郻-�����Oj?l����=F���%� r/�j9��6Y�����)�?nB��!��z�J�����i��6B��%Ȥ<��Z�� *��gP���5��ddE��~�R85��;�p�Ot�X%Y� ȹ�Cݤ��YI��C�w�%X�W;>
�ԭ�R���E��h %YM4���C;;��*� �v��jE��m�E�A@��W�C�v��~%=��@HiF����Y--�h �=z~�,o(�~P�Vi�瀲	:9�&.��")UB�p��7�N����P��p�����@i�+��[q� �$H�`|YX�J� X2.\�ԣъ!����	��	�%h�z��6Q�AG�\�N�$L�A@y���a��Ezգ�dTĩ*۴h�S��-�KFK�p\�E�[�;�cV�m]%�w#Y�&l�}&��4n'��R��Sp��X�g�=R9O,�2��!��"o*3�_H�7�g�_�ÔmD�E��������y�,�`"�ȷ�ۚ߮+�:%��ۚ�,�h	2�a(��f��b�]��`�"Ф&H
�!�z��ǡGϝ]Z-2�����,a��6�"@*QÛS����!	29Njk;��0�6�6�����b^����¸{g�@I���;K0���k�/����s %k�k��͟�o
�)3���!�E���	�%�����8����k(䍀%L���\�S�~/���@j#X&H��r-��C�����kwD�6��L}@�AB��|l�oi'H��*ʜn%LP,AE��r���B���W��0A5��rl�ojO��0���*�o%L��D�+���8��� ݵ��1B!��쒜��HA��7xS�Ajw��.Ɣ�v	��`Vu�hRu\	��~�k�߹P�Ë$;�!�uP�=$;�?�Ut���0A��\Ok$�_��*m��0AV����U��$EП� kA`$LP��OT֞w
ok�Ǎ�%LP-��Nn�o��d�W]|!X&h� 5?3�4A���Q�<�)0���i��W<7��e|Tɾ/�E *ӄ��@��i�ڻ"wmhj��	��	�"H�PT.9�6;aO�O���I�.T-ɽO7o� ���-ګ2�|FG���0A4�zv'k�{rsA���|�=M�!�,a�#ҧ�]��ys� �$V��R���?����n �@.�~%U�x��� Sf��2;A��/I�h��0����g��Ax�ʹT�)�RQ�NKؽ������vxm��B�ܖ�;b�&Ȇ�,�t�!;w	�K� X���)�����"W#�b�|
f����%L������[�l(�Aq�6mJ��7� �`���SZx�N���͡��E ���N��I59-��׶������(%ɵ<	�%htl��2�a�m����Uז��h(1}�O�{yk\:cP�iv	$K�~X�������+(A^�}�&Ȗ`��<^�{y�y��(�}%��	�%@��?.Ҵ���3��K�J�0A5�<���	�~��n�d�����*�vKƷ�'A��z��C��ֳ/�X͛5WJx�%� ��A���9�q�) �Ş�,�Y_fu*�z�՝`��MA�&�`�S95e6�^�0w��K���* f�N�7�uKP�FA�+�j��	�%@"A<͘i���Gsh�`	X����q���~'�FH�� <~4�G4�j����B��A�y�]�R��d\UN��5_
]Hj�WK� ���%��    j4�v�k��s�&(� �ɱ������!}��0@5 ��ک��y�!���Y�p��I	��ݱ7��~_����PT��ηE�%<~7�S��8ԣ�ٷ����f�;K��E��!n	ǫ�����%{a�&�`Zr?fM�N@�2�*-K� �Y���&�/����	�!HH��M�A�	jH��hK� �����>L-��p�7�RF�"K@�q�ڱ�"$K���=�)�&(���Y ��T������]�B��W3~�n��UX��g2nه_���7�#Ђ�L��SV���fi���!�R�m$	t~(]F��p�K��
[q� ��N�WQ`"܆8�*�K��'���N�	E>�n	�r�	rc�'��]AFD#` o �/���#@�
X��R):�	#��שּׂ/]#4g�ݻ]��D+a��pU�J8�2��w��rmCFH��p����E���PP�8�K� Y<�s��t�W�������UQ<׌��A��yܕ��ޒA���9�������?�e҇G��A��c�Z*��0B3���OM#,�=���4���d��� =����Gq�����q��쫪
��H���&R��G�� ��Y�; �ɖH� ��N:A@�L���������O� ��j%1���!/lXh3�f���Zda���g�-pI�K��zt�@�:O	�ʄ(�?N��m
��0�-��?��>d6[�lJ��x�K���:E�'4�:$آ2�]C�5�E'%L`˭S�����{eB<cl��eX���:�'���`[����X�[*��,��,AA��GB�!��;��[V��]��P^�gC 4���ic�ENSaf	�� �qQ?Փ�28D��TB�����`%1݀v$a�pO �����g�tu8[�]/\x������s�f	P'�$^j)ao(�.��}'�m�mX?��)�����><E����� %-@��B�(.`�N@}����>,a�lJ�� Ɲ #�?���	�!�"���Lk�酠�f�e'X&�� 1�C���B�� }l8�GC %L�,J��S1�m+�5t܊(����	�!�}\1z;�w��'պ,�"(����G,�!ض���Z�G��%L�-��E�a�4�vD&y܊�QJ� ��L�!1m;R�mE�e��	�%@�]zm��#�"h�ݫl�;�aI� ��A��I,"�!M��j�D�d�&y.+Q�R:T�γ��i�N������'���[	#x�iO� ���PE2����!�</����A���q��ӣ��!!}�jiY��d�l���m%Va؟�	������U��!+����v��W���y84S��J��"t�7>��W�x���~�өX�ؐ��D
��O�Ը+�&��'ecF�݉'�@-��M��3	�����N�5O��L�s��d��$y�1���؋
�g��3딟*դdHg���dC0��k�FQy��w�1w�f
��	�! �]��Q~�	z'��%a�j	f\�i�v��n.��|�M�s��A3a���&\���6�UU��E�Vb7	~�~Z�#�t	zF�����GX�C�!��?��p��%��;Ijl�H{fˁ�,�5���qa���ԂG���un �&Y�44�<�D�^Zq��w�W��3���<S�� P	�+��u�R��m�wRz�sݓ	Kz)&d8Q�w��RL�ן=�|��C�b�Yӗ%��s��D�OrV�A��O�c_�}˝T����҅!%�+���p�K���7�>���%L!l�74�Ko}Ǩc��i�n|aH���
��ݰ�/��;FW��Mt!����FD9�_��W
�L�P��hL��)X"(���_ ��q�c��:ˣ�cIF6�V��V�#(�v�����������`d��ܯ
-�����I�ܾ��"%b6���do�p�_�*�+T�A��j8��"�7�$)I��BSPZ9BP�ٝ&�'ь|!����i.X"�A���S�&�6��� O�e&�w��y�.ۿ���Am�3�$��wvYJ���#������!��xέ���wf.�dv.sԥ���Y��JǨv6<�(25���������Wd�Bޮ��$���Ca���ۣ]J�#q�#�Q��b���w�<��.%#Z�>+{�������|7Ld��������0R#��4�w�$�����ɴ�����,�����|��B~��dm;)�h:�n(�,��}�>"�Aѝ���U��P�d}�҃����N����;E��~v�`d_��0��h����{�h/�H�n�J��`D,��Ozg�U��?��A�d�|'�iI`E/��@e��	����`�ǆ6��;IL%aQ�r��"�Dү�S���WV;��d�8����94���ZNA�%�<�c��y���/#�hN�C�4�}ho�n?�+{�լYGY(�t������NY���,��[����֠��F1�F��v�y���=z'|��tg;�4��q�,Y??������M�� 2"�鮔�t�|+y)G�P�j>�ٟ���S��Aً����ք��������vCH�v�*Z!�Y���e���Q�Aw�)���X��<=4RV[Ќ����PdC���;ێnS�6��<v�\-A�yއ�i��'�]ʸ�țd4C@�P#���n��f*w#H����.�v�&��c�s�ɀV��)������Y*�����	����mW��r�c4��H��L�
8-O$�����H^y.^$� Xt����S�`h�q�r�	X�� ]�#��g �험��p�/1,��!z��W������_��K̒�%.���r�_rR�d�w��ɵ3�E�,Q1��.#��N[�$�[�Kܽ�B���&!�B�P���>
��N��@2���C *fO��w�W��h�^����=�S<k�m�ت� YL#C��OU<_�z�横�dѢ���G��N��$}Q1�~W�W� 6�ɳ��hvFn��fg�@���ᥬ$�}�.*V�&����Ç+��A���j�z�IQ��f%�����O���z��`Ͼ%a�d�9�o���BZ]נ��9��х��E�� uah����,E<a���.��M��D$R��ڔ��=�vg��Ϗ���?E_#a�n�O+C�"ܻ��������*y�s� �B��=SV��<�^'S��&�u�P
襌������
��ƌpե��r�$�4� ��9R���|�T�E@��4T� %� �~�S���O/����ؖ<��&� P���m����"j�"m,A!��+W8m����xyy��)� ���_K-X��0h*T`�@ �����Ɗ���th� 9��`IB6p�\����AH;�G|M��A`�@(���/�-�  � 8�+%�Z�>���+w�C�'�(w�=Oi�z���rГ�,�¯b�����H|&�nf&j �M"&�����/��WR�/�6yY)n���m��A�sE������v4�����  C�&@���N���qP3܊��E�)\^KR��ld�����D����ʲ�+��5�$�V�,���I��&��L�����eX������h��N�&QL��l	�@����YF�;tFa�t����6����p@�M�C���ұ²�3�9̎j�|]\�w�,Fr��r������;m��z��W�v�c_��.IH��kha�ў���^_��ո,� �`Ƈ�Gf�pS�n���/2m�qUlxQ��t{�k�d�N�o�S�H�P�7-!�3�!�����BȮZ���C�	�@I�~ʌ���ِ]{!((�E�,�"H�L�&��lY��������'%��-�@�ƕrq��?$�1��7���y��	HI��`\"sU��B�r4��眂B(�[8��h\��K"����J�����]ɈK��276�g%�L��D������ِW�H�@)�Vn���P,V,�����B�3fFs�g �  �%�Z�6��g��To��.@�D 4�0�f��rl
�n�J�:��X";�y����8Qg����W��TSf��4�vI��`$��W�Df��""�����nY��k��)wXFW�{]�ޙ�ʈJ�_�xg�bg����@efQUy����ޝ�!H��S�B�a' �8^M*�&H��!1�#P��w��<>�4�� �H
 A6ԩ�<����,j��8h�\�	��	�%@�̱#*�,/P�)�If,ѯ�?a�K��5k]��SQ�(�:�*�K�%a�f	�l�v�-� :A��k�X���<��S���Rz+����,��,@G���w����i?�6:�;`	x�TS��<�mK��3<���+�������Q�@���wP5K�@�i��|��t*:��i�AuH��ۡ�$�AB���x/��I�/�m�I���%�N%��$���
�#��k��
P�|R�`$�Y����S�S����pZN�ʪ�面�$�M6"芀�G��Χ�,�4	�I/ɪ��.It5"����Դ����C,Z�Nz�%�����g��Q�)�vZ�a9�6�$RuvC0�����)��
"���b�M�V�!�;{��6k̲^]x�id��+�,	$C�g	��t�2*H��7 �0���Qø@��sA�w>�� J�������·��3Yl_�*m��++\��
�$�d3�g�@8��%k�?�'�¥�R��[Ɏ�~�0A�3g���v(��녋��&&v�@Ix#Ȇ ��[<�mg����$Av�$w"-��աHB��~����}���B.��%LPAD�|l��&&Ȩ=T�N�$L�,�!ڱv&<ML@�Tӏ]���^@�N/��)��g�+i��-I�oD�%�0�������t������4������1btoG/��(էG��ZC"'�aų�[?-!X�~14��5PDە񽇧Xb���RC�$���k��"*k��>L��RC'��0E*u�$��$���L%�NO���E�a;OI�׽�d�ԍ��kȔ�xq��?�}!����ҕ7�ZɎO�܋��?��Kh��/�E�-�����@����η�l<��,}$d��p����ja�f�`t�Jª�"Y�x�1�i#�,k�D��=Z��+��ik�fƟI8ǣ�x�v���k�j���k�nǆ���j'j��IT�ɡ֨[�&y��}f��"�)�n�3��+�~p�dxC0��1��^,қ����]��I@� p��7�r�W��,.��V�p�-�	���^��Yv�)��m�#q�P�&!��V=���լ6=N�@� ��]U����� �B'3��t
P$�&�]��V�&Y � P��~�Ӣ`�U��;j����� 2���m�~f���W:U����V�ѥ W�i,a� *4��0���"l�3i�vtT%��=Q�� ,�~n��i�r8�2���/Gy�Y���%��ތEX�od[��kr���A�*�.�W��sÒ�g�",� RY0��Ce3�(5|&L�Xɸ$̷ L蔘JIv�*�_B�a>ã����"yց���Q�� j�8����`$�B�A�����C͠D/�`�¡���U���0A�ۿ��w�Gr?Ǐ���tK)�d8A2���2=��K!���Vv�V���d}����ͧ=�Jr;@F�T����`�LM�3��@&�*�Z�%a �
2�Wñ���ΕR�N�$L�WAD��|����v4�	�)X�v$%O�o/7@����%��B�� � ��r(�]���,zt��l����P�D��(ɳ�h���ZW��!�(�ٌ��pޖ,s�6�"h� %�U�.B��y�[D�vI�v��_7Ry!���AU��=̏�l�	����ƅ��<�^~?���l��R���` f�t=�
r�_A�]f��g %��yh��� ��&7ҩg�d���;kn�T1�M�,�������39�� �@�cyNKB�S;���a����_BD�����'`�`�G��B8���e|��m>� K�\�� j�H����A	v+BPJ�n�lEJ�VA����y��DsG���C��Aj�V��/=������@H�qg���n�YJx�%H�O���px����ރa��$��Z�>�K�s�nj�Z�C{���EM	���@jwr9��(e��ꌵ\�-IJ�K� �����&͝�>����<��%�FR�~�R�0��O��I�GB�$5:��K+��+!QGϷ�l� �v����s˲����"���@Hs����ȩ�ߧ��nم�8 �2�� fK��<�V6A7�{�~A�+c�6�_��\���h��&�v������G�0��&r;�
�� ��"� �˦��
x|��7��GK�ˬ�\n^��v���?(�գ�2�9t����ys��B��	�#ș=�Q�Q�Ǘ��	;��m�Qާ�]6B��d%�����t��f0�%eP8�!z�լ�B�ua�Ro���)�JO�����W���~l�"�Ϳ�N�(k
��B�*�*]��
U��y��V�S2��1:�
��X�g��� n9��{��:�f� �x~Я��f�"�]�:%S#D&��V�����|�\ŮМ���0���ۆ[�	�����R�ρQ�71'O@�,W	��}�]̐���d�,��	��[WJG��_#�aޠ{6B��<~u�Q7�+�qD��x���o�V2�=b�_�z��nD�.���Yu�Yi7���(�*��u:�2���U�bm	L��S�Ԥ�	�:]*C����>v�Y�#�[�Tǈ	�'���u���Q�3�Mr�^ͭ������Fe�=�Wi�����[�eP�up! Z��� H�g��K/<G0N��Aզ����ɍO���k{X�Uyo��0|aPm��l���8x�����J�vo6�?���fI+���A%N�
_�*������'������ƧEl��F�ǯ㓛�*�?*Z������D���_�>N8	2ywu_�*� =���F�!��bƗ��T�9��&莠rBa�ڍ��W��>)a�?��R�=���?��r|��`)� oO0d	>�'���Z��*� 9�&�W��a5����p�#(�C��&Ȟ��+'<5}�缢��Z�>��[�jk� ���Cx�=�9:"7<e��7�lf�_`�M � q[�=����οA焉td�2^��du�'���e�Eo6��xȅ7�}=ɿ�J�3�n|����30�p^�'n�r�c�l�n�tO��nع����>����U�+#�l��	:�Dˋ�7Q�����RV����V@HtBK�8*K/��]a�A���A��\}ތ���C�o!5:Xo+���8;$O����ZwFY���J?���A�n��A�#�<=J�􍃠��wT<���p���N��V�Hs2'�VA���!j�� 'p��r�OA)� H%��s����J����,��	���1������y��|��	Ny�AWw�B������s�����	v�      e   �  x��������k�*�C�(Q:]��i�n�l�&	� ���|��<@v�]���3��W$%�Dє�Ϟ�ˇ/����i΅����6�/.�H_������D��O��?�����jwE������ �x r|6�W�s�z=���H��?������7���S�R�"��q���1:_:�[����i�I�t~����9gi�����hE��8���_?u�?��3������?�	/!�u��C��eN�c����L)�Cq._T~yy�������|����>��/�t	�fG~�P����^0�����>0����A���nT��Lb�~	q��06,�al�Wl��tRG<��3�����ׇˡ��XfGa���\_2�R�K�ܻ�����Kd�P�h��sO3�>����o�ŧ.�C�)����A�v�HP�0��v��ɑN%���(��lwE2�����L�x�1���8�#���d���<�oӠ�;ntT�"Wpxo�4<�:B$�L1:H� ��a4)�x�g�E�&���U#���xVO���0�z���do�br�#�%�H�(��<6=�䄄(�����	"!Gt�m]|_ϯ@3���i���!�{����k��A�B�OC���#=?!cf�{�!��&��<�^ܹG�r�,m�y����q���i��Wp���9�������` m$�h�O�\/��)�%���3�CF]@�.>�pMBktq��[T����1�%n��Hfq����=���)��1�d��S����wCn��L�]���&��%�B��7}�!��)ZH#�������!�W��b�Լ��x})0-w!��9���g��24�@�yt��U;s)�]u�:�Fχ��)�.>���c�8�t/�ja����>n%�cptB��=�+r$���]`ϸ[�����0��S�X�RPA��w�~��6�9�>\u�Ҫ�+Xl(��<�6�wޥ!	ڂ��({D��io��ú���tؽ�2I�LN�s봫��#��)���Iv�)�ϲ*D?��òW�@�xB�`iع��&�O`�sq�ZF�=�tW]D)��kw"�m̺��{���ve�s�w֊���x-���Yga��G�a�vq$���<��ȊK	k&��C�����"H������<螼/����$�5ȍ���W�>c��U��V��۶�����JˌE=�!ҧ(Z^!�A�#]W�
���F�K��Ǉ��uG�(<�ծ�������o]��8k�����ʋK2��Z3ԧ�څڬ��88������v,(�x�������`4�����>g��X��m��C;Xpnd��{��mC�s)����׷{�"�yy��32����R3GO����;��5f��L���NiܻG�l%7	�%;�A�Vm��[��x��\�iw�)��_,xy2�l�Y?�R�t
B.N���1ĺBs
N�e�1z{W���?�Gp D[97.B�^�����R�'Hݩγ�]f�,5;����y����P���XȴE�����u+u��u� �*S{(W��6±Lqω2�lI���m<t��ǿ�s݈"�?�C����"�����LY�>�LO0���K~j�����'��_�Ȟ�=�ċǘ�P��L\\ƍz��Pc*�6;�����v2ݜHv�����a��e��_U[�g>E���C���/��T�AI�;'���L=�� F�2&\�7��y�pEm�J�>���@�J�)�j5�P�b�99.!�j�		�Q�s�M'�1Z�d�����b�}��6S��u/Út�?q�*,�wה��v��e*ߡ�r�%8;H�ʆk�M�j���B=����%�Y�W�faa�N�<O��,��@�j����);+$��b� �re��>
�E�Uɕ7Q�"��,�2�{���xg�N)����`�W�f�����#"iE����3,�R]X��ԇ���R��8p�7����S��6SVӘ� C���,zۅ����4Cݠ��֎���`�Y5=5h��O+�5q�]�Ԗ1��F(]���ԅ��}*;#eG'S[@j��:��L���O��[�8K�Y�"��N�cn�VS���Vb�����-Հ��"�{��[�����i[Fj�eO�%$��>-�B�v4�CG��#т)��v��M}���P99+X�IӚ�68�6��z�p�"�V���z0���L}Z���b�Ѷ���%��r]f��>-Y�3�AF�-#�>���f�1d�#��am눥*6�!]h{S��� ��xo�ն�� �9�e$��Z|\%�Hn�H�9��+{��6S����&H�Hn�H�Q��ޗUto��J=�H�AEr[Er��x�c~6ua�i1��o�xs[D��mP��
��ԇa���`А�֐l"hG�1��i�΅��m���� �h��ԧq]-A�2E)���*�μ[|sݡ:�����,�aĨ�mi@C <�ۍ�t�~�=�#��i��*ǀ7�d�LA�_�,�y�����$���L}�Xi��b��w�dߞ���k3�Xu ��aq���ʢ��Ta:��>�,b,��r�B��-�Kgoo�������6�G1���҄9hí��CY�� ����Oak�2[S̺Z�����մ��,�ͅ,�!�Ѐ�O7��V���*�{S�Q���oT<j�A9��}NiX��~�iȾq��ĭ&����,��0�b��U&=��x�5|�H��"�%嶩��s�IG�OK9�s�~D���z�����CmVKpP�r���	��.�����Ga��]�I�J�hej�VSU%��[�&=;�����!�j5�PɦUuܧ����lSP�+j3�Q�˱oTB�4ܡ��l�_�V�j�l��d3*�I��R�j�N�˻ڛ�(a�z���;�5�=���A��QF~���--���VS%�
KH�L��fX�B��6SE��`
�
񓶵B���H˗	�7�Pu�*Y�$4i[+�=�U[^���~I�m��w����_Ԉ���C��x�'a�m�X:<Vy_�bo�P�DS%��-��ū�|Y�����	k���m���V�ܚ���G�߄[����;�u�U�1~�����O�S�S�LP���ZM=���f2QB"��"Ծ�J#�7SUp����wZ�,�����G�I=�DP��	,� ܡM��VSU��|�����Y{�      U      x�����~;�8^�*�j����@ȡBr&��4�3tC�\$ٖ�d�{�U<��^K�,��Gߞ���z-9����_��/Op!�ݕ���7���'ŷ���������������\��su�������ϸ�'�?�����3ar@��蜯=m��O.\z]KW|�gP�\sLUQ�?�o���Ꮿo���O��d�*%�XRl_��?���{KjW\>��gϿ[.�g��'�?��1�+΄9!a����K�p&fR��g��0�!)%�P����K3��_�O�t��ՖR�)>�����?�g����\������S��<�����;����P ܛ]������k������,��b|S��\f�[*-���9?����O���/��W����SV�6��~��\�_d )�gC:��"�^�8�6;�]�.�T�/"�Wx�{o��+��kZ��l��~�����,r;��`��'���\�W|���w������w��g�ϥ�^!�Fc�ק?��	�_qa��XX���9q`Fq����^�I�Sp����9��R�#����/2q�V���d��0��_d�{!����ET!\���")���a��������+���/��,���0�m�_�EʗE�]:������_d��$�V��Ϭ�I��V-^q�AIo�S��(Se
�=82����wU����p$��r�'
����`�#�B���ޮ�"�e��n'˴����"OT*���E<�#Lꌱ�"�O������.�uչ��*=1�G��#+Hx��v�Y~bT�^6�F�\�W|��'���Á,�f�PW|���վQ���i\4��_��{"�l �v�Ï�����^��_d�r� m#��K�8���"1��;Od1���^T�I�O���!P���P�_d`��!�B�YB�,�r�Y~R+&���4�'G�7xQ�'E5/����b�W|�ܓ���p �pB�7�z�Yx�2"�W�������6%�_d��u�7�N�;�u���_d��l|�~�YB+ �֠��⋬>����Ǡ�R,�@��"�O��3An�FF��땭l�IVܓ�\����A`����_d��Y�S�s�^�����v�[xrYS�.���pk�A���E�\�&��ld�7��_�,=�	�O�W�nZ���3�/6�uw�Zv9�j��>�+���S���}�N��Ulu����S�~��'6�v"^���_l�)A�\?�E�����b�O���j���M1����V�SX��:���;���/6��,�s�.�U��b�O�;O�U��'C��_�|��g^����e#Kh�}Z.P;���3���162P�jm�[|�����3�~"�k!�C�⋬��٬��l���öO�j�+�^T�w����OaʯSF��'��б>S���«��^L�a�D���N���
�u�Tč&�����Oc��Wr\y��bx1��zq��$��%_d��r�8-b�}>���3����.:��p5_r�DFu#8^�E���y	܁�
��6���/��{j�kuI.v$�C.5._�E�Z����V<�@c��W|����-8Wk�A�(�n�_d�i�q��@�BJo�7xQՇ���է{�Q&�/���$��|��<Y�ť+���=-ˎ�ہ-x\4�g6���W�~�)�8i�g��4}2�[�הP�
�l�i"�(i�ݸ��vř-=�/%H��[F�T���3[~��Fܵ�������<]6���M��՞��Kg����[ns��6���F�C���������KH�M�ȇ+�lv5q!��K;:�||[���k�����A'�l�ڒ	���$�[���l�����?>8ӡ�;��獞����$�/d�]eq�+�W��~�V������L׀��Y��F�qA�b��L��f]���l�}ѷ��z����=ދv՞7�DOw�௸<�<&�jM#����m-]qy6>eje{
ӹ�w�~��i�A���%{o	�%��v�c�����=)�]R
�"��c5�t���ZU�ڛr��5>/�I�g>�\u~��M��	Z��L�7��ƓA8ҍcϵ+��2J^�ϼ��a�=)m�c���֡7={����s�����s2w������1�t�� �׭�g���Ye���׆��6�u]�q��}{	W��`��r�^�i��`eOp惍 deQ�~�L�P�g:Pؗ�ꆈ����:���~�3!sP�r���:^��"t�D38?R��D��T{�^$��d��8�� fJ7�]ĳ~�f��.�8Ӂ�D6����I�W��j��3�
����|��Fn�q��6�48����9W�ɯ�|�G�7��@T��?J�o�h��xo��L�hT��do��xq�3�]dg(l-VNFt@����#��� �hT>�p�]�wǐ6>ƙv��$v��rG� �A�zg:P����8=���olV�g>{as �D�@{�ddq��H���|��XqC��+8Ӂf$��6k_�8�E�g�vř#�	��顇$��nWp��HEΌm���LGaDs=_q��HJ5�au#E�����x�,�P��*��&�x����"6u�zw�l��'\q�Hs�Ҽ+G�{?HE��L�!WjC�7 
Mɕ����hp��S�R�Z�[�)ps�*��������1��K��`3i�58Ӂ��� �qz�|iQ���O����֘J3�!����g>ؕ�{v>zi*����;��.�_����'�'8��u>qzv�'�8�B��΄��]�VsǸ�����g>��"��=�FR� �֭�	�| E_#?`&��>t��0�R뇵��|c�pw���3�z�»F����(��&�8� ��:�4���uxS�W|O��W	��-����o6�q��j>�v�6=�������8��'��+�tb��T�C�,�l ��66�����6���3�JUϑ���5|�ǐ�~��$���b��cX��p���g>��*~�j-�1��{������|�X8�2����	�|���.|��ʁ;z���3�|ͩs�>7���FV4�t�Mb䒍H3� ��Q�g:Ћ�b�lM�����[�+�t��6y�/��Ku��pjW��@3Z��6�c܍\�W��0z���-ۛ�V�ڬ�ƙT��M��k�:F&_�8Ӂf�*�b�W
]>%!�$�/� ���x����h��7h'���4������-�N���Wz�3hFW{|:�l��ߪ���|��OY�VZh`�S^?)�	�����2�(x�(���ѕE��(�88���g>Ѝ.O����2eJ���1�t�]<�N�+��M���|�[ ���ƙ�ax޼>lt�3�F�ˀ�� �$h:���s���:{�k/q�_$;n��\q�������Ƹ4��|řu��B�ƸL��8������>��8��'(i.�������j0�l�k߭���a��Ϲap�ý[[@�_�Ӆ���	�|�!&�Y��r8-�̅ǔ�9-�!��k�J���/�'8e ���r2��\��HB����&�mJ!8�a��So_�e��Ol`��_Np�!��E���cY��K�����k�紬�Q��X��V�K�u��4
��9kWUp����)m6�a��ږ6:ƙt���w��O� �G����d�+��>��E�!���O��B�]%{i[W���ثD��ɘ�Dpp���3�H;���a�Rv�f2L�R"l��ƨ�����`&��봱���(2��>�+�t�'#ql�(�\�9��QP7:ƙ~�����w$A8��j�?��L"�U$�]�f�Z�T�8ӁID��#P$G����@�C�d�vc�r&b�e��0X���u ���aW��p�T�*i_td����g::y�)��&�e)��Z>��֊Ǚm�F���ps�5^q�I�ʑ�뗙H�[[���b�3�)^fp �}��3�]S�o��2_�1��h��_ѓ�ǈ�ɉ����08��'D�Ĳ�    �����kHW��@@���p�읆�Up��g�ƙd *{���������|�Q,�p�&7zK�_W���f��s�ފ�oh����^ C=
t�D�7�X��?qR��m?4(|.�����8���1)��S�2����n0��v��ǰE!������i|�5Ў��9���P��������#9Ӭ�m�Yf�>�3(G�� 6�|�u>l���@5RSkq�]����	�3��I������u����~�����Q
Qp�*�3f�{��".��P��z��k����Ҋ�[���.us��8�����B��� �'�X۟Op&���I�*G5�d��`%O�����!�3�)>^q�q��:��)����v� 3�d���L�=��0<[ML������|�h��cg>�I��t��(xS�k�8����"�����!����WR��<Ax�����(�����K-�T��E��>-���@=��h܍���U�FřD��;%��(�o���	E���m7�a����������M�����Z�ό�\�,-�ϕ	�7q��wtcU6Yv��Ey}���v¨uz�!^q��(���������_�?c����!��<�����ޓys�q!�xv�7�6B��f�����gB=u���71�RQTI㬝²>�v,��Ϗ%P:��6ǈ��7��MgB��j�
�+�X��~��{��B�	k�����y
G�0b�86����{����/ڌ�V#�1(Ƒ錧zv���UC9.e�q�ą���^T+���㎲8b|b&�w�)Q<|u!-sop��#�H�t��B�H<uÛ���	 �)c�֕����83⫸+*��럱����`�F>Ov\��]QZ�sB��!�T*G�83�k��R{.~�"k$V+�/&��pa�9V9��'?j�\֦
s�8���]�e�#&�'|:,W\�S���̗�z��B��BîFό��54r�zŅ�����9��2*�80��gF:��$��t���R�u�Z��*(oǭg��Q���tŅ��+��H�FF�zP�?;Ό���J�weg�T�	.�l��0&L����S0�0a<U���]N
q6�6y����Z��B��N'8�Ci���.�+΄�Mbb��{8,t����o��ŧ�(Xҿ��FŖ0���+.|i�͍�kg�{�S�Jb��	Vz���_:��Jk>x�k)�O�MrB�svl�3!V�x@T<�1?������?��Zi.��W\.{XkDFP�§2��:�%�t��:�����ͅ�y|i1]q��q��*���%�c�pŅ� Y
9���6��g�~��>�R�����`p�8�@��wب��s9X�5����aY��w�ԙ������R��˳�2�� ����q�UI"6��g��0}��bp�o��l�iX���o��.�1
bZn���T=ܣ�rO���퉔*�5"U+Pբ-.���Y�
1�����
HU�u;.�'�T����j�(�P���F�!��Ҍ�t��#�&'k*
.�h?�\7��g���B�"���'BzI�Zǂ�u��R�(��ʓ�=�[z���\e[Ē�{�r)���,���8Ŧ��ԝ0�L0h7�+.��-R|k�)��yG���^�-��b(���(M�4�T9�+.��/]���d�'�ˌ��J�(�b��њM���UH�b�4�T~�;ڞ����ޯ�0fdT6|>�<P5$3qǅ����Ov��Z�犸Q�+.���Q��~[���/b��s�oZ��p���0<u]��G���'�z���d�W�~���\D�k��p�'^�c�b� ݟ�`��TM�00��'J���-�2FQXk���g���.�?[�|+hu�Z|�E�D^	�h�Ln%\����8�M�U�o����1]P��Z�*"���3�A��v����r�÷��m�(�q�K�We#���1.`M��gř/��>ʵoK�0�߈B��LW�إ._��@�a��W��ꓜ�g�ng��?Rj��3]{�S=&�e�s
����`�����>_�4IU��;�&fr�k)&�I(��W��Z��r���7�Qݯ;[�W���I����m ���V���L��4�$�������F�8������	�\�2��{1���3ʊ�o���m���/9_q��n�f\���>,�,��9�x�K�Yμ����*'��q/�X��3���-�ؼ���g>����aW�T�}��g>=](��
*Zv��`&��EM�%w������g>����G�}�N1��s%�8Ӂ {Տ��{
���d?Vp�A��@���NQ�ME������5��躛=����؊�Np��@��-z�t�a��Ø�8ӁV��l��"e��+�t��j���MR�Mk��֎3�EP�����P#}�~,�L��Uу};Ƙ1�=�B��LW&݊�ڷ���@+�J	��V��L'�TX�q���-6���҄����g:�
r)���1{��kS l���/z1Ԭ�B�Vv~��[����ř�O��3|7�e��~"͈n9mR'B�I��sdq&��p�KpƵ�3��K� Ghi���u��kp&̓p���=�~��r�b���Q�vkW����]�@#�O��	��x����6ʳ�-��+�t}����j`O����:a�`x�����2r��g:?�
\H�P�6>�gB���$�^Kӌ���?�|�3_�|���.��%P�����f�vL��3_�|����	�D�Xe���iZ�`TԶ�1�|}�����]�"�l+��i�t�^q����sR��q�1%���i~(��l?Wp���~?_=F����!��Jwq_`�8�%�+�|y��{�'��Ǘ��T�R;�����rŅ0>��'�z $�o�6�Rpy�ŗ3'ym{�#���u�_qypŗ�"D�]_V>�����v|2f����W�HňS�*�6�]��� �`�-���R��E/�6C㰦WɁ;΄aήZ�����$����]����m�q�K��=6��gB�:8G�.{#�H0�vI��ʤ�M?Ė�e=�:!�#I�KvW�q�G%�5Y>���M>�3ކO��Α�Ov{��39��iG���w�'�?��O��"�+��2ۧ�1����ygǙU�[����&2T^4ջpř.N:<5k�����:!��;[�d���x�V�g�<�J��%����L:BL۴�� 9}C78��bP����[s	W�Y@([���Pck�3�@����%"�l�j~ �/���L�]�'�1�������(���@ڃrpgĐ��L)��A��Ԛ���Y�c�V��̏�Dds?��Tb��$��EX;��{�fW��K	���ٞ�m��/oRֲŅ�9f~�}_��z��KRz�J���4�H�J��+.aHXE�t���i�/Q?��l��,4�$*.%�'m��I�Y��E������9��t֠��+�|pLɞG/������^���������ɟ�2U1�+�tpD���v5^��'��4�tp@�Z��t�w���g:8 ��r;��_�%^q��㡈s��}s��!���;�tpN�7���cS�U���ծ���'F��Z��?]߳. ��LZ!����i�+���+.JKy0�ޕ}n�1��"�m���ש?�
2������!H�GkMW\���2�N�Y0;�mfgѸ0�欪 oޛ12S�P�6�Fp��� ����\�1�m����A��:㋬n����M�֟b��LR]�T�"�nר�M��̆2��K�f�J����9]q��n�|�[�O|��[%�,T���on%��~�em�I�J cU�Sg���-�Ppf��NwM����D���1�+�_~����M�>͓����a�jU�D�!d.��{������ߜ�f�k�y��>����ZS�l����(v
�ߒ�n�	)��Is���A��0���,��{Q������>,P���#�.�/�<u��=�Ja�ɛ�����H��.�K�{�dQ�    �-��q!�=��G�KO!���z��f_	Δt骕�߳��,oI銯U�骤��ê��ʕ��n�3��t��=c �^IrK؟��o���������#��������V(ك��8O4���o�T�V߼�0��X�$.����G#����+�tp�T�0�t�:J4���>�6	?��	zt�c�w�1��_1����8�)�_�8{s���83�b�勆���L�K��R�g:�t����2��i#d�	�G"�3���a�gA�W���Y��]�;ХD�RmW���L��Eƴ���_t��$-3�q?�ѫF�3��g"��ሣ��>}R�,�t |�����������+�tp��PՖ���g0��q�A^)�p�v[2������	�|�ɪ�o6����]��_Op�Ov�Ug�w�F��r��g��d����`�q(-_q��n��[\�o|��#����ȧ�etg~�7�tqҭ�ٷ�_�ғ�����4��^�\��
�tyҭ���¯|({�4�>������+�t(z�x�A�:m�-\q�k�n~m<h�O|({*}�z�ʪߏ���k_t`�e�B�������?��>��Q��2g=ܨ�g�0�֯g5�W>Tu�2ɪ�����������Ҥ[��]�_�@5�2p�s�������48ӕI�~=�i��j�*�%��(��m��L�&�<4���_�@5(�{T��}3�*�F����^�E���e�o����ʡ�ӆ�K���
��dp��n���>�+(�W��X�>{B��z�8�ɷ�E�����C�*�@G�,_���L��!�|��^�	�`�'}28��I�t�Ɠ�ʇ�!w7Y��$���Op��nM�>1��Q5�q�ٛT8>�� �3��t+0�z�~�C�Ps��Z�~������D.�'VU���O0R�}�W\�U��)N�����c��BX&!��������[��ն��k��!��p�����;�-��֕�kntf6�]�� ��"����/����l�<iX���V�g:�gy�ɦb���%U`jǙ�Y�	�^��tc	��8����O�;s��hL���L�r�;�^ð��[r��̇r�J»������-��L���^m��7�i���8�GI�čz�^���+�t �Q����V��B��_tpu̪���Ac\
����g>��Z�K��j�5�3HrT���pEt�b�N�48��U5^���AGh���������0�6��u�\q���#����\,�+�t�Q,:-�S�`�f2Ќ(A8��[(&���,�+�t�ɩ���<ݷc�W��@1F`�����\��4X@_���+��x{��lc�WI;�Lz!��[��jE�ÇWc_(��@+��5�A�c6ExK�W��@)�*^�O?]��Y�$J�3�DRO�i_�B����G�L*�$@�G���R�����8�N���[
9|Sx}��g>P�$�����yzn��_q���Nl�⶟otJ���ڎ3腪���<�mmg�3�/>8sV��~��H΀o0��^�fwf+o���g>�U�=���a�c*4^�g>PU�/���^��î^q���*z+I��#���ƪ�8�r��Ѻ��,?U�,�t�Y�q�/����ko3(F�*e1�憵	�ے�T�����߆�a[��9�+��`G�\i#d+��"���cq��+:_y��1W��1���|p��+�+��m#�*\��+�| y�����1�*|�х+�t xE�+��79mt�3^����>��0�z�O�řDO�8��?����Np��-���W��zr�bAug�'8�(Wu���}�ڡ��^�E�aK����YiX���-�+�t �B0"�}��a�>ʷ+�tqҭcߒ�A&�Ō�,�+	�5�>�N�8Ӂ W	v����뵾��`&+�lv#�[.�ot �Rw�u��@�<�W�����@��*`���a��"�zř��u�Ott�}v�O��P��Ξ>vd��p��v��*����N���T��d��KFH'!�����fp�n"���g�x�����8Ӂ�5���Fd:�ࣾw��tX�ME��/�w�k�soW��3�ISRgj܎aX�ͽME�Z|��dS�(��>�a�:oq�Ai���?�Qo���
�t�w6��M.6��l�W��@��f�^��,�t w8v�����T ����Np�˓n��2�&D+�)��Up\�;v��3�=(�@޾�R?��	l�8ӁbH@R�y_���u�J
X��@1T_q\��!�ۂ�=v���r��-�_���d�]5�M�S]KSA��LJAu�fJ�aCw/���rř�BE��z�����b�g:T
>*(��@G���X��.?ũڔu��FՓ��׻�LW��Tuʃ��?�T���_q��O9[#t��+�(Բ�.�+�t�)N%�]#��o��L�'�*tv���\�=ŉM�����QnQ�<-�t�)*b��ӏ1;���.��L�"!>p�;-i���d��3]|������Ƶ?��̗��ڜ�v�K�m=����P!T���w�N�p�'������?������e#��l�g:��r>�����T��g:�/1��8�Q"ʵvř�«#ǵ]�g������'V��:S��n��A��i�5���U�pٌ���,Vc�}p���RW��w�0�~!]q��P��K���y�.ok��3h�n��7Q�T5;���]qY��D]W���I����c��b45�MV�(C�;r�8ӡb�R)n;fG�-t�yK'8ӁbQ�6�����8Ӂb�֮ۮ��8�r\��/Ñ����1���x��3(�*_�]�|��s��
�|�AB����W6%Vz�~?��T�C�o�击$����3��z�'g�a=���W��3�A����c��T�Ь�ƙ�#�O��/S�V|�W��@;FE�w�R�Se�q��'8�3hGT�=����n)��3hGTUz®��H��R��/:���Ѱ���PGÛ�][��t#*�1gG�c]����L���Q�iv�ƪ�W��e�}�Uno��!�q#�TOp�	�nD��j�~Fb�}�18�a>���}���hqfňrF�uh�=?��3�0�j�l�jK�.l�ڲ8ӡ^��Ot���{�X��P/ؑO͜,]�2_�*@�⋮�^$��5�;��Y5��1]q��H�e��/��+D���g:Ћ$Zk�0�0�s���g:81��	���~�4Ɔ�aapֳ�Y��`ɦ%�(�)��|ř�:����eb<�P�N;60/(F�Kd��4?;$���g��@1�\"�y��0��}�c��@1���a��c=~R-�t�I�}m]�9�v�0�"k�*�mj��(]��+�t����\ cU�ӵ�-�t�Y�e���硞(���ř.N�Y�"ZC�W>8,T�F�t8Γ����U��|y�������"��8�g�a���`�B�LW'�,e�Y�+��ē��h�1W߬�|g>Ћ,���
���6O�5�⋮�f�p����#�ä/�g>PNҲu��q�E�;�8�n�7��1,P�Ī�F�3�?���S�k�I��[��Ҥ����O��WBԍ�ϵa+v8Fz"�X�g�2	We6����Qds����Tt�Q������@=����d�e���#��lp��(*�u��R�%�}���|�&��BV3���V脈�3��*d��;�y���*�eq��n�F<}�|�%�����'����jp��~����V�}D7f��	
΄y��ž����QTV�m?��en��_q�C��i@G�v�n�Op�C����=.�p�wo�Op����!x��p�90�b[^t`2�5={�����i�~���q���@;�t��ނF�5�K��Qdp���n}�Q�~���Q���{ƼC��L��+��,rg��v)�de���尰?��VT�M$���?n���3h���Y��!��q,����3*�.mt8�"����;=�_@�hj=�q�K
�b1^q�C�Pa��MgRo��3�ESg�I�)	Si�    �^���Iԅ/���3$�7i���0M¥i��+�F��ڰ= �v�e�9�5�|�Mr��I����.�[R7��ƙԣ�ꖦ~��3����z
f2��'d����ԛ����j|�����n"W��=���'�O�L�3�rS�3��3�Q�e���3��<	���s�;}��F5�t ɝ5#����ǖ7��q�AV�<m���034�rř�K��b��hX�����7��@�F��p΋Q(�5�g:ؓ��c;��R�$�3ȱ��l���q	�i|��'��K ǽʞr�hP'�Tސ�Z�| Ƚ)>{q�V}ԣ�-!^q�I�R���'F��0�tř.>�9�G,�B�	K��̗�������t��BV���5΄���n�z�w"6��d�[�	�SuCʼm��"O�o��3]}�.id߿�양�hp�Lמ�6{��@EX��W����[վ�?��=�R�\^gK����|��A�gB?	�z���o|ᩪjP�w�����=�3��6Ѭ�&j�����tX����Cy��ٙi���!�����,O�Y��V����B��mc�(�Y%+��@-TpR�j�f�x�i�vn�3��j\J�-��@^V.W����[��4��L�m�U�oC�hX�� >[:���«#�d��a����MZ��@'���X�v����Qe(X��@)TAo�lưDE u�ř.M����>P/A�ŝt�
��mp�C�h�e}{&I3眢�g>�ɺ��Ɨ�nwE�G�8�j�i��4GQfo���3���Oj6�x����o���/�
�T���.Em��}����1
��0�-/Uu�	g>���#�w�Y0��u��5_q��Z��K%C3�tN�3(GP1���a�o�7R�3�FP�m��1������3(�*aR�g���Ϭ)]q���j]<�u���7:ƙTCU0I6����H�/(S�I5�n�����%�T��O\��58��I��σ���"���؋'|��t r�Ժ)I:�E����g:���2��N����z���M��Q8�k��L�򦪽�W�Uv4�O�w�3�\ݷ��1/���D�/��&ݒ�ͧ�+!��Q�*����=)�Pn8ӅI�l<k���z�T
�ͥ�*գ��g�4��]����e_l�	�P,ݮ8ӕI�V����j$�@��p�0�DQ�3Y�d�T�N���@/�X��Aa<�K�|�']��)���x��Z�7�^Aǰ���ɇ+�t�)�M�|m�f��Nf��3]�tk)���+�E16�������tyҭ8k�ʇj!����a�3�ۯ��P+T+`k-6�Y�J^V��,�t���1=:�*@���5fp��n]�����Q��4u�氂N]���L�'ݚ���~��b���F��z[�{Tg�g:Ќ,e ��H=�TP�����"G�f����ǧ*����bDs�BW���^E'�|�y��N��#OǏ�Q��R	�t[�(wO2~�_�a�j��;���������h�Q1
��J(��@+�z�25 Ǩ�GRR��.�R4E�Otx⿮�+�t~ҭ�� '?�Rt5�}K�G�T��g:P
�@˴��}�!Ho��3h��B���@�� ������[?�Ae��bt7�jv�Z��Ŕ��du���v���1�tL5ԫ[��3��[�����@-��Rv9�(���f3�����q-*Uĺ@��n0}(_q��� .�m[G��@-,��8�Z�	�����n�0D�3*���m<
m��5�t�3]�t�)s���P+�`�^�L�p���/�de��{��c���Nf���Q���r��L�&�����W>Љѧh<�_.T�V�_t�[���co��RT�=Yc�����)�hq��P�e[�1�Lj��'8�P;���cK�x�f�8�8�쪦�w��ɹ`tjU!*�����T9�mu9'$�v�e~��N�����FC�H=uf��y~��P�Z=��ll����,�t���9э�@�����~��*ɥ���T�G�$[��@���b�&"g���`�K'8Ӂ,K(X,[��*�信�g�8��C7������G�<�|��$*�QX Q��Z�3�Ϋ|g^Xg�j���T�����a�oA-o8�G�$����
�tu�-7C>��| �M�U�\p��9\t|�W��`�o��$�1�>��Ի��> 7IJ����:�K�W\V�>MݧL�m\�"UmW���ڡZ���u���t	�ř��
���pׄ�_���8���k.G�������3�����8�/�M���l�]%˚FYcTt�Vf��LW'ݚ�m��+�FW������}��bX����[kO���|���Uw�1�%�\�b�| �]֯GYk�FT;?��d�+�-եw|�4�V7g>���[Ӿ�%��5�+�t �]��8�|���>5-�|(�M�,����-�@E���3J��:a�/q\�*��\mq�kOsJ;�y����s�ⲓ�z����~�RK_ܑ����kzpj7���6���h���g>�4'�Vm�eX%��m��+�|�iR�,t�5���_z������;hEH�&�h���Ӝ�6�g8ƭZa7����t�A�e8��4B��'8�Q����D�ح>�B�v��Op&�c\�s��`�D�9����Cu�p�Q�eL���.�aq��O����H.���Q?���+��\k���B}y�TB�5\q&�P��)1�����d��7�ڲM3�B���`g'8�vxUi!�Fs�%x�����L��傺�'G���C6ٯ��@;��?e���F���l?Vp�堸�2r
��:8f:"���4΄h��j&�+����	l�^q�� �����уm��gBЎ���e_]r]F��r��9�@U[P��Lɕ0�y�̫��>Ќ���X�ϓW �rW�(�j���5�+.|��3X5e��F9X�]mp��ȺUx�_ �	���gq��EV��A���KX\�@=T��fj��q����6Ѝ���lT>+��,>P��;��_���1�+.|�Q�D�_/��X`�g>��ZTo�&�ǍF��S.���ځI_��C=J����O�o���5��!�ŅTS�i�G�)V�E;�]q!=���I�L ��{A��L7��	V.]|p�:N�b#Ft�+.��,�U6H+n>�@-%u �Ņ4�˘��F϶�%�n�P��Ħ(ӕ��qdTQ�B
��if�4wS�s�Ëez��s\�@w0͌e��'Y�b����3)l��k6H>��H3�P���������sVT�ԿV����()-�m�B�.��L%�Pb� t��n�:|��B
���"�7�Dv������"��H��(�ٽ�ڵ\HA�R���|�s4F������*%V��ȕ�#I�봶���*��H/RJ%��C�-��B
����M�4�籺tř7L}`�|�i�T�3\HA�rP��i��&ݸ��B
��Y�2�ᾐb���iakq!��I��p�Fϔ��X����Fe9��{БC��hf�Ӹ��F�����w2;�[��j\HA�2kT� �i�t^;S��4*7Ez���)��&��+|$uR;�j(#h+�HʵP�"�Rqʿ��aT�6�������Cf�D�)�	C�U6��y�pĵ�*M�+������>P��j���.�q����X\�@o�j�7�3����fq��Y���K��Gy���+.|�-%�[����rY߷�
�������Aa�������-��HQm�+�E�ft�]�8EW�<�>G��0��HV���q6����48���T@L3QXs\���>�g騖s�׃�)��D��.| ϟ�e'>,���`�q�y���r��8�}{2���<S�աş�2�5�0���<W]����rFa��ȳ�\�M��9�������\��w�P��6>ƅ�J�����a�9

��3mF����}~dnQK�vŅ�����e׏FZ�w�Ņ���^�&�3����=�+.|�Mr�r��ӎ��ǈ�rŅ���4��:Ua�s�[>�����(O{�ҸD    �)]q��h:�s��N�z��!^q��h*��zE�8j��	j5���~�2Dq�����\^�o���~49?l#�gt�#�vř��F�	�E����N��x��Op����	��bc���n�_W\�@?�>?��;��Ol��GW�M����ԕ�R\�@?ti#�h0�Q+�OX����cV7�K'�N\���������h�~�q��ߢ���G/5�o�GvO��Ņ���v��� ���E��X�@;��P�/$iZ)��K�̇��]��Ɇ��Y������
.|�骥�7��"�b�ָŅ/<ݩ�^g_�Ӭk��'(��B���^v��h����q�KOwRM��/R�G��d�_~��\Fo���B�Cs���W��z��@>uE���V�������K�
uX3�]{����,5}"��{����?�IT���c f�cV`��L}(�a�U�JC�v��!�GW���[Z�b�����%`�Xk��f*E���4.| .~8�B�.��K��ի�+���Z�\υ5У�N4������Ȭ�]�4:6
B+��+Ȑ~�CO�xaM�K�r.t1z�1w�Ӆvr���F̻���
���Re�+���lS���[_�7ŒPG�J/��F�5.����ƿi�K���`ň��V�z}gV�	��Q$�j�ƅ4*8�@n/�_1� ae���
zD�v������ddU��
z�=�7V*��q�\X�Wj��hK�P!���}m�.�����K�>��N�l��L�]J��LpOy�o/7X����X�o'�'�T�������
�c��=L�3�?�,.��:�m���.Џ����/=Q���!y�`ë��7X����]À�ݨ0���\���yH�H���q!��KjE���I�_q!�n������uK�K"�b\�0�n�<��k���
!�̇)ӪJx�u���W4�߸�H��08��w�.|��\���j�q���'����*W�����{ �t�+.|��Y�`�����K���!�R�$c/�!Ŝ��8F�ĬO\�[w}��@�!|�ʜ�O�����DI���+.���)9�"������6�q!�mK��3�W�f�������:ض�jo[l�0�˔���Ö��_�嶺����>��-.���E5̵��1.���):><ו���ټ^���}���?JW"c��y�!�f���3_�sݩ.����������B�9Nh'�2y�����kֵcc��t�`��l?Xp!���G��o�~��QB�z#.���[���͂N�bg(�����}D���k��bS���J�MoG��m�o��P�}W`_�'�N��v~�x�.�Ԉ��K'���-0H�^��i >����g������ ��!X��`���_�ݵmy��UT���xŅ.~A��-il��!�+.�p�*�h�����*��+.�p݋҄&l�;4p�:~��.�pӋܑ��-U$��Yt��|Ņ;J�rZ�H)?��@��B�����lO�����7�rŅ�$J/ :C1Iu6�tŅ�$JS���c f9gEp&��a����e�X��y�!�B��m��yyN����4%v�ZÆ&�o.\q!MI�e��́��i��B�������;��BД�'W9S�䬦.� ���jB
O��]��Br(E�b�<�y6����]q&��sY�F��'B,��z�j\A�V��8bZ�����Br�ļ���̤���J! ��VP8����Q���J�9�RX�{��vŅ�0�Xo,��<���Bدs=�����F����,��X����v�S����DѸ�~�EO��NA�w<��f7Ըb"�۳��@��N�~ř���\�)�8�|ff3Ը��'�.�݆�Ѹȩ��>�B)�J9�Q!F]��B(%c��E�ݡ�v�+.|�7�7��ZL1ؘ��B��j ���o#X���+.����*3���h ��{�_q&�G�*���ըО{�W\A�#Q�g��[R��B����m)�10����m�E��֣$u�����1`l�p�e��y4�ElvM�G�ўŅ��Wӟ�-=�=Dβ��dU)+l��9�S�Vc�h\q+����f��r�)��{�}p�C��O���Á�^����q^c瞨j��r$D�2H��W\Q���}k����[�Ѹ�'����p�1�xj�zŅꓷ�/4p��%]q!=��R�[)�<��������!z��o\8)�m{��jWYp!E	ʶ���@��~���$Ѿ�M��Mȥ|Ņ=�Q�l��9���!��]mև�%o��&�e+�O��t����u� 0�!Hu��𸷒u�n�V��0>���}/D�
ԑ:�
.� ��CLsΛ��S���@?����Z$裚B���Ǜ�ɬA���E�0�3��Iؠ�����[uQ��͵N5���L\A��ѵ1�4���m��3Y��_�m��H!'Y߸.�p�+beb��}���H9Z>���v����*	��i�F�\�v'Yy3�9�
>�����Y��i��I������T����)6�Fa&V�HW\�@?$�#纋�9�J�<�\�@?TUѶ�c`�BP�*1��_`'H����{����QUC��8�N._q&�I�I�0�0�a���Op����wܯ�e�t��������ʝ�t��¨��t�/>4:�@����5��~.��	y{5��8	h���+.��$�����k6}=�B�ա�T���= j���ZҜ�۵��!w�s���J�
���.3�+c��x�e��z��P�j?T������g�eo��;��4���zŅ�D�КF&c\r��<�\��������#�pP����x���Q������Ԥ��I�M��{��*\�!M����V�K'���|Ņ�e�g&U����hp�C�fU���G7�jv�*����n#`z{��\��Q-�m��9��<����̇O�]Ç�h�,I������ڡ�0�rS7J���|�5.��]9�l��9�\b1�+.�`euu�V�T^g�,�!�GW����i�N7o�v��!�j�j������m��!(I��gX��.r��`g�@�(IWǜ;s����akp!-�� �^��,s��f:*���h����!S%�f'(�0�顪��N��M��Pp!����$�!��dŅ0>T]L��!����K\����?ث�y�:�z����v���s�,~O��`��Z���'JQ��m��ר(u�W\��Gi�k��1���;,�a{��n�]
=��3�wŅ�?1�C��4�1��]�W��*s� �}��d�;8ÿ�B�D/yض/�G1��\����	���e5(��Fe�_��'��}D�{�V�0����/��-�t�Lou!�B�Z�]o�5)T�v����b��Z���xUg�%��Y�a}���kM=ղY螶<��icq�A��@ުΏ���� �!��S1�[\���}���gB|?m����c ��8���!艓v�[>��qun�bƅ�U���N=�uU�/B|4����8Q����.|����-b�l��	2.��Р��%�0��i��B���řn��.����2��n�V��bp!��D�g�j2�$æw�!�IVy���E3�kYWE18�="f��q\�L3)e#d\1��
1����U&���!`o0��qa�EuZ�6\{�Ö�o(���'I���w�Y1'�ѻ2.��|*S���,�[�����j�j��u�yc6d�W\��Z	M;�q�����ծ����؏ls�i={}kr\�0���9�ݨ�6BƅߠU��Qd�-����3�]U[�7c�ò4��P>���RckҌ�t���.��#^�klouu� ή�+.��$M��Zqu��1��.��e��]�(�:���_����Tu_���U���vQBP�   &����G�KR�?���Z�#5�_1����~��BjRT8��D>b-�7m?��B�IѡG��m�v�gB� ��Xw�;�8�4;A��Ԥ�t��i��3^n�Ё�������%a.��$U)I;��q��Np!%���f��2�n�Ё�)�Sl�7��#ܛ��\�@C����S����Fȸb&�������m_e��*��Se%�]�6����t�#iHjOػWQ O��[g��.$qUS�n�4�`��Lj�_TM����i��>��B�g:n*�(?�Y�12Ӊնoqaķ���M�����n_�ج�j��s��S,Q�ު<�F��b{l��1���vř��"�~_s�ߝ_��pH�ɺ��CE.����>��AX��_q&��jY>��k ��F��W\��o����)?���� �YB���,�y|~3`��T_VU�&�c`�d��vׯ��7����Z#u?��gƄST���<F��|��`�CeQ/1X�^����@�<����|�����Y�      M     x���M��0�����=`��8�!��Ui�S/i��GI���ĮZ>T)�/�;~_όg�ٸ,��R{`����e��Q��3�S|��k����W�|TAZox`K�5����[+DP�8��9�cU���k�����t!p�N8�[��&��H9ך�����m��!F������*��Fk��\�/S�v���t����aw)���c�,�̑��M�=^��F�kS�L��L`�Ͷaϸٖ~p��ʢˢ62���}K]S��]S���=֫�.�X��\tJ��p�W}�z'�X��,�;��^*8���/���.�@o`d�$`��]'�l��kR۟�#�i,y�sj3�]����_g��6�ȼa�M�������;�=}B٨�����9X�x���f[����B1Ko$^웦:�O4�?_���dT��8��0.R���E�I��rí��B�ŢOm�F�,�����a����	��a���k������
=�����������	tl�Wg�=���̀����?�b�      C   )  x���M��0��ί��3����i����e+�T��j)D���h������l%'�w2ϼ�g�=�Վ>���½�Zs aȩ��H��o ��Dp�'\M@Q�CY��o�4y�5��MCgm|'���s$�\�P��g����:��:�^�e�$9�P�����z�~�w�q9
>�e���!K�ʓ�z鏡m�	�lWsLg^�Q�l8����cJ��ܬ��(7A� ܏��,"�.ژ��Iǌ�zG��3�F���=γ�z�4�zǓd��u�/a����;�"�m�-�=]����⏇w�Q�e[S|��SX
.�� �ܭ�66��3�lGR�c�ET���ܗ��VL��>5��Ӧ��$�Y�� xК�G��r�S��iZ���X��������CO�*����TF�C�n�@RAAiAi/��pAqR��}���
�e����U�i�V���坅^�T��4ZЌ;9��+���c>��v#�90�8��2����)zpq;)�u���n S
����_/�|����;u�����p�S�_������k�      K      x���k�7�%���_��5@����e�z�,i�g4<3FU�V�s��0������L2�3RdCXG\�L2�`0�)=��dmyrO1<���5�?oF����������[�1��)?��7g�U��#���h��W�|�2?���k}�O`a|a�K^�p���xl�NeĶ�xE��K��?��N0��7[��C��K�_:w�q\��߰~�������҇���CY	'��P����[t�-O)=��Fcl�}}�Ҧ�we�e�V�(�.��,K��%K>��<G�v.�'�8�Ň�,kD��[��̄fmX^�)�x�ɹ���Sz��է�0�l͜}a��X^:w5���~x�I�»[�&�\��1���.H��G�[4��,sk����z�.��1��)�)ub4k˘d����V���9R~��6���ɠ����l�Ќu*^kʩ<;F���s�����R�ɇ�w�W:�m)�KMH���3�+F+3P�$�9d�bd?�
?>bۜֆ1�&u���x�{���O?�g:�N��Ѡ�և\���w�{E��P�>���1&=���'��-;Y��e��N�"Eˣi�eV�F���
a|u�9m�nY�l��F�u��G��[�ᖽl`��?zYk/���i�~��>>�߄H��D+��<��|����饩"^�}qY:���/�g��g� ��,b_�j�[Wu<e9>�e�#����b:��.^����H�+���lrr���f°4��������Z��GSxsn�M�q�k���Ň�#�̱�ؾjL�Y6����*r��8�u0�����:���(�,{�LEz��[��wX������I��"u֧g������7O��)�� �N6����қ{�^�k�%?FY�%`�8�G˄�+�l�݅�⡔��s�྽���>j�c=��Yc�eRq9��Y��+��(�v�G��&'G2A�����m,�\��~�[+��Y	U(�x�^��ɢ~��ɲ)oo.ž1ĸL2�E9/�=��]�#�$�1��|@ӕ�X�[�3<ْ�.�2u�����3g�)����!�rh04��P҂���X˿E���h:�k��J(���tU\Ԥ����-�
�0ʊs2�Uų�.=�u't:!�G(w������ �"�=�s�p:�s1B�V~�Ո�}�ɱ�h��l��T\���}���������_����>ɮ���)�V��gaʒ~���D�c۪�j�����~:Vd���[�����UH�8h�6lxO���L��-߭b���aU\��A����	{���R���˂�����&��k0��"�)������f���܁c���{d��_G8pp�K�w�ȫ��%��߶DWd�މ�5E�?P�~\O��}y�����Y8^�y]4�mye�2�X�ͳ�1��?�������_�,y\<�kV�Z,�e;����}��������FVV2J��˯8�*����ۯ/�����{����ޓ�j�q�4��������oJ�4l9&�ƊC67�E�j��m�ǵ �u����L�[��D�� Gu.��I����]�w��C����;��QD�Y�A���f�հm��2p+
|������/��@Y�r�W����f+c�.���.![����n޼��D*��$��F�d�nzs�6]���� ��q*4/M��̭M�/��[�2������j�E�A�Яn5Qv5��|�h�9$�G�>߬����@$�*� \��͇��BTX���.\c�n�\�h2d'�{
V���1���T/���B���k���1�w�������)��U\X��[��\q9�f�\,y>ݭ�P`���R��j�
�|F�2�\�]���1y�iԻK����D�����\���8�*��F�8]�6�|O���q��� �υe��lY~���8�0�����|e��-���k�!C��=�\�3ԓ��&nָ�&*n��Z����B����8�(q�Ϣl8���
��,&�L�����˕o���}&�QBې�q�y�7ھ���e��ʔvcĦl��UA�@R�8�;({�o<D���w벊�8�Lb�y�F��YB�ܬ/8�`��?�	�5�`*�eF��ҳ'r��-��Y.�������0����F٭MdR�Páp��t�	�k���A�n�b�\��X�c�|ja�<�~�x�o%2�ݐ=Ț�H֙�g�;]�==�%�@ɧ��-,p�'�aˤؚ�K�F.�~>I����ƻ#ĞE�%�/_^}��߾����3o�v�K�8�v����>�h����Ӊ8���+Y���'��(�Ӊ'�U�:�IۦZY,<9@�w��Kԫ���X+4ܺw7Qf�'6��CC�b<rP��B&l
Abor���ƥ�e�]2����a��c�B�e�����g�j{W�5����4�X^�8��'�ݐS��C󷕕X��u�������F�[B�_���ֲ���b#���a�t7@6F�g���:�|Ȕ��gp0M�\.#�Z$�N�d�)��;RҪ.;=_mgʣ��D��O4Y���g�%�k���F�a���W��Kr�ǝ�8/��b�����c�|�� �",�BM��ln_q�n�xe��ӣ`����Sr�I���N���U4���8�J#+�%kd����$��M�/zF S��d'^J�{�����<�m�7y�8�|{԰�)�䛰'�{HV�I�_HR0����`Q楱�$���7���4��t��|�:¤���"���_�������$���"�� E�t0,8�J'��^ݞ���:=C�8�j�	0�_��mp]3�`62�(<���,��'ֿ\O]IWs)W!l^e]e'_
E�H^ўZ#n�6�=8�|�8��W��B���U�d����m�l<�� L'�a��\g0O�(��l�$�bMG}6=�&��LVq��F�܅�{>�{�U�IV{����h����ӌ�,b��n1E}7+8�d��l�Zp���L��~n��<�l�I:Y����7CT�:��dq�*Wd��;��I��,��QךV�JaP�{䣆@+{(ԌDǔb�E�����B�przL��+���F�KV6�ֈ6u������7UM���G�k~+o͒������ڢ�Op���m9�{G�=�^߂�십Q�����$�X�\�q��"ފe�?h�;N2�Ȃ��R��`iqQ�IY�E�f|:୵�8ɺ��hY�y�F���m�'��on�}�J�-0� ˜Ml�Y�f�X�pG�U�d�]���X4劐VT�d�ՠZEUh恀�m\��'Y�ȼ�Q��`�]l3N2L@�A4ߨ/�B��b]p��F�KP̃�Q��l�[p��FL��"���u�;L*���͇t�/G0Y�AVhM��&j���q��B��َ��,��U�gCҎ0����$s�*�.���`�J*N2�ɊfPe#ǥY��*4�Z��s�6;��ٻ�$�م�W���l�I�v�˞U8ϹG�'Ync�(�lgh>8�.8ɸ��c�V���ɍ|%8�j#^7�Q������ �����i��Q�-0�F�&W�\-�����"cgUc�I�w���5ز~���,4g�4e�5��{	A�I��խ���Խ�E���\�d�\��E_�F�F���I�%o���eM5��5Z'Y�d�*�\k�����8�j#���K����#��8un��B
ʞ�E^�Wq��M���u�5*x79�8��F�$R�&����uN��Ȋ��Wd{��p�I7�	�0����s�|��1x�^ĭ8>(�E6=m�r2Ă ���ѝ�����<Nn�>)�km�j�d�]��ƕ�:	'_�~�Y�]�S�Cl�l^p����㲣��l��l2{��8�0�7�K2�t!�R0p�����fIn�
]t��N2^��%M�b#<k�0�T�d�]v�D~EƵF�T'v������S���j�Sm��Iƛ����t�L� �R0p��W/� ^Sn�PQ�6�T���z1Ȁ���ͭd�Ò�����O�%i�1Y'Y7����6@u
���Sq��v
D�݂ۃ\��v�d3N2���L���W��    SQq��~�fIn���V�L�Է�����"���q'Yn֔/�|��Nn���I���&�/X�z;��s9p�Jw�-ޖ͆w���kK֦Y�J�O��IzV�w�s���:xYMY���m��m͟+�XL���TU�l��ū�d��7���v�l���pq�(P�yE'[ [~si�u�k6���ێ�-�-�H���ؼ��2n���-ml��R`���h���d˝͗e���XpV��V�?�VWG�t+W�蒊���M.�x��`�l峊�-�7#��|uW)4V��a��FY?݂-��Χ`Q��[�t�ds;�v[Oݗ�U��'��٢�7�e�Z���3N����K�g���-6]�7b權�-u6����֊>h�<|�'eA�t��f������l��斫f N�I���	?�d�,X���ߠaàQ�C�vl��l�r�	�{��Ag�l�+{o��!O+��R��Y8�ڹ ���Jt��T�T�l���	�W+�!��n�:ҁ�-�=$�t5RO��/{�� Z���r��x�ށf�l��+D�-���TV�8�(�3�W#Ź�x.8�J�n�]���nF:p�Q�2��-EI�؇��8�R�j�#i��l���ܺ�N6�^���{�V�Z��[�l����tօ.�]Qq����������$Q���'[�j���U�j�s�ݭ}�ێ�-���X��	�9��'w�-8�J�jJ��c���HN�������L3w����%k���K� }���j�@��%C$��O#	�?�b��5B/Q�S��i̱j���mw����X������X�%���}90:�|Zzw7F���)��~�ۻ[�aa���U��#N��G[.3 ��~ed8|�]��aL��/����q�1q�g�
�7����L۫���{�H�����y)�����\P���Zw��Ǯ@MFhPU_;��52�7F�Vx������ۼ$�1���֙v����w�n���^}�B�0N�m;#]��߿�>j���ߑ>���{dD���8�.�i����l���UzX߉O��3�K��/%��A�.2�`[�ݿn���ѩk'w�6�&�B2�ɷ�'DnCvW� ������T�Mp[�{)0���^�B�?R�a���ps�KԼE���*j�	�GD�y�#7op�L���j��$��;^/n.�q�m�/AGڶZ���"����D:�sYFDx�;��{���ըy���mrY�;ʖ���w��i�r"��è�p��X2}�Ǳj����l��VFO��l��Ƌ����ƻ_F]�yXnG�;����lђ���Dx���߿�裹Z�F��n��-/8]q�e��z5"R�[s��P�*V .�}��~(	Wc4T����Y��V;�>N׭BU���%���F���X������gC�~eĥ��q��}���W
C~����V#���1�s���������@��1���W�wa��xOu��w�~�kW�>&��.=Z1��;��K�\iˮ6��,G�IK��?�����\���1�㲗��\Ӑ��Qb,p��m=�����(�^N�2Q����'���s��#睬�iO��-��i�o���.�����L����������OY%,ܽ�4�i�:a3 �m�<ά�.���2���1��l�DtWC�ԧ�A��kuc���y⽏�I�5q�7Bu���{m���*�]"\+�-s�MuedX{�u�q�Z�@a|#�����;�U��£ܲv�s3�qe�4���h�g�>�O�����j���H_(<i:�lWFZu(<aWߑ����ia�E�o�7ն�qP_���עfg[WF�ϸ�M�BJ�m��=k�|Fެ߱�b���8n��Jd2s��)�lgl��v�k;f�]|G�Ql�sj�Έg�;./����薫>Ff'+qud��v;�
�5#�N��?0���S��1�;������:�Ъ+c�E���7�1�J-�S�w�ᡏ��t[d1RH�2s��5��l=�!�R�6~���������1��5G2ږ�iӖ��ˢn=�^�;ƕ��u����bTt5�l�Je
r��»�,�پ�Յ��J�����0��A�V�:Zs߳�?J�ﹸ�6��u5/�Q@S^>�����!���i�G�P��=�'���m;Yš�Pw![=��L=��"QRTq��Ζ�����*A�s^�Ʌ��lO�@�F���z�V�l�={s��Ի{k�mK�U�6��d��=�Ϸ�N��-CR�B7-�'�"�ψh?3��*�������2'"B���56�L{w;=W�lL�h�!���o��YˣG��Ƽ\��-Gw�̰��L$��ڷ��M��2�S_��*�Y�h0��Q���⫥-1��`r��Uͩ���(rނ�����á�b�1�R�<4lq�ܐ�j/فe*�p���X7��	P�����Ů?��^���9G���ʩ��O7낾d(��m-*.�E����/5���h�
��Aa�Ɇ�OK��`k؇0݄W�ll^�Ԝz3�V["��$�8��޷�x٭��M�
��8����ٳ��*�ydYu3N�2����`��N�SPq��ѷ+6�o�we8ج��N��V0��s�*N66�X�46xk����lng;M.��
|���9?�d��E�󠷭Ud�l��2p��!Y�
���t��%'[l�,4ۃ�S�#N6�e{H��ꅱi��k�Ʌ���#�s/.�Z�5睊�����p��\[���f%�arUvi���Zd�/�ׁt���v,FY���f�nuL.Fa��-��T������$s;�r"l��Eu,5�8��N�{Q�z�&�8��N��}[T,lm��u�Iw2��Y��:=u�8��N��S�^9D��ڳ��,���\�&K��V'Y�{��f����͔�o�yX�Hpyq�(L\����ج7m�t�/��`��������U}k�H¥�+l㙜��/8��ƥ/ږ�QnA��E	���b�aa /�����Ld��=��O6��r��E��jS����՝A�HLӯ�a0^���{w4U�qH���-OI��/?�/v��-�����+;��v�������g�IVw2e��m@�p�aP
��woTq���(N�ˏ8��N�_�T���U�dn'�??bp���g'����|5���E3eJYq���L&ӵX�j�(8��N�3�'ꒋ����;3^�h���٬]87ܰ���Q)@�[��MX�#�c�RO@�3��t��{��O�?��x�v���06��`#w�4a�����֮�
M�K�v���N���]��$�K��i8I��v+�E��H+��^onΞ2�����^�Uq�
7Tԏbe�6�1z�T�l	l��[��э[+K�S���-����/�7��,z�:ҁ���;���K[+G/�׾�lұ����/�|������o���"S:u��H���i��p�'�KpU{��ʰ̔���l�a�>�V~��ZQ�ba]'k؄��O�PQ��GN�
6+�Ss��V��KF\Tq�e~����fl�
���{����D�t���h�{�������+�v{�}�#I������}x'wT(�薏]/��K/Pą�>B���rӳo�Cܯ��~������_�!v�V$�3*�vi+Pɻ�yx_��fן�ja2����;T�چ�-�x2(A©�}�����!_��4�y�5��h�V����4���aϴ�Eq�>�yˠTן7�@H�g\��%Ě�Έ��N�q"���O�Bچ���d�K��"���J;�m��pt�n�bO�䰻4��/�H������Oh����m6���x�qf��'�rv��ah��S{����<��Tƕ����l�+��or���)��sn�t���%YV|>�.��� �&|��F/d�����3�3P�⾿���Eũi��P�{_d��K_ڿ��zf�݊����=�1�i^�\�
鴎92�a8�����d^=��s�3�n�v�2��x��V���è3_���8D�}ecN��k#�\�w���Ժx��C;4�*0�s��l��iH�≻o�L�5.��    T������������ڞ�T�2Z�6/)�A_�4�O��Ǹ22�{u;������.��%��+c��7�Rf�{�斬��}b�V��
���u*k���
�J���L�emI��GF����ʉ'|��x��q9��l�ixK̀v�D�D�Ƞ��j罪85ox����-{�����,�c�^fN�[�V|6�g�Ŵ�isU�+�YzNc߄��!�o�xEa
!Y�a{E�j���n,7�ѵ���M���^�"�������_��o������I�8^o��{���%
G�M�+]�f�N�����Q�8���(B�q�U��{�y�n��
�C�vS�<y\�x���"e�E�ei[II��������������7�\#S/|d�b��8f���
S��l�\Ģ�,��-ll��,��@έl'[�l9��n�N��q���V�i�ͭUd��PW���M�j��2^�Uah��]�Sq������Ο����vFΗ�Y5O|�,�4����u�TU�d=��",�4c�;�	+N29-P�ӟ�]����U�d^���7[N��l��31�Q�I�i^�rc2�[�,�F��g�<+EkЂh��O^�+N��P�S^��}QJ|�R.8�P��#��iއ�Q�/Q��'��V�����䩡���$�BV��C�����U�;��BW��ȷ��Y�1��GT�I��/;�s�9���7�Xz�I���$4���J�
J�><N2���VNzm멽��\��䊹�$�ʯr����[#ǀ�X֞�d��^}x��/�����w��!Ъ�$u3��)-�#n��)|�U�Y��:�v�gO���+8�]M���=�u��]�]��^�����C�*ήA$���y�&Sںi�2i���Af!�U��� K�|a]�'���X��<Xk�� yJ!����?!tE�v�Tek� ��Z'[@�8$7���a�Uk���f��'[[� ��U�\�'��'[zB]���l�7y�򎹗�+���-�MF�MV����L���p���ҭY�ڭݝ� �te8�*���[Q]�Z+Z�rXga�`�sr����V�yo��d����nɝ&f�[�{ZT�llNV���V���nbRq��޷���7&@��*N� 6��^_!��y�U5�\��z�ir��(v;�k��d�$�׷��Y�A�H%���jr��-E��
�9�c�)*N�&�Dk�ިZ+�5&�8�(�(����V-�k�Zq�yʁ�55�&�[�5[����rP߈h���L=�[Xq�Q�;-��ު0^���m�d� Gv�Xm�%M�S�G�l��Qʧ�P�V���ڝq�Q�2Xͫ�nqc�`rQ�[)���F��ѫ8�D�S��������Zwye8�
�<��k����a�ZN�'[[������}����>�`�+���׷�4G�ړ� �W�*N66�g�=�E����P��j8�\gKW:C�&��k+N66����Y_���=f�Xq���W����0Q��9'[d�D��ŝ�h�V|Qq�q�:Yo��ɶV��0��*N��Wo��>���O��[�z���9��U�5���d�zs�廝V3I�v�G��#N67.W�V�0���d���4	���2LNk�N� 6��j���n�D�Y�6p��1ҫ��rG�'[��z��so������e{�dC�}�hX�먖���E$$�Er��r!�-�HPV��6�����ފ�X�A���,�r�r(�ȀY'[�M���@s��[p�m�P�fYl�����6p��mN��(d-��+��A�Ͷܬ��Z1�CLY��f7#�9�Z�\8��͘Ñ��ds}��(6��
5f���mZn��Z!�����-�p�1xo�܁s�抓m�B\=S�b�l�S&�'��֦;�x
w���}q�ɖ��(��U�Ӣ���+�0Q���f�W��=�#N�J���!t�%��,?�N:X���#�o����+���e1�F1I�V�w�������P��g�l.>5��~Jr��d��s*��$�[�V�ʘ�m�ds;ۥ���~\�v�\~��2���5��۲�h8���f���{�1����li�r�s�yYY!�8�rg����ު2�B�*N���)V�֊�4.�+N����*�ooռc���r�s9䁹{U�l���ߊWb[+�
�����́- �O�hﭘ��:&����ͻC�±)+4�m�d�-E��K"=|�����&b��d�-�ܨ2�.�#���,��K��?|���?���?����o��o�I�)�#��rT�8�3�Q�%+V��
��r7%�8�
���=ꊭ��eלq�U���sRw_��v\�R�/��;��Ѵd�f�����Cc�7�"� WJq�I�8���z�!J:��fl�Q��A��&��z���E!b[V�ll��7����G=�����!v|��|��2��H��f,_���xG�W��%w0ܷXy�>���ɭ�$�p)$r��QW���3�Q;9�d�T$��Pv�-��W�*N6J��V���2?�&{��F�@%��r�[+x��r�Q��fM��R����*2u�Q39�d�@��d��U��p��q]t'[��o�(�
h�nA7+N�&?�\P^�Z+k[�Еm�d��[ּZ+��^Rq�Q�l$A?��*�h���d�,�7�.$+�ם�����P���p9��j;Y��d+}�����3d>��m�d�O2�o��r����(����L�a|Qq��y0��(��K��Ċ�MD���[�l�D���}���#[F]p&�h�� ?��o��)�B�
e?aKgX�f��XqvЃ�-E;v�^���N�����o�]am��I���\��yDd���B#����o~Zq�%�������A��*N�6���^���*���~T�lK.Ⱦy^
sk�՝�*N�
�������8��q�Z�8�
�~ha^y��-P[�Sڲ^	_��vw����#�=���ds`+�o>)/q�M������̓-�.l�l^�U�w��N���V��F��^��9z�=�m�d������lJ����'[��=�E*o��4h���N���)/They�{uU��V�>R����Uq�1J����4׿6K�Z�V��l֌����z�4�\����_wF#���l����ds;������:H��Ȋ���l�%��V����Uq����ȼ�w�W���d�$��3)o����Ȝlt��FI(on�h��(�V>m�Xq���f����u`皭BN6JB����wj}O�ڳ�k8�(	����
i���YJl�t�x^Vmk��(����l����d�����ӛ㊓�� ���ސ|����)(�(��R�B[h�(OU�l�dN��7Vo�۞����������i�}�0��Υ�?�����d˃-�x���bdyYo�8�`��r-i�+���Vw6�&�{,���ױn(��٘T���x��
A��F)H�oY�a�-�n9���8��`ӥ�Z�O��'%!����Zٖ�9�}8ٚ$���z�ޘYi�Sq�5Ix�������B0��.r5�dk��쓗s�A7/�'[l�ʥ�e0�`����6]�i�A`��`r�Ε����2l�૥�8�fXWu�ԋ�9oU�lngS�b6k#�U��v����~*�^'eN���d�M_mL�`�`r����D�2�lz��dK�M_��=����8��0��O�x\n�N���)�
�U��Ͱɩ8�m��T��v�Vt9~���0�ڻ���Q��^��ڳ����\ki�(� �,Z�*N��rQ������]x�ێ��+7`�=-2���Q�F����f�lqc+�V�V|K�;���l�[��^������Ǭ�d˛͢*J�U+^�h�3N6�]�I��ۖ��:���ʵ�H^?I[��X�>��8ٸz��[�2ԣU��(Ɗ����!�E�rl����^�l\������r�{�
�T�v�lagS�Ym�!ǭ�Pq��w6mg+˧عkG�\ip)�5j9b���'[���֪��<x�,8��`Sd��J8�l\p�Q������[+όv���l̖�!k���#=���v�\{�����|�a�.8�ܞ�B�����)G&o�'�lW�    ����v�'[�l!i�d��6�nH*N���iV��h�Vc�'[�l6\Hhdk�{%e���~i;Gk�:��Tq��U:����z�d
2Q��ֲ�Ⱥ�y���ŭ�Uq�Yʀ}�W}6�G�콦���l����O,3TD��N�N6���h���
�n��'���pKE���Vx~����n���ۨ�%�sg�$����R�?�R��ݭU�oü�.8����2jl���8�'[����ު�o�:ҁ��6EBӖ���
�8؜��TK}k�@��}8��e/J���=�k�8�ܘ}�̕��@�`r��3}�1�E,G?�'[s����F��VE�ɶ�ݬY[�f[�5�8٦���|��Q.+N�<����׀4F&�$W�d �!*e��6ɁLGQ����:΁�͛�>O�:l9}�q��1�j+]/�u���'�2��Ak����{Ղ��Y_�j�,��W"
r.��o'ې������.jN���*yx�9��ף���I���k/�U˝9�Y-8��qU��n��H6��N���i���*a]�N�����l�ʜ��`���[{!%����VT��:	;L.�si�)-j�p�<��Xq�����Kp���Y�.�8��`S���ᡊ|�*N�8F��]Z�Bj^�
N�4�����+J�=gU�l����m&"�sU�'�X�Jƚ�
��^Lq��yo��D�
U����^>ɍC�_�m���#+N6��]HA�[���T�l~g�\y[+��E�g�la���jgs��'[}S,F�{(�Ů��dK�M_k�{Ć�z��d˝-F�6�V����W�le�]}7h{�[��d��M������j�~���-m�7&��t�Pr��8��w[�s��l�x"�%bkv0�N�;NeU����
㾂�"��a{[��ȯ8���*����z,�s���d��\Q浵j5��`�l��ќ�r[�#���i��tf*#U�Yfи91-0�gd)�P����Ӿ�B�z�lHfw.����a{�sHA�8͵V0��{qE���L�o�*)'Z�hpMve8���$�~=�[�7ّ��]o�H���Cb띾������*α��M1��V,lfMQq���v���V�JQ�N�ɖ66�\�Z+oZ|Tq���v�=�V���ί�m�d+�M��\jH���m�`kO��M_�[𘒊�m_�N���V��YG:p���v~:�����PHp������ŗ��"�W�la���rЕCY�'W/�w�ↇV�i4�=.�w�ɶ9�Y���Z��z���-g��������(s��#��SU�;z�~��F�sh�x�8{J�H�����NE:��P�s{�LDVf��FK*�����<N�@�^�,,�:�dk^��v��o~������_��[��9Y�W���n��,���Ff�� ��Sq��~ۏ%���K4�^LTq�[�G$�M��70\\��������Y�f_�����8ٶ�wo��goՄ�'[�c.!��1fG2����;p�R��[����Y�bU�l�G���·V.�l��[io�dS^Z����:ҁ�m��߳j
�%"*ʩ8y���'/���E��q���7��)�D![��w8y��o�����7�'o��|{KE���[%��*N��*}�e�/;C*N����V�~H����୊���u��b�v����.������T�o�g�G��d�[q�������ŝ�V����늓��lJfע�hA
�!��ds�H���ʷ*�ae8��Φ���{�#��\�e���wS�[kU۝^����>X�G��u��FI`�M�g�S��o����m��N�@�����W�lM�3�#���_^���#�'&��0��^qr֍���U��
�ezaYq�Ў73X�N���a7!�d�]_�@��Ьv`�d�sΣP#��TT9:�ZN\�+M��I'�j;��Z[�P�͑�iWal��{6��siO����}�S�^�uW�����6=t?��Db���F?�W9���'���+��t��bU��a�_{b~9vKVqr����~�^O+Nδq&�y�T[�ݘ���̣���3�@�mUqr�1G櫜��c�*Nα}��szۜ�~�~����;��P s.Z���r俶�JΗ��|���ƼۯsF6O�;N�!G���t��:G'琣����������r��=�(J.�e��'g�_;+�B�kPqrNr��~��*ڵ�'�tm)toˇ��G��u���IQ���+�0��}���	(kX9N�I����V���ެ89�i�6�<u��H挓sH��z?�Y'U��C��׾ge�KQ����������m�-�.Wv��'[S�_�z<U�2K�@��T��,��Kgd�����tn�e��b{��qT]8{W;[�J�Fk�K�%����=��Myb���SQq��}�J ��YܼNi+N67F�\G�0i$P��W�l~̂��Z`3sp�)����-�lڊ�[��|�٫8���n����=I������^~���K�F]��э�N�8(�h�����[P�����C}.X����U���8�VH�c�n��'[3�X�٪e~uie8ؒ}S���|�Z�:ҁ����g��J�XU�lC"7�ފF�_2�lC"�4н��Jv*N�0F��º�q@_`r�!���RCq��G�\i�Rܒ{�V��z'[3�3��1�P0m��V�b(�<�R��=i��6N�����`"�fe8��~2x�ռ�
�C�Q�ɶ�AP��z��2���m�ɶ�AЌA�Ui��Sq���7]�P����UN�0�ԝ��@GST�l�$��^i�,�vρ�+N���i���yH2��dˣo�
a+�RF��d+;���ZE�OA�+N�M���|[+f*��CՊ����7�b�樗�ڷ����lJB��
���f�_p�����)��d&�\�Wk�Zp?r*N�0��U�l��˯]8ن$(5B[+�x�� �'ې%8���<�RQq�IЌ�'�p搪c��6$AI��[�g��U�lu����ӰOU��V'I�g����D��d���V����`r9�/B����s0p�IPJ=�F�[b&א�1*t�+� ��������-�ogd��o��ܧ�ŉ7�cn�ҏ�>[g�Kwxu�t1�}�ί�}�Ş�����dS����ض>�2,2�	�3x�>6���h�%�g�����
�?���_�������[1����T�8�gsS�}ĎO�sx̊�xXt�F�{�}���r�͸W3R��>�����h�8�$V��qlՂ��`�I<LS�w��=��PT���>U�7f�6�W�'�0R���c��ឌUq{o�]�8� �96t�I<���wM�-3�e9�f��C�����wB\���I<$����sLC����c�|��i�Q���w��f�'�\f��؏�Mʷ��m�d/|�?�"B����ih�7.^��q�΅�E4�n�������[P�ޅv���[hߦi	r@E�[��4��&0s8�����D[�g٭�S@���\��fnf-S˂�Բ��{��dd�M��YB��vW�G�,wou;���/3�r=��K#G��v�Ky�c�a�A�GR��L"GR}��n�NX�K�`׫!�A�b�������~|}�\�k�x�+��9!�o�<;�N�����D+[4�5�����3�voD�R.��֥s�K����|��4�y����¸�6�Xff�1�&��%�`���+�N�X�ڮP�od$o�4�IkD_[x����pjf0Q��`�k�W7.L?n��l6�v�"�b�;�ϧ��L��N�3v2Ǿy���D%����nd(1��?�El����J	x���5��݀�t��*Ⱚ)A�nO�)B���mn����0�&���^��[��>�[I����?�����S̗��hF�lO#��d������V��IA��@����ͱ[�Xo* �r�D���-����-�׍��x&"�?�Nxܳ��M֝=�.ϋ@��X�A�ʔ6aG�>j"|6�Bg|������<�w�^*�Éأo�)�T�����@��H��|�!
O��rS�L�|�D�&K$���[�3�rB���M�1��    w�C�oⲧ!���\�\���M	�i���!��:�5Z���Klq_�T��]h���*c�1���7Cd�EN��,T�@ygɞ0�O��a��~xF��։�qG�^PFq��e�+�{�c���r��N\mL��8g�0\��w�~�q�&�6���'�I�H�� �'X$u�*�I�k���uP蠽��9��u�?��;m&2�Ng"mkN�)y@�}��܋*��K�9��:F��-vN���`���<}����~N��$��gX���&����>ӓ��݊�2a	,���ײ��D\q[A59��Sy+��O�ꂎ��e2v<�M�U���Q����&���<��+{�#øYQ�<h���$�V�u�-Jnm���[�⇛���a�^�TW�<�cw�M�l嶌�&�t���j���`�%L=K�aE���>*s����c4:س�H�Y�YDžҟ1z��
������L�r�c��R#��LA5���;.}�=:?�au���?�Y���yv�fv?�rҞ�LwPDֵR����<��k�PW��>��*p=s���j�r�x�D��n:��
c��.��c �.��4e���#�����N����i��[ob��l)��ċ\j�2V3;nl�=�~�:¸ᶀ '�h��'GZ��|�dk�g�4ykςt|]p���-h�[��G��)y���-���#��.�4��-8��Φy�V,����'[}S^]bO6�D�U�ɖGߔ׃�S�Y�N�2��=,�n�U�lu���o�����v\=�����C���{|玓�nlIPb+Җ��S��ds;����f�u�����7���Խ��sY�'[�Myw�ۛT=$\q���7]�=�4(�T�li����  z�]��ɖw�ӛ��
�~��<�d+�o����bu.�0���r_�AK����fKUqZ*#�x��-eMJ�kH��9>�ٷ�"�y��fʗ��Rt�����B˼�?��L��T�l-H��-]픭D�����8�(	E؊f��|uC��t������~�Oz!�	�\�N�'[�$��˷VrB�dU�lM>����W&:�#�ƫ8�Z�䏰3�ߍ�s0g-�0�dk��2^�Ԉ=v�MQq�I��2=�'��R`���M(*���E:!\o�|έedn�����n��G C,\>�"_q
~{Q��V�T0��5��~��״L���`�p�=��Va;�}�)���`��o�kW�É�i�W��q]M���+jz�����r<k�������!�iZ����%�Y���s�����.��q�����g�v��xS;Yz2�z<�i:�Q����g�J�U�����y�|��lDG���A��J��0I&R˧�2R�D���pkM�,�T{ˤR�k�N�mL�3=c��q3v|�e:��	fl���C�g��b���$Zcu�&��_�v��-*��]H�1��N�����/���������~��//������4�F�	�m�
N�2w:�N�ӎ�iN��i�CA�_�Zy�B>�.8آ��4g�֊� q���lvg��ɤn��Cs�ι�ds��j�wУ�炓͏#F�s=L�ʫ8��`ӿ[��T��*N���y]�
��㳊�-�l��yꊲ\�G:p��M��[�����n��F�HQ}\�Ƥ�+ Ы8��Φ9>�V�B��k̂�T�,Խ֞SOd�5��6p�ٝMsM=c-��mPq���MI]�EZ��T�la�xhj*/��SQq���M���2��1�V�n[�q{*:��Ŋ�I.2c��PlvTg��^,�V՜�ʵJi.-���z���O7W5��ԃ���m��G�ݕ���V���cH��H���>$+q�^�g��+5�U��-��_���/���TI(�g����~�R�����<Z�ތ�m�Q����hU���6�wHe�ot�u��1�8ٚނ�!*~��C���'[�ǩ��{����D'[��.���,W�lu�n��~�; #:�S\p����/��/l����*�g�:��o���6(3��n[w$�nzx�#�F{ňJ����F�cꐜ������f��<h��+�>��d��Z�r�4��/t�����4��d�����:.I�x�~{CY�RT�l~����a�V��[�`r��g�B�W�����J;�e��ʑ�y����Z�������ן_���������4�d.��jF��/���򂓭�s�Y�R�������4[�8]s~�mq�̵�T<�0!���B����g�Ky0W||̌�h7L����L�ˮͣ��{yi��J��or]�\�����."����S��� ~.yt�V� s��?�����L����6f3�%]�ʗ�!w��m; �?���x&uW{*
Qb'��{z3�%��G�������HK��T-�g�q7褫��t�L#J�e�mS��XR*�y���pH?���:�>����n�)*N67ؔm!��p[�r��d�����u���d��u����-1��`Tq�š�l�ˡ�V�li�)��j��5�\y��1o���`U�le��������d��M9(��U����:}�0�0:���7:;�tY��Lbr*��ܠSN���S��ۤ���t�cS�K��&otaЩ�}�МX��7�a��x�9z�B��э@7-G	��i�v���Q���v��|�*���T軦e<T��^�]FZ7[������R�)˧�q�����P�ٹ��c~�:�=e�3^��+�6�|�4gY�FG��O?�������������f����u�c�V?�xO2�nc�?+�?������۷1���FN`�4[���t͏�;��L���˗W���÷�����[��Sx�o遭�7ވ��/����O���E뺲T�\�V:�*�h�SL�Z�d6��0ԣ-a�I��St�[NSZ�IZ>��?�#�z��diU�%)�P��2�f>q��Kt�&���L��sU�����d&Ɗ� l������t��i�Y�Շ����њ��7:��]Hc���(��T��9zT#߹�A����ޣY{7�F�A_�\�|�J7/���;ott�+���,���(ot��9�RoF��:��+��^˺SL �Y��lx���F�;���%�on�<6��7�:d�w�Bi�`?>��x���U�>[����I1_q�y��)�B����颹⍎R�_�3�|��f�"|�72ʄ���Rx�b�n��7:ʄ��y\Еf�*���E�O��b����q!�x�����o���^x��sa��.�;�^�n,���ׅ���E����	Q͇_o#̌.�_��-��u;��QT��t�j��ެ�·+����;�x"�f���e��I�(�Ző��%��:otv�vJ��ތ��\�v�ѹ1ث���;Br*����Y]�K���ix����J�fʝ|#��n�]t�`���v:�W�ѥ>��(��Z��rv^�F��T��lS�Z�B������2�z�4YQkE���gV�]�����J=�g�v���G�#N�h�X�����,1�WR�FG����Dtk昺��u�otn�;͖�7s��4t;����;�P�f���x��P�]@N�3ۛex���x��P��r�<}�ߚ�@j֩x�K{�N����'we��.����/͹$ot��P�Sk�ތ��=��x��Xȭ<�'ؚ��غ[Jq�%J������?|�ӟ��:)��7vp��y�����I�Fz��@?�݀��7R�iYX{M�7c(j�_U�F�A'�ƺ��e۽�������7� �,�;�H�5s�?R���F'��n�OKn�<S���U��%��^���f�55�x�ˠK?ܬ/g�����%jp#+4���|9��tb�:ԁ7�
�*����{3V��c�x3[СD�y��J~���l���u�O=�f����F'ۼaPy�ld���֙x�;ݩѢ5ےລw3��"��>e��ゎa��h�7�D:���S�lkf[���s;��2��wB�݋?���Ň?��_^|�ǯ�V�%��x#/ �n��^·f�~�ѯ]x E  ���sn���,�v��*N�b:]q�����g�̰����FgI�#�o��l�T��ot��.��jۛ�PRyX4otCB.Դ��ms7a�ف7��};Z@tk��~���%֚��#�Y���Qy�ot	gw~������jp#� �E���-q7�rC	*��
��{����n�T���FW;��h�r��;���h怢�|�_�������__|���/v�v哛A.*�~�K��裾Y�[ӛ�3+���C�o?����o}�嗿��_������_Tjfc�HUq<�ڑ�0=#^���3xݖ5��}�z~~���i�      m   �   x����
�0���S��O.�����c���
�b�/(�`�ސ��~�ǅ ����#0�c<���1y�c�X$��۴���2ݗ��H�w������XS��N�q�ɪ�f	�"1�P��.B��(�Me�zX���G�(�b�8?��}���C�=����N[��H6�ľ+$m`7���mH      _   u   x�e�1�0@��>�/�v�r`EH,��@+�Yz{: 1T���WPz����<H���eOأ�A��2��z$���0�ez�ЧO�#�G���	n�Kke��yP'9�A��	���_U�      A   P  x��Yَ[Ir}��⢞��I*�ȍ�<4�~0l���DV��RM����O�*�j�gF��T�Kf�8��H:�Q��K�J�/<>���g�f�X�:�X�J�fiep�j_��)����*s�.7��TJlϴ�VHZ�-�Y��K����$�Y�HR$�$��j�:�>����~���xgO��w2{�0:A�[DH�b�����ib�@���a'�]�F�Z��l)�\
9��oޕH��R��RM�obP�H�kA"+������#/Wx�y��u��U^�!28�+�&d���@I/�d-�LQ4"���X�UM�(�`�KN�3�q)���h|5$q���9{
���KzYt:� �#;qD��.���ܱ�0�@�tv�c�)da
��R��T�2k2*U�ǒ��d�*^)�U%"д$�S��Gف��&+�� 6�\��!�7�RW �ސ˧ǚ����q��=W�mZ�y&�q��']�UDę �߲� ���:˦��L�^�ز��Ԣl�&�\^�B:#٨*m�d�vMs	��}���-Ψ��Ⱥۀ�����O�m��Ve�߆h����@oR1"�c���T-G����~�R��z1Xh3�ֹH��L��9��0�M��T+��`��E�%@�c�EU�~�d2��Rl�KɕS�Svb��HE'��N	R���$¸�d�E"a�_)�`c��an�#�ߧ�\���t>�j�1��0�JI6"fԓ���µ��߷�؅����KuC�w)%��=���b��Ħ�!�]�Ad��(�Y�(eE��֒�!�k�w�%�{[pg��l
�4��K�gD��������QV�e��sJJ�&����oXM�j����I"`�=H�M�ɐ0H�Pra�ܒ3��r�I.�C�����Kޤ�z���ێ��t �c�k�Ez��6�l8#Ed��Y+�@*)� ��I�Zn���f$Q'��BB&YӠ
@'�V3^O)�&��	9/��)��ck��k�!q��aa����u��A"٥?!E�1twm	n0>�  ��o�z��s�"p�Z�-�J'uWD�bC+�5�Ks� �J�NF��"Q�J��`�FK��+nw�D�� zz�� #�s`�u����ZkN�����='{8_\�|�WH�w ����Qʱ���!�[s")@m�LM�53>���^���<�k�H-��p���Gh�B�Q� ma߆�u�Q�FJ��a�t �O���~��xA�렽q Z�����hEz�XE�dD6hݥ��f%�B߳��m� ��E��ш�"]D��*P\t�*�*h弪�dK���≫M����V��1Fs:�2���]��O�fu�O=O���ݐ�_��/�y�}J�nw�!�x�G3�ݞ��������0���)�m��f>|�T�M,���qx�}�[���[��W����vH��~W��x�d�bx8������|��}}��2���>n?n����6m���阾�?�\�V��X�̾������Ç����cO�:tG�=c��i��퉁����݇�|7m��������?�˿-��/�����᧺Ym�άOpt�*u>�M��������e1܍���exL�#p�w~E��a|�ǿ�X��o�_ظ<������n�Ǐצ�3�|N����>�����:L�V�����("�<}:����O���<]�Fݍ�z'=�z�ǧ��{ܧq�齉,�VӢG���������tzG�
��q��m�}>���Z��a�𿝵a�b8��^>#B��n�5�1Ӗ�$8]8T���������aʖ�������}w��0�㋳o������{�-^n���?�������bk\Y-�3��m�XL�ݼ�+?�+���������#��[�;ڨƵ��=/�s��s5:|{�=�[�������D����I�^?`����i���|���)�E�;l�kE�~�3�Ĥ&�a�Ichq��T�1��*=6�� TYCSJ�D�9T�ym2�0�l��-��+L3�J�Cu+k�������_~�_n���㗺���{����騫�	�X�ׂ���+���[!US��o���Ѡ�D�W����|#0.������J)��J�Q� Ի�� j`�hle)3L��96���+1bb�2����x�TYbv7���T���*mr��,�Jc�u��*������s��aK:�Ty�s���[�/6�Ѵ&�(�ԕ�H!M�3�Y8�d�2IBZA�'�gc�D+1�ɒ01���H
H��*�B*9�����ln:Է���F{�\��ɣt��Whc����i3��9���N�I>"/��M'�1Y�b��[hF�ȇ�G�(�\c��2ƹD�}4��M��09��ȩ��B��'z3�p����]�i���xL؞����z,v_KS�qd
ߚ=�DR��P�z G��W��E��́kI�T)�n����u���L�؟�FW<��7����\z�hTQD�zE"	C��k�^^��0���/��E!��U�P�XS�0�a�悈͸���C!��d�U|qIʌx��J
�7"�C*�t�t��W4!Q�>�t"e����y{�[�O��*1��i.E�0R�T�p�F��e-Bl��eQs�F�R�G�R?��)�V�K�\�9��DS=�w���(F����8V�ᴐ�1�^��E!�sʭ/u�^�<Ã�j��[����h&7�IT�iH���SSUT�-��#�Do�^y���:��TC����$h�2IJm���"Ɋ8�x-�dc���� ȼ�Ws.��Kj?|��M�5������Od�t�q�kj�*p-($*�WϽ���聆��kLA��M�u��3���>�!i�dk�	m'a\W��Ev�Q�؅�I�k�m��g�_���f�gBǘ~��W���}$��z�{���Iz7���/Z�pz��4+�`2J�P�iݿ{��H�l��T\�/RT>p���.��lH?�
����5\mǬ���0vft���v��o�w��G�>�����6�$����,k�F�lOx+�g 6���m.̚�A\j֚Q�d�!M?Aƻ�S���)B��l�D��2m�is�@M��S�^����JD98ڪ`��!��s7I}�d��r�(�6�@
���So��6�e�׿iKݲs�l��!��#f.�t9h(H���{-����d#{������k]uH����Ә�-��	���}��������N�lh��4h����"B]@'C8�kkcC�-5n��� #��F�j�ҐR2�S�$�Y��TF�(ѿi�90������� _��P"]|=�Ч�6V��(��S�"����*C�,��TS�A6�9�u�G��lь�	��O���9
4U)���o��V�B���e喞��姴~�,)5�]�we�!1�����&"�;s*�)�Ƀ^O ��˪j�3 �L'k��v]�@̐A̂�pZMmYc1Ic�&F4��4��l��H��?w��v��������g׿[��P�N	��hI��p϶�f�N��b+9jc�� 9�ǀqԮ�s3H⊍>6.������ב�t�F�T����>�?^�t�G�:yf����g������W�B�aj���޽�?�b~�     