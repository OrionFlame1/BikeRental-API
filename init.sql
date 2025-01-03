--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bike_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.bike_status AS ENUM (
    'In_Use',
    'Available',
    'Maintenance',
    'Retired'
);


ALTER TYPE public.bike_status OWNER TO postgres;

--
-- Name: currency; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.currency AS ENUM (
    'EURO',
    'USD',
    'RON'
);


ALTER TYPE public.currency OWNER TO postgres;

--
-- Name: membership_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.membership_type AS ENUM (
    'Standard',
    'Premium',
    'VIP'
);


ALTER TYPE public.membership_type OWNER TO postgres;

--
-- Name: payment_method; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_method AS ENUM (
    'Card',
    'Account'
);


ALTER TYPE public.payment_method OWNER TO postgres;

--
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status AS ENUM (
    'Active',
    'Inactive'
);


ALTER TYPE public.user_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bikes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bikes (
    bikeid integer NOT NULL,
    biketype character varying(20),
    purchasedate date,
    bikeproducer character varying(50),
    bikedefaulttarif numeric(5,2)
);


ALTER TABLE public.bikes OWNER TO postgres;

--
-- Name: bikes_bikeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bikes_bikeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bikes_bikeid_seq OWNER TO postgres;

--
-- Name: bikes_bikeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bikes_bikeid_seq OWNED BY public.bikes.bikeid;


--
-- Name: example; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.example (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.example OWNER TO postgres;

--
-- Name: example_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.example_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.example_id_seq OWNER TO postgres;

--
-- Name: example_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.example_id_seq OWNED BY public.example.id;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    inventoryid integer NOT NULL,
    bikeid integer,
    checkdate timestamp without time zone,
    status public.bike_status,
    notes text
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: inventory_inventoryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_inventoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_inventoryid_seq OWNER TO postgres;

--
-- Name: inventory_inventoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventory_inventoryid_seq OWNED BY public.inventory.inventoryid;


--
-- Name: maintenancelogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maintenancelogs (
    logid integer NOT NULL,
    bikeid integer,
    maintenancedate date,
    description text,
    cost numeric(10,2),
    technicianname character varying(50)
);


ALTER TABLE public.maintenancelogs OWNER TO postgres;

--
-- Name: maintenancelogs_logid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maintenancelogs_logid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.maintenancelogs_logid_seq OWNER TO postgres;

--
-- Name: maintenancelogs_logid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maintenancelogs_logid_seq OWNED BY public.maintenancelogs.logid;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    paymentid integer NOT NULL,
    rentalid integer,
    paymentdate timestamp without time zone,
    amount numeric(10,2),
    paymentmethod public.payment_method,
    currency public.currency,
    cardnumberhint character varying(4)
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_paymentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_paymentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_paymentid_seq OWNER TO postgres;

--
-- Name: payments_paymentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_paymentid_seq OWNED BY public.payments.paymentid;


--
-- Name: rentals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rentals (
    rentalid integer NOT NULL,
    userid integer,
    bikeid integer,
    starttime timestamp without time zone,
    endtime timestamp without time zone,
    startlocation character varying(100),
    endlocation character varying(100),
    status character varying(20)
);


ALTER TABLE public.rentals OWNER TO postgres;

--
-- Name: rentals_rentalid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rentals_rentalid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rentals_rentalid_seq OWNER TO postgres;

--
-- Name: rentals_rentalid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rentals_rentalid_seq OWNED BY public.rentals.rentalid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    firstname character varying(50),
    lastname character varying(50),
    email character varying(100),
    phonenumber character varying(15),
    registrationdate date,
    membershiptype public.membership_type,
    status public.user_status
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_userid_seq OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: bikes bikeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bikes ALTER COLUMN bikeid SET DEFAULT nextval('public.bikes_bikeid_seq'::regclass);


--
-- Name: example id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.example ALTER COLUMN id SET DEFAULT nextval('public.example_id_seq'::regclass);


--
-- Name: inventory inventoryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory ALTER COLUMN inventoryid SET DEFAULT nextval('public.inventory_inventoryid_seq'::regclass);


--
-- Name: maintenancelogs logid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenancelogs ALTER COLUMN logid SET DEFAULT nextval('public.maintenancelogs_logid_seq'::regclass);


--
-- Name: payments paymentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN paymentid SET DEFAULT nextval('public.payments_paymentid_seq'::regclass);


--
-- Name: rentals rentalid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals ALTER COLUMN rentalid SET DEFAULT nextval('public.rentals_rentalid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Data for Name: bikes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bikes (bikeid, biketype, purchasedate, bikeproducer, bikedefaulttarif) FROM stdin;
1	Road	2021-03-04	Trek	1.89
2	Electric	2021-04-23	Specialized	1.56
3	Hybrid	2022-01-08	Giant	0.22
4	Mountain	2021-10-26	Trek	0.37
5	Road	2021-01-13	Specialized	0.32
6	Electric	2021-12-23	Giant	1.06
7	Hybrid	2021-08-17	Trek	1.33
8	Mountain	2020-11-30	Specialized	0.60
9	Road	2021-12-03	Giant	0.83
10	Electric	2021-06-14	Trek	0.81
11	Hybrid	2020-11-27	Specialized	0.32
12	Mountain	2022-02-09	Giant	1.81
13	Road	2021-02-26	Trek	1.24
14	Electric	2021-06-28	Specialized	0.56
15	Hybrid	2021-01-27	Giant	1.87
16	Mountain	2021-03-02	Trek	1.01
17	Road	2021-09-24	Specialized	1.91
18	Electric	2020-12-22	Giant	0.67
19	Hybrid	2021-07-02	Trek	0.27
20	Mountain	2021-04-02	Specialized	1.77
21	Road	2021-01-11	Giant	0.58
22	Electric	2021-05-15	Trek	1.14
23	Hybrid	2022-01-05	Specialized	0.63
24	Mountain	2021-10-24	Giant	0.67
25	Road	2021-08-11	Trek	1.15
26	Electric	2021-06-09	Specialized	0.80
27	Hybrid	2021-06-13	Giant	1.54
28	Mountain	2021-07-07	Trek	0.36
29	Road	2021-06-09	Specialized	1.33
30	Electric	2021-01-16	Giant	1.51
\.


--
-- Data for Name: example; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.example (id, name) FROM stdin;
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (inventoryid, bikeid, checkdate, status, notes) FROM stdin;
1	1	2021-11-25 00:00:00	Available	Initial availability after purchase
2	2	2021-10-22 00:00:00	Available	Initial availability after purchase
3	3	2022-10-28 00:00:00	Available	Initial availability after purchase
4	4	2021-12-27 00:00:00	Available	Initial availability after purchase
5	5	2021-06-13 00:00:00	Available	Initial availability after purchase
6	6	2022-01-02 00:00:00	Available	Initial availability after purchase
7	7	2022-08-09 00:00:00	Available	Initial availability after purchase
8	8	2021-07-04 00:00:00	Available	Initial availability after purchase
9	9	2022-07-27 00:00:00	Available	Initial availability after purchase
10	10	2021-12-24 00:00:00	Available	Initial availability after purchase
11	11	2021-03-22 00:00:00	Available	Initial availability after purchase
12	12	2022-12-16 00:00:00	Available	Initial availability after purchase
13	13	2021-12-13 00:00:00	Available	Initial availability after purchase
14	14	2021-11-20 00:00:00	Available	Initial availability after purchase
15	15	2021-03-04 00:00:00	Available	Initial availability after purchase
16	16	2022-02-17 00:00:00	Available	Initial availability after purchase
17	17	2022-07-29 00:00:00	Available	Initial availability after purchase
18	18	2021-03-31 00:00:00	Available	Initial availability after purchase
19	19	2022-06-12 00:00:00	Available	Initial availability after purchase
20	20	2022-02-09 00:00:00	Available	Initial availability after purchase
21	21	2021-08-10 00:00:00	Available	Initial availability after purchase
22	22	2022-03-08 00:00:00	Available	Initial availability after purchase
23	23	2022-10-03 00:00:00	Available	Initial availability after purchase
24	24	2022-09-22 00:00:00	Available	Initial availability after purchase
25	25	2022-02-08 00:00:00	Available	Initial availability after purchase
26	26	2022-05-26 00:00:00	Available	Initial availability after purchase
27	27	2021-06-25 00:00:00	Available	Initial availability after purchase
28	28	2022-06-22 00:00:00	Available	Initial availability after purchase
29	29	2022-01-06 00:00:00	Available	Initial availability after purchase
30	30	2021-09-27 00:00:00	Available	Initial availability after purchase
101	1	2021-11-25 05:00:00	In_Use	Bike in use
102	1	2021-11-25 05:25:00	Available	Returned after use
201	2	2021-10-22 02:00:00	In_Use	Bike in use
202	2	2021-10-22 02:22:00	Available	Returned after use
301	3	2022-10-28 01:00:00	In_Use	Bike in use
302	3	2022-10-28 01:45:00	Available	Returned after use
401	4	2021-12-27 02:00:00	In_Use	Bike in use
402	4	2021-12-27 02:35:00	Available	Returned after use
501	5	2021-06-13 01:00:00	In_Use	Bike in use
502	5	2021-06-13 01:14:00	Available	Returned after use
601	6	2022-01-02 01:00:00	In_Use	Bike in use
602	6	2022-01-02 01:13:00	Available	Returned after use
701	7	2022-08-09 04:00:00	In_Use	Bike in use
702	7	2022-08-09 04:10:00	Available	Returned after use
801	8	2021-07-04 05:00:00	In_Use	Bike in use
802	8	2021-07-04 05:19:00	Available	Returned after use
901	9	2022-07-27 11:00:00	In_Use	Bike in use
902	9	2022-07-27 11:43:00	Available	Returned after use
1001	10	2021-12-24 07:00:00	In_Use	Bike in use
1002	10	2021-12-24 07:38:00	Available	Returned after use
1101	11	2021-03-22 00:00:00	In_Use	Bike in use
1102	11	2021-03-22 00:55:00	Available	Returned after use
1201	12	2022-12-16 02:00:00	In_Use	Bike in use
1202	12	2022-12-16 02:40:00	Available	Returned after use
1301	13	2021-12-13 03:00:00	In_Use	Bike in use
1302	13	2021-12-13 03:40:00	Available	Returned after use
1401	14	2021-11-20 04:00:00	In_Use	Bike in use
1402	14	2021-11-20 04:40:00	Available	Returned after use
1501	15	2021-03-04 02:00:00	In_Use	Bike in use
1502	15	2021-03-04 02:34:00	Available	Returned after use
1601	16	2022-02-17 11:00:00	In_Use	Bike in use
1602	16	2022-02-17 11:49:00	Available	Returned after use
1701	17	2022-07-29 02:00:00	In_Use	Bike in use
1702	17	2022-07-29 02:36:00	Available	Returned after use
1801	18	2021-03-31 08:00:00	In_Use	Bike in use
1802	18	2021-03-31 08:43:00	Available	Returned after use
1901	19	2022-06-12 07:00:00	In_Use	Bike in use
1902	19	2022-06-12 07:44:00	Available	Returned after use
2001	20	2022-02-09 09:00:00	In_Use	Bike in use
2002	20	2022-02-09 09:58:00	Available	Returned after use
2101	21	2021-08-10 00:00:00	In_Use	Bike in use
2102	21	2021-08-10 00:13:00	Available	Returned after use
2201	22	2022-03-08 04:00:00	In_Use	Bike in use
2202	22	2022-03-08 04:19:00	Available	Returned after use
2301	23	2022-10-03 09:00:00	In_Use	Bike in use
2302	23	2022-10-03 09:47:00	Available	Returned after use
2401	24	2022-09-22 01:00:00	In_Use	Bike in use
2402	24	2022-09-22 01:44:00	Available	Returned after use
2501	25	2022-02-08 09:00:00	In_Use	Bike in use
2502	25	2022-02-08 09:37:00	Available	Returned after use
2601	26	2022-05-26 06:00:00	In_Use	Bike in use
2602	26	2022-05-26 06:14:00	Available	Returned after use
2701	27	2021-06-25 11:00:00	In_Use	Bike in use
2702	27	2021-06-25 11:40:00	Available	Returned after use
2801	28	2022-06-22 01:00:00	In_Use	Bike in use
2802	28	2022-06-22 01:32:00	Available	Returned after use
2901	29	2022-01-06 10:00:00	In_Use	Bike in use
2902	29	2022-01-06 10:32:00	Available	Returned after use
3001	30	2021-09-27 06:00:00	In_Use	Bike in use
3002	30	2021-09-27 06:58:00	Available	Returned after use
3101	1	2021-11-25 07:00:00	In_Use	Bike in use
3102	1	2021-11-25 07:11:00	Available	Returned after use
3201	2	2021-10-22 05:00:00	In_Use	Bike in use
3202	2	2021-10-22 05:20:00	Available	Returned after use
3301	3	2022-10-28 06:00:00	In_Use	Bike in use
3302	3	2022-10-28 06:22:00	Available	Returned after use
3401	4	2021-12-27 05:00:00	In_Use	Bike in use
3402	4	2021-12-27 05:12:00	Available	Returned after use
3501	5	2021-06-13 06:00:00	In_Use	Bike in use
3502	5	2021-06-13 06:31:00	Available	Returned after use
3601	6	2022-01-02 06:00:00	In_Use	Bike in use
3602	6	2022-01-02 06:22:00	Available	Returned after use
3701	7	2022-08-09 07:00:00	In_Use	Bike in use
3702	7	2022-08-09 07:35:00	Available	Returned after use
3801	8	2021-07-04 02:00:00	In_Use	Bike in use
3802	8	2021-07-04 02:58:00	Available	Returned after use
3901	9	2022-07-27 06:00:00	In_Use	Bike in use
3902	9	2022-07-27 06:59:00	Available	Returned after use
4001	10	2021-12-24 04:00:00	In_Use	Bike in use
4002	10	2021-12-24 04:45:00	Available	Returned after use
4101	11	2021-03-22 00:00:00	In_Use	Bike in use
4102	11	2021-03-22 00:31:00	Available	Returned after use
4201	12	2022-12-16 03:00:00	In_Use	Bike in use
4202	12	2022-12-16 03:45:00	Available	Returned after use
4301	13	2021-12-13 10:00:00	In_Use	Bike in use
4302	13	2021-12-13 10:43:00	Available	Returned after use
4401	14	2021-11-20 02:00:00	In_Use	Bike in use
4402	14	2021-11-20 02:52:00	Available	Returned after use
4501	15	2021-03-04 02:00:00	In_Use	Bike in use
4502	15	2021-03-04 02:46:00	Available	Returned after use
4601	16	2022-02-17 03:00:00	In_Use	Bike in use
4602	16	2022-02-17 03:14:00	Available	Returned after use
4701	17	2022-07-29 09:00:00	In_Use	Bike in use
4702	17	2022-07-29 09:51:00	Available	Returned after use
4801	18	2021-03-31 09:00:00	In_Use	Bike in use
4802	18	2021-03-31 09:57:00	Available	Returned after use
4901	19	2022-06-12 00:00:00	In_Use	Bike in use
4902	19	2022-06-12 00:44:00	Available	Returned after use
5001	20	2022-02-09 04:00:00	In_Use	Bike in use
5002	20	2022-02-09 04:58:00	Available	Returned after use
5101	21	2021-08-10 03:00:00	In_Use	Bike in use
5102	21	2021-08-10 03:52:00	Available	Returned after use
5201	22	2022-03-08 09:00:00	In_Use	Bike in use
5202	22	2022-03-08 09:50:00	Available	Returned after use
5301	23	2022-10-03 02:00:00	In_Use	Bike in use
5302	23	2022-10-03 02:52:00	Available	Returned after use
5401	24	2022-09-22 03:00:00	In_Use	Bike in use
5402	24	2022-09-22 03:55:00	Available	Returned after use
5501	25	2022-02-08 04:00:00	In_Use	Bike in use
5502	25	2022-02-08 04:38:00	Available	Returned after use
5601	26	2022-05-26 11:00:00	In_Use	Bike in use
5602	26	2022-05-26 11:55:00	Available	Returned after use
5701	27	2021-06-25 07:00:00	In_Use	Bike in use
5702	27	2021-06-25 07:23:00	Available	Returned after use
5801	28	2022-06-22 05:00:00	In_Use	Bike in use
5802	28	2022-06-22 05:31:00	Available	Returned after use
5901	29	2022-01-06 06:00:00	In_Use	Bike in use
5902	29	2022-01-06 06:17:00	Available	Returned after use
6001	30	2021-09-27 04:00:00	In_Use	Bike in use
6002	30	2021-09-27 04:54:00	Available	Returned after use
6101	1	2021-11-25 07:00:00	In_Use	Bike in use
6102	1	2021-11-25 07:46:00	Available	Returned after use
6201	2	2021-11-14 08:00:00	In_Use	Bike in use
6202	2	2021-11-14 08:59:00	Available	Returned after use
6301	3	2022-10-28 04:00:00	In_Use	Bike in use
6302	3	2022-10-28 04:50:00	Available	Returned after use
6401	4	2021-12-27 00:00:00	In_Use	Bike in use
6402	4	2021-12-27 00:49:00	Available	Returned after use
6501	5	2021-11-14 03:00:00	In_Use	Bike in use
6502	5	2021-11-14 03:45:00	Available	Returned after use
6601	6	2022-01-02 02:00:00	In_Use	Bike in use
6602	6	2022-01-02 02:22:00	Available	Returned after use
6701	7	2022-08-09 01:00:00	In_Use	Bike in use
6702	7	2022-08-09 01:12:00	Available	Returned after use
6801	8	2021-11-14 06:00:00	In_Use	Bike in use
6802	8	2021-11-14 06:28:00	Available	Returned after use
6901	9	2022-07-27 02:00:00	In_Use	Bike in use
6902	9	2022-07-27 02:59:00	Available	Returned after use
7001	10	2021-12-24 00:00:00	In_Use	Bike in use
7002	10	2021-12-24 00:45:00	Available	Returned after use
7101	11	2021-11-14 05:00:00	In_Use	Bike in use
7102	11	2021-11-14 05:16:00	Available	Returned after use
7201	12	2022-12-16 05:00:00	In_Use	Bike in use
7202	12	2022-12-16 05:52:00	Available	Returned after use
7301	13	2021-12-13 02:00:00	In_Use	Bike in use
7302	13	2021-12-13 02:30:00	Available	Returned after use
7401	14	2021-11-20 07:00:00	In_Use	Bike in use
7402	14	2021-11-20 07:43:00	Available	Returned after use
7501	15	2021-11-14 02:00:00	In_Use	Bike in use
7502	15	2021-11-14 02:21:00	Available	Returned after use
7601	16	2022-02-17 04:00:00	In_Use	Bike in use
7602	16	2022-02-17 04:33:00	Available	Returned after use
7701	17	2022-07-29 00:00:00	In_Use	Bike in use
7702	17	2022-07-29 00:54:00	Available	Returned after use
7801	18	2021-11-14 06:00:00	In_Use	Bike in use
7802	18	2021-11-14 06:56:00	Available	Returned after use
7901	19	2022-06-12 04:00:00	In_Use	Bike in use
7902	19	2022-06-12 04:56:00	Available	Returned after use
8001	20	2022-02-09 03:00:00	In_Use	Bike in use
8002	20	2022-02-09 03:30:00	Available	Returned after use
8101	21	2021-11-14 11:00:00	In_Use	Bike in use
8102	21	2021-11-14 11:16:00	Available	Returned after use
8201	22	2022-03-08 11:00:00	In_Use	Bike in use
8202	22	2022-03-08 11:38:00	Available	Returned after use
8301	23	2022-10-03 05:00:00	In_Use	Bike in use
8302	23	2022-10-03 05:47:00	Available	Returned after use
8401	24	2022-09-22 01:00:00	In_Use	Bike in use
8402	24	2022-09-22 01:40:00	Available	Returned after use
8501	25	2022-02-08 11:00:00	In_Use	Bike in use
8502	25	2022-02-08 11:43:00	Available	Returned after use
8601	26	2022-05-26 03:00:00	In_Use	Bike in use
8602	26	2022-05-26 03:31:00	Available	Returned after use
8701	27	2021-11-14 04:00:00	In_Use	Bike in use
8702	27	2021-11-14 04:40:00	Available	Returned after use
8801	28	2022-06-22 09:00:00	In_Use	Bike in use
8802	28	2022-06-22 09:41:00	Available	Returned after use
8901	29	2022-01-06 11:00:00	In_Use	Bike in use
8902	29	2022-01-06 11:45:00	Available	Returned after use
9001	30	2021-11-14 09:00:00	In_Use	Bike in use
9002	30	2021-11-14 09:10:00	Available	Returned after use
9101	1	2022-01-07 09:00:00	In_Use	Bike in use
9102	1	2022-01-07 09:46:00	Available	Returned after use
9201	2	2022-01-07 11:00:00	In_Use	Bike in use
9202	2	2022-01-07 11:34:00	Available	Returned after use
9301	3	2022-10-28 00:00:00	In_Use	Bike in use
9302	3	2022-10-28 00:38:00	Available	Returned after use
9401	4	2022-01-07 03:00:00	In_Use	Bike in use
9402	4	2022-01-07 03:58:00	Available	Returned after use
9501	5	2022-01-07 03:00:00	In_Use	Bike in use
9502	5	2022-01-07 03:52:00	Available	Returned after use
9601	6	2022-01-07 11:00:00	In_Use	Bike in use
9602	6	2022-01-07 11:28:00	Available	Returned after use
9701	7	2022-08-09 00:00:00	In_Use	Bike in use
9702	7	2022-08-09 00:35:00	Available	Returned after use
9801	8	2022-01-07 04:00:00	In_Use	Bike in use
9802	8	2022-01-07 04:32:00	Available	Returned after use
9901	9	2022-07-27 01:00:00	In_Use	Bike in use
9902	9	2022-07-27 01:22:00	Available	Returned after use
10001	10	2022-01-07 11:00:00	In_Use	Bike in use
10002	10	2022-01-07 11:59:00	Available	Returned after use
10101	11	2022-01-07 04:00:00	In_Use	Bike in use
10102	11	2022-01-07 04:58:00	Available	Returned after use
10201	12	2022-12-16 07:00:00	In_Use	Bike in use
10202	12	2022-12-16 07:21:00	Available	Returned after use
10301	13	2022-01-07 02:00:00	In_Use	Bike in use
10302	13	2022-01-07 02:38:00	Available	Returned after use
10401	14	2022-01-07 09:00:00	In_Use	Bike in use
10402	14	2022-01-07 09:16:00	Available	Returned after use
10501	15	2022-01-07 04:00:00	In_Use	Bike in use
10502	15	2022-01-07 04:12:00	Available	Returned after use
10601	16	2022-02-17 03:00:00	In_Use	Bike in use
10602	16	2022-02-17 03:35:00	Available	Returned after use
10701	17	2022-07-29 02:00:00	In_Use	Bike in use
10702	17	2022-07-29 02:21:00	Available	Returned after use
10801	18	2022-01-07 01:00:00	In_Use	Bike in use
10802	18	2022-01-07 01:28:00	Available	Returned after use
10901	19	2022-06-12 10:00:00	In_Use	Bike in use
10902	19	2022-06-12 10:12:00	Available	Returned after use
11001	20	2022-02-09 10:00:00	In_Use	Bike in use
11002	20	2022-02-09 10:41:00	Available	Returned after use
11101	21	2022-01-07 01:00:00	In_Use	Bike in use
11102	21	2022-01-07 01:44:00	Available	Returned after use
11201	22	2022-03-08 03:00:00	In_Use	Bike in use
11202	22	2022-03-08 03:45:00	Available	Returned after use
11301	23	2022-10-03 11:00:00	In_Use	Bike in use
11302	23	2022-10-03 11:31:00	Available	Returned after use
11401	24	2022-09-22 07:00:00	In_Use	Bike in use
11402	24	2022-09-22 07:26:00	Available	Returned after use
11501	25	2022-02-08 07:00:00	In_Use	Bike in use
11502	25	2022-02-08 07:47:00	Available	Returned after use
11601	26	2022-05-26 08:00:00	In_Use	Bike in use
11602	26	2022-05-26 08:54:00	Available	Returned after use
11701	27	2022-01-07 10:00:00	In_Use	Bike in use
11702	27	2022-01-07 10:32:00	Available	Returned after use
11801	28	2022-06-22 09:00:00	In_Use	Bike in use
11802	28	2022-06-22 09:35:00	Available	Returned after use
11901	29	2022-01-07 01:00:00	In_Use	Bike in use
11902	29	2022-01-07 01:52:00	Available	Returned after use
12001	30	2022-01-07 04:00:00	In_Use	Bike in use
12002	30	2022-01-07 04:41:00	Available	Returned after use
12101	1	2021-11-25 04:00:00	In_Use	Bike in use
12102	1	2021-11-25 04:55:00	Available	Returned after use
12201	2	2021-10-22 07:00:00	In_Use	Bike in use
12202	2	2021-10-22 07:44:00	Available	Returned after use
12301	3	2022-10-28 00:00:00	In_Use	Bike in use
12302	3	2022-10-28 00:58:00	Available	Returned after use
12401	4	2021-12-27 05:00:00	In_Use	Bike in use
12402	4	2021-12-27 05:35:00	Available	Returned after use
12501	5	2021-06-13 00:00:00	In_Use	Bike in use
12502	5	2021-06-13 00:45:00	Available	Returned after use
12601	6	2022-01-02 05:00:00	In_Use	Bike in use
12602	6	2022-01-02 05:16:00	Available	Returned after use
12701	7	2022-08-09 11:00:00	In_Use	Bike in use
12702	7	2022-08-09 11:49:00	Available	Returned after use
12801	8	2021-07-04 06:00:00	In_Use	Bike in use
12802	8	2021-07-04 06:11:00	Available	Returned after use
12901	9	2022-07-27 01:00:00	In_Use	Bike in use
12902	9	2022-07-27 01:49:00	Available	Returned after use
13001	10	2021-12-24 03:00:00	In_Use	Bike in use
13002	10	2021-12-24 03:24:00	Available	Returned after use
13101	11	2021-03-22 05:00:00	In_Use	Bike in use
13102	11	2021-03-22 05:18:00	Available	Returned after use
13201	12	2022-12-16 05:00:00	In_Use	Bike in use
13202	12	2022-12-16 05:36:00	Available	Returned after use
13301	13	2021-12-13 06:00:00	In_Use	Bike in use
13302	13	2021-12-13 06:18:00	Available	Returned after use
13401	14	2021-11-20 10:00:00	In_Use	Bike in use
13402	14	2021-11-20 10:10:00	Available	Returned after use
13501	15	2021-03-04 05:00:00	In_Use	Bike in use
13502	15	2021-03-04 05:16:00	Available	Returned after use
13601	16	2022-02-17 01:00:00	In_Use	Bike in use
13602	16	2022-02-17 01:25:00	Available	Returned after use
13701	17	2022-07-29 08:00:00	In_Use	Bike in use
13702	17	2022-07-29 08:43:00	Available	Returned after use
13801	18	2021-03-31 04:00:00	In_Use	Bike in use
13802	18	2021-03-31 04:57:00	Available	Returned after use
13901	19	2022-06-12 11:00:00	In_Use	Bike in use
13902	19	2022-06-12 11:43:00	Available	Returned after use
14001	20	2022-02-09 03:00:00	In_Use	Bike in use
14002	20	2022-02-09 03:39:00	Available	Returned after use
14101	21	2021-08-10 09:00:00	In_Use	Bike in use
14102	21	2021-08-10 09:52:00	Available	Returned after use
14201	22	2022-03-08 11:00:00	In_Use	Bike in use
14202	22	2022-03-08 11:13:00	Available	Returned after use
14301	23	2022-10-03 05:00:00	In_Use	Bike in use
14302	23	2022-10-03 05:41:00	Available	Returned after use
14401	24	2022-09-22 06:00:00	In_Use	Bike in use
14402	24	2022-09-22 06:16:00	Available	Returned after use
14501	25	2022-02-08 03:00:00	In_Use	Bike in use
14502	25	2022-02-08 03:50:00	Available	Returned after use
14601	26	2022-05-26 02:00:00	In_Use	Bike in use
14602	26	2022-05-26 02:49:00	Available	Returned after use
14701	27	2021-06-25 00:00:00	In_Use	Bike in use
14702	27	2021-06-25 00:44:00	Available	Returned after use
14801	28	2022-06-22 06:00:00	In_Use	Bike in use
14802	28	2022-06-22 06:34:00	Available	Returned after use
14901	29	2022-01-06 08:00:00	In_Use	Bike in use
14902	29	2022-01-06 08:53:00	Available	Returned after use
15001	30	2021-09-27 07:00:00	In_Use	Bike in use
15002	30	2021-09-27 07:24:00	Available	Returned after use
15101	1	2021-11-25 11:00:00	In_Use	Bike in use
15102	1	2021-11-25 11:56:00	Available	Returned after use
15201	2	2021-10-22 10:00:00	In_Use	Bike in use
15202	2	2021-10-22 10:13:00	Available	Returned after use
15301	3	2022-10-28 07:00:00	In_Use	Bike in use
15302	3	2022-10-28 07:20:00	Available	Returned after use
15401	4	2021-12-27 02:00:00	In_Use	Bike in use
15402	4	2021-12-27 02:34:00	Available	Returned after use
15501	5	2021-06-13 02:00:00	In_Use	Bike in use
15502	5	2021-06-13 02:15:00	Available	Returned after use
15601	6	2022-01-02 11:00:00	In_Use	Bike in use
15602	6	2022-01-02 11:38:00	Available	Returned after use
15701	7	2022-08-09 06:00:00	In_Use	Bike in use
15702	7	2022-08-09 06:39:00	Available	Returned after use
15801	8	2021-07-04 02:00:00	In_Use	Bike in use
15802	8	2021-07-04 02:40:00	Available	Returned after use
15901	9	2022-07-27 05:00:00	In_Use	Bike in use
15902	9	2022-07-27 05:55:00	Available	Returned after use
16001	10	2021-12-24 05:00:00	In_Use	Bike in use
16002	10	2021-12-24 05:24:00	Available	Returned after use
16101	11	2021-03-22 06:00:00	In_Use	Bike in use
16102	11	2021-03-22 06:44:00	Available	Returned after use
16201	12	2022-12-16 04:00:00	In_Use	Bike in use
16202	12	2022-12-16 04:16:00	Available	Returned after use
16301	13	2021-12-13 07:00:00	In_Use	Bike in use
16302	13	2021-12-13 07:30:00	Available	Returned after use
16401	14	2021-11-20 01:00:00	In_Use	Bike in use
16402	14	2021-11-20 01:52:00	Available	Returned after use
16501	15	2021-03-04 03:00:00	In_Use	Bike in use
16502	15	2021-03-04 03:35:00	Available	Returned after use
16601	16	2022-02-17 08:00:00	In_Use	Bike in use
16602	16	2022-02-17 08:57:00	Available	Returned after use
16701	17	2022-07-29 10:00:00	In_Use	Bike in use
16702	17	2022-07-29 10:11:00	Available	Returned after use
16801	18	2021-03-31 10:00:00	In_Use	Bike in use
16802	18	2021-03-31 10:17:00	Available	Returned after use
16901	19	2022-06-12 00:00:00	In_Use	Bike in use
16902	19	2022-06-12 00:31:00	Available	Returned after use
17001	20	2022-02-09 10:00:00	In_Use	Bike in use
17002	20	2022-02-09 10:48:00	Available	Returned after use
17101	21	2021-08-10 08:00:00	In_Use	Bike in use
17102	21	2021-08-10 08:51:00	Available	Returned after use
17201	22	2022-03-08 08:00:00	In_Use	Bike in use
17202	22	2022-03-08 08:57:00	Available	Returned after use
17301	23	2022-10-03 02:00:00	In_Use	Bike in use
17302	23	2022-10-03 02:56:00	Available	Returned after use
17401	24	2022-09-22 09:00:00	In_Use	Bike in use
17402	24	2022-09-22 09:43:00	Available	Returned after use
17501	25	2022-02-08 00:00:00	In_Use	Bike in use
17502	25	2022-02-08 00:41:00	Available	Returned after use
17601	26	2022-05-26 03:00:00	In_Use	Bike in use
17602	26	2022-05-26 03:45:00	Available	Returned after use
17701	27	2021-06-25 02:00:00	In_Use	Bike in use
17702	27	2021-06-25 02:30:00	Available	Returned after use
17801	28	2022-06-22 02:00:00	In_Use	Bike in use
17802	28	2022-06-22 02:37:00	Available	Returned after use
17901	29	2022-01-06 00:00:00	In_Use	Bike in use
17902	29	2022-01-06 00:50:00	Available	Returned after use
18001	30	2021-09-27 06:00:00	In_Use	Bike in use
18002	30	2021-09-27 06:38:00	Available	Returned after use
18101	1	2021-11-25 11:00:00	In_Use	Bike in use
18102	1	2021-11-25 11:51:00	Available	Returned after use
18201	2	2021-10-22 09:00:00	In_Use	Bike in use
18202	2	2021-10-22 09:25:00	Available	Returned after use
18301	3	2022-10-28 03:00:00	In_Use	Bike in use
18302	3	2022-10-28 03:35:00	Available	Returned after use
18401	4	2021-12-27 06:00:00	In_Use	Bike in use
18402	4	2021-12-27 06:56:00	Available	Returned after use
18501	5	2021-06-13 00:00:00	In_Use	Bike in use
18502	5	2021-06-13 00:58:00	Available	Returned after use
18601	6	2022-01-02 06:00:00	In_Use	Bike in use
18602	6	2022-01-02 06:38:00	Available	Returned after use
18701	7	2022-08-09 01:00:00	In_Use	Bike in use
18702	7	2022-08-09 01:46:00	Available	Returned after use
18801	8	2021-07-04 03:00:00	In_Use	Bike in use
18802	8	2021-07-04 03:14:00	Available	Returned after use
18901	9	2022-07-27 02:00:00	In_Use	Bike in use
18902	9	2022-07-27 02:10:00	Available	Returned after use
19001	10	2021-12-24 11:00:00	In_Use	Bike in use
19002	10	2021-12-24 11:32:00	Available	Returned after use
19101	11	2021-03-22 10:00:00	In_Use	Bike in use
19102	11	2021-03-22 10:43:00	Available	Returned after use
19201	12	2022-12-16 05:00:00	In_Use	Bike in use
19202	12	2022-12-16 05:56:00	Available	Returned after use
19301	13	2021-12-13 00:00:00	In_Use	Bike in use
19302	13	2021-12-13 00:24:00	Available	Returned after use
19401	14	2021-11-20 07:00:00	In_Use	Bike in use
19402	14	2021-11-20 07:53:00	Available	Returned after use
19501	15	2021-03-04 11:00:00	In_Use	Bike in use
19502	15	2021-03-04 11:37:00	Available	Returned after use
19601	16	2022-02-17 01:00:00	In_Use	Bike in use
19602	16	2022-02-17 01:33:00	Available	Returned after use
19701	17	2022-07-29 02:00:00	In_Use	Bike in use
19702	17	2022-07-29 02:44:00	Available	Returned after use
19801	18	2021-03-31 01:00:00	In_Use	Bike in use
19802	18	2021-03-31 01:26:00	Available	Returned after use
19901	19	2022-06-12 02:00:00	In_Use	Bike in use
19902	19	2022-06-12 02:45:00	Available	Returned after use
20001	20	2022-02-09 11:00:00	In_Use	Bike in use
20002	20	2022-02-09 11:31:00	Available	Returned after use
20101	21	2021-08-10 04:00:00	In_Use	Bike in use
20102	21	2021-08-10 04:11:00	Available	Returned after use
20201	22	2022-03-08 06:00:00	In_Use	Bike in use
20202	22	2022-03-08 06:58:00	Available	Returned after use
20301	23	2022-10-03 09:00:00	In_Use	Bike in use
20302	23	2022-10-03 09:40:00	Available	Returned after use
20401	24	2022-09-22 05:00:00	In_Use	Bike in use
20402	24	2022-09-22 05:24:00	Available	Returned after use
20501	25	2022-02-08 06:00:00	In_Use	Bike in use
20502	25	2022-02-08 06:35:00	Available	Returned after use
20601	26	2022-05-26 11:00:00	In_Use	Bike in use
20602	26	2022-05-26 11:40:00	Available	Returned after use
20701	27	2021-06-25 11:00:00	In_Use	Bike in use
20702	27	2021-06-25 11:11:00	Available	Returned after use
20801	28	2022-06-22 06:00:00	In_Use	Bike in use
20802	28	2022-06-22 06:11:00	Available	Returned after use
20901	29	2022-01-06 07:00:00	In_Use	Bike in use
20902	29	2022-01-06 07:59:00	Available	Returned after use
21001	30	2021-09-27 04:00:00	In_Use	Bike in use
21002	30	2021-09-27 04:17:00	Available	Returned after use
21101	1	2021-11-25 03:00:00	In_Use	Bike in use
21102	1	2021-11-25 03:56:00	Available	Returned after use
21201	2	2021-10-22 02:00:00	In_Use	Bike in use
21202	2	2021-10-22 02:10:00	Available	Returned after use
21301	3	2022-10-28 08:00:00	In_Use	Bike in use
21302	3	2022-10-28 08:19:00	Available	Returned after use
21401	4	2021-12-27 00:00:00	In_Use	Bike in use
21402	4	2021-12-27 00:18:00	Available	Returned after use
21501	5	2021-06-13 00:00:00	In_Use	Bike in use
21502	5	2021-06-13 00:52:00	Available	Returned after use
21601	6	2022-01-02 01:00:00	In_Use	Bike in use
21602	6	2022-01-02 01:11:00	Available	Returned after use
21701	7	2022-08-09 01:00:00	In_Use	Bike in use
21702	7	2022-08-09 01:22:00	Available	Returned after use
21801	8	2021-07-04 09:00:00	In_Use	Bike in use
21802	8	2021-07-04 09:41:00	Available	Returned after use
21901	9	2022-07-27 08:00:00	In_Use	Bike in use
21902	9	2022-07-27 08:49:00	Available	Returned after use
22001	10	2021-12-24 00:00:00	In_Use	Bike in use
22002	10	2021-12-24 00:12:00	Available	Returned after use
22101	11	2021-03-22 08:00:00	In_Use	Bike in use
22102	11	2021-03-22 08:40:00	Available	Returned after use
22201	12	2022-12-16 11:00:00	In_Use	Bike in use
22202	12	2022-12-16 11:53:00	Available	Returned after use
22301	13	2021-12-13 08:00:00	In_Use	Bike in use
22302	13	2021-12-13 08:28:00	Available	Returned after use
22401	14	2021-11-20 11:00:00	In_Use	Bike in use
22402	14	2021-11-20 11:25:00	Available	Returned after use
22501	15	2021-03-04 04:00:00	In_Use	Bike in use
22502	15	2021-03-04 04:53:00	Available	Returned after use
22601	16	2022-02-17 07:00:00	In_Use	Bike in use
22602	16	2022-02-17 07:49:00	Available	Returned after use
22701	17	2022-07-29 07:00:00	In_Use	Bike in use
22702	17	2022-07-29 07:19:00	Available	Returned after use
22801	18	2021-03-31 10:00:00	In_Use	Bike in use
22802	18	2021-03-31 10:12:00	Available	Returned after use
22901	19	2022-06-12 04:00:00	In_Use	Bike in use
22902	19	2022-06-12 04:20:00	Available	Returned after use
23001	20	2022-02-09 06:00:00	In_Use	Bike in use
23002	20	2022-02-09 06:25:00	Available	Returned after use
23101	21	2021-08-10 03:00:00	In_Use	Bike in use
23102	21	2021-08-10 03:49:00	Available	Returned after use
23201	22	2022-03-08 07:00:00	In_Use	Bike in use
23202	22	2022-03-08 07:14:00	Available	Returned after use
23301	23	2022-10-03 02:00:00	In_Use	Bike in use
23302	23	2022-10-03 02:11:00	Available	Returned after use
23401	24	2022-09-22 04:00:00	In_Use	Bike in use
23402	24	2022-09-22 04:50:00	Available	Returned after use
23501	25	2022-02-08 03:00:00	In_Use	Bike in use
23502	25	2022-02-08 03:24:00	Available	Returned after use
23601	26	2022-05-26 09:00:00	In_Use	Bike in use
23602	26	2022-05-26 09:25:00	Available	Returned after use
23701	27	2021-06-25 11:00:00	In_Use	Bike in use
23702	27	2021-06-25 11:59:00	Available	Returned after use
23801	28	2022-06-22 02:00:00	In_Use	Bike in use
23802	28	2022-06-22 02:28:00	Available	Returned after use
23901	29	2022-01-06 00:00:00	In_Use	Bike in use
23902	29	2022-01-06 00:59:00	Available	Returned after use
24001	30	2021-09-27 10:00:00	In_Use	Bike in use
24002	30	2021-09-27 10:22:00	Available	Returned after use
24101	1	2021-11-25 02:00:00	In_Use	Bike in use
24102	1	2021-11-25 02:27:00	Available	Returned after use
24201	2	2021-10-22 00:00:00	In_Use	Bike in use
24202	2	2021-10-22 00:47:00	Available	Returned after use
24301	3	2022-10-28 02:00:00	In_Use	Bike in use
24302	3	2022-10-28 02:20:00	Available	Returned after use
24401	4	2021-12-27 03:00:00	In_Use	Bike in use
24402	4	2021-12-27 03:20:00	Available	Returned after use
24501	5	2021-06-13 11:00:00	In_Use	Bike in use
24502	5	2021-06-13 11:12:00	Available	Returned after use
24601	6	2022-01-02 01:00:00	In_Use	Bike in use
24602	6	2022-01-02 01:10:00	Available	Returned after use
24701	7	2022-08-09 02:00:00	In_Use	Bike in use
24702	7	2022-08-09 02:10:00	Available	Returned after use
24801	8	2021-07-04 11:00:00	In_Use	Bike in use
24802	8	2021-07-04 11:22:00	Available	Returned after use
24901	9	2022-07-27 04:00:00	In_Use	Bike in use
24902	9	2022-07-27 04:42:00	Available	Returned after use
25001	10	2021-12-24 05:00:00	In_Use	Bike in use
25002	10	2021-12-24 05:42:00	Available	Returned after use
25101	11	2021-03-22 11:00:00	In_Use	Bike in use
25102	11	2021-03-22 11:44:00	Available	Returned after use
25201	12	2022-12-16 03:00:00	In_Use	Bike in use
25202	12	2022-12-16 03:26:00	Available	Returned after use
25301	13	2021-12-13 04:00:00	In_Use	Bike in use
25302	13	2021-12-13 04:33:00	Available	Returned after use
25401	14	2021-11-20 10:00:00	In_Use	Bike in use
25402	14	2021-11-20 10:32:00	Available	Returned after use
25501	15	2021-03-04 07:00:00	In_Use	Bike in use
25502	15	2021-03-04 07:47:00	Available	Returned after use
25601	16	2022-02-17 00:00:00	In_Use	Bike in use
25602	16	2022-02-17 00:28:00	Available	Returned after use
25701	17	2022-07-29 10:00:00	In_Use	Bike in use
25702	17	2022-07-29 10:51:00	Available	Returned after use
25801	18	2021-03-31 08:00:00	In_Use	Bike in use
25802	18	2021-03-31 08:19:00	Available	Returned after use
25901	19	2022-06-12 08:00:00	In_Use	Bike in use
25902	19	2022-06-12 08:47:00	Available	Returned after use
26001	20	2022-02-09 03:00:00	In_Use	Bike in use
26002	20	2022-02-09 03:19:00	Available	Returned after use
26101	21	2021-08-10 00:00:00	In_Use	Bike in use
26102	21	2021-08-10 00:22:00	Available	Returned after use
26201	22	2022-03-08 08:00:00	In_Use	Bike in use
26202	22	2022-03-08 08:55:00	Available	Returned after use
26301	23	2022-10-03 09:00:00	In_Use	Bike in use
26302	23	2022-10-03 09:17:00	Available	Returned after use
26401	24	2022-09-22 09:00:00	In_Use	Bike in use
26402	24	2022-09-22 09:26:00	Available	Returned after use
26501	25	2022-02-08 11:00:00	In_Use	Bike in use
26502	25	2022-02-08 11:13:00	Available	Returned after use
26601	26	2022-05-26 04:00:00	In_Use	Bike in use
26602	26	2022-05-26 04:44:00	Available	Returned after use
26701	27	2021-06-25 09:00:00	In_Use	Bike in use
26702	27	2021-06-25 09:28:00	Available	Returned after use
26801	28	2022-06-22 07:00:00	In_Use	Bike in use
26802	28	2022-06-22 07:23:00	Available	Returned after use
26901	29	2022-01-06 01:00:00	In_Use	Bike in use
26902	29	2022-01-06 01:40:00	Available	Returned after use
27001	30	2021-09-27 01:00:00	In_Use	Bike in use
27002	30	2021-09-27 01:18:00	Available	Returned after use
27101	1	2022-02-01 10:00:00	In_Use	Bike in use
27102	1	2022-02-01 10:19:00	Available	Returned after use
27201	2	2022-02-01 11:00:00	In_Use	Bike in use
27202	2	2022-02-01 11:29:00	Available	Returned after use
27301	3	2022-10-28 06:00:00	In_Use	Bike in use
27302	3	2022-10-28 06:27:00	Available	Returned after use
27401	4	2022-02-01 09:00:00	In_Use	Bike in use
27402	4	2022-02-01 09:40:00	Available	Returned after use
27501	5	2022-02-01 00:00:00	In_Use	Bike in use
27502	5	2022-02-01 00:57:00	Available	Returned after use
27601	6	2022-02-01 01:00:00	In_Use	Bike in use
27602	6	2022-02-01 01:46:00	Available	Returned after use
27701	7	2022-08-09 11:00:00	In_Use	Bike in use
27702	7	2022-08-09 11:48:00	Available	Returned after use
27801	8	2022-02-01 11:00:00	In_Use	Bike in use
27802	8	2022-02-01 11:47:00	Available	Returned after use
27901	9	2022-07-27 08:00:00	In_Use	Bike in use
27902	9	2022-07-27 08:45:00	Available	Returned after use
28001	10	2022-02-01 04:00:00	In_Use	Bike in use
28002	10	2022-02-01 04:18:00	Available	Returned after use
28101	11	2022-02-01 09:00:00	In_Use	Bike in use
28102	11	2022-02-01 09:56:00	Available	Returned after use
28201	12	2022-12-16 10:00:00	In_Use	Bike in use
28202	12	2022-12-16 10:13:00	Available	Returned after use
28301	13	2022-02-01 01:00:00	In_Use	Bike in use
28302	13	2022-02-01 01:47:00	Available	Returned after use
28401	14	2022-02-01 11:00:00	In_Use	Bike in use
28402	14	2022-02-01 11:21:00	Available	Returned after use
28501	15	2022-02-01 01:00:00	In_Use	Bike in use
28502	15	2022-02-01 01:30:00	Available	Returned after use
28601	16	2022-02-17 10:00:00	In_Use	Bike in use
28602	16	2022-02-17 10:13:00	Available	Returned after use
28701	17	2022-07-29 10:00:00	In_Use	Bike in use
28702	17	2022-07-29 10:48:00	Available	Returned after use
28801	18	2022-02-01 04:00:00	In_Use	Bike in use
28802	18	2022-02-01 04:28:00	Available	Returned after use
28901	19	2022-06-12 08:00:00	In_Use	Bike in use
28902	19	2022-06-12 08:13:00	Available	Returned after use
29001	20	2022-02-09 11:00:00	In_Use	Bike in use
29002	20	2022-02-09 11:27:00	Available	Returned after use
29101	21	2022-02-01 11:00:00	In_Use	Bike in use
29102	21	2022-02-01 11:59:00	Available	Returned after use
29201	22	2022-03-08 11:00:00	In_Use	Bike in use
29202	22	2022-03-08 11:59:00	Available	Returned after use
29301	23	2022-10-03 00:00:00	In_Use	Bike in use
29302	23	2022-10-03 00:13:00	Available	Returned after use
29401	24	2022-09-22 06:00:00	In_Use	Bike in use
29402	24	2022-09-22 06:26:00	Available	Returned after use
29501	25	2022-02-08 00:00:00	In_Use	Bike in use
29502	25	2022-02-08 00:37:00	Available	Returned after use
29601	26	2022-05-26 00:00:00	In_Use	Bike in use
29602	26	2022-05-26 00:27:00	Available	Returned after use
29701	27	2022-02-01 05:00:00	In_Use	Bike in use
29702	27	2022-02-01 05:59:00	Available	Returned after use
29801	28	2022-06-22 07:00:00	In_Use	Bike in use
29802	28	2022-06-22 07:46:00	Available	Returned after use
29901	29	2022-02-01 06:00:00	In_Use	Bike in use
29902	29	2022-02-01 06:58:00	Available	Returned after use
30001	30	2022-02-01 03:00:00	In_Use	Bike in use
30002	30	2022-02-01 03:38:00	Available	Returned after use
30101	1	2021-11-25 09:00:00	In_Use	Bike in use
30102	1	2021-11-25 09:50:00	Available	Returned after use
30201	2	2021-10-22 09:00:00	In_Use	Bike in use
30202	2	2021-10-22 09:51:00	Available	Returned after use
30301	3	2022-10-28 04:00:00	In_Use	Bike in use
30302	3	2022-10-28 04:17:00	Available	Returned after use
30401	4	2021-12-27 03:00:00	In_Use	Bike in use
30402	4	2021-12-27 03:53:00	Available	Returned after use
30501	5	2021-06-13 05:00:00	In_Use	Bike in use
30502	5	2021-06-13 05:27:00	Available	Returned after use
30601	6	2022-01-02 02:00:00	In_Use	Bike in use
30602	6	2022-01-02 02:46:00	Available	Returned after use
30701	7	2022-08-09 09:00:00	In_Use	Bike in use
30702	7	2022-08-09 09:42:00	Available	Returned after use
30801	8	2021-07-04 01:00:00	In_Use	Bike in use
30802	8	2021-07-04 01:46:00	Available	Returned after use
30901	9	2022-07-27 02:00:00	In_Use	Bike in use
30902	9	2022-07-27 02:17:00	Available	Returned after use
31001	10	2021-12-24 09:00:00	In_Use	Bike in use
31002	10	2021-12-24 09:27:00	Available	Returned after use
31101	11	2021-03-22 03:00:00	In_Use	Bike in use
31102	11	2021-03-22 03:21:00	Available	Returned after use
31201	12	2022-12-16 07:00:00	In_Use	Bike in use
31202	12	2022-12-16 07:20:00	Available	Returned after use
31301	13	2021-12-13 04:00:00	In_Use	Bike in use
31302	13	2021-12-13 04:11:00	Available	Returned after use
31401	14	2021-11-20 07:00:00	In_Use	Bike in use
31402	14	2021-11-20 07:44:00	Available	Returned after use
31501	15	2021-03-04 02:00:00	In_Use	Bike in use
31502	15	2021-03-04 02:22:00	Available	Returned after use
31601	16	2022-02-17 06:00:00	In_Use	Bike in use
31602	16	2022-02-17 06:46:00	Available	Returned after use
31701	17	2022-07-29 08:00:00	In_Use	Bike in use
31702	17	2022-07-29 08:27:00	Available	Returned after use
31801	18	2021-03-31 01:00:00	In_Use	Bike in use
31802	18	2021-03-31 01:18:00	Available	Returned after use
31901	19	2022-06-12 00:00:00	In_Use	Bike in use
31902	19	2022-06-12 00:36:00	Available	Returned after use
32001	20	2022-02-09 06:00:00	In_Use	Bike in use
32002	20	2022-02-09 06:59:00	Available	Returned after use
32101	21	2021-08-10 08:00:00	In_Use	Bike in use
32102	21	2021-08-10 08:23:00	Available	Returned after use
32201	22	2022-03-08 04:00:00	In_Use	Bike in use
32202	22	2022-03-08 04:45:00	Available	Returned after use
32301	23	2022-10-03 07:00:00	In_Use	Bike in use
32302	23	2022-10-03 07:48:00	Available	Returned after use
32401	24	2022-09-22 06:00:00	In_Use	Bike in use
32402	24	2022-09-22 06:17:00	Available	Returned after use
32501	25	2022-02-08 05:00:00	In_Use	Bike in use
32502	25	2022-02-08 05:13:00	Available	Returned after use
32601	26	2022-05-26 06:00:00	In_Use	Bike in use
32602	26	2022-05-26 06:26:00	Available	Returned after use
32701	27	2021-06-25 08:00:00	In_Use	Bike in use
32702	27	2021-06-25 08:12:00	Available	Returned after use
32801	28	2022-06-22 09:00:00	In_Use	Bike in use
32802	28	2022-06-22 09:45:00	Available	Returned after use
32901	29	2022-01-06 07:00:00	In_Use	Bike in use
32902	29	2022-01-06 07:45:00	Available	Returned after use
33001	30	2021-09-27 01:00:00	In_Use	Bike in use
33002	30	2021-09-27 01:57:00	Available	Returned after use
33101	1	2021-11-25 07:00:00	In_Use	Bike in use
33102	1	2021-11-25 07:54:00	Available	Returned after use
33201	2	2021-10-22 06:00:00	In_Use	Bike in use
33202	2	2021-10-22 06:43:00	Available	Returned after use
33301	3	2022-10-28 08:00:00	In_Use	Bike in use
33302	3	2022-10-28 08:14:00	Available	Returned after use
33401	4	2021-12-27 04:00:00	In_Use	Bike in use
33402	4	2021-12-27 04:53:00	Available	Returned after use
33501	5	2021-06-13 05:00:00	In_Use	Bike in use
33502	5	2021-06-13 05:43:00	Available	Returned after use
33601	6	2022-01-02 07:00:00	In_Use	Bike in use
33602	6	2022-01-02 07:31:00	Available	Returned after use
33701	7	2022-08-09 01:00:00	In_Use	Bike in use
33702	7	2022-08-09 01:36:00	Available	Returned after use
33801	8	2021-07-04 08:00:00	In_Use	Bike in use
33802	8	2021-07-04 08:24:00	Available	Returned after use
33901	9	2022-07-27 05:00:00	In_Use	Bike in use
33902	9	2022-07-27 05:29:00	Available	Returned after use
34001	10	2021-12-24 05:00:00	In_Use	Bike in use
34002	10	2021-12-24 05:39:00	Available	Returned after use
34101	11	2021-03-22 01:00:00	In_Use	Bike in use
34102	11	2021-03-22 01:15:00	Available	Returned after use
34201	12	2022-12-16 07:00:00	In_Use	Bike in use
34202	12	2022-12-16 07:43:00	Available	Returned after use
34301	13	2021-12-13 08:00:00	In_Use	Bike in use
34302	13	2021-12-13 08:14:00	Available	Returned after use
34401	14	2021-11-20 09:00:00	In_Use	Bike in use
34402	14	2021-11-20 09:19:00	Available	Returned after use
34501	15	2021-03-04 05:00:00	In_Use	Bike in use
34502	15	2021-03-04 05:37:00	Available	Returned after use
34601	16	2022-02-17 05:00:00	In_Use	Bike in use
34602	16	2022-02-17 05:17:00	Available	Returned after use
34701	17	2022-07-29 04:00:00	In_Use	Bike in use
34702	17	2022-07-29 04:29:00	Available	Returned after use
34801	18	2021-03-31 02:00:00	In_Use	Bike in use
34802	18	2021-03-31 02:32:00	Available	Returned after use
34901	19	2022-06-12 06:00:00	In_Use	Bike in use
34902	19	2022-06-12 06:16:00	Available	Returned after use
35001	20	2022-02-09 06:00:00	In_Use	Bike in use
35002	20	2022-02-09 06:48:00	Available	Returned after use
35101	21	2021-08-10 08:00:00	In_Use	Bike in use
35102	21	2021-08-10 08:36:00	Available	Returned after use
35201	22	2022-03-08 02:00:00	In_Use	Bike in use
35202	22	2022-03-08 02:43:00	Available	Returned after use
35301	23	2022-10-03 11:00:00	In_Use	Bike in use
35302	23	2022-10-03 11:24:00	Available	Returned after use
35401	24	2022-09-22 01:00:00	In_Use	Bike in use
35402	24	2022-09-22 01:48:00	Available	Returned after use
35501	25	2022-02-08 06:00:00	In_Use	Bike in use
35502	25	2022-02-08 06:39:00	Available	Returned after use
35601	26	2022-05-26 03:00:00	In_Use	Bike in use
35602	26	2022-05-26 03:10:00	Available	Returned after use
35701	27	2021-06-25 02:00:00	In_Use	Bike in use
35702	27	2021-06-25 02:16:00	Available	Returned after use
35801	28	2022-06-22 02:00:00	In_Use	Bike in use
35802	28	2022-06-22 02:37:00	Available	Returned after use
35901	29	2022-01-06 01:00:00	In_Use	Bike in use
35902	29	2022-01-06 01:36:00	Available	Returned after use
36001	30	2021-09-27 00:00:00	In_Use	Bike in use
36002	30	2021-09-27 00:15:00	Available	Returned after use
36101	1	2021-11-25 10:00:00	In_Use	Bike in use
36102	1	2021-11-25 10:16:00	Available	Returned after use
36201	2	2021-11-11 05:00:00	In_Use	Bike in use
36202	2	2021-11-11 05:58:00	Available	Returned after use
36301	3	2022-10-28 06:00:00	In_Use	Bike in use
36302	3	2022-10-28 06:47:00	Available	Returned after use
36401	4	2021-12-27 03:00:00	In_Use	Bike in use
36402	4	2021-12-27 03:59:00	Available	Returned after use
36501	5	2021-11-11 09:00:00	In_Use	Bike in use
36502	5	2021-11-11 09:18:00	Available	Returned after use
36601	6	2022-01-02 09:00:00	In_Use	Bike in use
36602	6	2022-01-02 09:32:00	Available	Returned after use
36701	7	2022-08-09 01:00:00	In_Use	Bike in use
36702	7	2022-08-09 01:47:00	Available	Returned after use
36801	8	2021-11-11 03:00:00	In_Use	Bike in use
36802	8	2021-11-11 03:49:00	Available	Returned after use
36901	9	2022-07-27 01:00:00	In_Use	Bike in use
36902	9	2022-07-27 01:29:00	Available	Returned after use
37001	10	2021-12-24 07:00:00	In_Use	Bike in use
37002	10	2021-12-24 07:51:00	Available	Returned after use
37101	11	2021-11-11 11:00:00	In_Use	Bike in use
37102	11	2021-11-11 11:34:00	Available	Returned after use
37201	12	2022-12-16 06:00:00	In_Use	Bike in use
37202	12	2022-12-16 06:11:00	Available	Returned after use
37301	13	2021-12-13 11:00:00	In_Use	Bike in use
37302	13	2021-12-13 11:25:00	Available	Returned after use
37401	14	2021-11-20 06:00:00	In_Use	Bike in use
37402	14	2021-11-20 06:57:00	Available	Returned after use
37501	15	2021-11-11 10:00:00	In_Use	Bike in use
37502	15	2021-11-11 10:18:00	Available	Returned after use
37601	16	2022-02-17 07:00:00	In_Use	Bike in use
37602	16	2022-02-17 07:56:00	Available	Returned after use
37701	17	2022-07-29 00:00:00	In_Use	Bike in use
37702	17	2022-07-29 00:46:00	Available	Returned after use
37801	18	2021-11-11 03:00:00	In_Use	Bike in use
37802	18	2021-11-11 03:31:00	Available	Returned after use
37901	19	2022-06-12 07:00:00	In_Use	Bike in use
37902	19	2022-06-12 07:30:00	Available	Returned after use
38001	20	2022-02-09 10:00:00	In_Use	Bike in use
38002	20	2022-02-09 10:43:00	Available	Returned after use
38101	21	2021-11-11 01:00:00	In_Use	Bike in use
38102	21	2021-11-11 01:29:00	Available	Returned after use
38201	22	2022-03-08 08:00:00	In_Use	Bike in use
38202	22	2022-03-08 08:36:00	Available	Returned after use
38301	23	2022-10-03 08:00:00	In_Use	Bike in use
38302	23	2022-10-03 08:25:00	Available	Returned after use
38401	24	2022-09-22 07:00:00	In_Use	Bike in use
38402	24	2022-09-22 07:19:00	Available	Returned after use
38501	25	2022-02-08 00:00:00	In_Use	Bike in use
38502	25	2022-02-08 00:41:00	Available	Returned after use
38601	26	2022-05-26 07:00:00	In_Use	Bike in use
38602	26	2022-05-26 07:53:00	Available	Returned after use
38701	27	2021-11-11 04:00:00	In_Use	Bike in use
38702	27	2021-11-11 04:36:00	Available	Returned after use
38801	28	2022-06-22 10:00:00	In_Use	Bike in use
38802	28	2022-06-22 10:54:00	Available	Returned after use
38901	29	2022-01-06 11:00:00	In_Use	Bike in use
38902	29	2022-01-06 11:33:00	Available	Returned after use
39001	30	2021-11-11 02:00:00	In_Use	Bike in use
39002	30	2021-11-11 02:54:00	Available	Returned after use
39101	1	2021-11-25 05:00:00	In_Use	Bike in use
39102	1	2021-11-25 05:52:00	Available	Returned after use
39201	2	2021-10-22 06:00:00	In_Use	Bike in use
39202	2	2021-10-22 06:59:00	Available	Returned after use
39301	3	2022-10-28 01:00:00	In_Use	Bike in use
39302	3	2022-10-28 01:19:00	Available	Returned after use
39401	4	2021-12-27 01:00:00	In_Use	Bike in use
39402	4	2021-12-27 01:49:00	Available	Returned after use
39501	5	2021-06-13 01:00:00	In_Use	Bike in use
39502	5	2021-06-13 01:29:00	Available	Returned after use
39601	6	2022-01-02 02:00:00	In_Use	Bike in use
39602	6	2022-01-02 02:10:00	Available	Returned after use
39701	7	2022-08-09 08:00:00	In_Use	Bike in use
39702	7	2022-08-09 08:12:00	Available	Returned after use
39801	8	2021-07-04 01:00:00	In_Use	Bike in use
39802	8	2021-07-04 01:11:00	Available	Returned after use
39901	9	2022-07-27 10:00:00	In_Use	Bike in use
39902	9	2022-07-27 10:19:00	Available	Returned after use
40001	10	2021-12-24 03:00:00	In_Use	Bike in use
40002	10	2021-12-24 03:52:00	Available	Returned after use
40101	11	2021-03-22 09:00:00	In_Use	Bike in use
40102	11	2021-03-22 09:23:00	Available	Returned after use
40201	12	2022-12-16 07:00:00	In_Use	Bike in use
40202	12	2022-12-16 07:32:00	Available	Returned after use
40301	13	2021-12-13 08:00:00	In_Use	Bike in use
40302	13	2021-12-13 08:55:00	Available	Returned after use
40401	14	2021-11-20 11:00:00	In_Use	Bike in use
40402	14	2021-11-20 11:14:00	Available	Returned after use
40501	15	2021-03-04 00:00:00	In_Use	Bike in use
40502	15	2021-03-04 00:13:00	Available	Returned after use
40601	16	2022-02-17 01:00:00	In_Use	Bike in use
40602	16	2022-02-17 01:38:00	Available	Returned after use
40701	17	2022-07-29 07:00:00	In_Use	Bike in use
40702	17	2022-07-29 07:28:00	Available	Returned after use
40801	18	2021-03-31 06:00:00	In_Use	Bike in use
40802	18	2021-03-31 06:12:00	Available	Returned after use
40901	19	2022-06-12 04:00:00	In_Use	Bike in use
40902	19	2022-06-12 04:53:00	Available	Returned after use
41001	20	2022-02-09 10:00:00	In_Use	Bike in use
41002	20	2022-02-09 10:11:00	Available	Returned after use
41101	21	2021-08-10 04:00:00	In_Use	Bike in use
41102	21	2021-08-10 04:50:00	Available	Returned after use
41201	22	2022-03-08 01:00:00	In_Use	Bike in use
41202	22	2022-03-08 01:19:00	Available	Returned after use
41301	23	2022-10-03 05:00:00	In_Use	Bike in use
41302	23	2022-10-03 05:25:00	Available	Returned after use
41401	24	2022-09-22 01:00:00	In_Use	Bike in use
41402	24	2022-09-22 01:23:00	Available	Returned after use
41501	25	2022-02-08 03:00:00	In_Use	Bike in use
41502	25	2022-02-08 03:45:00	Available	Returned after use
41601	26	2022-05-26 07:00:00	In_Use	Bike in use
41602	26	2022-05-26 07:48:00	Available	Returned after use
41701	27	2021-06-25 10:00:00	In_Use	Bike in use
41702	27	2021-06-25 10:49:00	Available	Returned after use
41801	28	2022-06-22 02:00:00	In_Use	Bike in use
41802	28	2022-06-22 02:53:00	Available	Returned after use
41901	29	2022-01-06 00:00:00	In_Use	Bike in use
41902	29	2022-01-06 00:41:00	Available	Returned after use
42001	30	2021-09-27 03:00:00	In_Use	Bike in use
42002	30	2021-09-27 03:38:00	Available	Returned after use
42101	1	2021-11-25 11:00:00	In_Use	Bike in use
42102	1	2021-11-25 11:46:00	Available	Returned after use
42201	2	2021-10-22 03:00:00	In_Use	Bike in use
42202	2	2021-10-22 03:24:00	Available	Returned after use
42301	3	2022-10-28 11:00:00	In_Use	Bike in use
42302	3	2022-10-28 11:44:00	Available	Returned after use
42401	4	2021-12-27 01:00:00	In_Use	Bike in use
42402	4	2021-12-27 01:29:00	Available	Returned after use
42501	5	2021-06-13 08:00:00	In_Use	Bike in use
42502	5	2021-06-13 08:27:00	Available	Returned after use
42601	6	2022-01-02 09:00:00	In_Use	Bike in use
42602	6	2022-01-02 09:33:00	Available	Returned after use
42701	7	2022-08-09 06:00:00	In_Use	Bike in use
42702	7	2022-08-09 06:35:00	Available	Returned after use
42801	8	2021-07-04 05:00:00	In_Use	Bike in use
42802	8	2021-07-04 05:35:00	Available	Returned after use
42901	9	2022-07-27 10:00:00	In_Use	Bike in use
42902	9	2022-07-27 10:12:00	Available	Returned after use
43001	10	2021-12-24 08:00:00	In_Use	Bike in use
43002	10	2021-12-24 08:23:00	Available	Returned after use
43101	11	2021-03-22 09:00:00	In_Use	Bike in use
43102	11	2021-03-22 09:47:00	Available	Returned after use
43201	12	2022-12-16 02:00:00	In_Use	Bike in use
43202	12	2022-12-16 02:43:00	Available	Returned after use
43301	13	2021-12-13 06:00:00	In_Use	Bike in use
43302	13	2021-12-13 06:21:00	Available	Returned after use
43401	14	2021-11-20 09:00:00	In_Use	Bike in use
43402	14	2021-11-20 09:36:00	Available	Returned after use
43501	15	2021-03-04 09:00:00	In_Use	Bike in use
43502	15	2021-03-04 09:28:00	Available	Returned after use
43601	16	2022-02-17 10:00:00	In_Use	Bike in use
43602	16	2022-02-17 10:35:00	Available	Returned after use
43701	17	2022-07-29 06:00:00	In_Use	Bike in use
43702	17	2022-07-29 06:13:00	Available	Returned after use
43801	18	2021-03-31 06:00:00	In_Use	Bike in use
43802	18	2021-03-31 06:51:00	Available	Returned after use
43901	19	2022-06-12 00:00:00	In_Use	Bike in use
43902	19	2022-06-12 00:25:00	Available	Returned after use
44001	20	2022-02-09 10:00:00	In_Use	Bike in use
44002	20	2022-02-09 10:30:00	Available	Returned after use
44101	21	2021-08-10 05:00:00	In_Use	Bike in use
44102	21	2021-08-10 05:36:00	Available	Returned after use
44201	22	2022-03-08 00:00:00	In_Use	Bike in use
44202	22	2022-03-08 00:31:00	Available	Returned after use
44301	23	2022-10-03 04:00:00	In_Use	Bike in use
44302	23	2022-10-03 04:20:00	Available	Returned after use
44401	24	2022-09-22 06:00:00	In_Use	Bike in use
44402	24	2022-09-22 06:55:00	Available	Returned after use
44501	25	2022-02-08 01:00:00	In_Use	Bike in use
44502	25	2022-02-08 01:37:00	Available	Returned after use
44601	26	2022-05-26 02:00:00	In_Use	Bike in use
44602	26	2022-05-26 02:45:00	Available	Returned after use
44701	27	2021-06-25 10:00:00	In_Use	Bike in use
44702	27	2021-06-25 10:47:00	Available	Returned after use
44801	28	2022-06-22 08:00:00	In_Use	Bike in use
44802	28	2022-06-22 08:11:00	Available	Returned after use
44901	29	2022-01-06 10:00:00	In_Use	Bike in use
44902	29	2022-01-06 10:48:00	Available	Returned after use
45001	30	2021-09-27 01:00:00	In_Use	Bike in use
45002	30	2021-09-27 01:18:00	Available	Returned after use
45101	1	2021-11-25 10:00:00	In_Use	Bike in use
45102	1	2021-11-25 10:34:00	Available	Returned after use
45201	2	2021-10-22 09:00:00	In_Use	Bike in use
45202	2	2021-10-22 09:29:00	Available	Returned after use
45301	3	2022-10-28 11:00:00	In_Use	Bike in use
45302	3	2022-10-28 11:45:00	Available	Returned after use
45401	4	2021-12-27 02:00:00	In_Use	Bike in use
45402	4	2021-12-27 02:32:00	Available	Returned after use
45501	5	2021-06-13 01:00:00	In_Use	Bike in use
45502	5	2021-06-13 01:28:00	Available	Returned after use
45601	6	2022-01-02 10:00:00	In_Use	Bike in use
45602	6	2022-01-02 10:27:00	Available	Returned after use
45701	7	2022-08-09 09:00:00	In_Use	Bike in use
45702	7	2022-08-09 09:58:00	Available	Returned after use
45801	8	2021-07-04 05:00:00	In_Use	Bike in use
45802	8	2021-07-04 05:28:00	Available	Returned after use
45901	9	2022-07-27 10:00:00	In_Use	Bike in use
45902	9	2022-07-27 10:29:00	Available	Returned after use
46001	10	2021-12-24 02:00:00	In_Use	Bike in use
46002	10	2021-12-24 02:33:00	Available	Returned after use
46101	11	2021-03-22 11:00:00	In_Use	Bike in use
46102	11	2021-03-22 11:16:00	Available	Returned after use
46201	12	2022-12-16 03:00:00	In_Use	Bike in use
46202	12	2022-12-16 03:52:00	Available	Returned after use
46301	13	2021-12-13 03:00:00	In_Use	Bike in use
46302	13	2021-12-13 03:50:00	Available	Returned after use
46401	14	2021-11-20 11:00:00	In_Use	Bike in use
46402	14	2021-11-20 11:25:00	Available	Returned after use
46501	15	2021-03-04 02:00:00	In_Use	Bike in use
46502	15	2021-03-04 02:16:00	Available	Returned after use
46601	16	2022-02-17 06:00:00	In_Use	Bike in use
46602	16	2022-02-17 06:57:00	Available	Returned after use
46701	17	2022-07-29 03:00:00	In_Use	Bike in use
46702	17	2022-07-29 03:22:00	Available	Returned after use
46801	18	2021-03-31 02:00:00	In_Use	Bike in use
46802	18	2021-03-31 02:43:00	Available	Returned after use
46901	19	2022-06-12 00:00:00	In_Use	Bike in use
46902	19	2022-06-12 00:38:00	Available	Returned after use
47001	20	2022-02-09 11:00:00	In_Use	Bike in use
47002	20	2022-02-09 11:43:00	Available	Returned after use
47101	21	2021-08-10 03:00:00	In_Use	Bike in use
47102	21	2021-08-10 03:59:00	Available	Returned after use
47201	22	2022-03-08 01:00:00	In_Use	Bike in use
47202	22	2022-03-08 01:32:00	Available	Returned after use
47301	23	2022-10-03 08:00:00	In_Use	Bike in use
47302	23	2022-10-03 08:45:00	Available	Returned after use
47401	24	2022-09-22 03:00:00	In_Use	Bike in use
47402	24	2022-09-22 03:36:00	Available	Returned after use
47501	25	2022-02-08 00:00:00	In_Use	Bike in use
47502	25	2022-02-08 00:36:00	Available	Returned after use
47601	26	2022-05-26 02:00:00	In_Use	Bike in use
47602	26	2022-05-26 02:48:00	Available	Returned after use
47701	27	2021-06-25 11:00:00	In_Use	Bike in use
47702	27	2021-06-25 11:19:00	Available	Returned after use
47801	28	2022-06-22 09:00:00	In_Use	Bike in use
47802	28	2022-06-22 09:39:00	Available	Returned after use
47901	29	2022-01-06 05:00:00	In_Use	Bike in use
47902	29	2022-01-06 05:17:00	Available	Returned after use
48001	30	2021-09-27 07:00:00	In_Use	Bike in use
48002	30	2021-09-27 07:19:00	Available	Returned after use
48101	1	2021-11-25 07:00:00	In_Use	Bike in use
48102	1	2021-11-25 07:44:00	Available	Returned after use
48201	2	2021-10-22 08:00:00	In_Use	Bike in use
48202	2	2021-10-22 08:37:00	Available	Returned after use
48301	3	2022-10-28 07:00:00	In_Use	Bike in use
48302	3	2022-10-28 07:34:00	Available	Returned after use
48401	4	2021-12-27 08:00:00	In_Use	Bike in use
48402	4	2021-12-27 08:20:00	Available	Returned after use
48501	5	2021-06-13 09:00:00	In_Use	Bike in use
48502	5	2021-06-13 09:27:00	Available	Returned after use
48601	6	2022-01-02 11:00:00	In_Use	Bike in use
48602	6	2022-01-02 11:17:00	Available	Returned after use
48701	7	2022-08-09 01:00:00	In_Use	Bike in use
48702	7	2022-08-09 01:52:00	Available	Returned after use
48801	8	2021-07-04 03:00:00	In_Use	Bike in use
48802	8	2021-07-04 03:14:00	Available	Returned after use
48901	9	2022-07-27 08:00:00	In_Use	Bike in use
48902	9	2022-07-27 08:45:00	Available	Returned after use
49001	10	2021-12-24 04:00:00	In_Use	Bike in use
49002	10	2021-12-24 04:47:00	Available	Returned after use
49101	11	2021-03-22 09:00:00	In_Use	Bike in use
49102	11	2021-03-22 09:40:00	Available	Returned after use
49201	12	2022-12-16 09:00:00	In_Use	Bike in use
49202	12	2022-12-16 09:45:00	Available	Returned after use
49301	13	2021-12-13 00:00:00	In_Use	Bike in use
49302	13	2021-12-13 00:31:00	Available	Returned after use
49401	14	2021-11-20 09:00:00	In_Use	Bike in use
49402	14	2021-11-20 09:44:00	Available	Returned after use
49501	15	2021-03-04 08:00:00	In_Use	Bike in use
49502	15	2021-03-04 08:38:00	Available	Returned after use
49601	16	2022-02-17 11:00:00	In_Use	Bike in use
49602	16	2022-02-17 11:41:00	Available	Returned after use
49701	17	2022-07-29 08:00:00	In_Use	Bike in use
49702	17	2022-07-29 08:48:00	Available	Returned after use
49801	18	2021-03-31 09:00:00	In_Use	Bike in use
49802	18	2021-03-31 09:23:00	Available	Returned after use
49901	19	2022-06-12 00:00:00	In_Use	Bike in use
49902	19	2022-06-12 00:40:00	Available	Returned after use
50001	20	2022-02-09 09:00:00	In_Use	Bike in use
50002	20	2022-02-09 09:20:00	Available	Returned after use
50101	21	2021-08-10 02:00:00	In_Use	Bike in use
50102	21	2021-08-10 02:59:00	Available	Returned after use
50201	22	2022-03-08 11:00:00	In_Use	Bike in use
50202	22	2022-03-08 11:26:00	Available	Returned after use
50301	23	2022-10-03 07:00:00	In_Use	Bike in use
50302	23	2022-10-03 07:32:00	Available	Returned after use
50401	24	2022-09-22 08:00:00	In_Use	Bike in use
50402	24	2022-09-22 08:47:00	Available	Returned after use
50501	25	2022-02-08 02:00:00	In_Use	Bike in use
50502	25	2022-02-08 02:12:00	Available	Returned after use
50601	26	2022-05-26 01:00:00	In_Use	Bike in use
50602	26	2022-05-26 01:21:00	Available	Returned after use
50701	27	2021-06-25 08:00:00	In_Use	Bike in use
50702	27	2021-06-25 08:53:00	Available	Returned after use
50801	28	2022-06-22 06:00:00	In_Use	Bike in use
50802	28	2022-06-22 06:48:00	Available	Returned after use
50901	29	2022-01-06 04:00:00	In_Use	Bike in use
50902	29	2022-01-06 04:11:00	Available	Returned after use
51001	30	2021-09-27 11:00:00	In_Use	Bike in use
51002	30	2021-09-27 11:59:00	Available	Returned after use
51101	1	2021-11-25 11:00:00	In_Use	Bike in use
51102	1	2021-11-25 11:23:00	Available	Returned after use
51201	2	2021-10-22 07:00:00	In_Use	Bike in use
51202	2	2021-10-22 07:27:00	Available	Returned after use
51301	3	2022-10-28 11:00:00	In_Use	Bike in use
51302	3	2022-10-28 11:17:00	Available	Returned after use
51401	4	2021-12-27 09:00:00	In_Use	Bike in use
51402	4	2021-12-27 09:15:00	Available	Returned after use
51501	5	2021-06-13 03:00:00	In_Use	Bike in use
51502	5	2021-06-13 03:14:00	Available	Returned after use
51601	6	2022-01-02 07:00:00	In_Use	Bike in use
51602	6	2022-01-02 07:30:00	Available	Returned after use
51701	7	2022-08-09 06:00:00	In_Use	Bike in use
51702	7	2022-08-09 06:36:00	Available	Returned after use
51801	8	2021-07-04 04:00:00	In_Use	Bike in use
51802	8	2021-07-04 04:40:00	Available	Returned after use
51901	9	2022-07-27 00:00:00	In_Use	Bike in use
51902	9	2022-07-27 00:45:00	Available	Returned after use
52001	10	2021-12-24 10:00:00	In_Use	Bike in use
52002	10	2021-12-24 10:21:00	Available	Returned after use
52101	11	2021-03-22 04:00:00	In_Use	Bike in use
52102	11	2021-03-22 04:17:00	Available	Returned after use
52201	12	2022-12-16 08:00:00	In_Use	Bike in use
52202	12	2022-12-16 08:50:00	Available	Returned after use
52301	13	2021-12-13 02:00:00	In_Use	Bike in use
52302	13	2021-12-13 02:58:00	Available	Returned after use
52401	14	2021-11-20 04:00:00	In_Use	Bike in use
52402	14	2021-11-20 04:41:00	Available	Returned after use
52501	15	2021-03-04 02:00:00	In_Use	Bike in use
52502	15	2021-03-04 02:25:00	Available	Returned after use
52601	16	2022-02-17 03:00:00	In_Use	Bike in use
52602	16	2022-02-17 03:18:00	Available	Returned after use
52701	17	2022-07-29 02:00:00	In_Use	Bike in use
52702	17	2022-07-29 02:51:00	Available	Returned after use
52801	18	2021-03-31 09:00:00	In_Use	Bike in use
52802	18	2021-03-31 09:25:00	Available	Returned after use
52901	19	2022-06-12 05:00:00	In_Use	Bike in use
52902	19	2022-06-12 05:59:00	Available	Returned after use
53001	20	2022-02-09 07:00:00	In_Use	Bike in use
53002	20	2022-02-09 07:23:00	Available	Returned after use
53101	21	2021-08-10 04:00:00	In_Use	Bike in use
53102	21	2021-08-10 04:33:00	Available	Returned after use
53201	22	2022-03-08 10:00:00	In_Use	Bike in use
53202	22	2022-03-08 10:46:00	Available	Returned after use
53301	23	2022-10-03 04:00:00	In_Use	Bike in use
53302	23	2022-10-03 04:26:00	Available	Returned after use
53401	24	2022-09-22 01:00:00	In_Use	Bike in use
53402	24	2022-09-22 01:56:00	Available	Returned after use
53501	25	2022-02-08 11:00:00	In_Use	Bike in use
53502	25	2022-02-08 11:33:00	Available	Returned after use
53601	26	2022-05-26 10:00:00	In_Use	Bike in use
53602	26	2022-05-26 10:21:00	Available	Returned after use
53701	27	2021-06-25 11:00:00	In_Use	Bike in use
53702	27	2021-06-25 11:15:00	Available	Returned after use
53801	28	2022-06-22 09:00:00	In_Use	Bike in use
53802	28	2022-06-22 09:36:00	Available	Returned after use
53901	29	2022-01-06 04:00:00	In_Use	Bike in use
53902	29	2022-01-06 04:26:00	Available	Returned after use
54001	30	2021-09-27 05:00:00	In_Use	Bike in use
54002	30	2021-09-27 05:32:00	Available	Returned after use
54101	1	2021-11-25 05:00:00	In_Use	Bike in use
54102	1	2021-11-25 05:37:00	Available	Returned after use
54201	2	2021-10-22 06:00:00	In_Use	Bike in use
54202	2	2021-10-22 06:48:00	Available	Returned after use
54301	3	2022-10-28 07:00:00	In_Use	Bike in use
54302	3	2022-10-28 07:51:00	Available	Returned after use
54401	4	2021-12-27 09:00:00	In_Use	Bike in use
54402	4	2021-12-27 09:22:00	Available	Returned after use
54501	5	2021-06-13 10:00:00	In_Use	Bike in use
54502	5	2021-06-13 10:37:00	Available	Returned after use
54601	6	2022-01-02 06:00:00	In_Use	Bike in use
54602	6	2022-01-02 06:33:00	Available	Returned after use
54701	7	2022-08-09 00:00:00	In_Use	Bike in use
54702	7	2022-08-09 00:18:00	Available	Returned after use
54801	8	2021-07-04 02:00:00	In_Use	Bike in use
54802	8	2021-07-04 02:39:00	Available	Returned after use
54901	9	2022-07-27 08:00:00	In_Use	Bike in use
54902	9	2022-07-27 08:27:00	Available	Returned after use
55001	10	2021-12-24 05:00:00	In_Use	Bike in use
55002	10	2021-12-24 05:13:00	Available	Returned after use
55101	11	2021-03-22 00:00:00	In_Use	Bike in use
55102	11	2021-03-22 00:40:00	Available	Returned after use
55201	12	2022-12-16 10:00:00	In_Use	Bike in use
55202	12	2022-12-16 10:51:00	Available	Returned after use
55301	13	2021-12-13 00:00:00	In_Use	Bike in use
55302	13	2021-12-13 00:40:00	Available	Returned after use
55401	14	2021-11-20 02:00:00	In_Use	Bike in use
55402	14	2021-11-20 02:46:00	Available	Returned after use
55501	15	2021-03-04 11:00:00	In_Use	Bike in use
55502	15	2021-03-04 11:21:00	Available	Returned after use
55601	16	2022-02-17 05:00:00	In_Use	Bike in use
55602	16	2022-02-17 05:20:00	Available	Returned after use
55701	17	2022-07-29 05:00:00	In_Use	Bike in use
55702	17	2022-07-29 05:44:00	Available	Returned after use
55801	18	2021-03-31 03:00:00	In_Use	Bike in use
55802	18	2021-03-31 03:57:00	Available	Returned after use
55901	19	2022-06-12 09:00:00	In_Use	Bike in use
55902	19	2022-06-12 09:35:00	Available	Returned after use
56001	20	2022-02-09 04:00:00	In_Use	Bike in use
56002	20	2022-02-09 04:52:00	Available	Returned after use
56101	21	2021-08-10 05:00:00	In_Use	Bike in use
56102	21	2021-08-10 05:31:00	Available	Returned after use
56201	22	2022-03-08 11:00:00	In_Use	Bike in use
56202	22	2022-03-08 11:50:00	Available	Returned after use
56301	23	2022-10-03 09:00:00	In_Use	Bike in use
56302	23	2022-10-03 09:20:00	Available	Returned after use
56401	24	2022-09-22 06:00:00	In_Use	Bike in use
56402	24	2022-09-22 06:40:00	Available	Returned after use
56501	25	2022-02-08 05:00:00	In_Use	Bike in use
56502	25	2022-02-08 05:41:00	Available	Returned after use
56601	26	2022-05-26 10:00:00	In_Use	Bike in use
56602	26	2022-05-26 10:25:00	Available	Returned after use
56701	27	2021-06-25 04:00:00	In_Use	Bike in use
56702	27	2021-06-25 04:47:00	Available	Returned after use
56801	28	2022-06-22 09:00:00	In_Use	Bike in use
56802	28	2022-06-22 09:42:00	Available	Returned after use
56901	29	2022-01-06 07:00:00	In_Use	Bike in use
56902	29	2022-01-06 07:24:00	Available	Returned after use
57001	30	2021-09-27 07:00:00	In_Use	Bike in use
57002	30	2021-09-27 07:54:00	Available	Returned after use
57101	1	2021-11-25 07:00:00	In_Use	Bike in use
57102	1	2021-11-25 07:11:00	Available	Returned after use
57201	2	2021-10-22 04:00:00	In_Use	Bike in use
57202	2	2021-10-22 04:53:00	Available	Returned after use
57301	3	2022-10-28 04:00:00	In_Use	Bike in use
57302	3	2022-10-28 04:31:00	Available	Returned after use
57401	4	2021-12-27 00:00:00	In_Use	Bike in use
57402	4	2021-12-27 00:22:00	Available	Returned after use
57501	5	2021-06-13 11:00:00	In_Use	Bike in use
57502	5	2021-06-13 11:55:00	Available	Returned after use
57601	6	2022-01-02 06:00:00	In_Use	Bike in use
57602	6	2022-01-02 06:42:00	Available	Returned after use
57701	7	2022-08-09 02:00:00	In_Use	Bike in use
57702	7	2022-08-09 02:49:00	Available	Returned after use
57801	8	2021-07-04 00:00:00	In_Use	Bike in use
57802	8	2021-07-04 00:30:00	Available	Returned after use
57901	9	2022-07-27 09:00:00	In_Use	Bike in use
57902	9	2022-07-27 09:21:00	Available	Returned after use
58001	10	2021-12-24 05:00:00	In_Use	Bike in use
58002	10	2021-12-24 05:59:00	Available	Returned after use
58101	11	2021-03-22 04:00:00	In_Use	Bike in use
58102	11	2021-03-22 04:16:00	Available	Returned after use
58201	12	2022-12-16 02:00:00	In_Use	Bike in use
58202	12	2022-12-16 02:10:00	Available	Returned after use
58301	13	2021-12-13 00:00:00	In_Use	Bike in use
58302	13	2021-12-13 00:24:00	Available	Returned after use
58401	14	2021-11-20 05:00:00	In_Use	Bike in use
58402	14	2021-11-20 05:13:00	Available	Returned after use
58501	15	2021-03-04 00:00:00	In_Use	Bike in use
58502	15	2021-03-04 00:48:00	Available	Returned after use
58601	16	2022-02-17 01:00:00	In_Use	Bike in use
58602	16	2022-02-17 01:49:00	Available	Returned after use
58701	17	2022-07-29 06:00:00	In_Use	Bike in use
58702	17	2022-07-29 06:13:00	Available	Returned after use
58801	18	2021-03-31 08:00:00	In_Use	Bike in use
58802	18	2021-03-31 08:19:00	Available	Returned after use
58901	19	2022-06-12 07:00:00	In_Use	Bike in use
58902	19	2022-06-12 07:25:00	Available	Returned after use
59001	20	2022-02-09 06:00:00	In_Use	Bike in use
59002	20	2022-02-09 06:26:00	Available	Returned after use
59101	21	2021-08-10 03:00:00	In_Use	Bike in use
59102	21	2021-08-10 03:21:00	Available	Returned after use
59201	22	2022-03-08 06:00:00	In_Use	Bike in use
59202	22	2022-03-08 06:14:00	Available	Returned after use
59301	23	2022-10-03 04:00:00	In_Use	Bike in use
59302	23	2022-10-03 04:28:00	Available	Returned after use
59401	24	2022-09-22 00:00:00	In_Use	Bike in use
59402	24	2022-09-22 00:47:00	Available	Returned after use
59501	25	2022-02-08 03:00:00	In_Use	Bike in use
59502	25	2022-02-08 03:38:00	Available	Returned after use
59601	26	2022-05-26 05:00:00	In_Use	Bike in use
59602	26	2022-05-26 05:47:00	Available	Returned after use
59701	27	2021-06-25 09:00:00	In_Use	Bike in use
59702	27	2021-06-25 09:25:00	Available	Returned after use
59801	28	2022-06-22 10:00:00	In_Use	Bike in use
59802	28	2022-06-22 10:56:00	Available	Returned after use
59901	29	2022-01-06 04:00:00	In_Use	Bike in use
59902	29	2022-01-06 04:16:00	Available	Returned after use
60001	30	2021-09-27 08:00:00	In_Use	Bike in use
60002	30	2021-09-27 08:28:00	Available	Returned after use
60101	1	2021-11-25 09:00:00	In_Use	Bike in use
60102	1	2021-11-25 09:13:00	Available	Returned after use
60201	2	2021-10-22 10:00:00	In_Use	Bike in use
60202	2	2021-10-22 10:46:00	Available	Returned after use
60301	3	2022-10-28 09:00:00	In_Use	Bike in use
60302	3	2022-10-28 09:59:00	Available	Returned after use
60401	4	2021-12-27 09:00:00	In_Use	Bike in use
60402	4	2021-12-27 09:55:00	Available	Returned after use
60501	5	2021-06-13 06:00:00	In_Use	Bike in use
60502	5	2021-06-13 06:33:00	Available	Returned after use
60601	6	2022-01-02 05:00:00	In_Use	Bike in use
60602	6	2022-01-02 05:18:00	Available	Returned after use
60701	7	2022-08-09 03:00:00	In_Use	Bike in use
60702	7	2022-08-09 03:59:00	Available	Returned after use
60801	8	2021-07-04 10:00:00	In_Use	Bike in use
60802	8	2021-07-04 10:35:00	Available	Returned after use
60901	9	2022-07-27 10:00:00	In_Use	Bike in use
60902	9	2022-07-27 10:49:00	Available	Returned after use
61001	10	2021-12-24 02:00:00	In_Use	Bike in use
61002	10	2021-12-24 02:46:00	Available	Returned after use
61101	11	2021-03-22 03:00:00	In_Use	Bike in use
61102	11	2021-03-22 03:12:00	Available	Returned after use
61201	12	2022-12-16 11:00:00	In_Use	Bike in use
61202	12	2022-12-16 11:34:00	Available	Returned after use
61301	13	2021-12-13 05:00:00	In_Use	Bike in use
61302	13	2021-12-13 05:22:00	Available	Returned after use
61401	14	2021-11-20 09:00:00	In_Use	Bike in use
61402	14	2021-11-20 09:34:00	Available	Returned after use
61501	15	2021-03-04 07:00:00	In_Use	Bike in use
61502	15	2021-03-04 07:44:00	Available	Returned after use
61601	16	2022-02-17 08:00:00	In_Use	Bike in use
61602	16	2022-02-17 08:38:00	Available	Returned after use
61701	17	2022-07-29 11:00:00	In_Use	Bike in use
61702	17	2022-07-29 11:28:00	Available	Returned after use
61801	18	2021-03-31 03:00:00	In_Use	Bike in use
61802	18	2021-03-31 03:33:00	Available	Returned after use
61901	19	2022-06-12 06:00:00	In_Use	Bike in use
61902	19	2022-06-12 06:19:00	Available	Returned after use
62001	20	2022-02-09 01:00:00	In_Use	Bike in use
62002	20	2022-02-09 01:30:00	Available	Returned after use
62101	21	2021-08-10 08:00:00	In_Use	Bike in use
62102	21	2021-08-10 08:50:00	Available	Returned after use
62201	22	2022-03-08 11:00:00	In_Use	Bike in use
62202	22	2022-03-08 11:44:00	Available	Returned after use
62301	23	2022-10-03 08:00:00	In_Use	Bike in use
62302	23	2022-10-03 08:20:00	Available	Returned after use
62401	24	2022-09-22 10:00:00	In_Use	Bike in use
62402	24	2022-09-22 10:40:00	Available	Returned after use
62501	25	2022-02-08 11:00:00	In_Use	Bike in use
62502	25	2022-02-08 11:38:00	Available	Returned after use
62601	26	2022-05-26 10:00:00	In_Use	Bike in use
62602	26	2022-05-26 10:51:00	Available	Returned after use
62701	27	2021-06-25 07:00:00	In_Use	Bike in use
62702	27	2021-06-25 07:59:00	Available	Returned after use
62801	28	2022-06-22 10:00:00	In_Use	Bike in use
62802	28	2022-06-22 10:48:00	Available	Returned after use
62901	29	2022-01-06 01:00:00	In_Use	Bike in use
62902	29	2022-01-06 01:30:00	Available	Returned after use
63001	30	2021-09-27 03:00:00	In_Use	Bike in use
63002	30	2021-09-27 03:32:00	Available	Returned after use
63101	1	2021-11-25 11:00:00	In_Use	Bike in use
63102	1	2021-11-25 11:12:00	Available	Returned after use
63201	2	2021-10-22 10:00:00	In_Use	Bike in use
63202	2	2021-10-22 10:53:00	Available	Returned after use
63301	3	2022-10-28 10:00:00	In_Use	Bike in use
63302	3	2022-10-28 10:18:00	Available	Returned after use
63401	4	2021-12-27 03:00:00	In_Use	Bike in use
63402	4	2021-12-27 03:37:00	Available	Returned after use
63501	5	2021-06-13 05:00:00	In_Use	Bike in use
63502	5	2021-06-13 05:24:00	Available	Returned after use
63601	6	2022-01-02 04:00:00	In_Use	Bike in use
63602	6	2022-01-02 04:26:00	Available	Returned after use
63701	7	2022-08-09 11:00:00	In_Use	Bike in use
63702	7	2022-08-09 11:50:00	Available	Returned after use
63801	8	2021-07-04 09:00:00	In_Use	Bike in use
63802	8	2021-07-04 09:33:00	Available	Returned after use
63901	9	2022-07-27 11:00:00	In_Use	Bike in use
63902	9	2022-07-27 11:45:00	Available	Returned after use
64001	10	2021-12-24 07:00:00	In_Use	Bike in use
64002	10	2021-12-24 07:19:00	Available	Returned after use
64101	11	2021-03-22 02:00:00	In_Use	Bike in use
64102	11	2021-03-22 02:50:00	Available	Returned after use
64201	12	2022-12-16 00:00:00	In_Use	Bike in use
64202	12	2022-12-16 00:14:00	Available	Returned after use
64301	13	2021-12-13 10:00:00	In_Use	Bike in use
64302	13	2021-12-13 10:53:00	Available	Returned after use
64401	14	2021-11-20 03:00:00	In_Use	Bike in use
64402	14	2021-11-20 03:44:00	Available	Returned after use
64501	15	2021-03-04 11:00:00	In_Use	Bike in use
64502	15	2021-03-04 11:55:00	Available	Returned after use
64601	16	2022-02-17 11:00:00	In_Use	Bike in use
64602	16	2022-02-17 11:36:00	Available	Returned after use
64701	17	2022-07-29 10:00:00	In_Use	Bike in use
64702	17	2022-07-29 10:15:00	Available	Returned after use
64801	18	2021-03-31 00:00:00	In_Use	Bike in use
64802	18	2021-03-31 00:35:00	Available	Returned after use
64901	19	2022-06-12 09:00:00	In_Use	Bike in use
64902	19	2022-06-12 09:46:00	Available	Returned after use
65001	20	2022-02-09 07:00:00	In_Use	Bike in use
65002	20	2022-02-09 07:55:00	Available	Returned after use
65101	21	2021-08-10 05:00:00	In_Use	Bike in use
65102	21	2021-08-10 05:52:00	Available	Returned after use
65201	22	2022-03-08 00:00:00	In_Use	Bike in use
65202	22	2022-03-08 00:19:00	Available	Returned after use
65301	23	2022-10-03 05:00:00	In_Use	Bike in use
65302	23	2022-10-03 05:59:00	Available	Returned after use
65401	24	2022-09-22 02:00:00	In_Use	Bike in use
65402	24	2022-09-22 02:37:00	Available	Returned after use
65501	25	2022-02-08 09:00:00	In_Use	Bike in use
65502	25	2022-02-08 09:10:00	Available	Returned after use
65601	26	2022-05-26 08:00:00	In_Use	Bike in use
65602	26	2022-05-26 08:35:00	Available	Returned after use
65701	27	2021-06-25 00:00:00	In_Use	Bike in use
65702	27	2021-06-25 00:44:00	Available	Returned after use
65801	28	2022-06-22 11:00:00	In_Use	Bike in use
65802	28	2022-06-22 11:12:00	Available	Returned after use
65901	29	2022-01-06 06:00:00	In_Use	Bike in use
65902	29	2022-01-06 06:35:00	Available	Returned after use
66001	30	2021-09-27 02:00:00	In_Use	Bike in use
66002	30	2021-09-27 02:45:00	Available	Returned after use
66101	1	2021-11-25 01:00:00	In_Use	Bike in use
66102	1	2021-11-25 01:17:00	Available	Returned after use
66201	2	2021-10-22 02:00:00	In_Use	Bike in use
66202	2	2021-10-22 02:48:00	Available	Returned after use
66301	3	2022-10-28 06:00:00	In_Use	Bike in use
66302	3	2022-10-28 06:17:00	Available	Returned after use
66401	4	2021-12-27 08:00:00	In_Use	Bike in use
66402	4	2021-12-27 08:39:00	Available	Returned after use
66501	5	2021-06-13 05:00:00	In_Use	Bike in use
66502	5	2021-06-13 05:23:00	Available	Returned after use
66601	6	2022-01-02 04:00:00	In_Use	Bike in use
66602	6	2022-01-02 04:15:00	Available	Returned after use
66701	7	2022-08-09 03:00:00	In_Use	Bike in use
66702	7	2022-08-09 03:56:00	Available	Returned after use
66801	8	2021-07-04 00:00:00	In_Use	Bike in use
66802	8	2021-07-04 00:54:00	Available	Returned after use
66901	9	2022-07-27 08:00:00	In_Use	Bike in use
66902	9	2022-07-27 08:27:00	Available	Returned after use
67001	10	2021-12-24 04:00:00	In_Use	Bike in use
67002	10	2021-12-24 04:34:00	Available	Returned after use
67101	11	2021-03-22 06:00:00	In_Use	Bike in use
67102	11	2021-03-22 06:56:00	Available	Returned after use
67201	12	2022-12-16 04:00:00	In_Use	Bike in use
67202	12	2022-12-16 04:59:00	Available	Returned after use
67301	13	2021-12-13 08:00:00	In_Use	Bike in use
67302	13	2021-12-13 08:13:00	Available	Returned after use
67401	14	2021-11-20 09:00:00	In_Use	Bike in use
67402	14	2021-11-20 09:48:00	Available	Returned after use
67501	15	2021-03-04 03:00:00	In_Use	Bike in use
67502	15	2021-03-04 03:19:00	Available	Returned after use
67601	16	2022-02-17 05:00:00	In_Use	Bike in use
67602	16	2022-02-17 05:25:00	Available	Returned after use
67701	17	2022-07-29 11:00:00	In_Use	Bike in use
67702	17	2022-07-29 11:34:00	Available	Returned after use
67801	18	2021-03-31 05:00:00	In_Use	Bike in use
67802	18	2021-03-31 05:16:00	Available	Returned after use
67901	19	2022-06-12 00:00:00	In_Use	Bike in use
67902	19	2022-06-12 00:35:00	Available	Returned after use
68001	20	2022-02-09 02:00:00	In_Use	Bike in use
68002	20	2022-02-09 02:11:00	Available	Returned after use
68101	21	2021-08-10 08:00:00	In_Use	Bike in use
68102	21	2021-08-10 08:17:00	Available	Returned after use
68201	22	2022-03-08 08:00:00	In_Use	Bike in use
68202	22	2022-03-08 08:39:00	Available	Returned after use
68301	23	2022-10-03 09:00:00	In_Use	Bike in use
68302	23	2022-10-03 09:55:00	Available	Returned after use
68401	24	2022-09-22 08:00:00	In_Use	Bike in use
68402	24	2022-09-22 08:26:00	Available	Returned after use
68501	25	2022-02-08 09:00:00	In_Use	Bike in use
68502	25	2022-02-08 09:56:00	Available	Returned after use
68601	26	2022-05-26 04:00:00	In_Use	Bike in use
68602	26	2022-05-26 04:25:00	Available	Returned after use
68701	27	2021-06-25 10:00:00	In_Use	Bike in use
68702	27	2021-06-25 10:17:00	Available	Returned after use
68801	28	2022-06-22 04:00:00	In_Use	Bike in use
68802	28	2022-06-22 04:24:00	Available	Returned after use
68901	29	2022-01-06 08:00:00	In_Use	Bike in use
68902	29	2022-01-06 08:32:00	Available	Returned after use
69001	30	2021-09-27 06:00:00	In_Use	Bike in use
69002	30	2021-09-27 06:52:00	Available	Returned after use
69101	1	2021-11-25 03:00:00	In_Use	Bike in use
69102	1	2021-11-25 03:43:00	Available	Returned after use
69201	2	2021-10-22 00:00:00	In_Use	Bike in use
69202	2	2021-10-22 00:26:00	Available	Returned after use
69301	3	2022-10-28 10:00:00	In_Use	Bike in use
69302	3	2022-10-28 10:41:00	Available	Returned after use
69401	4	2021-12-27 01:00:00	In_Use	Bike in use
69402	4	2021-12-27 01:52:00	Available	Returned after use
69501	5	2021-09-05 08:00:00	In_Use	Bike in use
69502	5	2021-09-05 08:24:00	Available	Returned after use
69601	6	2022-01-02 10:00:00	In_Use	Bike in use
69602	6	2022-01-02 10:29:00	Available	Returned after use
69701	7	2022-08-09 07:00:00	In_Use	Bike in use
69702	7	2022-08-09 07:59:00	Available	Returned after use
69801	8	2021-09-05 08:00:00	In_Use	Bike in use
69802	8	2021-09-05 08:39:00	Available	Returned after use
69901	9	2022-07-27 09:00:00	In_Use	Bike in use
69902	9	2022-07-27 09:22:00	Available	Returned after use
70001	10	2021-12-24 09:00:00	In_Use	Bike in use
70002	10	2021-12-24 09:37:00	Available	Returned after use
70101	11	2021-09-05 09:00:00	In_Use	Bike in use
70102	11	2021-09-05 09:41:00	Available	Returned after use
70201	12	2022-12-16 05:00:00	In_Use	Bike in use
70202	12	2022-12-16 05:24:00	Available	Returned after use
70301	13	2021-12-13 04:00:00	In_Use	Bike in use
70302	13	2021-12-13 04:21:00	Available	Returned after use
70401	14	2021-11-20 00:00:00	In_Use	Bike in use
70402	14	2021-11-20 00:52:00	Available	Returned after use
70501	15	2021-09-05 09:00:00	In_Use	Bike in use
70502	15	2021-09-05 09:51:00	Available	Returned after use
70601	16	2022-02-17 02:00:00	In_Use	Bike in use
70602	16	2022-02-17 02:29:00	Available	Returned after use
70701	17	2022-07-29 05:00:00	In_Use	Bike in use
70702	17	2022-07-29 05:14:00	Available	Returned after use
70801	18	2021-09-05 11:00:00	In_Use	Bike in use
70802	18	2021-09-05 11:30:00	Available	Returned after use
70901	19	2022-06-12 09:00:00	In_Use	Bike in use
70902	19	2022-06-12 09:29:00	Available	Returned after use
71001	20	2022-02-09 06:00:00	In_Use	Bike in use
71002	20	2022-02-09 06:39:00	Available	Returned after use
71101	21	2021-09-05 02:00:00	In_Use	Bike in use
71102	21	2021-09-05 02:18:00	Available	Returned after use
71201	22	2022-03-08 09:00:00	In_Use	Bike in use
71202	22	2022-03-08 09:24:00	Available	Returned after use
71301	23	2022-10-03 02:00:00	In_Use	Bike in use
71302	23	2022-10-03 02:39:00	Available	Returned after use
71401	24	2022-09-22 02:00:00	In_Use	Bike in use
71402	24	2022-09-22 02:14:00	Available	Returned after use
71501	25	2022-02-08 04:00:00	In_Use	Bike in use
71502	25	2022-02-08 04:55:00	Available	Returned after use
71601	26	2022-05-26 10:00:00	In_Use	Bike in use
71602	26	2022-05-26 10:54:00	Available	Returned after use
71701	27	2021-09-05 02:00:00	In_Use	Bike in use
71702	27	2021-09-05 02:17:00	Available	Returned after use
71801	28	2022-06-22 05:00:00	In_Use	Bike in use
71802	28	2022-06-22 05:47:00	Available	Returned after use
71901	29	2022-01-06 01:00:00	In_Use	Bike in use
71902	29	2022-01-06 01:14:00	Available	Returned after use
72001	30	2021-09-27 06:00:00	In_Use	Bike in use
72002	30	2021-09-27 06:53:00	Available	Returned after use
72101	1	2021-11-25 08:00:00	In_Use	Bike in use
72102	1	2021-11-25 08:27:00	Available	Returned after use
72201	2	2021-10-22 04:00:00	In_Use	Bike in use
72202	2	2021-10-22 04:29:00	Available	Returned after use
72301	3	2022-10-28 03:00:00	In_Use	Bike in use
72302	3	2022-10-28 03:38:00	Available	Returned after use
72401	4	2021-12-27 09:00:00	In_Use	Bike in use
72402	4	2021-12-27 09:10:00	Available	Returned after use
72501	5	2021-06-13 11:00:00	In_Use	Bike in use
72502	5	2021-06-13 11:12:00	Available	Returned after use
72601	6	2022-01-02 10:00:00	In_Use	Bike in use
72602	6	2022-01-02 10:36:00	Available	Returned after use
72701	7	2022-08-09 06:00:00	In_Use	Bike in use
72702	7	2022-08-09 06:59:00	Available	Returned after use
72801	8	2021-07-04 02:00:00	In_Use	Bike in use
72802	8	2021-07-04 02:19:00	Available	Returned after use
72901	9	2022-07-27 03:00:00	In_Use	Bike in use
72902	9	2022-07-27 03:56:00	Available	Returned after use
73001	10	2021-12-24 08:00:00	In_Use	Bike in use
73002	10	2021-12-24 08:17:00	Available	Returned after use
73101	11	2021-03-22 01:00:00	In_Use	Bike in use
73102	11	2021-03-22 01:49:00	Available	Returned after use
73201	12	2022-12-16 11:00:00	In_Use	Bike in use
73202	12	2022-12-16 11:20:00	Available	Returned after use
73301	13	2021-12-13 06:00:00	In_Use	Bike in use
73302	13	2021-12-13 06:59:00	Available	Returned after use
73401	14	2021-11-20 00:00:00	In_Use	Bike in use
73402	14	2021-11-20 00:56:00	Available	Returned after use
73501	15	2021-03-04 04:00:00	In_Use	Bike in use
73502	15	2021-03-04 04:36:00	Available	Returned after use
73601	16	2022-02-17 11:00:00	In_Use	Bike in use
73602	16	2022-02-17 11:24:00	Available	Returned after use
73701	17	2022-07-29 01:00:00	In_Use	Bike in use
73702	17	2022-07-29 01:39:00	Available	Returned after use
73801	18	2021-03-31 02:00:00	In_Use	Bike in use
73802	18	2021-03-31 02:44:00	Available	Returned after use
73901	19	2022-06-12 11:00:00	In_Use	Bike in use
73902	19	2022-06-12 11:38:00	Available	Returned after use
74001	20	2022-02-09 04:00:00	In_Use	Bike in use
74002	20	2022-02-09 04:24:00	Available	Returned after use
74101	21	2021-08-10 11:00:00	In_Use	Bike in use
74102	21	2021-08-10 11:52:00	Available	Returned after use
74201	22	2022-03-08 10:00:00	In_Use	Bike in use
74202	22	2022-03-08 10:19:00	Available	Returned after use
74301	23	2022-10-03 01:00:00	In_Use	Bike in use
74302	23	2022-10-03 01:34:00	Available	Returned after use
74401	24	2022-09-22 11:00:00	In_Use	Bike in use
74402	24	2022-09-22 11:16:00	Available	Returned after use
74501	25	2022-02-08 07:00:00	In_Use	Bike in use
74502	25	2022-02-08 07:39:00	Available	Returned after use
74601	26	2022-05-26 01:00:00	In_Use	Bike in use
74602	26	2022-05-26 01:47:00	Available	Returned after use
74701	27	2021-06-25 07:00:00	In_Use	Bike in use
74702	27	2021-06-25 07:13:00	Available	Returned after use
74801	28	2022-06-22 06:00:00	In_Use	Bike in use
74802	28	2022-06-22 06:12:00	Available	Returned after use
74901	29	2022-01-06 11:00:00	In_Use	Bike in use
74902	29	2022-01-06 11:53:00	Available	Returned after use
75001	30	2021-09-27 05:00:00	In_Use	Bike in use
75002	30	2021-09-27 05:26:00	Available	Returned after use
\.


--
-- Data for Name: maintenancelogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maintenancelogs (logid, bikeid, maintenancedate, description, cost, technicianname) FROM stdin;
1	1	2025-08-14	General maintenance	49.57	Technician 2
2	2	2025-03-15	General maintenance	46.02	Technician 6
3	3	2025-10-07	General maintenance	40.11	Technician 1
4	4	2025-12-18	General maintenance	36.70	Technician 5
5	5	2025-03-04	General maintenance	98.86	Technician 10
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (paymentid, rentalid, paymentdate, amount, paymentmethod, currency, cardnumberhint) FROM stdin;
1	1	2021-11-25 05:25:00	19.87	Account	EURO	0403
2	2	2021-10-22 02:22:00	11.78	Card	USD	7715
3	3	2022-10-28 01:45:00	14.42	Account	RON	2679
4	4	2021-12-27 02:35:00	9.73	Card	EURO	8645
5	5	2021-06-13 01:14:00	17.27	Account	USD	4978
6	6	2022-01-02 01:13:00	6.39	Card	RON	2164
7	7	2022-08-09 04:10:00	5.85	Account	EURO	2357
8	8	2021-07-04 05:19:00	13.64	Card	USD	1983
9	9	2022-07-27 11:43:00	13.18	Account	RON	9057
10	10	2021-12-24 07:38:00	10.60	Card	EURO	4898
11	11	2021-03-22 00:55:00	9.36	Account	USD	4756
12	12	2022-12-16 02:40:00	11.07	Card	RON	6623
13	13	2021-12-13 03:40:00	6.90	Account	EURO	1437
14	14	2021-11-20 04:40:00	19.14	Card	USD	3549
15	15	2021-03-04 02:34:00	1.58	Account	RON	3840
16	16	2022-02-17 11:49:00	14.74	Card	EURO	7166
17	17	2022-07-29 02:36:00	1.84	Account	USD	6885
18	18	2021-03-31 08:43:00	7.81	Card	RON	7064
19	19	2022-06-12 07:44:00	14.35	Account	EURO	5442
20	20	2022-02-09 09:58:00	6.53	Card	USD	1234
21	21	2021-08-10 00:13:00	7.40	Account	RON	9411
22	22	2022-03-08 04:19:00	14.56	Card	EURO	4840
23	23	2022-10-03 09:47:00	19.36	Account	USD	2031
24	24	2022-09-22 01:44:00	2.16	Card	RON	7854
25	25	2022-02-08 09:37:00	2.69	Account	EURO	6111
26	26	2022-05-26 06:14:00	11.66	Card	USD	4776
27	27	2021-06-25 11:40:00	18.42	Account	RON	9657
28	28	2022-06-22 01:32:00	17.44	Card	EURO	4286
29	29	2022-01-06 10:32:00	12.08	Account	USD	4725
30	30	2021-09-27 06:58:00	7.66	Card	RON	8234
31	31	2021-11-25 07:11:00	6.60	Account	EURO	4727
32	32	2021-10-22 05:20:00	17.60	Card	USD	8255
33	33	2022-10-28 06:22:00	15.61	Account	RON	0688
34	34	2021-12-27 05:12:00	14.42	Card	EURO	8739
35	35	2021-06-13 06:31:00	10.90	Account	USD	3081
36	36	2022-01-02 06:22:00	16.13	Card	RON	2575
37	37	2022-08-09 07:35:00	8.79	Account	EURO	2893
38	38	2021-07-04 02:58:00	19.53	Card	USD	0642
39	39	2022-07-27 06:59:00	9.21	Account	RON	2680
40	40	2021-12-24 04:45:00	4.98	Card	EURO	8114
41	41	2021-03-22 00:31:00	6.07	Account	USD	8778
42	42	2022-12-16 03:45:00	18.43	Card	RON	7041
43	43	2021-12-13 10:43:00	6.72	Account	EURO	7527
44	44	2021-11-20 02:52:00	2.89	Card	USD	4991
45	45	2021-03-04 02:46:00	4.85	Account	RON	5636
46	46	2022-02-17 03:14:00	17.64	Card	EURO	4416
47	47	2022-07-29 09:51:00	12.71	Account	USD	2477
48	48	2021-03-31 09:57:00	17.89	Card	RON	5431
49	49	2022-06-12 00:44:00	18.74	Account	EURO	2511
50	50	2022-02-09 04:58:00	19.40	Card	USD	2292
51	51	2021-08-10 03:52:00	16.56	Account	RON	4608
52	52	2022-03-08 09:50:00	2.81	Card	EURO	9950
53	53	2022-10-03 02:52:00	8.70	Account	USD	8852
54	54	2022-09-22 03:55:00	16.88	Card	RON	5425
55	55	2022-02-08 04:38:00	18.74	Account	EURO	6331
56	56	2022-05-26 11:55:00	17.94	Card	USD	8922
57	57	2021-06-25 07:23:00	9.11	Account	RON	6506
58	58	2022-06-22 05:31:00	15.93	Card	EURO	5327
59	59	2022-01-06 06:17:00	2.96	Account	USD	1236
60	60	2021-09-27 04:54:00	13.67	Card	RON	0455
61	61	2021-11-25 07:46:00	7.43	Account	EURO	9034
62	62	2021-11-14 08:59:00	7.57	Card	USD	3303
63	63	2022-10-28 04:50:00	19.53	Account	RON	9804
64	64	2021-12-27 00:49:00	16.93	Card	EURO	2981
65	65	2021-11-14 03:45:00	7.05	Account	USD	5207
66	66	2022-01-02 02:22:00	13.32	Card	RON	3616
67	67	2022-08-09 01:12:00	14.46	Account	EURO	4706
68	68	2021-11-14 06:28:00	2.90	Card	USD	8246
69	69	2022-07-27 02:59:00	4.72	Account	RON	5584
70	70	2021-12-24 00:45:00	6.72	Card	EURO	5425
71	71	2021-11-14 05:16:00	17.23	Account	USD	3314
72	72	2022-12-16 05:52:00	10.75	Card	RON	2362
73	73	2021-12-13 02:30:00	11.95	Account	EURO	4739
74	74	2021-11-20 07:43:00	17.97	Card	USD	2715
75	75	2021-11-14 02:21:00	1.91	Account	RON	2070
76	76	2022-02-17 04:33:00	12.44	Card	EURO	8813
77	77	2022-07-29 00:54:00	6.92	Account	USD	3467
78	78	2021-11-14 06:56:00	4.00	Card	RON	2228
79	79	2022-06-12 04:56:00	19.15	Account	EURO	8987
80	80	2022-02-09 03:30:00	6.98	Card	USD	8400
81	81	2021-11-14 11:16:00	3.42	Account	RON	3516
82	82	2022-03-08 11:38:00	9.96	Card	EURO	8553
83	83	2022-10-03 05:47:00	14.84	Account	USD	7630
84	84	2022-09-22 01:40:00	8.78	Card	RON	9752
85	85	2022-02-08 11:43:00	12.43	Account	EURO	9574
86	86	2022-05-26 03:31:00	13.12	Card	USD	2116
87	87	2021-11-14 04:40:00	14.15	Account	RON	3939
88	88	2022-06-22 09:41:00	8.32	Card	EURO	3859
89	89	2022-01-06 11:45:00	13.41	Account	USD	3884
90	90	2021-11-14 09:10:00	11.34	Card	RON	0452
91	91	2022-01-07 09:46:00	3.07	Account	EURO	8890
92	92	2022-01-07 11:34:00	11.89	Card	USD	2423
93	93	2022-10-28 00:38:00	8.88	Account	RON	3772
94	94	2022-01-07 03:58:00	17.60	Card	EURO	3967
95	95	2022-01-07 03:52:00	10.53	Account	USD	2107
96	96	2022-01-07 11:28:00	15.50	Card	RON	6663
97	97	2022-08-09 00:35:00	6.92	Account	EURO	6336
98	98	2022-01-07 04:32:00	17.07	Card	USD	1918
99	99	2022-07-27 01:22:00	16.16	Account	RON	0517
100	100	2022-01-07 11:59:00	10.93	Card	EURO	5322
101	101	2022-01-07 04:58:00	19.69	Account	USD	6462
102	102	2022-12-16 07:21:00	15.52	Card	RON	9624
103	103	2022-01-07 02:38:00	5.65	Account	EURO	8690
104	104	2022-01-07 09:16:00	18.06	Card	USD	8422
105	105	2022-01-07 04:12:00	3.51	Account	RON	8269
106	106	2022-02-17 03:35:00	10.25	Card	EURO	7035
107	107	2022-07-29 02:21:00	12.31	Account	USD	2013
108	108	2022-01-07 01:28:00	15.71	Card	RON	2310
109	109	2022-06-12 10:12:00	18.09	Account	EURO	3077
110	110	2022-02-09 10:41:00	16.46	Card	USD	5729
111	111	2022-01-07 01:44:00	3.99	Account	RON	9574
112	112	2022-03-08 03:45:00	10.64	Card	EURO	3440
113	113	2022-10-03 11:31:00	2.39	Account	USD	0629
114	114	2022-09-22 07:26:00	11.01	Card	RON	0988
115	115	2022-02-08 07:47:00	2.87	Account	EURO	2074
116	116	2022-05-26 08:54:00	7.64	Card	USD	3816
117	117	2022-01-07 10:32:00	16.53	Account	RON	5905
118	118	2022-06-22 09:35:00	12.23	Card	EURO	1607
119	119	2022-01-07 01:52:00	10.63	Account	USD	6862
120	120	2022-01-07 04:41:00	12.94	Card	RON	0138
121	121	2021-11-25 04:55:00	13.61	Account	EURO	2259
122	122	2021-10-22 07:44:00	5.31	Card	USD	5272
123	123	2022-10-28 00:58:00	11.39	Account	RON	1449
124	124	2021-12-27 05:35:00	4.61	Card	EURO	8856
125	125	2021-06-13 00:45:00	5.78	Account	USD	6031
126	126	2022-01-02 05:16:00	14.05	Card	RON	8624
127	127	2022-08-09 11:49:00	10.97	Account	EURO	1755
128	128	2021-07-04 06:11:00	17.75	Card	USD	1995
129	129	2022-07-27 01:49:00	1.01	Account	RON	4460
130	130	2021-12-24 03:24:00	16.28	Card	EURO	0854
131	131	2021-03-22 05:18:00	8.97	Account	USD	0844
132	132	2022-12-16 05:36:00	5.66	Card	RON	1464
133	133	2021-12-13 06:18:00	17.13	Account	EURO	5577
134	134	2021-11-20 10:10:00	4.26	Card	USD	0471
135	135	2021-03-04 05:16:00	12.64	Account	RON	7609
136	136	2022-02-17 01:25:00	3.74	Card	EURO	8714
137	137	2022-07-29 08:43:00	9.49	Account	USD	1803
138	138	2021-03-31 04:57:00	11.81	Card	RON	8675
139	139	2022-06-12 11:43:00	19.64	Account	EURO	7112
140	140	2022-02-09 03:39:00	1.57	Card	USD	0709
141	141	2021-08-10 09:52:00	6.14	Account	RON	6941
142	142	2022-03-08 11:13:00	4.72	Card	EURO	0911
143	143	2022-10-03 05:41:00	18.10	Account	USD	7516
144	144	2022-09-22 06:16:00	14.78	Card	RON	7613
145	145	2022-02-08 03:50:00	3.17	Account	EURO	5401
146	146	2022-05-26 02:49:00	3.23	Card	USD	5566
147	147	2021-06-25 00:44:00	9.68	Account	RON	5027
148	148	2022-06-22 06:34:00	9.83	Card	EURO	8461
149	149	2022-01-06 08:53:00	4.80	Account	USD	2391
150	150	2021-09-27 07:24:00	7.26	Card	RON	1914
151	151	2021-11-25 11:56:00	11.01	Account	EURO	0998
152	152	2021-10-22 10:13:00	1.67	Card	USD	6937
153	153	2022-10-28 07:20:00	7.28	Account	RON	2339
154	154	2021-12-27 02:34:00	15.20	Card	EURO	3055
155	155	2021-06-13 02:15:00	15.46	Account	USD	4297
156	156	2022-01-02 11:38:00	13.18	Card	RON	6339
157	157	2022-08-09 06:39:00	14.78	Account	EURO	1842
158	158	2021-07-04 02:40:00	6.04	Card	USD	2664
159	159	2022-07-27 05:55:00	3.80	Account	RON	9802
160	160	2021-12-24 05:24:00	7.80	Card	EURO	4238
161	161	2021-03-22 06:44:00	8.99	Account	USD	0759
162	162	2022-12-16 04:16:00	19.00	Card	RON	8525
163	163	2021-12-13 07:30:00	18.58	Account	EURO	0369
164	164	2021-11-20 01:52:00	11.52	Card	USD	1549
165	165	2021-03-04 03:35:00	11.95	Account	RON	4883
166	166	2022-02-17 08:57:00	11.49	Card	EURO	5654
167	167	2022-07-29 10:11:00	2.43	Account	USD	1485
168	168	2021-03-31 10:17:00	18.34	Card	RON	4374
169	169	2022-06-12 00:31:00	7.02	Account	EURO	8040
170	170	2022-02-09 10:48:00	15.71	Card	USD	3851
171	171	2021-08-10 08:51:00	16.85	Account	RON	5503
172	172	2022-03-08 08:57:00	4.45	Card	EURO	4792
173	173	2022-10-03 02:56:00	11.22	Account	USD	8686
174	174	2022-09-22 09:43:00	4.33	Card	RON	5114
175	175	2022-02-08 00:41:00	8.00	Account	EURO	6778
176	176	2022-05-26 03:45:00	2.48	Card	USD	1319
177	177	2021-06-25 02:30:00	2.44	Account	RON	8903
178	178	2022-06-22 02:37:00	8.47	Card	EURO	5150
179	179	2022-01-06 00:50:00	13.83	Account	USD	1716
180	180	2021-09-27 06:38:00	9.83	Card	RON	7848
181	181	2021-11-25 11:51:00	11.30	Account	EURO	5601
182	182	2021-10-22 09:25:00	18.58	Card	USD	4824
183	183	2022-10-28 03:35:00	1.84	Account	RON	3103
184	184	2021-12-27 06:56:00	10.62	Card	EURO	7624
185	185	2021-06-13 00:58:00	13.02	Account	USD	8922
186	186	2022-01-02 06:38:00	8.52	Card	RON	2151
187	187	2022-08-09 01:46:00	14.71	Account	EURO	2339
188	188	2021-07-04 03:14:00	18.67	Card	USD	7226
189	189	2022-07-27 02:10:00	7.35	Account	RON	1162
190	190	2021-12-24 11:32:00	3.12	Card	EURO	4109
191	191	2021-03-22 10:43:00	19.18	Account	USD	3539
192	192	2022-12-16 05:56:00	5.77	Card	RON	2816
193	193	2021-12-13 00:24:00	1.12	Account	EURO	6520
194	194	2021-11-20 07:53:00	4.77	Card	USD	6278
195	195	2021-03-04 11:37:00	19.85	Account	RON	7045
196	196	2022-02-17 01:33:00	1.68	Card	EURO	5373
197	197	2022-07-29 02:44:00	17.23	Account	USD	4575
198	198	2021-03-31 01:26:00	6.03	Card	RON	8076
199	199	2022-06-12 02:45:00	19.40	Account	EURO	1531
200	200	2022-02-09 11:31:00	9.72	Card	USD	1274
201	201	2021-08-10 04:11:00	13.32	Account	RON	5068
202	202	2022-03-08 06:58:00	11.96	Card	EURO	9924
203	203	2022-10-03 09:40:00	17.99	Account	USD	8994
204	204	2022-09-22 05:24:00	12.08	Card	RON	4151
205	205	2022-02-08 06:35:00	3.97	Account	EURO	3699
206	206	2022-05-26 11:40:00	2.65	Card	USD	8515
207	207	2021-06-25 11:11:00	4.99	Account	RON	2305
208	208	2022-06-22 06:11:00	17.22	Card	EURO	8174
209	209	2022-01-06 07:59:00	11.87	Account	USD	3058
210	210	2021-09-27 04:17:00	10.54	Card	RON	1182
211	211	2021-11-25 03:56:00	1.33	Account	EURO	5474
212	212	2021-10-22 02:10:00	10.56	Card	USD	4181
213	213	2022-10-28 08:19:00	6.72	Account	RON	0329
214	214	2021-12-27 00:18:00	5.57	Card	EURO	8189
215	215	2021-06-13 00:52:00	8.23	Account	USD	8315
216	216	2022-01-02 01:11:00	17.52	Card	RON	1413
217	217	2022-08-09 01:22:00	5.85	Account	EURO	2131
218	218	2021-07-04 09:41:00	9.05	Card	USD	2543
219	219	2022-07-27 08:49:00	3.38	Account	RON	0991
220	220	2021-12-24 00:12:00	14.03	Card	EURO	4579
221	221	2021-03-22 08:40:00	9.56	Account	USD	8640
222	222	2022-12-16 11:53:00	6.05	Card	RON	0967
223	223	2021-12-13 08:28:00	19.06	Account	EURO	6413
224	224	2021-11-20 11:25:00	16.78	Card	USD	4878
225	225	2021-03-04 04:53:00	6.89	Account	RON	1522
226	226	2022-02-17 07:49:00	14.45	Card	EURO	3904
227	227	2022-07-29 07:19:00	17.39	Account	USD	1002
228	228	2021-03-31 10:12:00	14.75	Card	RON	5268
229	229	2022-06-12 04:20:00	3.07	Account	EURO	3280
230	230	2022-02-09 06:25:00	9.88	Card	USD	5144
231	231	2021-08-10 03:49:00	19.97	Account	RON	9876
232	232	2022-03-08 07:14:00	14.81	Card	EURO	8996
233	233	2022-10-03 02:11:00	9.53	Account	USD	5873
234	234	2022-09-22 04:50:00	14.83	Card	RON	0534
235	235	2022-02-08 03:24:00	10.22	Account	EURO	2775
236	236	2022-05-26 09:25:00	18.85	Card	USD	8179
237	237	2021-06-25 11:59:00	2.47	Account	RON	3292
238	238	2022-06-22 02:28:00	8.76	Card	EURO	7151
239	239	2022-01-06 00:59:00	3.46	Account	USD	1780
240	240	2021-09-27 10:22:00	19.00	Card	RON	1428
241	241	2021-11-25 02:27:00	7.01	Account	EURO	2395
242	242	2021-10-22 00:47:00	10.07	Card	USD	2034
243	243	2022-10-28 02:20:00	17.90	Account	RON	6483
244	244	2021-12-27 03:20:00	17.89	Card	EURO	1953
245	245	2021-06-13 11:12:00	19.59	Account	USD	8874
246	246	2022-01-02 01:10:00	8.61	Card	RON	2032
247	247	2022-08-09 02:10:00	16.99	Account	EURO	9999
248	248	2021-07-04 11:22:00	7.76	Card	USD	1758
249	249	2022-07-27 04:42:00	16.80	Account	RON	2950
250	250	2021-12-24 05:42:00	16.86	Card	EURO	6310
251	251	2021-03-22 11:44:00	10.04	Account	USD	6582
252	252	2022-12-16 03:26:00	3.57	Card	RON	2619
253	253	2021-12-13 04:33:00	16.15	Account	EURO	7049
254	254	2021-11-20 10:32:00	15.79	Card	USD	8299
255	255	2021-03-04 07:47:00	14.97	Account	RON	0298
256	256	2022-02-17 00:28:00	3.16	Card	EURO	3201
257	257	2022-07-29 10:51:00	10.97	Account	USD	1085
258	258	2021-03-31 08:19:00	16.74	Card	RON	1761
259	259	2022-06-12 08:47:00	13.41	Account	EURO	9524
260	260	2022-02-09 03:19:00	11.56	Card	USD	9813
261	261	2021-08-10 00:22:00	12.28	Account	RON	0979
262	262	2022-03-08 08:55:00	4.59	Card	EURO	6697
263	263	2022-10-03 09:17:00	13.82	Account	USD	6113
264	264	2022-09-22 09:26:00	9.07	Card	RON	3040
265	265	2022-02-08 11:13:00	16.49	Account	EURO	6426
266	266	2022-05-26 04:44:00	2.07	Card	USD	1786
267	267	2021-06-25 09:28:00	2.66	Account	RON	2372
268	268	2022-06-22 07:23:00	4.94	Card	EURO	1721
269	269	2022-01-06 01:40:00	9.44	Account	USD	8114
270	270	2021-09-27 01:18:00	19.23	Card	RON	1007
271	271	2022-02-01 10:19:00	14.24	Account	EURO	1160
272	272	2022-02-01 11:29:00	13.19	Card	USD	3874
273	273	2022-10-28 06:27:00	16.49	Account	RON	5047
274	274	2022-02-01 09:40:00	7.59	Card	EURO	5028
275	275	2022-02-01 00:57:00	5.15	Account	USD	2973
276	276	2022-02-01 01:46:00	4.97	Card	RON	4689
277	277	2022-08-09 11:48:00	11.94	Account	EURO	7970
278	278	2022-02-01 11:47:00	6.49	Card	USD	0738
279	279	2022-07-27 08:45:00	6.73	Account	RON	7078
280	280	2022-02-01 04:18:00	9.83	Card	EURO	7357
281	281	2022-02-01 09:56:00	10.41	Account	USD	1754
282	282	2022-12-16 10:13:00	18.03	Card	RON	8860
283	283	2022-02-01 01:47:00	8.47	Account	EURO	0652
284	284	2022-02-01 11:21:00	14.26	Card	USD	0636
285	285	2022-02-01 01:30:00	14.00	Account	RON	5540
286	286	2022-02-17 10:13:00	3.82	Card	EURO	6417
287	287	2022-07-29 10:48:00	16.22	Account	USD	6368
288	288	2022-02-01 04:28:00	19.06	Card	RON	5555
289	289	2022-06-12 08:13:00	18.70	Account	EURO	7973
290	290	2022-02-09 11:27:00	6.29	Card	USD	3435
291	291	2022-02-01 11:59:00	7.41	Account	RON	6720
292	292	2022-03-08 11:59:00	8.43	Card	EURO	1337
293	293	2022-10-03 00:13:00	7.22	Account	USD	1636
294	294	2022-09-22 06:26:00	17.47	Card	RON	2887
295	295	2022-02-08 00:37:00	1.87	Account	EURO	3743
296	296	2022-05-26 00:27:00	7.13	Card	USD	8897
297	297	2022-02-01 05:59:00	8.74	Account	RON	8084
298	298	2022-06-22 07:46:00	1.54	Card	EURO	3551
299	299	2022-02-01 06:58:00	18.18	Account	USD	0478
300	300	2022-02-01 03:38:00	12.00	Card	RON	6026
301	301	2021-11-25 09:50:00	5.04	Account	EURO	1555
302	302	2021-10-22 09:51:00	8.92	Card	USD	8777
303	303	2022-10-28 04:17:00	6.47	Account	RON	7639
304	304	2021-12-27 03:53:00	16.13	Card	EURO	4386
305	305	2021-06-13 05:27:00	12.83	Account	USD	9509
306	306	2022-01-02 02:46:00	11.61	Card	RON	9395
307	307	2022-08-09 09:42:00	8.26	Account	EURO	6122
308	308	2021-07-04 01:46:00	15.49	Card	USD	1664
309	309	2022-07-27 02:17:00	17.92	Account	RON	5920
310	310	2021-12-24 09:27:00	4.77	Card	EURO	1753
311	311	2021-03-22 03:21:00	13.80	Account	USD	3723
312	312	2022-12-16 07:20:00	5.68	Card	RON	4346
313	313	2021-12-13 04:11:00	3.64	Account	EURO	0741
314	314	2021-11-20 07:44:00	7.42	Card	USD	8427
315	315	2021-03-04 02:22:00	1.10	Account	RON	4025
316	316	2022-02-17 06:46:00	3.27	Card	EURO	4650
317	317	2022-07-29 08:27:00	18.54	Account	USD	0363
318	318	2021-03-31 01:18:00	2.93	Card	RON	1704
319	319	2022-06-12 00:36:00	18.00	Account	EURO	7758
320	320	2022-02-09 06:59:00	19.45	Card	USD	2116
321	321	2021-08-10 08:23:00	5.35	Account	RON	1924
322	322	2022-03-08 04:45:00	18.28	Card	EURO	6340
323	323	2022-10-03 07:48:00	7.35	Account	USD	5312
324	324	2022-09-22 06:17:00	19.49	Card	RON	8466
325	325	2022-02-08 05:13:00	3.07	Account	EURO	5929
326	326	2022-05-26 06:26:00	13.91	Card	USD	1248
327	327	2021-06-25 08:12:00	7.55	Account	RON	5438
328	328	2022-06-22 09:45:00	4.43	Card	EURO	0966
329	329	2022-01-06 07:45:00	5.41	Account	USD	6814
330	330	2021-09-27 01:57:00	16.22	Card	RON	6913
331	331	2021-11-25 07:54:00	13.90	Account	EURO	7682
332	332	2021-10-22 06:43:00	15.15	Card	USD	2624
333	333	2022-10-28 08:14:00	7.54	Account	RON	0792
334	334	2021-12-27 04:53:00	16.60	Card	EURO	0737
335	335	2021-06-13 05:43:00	3.14	Account	USD	8493
336	336	2022-01-02 07:31:00	19.08	Card	RON	8318
337	337	2022-08-09 01:36:00	6.74	Account	EURO	9360
338	338	2021-07-04 08:24:00	1.18	Card	USD	1716
339	339	2022-07-27 05:29:00	7.56	Account	RON	9586
340	340	2021-12-24 05:39:00	8.01	Card	EURO	9105
341	341	2021-03-22 01:15:00	10.00	Account	USD	9471
342	342	2022-12-16 07:43:00	16.48	Card	RON	3891
343	343	2021-12-13 08:14:00	11.20	Account	EURO	8335
344	344	2021-11-20 09:19:00	19.33	Card	USD	7187
345	345	2021-03-04 05:37:00	18.64	Account	RON	8479
346	346	2022-02-17 05:17:00	8.85	Card	EURO	8289
347	347	2022-07-29 04:29:00	7.98	Account	USD	8367
348	348	2021-03-31 02:32:00	3.09	Card	RON	3668
349	349	2022-06-12 06:16:00	18.77	Account	EURO	0421
350	350	2022-02-09 06:48:00	16.55	Card	USD	0948
351	351	2021-08-10 08:36:00	7.45	Account	RON	7163
352	352	2022-03-08 02:43:00	4.09	Card	EURO	3764
353	353	2022-10-03 11:24:00	3.76	Account	USD	6604
354	354	2022-09-22 01:48:00	9.94	Card	RON	9954
355	355	2022-02-08 06:39:00	18.38	Account	EURO	5459
356	356	2022-05-26 03:10:00	18.38	Card	USD	3667
357	357	2021-06-25 02:16:00	18.51	Account	RON	9557
358	358	2022-06-22 02:37:00	1.85	Card	EURO	4560
359	359	2022-01-06 01:36:00	16.41	Account	USD	4997
360	360	2021-09-27 00:15:00	6.64	Card	RON	6982
361	361	2021-11-25 10:16:00	3.21	Account	EURO	1495
362	362	2021-11-11 05:58:00	6.21	Card	USD	4222
363	363	2022-10-28 06:47:00	12.60	Account	RON	6744
364	364	2021-12-27 03:59:00	1.99	Card	EURO	0004
365	365	2021-11-11 09:18:00	6.73	Account	USD	8226
366	366	2022-01-02 09:32:00	12.89	Card	RON	0232
367	367	2022-08-09 01:47:00	15.14	Account	EURO	6329
368	368	2021-11-11 03:49:00	8.89	Card	USD	0799
369	369	2022-07-27 01:29:00	5.74	Account	RON	4988
370	370	2021-12-24 07:51:00	14.56	Card	EURO	5681
371	371	2021-11-11 11:34:00	2.40	Account	USD	6063
372	372	2022-12-16 06:11:00	8.51	Card	RON	0577
373	373	2021-12-13 11:25:00	9.39	Account	EURO	5435
374	374	2021-11-20 06:57:00	6.47	Card	USD	3869
375	375	2021-11-11 10:18:00	6.49	Account	RON	7992
376	376	2022-02-17 07:56:00	15.56	Card	EURO	6823
377	377	2022-07-29 00:46:00	4.76	Account	USD	2889
378	378	2021-11-11 03:31:00	19.45	Card	RON	1599
379	379	2022-06-12 07:30:00	3.39	Account	EURO	0613
380	380	2022-02-09 10:43:00	13.12	Card	USD	8804
381	381	2021-11-11 01:29:00	11.42	Account	RON	0192
382	382	2022-03-08 08:36:00	11.96	Card	EURO	4857
383	383	2022-10-03 08:25:00	7.47	Account	USD	0194
384	384	2022-09-22 07:19:00	18.05	Card	RON	2695
385	385	2022-02-08 00:41:00	12.08	Account	EURO	2644
386	386	2022-05-26 07:53:00	5.16	Card	USD	3442
387	387	2021-11-11 04:36:00	6.64	Account	RON	1605
388	388	2022-06-22 10:54:00	12.16	Card	EURO	0176
389	389	2022-01-06 11:33:00	7.02	Account	USD	1990
390	390	2021-11-11 02:54:00	8.31	Card	RON	3392
391	391	2021-11-25 05:52:00	15.90	Account	EURO	4522
392	392	2021-10-22 06:59:00	19.89	Card	USD	4265
393	393	2022-10-28 01:19:00	5.29	Account	RON	9936
394	394	2021-12-27 01:49:00	8.18	Card	EURO	3745
395	395	2021-06-13 01:29:00	19.95	Account	USD	0053
396	396	2022-01-02 02:10:00	1.40	Card	RON	7702
397	397	2022-08-09 08:12:00	3.30	Account	EURO	6343
398	398	2021-07-04 01:11:00	11.08	Card	USD	7249
399	399	2022-07-27 10:19:00	12.32	Account	RON	0028
400	400	2021-12-24 03:52:00	4.26	Card	EURO	7411
401	401	2021-03-22 09:23:00	1.85	Account	USD	8957
402	402	2022-12-16 07:32:00	18.74	Card	RON	2970
403	403	2021-12-13 08:55:00	5.15	Account	EURO	8836
404	404	2021-11-20 11:14:00	18.16	Card	USD	5211
405	405	2021-03-04 00:13:00	19.84	Account	RON	0349
406	406	2022-02-17 01:38:00	4.97	Card	EURO	0668
407	407	2022-07-29 07:28:00	12.26	Account	USD	7857
408	408	2021-03-31 06:12:00	18.74	Card	RON	5539
409	409	2022-06-12 04:53:00	9.07	Account	EURO	3602
410	410	2022-02-09 10:11:00	13.08	Card	USD	8798
411	411	2021-08-10 04:50:00	6.76	Account	RON	0931
412	412	2022-03-08 01:19:00	2.59	Card	EURO	3808
413	413	2022-10-03 05:25:00	1.13	Account	USD	5254
414	414	2022-09-22 01:23:00	3.85	Card	RON	8666
415	415	2022-02-08 03:45:00	7.14	Account	EURO	7293
416	416	2022-05-26 07:48:00	10.20	Card	USD	9505
417	417	2021-06-25 10:49:00	13.85	Account	RON	4278
418	418	2022-06-22 02:53:00	6.32	Card	EURO	5865
419	419	2022-01-06 00:41:00	11.79	Account	USD	8931
420	420	2021-09-27 03:38:00	17.52	Card	RON	7625
421	421	2021-11-25 11:46:00	8.87	Account	EURO	4620
422	422	2021-10-22 03:24:00	15.10	Card	USD	5111
423	423	2022-10-28 11:44:00	19.55	Account	RON	0082
424	424	2021-12-27 01:29:00	5.83	Card	EURO	7850
425	425	2021-06-13 08:27:00	8.12	Account	USD	3891
426	426	2022-01-02 09:33:00	4.21	Card	RON	8682
427	427	2022-08-09 06:35:00	17.94	Account	EURO	2106
428	428	2021-07-04 05:35:00	19.71	Card	USD	3757
429	429	2022-07-27 10:12:00	16.52	Account	RON	9871
430	430	2021-12-24 08:23:00	10.25	Card	EURO	7617
431	431	2021-03-22 09:47:00	11.73	Account	USD	5404
432	432	2022-12-16 02:43:00	18.23	Card	RON	1723
433	433	2021-12-13 06:21:00	5.31	Account	EURO	1675
434	434	2021-11-20 09:36:00	9.69	Card	USD	1360
435	435	2021-03-04 09:28:00	10.55	Account	RON	7959
436	436	2022-02-17 10:35:00	19.42	Card	EURO	8254
437	437	2022-07-29 06:13:00	16.86	Account	USD	6680
438	438	2021-03-31 06:51:00	1.25	Card	RON	9365
439	439	2022-06-12 00:25:00	11.73	Account	EURO	3286
440	440	2022-02-09 10:30:00	3.44	Card	USD	3503
441	441	2021-08-10 05:36:00	12.56	Account	RON	1014
442	442	2022-03-08 00:31:00	12.62	Card	EURO	1778
443	443	2022-10-03 04:20:00	7.74	Account	USD	3650
444	444	2022-09-22 06:55:00	14.82	Card	RON	9370
445	445	2022-02-08 01:37:00	4.60	Account	EURO	8304
446	446	2022-05-26 02:45:00	12.75	Card	USD	3251
447	447	2021-06-25 10:47:00	1.06	Account	RON	2902
448	448	2022-06-22 08:11:00	11.38	Card	EURO	6406
449	449	2022-01-06 10:48:00	3.02	Account	USD	3998
450	450	2021-09-27 01:18:00	16.60	Card	RON	3608
451	451	2021-11-25 10:34:00	11.39	Account	EURO	7198
452	452	2021-10-22 09:29:00	12.66	Card	USD	4630
453	453	2022-10-28 11:45:00	11.95	Account	RON	6882
454	454	2021-12-27 02:32:00	12.23	Card	EURO	4565
455	455	2021-06-13 01:28:00	13.81	Account	USD	8813
456	456	2022-01-02 10:27:00	5.70	Card	RON	3576
457	457	2022-08-09 09:58:00	3.16	Account	EURO	0277
458	458	2021-07-04 05:28:00	1.54	Card	USD	1819
459	459	2022-07-27 10:29:00	10.91	Account	RON	6343
460	460	2021-12-24 02:33:00	10.34	Card	EURO	1965
461	461	2021-03-22 11:16:00	19.12	Account	USD	3700
462	462	2022-12-16 03:52:00	17.48	Card	RON	3336
463	463	2021-12-13 03:50:00	11.98	Account	EURO	9016
464	464	2021-11-20 11:25:00	10.17	Card	USD	0364
465	465	2021-03-04 02:16:00	7.55	Account	RON	2752
466	466	2022-02-17 06:57:00	16.59	Card	EURO	5931
467	467	2022-07-29 03:22:00	18.20	Account	USD	7538
468	468	2021-03-31 02:43:00	5.99	Card	RON	4517
469	469	2022-06-12 00:38:00	14.19	Account	EURO	3795
470	470	2022-02-09 11:43:00	10.06	Card	USD	3719
471	471	2021-08-10 03:59:00	13.66	Account	RON	7633
472	472	2022-03-08 01:32:00	17.44	Card	EURO	5872
473	473	2022-10-03 08:45:00	3.16	Account	USD	9700
474	474	2022-09-22 03:36:00	18.69	Card	RON	2893
475	475	2022-02-08 00:36:00	16.49	Account	EURO	2199
476	476	2022-05-26 02:48:00	1.45	Card	USD	2387
477	477	2021-06-25 11:19:00	15.89	Account	RON	1880
478	478	2022-06-22 09:39:00	5.78	Card	EURO	8294
479	479	2022-01-06 05:17:00	6.16	Account	USD	4785
480	480	2021-09-27 07:19:00	7.40	Card	RON	0179
481	481	2021-11-25 07:44:00	1.80	Account	EURO	4443
482	482	2021-10-22 08:37:00	5.48	Card	USD	9104
483	483	2022-10-28 07:34:00	14.39	Account	RON	0728
484	484	2021-12-27 08:20:00	10.24	Card	EURO	8203
485	485	2021-06-13 09:27:00	12.15	Account	USD	3019
486	486	2022-01-02 11:17:00	3.16	Card	RON	7862
487	487	2022-08-09 01:52:00	13.52	Account	EURO	9265
488	488	2021-07-04 03:14:00	11.23	Card	USD	1685
489	489	2022-07-27 08:45:00	4.64	Account	RON	1431
490	490	2021-12-24 04:47:00	14.40	Card	EURO	0206
491	491	2021-03-22 09:40:00	7.92	Account	USD	2969
492	492	2022-12-16 09:45:00	16.54	Card	RON	6220
493	493	2021-12-13 00:31:00	14.16	Account	EURO	6569
494	494	2021-11-20 09:44:00	3.29	Card	USD	5137
495	495	2021-03-04 08:38:00	1.76	Account	RON	4032
496	496	2022-02-17 11:41:00	9.32	Card	EURO	0105
497	497	2022-07-29 08:48:00	19.71	Account	USD	4570
498	498	2021-03-31 09:23:00	17.01	Card	RON	5592
499	499	2022-06-12 00:40:00	13.34	Account	EURO	0487
500	500	2022-02-09 09:20:00	15.19	Card	USD	1618
501	501	2021-08-10 02:59:00	10.26	Account	RON	4272
502	502	2022-03-08 11:26:00	8.13	Card	EURO	2804
503	503	2022-10-03 07:32:00	13.47	Account	USD	4444
504	504	2022-09-22 08:47:00	15.22	Card	RON	2511
505	505	2022-02-08 02:12:00	3.10	Account	EURO	2806
506	506	2022-05-26 01:21:00	18.80	Card	USD	9740
507	507	2021-06-25 08:53:00	1.91	Account	RON	7142
508	508	2022-06-22 06:48:00	10.36	Card	EURO	9988
509	509	2022-01-06 04:11:00	17.60	Account	USD	0668
510	510	2021-09-27 11:59:00	5.29	Card	RON	1079
511	511	2021-11-25 11:23:00	1.21	Account	EURO	6949
512	512	2021-10-22 07:27:00	1.09	Card	USD	5816
513	513	2022-10-28 11:17:00	3.36	Account	RON	7723
514	514	2021-12-27 09:15:00	10.58	Card	EURO	4292
515	515	2021-06-13 03:14:00	18.97	Account	USD	2195
516	516	2022-01-02 07:30:00	16.97	Card	RON	8935
517	517	2022-08-09 06:36:00	7.48	Account	EURO	5922
518	518	2021-07-04 04:40:00	17.10	Card	USD	5305
519	519	2022-07-27 00:45:00	3.26	Account	RON	4328
520	520	2021-12-24 10:21:00	3.35	Card	EURO	5509
521	521	2021-03-22 04:17:00	5.87	Account	USD	9611
522	522	2022-12-16 08:50:00	4.29	Card	RON	4105
523	523	2021-12-13 02:58:00	12.14	Account	EURO	1123
524	524	2021-11-20 04:41:00	5.20	Card	USD	3999
525	525	2021-03-04 02:25:00	11.03	Account	RON	4485
526	526	2022-02-17 03:18:00	17.66	Card	EURO	7325
527	527	2022-07-29 02:51:00	15.34	Account	USD	1653
528	528	2021-03-31 09:25:00	14.44	Card	RON	7682
529	529	2022-06-12 05:59:00	18.86	Account	EURO	7512
530	530	2022-02-09 07:23:00	8.08	Card	USD	4424
531	531	2021-08-10 04:33:00	7.36	Account	RON	8425
532	532	2022-03-08 10:46:00	9.93	Card	EURO	2153
533	533	2022-10-03 04:26:00	6.80	Account	USD	4203
534	534	2022-09-22 01:56:00	11.07	Card	RON	3893
535	535	2022-02-08 11:33:00	1.29	Account	EURO	1293
536	536	2022-05-26 10:21:00	3.26	Card	USD	1849
537	537	2021-06-25 11:15:00	9.01	Account	RON	9253
538	538	2022-06-22 09:36:00	18.79	Card	EURO	1709
539	539	2022-01-06 04:26:00	6.25	Account	USD	1451
540	540	2021-09-27 05:32:00	9.92	Card	RON	1890
541	541	2021-11-25 05:37:00	6.78	Account	EURO	7462
542	542	2021-10-22 06:48:00	4.78	Card	USD	8189
543	543	2022-10-28 07:51:00	7.13	Account	RON	1521
544	544	2021-12-27 09:22:00	13.66	Card	EURO	2489
545	545	2021-06-13 10:37:00	14.47	Account	USD	6135
546	546	2022-01-02 06:33:00	16.55	Card	RON	4401
547	547	2022-08-09 00:18:00	17.75	Account	EURO	1473
548	548	2021-07-04 02:39:00	2.36	Card	USD	8137
549	549	2022-07-27 08:27:00	11.61	Account	RON	9300
550	550	2021-12-24 05:13:00	3.88	Card	EURO	2395
551	551	2021-03-22 00:40:00	4.06	Account	USD	9911
552	552	2022-12-16 10:51:00	4.32	Card	RON	4363
553	553	2021-12-13 00:40:00	14.71	Account	EURO	7087
554	554	2021-11-20 02:46:00	2.93	Card	USD	8860
555	555	2021-03-04 11:21:00	2.11	Account	RON	1414
556	556	2022-02-17 05:20:00	8.16	Card	EURO	8197
557	557	2022-07-29 05:44:00	9.26	Account	USD	1707
558	558	2021-03-31 03:57:00	16.08	Card	RON	8689
559	559	2022-06-12 09:35:00	9.62	Account	EURO	1703
560	560	2022-02-09 04:52:00	13.25	Card	USD	7783
561	561	2021-08-10 05:31:00	18.16	Account	RON	8540
562	562	2022-03-08 11:50:00	5.20	Card	EURO	3997
563	563	2022-10-03 09:20:00	4.94	Account	USD	7913
564	564	2022-09-22 06:40:00	8.42	Card	RON	2074
565	565	2022-02-08 05:41:00	4.61	Account	EURO	1204
566	566	2022-05-26 10:25:00	15.13	Card	USD	3148
567	567	2021-06-25 04:47:00	12.05	Account	RON	3192
568	568	2022-06-22 09:42:00	8.52	Card	EURO	0845
569	569	2022-01-06 07:24:00	7.63	Account	USD	4675
570	570	2021-09-27 07:54:00	1.18	Card	RON	4438
571	571	2021-11-25 07:11:00	9.65	Account	EURO	7869
572	572	2021-10-22 04:53:00	6.41	Card	USD	8801
573	573	2022-10-28 04:31:00	17.00	Account	RON	3975
574	574	2021-12-27 00:22:00	12.44	Card	EURO	1658
575	575	2021-06-13 11:55:00	17.76	Account	USD	2064
576	576	2022-01-02 06:42:00	15.08	Card	RON	7300
577	577	2022-08-09 02:49:00	8.71	Account	EURO	1265
578	578	2021-07-04 00:30:00	5.74	Card	USD	8206
579	579	2022-07-27 09:21:00	12.11	Account	RON	9042
580	580	2021-12-24 05:59:00	8.78	Card	EURO	3206
581	581	2021-03-22 04:16:00	18.24	Account	USD	9801
582	582	2022-12-16 02:10:00	4.44	Card	RON	4058
583	583	2021-12-13 00:24:00	17.07	Account	EURO	0117
584	584	2021-11-20 05:13:00	17.68	Card	USD	0874
585	585	2021-03-04 00:48:00	5.34	Account	RON	7999
586	586	2022-02-17 01:49:00	18.92	Card	EURO	3566
587	587	2022-07-29 06:13:00	1.52	Account	USD	1629
588	588	2021-03-31 08:19:00	15.63	Card	RON	1319
589	589	2022-06-12 07:25:00	3.52	Account	EURO	9788
590	590	2022-02-09 06:26:00	8.06	Card	USD	4191
591	591	2021-08-10 03:21:00	19.93	Account	RON	2333
592	592	2022-03-08 06:14:00	5.89	Card	EURO	8316
593	593	2022-10-03 04:28:00	6.61	Account	USD	4645
594	594	2022-09-22 00:47:00	19.87	Card	RON	8217
595	595	2022-02-08 03:38:00	7.24	Account	EURO	0546
596	596	2022-05-26 05:47:00	8.52	Card	USD	0327
597	597	2021-06-25 09:25:00	18.68	Account	RON	3347
598	598	2022-06-22 10:56:00	6.59	Card	EURO	1203
599	599	2022-01-06 04:16:00	1.35	Account	USD	5190
600	600	2021-09-27 08:28:00	2.59	Card	RON	4111
601	601	2021-11-25 09:13:00	14.33	Account	EURO	3054
602	602	2021-10-22 10:46:00	2.48	Card	USD	6718
603	603	2022-10-28 09:59:00	7.43	Account	RON	2314
604	604	2021-12-27 09:55:00	10.74	Card	EURO	7766
605	605	2021-06-13 06:33:00	9.37	Account	USD	2099
606	606	2022-01-02 05:18:00	12.10	Card	RON	3574
607	607	2022-08-09 03:59:00	13.69	Account	EURO	0981
608	608	2021-07-04 10:35:00	3.39	Card	USD	7820
609	609	2022-07-27 10:49:00	8.33	Account	RON	9047
610	610	2021-12-24 02:46:00	16.67	Card	EURO	3564
611	611	2021-03-22 03:12:00	6.09	Account	USD	2255
612	612	2022-12-16 11:34:00	15.85	Card	RON	8760
613	613	2021-12-13 05:22:00	7.68	Account	EURO	8495
614	614	2021-11-20 09:34:00	13.06	Card	USD	2406
615	615	2021-03-04 07:44:00	1.17	Account	RON	1764
616	616	2022-02-17 08:38:00	5.73	Card	EURO	1233
617	617	2022-07-29 11:28:00	10.27	Account	USD	5366
618	618	2021-03-31 03:33:00	2.33	Card	RON	6693
619	619	2022-06-12 06:19:00	10.63	Account	EURO	7937
620	620	2022-02-09 01:30:00	18.40	Card	USD	9607
621	621	2021-08-10 08:50:00	15.33	Account	RON	8365
622	622	2022-03-08 11:44:00	9.66	Card	EURO	5066
623	623	2022-10-03 08:20:00	19.22	Account	USD	0629
624	624	2022-09-22 10:40:00	15.18	Card	RON	6007
625	625	2022-02-08 11:38:00	7.65	Account	EURO	3433
626	626	2022-05-26 10:51:00	5.06	Card	USD	4021
627	627	2021-06-25 07:59:00	9.26	Account	RON	6404
628	628	2022-06-22 10:48:00	16.88	Card	EURO	6963
629	629	2022-01-06 01:30:00	16.71	Account	USD	0063
630	630	2021-09-27 03:32:00	12.20	Card	RON	0611
631	631	2021-11-25 11:12:00	18.62	Account	EURO	7844
632	632	2021-10-22 10:53:00	14.37	Card	USD	7605
633	633	2022-10-28 10:18:00	9.77	Account	RON	5448
634	634	2021-12-27 03:37:00	19.02	Card	EURO	3691
635	635	2021-06-13 05:24:00	18.87	Account	USD	0677
636	636	2022-01-02 04:26:00	13.82	Card	RON	3440
637	637	2022-08-09 11:50:00	14.45	Account	EURO	2348
638	638	2021-07-04 09:33:00	2.41	Card	USD	8581
639	639	2022-07-27 11:45:00	18.96	Account	RON	7778
640	640	2021-12-24 07:19:00	9.03	Card	EURO	0827
641	641	2021-03-22 02:50:00	5.46	Account	USD	5559
642	642	2022-12-16 00:14:00	8.63	Card	RON	0545
643	643	2021-12-13 10:53:00	18.93	Account	EURO	6212
644	644	2021-11-20 03:44:00	6.84	Card	USD	7205
645	645	2021-03-04 11:55:00	6.16	Account	RON	7985
646	646	2022-02-17 11:36:00	5.67	Card	EURO	4609
647	647	2022-07-29 10:15:00	11.71	Account	USD	8268
648	648	2021-03-31 00:35:00	18.78	Card	RON	9713
649	649	2022-06-12 09:46:00	18.75	Account	EURO	7386
650	650	2022-02-09 07:55:00	11.81	Card	USD	5539
651	651	2021-08-10 05:52:00	18.19	Account	RON	0102
652	652	2022-03-08 00:19:00	7.97	Card	EURO	8071
653	653	2022-10-03 05:59:00	5.20	Account	USD	4847
654	654	2022-09-22 02:37:00	14.19	Card	RON	9302
655	655	2022-02-08 09:10:00	18.17	Account	EURO	0821
656	656	2022-05-26 08:35:00	6.63	Card	USD	6074
657	657	2021-06-25 00:44:00	7.15	Account	RON	8722
658	658	2022-06-22 11:12:00	15.13	Card	EURO	6419
659	659	2022-01-06 06:35:00	3.14	Account	USD	4230
660	660	2021-09-27 02:45:00	1.83	Card	RON	4483
661	661	2021-11-25 01:17:00	5.46	Account	EURO	4012
662	662	2021-10-22 02:48:00	12.01	Card	USD	7800
663	663	2022-10-28 06:17:00	13.92	Account	RON	3696
664	664	2021-12-27 08:39:00	19.59	Card	EURO	1546
665	665	2021-06-13 05:23:00	10.73	Account	USD	5935
666	666	2022-01-02 04:15:00	11.14	Card	RON	6770
667	667	2022-08-09 03:56:00	7.18	Account	EURO	4011
668	668	2021-07-04 00:54:00	13.87	Card	USD	4258
669	669	2022-07-27 08:27:00	18.42	Account	RON	1074
670	670	2021-12-24 04:34:00	12.43	Card	EURO	8935
671	671	2021-03-22 06:56:00	12.94	Account	USD	3146
672	672	2022-12-16 04:59:00	1.62	Card	RON	3385
673	673	2021-12-13 08:13:00	12.80	Account	EURO	4947
674	674	2021-11-20 09:48:00	5.30	Card	USD	8189
675	675	2021-03-04 03:19:00	2.60	Account	RON	7412
676	676	2022-02-17 05:25:00	1.31	Card	EURO	2619
677	677	2022-07-29 11:34:00	6.59	Account	USD	0019
678	678	2021-03-31 05:16:00	18.09	Card	RON	8848
679	679	2022-06-12 00:35:00	17.36	Account	EURO	7594
680	680	2022-02-09 02:11:00	12.82	Card	USD	9010
681	681	2021-08-10 08:17:00	4.86	Account	RON	6614
682	682	2022-03-08 08:39:00	1.09	Card	EURO	3229
683	683	2022-10-03 09:55:00	9.91	Account	USD	4486
684	684	2022-09-22 08:26:00	2.02	Card	RON	9755
685	685	2022-02-08 09:56:00	1.51	Account	EURO	9075
686	686	2022-05-26 04:25:00	11.89	Card	USD	3294
687	687	2021-06-25 10:17:00	18.95	Account	RON	3957
688	688	2022-06-22 04:24:00	11.31	Card	EURO	4835
689	689	2022-01-06 08:32:00	6.40	Account	USD	4141
690	690	2021-09-27 06:52:00	17.31	Card	RON	4715
691	691	2021-11-25 03:43:00	2.01	Account	EURO	7013
692	692	2021-10-22 00:26:00	1.01	Card	USD	0646
693	693	2022-10-28 10:41:00	6.03	Account	RON	3866
694	694	2021-12-27 01:52:00	6.30	Card	EURO	1439
695	695	2021-09-05 08:24:00	14.42	Account	USD	8076
696	696	2022-01-02 10:29:00	13.71	Card	RON	4701
697	697	2022-08-09 07:59:00	5.10	Account	EURO	6830
698	698	2021-09-05 08:39:00	4.08	Card	USD	7278
699	699	2022-07-27 09:22:00	7.06	Account	RON	1565
700	700	2021-12-24 09:37:00	17.58	Card	EURO	2169
701	701	2021-09-05 09:41:00	13.47	Account	USD	4796
702	702	2022-12-16 05:24:00	6.05	Card	RON	1157
703	703	2021-12-13 04:21:00	9.50	Account	EURO	4911
704	704	2021-11-20 00:52:00	16.23	Card	USD	1422
705	705	2021-09-05 09:51:00	9.64	Account	RON	5005
706	706	2022-02-17 02:29:00	16.33	Card	EURO	2520
707	707	2022-07-29 05:14:00	8.69	Account	USD	3013
708	708	2021-09-05 11:30:00	17.89	Card	RON	3150
709	709	2022-06-12 09:29:00	1.47	Account	EURO	5986
710	710	2022-02-09 06:39:00	6.24	Card	USD	5398
711	711	2021-09-05 02:18:00	18.50	Account	RON	8687
712	712	2022-03-08 09:24:00	18.67	Card	EURO	1376
713	713	2022-10-03 02:39:00	5.87	Account	USD	0203
714	714	2022-09-22 02:14:00	16.66	Card	RON	4648
715	715	2022-02-08 04:55:00	3.05	Account	EURO	8832
716	716	2022-05-26 10:54:00	11.87	Card	USD	0465
717	717	2021-09-05 02:17:00	9.32	Account	RON	2337
718	718	2022-06-22 05:47:00	10.49	Card	EURO	8725
719	719	2022-01-06 01:14:00	12.33	Account	USD	4136
720	720	2021-09-27 06:53:00	13.33	Card	RON	4826
721	721	2021-11-25 08:27:00	11.18	Account	EURO	9290
722	722	2021-10-22 04:29:00	10.65	Card	USD	9661
723	723	2022-10-28 03:38:00	15.32	Account	RON	5243
724	724	2021-12-27 09:10:00	16.91	Card	EURO	6206
725	725	2021-06-13 11:12:00	15.11	Account	USD	9074
726	726	2022-01-02 10:36:00	12.24	Card	RON	5873
727	727	2022-08-09 06:59:00	5.48	Account	EURO	8139
728	728	2021-07-04 02:19:00	4.47	Card	USD	4915
729	729	2022-07-27 03:56:00	8.05	Account	RON	9752
730	730	2021-12-24 08:17:00	12.43	Card	EURO	4930
731	731	2021-03-22 01:49:00	11.23	Account	USD	9262
732	732	2022-12-16 11:20:00	5.04	Card	RON	7135
733	733	2021-12-13 06:59:00	19.38	Account	EURO	0517
734	734	2021-11-20 00:56:00	19.16	Card	USD	2896
735	735	2021-03-04 04:36:00	14.69	Account	RON	4578
736	736	2022-02-17 11:24:00	2.71	Card	EURO	4136
737	737	2022-07-29 01:39:00	17.07	Account	USD	1828
738	738	2021-03-31 02:44:00	12.41	Card	RON	5808
739	739	2022-06-12 11:38:00	3.68	Account	EURO	4233
740	740	2022-02-09 04:24:00	6.74	Card	USD	8710
741	741	2021-08-10 11:52:00	19.46	Account	RON	2520
742	742	2022-03-08 10:19:00	18.19	Card	EURO	8203
743	743	2022-10-03 01:34:00	8.82	Account	USD	9348
744	744	2022-09-22 11:16:00	15.12	Card	RON	4239
745	745	2022-02-08 07:39:00	17.03	Account	EURO	4679
746	746	2022-05-26 01:47:00	9.18	Card	USD	0427
747	747	2021-06-25 07:13:00	6.57	Account	RON	5251
748	748	2022-06-22 06:12:00	9.09	Card	EURO	4704
749	749	2022-01-06 11:53:00	16.57	Account	USD	0361
750	750	2021-09-27 05:26:00	15.37	Card	RON	6815
\.


--
-- Data for Name: rentals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rentals (rentalid, userid, bikeid, starttime, endtime, startlocation, endlocation, status) FROM stdin;
2	2	2	2021-10-22 02:00:00	2021-10-22 02:22:00	Location 9	Location 9	Success
3	2	3	2022-10-28 01:00:00	2022-10-28 01:45:00	Location 2	Location 6	Success
4	2	4	2021-12-27 02:00:00	2021-12-27 02:35:00	Location 4	Location 3	Success
5	2	5	2021-06-13 01:00:00	2021-06-13 01:14:00	Location 8	Location 6	Success
6	2	6	2022-01-02 01:00:00	2022-01-02 01:13:00	Location 5	Location 4	Success
7	2	7	2022-08-09 04:00:00	2022-08-09 04:10:00	Location 10	Location 10	Success
8	2	8	2021-07-04 05:00:00	2021-07-04 05:19:00	Location 5	Location 8	Success
9	2	9	2022-07-27 11:00:00	2022-07-27 11:43:00	Location 10	Location 3	Success
10	2	10	2021-12-24 07:00:00	2021-12-24 07:38:00	Location 2	Location 10	Success
11	2	11	2021-03-22 00:00:00	2021-03-22 00:55:00	Location 3	Location 7	Success
12	2	12	2022-12-16 02:00:00	2022-12-16 02:40:00	Location 3	Location 5	Success
13	2	13	2021-12-13 03:00:00	2021-12-13 03:40:00	Location 9	Location 8	Success
14	2	14	2021-11-20 04:00:00	2021-11-20 04:40:00	Location 6	Location 6	Success
15	2	15	2021-03-04 02:00:00	2021-03-04 02:34:00	Location 4	Location 3	Success
16	2	16	2022-02-17 11:00:00	2022-02-17 11:49:00	Location 6	Location 3	Success
17	2	17	2022-07-29 02:00:00	2022-07-29 02:36:00	Location 2	Location 5	Success
18	2	18	2021-03-31 08:00:00	2021-03-31 08:43:00	Location 8	Location 3	Success
19	2	19	2022-06-12 07:00:00	2022-06-12 07:44:00	Location 4	Location 6	Success
20	2	20	2022-02-09 09:00:00	2022-02-09 09:58:00	Location 7	Location 3	Success
21	2	21	2021-08-10 00:00:00	2021-08-10 00:13:00	Location 5	Location 9	Success
22	2	22	2022-03-08 04:00:00	2022-03-08 04:19:00	Location 9	Location 3	Success
23	2	23	2022-10-03 09:00:00	2022-10-03 09:47:00	Location 4	Location 9	Success
24	2	24	2022-09-22 01:00:00	2022-09-22 01:44:00	Location 4	Location 6	Success
25	2	25	2022-02-08 09:00:00	2022-02-08 09:37:00	Location 6	Location 3	Success
26	2	26	2022-05-26 06:00:00	2022-05-26 06:14:00	Location 10	Location 5	Success
27	2	27	2021-06-25 11:00:00	2021-06-25 11:40:00	Location 3	Location 3	Success
28	2	28	2022-06-22 01:00:00	2022-06-22 01:32:00	Location 3	Location 10	Success
29	2	29	2022-01-06 10:00:00	2022-01-06 10:32:00	Location 3	Location 1	Success
30	2	30	2021-09-27 06:00:00	2021-09-27 06:58:00	Location 6	Location 7	Success
31	4	1	2021-11-25 07:00:00	2021-11-25 07:11:00	Location 10	Location 9	Success
32	4	2	2021-10-22 05:00:00	2021-10-22 05:20:00	Location 2	Location 10	Success
33	4	3	2022-10-28 06:00:00	2022-10-28 06:22:00	Location 4	Location 9	Success
34	4	4	2021-12-27 05:00:00	2021-12-27 05:12:00	Location 9	Location 7	Success
35	4	5	2021-06-13 06:00:00	2021-06-13 06:31:00	Location 4	Location 9	Success
36	4	6	2022-01-02 06:00:00	2022-01-02 06:22:00	Location 10	Location 5	Success
37	4	7	2022-08-09 07:00:00	2022-08-09 07:35:00	Location 3	Location 2	Success
38	4	8	2021-07-04 02:00:00	2021-07-04 02:58:00	Location 8	Location 2	Success
39	4	9	2022-07-27 06:00:00	2022-07-27 06:59:00	Location 1	Location 7	Success
40	4	10	2021-12-24 04:00:00	2021-12-24 04:45:00	Location 9	Location 9	Success
41	4	11	2021-03-22 00:00:00	2021-03-22 00:31:00	Location 9	Location 9	Success
42	4	12	2022-12-16 03:00:00	2022-12-16 03:45:00	Location 7	Location 3	Success
43	4	13	2021-12-13 10:00:00	2021-12-13 10:43:00	Location 8	Location 8	Success
44	4	14	2021-11-20 02:00:00	2021-11-20 02:52:00	Location 4	Location 3	Success
45	4	15	2021-03-04 02:00:00	2021-03-04 02:46:00	Location 7	Location 9	Success
46	4	16	2022-02-17 03:00:00	2022-02-17 03:14:00	Location 2	Location 3	Success
47	4	17	2022-07-29 09:00:00	2022-07-29 09:51:00	Location 6	Location 3	Success
48	4	18	2021-03-31 09:00:00	2021-03-31 09:57:00	Location 4	Location 3	Success
49	4	19	2022-06-12 00:00:00	2022-06-12 00:44:00	Location 6	Location 2	Success
50	4	20	2022-02-09 04:00:00	2022-02-09 04:58:00	Location 6	Location 9	Success
51	4	21	2021-08-10 03:00:00	2021-08-10 03:52:00	Location 5	Location 4	Success
52	4	22	2022-03-08 09:00:00	2022-03-08 09:50:00	Location 4	Location 2	Success
53	4	23	2022-10-03 02:00:00	2022-10-03 02:52:00	Location 8	Location 7	Success
54	4	24	2022-09-22 03:00:00	2022-09-22 03:55:00	Location 6	Location 9	Success
55	4	25	2022-02-08 04:00:00	2022-02-08 04:38:00	Location 8	Location 3	Success
56	4	26	2022-05-26 11:00:00	2022-05-26 11:55:00	Location 3	Location 10	Success
57	4	27	2021-06-25 07:00:00	2021-06-25 07:23:00	Location 4	Location 5	Success
58	4	28	2022-06-22 05:00:00	2022-06-22 05:31:00	Location 6	Location 10	Success
59	4	29	2022-01-06 06:00:00	2022-01-06 06:17:00	Location 10	Location 10	Success
60	4	30	2021-09-27 04:00:00	2021-09-27 04:54:00	Location 3	Location 5	Success
61	6	1	2021-11-25 07:00:00	2021-11-25 07:46:00	Location 8	Location 2	Success
62	6	2	2021-11-14 08:00:00	2021-11-14 08:59:00	Location 4	Location 9	Success
63	6	3	2022-10-28 04:00:00	2022-10-28 04:50:00	Location 4	Location 4	Success
64	6	4	2021-12-27 00:00:00	2021-12-27 00:49:00	Location 4	Location 5	Success
65	6	5	2021-11-14 03:00:00	2021-11-14 03:45:00	Location 9	Location 9	Success
66	6	6	2022-01-02 02:00:00	2022-01-02 02:22:00	Location 2	Location 4	Success
67	6	7	2022-08-09 01:00:00	2022-08-09 01:12:00	Location 5	Location 5	Success
68	6	8	2021-11-14 06:00:00	2021-11-14 06:28:00	Location 2	Location 10	Success
69	6	9	2022-07-27 02:00:00	2022-07-27 02:59:00	Location 9	Location 4	Success
70	6	10	2021-12-24 00:00:00	2021-12-24 00:45:00	Location 6	Location 5	Success
71	6	11	2021-11-14 05:00:00	2021-11-14 05:16:00	Location 3	Location 10	Success
72	6	12	2022-12-16 05:00:00	2022-12-16 05:52:00	Location 1	Location 5	Success
73	6	13	2021-12-13 02:00:00	2021-12-13 02:30:00	Location 2	Location 3	Success
74	6	14	2021-11-20 07:00:00	2021-11-20 07:43:00	Location 4	Location 2	Success
75	6	15	2021-11-14 02:00:00	2021-11-14 02:21:00	Location 7	Location 3	Success
76	6	16	2022-02-17 04:00:00	2022-02-17 04:33:00	Location 3	Location 10	Success
77	6	17	2022-07-29 00:00:00	2022-07-29 00:54:00	Location 3	Location 2	Success
78	6	18	2021-11-14 06:00:00	2021-11-14 06:56:00	Location 2	Location 6	Success
79	6	19	2022-06-12 04:00:00	2022-06-12 04:56:00	Location 3	Location 5	Success
80	6	20	2022-02-09 03:00:00	2022-02-09 03:30:00	Location 10	Location 1	Success
81	6	21	2021-11-14 11:00:00	2021-11-14 11:16:00	Location 3	Location 6	Success
82	6	22	2022-03-08 11:00:00	2022-03-08 11:38:00	Location 7	Location 6	Success
83	6	23	2022-10-03 05:00:00	2022-10-03 05:47:00	Location 10	Location 5	Success
84	6	24	2022-09-22 01:00:00	2022-09-22 01:40:00	Location 8	Location 2	Success
85	6	25	2022-02-08 11:00:00	2022-02-08 11:43:00	Location 9	Location 6	Success
86	6	26	2022-05-26 03:00:00	2022-05-26 03:31:00	Location 1	Location 6	Success
87	6	27	2021-11-14 04:00:00	2021-11-14 04:40:00	Location 3	Location 6	Success
88	6	28	2022-06-22 09:00:00	2022-06-22 09:41:00	Location 7	Location 6	Success
89	6	29	2022-01-06 11:00:00	2022-01-06 11:45:00	Location 1	Location 3	Success
90	6	30	2021-11-14 09:00:00	2021-11-14 09:10:00	Location 6	Location 3	Success
91	8	1	2022-01-07 09:00:00	2022-01-07 09:46:00	Location 5	Location 5	Success
92	8	2	2022-01-07 11:00:00	2022-01-07 11:34:00	Location 4	Location 5	Success
93	8	3	2022-10-28 00:00:00	2022-10-28 00:38:00	Location 5	Location 9	Success
94	8	4	2022-01-07 03:00:00	2022-01-07 03:58:00	Location 2	Location 4	Success
95	8	5	2022-01-07 03:00:00	2022-01-07 03:52:00	Location 3	Location 7	Success
96	8	6	2022-01-07 11:00:00	2022-01-07 11:28:00	Location 1	Location 4	Success
97	8	7	2022-08-09 00:00:00	2022-08-09 00:35:00	Location 1	Location 10	Success
98	8	8	2022-01-07 04:00:00	2022-01-07 04:32:00	Location 9	Location 2	Success
99	8	9	2022-07-27 01:00:00	2022-07-27 01:22:00	Location 1	Location 8	Success
100	8	10	2022-01-07 11:00:00	2022-01-07 11:59:00	Location 9	Location 9	Success
101	8	11	2022-01-07 04:00:00	2022-01-07 04:58:00	Location 9	Location 8	Success
102	8	12	2022-12-16 07:00:00	2022-12-16 07:21:00	Location 5	Location 9	Success
103	8	13	2022-01-07 02:00:00	2022-01-07 02:38:00	Location 2	Location 5	Success
104	8	14	2022-01-07 09:00:00	2022-01-07 09:16:00	Location 10	Location 5	Success
105	8	15	2022-01-07 04:00:00	2022-01-07 04:12:00	Location 1	Location 9	Success
106	8	16	2022-02-17 03:00:00	2022-02-17 03:35:00	Location 3	Location 7	Success
107	8	17	2022-07-29 02:00:00	2022-07-29 02:21:00	Location 9	Location 4	Success
108	8	18	2022-01-07 01:00:00	2022-01-07 01:28:00	Location 6	Location 8	Success
109	8	19	2022-06-12 10:00:00	2022-06-12 10:12:00	Location 9	Location 9	Success
110	8	20	2022-02-09 10:00:00	2022-02-09 10:41:00	Location 3	Location 8	Success
111	8	21	2022-01-07 01:00:00	2022-01-07 01:44:00	Location 10	Location 4	Success
112	8	22	2022-03-08 03:00:00	2022-03-08 03:45:00	Location 1	Location 4	Success
113	8	23	2022-10-03 11:00:00	2022-10-03 11:31:00	Location 10	Location 1	Success
114	8	24	2022-09-22 07:00:00	2022-09-22 07:26:00	Location 4	Location 7	Success
115	8	25	2022-02-08 07:00:00	2022-02-08 07:47:00	Location 5	Location 1	Success
116	8	26	2022-05-26 08:00:00	2022-05-26 08:54:00	Location 1	Location 6	Success
117	8	27	2022-01-07 10:00:00	2022-01-07 10:32:00	Location 5	Location 7	Success
118	8	28	2022-06-22 09:00:00	2022-06-22 09:35:00	Location 8	Location 6	Success
119	8	29	2022-01-07 01:00:00	2022-01-07 01:52:00	Location 7	Location 8	Success
120	8	30	2022-01-07 04:00:00	2022-01-07 04:41:00	Location 3	Location 7	Success
121	10	1	2021-11-25 04:00:00	2021-11-25 04:55:00	Location 2	Location 3	Success
122	10	2	2021-10-22 07:00:00	2021-10-22 07:44:00	Location 9	Location 9	Success
123	10	3	2022-10-28 00:00:00	2022-10-28 00:58:00	Location 8	Location 10	Success
124	10	4	2021-12-27 05:00:00	2021-12-27 05:35:00	Location 3	Location 9	Success
125	10	5	2021-06-13 00:00:00	2021-06-13 00:45:00	Location 10	Location 9	Success
126	10	6	2022-01-02 05:00:00	2022-01-02 05:16:00	Location 4	Location 7	Success
127	10	7	2022-08-09 11:00:00	2022-08-09 11:49:00	Location 5	Location 8	Success
128	10	8	2021-07-04 06:00:00	2021-07-04 06:11:00	Location 10	Location 4	Success
129	10	9	2022-07-27 01:00:00	2022-07-27 01:49:00	Location 7	Location 1	Success
130	10	10	2021-12-24 03:00:00	2021-12-24 03:24:00	Location 3	Location 3	Success
131	10	11	2021-03-22 05:00:00	2021-03-22 05:18:00	Location 10	Location 5	Success
132	10	12	2022-12-16 05:00:00	2022-12-16 05:36:00	Location 1	Location 6	Success
133	10	13	2021-12-13 06:00:00	2021-12-13 06:18:00	Location 5	Location 2	Success
134	10	14	2021-11-20 10:00:00	2021-11-20 10:10:00	Location 2	Location 8	Success
135	10	15	2021-03-04 05:00:00	2021-03-04 05:16:00	Location 3	Location 7	Success
136	10	16	2022-02-17 01:00:00	2022-02-17 01:25:00	Location 9	Location 5	Success
137	10	17	2022-07-29 08:00:00	2022-07-29 08:43:00	Location 2	Location 1	Success
138	10	18	2021-03-31 04:00:00	2021-03-31 04:57:00	Location 8	Location 6	Success
139	10	19	2022-06-12 11:00:00	2022-06-12 11:43:00	Location 2	Location 1	Success
140	10	20	2022-02-09 03:00:00	2022-02-09 03:39:00	Location 10	Location 6	Success
141	10	21	2021-08-10 09:00:00	2021-08-10 09:52:00	Location 5	Location 8	Success
142	10	22	2022-03-08 11:00:00	2022-03-08 11:13:00	Location 3	Location 5	Success
143	10	23	2022-10-03 05:00:00	2022-10-03 05:41:00	Location 4	Location 10	Success
144	10	24	2022-09-22 06:00:00	2022-09-22 06:16:00	Location 8	Location 10	Success
145	10	25	2022-02-08 03:00:00	2022-02-08 03:50:00	Location 7	Location 3	Success
146	10	26	2022-05-26 02:00:00	2022-05-26 02:49:00	Location 8	Location 1	Success
147	10	27	2021-06-25 00:00:00	2021-06-25 00:44:00	Location 6	Location 10	Success
148	10	28	2022-06-22 06:00:00	2022-06-22 06:34:00	Location 10	Location 8	Success
149	10	29	2022-01-06 08:00:00	2022-01-06 08:53:00	Location 7	Location 9	Success
150	10	30	2021-09-27 07:00:00	2021-09-27 07:24:00	Location 7	Location 1	Success
151	12	1	2021-11-25 11:00:00	2021-11-25 11:56:00	Location 2	Location 5	Success
152	12	2	2021-10-22 10:00:00	2021-10-22 10:13:00	Location 6	Location 9	Success
153	12	3	2022-10-28 07:00:00	2022-10-28 07:20:00	Location 7	Location 8	Success
154	12	4	2021-12-27 02:00:00	2021-12-27 02:34:00	Location 9	Location 7	Success
155	12	5	2021-06-13 02:00:00	2021-06-13 02:15:00	Location 7	Location 4	Success
156	12	6	2022-01-02 11:00:00	2022-01-02 11:38:00	Location 1	Location 3	Success
157	12	7	2022-08-09 06:00:00	2022-08-09 06:39:00	Location 10	Location 9	Success
158	12	8	2021-07-04 02:00:00	2021-07-04 02:40:00	Location 8	Location 1	Success
159	12	9	2022-07-27 05:00:00	2022-07-27 05:55:00	Location 1	Location 5	Success
160	12	10	2021-12-24 05:00:00	2021-12-24 05:24:00	Location 9	Location 8	Success
161	12	11	2021-03-22 06:00:00	2021-03-22 06:44:00	Location 7	Location 10	Success
162	12	12	2022-12-16 04:00:00	2022-12-16 04:16:00	Location 9	Location 1	Success
163	12	13	2021-12-13 07:00:00	2021-12-13 07:30:00	Location 3	Location 9	Success
164	12	14	2021-11-20 01:00:00	2021-11-20 01:52:00	Location 2	Location 5	Success
165	12	15	2021-03-04 03:00:00	2021-03-04 03:35:00	Location 10	Location 5	Success
166	12	16	2022-02-17 08:00:00	2022-02-17 08:57:00	Location 1	Location 10	Success
167	12	17	2022-07-29 10:00:00	2022-07-29 10:11:00	Location 4	Location 9	Success
168	12	18	2021-03-31 10:00:00	2021-03-31 10:17:00	Location 5	Location 7	Success
169	12	19	2022-06-12 00:00:00	2022-06-12 00:31:00	Location 3	Location 2	Success
170	12	20	2022-02-09 10:00:00	2022-02-09 10:48:00	Location 10	Location 7	Success
171	12	21	2021-08-10 08:00:00	2021-08-10 08:51:00	Location 10	Location 7	Success
172	12	22	2022-03-08 08:00:00	2022-03-08 08:57:00	Location 6	Location 3	Success
173	12	23	2022-10-03 02:00:00	2022-10-03 02:56:00	Location 4	Location 8	Success
174	12	24	2022-09-22 09:00:00	2022-09-22 09:43:00	Location 2	Location 3	Success
175	12	25	2022-02-08 00:00:00	2022-02-08 00:41:00	Location 9	Location 1	Success
176	12	26	2022-05-26 03:00:00	2022-05-26 03:45:00	Location 5	Location 6	Success
177	12	27	2021-06-25 02:00:00	2021-06-25 02:30:00	Location 6	Location 9	Success
178	12	28	2022-06-22 02:00:00	2022-06-22 02:37:00	Location 6	Location 10	Success
179	12	29	2022-01-06 00:00:00	2022-01-06 00:50:00	Location 1	Location 7	Success
180	12	30	2021-09-27 06:00:00	2021-09-27 06:38:00	Location 9	Location 2	Success
181	14	1	2021-11-25 11:00:00	2021-11-25 11:51:00	Location 6	Location 8	Success
182	14	2	2021-10-22 09:00:00	2021-10-22 09:25:00	Location 3	Location 10	Success
183	14	3	2022-10-28 03:00:00	2022-10-28 03:35:00	Location 4	Location 10	Success
184	14	4	2021-12-27 06:00:00	2021-12-27 06:56:00	Location 7	Location 3	Success
185	14	5	2021-06-13 00:00:00	2021-06-13 00:58:00	Location 9	Location 7	Success
186	14	6	2022-01-02 06:00:00	2022-01-02 06:38:00	Location 7	Location 8	Success
187	14	7	2022-08-09 01:00:00	2022-08-09 01:46:00	Location 10	Location 4	Success
188	14	8	2021-07-04 03:00:00	2021-07-04 03:14:00	Location 4	Location 10	Success
189	14	9	2022-07-27 02:00:00	2022-07-27 02:10:00	Location 6	Location 9	Success
190	14	10	2021-12-24 11:00:00	2021-12-24 11:32:00	Location 4	Location 5	Success
191	14	11	2021-03-22 10:00:00	2021-03-22 10:43:00	Location 6	Location 6	Success
192	14	12	2022-12-16 05:00:00	2022-12-16 05:56:00	Location 8	Location 7	Success
193	14	13	2021-12-13 00:00:00	2021-12-13 00:24:00	Location 10	Location 5	Success
194	14	14	2021-11-20 07:00:00	2021-11-20 07:53:00	Location 5	Location 3	Success
195	14	15	2021-03-04 11:00:00	2021-03-04 11:37:00	Location 4	Location 4	Success
196	14	16	2022-02-17 01:00:00	2022-02-17 01:33:00	Location 5	Location 2	Success
197	14	17	2022-07-29 02:00:00	2022-07-29 02:44:00	Location 7	Location 7	Success
198	14	18	2021-03-31 01:00:00	2021-03-31 01:26:00	Location 3	Location 10	Success
199	14	19	2022-06-12 02:00:00	2022-06-12 02:45:00	Location 4	Location 4	Success
200	14	20	2022-02-09 11:00:00	2022-02-09 11:31:00	Location 3	Location 10	Success
201	14	21	2021-08-10 04:00:00	2021-08-10 04:11:00	Location 3	Location 6	Success
202	14	22	2022-03-08 06:00:00	2022-03-08 06:58:00	Location 2	Location 7	Success
203	14	23	2022-10-03 09:00:00	2022-10-03 09:40:00	Location 3	Location 9	Success
204	14	24	2022-09-22 05:00:00	2022-09-22 05:24:00	Location 7	Location 2	Success
205	14	25	2022-02-08 06:00:00	2022-02-08 06:35:00	Location 9	Location 5	Success
206	14	26	2022-05-26 11:00:00	2022-05-26 11:40:00	Location 9	Location 1	Success
207	14	27	2021-06-25 11:00:00	2021-06-25 11:11:00	Location 1	Location 3	Success
208	14	28	2022-06-22 06:00:00	2022-06-22 06:11:00	Location 2	Location 6	Success
209	14	29	2022-01-06 07:00:00	2022-01-06 07:59:00	Location 7	Location 5	Success
210	14	30	2021-09-27 04:00:00	2021-09-27 04:17:00	Location 1	Location 9	Success
211	16	1	2021-11-25 03:00:00	2021-11-25 03:56:00	Location 2	Location 7	Success
212	16	2	2021-10-22 02:00:00	2021-10-22 02:10:00	Location 2	Location 5	Success
213	16	3	2022-10-28 08:00:00	2022-10-28 08:19:00	Location 9	Location 9	Success
214	16	4	2021-12-27 00:00:00	2021-12-27 00:18:00	Location 8	Location 10	Success
215	16	5	2021-06-13 00:00:00	2021-06-13 00:52:00	Location 5	Location 1	Success
216	16	6	2022-01-02 01:00:00	2022-01-02 01:11:00	Location 7	Location 4	Success
217	16	7	2022-08-09 01:00:00	2022-08-09 01:22:00	Location 4	Location 4	Success
218	16	8	2021-07-04 09:00:00	2021-07-04 09:41:00	Location 10	Location 5	Success
219	16	9	2022-07-27 08:00:00	2022-07-27 08:49:00	Location 7	Location 8	Success
220	16	10	2021-12-24 00:00:00	2021-12-24 00:12:00	Location 3	Location 4	Success
221	16	11	2021-03-22 08:00:00	2021-03-22 08:40:00	Location 6	Location 1	Success
222	16	12	2022-12-16 11:00:00	2022-12-16 11:53:00	Location 1	Location 5	Success
223	16	13	2021-12-13 08:00:00	2021-12-13 08:28:00	Location 6	Location 1	Success
224	16	14	2021-11-20 11:00:00	2021-11-20 11:25:00	Location 6	Location 4	Success
225	16	15	2021-03-04 04:00:00	2021-03-04 04:53:00	Location 9	Location 7	Success
226	16	16	2022-02-17 07:00:00	2022-02-17 07:49:00	Location 7	Location 6	Success
227	16	17	2022-07-29 07:00:00	2022-07-29 07:19:00	Location 1	Location 5	Success
228	16	18	2021-03-31 10:00:00	2021-03-31 10:12:00	Location 9	Location 2	Success
229	16	19	2022-06-12 04:00:00	2022-06-12 04:20:00	Location 6	Location 6	Success
230	16	20	2022-02-09 06:00:00	2022-02-09 06:25:00	Location 5	Location 9	Success
231	16	21	2021-08-10 03:00:00	2021-08-10 03:49:00	Location 4	Location 1	Success
232	16	22	2022-03-08 07:00:00	2022-03-08 07:14:00	Location 9	Location 4	Success
233	16	23	2022-10-03 02:00:00	2022-10-03 02:11:00	Location 2	Location 5	Success
234	16	24	2022-09-22 04:00:00	2022-09-22 04:50:00	Location 2	Location 5	Success
235	16	25	2022-02-08 03:00:00	2022-02-08 03:24:00	Location 10	Location 10	Success
236	16	26	2022-05-26 09:00:00	2022-05-26 09:25:00	Location 8	Location 8	Success
237	16	27	2021-06-25 11:00:00	2021-06-25 11:59:00	Location 10	Location 4	Success
238	16	28	2022-06-22 02:00:00	2022-06-22 02:28:00	Location 4	Location 7	Success
239	16	29	2022-01-06 00:00:00	2022-01-06 00:59:00	Location 10	Location 7	Success
240	16	30	2021-09-27 10:00:00	2021-09-27 10:22:00	Location 1	Location 1	Success
241	18	1	2021-11-25 02:00:00	2021-11-25 02:27:00	Location 7	Location 8	Success
242	18	2	2021-10-22 00:00:00	2021-10-22 00:47:00	Location 6	Location 10	Success
243	18	3	2022-10-28 02:00:00	2022-10-28 02:20:00	Location 8	Location 6	Success
244	18	4	2021-12-27 03:00:00	2021-12-27 03:20:00	Location 7	Location 1	Success
245	18	5	2021-06-13 11:00:00	2021-06-13 11:12:00	Location 10	Location 10	Success
246	18	6	2022-01-02 01:00:00	2022-01-02 01:10:00	Location 8	Location 2	Success
247	18	7	2022-08-09 02:00:00	2022-08-09 02:10:00	Location 6	Location 3	Success
248	18	8	2021-07-04 11:00:00	2021-07-04 11:22:00	Location 5	Location 10	Success
249	18	9	2022-07-27 04:00:00	2022-07-27 04:42:00	Location 2	Location 8	Success
250	18	10	2021-12-24 05:00:00	2021-12-24 05:42:00	Location 5	Location 9	Success
251	18	11	2021-03-22 11:00:00	2021-03-22 11:44:00	Location 4	Location 4	Success
252	18	12	2022-12-16 03:00:00	2022-12-16 03:26:00	Location 2	Location 3	Success
253	18	13	2021-12-13 04:00:00	2021-12-13 04:33:00	Location 1	Location 5	Success
254	18	14	2021-11-20 10:00:00	2021-11-20 10:32:00	Location 3	Location 10	Success
255	18	15	2021-03-04 07:00:00	2021-03-04 07:47:00	Location 9	Location 10	Success
256	18	16	2022-02-17 00:00:00	2022-02-17 00:28:00	Location 10	Location 7	Success
257	18	17	2022-07-29 10:00:00	2022-07-29 10:51:00	Location 10	Location 5	Success
258	18	18	2021-03-31 08:00:00	2021-03-31 08:19:00	Location 7	Location 2	Success
259	18	19	2022-06-12 08:00:00	2022-06-12 08:47:00	Location 6	Location 6	Success
260	18	20	2022-02-09 03:00:00	2022-02-09 03:19:00	Location 1	Location 1	Success
261	18	21	2021-08-10 00:00:00	2021-08-10 00:22:00	Location 9	Location 9	Success
262	18	22	2022-03-08 08:00:00	2022-03-08 08:55:00	Location 8	Location 4	Success
263	18	23	2022-10-03 09:00:00	2022-10-03 09:17:00	Location 9	Location 10	Success
264	18	24	2022-09-22 09:00:00	2022-09-22 09:26:00	Location 1	Location 4	Success
265	18	25	2022-02-08 11:00:00	2022-02-08 11:13:00	Location 3	Location 10	Success
266	18	26	2022-05-26 04:00:00	2022-05-26 04:44:00	Location 1	Location 7	Success
267	18	27	2021-06-25 09:00:00	2021-06-25 09:28:00	Location 5	Location 3	Success
268	18	28	2022-06-22 07:00:00	2022-06-22 07:23:00	Location 7	Location 5	Success
269	18	29	2022-01-06 01:00:00	2022-01-06 01:40:00	Location 4	Location 6	Success
270	18	30	2021-09-27 01:00:00	2021-09-27 01:18:00	Location 1	Location 10	Success
271	20	1	2022-02-01 10:00:00	2022-02-01 10:19:00	Location 7	Location 2	Success
272	20	2	2022-02-01 11:00:00	2022-02-01 11:29:00	Location 6	Location 4	Success
273	20	3	2022-10-28 06:00:00	2022-10-28 06:27:00	Location 3	Location 3	Success
274	20	4	2022-02-01 09:00:00	2022-02-01 09:40:00	Location 10	Location 3	Success
275	20	5	2022-02-01 00:00:00	2022-02-01 00:57:00	Location 10	Location 3	Success
276	20	6	2022-02-01 01:00:00	2022-02-01 01:46:00	Location 4	Location 8	Success
277	20	7	2022-08-09 11:00:00	2022-08-09 11:48:00	Location 9	Location 4	Success
278	20	8	2022-02-01 11:00:00	2022-02-01 11:47:00	Location 10	Location 8	Success
279	20	9	2022-07-27 08:00:00	2022-07-27 08:45:00	Location 2	Location 7	Success
280	20	10	2022-02-01 04:00:00	2022-02-01 04:18:00	Location 2	Location 2	Success
281	20	11	2022-02-01 09:00:00	2022-02-01 09:56:00	Location 4	Location 8	Success
282	20	12	2022-12-16 10:00:00	2022-12-16 10:13:00	Location 2	Location 7	Success
283	20	13	2022-02-01 01:00:00	2022-02-01 01:47:00	Location 3	Location 9	Success
284	20	14	2022-02-01 11:00:00	2022-02-01 11:21:00	Location 10	Location 6	Success
285	20	15	2022-02-01 01:00:00	2022-02-01 01:30:00	Location 4	Location 7	Success
286	20	16	2022-02-17 10:00:00	2022-02-17 10:13:00	Location 1	Location 8	Success
287	20	17	2022-07-29 10:00:00	2022-07-29 10:48:00	Location 1	Location 3	Success
288	20	18	2022-02-01 04:00:00	2022-02-01 04:28:00	Location 6	Location 1	Success
289	20	19	2022-06-12 08:00:00	2022-06-12 08:13:00	Location 2	Location 7	Success
290	20	20	2022-02-09 11:00:00	2022-02-09 11:27:00	Location 5	Location 8	Success
291	20	21	2022-02-01 11:00:00	2022-02-01 11:59:00	Location 6	Location 6	Success
292	20	22	2022-03-08 11:00:00	2022-03-08 11:59:00	Location 9	Location 1	Success
293	20	23	2022-10-03 00:00:00	2022-10-03 00:13:00	Location 3	Location 8	Success
294	20	24	2022-09-22 06:00:00	2022-09-22 06:26:00	Location 2	Location 8	Success
295	20	25	2022-02-08 00:00:00	2022-02-08 00:37:00	Location 3	Location 2	Success
296	20	26	2022-05-26 00:00:00	2022-05-26 00:27:00	Location 6	Location 6	Success
297	20	27	2022-02-01 05:00:00	2022-02-01 05:59:00	Location 6	Location 10	Success
298	20	28	2022-06-22 07:00:00	2022-06-22 07:46:00	Location 5	Location 5	Success
299	20	29	2022-02-01 06:00:00	2022-02-01 06:58:00	Location 5	Location 5	Success
300	20	30	2022-02-01 03:00:00	2022-02-01 03:38:00	Location 3	Location 4	Success
301	22	1	2021-11-25 09:00:00	2021-11-25 09:50:00	Location 6	Location 4	Success
302	22	2	2021-10-22 09:00:00	2021-10-22 09:51:00	Location 4	Location 2	Success
303	22	3	2022-10-28 04:00:00	2022-10-28 04:17:00	Location 8	Location 2	Success
304	22	4	2021-12-27 03:00:00	2021-12-27 03:53:00	Location 8	Location 9	Success
305	22	5	2021-06-13 05:00:00	2021-06-13 05:27:00	Location 9	Location 2	Success
306	22	6	2022-01-02 02:00:00	2022-01-02 02:46:00	Location 10	Location 4	Success
307	22	7	2022-08-09 09:00:00	2022-08-09 09:42:00	Location 6	Location 9	Success
308	22	8	2021-07-04 01:00:00	2021-07-04 01:46:00	Location 9	Location 7	Success
309	22	9	2022-07-27 02:00:00	2022-07-27 02:17:00	Location 4	Location 8	Success
310	22	10	2021-12-24 09:00:00	2021-12-24 09:27:00	Location 2	Location 10	Success
311	22	11	2021-03-22 03:00:00	2021-03-22 03:21:00	Location 3	Location 3	Success
312	22	12	2022-12-16 07:00:00	2022-12-16 07:20:00	Location 7	Location 9	Success
313	22	13	2021-12-13 04:00:00	2021-12-13 04:11:00	Location 8	Location 5	Success
314	22	14	2021-11-20 07:00:00	2021-11-20 07:44:00	Location 5	Location 10	Success
315	22	15	2021-03-04 02:00:00	2021-03-04 02:22:00	Location 9	Location 1	Success
316	22	16	2022-02-17 06:00:00	2022-02-17 06:46:00	Location 6	Location 10	Success
317	22	17	2022-07-29 08:00:00	2022-07-29 08:27:00	Location 9	Location 3	Success
318	22	18	2021-03-31 01:00:00	2021-03-31 01:18:00	Location 5	Location 1	Success
319	22	19	2022-06-12 00:00:00	2022-06-12 00:36:00	Location 3	Location 10	Success
320	22	20	2022-02-09 06:00:00	2022-02-09 06:59:00	Location 2	Location 1	Success
321	22	21	2021-08-10 08:00:00	2021-08-10 08:23:00	Location 3	Location 10	Success
322	22	22	2022-03-08 04:00:00	2022-03-08 04:45:00	Location 1	Location 1	Success
323	22	23	2022-10-03 07:00:00	2022-10-03 07:48:00	Location 10	Location 7	Success
324	22	24	2022-09-22 06:00:00	2022-09-22 06:17:00	Location 4	Location 6	Success
325	22	25	2022-02-08 05:00:00	2022-02-08 05:13:00	Location 1	Location 7	Success
326	22	26	2022-05-26 06:00:00	2022-05-26 06:26:00	Location 4	Location 10	Success
327	22	27	2021-06-25 08:00:00	2021-06-25 08:12:00	Location 5	Location 4	Success
328	22	28	2022-06-22 09:00:00	2022-06-22 09:45:00	Location 10	Location 3	Success
329	22	29	2022-01-06 07:00:00	2022-01-06 07:45:00	Location 3	Location 10	Success
330	22	30	2021-09-27 01:00:00	2021-09-27 01:57:00	Location 7	Location 9	Success
331	24	1	2021-11-25 07:00:00	2021-11-25 07:54:00	Location 6	Location 10	Success
332	24	2	2021-10-22 06:00:00	2021-10-22 06:43:00	Location 6	Location 4	Success
333	24	3	2022-10-28 08:00:00	2022-10-28 08:14:00	Location 4	Location 5	Success
334	24	4	2021-12-27 04:00:00	2021-12-27 04:53:00	Location 3	Location 10	Success
335	24	5	2021-06-13 05:00:00	2021-06-13 05:43:00	Location 4	Location 10	Success
336	24	6	2022-01-02 07:00:00	2022-01-02 07:31:00	Location 3	Location 4	Success
337	24	7	2022-08-09 01:00:00	2022-08-09 01:36:00	Location 4	Location 7	Success
338	24	8	2021-07-04 08:00:00	2021-07-04 08:24:00	Location 2	Location 5	Success
339	24	9	2022-07-27 05:00:00	2022-07-27 05:29:00	Location 2	Location 5	Success
340	24	10	2021-12-24 05:00:00	2021-12-24 05:39:00	Location 6	Location 7	Success
341	24	11	2021-03-22 01:00:00	2021-03-22 01:15:00	Location 7	Location 6	Success
342	24	12	2022-12-16 07:00:00	2022-12-16 07:43:00	Location 9	Location 3	Success
343	24	13	2021-12-13 08:00:00	2021-12-13 08:14:00	Location 10	Location 3	Success
344	24	14	2021-11-20 09:00:00	2021-11-20 09:19:00	Location 5	Location 6	Success
345	24	15	2021-03-04 05:00:00	2021-03-04 05:37:00	Location 10	Location 3	Success
346	24	16	2022-02-17 05:00:00	2022-02-17 05:17:00	Location 7	Location 4	Success
347	24	17	2022-07-29 04:00:00	2022-07-29 04:29:00	Location 1	Location 4	Success
348	24	18	2021-03-31 02:00:00	2021-03-31 02:32:00	Location 4	Location 1	Success
349	24	19	2022-06-12 06:00:00	2022-06-12 06:16:00	Location 1	Location 5	Success
350	24	20	2022-02-09 06:00:00	2022-02-09 06:48:00	Location 4	Location 8	Success
351	24	21	2021-08-10 08:00:00	2021-08-10 08:36:00	Location 7	Location 1	Success
352	24	22	2022-03-08 02:00:00	2022-03-08 02:43:00	Location 10	Location 6	Success
353	24	23	2022-10-03 11:00:00	2022-10-03 11:24:00	Location 9	Location 9	Success
354	24	24	2022-09-22 01:00:00	2022-09-22 01:48:00	Location 6	Location 1	Success
355	24	25	2022-02-08 06:00:00	2022-02-08 06:39:00	Location 3	Location 8	Success
356	24	26	2022-05-26 03:00:00	2022-05-26 03:10:00	Location 3	Location 7	Success
357	24	27	2021-06-25 02:00:00	2021-06-25 02:16:00	Location 5	Location 8	Success
358	24	28	2022-06-22 02:00:00	2022-06-22 02:37:00	Location 9	Location 7	Success
359	24	29	2022-01-06 01:00:00	2022-01-06 01:36:00	Location 2	Location 4	Success
360	24	30	2021-09-27 00:00:00	2021-09-27 00:15:00	Location 10	Location 1	Success
361	26	1	2021-11-25 10:00:00	2021-11-25 10:16:00	Location 4	Location 7	Success
362	26	2	2021-11-11 05:00:00	2021-11-11 05:58:00	Location 10	Location 7	Success
363	26	3	2022-10-28 06:00:00	2022-10-28 06:47:00	Location 7	Location 1	Success
364	26	4	2021-12-27 03:00:00	2021-12-27 03:59:00	Location 9	Location 4	Success
365	26	5	2021-11-11 09:00:00	2021-11-11 09:18:00	Location 4	Location 5	Success
366	26	6	2022-01-02 09:00:00	2022-01-02 09:32:00	Location 4	Location 1	Success
367	26	7	2022-08-09 01:00:00	2022-08-09 01:47:00	Location 7	Location 3	Success
368	26	8	2021-11-11 03:00:00	2021-11-11 03:49:00	Location 8	Location 7	Success
369	26	9	2022-07-27 01:00:00	2022-07-27 01:29:00	Location 1	Location 8	Success
370	26	10	2021-12-24 07:00:00	2021-12-24 07:51:00	Location 7	Location 9	Success
371	26	11	2021-11-11 11:00:00	2021-11-11 11:34:00	Location 7	Location 10	Success
372	26	12	2022-12-16 06:00:00	2022-12-16 06:11:00	Location 8	Location 10	Success
373	26	13	2021-12-13 11:00:00	2021-12-13 11:25:00	Location 2	Location 10	Success
374	26	14	2021-11-20 06:00:00	2021-11-20 06:57:00	Location 3	Location 4	Success
375	26	15	2021-11-11 10:00:00	2021-11-11 10:18:00	Location 5	Location 6	Success
376	26	16	2022-02-17 07:00:00	2022-02-17 07:56:00	Location 7	Location 4	Success
377	26	17	2022-07-29 00:00:00	2022-07-29 00:46:00	Location 9	Location 3	Success
378	26	18	2021-11-11 03:00:00	2021-11-11 03:31:00	Location 5	Location 5	Success
379	26	19	2022-06-12 07:00:00	2022-06-12 07:30:00	Location 5	Location 4	Success
380	26	20	2022-02-09 10:00:00	2022-02-09 10:43:00	Location 6	Location 3	Success
381	26	21	2021-11-11 01:00:00	2021-11-11 01:29:00	Location 5	Location 5	Success
382	26	22	2022-03-08 08:00:00	2022-03-08 08:36:00	Location 2	Location 5	Success
383	26	23	2022-10-03 08:00:00	2022-10-03 08:25:00	Location 1	Location 7	Success
384	26	24	2022-09-22 07:00:00	2022-09-22 07:19:00	Location 4	Location 10	Success
385	26	25	2022-02-08 00:00:00	2022-02-08 00:41:00	Location 7	Location 10	Success
386	26	26	2022-05-26 07:00:00	2022-05-26 07:53:00	Location 3	Location 6	Success
387	26	27	2021-11-11 04:00:00	2021-11-11 04:36:00	Location 9	Location 9	Success
388	26	28	2022-06-22 10:00:00	2022-06-22 10:54:00	Location 3	Location 2	Success
389	26	29	2022-01-06 11:00:00	2022-01-06 11:33:00	Location 4	Location 6	Success
390	26	30	2021-11-11 02:00:00	2021-11-11 02:54:00	Location 3	Location 5	Success
391	28	1	2021-11-25 05:00:00	2021-11-25 05:52:00	Location 7	Location 5	Success
392	28	2	2021-10-22 06:00:00	2021-10-22 06:59:00	Location 10	Location 10	Success
393	28	3	2022-10-28 01:00:00	2022-10-28 01:19:00	Location 8	Location 3	Success
394	28	4	2021-12-27 01:00:00	2021-12-27 01:49:00	Location 7	Location 1	Success
395	28	5	2021-06-13 01:00:00	2021-06-13 01:29:00	Location 8	Location 10	Success
396	28	6	2022-01-02 02:00:00	2022-01-02 02:10:00	Location 8	Location 4	Success
397	28	7	2022-08-09 08:00:00	2022-08-09 08:12:00	Location 4	Location 3	Success
398	28	8	2021-07-04 01:00:00	2021-07-04 01:11:00	Location 1	Location 7	Success
399	28	9	2022-07-27 10:00:00	2022-07-27 10:19:00	Location 7	Location 4	Success
400	28	10	2021-12-24 03:00:00	2021-12-24 03:52:00	Location 7	Location 4	Success
401	28	11	2021-03-22 09:00:00	2021-03-22 09:23:00	Location 3	Location 4	Success
402	28	12	2022-12-16 07:00:00	2022-12-16 07:32:00	Location 5	Location 4	Success
403	28	13	2021-12-13 08:00:00	2021-12-13 08:55:00	Location 5	Location 4	Success
404	28	14	2021-11-20 11:00:00	2021-11-20 11:14:00	Location 10	Location 1	Success
405	28	15	2021-03-04 00:00:00	2021-03-04 00:13:00	Location 1	Location 2	Success
406	28	16	2022-02-17 01:00:00	2022-02-17 01:38:00	Location 7	Location 4	Success
407	28	17	2022-07-29 07:00:00	2022-07-29 07:28:00	Location 5	Location 7	Success
408	28	18	2021-03-31 06:00:00	2021-03-31 06:12:00	Location 9	Location 3	Success
409	28	19	2022-06-12 04:00:00	2022-06-12 04:53:00	Location 6	Location 6	Success
410	28	20	2022-02-09 10:00:00	2022-02-09 10:11:00	Location 8	Location 3	Success
411	28	21	2021-08-10 04:00:00	2021-08-10 04:50:00	Location 8	Location 5	Success
412	28	22	2022-03-08 01:00:00	2022-03-08 01:19:00	Location 2	Location 4	Success
413	28	23	2022-10-03 05:00:00	2022-10-03 05:25:00	Location 6	Location 1	Success
414	28	24	2022-09-22 01:00:00	2022-09-22 01:23:00	Location 7	Location 3	Success
415	28	25	2022-02-08 03:00:00	2022-02-08 03:45:00	Location 5	Location 1	Success
416	28	26	2022-05-26 07:00:00	2022-05-26 07:48:00	Location 10	Location 4	Success
417	28	27	2021-06-25 10:00:00	2021-06-25 10:49:00	Location 5	Location 7	Success
418	28	28	2022-06-22 02:00:00	2022-06-22 02:53:00	Location 6	Location 4	Success
419	28	29	2022-01-06 00:00:00	2022-01-06 00:41:00	Location 5	Location 9	Success
420	28	30	2021-09-27 03:00:00	2021-09-27 03:38:00	Location 1	Location 8	Success
421	30	1	2021-11-25 11:00:00	2021-11-25 11:46:00	Location 2	Location 1	Success
422	30	2	2021-10-22 03:00:00	2021-10-22 03:24:00	Location 2	Location 6	Success
423	30	3	2022-10-28 11:00:00	2022-10-28 11:44:00	Location 4	Location 7	Success
424	30	4	2021-12-27 01:00:00	2021-12-27 01:29:00	Location 10	Location 9	Success
425	30	5	2021-06-13 08:00:00	2021-06-13 08:27:00	Location 2	Location 3	Success
426	30	6	2022-01-02 09:00:00	2022-01-02 09:33:00	Location 1	Location 2	Success
427	30	7	2022-08-09 06:00:00	2022-08-09 06:35:00	Location 4	Location 10	Success
428	30	8	2021-07-04 05:00:00	2021-07-04 05:35:00	Location 6	Location 2	Success
429	30	9	2022-07-27 10:00:00	2022-07-27 10:12:00	Location 9	Location 5	Success
430	30	10	2021-12-24 08:00:00	2021-12-24 08:23:00	Location 5	Location 9	Success
431	30	11	2021-03-22 09:00:00	2021-03-22 09:47:00	Location 1	Location 7	Success
432	30	12	2022-12-16 02:00:00	2022-12-16 02:43:00	Location 6	Location 2	Success
433	30	13	2021-12-13 06:00:00	2021-12-13 06:21:00	Location 3	Location 2	Success
434	30	14	2021-11-20 09:00:00	2021-11-20 09:36:00	Location 3	Location 3	Success
435	30	15	2021-03-04 09:00:00	2021-03-04 09:28:00	Location 8	Location 5	Success
436	30	16	2022-02-17 10:00:00	2022-02-17 10:35:00	Location 8	Location 10	Success
437	30	17	2022-07-29 06:00:00	2022-07-29 06:13:00	Location 9	Location 8	Success
438	30	18	2021-03-31 06:00:00	2021-03-31 06:51:00	Location 10	Location 3	Success
439	30	19	2022-06-12 00:00:00	2022-06-12 00:25:00	Location 4	Location 10	Success
440	30	20	2022-02-09 10:00:00	2022-02-09 10:30:00	Location 10	Location 3	Success
441	30	21	2021-08-10 05:00:00	2021-08-10 05:36:00	Location 5	Location 6	Success
442	30	22	2022-03-08 00:00:00	2022-03-08 00:31:00	Location 6	Location 9	Success
443	30	23	2022-10-03 04:00:00	2022-10-03 04:20:00	Location 10	Location 5	Success
444	30	24	2022-09-22 06:00:00	2022-09-22 06:55:00	Location 9	Location 10	Success
445	30	25	2022-02-08 01:00:00	2022-02-08 01:37:00	Location 2	Location 3	Success
446	30	26	2022-05-26 02:00:00	2022-05-26 02:45:00	Location 8	Location 4	Success
447	30	27	2021-06-25 10:00:00	2021-06-25 10:47:00	Location 7	Location 6	Success
448	30	28	2022-06-22 08:00:00	2022-06-22 08:11:00	Location 6	Location 1	Success
449	30	29	2022-01-06 10:00:00	2022-01-06 10:48:00	Location 4	Location 10	Success
450	30	30	2021-09-27 01:00:00	2021-09-27 01:18:00	Location 3	Location 9	Success
451	32	1	2021-11-25 10:00:00	2021-11-25 10:34:00	Location 4	Location 9	Success
452	32	2	2021-10-22 09:00:00	2021-10-22 09:29:00	Location 9	Location 4	Success
453	32	3	2022-10-28 11:00:00	2022-10-28 11:45:00	Location 10	Location 6	Success
454	32	4	2021-12-27 02:00:00	2021-12-27 02:32:00	Location 10	Location 8	Success
455	32	5	2021-06-13 01:00:00	2021-06-13 01:28:00	Location 5	Location 9	Success
456	32	6	2022-01-02 10:00:00	2022-01-02 10:27:00	Location 5	Location 4	Success
457	32	7	2022-08-09 09:00:00	2022-08-09 09:58:00	Location 5	Location 9	Success
458	32	8	2021-07-04 05:00:00	2021-07-04 05:28:00	Location 2	Location 6	Success
459	32	9	2022-07-27 10:00:00	2022-07-27 10:29:00	Location 6	Location 8	Success
460	32	10	2021-12-24 02:00:00	2021-12-24 02:33:00	Location 3	Location 5	Success
461	32	11	2021-03-22 11:00:00	2021-03-22 11:16:00	Location 10	Location 6	Success
462	32	12	2022-12-16 03:00:00	2022-12-16 03:52:00	Location 9	Location 10	Success
463	32	13	2021-12-13 03:00:00	2021-12-13 03:50:00	Location 9	Location 10	Success
464	32	14	2021-11-20 11:00:00	2021-11-20 11:25:00	Location 6	Location 8	Success
465	32	15	2021-03-04 02:00:00	2021-03-04 02:16:00	Location 1	Location 9	Success
466	32	16	2022-02-17 06:00:00	2022-02-17 06:57:00	Location 1	Location 8	Success
467	32	17	2022-07-29 03:00:00	2022-07-29 03:22:00	Location 7	Location 6	Success
468	32	18	2021-03-31 02:00:00	2021-03-31 02:43:00	Location 8	Location 3	Success
469	32	19	2022-06-12 00:00:00	2022-06-12 00:38:00	Location 9	Location 2	Success
470	32	20	2022-02-09 11:00:00	2022-02-09 11:43:00	Location 5	Location 3	Success
471	32	21	2021-08-10 03:00:00	2021-08-10 03:59:00	Location 9	Location 2	Success
472	32	22	2022-03-08 01:00:00	2022-03-08 01:32:00	Location 3	Location 10	Success
473	32	23	2022-10-03 08:00:00	2022-10-03 08:45:00	Location 3	Location 9	Success
474	32	24	2022-09-22 03:00:00	2022-09-22 03:36:00	Location 4	Location 10	Success
475	32	25	2022-02-08 00:00:00	2022-02-08 00:36:00	Location 5	Location 9	Success
476	32	26	2022-05-26 02:00:00	2022-05-26 02:48:00	Location 6	Location 8	Success
477	32	27	2021-06-25 11:00:00	2021-06-25 11:19:00	Location 10	Location 5	Success
478	32	28	2022-06-22 09:00:00	2022-06-22 09:39:00	Location 3	Location 8	Success
479	32	29	2022-01-06 05:00:00	2022-01-06 05:17:00	Location 6	Location 9	Success
480	32	30	2021-09-27 07:00:00	2021-09-27 07:19:00	Location 7	Location 1	Success
481	34	1	2021-11-25 07:00:00	2021-11-25 07:44:00	Location 6	Location 4	Success
482	34	2	2021-10-22 08:00:00	2021-10-22 08:37:00	Location 6	Location 4	Success
483	34	3	2022-10-28 07:00:00	2022-10-28 07:34:00	Location 10	Location 3	Success
484	34	4	2021-12-27 08:00:00	2021-12-27 08:20:00	Location 6	Location 5	Success
485	34	5	2021-06-13 09:00:00	2021-06-13 09:27:00	Location 2	Location 6	Success
486	34	6	2022-01-02 11:00:00	2022-01-02 11:17:00	Location 1	Location 8	Success
487	34	7	2022-08-09 01:00:00	2022-08-09 01:52:00	Location 4	Location 9	Success
488	34	8	2021-07-04 03:00:00	2021-07-04 03:14:00	Location 7	Location 8	Success
489	34	9	2022-07-27 08:00:00	2022-07-27 08:45:00	Location 2	Location 2	Success
490	34	10	2021-12-24 04:00:00	2021-12-24 04:47:00	Location 10	Location 10	Success
491	34	11	2021-03-22 09:00:00	2021-03-22 09:40:00	Location 8	Location 4	Success
492	34	12	2022-12-16 09:00:00	2022-12-16 09:45:00	Location 8	Location 9	Success
493	34	13	2021-12-13 00:00:00	2021-12-13 00:31:00	Location 6	Location 8	Success
494	34	14	2021-11-20 09:00:00	2021-11-20 09:44:00	Location 2	Location 8	Success
495	34	15	2021-03-04 08:00:00	2021-03-04 08:38:00	Location 7	Location 3	Success
496	34	16	2022-02-17 11:00:00	2022-02-17 11:41:00	Location 8	Location 8	Success
497	34	17	2022-07-29 08:00:00	2022-07-29 08:48:00	Location 9	Location 8	Success
498	34	18	2021-03-31 09:00:00	2021-03-31 09:23:00	Location 3	Location 1	Success
499	34	19	2022-06-12 00:00:00	2022-06-12 00:40:00	Location 9	Location 10	Success
500	34	20	2022-02-09 09:00:00	2022-02-09 09:20:00	Location 1	Location 4	Success
501	34	21	2021-08-10 02:00:00	2021-08-10 02:59:00	Location 1	Location 1	Success
502	34	22	2022-03-08 11:00:00	2022-03-08 11:26:00	Location 5	Location 5	Success
503	34	23	2022-10-03 07:00:00	2022-10-03 07:32:00	Location 8	Location 6	Success
504	34	24	2022-09-22 08:00:00	2022-09-22 08:47:00	Location 3	Location 1	Success
505	34	25	2022-02-08 02:00:00	2022-02-08 02:12:00	Location 2	Location 2	Success
506	34	26	2022-05-26 01:00:00	2022-05-26 01:21:00	Location 3	Location 10	Success
507	34	27	2021-06-25 08:00:00	2021-06-25 08:53:00	Location 2	Location 3	Success
508	34	28	2022-06-22 06:00:00	2022-06-22 06:48:00	Location 1	Location 2	Success
509	34	29	2022-01-06 04:00:00	2022-01-06 04:11:00	Location 8	Location 10	Success
510	34	30	2021-09-27 11:00:00	2021-09-27 11:59:00	Location 7	Location 8	Success
511	36	1	2021-11-25 11:00:00	2021-11-25 11:23:00	Location 8	Location 7	Success
512	36	2	2021-10-22 07:00:00	2021-10-22 07:27:00	Location 5	Location 9	Success
513	36	3	2022-10-28 11:00:00	2022-10-28 11:17:00	Location 7	Location 5	Success
514	36	4	2021-12-27 09:00:00	2021-12-27 09:15:00	Location 4	Location 7	Success
515	36	5	2021-06-13 03:00:00	2021-06-13 03:14:00	Location 9	Location 6	Success
516	36	6	2022-01-02 07:00:00	2022-01-02 07:30:00	Location 4	Location 7	Success
517	36	7	2022-08-09 06:00:00	2022-08-09 06:36:00	Location 3	Location 4	Success
518	36	8	2021-07-04 04:00:00	2021-07-04 04:40:00	Location 6	Location 10	Success
519	36	9	2022-07-27 00:00:00	2022-07-27 00:45:00	Location 5	Location 8	Success
520	36	10	2021-12-24 10:00:00	2021-12-24 10:21:00	Location 2	Location 1	Success
521	36	11	2021-03-22 04:00:00	2021-03-22 04:17:00	Location 10	Location 7	Success
522	36	12	2022-12-16 08:00:00	2022-12-16 08:50:00	Location 9	Location 6	Success
523	36	13	2021-12-13 02:00:00	2021-12-13 02:58:00	Location 2	Location 9	Success
524	36	14	2021-11-20 04:00:00	2021-11-20 04:41:00	Location 5	Location 5	Success
525	36	15	2021-03-04 02:00:00	2021-03-04 02:25:00	Location 4	Location 10	Success
526	36	16	2022-02-17 03:00:00	2022-02-17 03:18:00	Location 2	Location 1	Success
527	36	17	2022-07-29 02:00:00	2022-07-29 02:51:00	Location 2	Location 6	Success
528	36	18	2021-03-31 09:00:00	2021-03-31 09:25:00	Location 3	Location 10	Success
529	36	19	2022-06-12 05:00:00	2022-06-12 05:59:00	Location 2	Location 7	Success
530	36	20	2022-02-09 07:00:00	2022-02-09 07:23:00	Location 10	Location 2	Success
531	36	21	2021-08-10 04:00:00	2021-08-10 04:33:00	Location 3	Location 7	Success
532	36	22	2022-03-08 10:00:00	2022-03-08 10:46:00	Location 9	Location 10	Success
533	36	23	2022-10-03 04:00:00	2022-10-03 04:26:00	Location 3	Location 4	Success
534	36	24	2022-09-22 01:00:00	2022-09-22 01:56:00	Location 7	Location 8	Success
535	36	25	2022-02-08 11:00:00	2022-02-08 11:33:00	Location 2	Location 5	Success
536	36	26	2022-05-26 10:00:00	2022-05-26 10:21:00	Location 3	Location 9	Success
537	36	27	2021-06-25 11:00:00	2021-06-25 11:15:00	Location 10	Location 8	Success
538	36	28	2022-06-22 09:00:00	2022-06-22 09:36:00	Location 9	Location 2	Success
539	36	29	2022-01-06 04:00:00	2022-01-06 04:26:00	Location 9	Location 10	Success
540	36	30	2021-09-27 05:00:00	2021-09-27 05:32:00	Location 2	Location 5	Success
541	38	1	2021-11-25 05:00:00	2021-11-25 05:37:00	Location 1	Location 1	Success
542	38	2	2021-10-22 06:00:00	2021-10-22 06:48:00	Location 8	Location 7	Success
543	38	3	2022-10-28 07:00:00	2022-10-28 07:51:00	Location 6	Location 9	Success
544	38	4	2021-12-27 09:00:00	2021-12-27 09:22:00	Location 4	Location 5	Success
545	38	5	2021-06-13 10:00:00	2021-06-13 10:37:00	Location 8	Location 2	Success
546	38	6	2022-01-02 06:00:00	2022-01-02 06:33:00	Location 4	Location 7	Success
547	38	7	2022-08-09 00:00:00	2022-08-09 00:18:00	Location 9	Location 10	Success
548	38	8	2021-07-04 02:00:00	2021-07-04 02:39:00	Location 6	Location 5	Success
549	38	9	2022-07-27 08:00:00	2022-07-27 08:27:00	Location 3	Location 4	Success
550	38	10	2021-12-24 05:00:00	2021-12-24 05:13:00	Location 9	Location 7	Success
551	38	11	2021-03-22 00:00:00	2021-03-22 00:40:00	Location 6	Location 3	Success
552	38	12	2022-12-16 10:00:00	2022-12-16 10:51:00	Location 2	Location 2	Success
553	38	13	2021-12-13 00:00:00	2021-12-13 00:40:00	Location 4	Location 3	Success
554	38	14	2021-11-20 02:00:00	2021-11-20 02:46:00	Location 3	Location 10	Success
555	38	15	2021-03-04 11:00:00	2021-03-04 11:21:00	Location 2	Location 1	Success
556	38	16	2022-02-17 05:00:00	2022-02-17 05:20:00	Location 6	Location 4	Success
557	38	17	2022-07-29 05:00:00	2022-07-29 05:44:00	Location 6	Location 3	Success
558	38	18	2021-03-31 03:00:00	2021-03-31 03:57:00	Location 7	Location 7	Success
559	38	19	2022-06-12 09:00:00	2022-06-12 09:35:00	Location 3	Location 7	Success
560	38	20	2022-02-09 04:00:00	2022-02-09 04:52:00	Location 3	Location 8	Success
561	38	21	2021-08-10 05:00:00	2021-08-10 05:31:00	Location 1	Location 7	Success
562	38	22	2022-03-08 11:00:00	2022-03-08 11:50:00	Location 3	Location 2	Success
563	38	23	2022-10-03 09:00:00	2022-10-03 09:20:00	Location 9	Location 9	Success
564	38	24	2022-09-22 06:00:00	2022-09-22 06:40:00	Location 6	Location 2	Success
565	38	25	2022-02-08 05:00:00	2022-02-08 05:41:00	Location 5	Location 5	Success
566	38	26	2022-05-26 10:00:00	2022-05-26 10:25:00	Location 5	Location 3	Success
567	38	27	2021-06-25 04:00:00	2021-06-25 04:47:00	Location 6	Location 7	Success
568	38	28	2022-06-22 09:00:00	2022-06-22 09:42:00	Location 2	Location 10	Success
569	38	29	2022-01-06 07:00:00	2022-01-06 07:24:00	Location 8	Location 1	Success
570	38	30	2021-09-27 07:00:00	2021-09-27 07:54:00	Location 6	Location 6	Success
571	40	1	2021-11-25 07:00:00	2021-11-25 07:11:00	Location 8	Location 7	Success
572	40	2	2021-10-22 04:00:00	2021-10-22 04:53:00	Location 1	Location 3	Success
573	40	3	2022-10-28 04:00:00	2022-10-28 04:31:00	Location 1	Location 3	Success
574	40	4	2021-12-27 00:00:00	2021-12-27 00:22:00	Location 3	Location 3	Success
575	40	5	2021-06-13 11:00:00	2021-06-13 11:55:00	Location 5	Location 5	Success
576	40	6	2022-01-02 06:00:00	2022-01-02 06:42:00	Location 4	Location 9	Success
577	40	7	2022-08-09 02:00:00	2022-08-09 02:49:00	Location 10	Location 9	Success
578	40	8	2021-07-04 00:00:00	2021-07-04 00:30:00	Location 2	Location 3	Success
579	40	9	2022-07-27 09:00:00	2022-07-27 09:21:00	Location 7	Location 5	Success
580	40	10	2021-12-24 05:00:00	2021-12-24 05:59:00	Location 2	Location 1	Success
581	40	11	2021-03-22 04:00:00	2021-03-22 04:16:00	Location 2	Location 1	Success
582	40	12	2022-12-16 02:00:00	2022-12-16 02:10:00	Location 6	Location 2	Success
583	40	13	2021-12-13 00:00:00	2021-12-13 00:24:00	Location 5	Location 6	Success
584	40	14	2021-11-20 05:00:00	2021-11-20 05:13:00	Location 3	Location 7	Success
585	40	15	2021-03-04 00:00:00	2021-03-04 00:48:00	Location 5	Location 3	Success
586	40	16	2022-02-17 01:00:00	2022-02-17 01:49:00	Location 1	Location 7	Success
587	40	17	2022-07-29 06:00:00	2022-07-29 06:13:00	Location 8	Location 3	Success
588	40	18	2021-03-31 08:00:00	2021-03-31 08:19:00	Location 6	Location 4	Success
589	40	19	2022-06-12 07:00:00	2022-06-12 07:25:00	Location 3	Location 9	Success
590	40	20	2022-02-09 06:00:00	2022-02-09 06:26:00	Location 2	Location 8	Success
591	40	21	2021-08-10 03:00:00	2021-08-10 03:21:00	Location 7	Location 7	Success
592	40	22	2022-03-08 06:00:00	2022-03-08 06:14:00	Location 8	Location 10	Success
593	40	23	2022-10-03 04:00:00	2022-10-03 04:28:00	Location 9	Location 9	Success
594	40	24	2022-09-22 00:00:00	2022-09-22 00:47:00	Location 2	Location 5	Success
595	40	25	2022-02-08 03:00:00	2022-02-08 03:38:00	Location 6	Location 6	Success
596	40	26	2022-05-26 05:00:00	2022-05-26 05:47:00	Location 2	Location 4	Success
597	40	27	2021-06-25 09:00:00	2021-06-25 09:25:00	Location 1	Location 3	Success
598	40	28	2022-06-22 10:00:00	2022-06-22 10:56:00	Location 7	Location 10	Success
599	40	29	2022-01-06 04:00:00	2022-01-06 04:16:00	Location 5	Location 5	Success
600	40	30	2021-09-27 08:00:00	2021-09-27 08:28:00	Location 9	Location 9	Success
601	42	1	2021-11-25 09:00:00	2021-11-25 09:13:00	Location 4	Location 9	Success
602	42	2	2021-10-22 10:00:00	2021-10-22 10:46:00	Location 2	Location 3	Success
603	42	3	2022-10-28 09:00:00	2022-10-28 09:59:00	Location 9	Location 2	Success
604	42	4	2021-12-27 09:00:00	2021-12-27 09:55:00	Location 2	Location 5	Success
605	42	5	2021-06-13 06:00:00	2021-06-13 06:33:00	Location 6	Location 5	Success
606	42	6	2022-01-02 05:00:00	2022-01-02 05:18:00	Location 1	Location 1	Success
607	42	7	2022-08-09 03:00:00	2022-08-09 03:59:00	Location 9	Location 6	Success
608	42	8	2021-07-04 10:00:00	2021-07-04 10:35:00	Location 8	Location 8	Success
609	42	9	2022-07-27 10:00:00	2022-07-27 10:49:00	Location 2	Location 6	Success
610	42	10	2021-12-24 02:00:00	2021-12-24 02:46:00	Location 8	Location 6	Success
611	42	11	2021-03-22 03:00:00	2021-03-22 03:12:00	Location 2	Location 2	Success
612	42	12	2022-12-16 11:00:00	2022-12-16 11:34:00	Location 8	Location 3	Success
613	42	13	2021-12-13 05:00:00	2021-12-13 05:22:00	Location 10	Location 3	Success
614	42	14	2021-11-20 09:00:00	2021-11-20 09:34:00	Location 7	Location 7	Success
615	42	15	2021-03-04 07:00:00	2021-03-04 07:44:00	Location 8	Location 4	Success
616	42	16	2022-02-17 08:00:00	2022-02-17 08:38:00	Location 5	Location 10	Success
617	42	17	2022-07-29 11:00:00	2022-07-29 11:28:00	Location 3	Location 1	Success
618	42	18	2021-03-31 03:00:00	2021-03-31 03:33:00	Location 6	Location 6	Success
619	42	19	2022-06-12 06:00:00	2022-06-12 06:19:00	Location 9	Location 2	Success
620	42	20	2022-02-09 01:00:00	2022-02-09 01:30:00	Location 8	Location 2	Success
621	42	21	2021-08-10 08:00:00	2021-08-10 08:50:00	Location 1	Location 10	Success
622	42	22	2022-03-08 11:00:00	2022-03-08 11:44:00	Location 2	Location 7	Success
623	42	23	2022-10-03 08:00:00	2022-10-03 08:20:00	Location 7	Location 4	Success
624	42	24	2022-09-22 10:00:00	2022-09-22 10:40:00	Location 3	Location 7	Success
625	42	25	2022-02-08 11:00:00	2022-02-08 11:38:00	Location 3	Location 10	Success
626	42	26	2022-05-26 10:00:00	2022-05-26 10:51:00	Location 9	Location 5	Success
627	42	27	2021-06-25 07:00:00	2021-06-25 07:59:00	Location 5	Location 9	Success
628	42	28	2022-06-22 10:00:00	2022-06-22 10:48:00	Location 5	Location 4	Success
629	42	29	2022-01-06 01:00:00	2022-01-06 01:30:00	Location 10	Location 8	Success
630	42	30	2021-09-27 03:00:00	2021-09-27 03:32:00	Location 9	Location 6	Success
631	44	1	2021-11-25 11:00:00	2021-11-25 11:12:00	Location 7	Location 8	Success
632	44	2	2021-10-22 10:00:00	2021-10-22 10:53:00	Location 10	Location 6	Success
633	44	3	2022-10-28 10:00:00	2022-10-28 10:18:00	Location 6	Location 9	Success
634	44	4	2021-12-27 03:00:00	2021-12-27 03:37:00	Location 8	Location 5	Success
635	44	5	2021-06-13 05:00:00	2021-06-13 05:24:00	Location 6	Location 3	Success
636	44	6	2022-01-02 04:00:00	2022-01-02 04:26:00	Location 7	Location 10	Success
637	44	7	2022-08-09 11:00:00	2022-08-09 11:50:00	Location 4	Location 3	Success
638	44	8	2021-07-04 09:00:00	2021-07-04 09:33:00	Location 4	Location 5	Success
639	44	9	2022-07-27 11:00:00	2022-07-27 11:45:00	Location 7	Location 2	Success
640	44	10	2021-12-24 07:00:00	2021-12-24 07:19:00	Location 5	Location 7	Success
641	44	11	2021-03-22 02:00:00	2021-03-22 02:50:00	Location 5	Location 7	Success
642	44	12	2022-12-16 00:00:00	2022-12-16 00:14:00	Location 1	Location 1	Success
643	44	13	2021-12-13 10:00:00	2021-12-13 10:53:00	Location 9	Location 2	Success
644	44	14	2021-11-20 03:00:00	2021-11-20 03:44:00	Location 7	Location 1	Success
645	44	15	2021-03-04 11:00:00	2021-03-04 11:55:00	Location 3	Location 7	Success
646	44	16	2022-02-17 11:00:00	2022-02-17 11:36:00	Location 5	Location 1	Success
647	44	17	2022-07-29 10:00:00	2022-07-29 10:15:00	Location 9	Location 2	Success
648	44	18	2021-03-31 00:00:00	2021-03-31 00:35:00	Location 1	Location 9	Success
649	44	19	2022-06-12 09:00:00	2022-06-12 09:46:00	Location 5	Location 9	Success
650	44	20	2022-02-09 07:00:00	2022-02-09 07:55:00	Location 4	Location 10	Success
651	44	21	2021-08-10 05:00:00	2021-08-10 05:52:00	Location 7	Location 3	Success
652	44	22	2022-03-08 00:00:00	2022-03-08 00:19:00	Location 7	Location 9	Success
653	44	23	2022-10-03 05:00:00	2022-10-03 05:59:00	Location 1	Location 6	Success
654	44	24	2022-09-22 02:00:00	2022-09-22 02:37:00	Location 8	Location 3	Success
655	44	25	2022-02-08 09:00:00	2022-02-08 09:10:00	Location 2	Location 1	Success
656	44	26	2022-05-26 08:00:00	2022-05-26 08:35:00	Location 7	Location 5	Success
657	44	27	2021-06-25 00:00:00	2021-06-25 00:44:00	Location 4	Location 3	Success
658	44	28	2022-06-22 11:00:00	2022-06-22 11:12:00	Location 6	Location 5	Success
659	44	29	2022-01-06 06:00:00	2022-01-06 06:35:00	Location 1	Location 10	Success
660	44	30	2021-09-27 02:00:00	2021-09-27 02:45:00	Location 8	Location 3	Success
661	46	1	2021-11-25 01:00:00	2021-11-25 01:17:00	Location 2	Location 10	Success
662	46	2	2021-10-22 02:00:00	2021-10-22 02:48:00	Location 7	Location 2	Success
663	46	3	2022-10-28 06:00:00	2022-10-28 06:17:00	Location 5	Location 1	Success
664	46	4	2021-12-27 08:00:00	2021-12-27 08:39:00	Location 1	Location 7	Success
665	46	5	2021-06-13 05:00:00	2021-06-13 05:23:00	Location 8	Location 4	Success
666	46	6	2022-01-02 04:00:00	2022-01-02 04:15:00	Location 9	Location 6	Success
667	46	7	2022-08-09 03:00:00	2022-08-09 03:56:00	Location 9	Location 9	Success
668	46	8	2021-07-04 00:00:00	2021-07-04 00:54:00	Location 10	Location 5	Success
669	46	9	2022-07-27 08:00:00	2022-07-27 08:27:00	Location 9	Location 9	Success
670	46	10	2021-12-24 04:00:00	2021-12-24 04:34:00	Location 1	Location 1	Success
671	46	11	2021-03-22 06:00:00	2021-03-22 06:56:00	Location 5	Location 10	Success
672	46	12	2022-12-16 04:00:00	2022-12-16 04:59:00	Location 4	Location 9	Success
673	46	13	2021-12-13 08:00:00	2021-12-13 08:13:00	Location 7	Location 2	Success
674	46	14	2021-11-20 09:00:00	2021-11-20 09:48:00	Location 6	Location 3	Success
675	46	15	2021-03-04 03:00:00	2021-03-04 03:19:00	Location 2	Location 3	Success
676	46	16	2022-02-17 05:00:00	2022-02-17 05:25:00	Location 1	Location 4	Success
677	46	17	2022-07-29 11:00:00	2022-07-29 11:34:00	Location 3	Location 4	Success
678	46	18	2021-03-31 05:00:00	2021-03-31 05:16:00	Location 1	Location 5	Success
679	46	19	2022-06-12 00:00:00	2022-06-12 00:35:00	Location 2	Location 8	Success
680	46	20	2022-02-09 02:00:00	2022-02-09 02:11:00	Location 6	Location 8	Success
681	46	21	2021-08-10 08:00:00	2021-08-10 08:17:00	Location 3	Location 8	Success
682	46	22	2022-03-08 08:00:00	2022-03-08 08:39:00	Location 6	Location 9	Success
683	46	23	2022-10-03 09:00:00	2022-10-03 09:55:00	Location 9	Location 1	Success
684	46	24	2022-09-22 08:00:00	2022-09-22 08:26:00	Location 9	Location 7	Success
685	46	25	2022-02-08 09:00:00	2022-02-08 09:56:00	Location 4	Location 8	Success
686	46	26	2022-05-26 04:00:00	2022-05-26 04:25:00	Location 10	Location 1	Success
687	46	27	2021-06-25 10:00:00	2021-06-25 10:17:00	Location 9	Location 6	Success
688	46	28	2022-06-22 04:00:00	2022-06-22 04:24:00	Location 4	Location 7	Success
689	46	29	2022-01-06 08:00:00	2022-01-06 08:32:00	Location 2	Location 6	Success
690	46	30	2021-09-27 06:00:00	2021-09-27 06:52:00	Location 10	Location 1	Success
691	48	1	2021-11-25 03:00:00	2021-11-25 03:43:00	Location 6	Location 9	Success
692	48	2	2021-10-22 00:00:00	2021-10-22 00:26:00	Location 9	Location 6	Success
693	48	3	2022-10-28 10:00:00	2022-10-28 10:41:00	Location 1	Location 1	Success
694	48	4	2021-12-27 01:00:00	2021-12-27 01:52:00	Location 8	Location 2	Success
695	48	5	2021-09-05 08:00:00	2021-09-05 08:24:00	Location 2	Location 4	Success
696	48	6	2022-01-02 10:00:00	2022-01-02 10:29:00	Location 3	Location 6	Success
697	48	7	2022-08-09 07:00:00	2022-08-09 07:59:00	Location 4	Location 8	Success
698	48	8	2021-09-05 08:00:00	2021-09-05 08:39:00	Location 7	Location 5	Success
699	48	9	2022-07-27 09:00:00	2022-07-27 09:22:00	Location 8	Location 7	Success
700	48	10	2021-12-24 09:00:00	2021-12-24 09:37:00	Location 9	Location 8	Success
701	48	11	2021-09-05 09:00:00	2021-09-05 09:41:00	Location 6	Location 3	Success
702	48	12	2022-12-16 05:00:00	2022-12-16 05:24:00	Location 5	Location 5	Success
703	48	13	2021-12-13 04:00:00	2021-12-13 04:21:00	Location 2	Location 7	Success
704	48	14	2021-11-20 00:00:00	2021-11-20 00:52:00	Location 3	Location 9	Success
705	48	15	2021-09-05 09:00:00	2021-09-05 09:51:00	Location 1	Location 10	Success
706	48	16	2022-02-17 02:00:00	2022-02-17 02:29:00	Location 1	Location 2	Success
707	48	17	2022-07-29 05:00:00	2022-07-29 05:14:00	Location 3	Location 7	Success
708	48	18	2021-09-05 11:00:00	2021-09-05 11:30:00	Location 10	Location 5	Success
709	48	19	2022-06-12 09:00:00	2022-06-12 09:29:00	Location 1	Location 2	Success
710	48	20	2022-02-09 06:00:00	2022-02-09 06:39:00	Location 9	Location 5	Success
711	48	21	2021-09-05 02:00:00	2021-09-05 02:18:00	Location 4	Location 10	Success
712	48	22	2022-03-08 09:00:00	2022-03-08 09:24:00	Location 1	Location 5	Success
713	48	23	2022-10-03 02:00:00	2022-10-03 02:39:00	Location 1	Location 3	Success
714	48	24	2022-09-22 02:00:00	2022-09-22 02:14:00	Location 1	Location 2	Success
715	48	25	2022-02-08 04:00:00	2022-02-08 04:55:00	Location 6	Location 8	Success
716	48	26	2022-05-26 10:00:00	2022-05-26 10:54:00	Location 6	Location 3	Success
717	48	27	2021-09-05 02:00:00	2021-09-05 02:17:00	Location 2	Location 3	Success
718	48	28	2022-06-22 05:00:00	2022-06-22 05:47:00	Location 6	Location 1	Success
719	48	29	2022-01-06 01:00:00	2022-01-06 01:14:00	Location 5	Location 8	Success
720	48	30	2021-09-27 06:00:00	2021-09-27 06:53:00	Location 2	Location 1	Success
721	50	1	2021-11-25 08:00:00	2021-11-25 08:27:00	Location 3	Location 6	Success
722	50	2	2021-10-22 04:00:00	2021-10-22 04:29:00	Location 3	Location 9	Success
723	50	3	2022-10-28 03:00:00	2022-10-28 03:38:00	Location 5	Location 4	Success
724	50	4	2021-12-27 09:00:00	2021-12-27 09:10:00	Location 4	Location 9	Success
725	50	5	2021-06-13 11:00:00	2021-06-13 11:12:00	Location 10	Location 6	Success
726	50	6	2022-01-02 10:00:00	2022-01-02 10:36:00	Location 3	Location 9	Success
727	50	7	2022-08-09 06:00:00	2022-08-09 06:59:00	Location 9	Location 8	Success
728	50	8	2021-07-04 02:00:00	2021-07-04 02:19:00	Location 9	Location 7	Success
729	50	9	2022-07-27 03:00:00	2022-07-27 03:56:00	Location 6	Location 8	Success
730	50	10	2021-12-24 08:00:00	2021-12-24 08:17:00	Location 4	Location 4	Success
731	50	11	2021-03-22 01:00:00	2021-03-22 01:49:00	Location 6	Location 8	Success
732	50	12	2022-12-16 11:00:00	2022-12-16 11:20:00	Location 1	Location 1	Success
733	50	13	2021-12-13 06:00:00	2021-12-13 06:59:00	Location 9	Location 10	Success
734	50	14	2021-11-20 00:00:00	2021-11-20 00:56:00	Location 9	Location 4	Success
735	50	15	2021-03-04 04:00:00	2021-03-04 04:36:00	Location 9	Location 7	Success
736	50	16	2022-02-17 11:00:00	2022-02-17 11:24:00	Location 3	Location 10	Success
737	50	17	2022-07-29 01:00:00	2022-07-29 01:39:00	Location 8	Location 4	Success
738	50	18	2021-03-31 02:00:00	2021-03-31 02:44:00	Location 10	Location 8	Success
739	50	19	2022-06-12 11:00:00	2022-06-12 11:38:00	Location 2	Location 3	Success
740	50	20	2022-02-09 04:00:00	2022-02-09 04:24:00	Location 1	Location 10	Success
741	50	21	2021-08-10 11:00:00	2021-08-10 11:52:00	Location 10	Location 1	Success
742	50	22	2022-03-08 10:00:00	2022-03-08 10:19:00	Location 4	Location 10	Success
743	50	23	2022-10-03 01:00:00	2022-10-03 01:34:00	Location 5	Location 9	Success
744	50	24	2022-09-22 11:00:00	2022-09-22 11:16:00	Location 6	Location 10	Success
745	50	25	2022-02-08 07:00:00	2022-02-08 07:39:00	Location 3	Location 1	Success
746	50	26	2022-05-26 01:00:00	2022-05-26 01:47:00	Location 7	Location 1	Success
747	50	27	2021-06-25 07:00:00	2021-06-25 07:13:00	Location 2	Location 6	Success
748	50	28	2022-06-22 06:00:00	2022-06-22 06:12:00	Location 7	Location 3	Success
749	50	29	2022-01-06 11:00:00	2022-01-06 11:53:00	Location 4	Location 2	Success
750	50	30	2021-09-27 05:00:00	2021-09-27 05:26:00	Location 5	Location 7	Success
1	2	1	2021-11-25 05:00:00	2025-11-25 05:25:00	Location 9	Location 1	Success
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, firstname, lastname, email, phonenumber, registrationdate, membershiptype, status) FROM stdin;
1	User1	Last1	user1@example.com	+4074000001	2020-11-06	Premium	Inactive
2	User2	Last2	user2@example.com	+4074000002	2020-04-21	VIP	Active
3	User3	Last3	user3@example.com	+4074000003	2020-08-17	Standard	Inactive
4	User4	Last4	user4@example.com	+4074000004	2020-11-01	Premium	Active
5	User5	Last5	user5@example.com	+4074000005	2021-01-17	VIP	Inactive
6	User6	Last6	user6@example.com	+4074000006	2021-11-13	Standard	Active
7	User7	Last7	user7@example.com	+4074000007	2020-03-28	Premium	Inactive
8	User8	Last8	user8@example.com	+4074000008	2022-01-06	VIP	Active
9	User9	Last9	user9@example.com	+4074000009	2019-10-20	Standard	Inactive
10	User10	Last10	user10@example.com	+4074000010	2019-12-14	Premium	Active
11	User11	Last11	user11@example.com	+4074000011	2021-02-12	VIP	Inactive
12	User12	Last12	user12@example.com	+4074000012	2020-02-13	Standard	Active
13	User13	Last13	user13@example.com	+4074000013	2021-08-18	Premium	Inactive
14	User14	Last14	user14@example.com	+4074000014	2020-10-08	VIP	Active
15	User15	Last15	user15@example.com	+4074000015	2021-01-25	Standard	Inactive
16	User16	Last16	user16@example.com	+4074000016	2020-05-30	Premium	Active
17	User17	Last17	user17@example.com	+4074000017	2021-03-04	VIP	Inactive
18	User18	Last18	user18@example.com	+4074000018	2020-04-28	Standard	Active
19	User19	Last19	user19@example.com	+4074000019	2021-10-24	Premium	Inactive
20	User20	Last20	user20@example.com	+4074000020	2022-01-31	VIP	Active
21	User21	Last21	user21@example.com	+4074000021	2020-07-07	Standard	Inactive
22	User22	Last22	user22@example.com	+4074000022	2019-09-30	Premium	Active
23	User23	Last23	user23@example.com	+4074000023	2022-02-27	VIP	Inactive
24	User24	Last24	user24@example.com	+4074000024	2020-05-02	Standard	Active
25	User25	Last25	user25@example.com	+4074000025	2020-11-17	Premium	Inactive
26	User26	Last26	user26@example.com	+4074000026	2021-11-10	VIP	Active
27	User27	Last27	user27@example.com	+4074000027	2021-01-15	Standard	Inactive
28	User28	Last28	user28@example.com	+4074000028	2020-10-26	Premium	Active
29	User29	Last29	user29@example.com	+4074000029	2019-08-06	VIP	Inactive
30	User30	Last30	user30@example.com	+4074000030	2019-10-12	Standard	Active
31	User31	Last31	user31@example.com	+4074000031	2022-02-04	Premium	Inactive
32	User32	Last32	user32@example.com	+4074000032	2019-10-04	VIP	Active
33	User33	Last33	user33@example.com	+4074000033	2019-09-13	Standard	Inactive
34	User34	Last34	user34@example.com	+4074000034	2020-07-23	Premium	Active
35	User35	Last35	user35@example.com	+4074000035	2020-04-30	VIP	Inactive
36	User36	Last36	user36@example.com	+4074000036	2020-12-07	Standard	Active
37	User37	Last37	user37@example.com	+4074000037	2020-08-12	Premium	Inactive
38	User38	Last38	user38@example.com	+4074000038	2020-11-12	VIP	Active
39	User39	Last39	user39@example.com	+4074000039	2022-01-14	Standard	Inactive
40	User40	Last40	user40@example.com	+4074000040	2020-10-10	Premium	Active
41	User41	Last41	user41@example.com	+4074000041	2020-09-22	VIP	Inactive
42	User42	Last42	user42@example.com	+4074000042	2020-12-21	Standard	Active
43	User43	Last43	user43@example.com	+4074000043	2021-07-07	Premium	Inactive
44	User44	Last44	user44@example.com	+4074000044	2020-12-24	VIP	Active
45	User45	Last45	user45@example.com	+4074000045	2019-09-26	Standard	Inactive
46	User46	Last46	user46@example.com	+4074000046	2020-07-06	Premium	Active
47	User47	Last47	user47@example.com	+4074000047	2020-12-04	VIP	Inactive
48	User48	Last48	user48@example.com	+4074000048	2021-09-04	Standard	Active
49	User49	Last49	user49@example.com	+4074000049	2020-10-08	Premium	Inactive
50	User50	Last50	user50@example.com	+4074000050	2019-10-16	VIP	Active
\.


--
-- Name: bikes_bikeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bikes_bikeid_seq', 30, true);


--
-- Name: example_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.example_id_seq', 1, false);


--
-- Name: inventory_inventoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_inventoryid_seq', 1, false);


--
-- Name: maintenancelogs_logid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maintenancelogs_logid_seq', 1, false);


--
-- Name: payments_paymentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_paymentid_seq', 1, false);


--
-- Name: rentals_rentalid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rentals_rentalid_seq', 1, false);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 50, true);


--
-- Name: bikes bikes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bikes
    ADD CONSTRAINT bikes_pkey PRIMARY KEY (bikeid);


--
-- Name: example example_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.example
    ADD CONSTRAINT example_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventoryid);


--
-- Name: maintenancelogs maintenancelogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenancelogs
    ADD CONSTRAINT maintenancelogs_pkey PRIMARY KEY (logid);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (paymentid);


--
-- Name: rentals rentals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_pkey PRIMARY KEY (rentalid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: inventory inventory_bikeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_bikeid_fkey FOREIGN KEY (bikeid) REFERENCES public.bikes(bikeid);


--
-- Name: maintenancelogs maintenancelogs_bikeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenancelogs
    ADD CONSTRAINT maintenancelogs_bikeid_fkey FOREIGN KEY (bikeid) REFERENCES public.bikes(bikeid);


--
-- Name: payments payments_rentalid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_rentalid_fkey FOREIGN KEY (rentalid) REFERENCES public.rentals(rentalid);


--
-- Name: rentals rentals_bikeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_bikeid_fkey FOREIGN KEY (bikeid) REFERENCES public.bikes(bikeid);


--
-- Name: rentals rentals_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- PostgreSQL database dump complete
--

