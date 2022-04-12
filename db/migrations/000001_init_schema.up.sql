CREATE TABLE "User" (
                        "id" bigserial NOT NULL,
                        "user_id" varchar PRIMARY KEY NOT NULL,
                        "user_name" varchar UNIQUE NOT NULL,
                        "first_name" varchar NOT NULL,
                        "last_name" varchar NOT NULL,
                        "password" varchar NOT NULL,
                        "role" varchar NOT NULL
);

-- CREATE TABLE "Customer" (
--                             "id" bigserial NOT NULL,
--                             "customer_name" varchar NOT NULL,
--                             "ticket_id" varchar NOT NULL,
--                             PRIMARY KEY ("customer_name", "ticket_id")
-- );

CREATE TABLE "Schedule" (
                            "id" bigserial NOT NULL,
                            "schedule_id" varchar PRIMARY KEY NOT NULL,
                            "movie_id" varchar NOT NULL,
                            "room_id" varchar NOT NULL,
                            "time_start" timestamp NOT NULL,
                            "time_end" timestamp NOT NULL
);

CREATE TABLE "Movie" (
                         "id" bigserial NOT NULL,
                         "movie_id" varchar PRIMARY KEY NOT NULL,
                         "movie_name" varchar NOT NULL,
                         "runtime" int NOT NULL,
                         "genre" varchar NOT NULL,
                         "status" varchar NOT NULL,
                         "image_url" varchar NOT NULL
);

CREATE TABLE "Room" (
                        "id" bigserial NOT NULL,
                        "room_id" varchar PRIMARY KEY NOT NULL,
                        "room_name" varchar UNIQUE NOT NULL,
                        "active" boolean NOT NULL
);

CREATE TABLE "Ticket" (
                          "id" bigserial,
                          "ticket_id" varchar PRIMARY KEY NOT NULL,
                          "schedule_id" varchar NOT NULL,
                          "order_id" varchar
);

CREATE TABLE "Ticket_Seat" (
                               "id" bigserial NOT NULL,
                               "ticket_id" varchar NOT NULL,
                               "seat_id" varchar NOT NULL,
                               PRIMARY KEY ("ticket_id", "seat_id")
);

CREATE TABLE "Tier" (
                        "id" bigserial NOT NULL,
                        "tier_id" varchar PRIMARY KEY NOT NULL,
                        "tier_name" varchar NOT NULL
);

CREATE TABLE "Schedule_Tier" (
                                 "id" bigserial NOT NULL,
                                 "schedule_id" varchar NOT NULL,
                                 "tier_id" varchar NOT NULL,
                                 "price" bigint NOT NULL,
                                 PRIMARY KEY ("schedule_id", "tier_id")
);

CREATE TABLE "Seat" (
                        "id" bigserial NOT NULL,
                        "seat_id" varchar PRIMARY KEY NOT NULL,
                        "room_id" varchar NOT NULL,
                        "tier_id" varchar NOT NULL,
                        "row" varchar NOT NULL,
                        "column" int NOT NULL,
                        "active" boolean NOT NULL
);

CREATE TABLE "Order" (
                         "id" bigserial NOT NULL,
                         "order_id" varchar PRIMARY KEY NOT NULL,
                         "created_at" timestamp NOT NULL DEFAULT (now())
);

CREATE TABLE "Order_Food" (
                              "id" bigserial NOT NULL,
                              "order_id" varchar NOT NULL,
                              "food_id" varchar NOT NULL
);

CREATE TABLE "Order_Drink" (
                               "id" bigserial NOT NULL,
                               "order_id" varchar NOT NULL,
                               "drink_id" varchar NOT NULL,
                               PRIMARY KEY ("order_id", "drink_id")
);

CREATE TABLE "Drink" (
                         "id" bigserial NOT NULL,
                         "drink_id" varchar PRIMARY KEY NOT NULL,
                         "name" varchar NOT NULL,
                         "price" bigint NOT NULL,
                         "image_url" varchar NOT NULL
);

CREATE TABLE "Food" (
                        "id" bigserial NOT NULL,
                        "food_id" varchar PRIMARY KEY NOT NULL,
                        "name" varchar NOT NULL,
                        "price" bigint NOT NULL,
                        "image_url" varchar NOT NULL
);

ALTER TABLE "Order_Food" ADD FOREIGN KEY ("order_id") REFERENCES "Order" ("order_id");

ALTER TABLE "Order_Food" ADD FOREIGN KEY ("food_id") REFERENCES "Food" ("food_id");

ALTER TABLE "Order_Drink" ADD FOREIGN KEY ("order_id") REFERENCES "Order" ("order_id");

ALTER TABLE "Order_Drink" ADD FOREIGN KEY ("drink_id") REFERENCES "Drink" ("drink_id");

ALTER TABLE "Ticket" ADD FOREIGN KEY ("schedule_id") REFERENCES "Schedule" ("schedule_id");

ALTER TABLE "Schedule" ADD FOREIGN KEY ("room_id") REFERENCES "Room" ("room_id");

ALTER TABLE "Schedule" ADD FOREIGN KEY ("movie_id") REFERENCES "Movie" ("movie_id");

ALTER TABLE "Seat" ADD FOREIGN KEY ("tier_id") REFERENCES "Tier" ("tier_id");

ALTER TABLE "Ticket_Seat" ADD FOREIGN KEY ("ticket_id") REFERENCES "Ticket" ("ticket_id");

ALTER TABLE "Ticket_Seat" ADD FOREIGN KEY ("seat_id") REFERENCES "Seat" ("seat_id");

ALTER TABLE "Seat" ADD FOREIGN KEY ("room_id") REFERENCES "Room" ("room_id");

ALTER TABLE "Schedule_Tier" ADD FOREIGN KEY ("schedule_id") REFERENCES "Schedule" ("schedule_id");

ALTER TABLE "Schedule_Tier" ADD FOREIGN KEY ("tier_id") REFERENCES "Tier" ("tier_id");

CREATE INDEX ON "User" ("user_name");

CREATE INDEX ON "Movie" ("movie_name");


INSERT INTO public."Drink" VALUES
                               (1, 'D_tGzO7', 'DN_tyt_l', 100, 'IMG_PLAV4iyGjZrFW0dgeq_p'),
                               (2, 'D_2_gsR', 'Cocacola', 100000, 'https://media.istockphoto.com/photos/paper-cup-with-a-popcorn-on-white-picture-id1160441778?k=20&m=1160441778&s=612x612&w=0&h=O14acdtSZldtg_I4Tmi3WbMZElbNwU3JuDfHzyN8-Hs=');


--
-- Data for Name: Food; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Food" VALUES
                              (1, 'F_9PYn5', 'FN_2Hx84eVNos', 100, 'PF_W9EIC'),
                              (2, 'D_ko7ht', 'Popcorn', 100000, 'https://media.istockphoto.com/photos/paper-cup-with-a-popcorn-on-white-picture-id1160441778?k=20&m=1160441778&s=612x612&w=0&h=O14acdtSZldtg_I4Tmi3WbMZElbNwU3JuDfHzyN8-Hs=');


--
-- Data for Name: Movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Movie" VALUES
                               (1, 'M_DjKvn', 'The Batman', 176, 'Action, Crime, Drama', 'RUNNING', 'https://m.media-amazon.com/images/M/MV5BMDdmMTBiNTYtMDIzNi00NGVlLWIzMDYtZTk3MTQ3NGQxZGEwXkEyXkFqcGdeQXVyMzMwOTU5MDk@._V1_SY139_CR1,0,92,139_.jpg'),
                               (1, 'M_neMzf', 'Ambulance', 136, 'Action, Crime, Drama, Thriller', 'RUNNING', 'https://m.media-amazon.com/images/M/MV5BYjUyN2VlZGEtNGEyZC00YjViLTgwYmQtZDJiM2FlOTU3Mjg2XkEyXkFqcGdeQXVyMjMxOTE0ODA@._V1_SX92_CR0,0,92,139_.jpg');


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Order_Drink; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Order_Food; Type: TABLE DATA; Schema: public; Owner: postgres
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


INSERT INTO public."Tier"
VALUES (1, 'T_2K-hy', 'NORMAL'),
       (2, 'T_p2N_-', 'VIP'),
       (3, 'T_oNjU4', 'SWEET BOX');
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





--
-- Data for Name: Ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Ticket_Seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES
                              (1, 'U_iJzFC', 'admin', 'Chinh', 'Pham', '$2a$10$iYny/j3jWO9wDhNaXIs2aOiyuFKqhg5RU2r5lTJEX.OnYNnZVX3LG', 'admin'),
                              (2, 'U_kAz08', 'staff', 'Chinh', 'Pham', '$2a$10$pWlBf6OHf4lEK12q9FAv5O2SAgrEUdAZGnidX.gRENEwDXYRko.0y', 'staff');

