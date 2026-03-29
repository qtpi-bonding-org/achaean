BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "koinon_observe_declarations" (
    "id" bigserial PRIMARY KEY,
    "fromPubkey" text NOT NULL,
    "toPubkey" text NOT NULL,
    "subjectRepoUrl" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "koinon_observe_declarations_from_to_idx" ON "koinon_observe_declarations" USING btree ("fromPubkey", "toPubkey");
CREATE INDEX "koinon_observe_declarations_from_pubkey_idx" ON "koinon_observe_declarations" USING btree ("fromPubkey");
CREATE INDEX "koinon_observe_declarations_to_pubkey_idx" ON "koinon_observe_declarations" USING btree ("toPubkey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "koinon_polis_definitions" (
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
CREATE UNIQUE INDEX "koinon_polis_definitions_repo_url_idx" ON "koinon_polis_definitions" USING btree ("repoUrl");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "koinon_politai_users" (
    "id" bigserial PRIMARY KEY,
    "pubkey" text NOT NULL,
    "repoUrl" text NOT NULL,
    "discoveredAt" timestamp without time zone NOT NULL,
    "lastIndexedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "koinon_politai_users_pubkey_idx" ON "koinon_politai_users" USING btree ("pubkey");
CREATE UNIQUE INDEX "koinon_politai_users_repo_url_idx" ON "koinon_politai_users" USING btree ("repoUrl");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "koinon_readme_signatures" (
    "id" bigserial PRIMARY KEY,
    "signerPubkey" text NOT NULL,
    "polisRepoUrl" text NOT NULL,
    "readmeCommit" text NOT NULL,
    "readmeHash" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "koinon_readme_signatures_signer_polis_idx" ON "koinon_readme_signatures" USING btree ("signerPubkey", "polisRepoUrl");
CREATE INDEX "koinon_readme_signatures_polis_idx" ON "koinon_readme_signatures" USING btree ("polisRepoUrl");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "koinon_trust_declarations" (
    "id" bigserial PRIMARY KEY,
    "fromPubkey" text NOT NULL,
    "toPubkey" text NOT NULL,
    "subjectRepoUrl" text NOT NULL,
    "level" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "koinon_trust_declarations_from_to_idx" ON "koinon_trust_declarations" USING btree ("fromPubkey", "toPubkey");
CREATE INDEX "koinon_trust_declarations_to_pubkey_idx" ON "koinon_trust_declarations" USING btree ("toPubkey");


--
-- MIGRATION VERSION FOR koinon_index_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('koinon_index_core', '20260329200144485', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329200144485', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


COMMIT;
