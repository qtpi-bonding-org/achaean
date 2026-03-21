BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_core_user" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_core_session" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_core_profile_image" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_core_profile" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_core_jwt_refresh_token" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "anon_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "account_device" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_secret_challenge" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_rate_limited_request_attempt" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_passkey_challenge" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_passkey_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_microsoft_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_google_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_github_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_firebase_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_facebook_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_email_account_request" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_email_account_password_reset_request" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_email_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_apple_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "serverpod_auth_idp_anonymous_account" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "post_references" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post_references" (
    "id" bigserial PRIMARY KEY,
    "authorPubkey" text NOT NULL,
    "authorRepoUrl" text NOT NULL,
    "postUrl" text NOT NULL,
    "commitHash" text NOT NULL,
    "title" text,
    "poleisTags" text,
    "timestamp" timestamp without time zone NOT NULL,
    "isReply" boolean NOT NULL,
    "parentPostUrl" text,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "post_references_post_url_idx" ON "post_references" USING btree ("postUrl");
CREATE INDEX "post_references_timestamp_idx" ON "post_references" USING btree ("timestamp");
CREATE INDEX "post_references_parent_idx" ON "post_references" USING btree ("parentPostUrl");


--
-- MIGRATION VERSION FOR achaean
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('achaean', '20260321010931808', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260321010931808', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


--
-- MIGRATION VERSION FOR 'serverpod_auth_idp', 'anonaccount', 'serverpod_auth_core'
--
DELETE FROM "serverpod_migrations"WHERE "module" IN ('serverpod_auth_idp', 'anonaccount', 'serverpod_auth_core');

COMMIT;
