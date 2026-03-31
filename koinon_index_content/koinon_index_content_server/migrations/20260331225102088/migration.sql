BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "koinon_post_references" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "koinon_post_references" (
    "id" bigserial PRIMARY KEY,
    "authorPubkey" text NOT NULL,
    "authorRepoUrl" text NOT NULL,
    "postUrl" text NOT NULL,
    "commitHash" text NOT NULL,
    "title" text,
    "poleisTags" text,
    "timestamp" timestamp without time zone NOT NULL,
    "parentPostUrl" text,
    "encrypted" boolean NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "koinon_post_references_post_url_idx" ON "koinon_post_references" USING btree ("postUrl");
CREATE INDEX "koinon_post_references_timestamp_idx" ON "koinon_post_references" USING btree ("timestamp");
CREATE INDEX "koinon_post_references_parent_idx" ON "koinon_post_references" USING btree ("parentPostUrl");


--
-- MIGRATION VERSION FOR koinon_index_content
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('koinon_index_content', '20260331225102088', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260331225102088', "timestamp" = now();

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
    VALUES ('koinon_index_core', '20260329200144485', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329200144485', "timestamp" = now();


COMMIT;
