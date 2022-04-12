--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9
-- Dumped by pg_dump version 14.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Customer"
(
    id            bigint            NOT NULL,
    customer_name character varying NOT NULL,
    ticket_id     character varying NOT NULL
);


ALTER TABLE public."Customer"
    OWNER TO postgres;

--
-- Name: Customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Customer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Customer_id_seq"
    OWNER TO postgres;

--
-- Name: Customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Customer_id_seq" OWNED BY public."Customer".id;


--
-- Name: Drink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Drink"
(
    id        bigint            NOT NULL,
    drink_id  character varying NOT NULL,
    name      character varying NOT NULL,
    price     bigint            NOT NULL,
    image_url character varying NOT NULL
);


ALTER TABLE public."Drink"
    OWNER TO postgres;

--
-- Name: Drink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Drink_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Drink_id_seq"
    OWNER TO postgres;

--
-- Name: Drink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Drink_id_seq" OWNED BY public."Drink".id;


--
-- Name: Food; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Food"
(
    id        bigint            NOT NULL,
    food_id   character varying NOT NULL,
    name      character varying NOT NULL,
    price     bigint            NOT NULL,
    image_url character varying NOT NULL
);


ALTER TABLE public."Food"
    OWNER TO postgres;

--
-- Name: Food_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Food_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Food_id_seq"
    OWNER TO postgres;

--
-- Name: Food_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Food_id_seq" OWNED BY public."Food".id;


--
-- Name: Movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movie"
(
    id         bigint            NOT NULL,
    movie_id   character varying NOT NULL,
    movie_name character varying NOT NULL,
    runtime    integer           NOT NULL,
    genre      character varying NOT NULL,
    status     character varying NOT NULL,
    image_url  character varying NOT NULL
);


ALTER TABLE public."Movie"
    OWNER TO postgres;

--
-- Name: Movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Movie_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Movie_id_seq"
    OWNER TO postgres;

--
-- Name: Movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Movie_id_seq" OWNED BY public."Movie".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order"
(
    id         bigint                                    NOT NULL,
    order_id   character varying                         NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Order"
    OWNER TO postgres;

--
-- Name: Order_Drink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order_Drink"
(
    id       bigint            NOT NULL,
    order_id character varying NOT NULL,
    drink_id character varying NOT NULL
);


ALTER TABLE public."Order_Drink"
    OWNER TO postgres;

--
-- Name: Order_Drink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_Drink_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_Drink_id_seq"
    OWNER TO postgres;

--
-- Name: Order_Drink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_Drink_id_seq" OWNED BY public."Order_Drink".id;


--
-- Name: Order_Food; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order_Food"
(
    id       bigint            NOT NULL,
    order_id character varying NOT NULL,
    food_id  character varying NOT NULL
);


ALTER TABLE public."Order_Food"
    OWNER TO postgres;

--
-- Name: Order_Food_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_Food_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_Food_id_seq"
    OWNER TO postgres;

--
-- Name: Order_Food_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_Food_id_seq" OWNED BY public."Order_Food".id;


--
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_id_seq"
    OWNER TO postgres;

--
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- Name: Room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Room"
(
    id        bigint            NOT NULL,
    room_id   character varying NOT NULL,
    room_name character varying NOT NULL,
    active    boolean           NOT NULL
);


ALTER TABLE public."Room"
    OWNER TO postgres;

--
-- Name: Room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Room_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Room_id_seq"
    OWNER TO postgres;

--
-- Name: Room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Room_id_seq" OWNED BY public."Room".id;


--
-- Name: Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Schedule"
(
    id          bigint                      NOT NULL,
    schedule_id character varying           NOT NULL,
    movie_id    character varying           NOT NULL,
    room_id     character varying           NOT NULL,
    time_start  timestamp without time zone NOT NULL,
    time_end    timestamp without time zone NOT NULL
);


ALTER TABLE public."Schedule"
    OWNER TO postgres;

--
-- Name: Schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Schedule_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Schedule_id_seq"
    OWNER TO postgres;

--
-- Name: Schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Schedule_id_seq" OWNED BY public."Schedule".id;


--
-- Name: Seat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Seat"
(
    id       bigint            NOT NULL,
    seat_id  character varying NOT NULL,
    room_id  character varying NOT NULL,
    tier_id  character varying NOT NULL,
    "row"    character varying NOT NULL,
    "column" integer           NOT NULL,
    active   boolean           NOT NULL
);


ALTER TABLE public."Seat"
    OWNER TO postgres;

--
-- Name: Seat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Seat_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Seat_id_seq"
    OWNER TO postgres;

--
-- Name: Seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Seat_id_seq" OWNED BY public."Seat".id;


--
-- Name: Ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ticket"
(
    id          bigint            NOT NULL,
    ticket_id   character varying NOT NULL,
    schedule_id character varying NOT NULL,
    order_id    character varying
);


ALTER TABLE public."Ticket"
    OWNER TO postgres;

--
-- Name: Ticket_Seat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ticket_Seat"
(
    id        bigint            NOT NULL,
    ticket_id character varying NOT NULL,
    seat_id   character varying NOT NULL
);


ALTER TABLE public."Ticket_Seat"
    OWNER TO postgres;

--
-- Name: Ticket_Seat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ticket_Seat_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ticket_Seat_id_seq"
    OWNER TO postgres;

--
-- Name: Ticket_Seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ticket_Seat_id_seq" OWNED BY public."Ticket_Seat".id;


--
-- Name: Ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ticket_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ticket_id_seq"
    OWNER TO postgres;

--
-- Name: Ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ticket_id_seq" OWNED BY public."Ticket".id;


--
-- Name: Tier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tier"
(
    id        bigint            NOT NULL,
    tier_id   character varying NOT NULL,
    tier_name character varying NOT NULL,
    price     bigint            NOT NULL
);


ALTER TABLE public."Tier"
    OWNER TO postgres;

--
-- Name: Tier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tier_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tier_id_seq"
    OWNER TO postgres;

--
-- Name: Tier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tier_id_seq" OWNED BY public."Tier".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User"
(
    id         bigint            NOT NULL,
    user_id    character varying NOT NULL,
    user_name  character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name  character varying NOT NULL,
    password   character varying NOT NULL,
    role       character varying NOT NULL
);


ALTER TABLE public."User"
    OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq"
    OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations
(
    version bigint  NOT NULL,
    dirty   boolean NOT NULL
);


ALTER TABLE public.schema_migrations
    OWNER TO postgres;

--
-- Name: Customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ALTER COLUMN id SET DEFAULT nextval('public."Customer_id_seq"'::regclass);


--
-- Name: Drink id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drink"
    ALTER COLUMN id SET DEFAULT nextval('public."Drink_id_seq"'::regclass);


--
-- Name: Food id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Food"
    ALTER COLUMN id SET DEFAULT nextval('public."Food_id_seq"'::regclass);


--
-- Name: Movie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movie"
    ALTER COLUMN id SET DEFAULT nextval('public."Movie_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: Order_Drink id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drink"
    ALTER COLUMN id SET DEFAULT nextval('public."Order_Drink_id_seq"'::regclass);


--
-- Name: Order_Food id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Food"
    ALTER COLUMN id SET DEFAULT nextval('public."Order_Food_id_seq"'::regclass);


--
-- Name: Room id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Room"
    ALTER COLUMN id SET DEFAULT nextval('public."Room_id_seq"'::regclass);


--
-- Name: Schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule"
    ALTER COLUMN id SET DEFAULT nextval('public."Schedule_id_seq"'::regclass);


--
-- Name: Seat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ALTER COLUMN id SET DEFAULT nextval('public."Seat_id_seq"'::regclass);


--
-- Name: Ticket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ticket"
    ALTER COLUMN id SET DEFAULT nextval('public."Ticket_id_seq"'::regclass);


--
-- Name: Ticket_Seat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ticket_Seat"
    ALTER COLUMN id SET DEFAULT nextval('public."Ticket_Seat_id_seq"'::regclass);


--
-- Name: Tier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tier"
    ALTER COLUMN id SET DEFAULT nextval('public."Tier_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: Drink; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Drink"
VALUES (1, 'D_tGzO7', 'DN_tyt_l', 100, 'IMG_PLAV4iyGjZrFW0dgeq_p'),
       (2, 'D_2_gsR', 'Cocacola', 100000,
        'https://media.istockphoto.com/photos/paper-cup-with-a-popcorn-on-white-picture-id1160441778?k=20&m=1160441778&s=612x612&w=0&h=O14acdtSZldtg_I4Tmi3WbMZElbNwU3JuDfHzyN8-Hs=');


--
-- Data for Name: Food; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Food"
VALUES (1, 'F_9PYn5', 'FN_2Hx84eVNos', 100, 'PF_W9EIC'),
       (2, 'D_ko7ht', 'Popcorn', 100000,
        'https://media.istockphoto.com/photos/paper-cup-with-a-popcorn-on-white-picture-id1160441778?k=20&m=1160441778&s=612x612&w=0&h=O14acdtSZldtg_I4Tmi3WbMZElbNwU3JuDfHzyN8-Hs=');


--
-- Data for Name: Movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Movie"
VALUES (1, 'M_DjKvn', 'The Batman', 176, 'Action, Crime, Drama', 'RUNNING',
        'https://m.media-amazon.com/images/M/MV5BMDdmMTBiNTYtMDIzNi00NGVlLWIzMDYtZTk3MTQ3NGQxZGEwXkEyXkFqcGdeQXVyMzMwOTU5MDk@._V1_SY139_CR1,0,92,139_.jpg'),
       (2, 'M_neMzf', 'Ambulance', 136, 'Action, Crime, Drama, Thriller', 'RUNNING',
        'https://m.media-amazon.com/images/M/MV5BYjUyN2VlZGEtNGEyZC00YjViLTgwYmQtZDJiM2FlOTU3Mjg2XkEyXkFqcGdeQXVyMjMxOTE0ODA@._V1_SX92_CR0,0,92,139_.jpg');


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: Order_Drink; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: Order_Food; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: Room; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Room"
VALUES (1, 'R_yAjMO', 'R1', true);


--
-- Data for Name: Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Schedule"
VALUES (1, 'S_RozOD', 'M_DjKvn', 'R_yAjMO', '1970-01-01 00:00:00', '1970-01-01 02:56:00'),
       (2, 'S_KchKx', 'M_DjKvn', 'R_yAjMO', '2022-03-24 10:00:00', '2022-03-24 12:56:00'),
       (3, 'S__FDn4', 'M_DjKvn', 'R_yAjMO', '2022-03-21 08:00:00', '2022-03-21 10:56:00'),
       (4, 'S_-Kicm', 'M_neMzf', 'R_yAjMO', '2022-03-21 15:00:00', '2022-03-21 17:16:00'),
       (5, 'S_7eewX', 'M_DjKvn', 'R_yAjMO', '2022-03-25 10:00:00', '2022-03-25 12:56:00');


--
-- Data for Name: Seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Seat"
VALUES (1, 'S_wkHGr', 'R_yAjMO', 'T_2K-hy', 'A', 1, true),
       (2, 'S_GZKHi', 'R_yAjMO', 'T_2K-hy', 'A', 2, true),
       (3, 'S_BPamp', 'R_yAjMO', 'T_2K-hy', 'A', 3, true),
       (4, 'S_LjwEK', 'R_yAjMO', 'T_2K-hy', 'A', 4, true),
       (5, 'S_iPr1Z', 'R_yAjMO', 'T_2K-hy', 'A', 5, true),
       (6, 'S_oMTXh', 'R_yAjMO', 'T_2K-hy', 'A', 6, true),
       (7, 'S_J8GDX', 'R_yAjMO', 'T_2K-hy', 'A', 7, true),
       (8, 'S_mLoNM', 'R_yAjMO', 'T_2K-hy', 'A', 8, true),
       (9, 'S_5RIcG', 'R_yAjMO', 'T_2K-hy', 'A', 9, true),
       (10, 'S_KdGb3', 'R_yAjMO', 'T_2K-hy', 'A', 10, true),
       (11, 'S_JkNGU', 'R_yAjMO', 'T_2K-hy', 'A', 11, true),
       (12, 'S_CWMpl', 'R_yAjMO', 'T_2K-hy', 'A', 12, true),
       (13, 'S_qLfPU', 'R_yAjMO', 'T_2K-hy', 'B', 1, true),
       (14, 'S_tnCsU', 'R_yAjMO', 'T_2K-hy', 'B', 2, true),
       (15, 'S_HMtYd', 'R_yAjMO', 'T_2K-hy', 'B', 3, true),
       (16, 'S_Y84Bp', 'R_yAjMO', 'T_2K-hy', 'B', 4, true),
       (17, 'S_bW68W', 'R_yAjMO', 'T_2K-hy', 'B', 5, true),
       (18, 'S_CSM72', 'R_yAjMO', 'T_2K-hy', 'B', 6, true),
       (19, 'S_MLZiR', 'R_yAjMO', 'T_2K-hy', 'B', 7, true),
       (20, 'S_xyrs3', 'R_yAjMO', 'T_2K-hy', 'B', 8, true),
       (21, 'S_Q5vhr', 'R_yAjMO', 'T_2K-hy', 'B', 9, true),
       (22, 'S_Y4mLw', 'R_yAjMO', 'T_2K-hy', 'B', 10, true),
       (23, 'S_HPI80', 'R_yAjMO', 'T_2K-hy', 'B', 11, true),
       (24, 'S_jXfbg', 'R_yAjMO', 'T_2K-hy', 'B', 12, true),
       (25, 'S_0KSjn', 'R_yAjMO', 'T_2K-hy', 'C', 1, true),
       (26, 'S_KjoxV', 'R_yAjMO', 'T_2K-hy', 'C', 2, true),
       (27, 'S_-b4jU', 'R_yAjMO', 'T_2K-hy', 'C', 3, true),
       (28, 'S_zLHP6', 'R_yAjMO', 'T_2K-hy', 'C', 4, true),
       (29, 'S_TtfHu', 'R_yAjMO', 'T_2K-hy', 'C', 5, true),
       (30, 'S_e4IJe', 'R_yAjMO', 'T_2K-hy', 'C', 6, true),
       (31, 'S_nsIHn', 'R_yAjMO', 'T_2K-hy', 'C', 7, true),
       (32, 'S_NkLx5', 'R_yAjMO', 'T_2K-hy', 'C', 8, true),
       (33, 'S_rjQXM', 'R_yAjMO', 'T_2K-hy', 'C', 9, true),
       (34, 'S_3U755', 'R_yAjMO', 'T_2K-hy', 'C', 10, true),
       (35, 'S_7zc2L', 'R_yAjMO', 'T_2K-hy', 'C', 11, true),
       (36, 'S_ZFlMf', 'R_yAjMO', 'T_2K-hy', 'C', 12, true),
       (37, 'S_MPnC-', 'R_yAjMO', 'T_2K-hy', 'D', 1, true),
       (38, 'S_Uj8SD', 'R_yAjMO', 'T_2K-hy', 'D', 2, true),
       (39, 'S_VxzQy', 'R_yAjMO', 'T_2K-hy', 'D', 3, true),
       (40, 'S_l3pG5', 'R_yAjMO', 'T_2K-hy', 'D', 4, true),
       (41, 'S_j1DXa', 'R_yAjMO', 'T_2K-hy', 'D', 5, true),
       (42, 'S_N1MRn', 'R_yAjMO', 'T_2K-hy', 'D', 6, true),
       (43, 'S_pshz2', 'R_yAjMO', 'T_2K-hy', 'D', 7, true),
       (44, 'S_NzxSp', 'R_yAjMO', 'T_2K-hy', 'D', 8, true),
       (45, 'S_LJmKh', 'R_yAjMO', 'T_2K-hy', 'D', 9, true),
       (46, 'S_DGpg9', 'R_yAjMO', 'T_2K-hy', 'D', 10, true),
       (47, 'S_JLmKS', 'R_yAjMO', 'T_2K-hy', 'D', 11, true),
       (48, 'S_CtYMA', 'R_yAjMO', 'T_2K-hy', 'D', 12, true),
       (49, 'S_KUVHA', 'R_yAjMO', 'T_p2N_-', 'E', 1, true),
       (50, 'S_l4jBL', 'R_yAjMO', 'T_p2N_-', 'E', 2, true),
       (51, 'S_cTdli', 'R_yAjMO', 'T_p2N_-', 'E', 3, true),
       (52, 'S_e0Pym', 'R_yAjMO', 'T_p2N_-', 'E', 4, true),
       (53, 'S_DlmHj', 'R_yAjMO', 'T_p2N_-', 'E', 5, true),
       (54, 'S_eeIMF', 'R_yAjMO', 'T_p2N_-', 'E', 6, true),
       (55, 'S_ulhwH', 'R_yAjMO', 'T_p2N_-', 'E', 7, true),
       (56, 'S_2YnmW', 'R_yAjMO', 'T_p2N_-', 'E', 8, true),
       (57, 'S_T4FBp', 'R_yAjMO', 'T_p2N_-', 'E', 9, true),
       (58, 'S_-N8SE', 'R_yAjMO', 'T_p2N_-', 'E', 10, true),
       (59, 'S_zvyvm', 'R_yAjMO', 'T_p2N_-', 'E', 11, true),
       (60, 'S_Pofxd', 'R_yAjMO', 'T_p2N_-', 'E', 12, true),
       (61, 'S_a7pvT', 'R_yAjMO', 'T_p2N_-', 'F', 1, true),
       (62, 'S_ZNBj-', 'R_yAjMO', 'T_p2N_-', 'F', 2, true),
       (63, 'S_N5Gms', 'R_yAjMO', 'T_p2N_-', 'F', 3, true),
       (64, 'S_yf8Rj', 'R_yAjMO', 'T_p2N_-', 'F', 4, true),
       (65, 'S_eC6tQ', 'R_yAjMO', 'T_p2N_-', 'F', 5, true),
       (66, 'S_zAmO8', 'R_yAjMO', 'T_p2N_-', 'F', 6, true),
       (67, 'S_Lc7iZ', 'R_yAjMO', 'T_p2N_-', 'F', 7, true),
       (68, 'S_jQMeb', 'R_yAjMO', 'T_p2N_-', 'F', 8, true),
       (69, 'S_l64W_', 'R_yAjMO', 'T_p2N_-', 'F', 9, true),
       (70, 'S_Nzz8s', 'R_yAjMO', 'T_p2N_-', 'F', 10, true),
       (71, 'S_iowQg', 'R_yAjMO', 'T_p2N_-', 'F', 11, true),
       (72, 'S_EFA8i', 'R_yAjMO', 'T_p2N_-', 'F', 12, true),
       (73, 'S_pjebF', 'R_yAjMO', 'T_p2N_-', 'G', 1, true),
       (74, 'S_zx33L', 'R_yAjMO', 'T_p2N_-', 'G', 2, true),
       (75, 'S_FwWlP', 'R_yAjMO', 'T_p2N_-', 'G', 3, true),
       (76, 'S_MhUkR', 'R_yAjMO', 'T_p2N_-', 'G', 4, true),
       (77, 'S_CVHxn', 'R_yAjMO', 'T_p2N_-', 'G', 5, true),
       (78, 'S_wANIe', 'R_yAjMO', 'T_p2N_-', 'G', 6, true),
       (79, 'S_eQrSS', 'R_yAjMO', 'T_p2N_-', 'G', 7, true),
       (80, 'S_94PUg', 'R_yAjMO', 'T_p2N_-', 'G', 8, true),
       (81, 'S_ZC9_r', 'R_yAjMO', 'T_p2N_-', 'G', 9, true),
       (82, 'S_fDldd', 'R_yAjMO', 'T_p2N_-', 'G', 10, true),
       (83, 'S_Dm9dG', 'R_yAjMO', 'T_p2N_-', 'G', 11, true),
       (84, 'S_5D8ml', 'R_yAjMO', 'T_p2N_-', 'G', 12, true),
       (85, 'S_so1fj', 'R_yAjMO', 'T_p2N_-', 'H', 1, true),
       (86, 'S_InE8g', 'R_yAjMO', 'T_p2N_-', 'H', 2, true),
       (87, 'S_s5y6k', 'R_yAjMO', 'T_p2N_-', 'H', 3, true),
       (88, 'S_UqiVl', 'R_yAjMO', 'T_p2N_-', 'H', 4, true),
       (89, 'S_khiau', 'R_yAjMO', 'T_p2N_-', 'H', 5, true),
       (90, 'S_8vQQm', 'R_yAjMO', 'T_p2N_-', 'H', 6, true),
       (91, 'S_RDp56', 'R_yAjMO', 'T_p2N_-', 'H', 7, true),
       (92, 'S_V4vR0', 'R_yAjMO', 'T_p2N_-', 'H', 8, true),
       (93, 'S_qxUZh', 'R_yAjMO', 'T_p2N_-', 'H', 9, true),
       (94, 'S_AzRbd', 'R_yAjMO', 'T_p2N_-', 'H', 10, true),
       (95, 'S_K1sb0', 'R_yAjMO', 'T_p2N_-', 'H', 11, true),
       (96, 'S_x8_JG', 'R_yAjMO', 'T_p2N_-', 'H', 12, true),
       (97, 'S_aLPmy', 'R_yAjMO', 'T_oNjU4', 'J', 1, true),
       (98, 'S_oOSj2', 'R_yAjMO', 'T_oNjU4', 'J', 2, true),
       (99, 'S_RYmrU', 'R_yAjMO', 'T_oNjU4', 'J', 3, true),
       (100, 'S_2glIG', 'R_yAjMO', 'T_oNjU4', 'J', 4, true),
       (101, 'S_16G2k', 'R_yAjMO', 'T_oNjU4', 'J', 5, true),
       (102, 'S_HmoVt', 'R_yAjMO', 'T_oNjU4', 'J', 6, true),
       (103, 'S_iqZwR', 'R_yAjMO', 'T_oNjU4', 'J', 7, true),
       (104, 'S_CL1UF', 'R_yAjMO', 'T_oNjU4', 'J', 8, true),
       (105, 'S_dLlBZ', 'R_yAjMO', 'T_oNjU4', 'J', 9, true),
       (106, 'S_6Ys7a', 'R_yAjMO', 'T_oNjU4', 'J', 10, true),
       (107, 'S_f8DaT', 'R_yAjMO', 'T_oNjU4', 'J', 11, true),
       (108, 'S_SNwgm', 'R_yAjMO', 'T_oNjU4', 'J', 12, true);


--
-- Data for Name: Ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: Ticket_Seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: Tier; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tier"
VALUES (1, 'T_2K-hy', 'NORMAL', 100000),
       (2, 'T_p2N_-', 'VIP', 120000),
       (3, 'T_oNjU4', 'SWEET BOX', 140000);


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User"
VALUES (1, 'U_iJzFC', 'admin', 'Chinh', 'Pham', '$2a$10$iYny/j3jWO9wDhNaXIs2aOiyuFKqhg5RU2r5lTJEX.OnYNnZVX3LG',
        'admin'),
       (2, 'U_kAz08', 'staff', 'Chinh', 'Pham', '$2a$10$pWlBf6OHf4lEK12q9FAv5O2SAgrEUdAZGnidX.gRENEwDXYRko.0y',
        'staff');


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.schema_migrations
VALUES (1, false);


--
-- Name: Customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Customer_id_seq"', 1, false);


--
-- Name: Drink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Drink_id_seq"', 1, false);


--
-- Name: Food_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Food_id_seq"', 1, false);


--
-- Name: Movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Movie_id_seq"', 1, false);


--
-- Name: Order_Drink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_Drink_id_seq"', 1, false);


--
-- Name: Order_Food_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_Food_id_seq"', 1, false);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1, false);


--
-- Name: Room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Room_id_seq"', 1, true);


--
-- Name: Schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Schedule_id_seq"', 1, false);


--
-- Name: Seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Seat_id_seq"', 108, true);


--
-- Name: Ticket_Seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ticket_Seat_id_seq"', 3, true);


--
-- Name: Ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ticket_id_seq"', 3, true);


--
-- Name: Tier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tier_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (customer_name, ticket_id);


--
-- Name: Drink Drink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Drink"
    ADD CONSTRAINT "Drink_pkey" PRIMARY KEY (drink_id);


--
-- Name: Food Food_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Food"
    ADD CONSTRAINT "Food_pkey" PRIMARY KEY (food_id);


--
-- Name: Movie Movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movie"
    ADD CONSTRAINT "Movie_pkey" PRIMARY KEY (movie_id);


--
-- Name: Order_Drink Order_Drink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drink"
    ADD CONSTRAINT "Order_Drink_pkey" PRIMARY KEY (order_id, drink_id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (order_id);


--
-- Name: Room Room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Room"
    ADD CONSTRAINT "Room_pkey" PRIMARY KEY (room_id);


--
-- Name: Room Room_room_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Room"
    ADD CONSTRAINT "Room_room_name_key" UNIQUE (room_name);


--
-- Name: Schedule Schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_pkey" PRIMARY KEY (schedule_id);


--
-- Name: Seat Seat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_pkey" PRIMARY KEY (seat_id);


--
-- Name: Ticket_Seat Ticket_Seat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ticket_Seat"
    ADD CONSTRAINT "Ticket_Seat_pkey" PRIMARY KEY (ticket_id, seat_id);


--
-- Name: Ticket Ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ticket"
    ADD CONSTRAINT "Ticket_pkey" PRIMARY KEY (ticket_id);


--
-- Name: Tier Tier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tier"
    ADD CONSTRAINT "Tier_pkey" PRIMARY KEY (tier_id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (user_id);


--
-- Name: User User_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_user_name_key" UNIQUE (user_name);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: Movie_movie_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Movie_movie_name_idx" ON public."Movie" USING btree (movie_name);


--
-- Name: User_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "User_user_name_idx" ON public."User" USING btree (user_name);


--
-- Name: Order_Drink Order_Drink_drink_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drink"
    ADD CONSTRAINT "Order_Drink_drink_id_fkey" FOREIGN KEY (drink_id) REFERENCES public."Drink" (drink_id);


--
-- Name: Order_Drink Order_Drink_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Drink"
    ADD CONSTRAINT "Order_Drink_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order" (order_id);


--
-- Name: Order_Food Order_Food_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Food"
    ADD CONSTRAINT "Order_Food_food_id_fkey" FOREIGN KEY (food_id) REFERENCES public."Food" (food_id);


--
-- Name: Order_Food Order_Food_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Food"
    ADD CONSTRAINT "Order_Food_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order" (order_id);


--
-- Name: Schedule Schedule_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_movie_id_fkey" FOREIGN KEY (movie_id) REFERENCES public."Movie" (movie_id);


--
-- Name: Schedule Schedule_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public."Room" (room_id);


--
-- Name: Seat Seat_tier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_tier_id_fkey" FOREIGN KEY (tier_id) REFERENCES public."Tier" (tier_id);


--
-- Name: Ticket_Seat Ticket_Seat_seat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ticket_Seat"
    ADD CONSTRAINT "Ticket_Seat_seat_id_fkey" FOREIGN KEY (seat_id) REFERENCES public."Seat" (seat_id);


--
-- Name: Ticket_Seat Ticket_Seat_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ticket_Seat"
    ADD CONSTRAINT "Ticket_Seat_ticket_id_fkey" FOREIGN KEY (ticket_id) REFERENCES public."Ticket" (ticket_id);


--
-- Name: Ticket Ticket_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ticket"
    ADD CONSTRAINT "Ticket_schedule_id_fkey" FOREIGN KEY (schedule_id) REFERENCES public."Schedule" (schedule_id);


--
-- PostgreSQL database dump complete
--

