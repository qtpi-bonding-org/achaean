BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "flag_records" (
    "id" bigserial PRIMARY KEY,
    "flaggedByPubkey" text NOT NULL,
    "postAuthorPubkey" text NOT NULL,
    "postPath" text NOT NULL,
    "polisRepoUrl" text NOT NULL,
    "reason" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "flag_records_flagger_post_polis_idx" ON "flag_records" USING btree ("flaggedByPubkey", "postPath", "polisRepoUrl");
CREATE INDEX "flag_records_post_polis_idx" ON "flag_records" USING btree ("postPath", "polisRepoUrl");
CREATE INDEX "flag_records_author_idx" ON "flag_records" USING btree ("postAuthorPubkey");

--
-- ACTION DROP TABLE
--
DROP TABLE "polis_definitions" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "polis_definitions" (
    "id" bigserial PRIMARY KEY,
    "repoUrl" text NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "membershipThreshold" bigint NOT NULL,
    "flagThreshold" bigint NOT NULL,
    "parentRepoUrl" text,
    "ownerPubkey" text NOT NULL,
    "readmeCommit" text,
    "discoveredAt" timestamp without time zone NOT NULL,
    "lastIndexedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "polis_definitions_repo_url_idx" ON "polis_definitions" USING btree ("repoUrl");


--
-- MIGRATION VERSION FOR achaean
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('achaean', '20260309224754165', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260309224754165', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR anonaccount
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('anonaccount', '20260309121840300', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260309121840300', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
