BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "polis_definitions" (
    "id" bigserial PRIMARY KEY,
    "repoUrl" text NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "threshold" bigint NOT NULL,
    "parentRepoUrl" text,
    "ownerPubkey" text NOT NULL,
    "readmeCommit" text,
    "discoveredAt" timestamp without time zone NOT NULL,
    "lastIndexedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "polis_definitions_repo_url_idx" ON "polis_definitions" USING btree ("repoUrl");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "politai_users" (
    "id" bigserial PRIMARY KEY,
    "pubkey" text NOT NULL,
    "repoUrl" text NOT NULL,
    "displayName" text,
    "discoveredAt" timestamp without time zone NOT NULL,
    "lastIndexedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "politai_users_pubkey_idx" ON "politai_users" USING btree ("pubkey");
CREATE UNIQUE INDEX "politai_users_repo_url_idx" ON "politai_users" USING btree ("repoUrl");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post_references" (
    "id" bigserial PRIMARY KEY,
    "authorPubkey" text NOT NULL,
    "authorRepoUrl" text NOT NULL,
    "path" text NOT NULL,
    "commitHash" text NOT NULL,
    "title" text,
    "poleisTags" text,
    "timestamp" timestamp without time zone NOT NULL,
    "isReply" boolean NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "post_references_author_path_idx" ON "post_references" USING btree ("authorPubkey", "path");
CREATE INDEX "post_references_timestamp_idx" ON "post_references" USING btree ("timestamp");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "readme_signatures" (
    "id" bigserial PRIMARY KEY,
    "signerPubkey" text NOT NULL,
    "polisRepoUrl" text NOT NULL,
    "readmeCommit" text NOT NULL,
    "readmeHash" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "readme_signatures_signer_polis_idx" ON "readme_signatures" USING btree ("signerPubkey", "polisRepoUrl");
CREATE INDEX "readme_signatures_polis_idx" ON "readme_signatures" USING btree ("polisRepoUrl");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "trust_declarations" (
    "id" bigserial PRIMARY KEY,
    "fromPubkey" text NOT NULL,
    "toPubkey" text NOT NULL,
    "subjectRepoUrl" text NOT NULL,
    "level" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "trust_declarations_from_to_idx" ON "trust_declarations" USING btree ("fromPubkey", "toPubkey");
CREATE INDEX "trust_declarations_to_pubkey_idx" ON "trust_declarations" USING btree ("toPubkey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "account_device" (
    "id" bigserial PRIMARY KEY,
    "accountId" bigint NOT NULL,
    "deviceSigningPublicKeyHex" text NOT NULL,
    "encryptedDataKey" text NOT NULL,
    "label" text NOT NULL,
    "lastActive" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isRevoked" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE INDEX "auth_lookup_idx" ON "account_device" USING btree ("deviceSigningPublicKeyHex", "isRevoked");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "anon_account" (
    "id" bigserial PRIMARY KEY,
    "ultimateSigningPublicKeyHex" text NOT NULL,
    "encryptedDataKey" text NOT NULL,
    "ultimatePublicKey" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "ultimate_key_idx" ON "anon_account" USING btree ("ultimatePublicKey");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "account_device"
    ADD CONSTRAINT "account_device_fk_0"
    FOREIGN KEY("accountId")
    REFERENCES "anon_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR achaean
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('achaean', '20260309165741803', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260309165741803', "timestamp" = now();

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
