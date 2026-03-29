BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "trust_declarations" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "readme_signatures" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "post_references" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "politai_users" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "polis_definitions" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "observe_declarations" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "flag_records" CASCADE;


--
-- MIGRATION VERSION FOR achaean
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('achaean', '20260329195934139', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329195934139', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR koinon_index_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('koinon_index_core', '20260329193840048', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329193840048', "timestamp" = now();

--
-- MIGRATION VERSION FOR koinon_index_content
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('koinon_index_content', '20260329193905675', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329193905675', "timestamp" = now();


COMMIT;
