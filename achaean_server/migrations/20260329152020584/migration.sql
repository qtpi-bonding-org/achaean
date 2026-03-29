BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "observe_declarations" (
    "id" bigserial PRIMARY KEY,
    "fromPubkey" text NOT NULL,
    "toPubkey" text NOT NULL,
    "subjectRepoUrl" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "indexedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "observe_declarations_from_to_idx" ON "observe_declarations" USING btree ("fromPubkey", "toPubkey");
CREATE INDEX "observe_declarations_from_pubkey_idx" ON "observe_declarations" USING btree ("fromPubkey");
CREATE INDEX "observe_declarations_to_pubkey_idx" ON "observe_declarations" USING btree ("toPubkey");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "politai_users" DROP COLUMN "displayName";

--
-- MIGRATION VERSION FOR achaean
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('achaean', '20260329152020584', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260329152020584', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


COMMIT;
