BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "post_references" DROP COLUMN "isReply";

--
-- MIGRATION VERSION FOR achaean
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('achaean', '20260321094224593', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260321094224593', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


COMMIT;
