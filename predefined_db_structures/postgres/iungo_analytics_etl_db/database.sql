CREATE DATABASE analytics_etl_result;

\connect analytics_etl_result;

CREATE TABLE visits (
  id BIGSERIAL PRIMARY KEY,
  hot_spot_uuid VARCHAR(255) NOT NULL,
  year  INTEGER NOT NULL,
  month  INTEGER NOT NULL,
  day INTEGER NOT NULL,
  hour INTEGER NOT NULL,
  amount INTEGER NOT NULL
);

CREATE TABLE job_metadata (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  last_data TIMESTAMP NOT NULL
);

CREATE TABLE new_visits (
  id BIGSERIAL PRIMARY KEY,
  hot_spot_uuid VARCHAR(255) NOT NULL,
  year  INTEGER NOT NULL,
  month  INTEGER NOT NULL,
  day INTEGER NOT NULL,
  hour INTEGER NOT NULL,
  amount INTEGER NOT NUL
);

CREATE TABLE new_visitors (
  id BIGSERIAL PRIMARY KEY,
  hot_spot_uuid VARCHAR(255) NOT NULL,
  mac VARCHAR(63) NOT NULL,
  first_visit TIMESTAMP NOT NULL
);

CREATE TABLE user_email_data (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(1024) NOT NULL,
  username VARCHAR(1024) DEFAULT NULL,
  hot_spot_id VARCHAR(255) NOT NULL,
  last_login TIMESTAMP NOT NULL,
  first_login TIMESTAMP NOT NULL,
  direct_marketing BOOLEAN NOT NULL DEFAULT FALSE
  total_visits INTEGER NOT NULL
);

