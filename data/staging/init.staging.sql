create table identities 
(
  identity_id serial not null,
  identity varchar(255) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint identity unique (identity),
  primary key (identity_id)
);

create table privileges 
(
  privilege_id serial not null,
  privilege varchar(64) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint privilege unique (privilege),
  primary key (privilege_id)
);

create table feelings 
(
  feeling_id serial not null,
  feeling varchar(255) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint feeling unique (feeling),
  primary key (feeling_id)
);

create table occupations 
(
  occupation_id serial not null,
  occupation varchar(64) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint occupation unique (occupation),
  primary key (occupation_id)
);

create table industries 
(
  industry_id serial not null,
  industry varchar(64) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint industry unique (industry),
  primary key (industry_id)
);

create table workplaces 
(
  workplace_id serial not null,
  workplace_name varchar(255) not null,
  workplace_abbreviation varchar(64),
  has_locations smallint not null,
  industry_id integer not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint workplace_name unique (workplace_name),
  constraint workplace_abbreviation unique (workplace_abbreviation),
  primary key (workplace_id)
);

alter table workplaces 
  add foreign key (industry_id) REFERENCES industries(industry_id);

create table locations 
(
  location_id serial not null,
  location_name varchar(255) not null,
  workplace_id integer not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  primary key (location_id)
);

create extension postgis;

alter table locations
  add column location_coordinates geometry(Point, 4326) not null;

alter table locations
  add foreign key (workplace_id) REFERENCES workplaces(workplace_id);

create table workplace_email_address_domains 
(
  workplace_email_address_domain_id serial not null,
  domain_name varchar(255) not null,
  workplace_id integer not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint domain_name unique (domain_name),
  primary key (workplace_email_address_domain_id)
);

alter table workplace_email_address_domains 
  add foreign key (workplace_id) REFERENCES workplaces(workplace_id);

create table users 
(
  user_id varchar(255) not null,
  occupation_id integer not null,
  username varchar(32) not null,
  password varchar(255) not null,
  is_active smallint not null DEFAULT 0,
  local_email_address varchar(64) not null,
  workplace_email_address_domain_id integer not null,
  privilege_id integer not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  constraint email_address unique (local_email_address, workplace_email_address_domain_id),
  constraint username unique (username),
  primary key (user_id)
);

alter table users
  add foreign key (occupation_id) REFERENCES occupations(occupation_id),
  add foreign key (privilege_id) REFERENCES privileges(privilege_id),
  add foreign key (workplace_email_address_domain_id) REFERENCES workplace_email_address_domains(workplace_email_address_domain_id);

create table reports 
(
  report_id varchar(255) not null,
  description TEXT not null,
  privacy smallint not null,
  workplace_id integer not null,
  location_id integer DEFAULT (-1),
  feeling_id integer not null,
  username varchar(255) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  primary key (report_id)
);

alter table reports
  add foreign key (workplace_id) REFERENCES workplaces(workplace_id),
  add foreign key (feeling_id) REFERENCES feelings(feeling_id),
  add foreign key (username) REFERENCES users(username);

create table reports_identities 
(
  report_id varchar(255),
  identity_id integer
);

alter table reports_identities 
  add foreign key (report_id) REFERENCES reports(report_id);
alter table reports_identities
  add foreign key (identity_id) REFERENCES identities(identity_id);

create table confirmation_tokens 
(
  confirmation_token varchar(255),
  user_id varchar(255),
  updated_at timestamp default CURRENT_TIMESTAMP not null,
  created_at timestamp default CURRENT_TIMESTAMP,
  primary key (confirmation_token)
);

alter table confirmation_tokens
  add foreign key (user_id) REFERENCES users(user_id);

INSERT INTO identities (identity) VALUES ('sexual orientation'), ('race'), ('gender'), ('something else'), ('culture');
INSERT INTO privileges (privilege) VALUES ('moderator'), ('regular'), ('banned');
INSERT INTO feelings (feeling) VALUES ('not at all'), ('somewhat'), ('very much'), ('affected');
INSERT INTO occupations (occupation) VALUES ('student'), ('worker'), ('engineer'), ('professor');
INSERT INTO industries (industry) VALUES ('education'), ('health care'), ('food and service'), ('technology');

-- create a workplace
INSERT INTO workplaces (workplace_name, workplace_abbreviation, has_locations, industry_id)
  VALUES ('University of California, Santa Cruz', 'UC Santa Cruz', 1, 1),
  ('University of California, Los Angeles', 'UCLA', 0, 1),
  ('Google', 'Google', 0, 4);

-- create a location
INSERT INTO locations (location_name, location_coordinates, workplace_id) 
  VALUES ('Kresge Town Hall', (ST_GeomFromText('POINT(36.998882 -122.066376)', 4326)), 1),
  ('Engineering 2', (ST_GeomFromText('POINT(37.001148 -122.063263)', 4326)), 1);

-- create a google workplace email
INSERT INTO workplace_email_address_domains (domain_name, workplace_id) VALUES ('gmail.com', 3);

-- create a ucsc workplace email
INSERT INTO workplace_email_address_domains (domain_name, workplace_id) VALUES ('ucsc.edu', 1);

-- create a 'google' user
INSERT INTO users (user_id, occupation_id, username, password, local_email_address, workplace_email_address_domain_id, privilege_id)
  VALUES ('991fd4cb-881a-444d-915b-7e92155801ed', 3, 'qwe', 'qwe', 'krfong', 2, 2);

-- create a ucsc user
INSERT INTO users (user_id, occupation_id, username, password, local_email_address, workplace_email_address_domain_id, privilege_id)
  VALUES ('17bac180-dc4f-4522-a479-ed8611a83491', 1, 'test', 'test', 'krfong', 1, 2);

-- create a ucsc report, private
INSERT INTO reports (report_id, description, privacy, workplace_id, feeling_id, username)
  VALUES ('44eb70e1-26cb-42e0-9a21-dc3f95baf8f5', 'from test', 0, 1, 1, 'test'),
  ('dcdc99ea-f313-4edf-8767-3f7acab30c4f', 'from qwe', 1, 3, 3, 'qwe');

-- create a google report, public
INSERT INTO reports (report_id, description, privacy, workplace_id, feeling_id, username)
  VALUES ('57bf6e26-9d56-4d17-9363-5088eefc8200', 'second from test', 0, 1, 3, 'test');
