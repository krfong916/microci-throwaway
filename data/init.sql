create table "users" 
(
  "id" uuid PRIMARY KEY NOT NULL,
  "username" varchar(255) UNIQUE NOT NULL,
  "password" varchar(64) NOT NULL,
  "is_active" boolean NOT NULL DEFAULT FALSE,
  "created_at" timestamp NOT NULL DEFAULT (now())
);

CREATE TABLE "report" (
  "id" uuid PRIMARY KEY NOT NULL,
  "username" varchar(255) NOT NULL,
  "description" text NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT (now())
);

ALTER TABLE "report" ADD FOREIGN KEY ("username") REFERENCES "users" ("username") ON DELETE CASCADE ON UPDATE CASCADE;

-- create a 'google' user
INSERT INTO users (id, username, password)
  VALUES ('991fd4cb-881a-444d-915b-7e92155801ed', 'test_user_a', '123');

-- create a ucsc user
INSERT INTO users (id, username, password)
  VALUES ('17bac180-dc4f-4522-a479-ed8611a83491', 'test_user_b', '456');

-- create a report
INSERT INTO report (id, username, description)
  VALUES ('57bf6e26-9d56-4d17-9363-5088eefc8200', 'test_user_a', 'report description');
