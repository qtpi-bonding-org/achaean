-- Create the Forgejo database and user. These are supplied by the postgres
-- container environment during first-volume initialization; do not hard-code
-- a development password here.
\getenv forgejo_db_user FORGEJO_DB_USER
\getenv forgejo_db_pass FORGEJO_DB_PASS
\getenv forgejo_db_name FORGEJO_DB_NAME
CREATE USER :"forgejo_db_user" WITH PASSWORD :'forgejo_db_pass';
CREATE DATABASE :"forgejo_db_name" OWNER :"forgejo_db_user";

-- Load Apache AGE extension into the achaean database
LOAD 'age';
CREATE EXTENSION IF NOT EXISTS age;
SET search_path = ag_catalog, "$user", public;

-- Create the trust graph
SELECT create_graph('trust_graph');
