/* Template applied to each service DB */
\c :DBNAME;
GRANT CONNECT ON DATABASE :DBNAME TO debezium_user;
GRANT USAGE ON SCHEMA public TO debezium_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO debezium_user;
CREATE PUBLICATION IF NOT EXISTS dbz_publication FOR ALL TABLES;