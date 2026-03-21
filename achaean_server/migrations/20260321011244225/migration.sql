BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "flag_records" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "flag_records" (
    "id" bigserial PRIMARY KEY,
    "flaggedByPubkey" text NOT NULL,
    "postAuthorPubkey" text NOT NULL,
    "postUrl" text NOT NULL,
    "polisRepoUrl" text NOT NULL,
    "reason" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "flag_records_flagger_post_polis_idx" ON "flag_records" USING btree ("flaggedByPubkey", "postUrl", "polisRepoUrl");
CREATE INDEX "flag_records_post_polis_idx" ON "flag_records" USING btree ("postUrl", "polisRepoUrl");
CREATE INDEX "flag_records_author_idx" ON "flag_records" USING btree ("postAuthorPubkey");


--
-- MIGRATION VERSION FOR achaean
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('achaean', '20260321011244225', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260321011244225', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


COMMIT;
