-- Create the Forgejo database and user
CREATE USER forgejo WITH PASSWORD 'forgejo';
CREATE DATABASE forgejo OWNER forgejo;

-- Load Apache AGE extension into the achaean database
LOAD 'age';
CREATE EXTENSION IF NOT EXISTS age;
SET search_path = ag_catalog, "$user", public;

-- Create the trust graph
SELECT create_graph('trust_graph');
