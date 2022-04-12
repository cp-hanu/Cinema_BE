CREATE TABLE "User" (
  "id" bigserial NOT NULL,
  "user_id" varchar PRIMARY KEY NOT NULL,
  "user_name" varchar UNIQUE NOT NULL,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "password" varchar NOT NULL,
  "role" varchar NOT NULL
);

CREATE TABLE "Customer" (
  "id" bigserial NOT NULL,
  "customer_name" varchar NOT NULL,
  "ticket_id" varchar NOT NULL,
  PRIMARY KEY ("customer_name", "ticket_id")
);

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
  "tier_name" varchar NOT NULL,
  "schedule_id" varchar NOT NULL,
  "price" bigint NOT NULL
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
