-- Synedrion Schema: Relational Tables + Apache AGE Graph
--
-- This is the reference schema for building a Koinon indexer (synedrion).
-- Requires PostgreSQL with the Apache AGE extension for graph queries.
--
-- The synedrion indexes data from users' git repos. It never stores content —
-- only metadata pointers and trust graph edges.

-- ============================================================================
-- RELATIONAL TABLES
-- ============================================================================

-- Users (politai) — discovered by the indexer from git repos.
CREATE TABLE politai_users (
  id            BIGSERIAL PRIMARY KEY,
  pubkey        TEXT NOT NULL,
  repo_url      TEXT NOT NULL,
  discovered_at TIMESTAMPTZ NOT NULL,
  last_indexed_at TIMESTAMPTZ,

  CONSTRAINT politai_users_pubkey_idx UNIQUE (pubkey)
);

-- Trust declarations — directed edges in the trust graph.
-- Indexed from koinon.json manifests in user repos.
CREATE TABLE trust_declarations (
  id               BIGSERIAL PRIMARY KEY,
  from_pubkey      TEXT NOT NULL,
  to_pubkey        TEXT NOT NULL,
  subject_repo_url TEXT NOT NULL,
  level            TEXT NOT NULL,        -- 'trust' or 'provisional'
  timestamp        TIMESTAMPTZ NOT NULL,
  indexed_at       TIMESTAMPTZ NOT NULL,

  CONSTRAINT trust_declarations_from_to_idx UNIQUE (from_pubkey, to_pubkey)
);
CREATE INDEX trust_declarations_to_pubkey_idx ON trust_declarations (to_pubkey);

-- Observe declarations — non-structural, personal feed only.
-- Does NOT affect the trust graph or polis membership.
CREATE TABLE observe_declarations (
  id               BIGSERIAL PRIMARY KEY,
  from_pubkey      TEXT NOT NULL,
  to_pubkey        TEXT NOT NULL,
  subject_repo_url TEXT NOT NULL,
  timestamp        TIMESTAMPTZ NOT NULL,
  indexed_at       TIMESTAMPTZ NOT NULL,

  CONSTRAINT observe_declarations_from_to_idx UNIQUE (from_pubkey, to_pubkey)
);
CREATE INDEX observe_declarations_from_pubkey_idx ON observe_declarations (from_pubkey);
CREATE INDEX observe_declarations_to_pubkey_idx ON observe_declarations (to_pubkey);

-- Polis definitions — communities known to the indexer.
CREATE TABLE polis_definitions (
  id                    BIGSERIAL PRIMARY KEY,
  repo_url              TEXT NOT NULL,
  name                  TEXT NOT NULL,
  description           TEXT,
  membership_threshold  INT NOT NULL,     -- mutual trust links required for membership
  flag_threshold        INT NOT NULL,     -- flags before content is blurred
  parent_repo_url       TEXT,             -- null for genesis poleis
  owner_pubkey          TEXT NOT NULL,
  readme_commit         TEXT,
  discovered_at         TIMESTAMPTZ NOT NULL,
  last_indexed_at       TIMESTAMPTZ,

  CONSTRAINT polis_definitions_repo_url_idx UNIQUE (repo_url)
);

-- README signatures — a polites has signed a polis README (cosigned the social contract).
CREATE TABLE readme_signatures (
  id              BIGSERIAL PRIMARY KEY,
  signer_pubkey   TEXT NOT NULL,
  polis_repo_url  TEXT NOT NULL,
  readme_commit   TEXT NOT NULL,
  readme_hash     TEXT NOT NULL,
  timestamp       TIMESTAMPTZ NOT NULL,
  indexed_at      TIMESTAMPTZ NOT NULL,

  CONSTRAINT readme_signatures_signer_polis_idx UNIQUE (signer_pubkey, polis_repo_url)
);
CREATE INDEX readme_signatures_polis_idx ON readme_signatures (polis_repo_url);

-- Post references — metadata pointers to posts in user repos.
-- The synedrion NEVER stores post content, only the reference.
CREATE TABLE post_references (
  id               BIGSERIAL PRIMARY KEY,
  author_pubkey    TEXT NOT NULL,
  author_repo_url  TEXT NOT NULL,
  post_url         TEXT NOT NULL,          -- full URL to post.json on the forge
  commit_hash      TEXT NOT NULL,
  title            TEXT,
  poleis_tags      TEXT,                   -- comma-separated polis repo URLs
  timestamp        TIMESTAMPTZ NOT NULL,
  parent_post_url  TEXT,                   -- null unless this is a reply
  indexed_at       TIMESTAMPTZ NOT NULL,

  CONSTRAINT post_references_post_url_idx UNIQUE (post_url)
);
CREATE INDEX post_references_timestamp_idx ON post_references (timestamp);
CREATE INDEX post_references_parent_idx ON post_references (parent_post_url);

-- Flag records — moderation signals from polis members.
CREATE TABLE flag_records (
  id                 BIGSERIAL PRIMARY KEY,
  flagged_by_pubkey  TEXT NOT NULL,
  post_author_pubkey TEXT NOT NULL,
  post_url           TEXT NOT NULL,
  polis_repo_url     TEXT NOT NULL,
  reason             TEXT NOT NULL,
  timestamp          TIMESTAMPTZ NOT NULL,
  indexed_at         TIMESTAMPTZ NOT NULL,

  CONSTRAINT flag_records_flagger_post_polis_idx UNIQUE (flagged_by_pubkey, post_url, polis_repo_url)
);
CREATE INDEX flag_records_post_polis_idx ON flag_records (post_url, polis_repo_url);
CREATE INDEX flag_records_author_idx ON flag_records (post_author_pubkey);

-- ============================================================================
-- APACHE AGE GRAPH
-- ============================================================================

-- The trust graph uses Apache AGE (a PostgreSQL extension for graph queries).
-- AGE stores graph data in its own internal tables but is queried via Cypher
-- wrapped in SQL.

-- Initialize AGE and create the koinon graph:
CREATE EXTENSION IF NOT EXISTS age;
-- LOAD 'age';  -- Must be run per-session (see queries.sql)
-- SET search_path = ag_catalog, "$user", public;  -- Must be run per-session

-- Create the graph (idempotent check):
-- SELECT * FROM ag_catalog.create_graph('koinon');

-- Graph schema (implicit — created by MERGE operations):
--
--   Node labels:
--     Polites  { pubkey: text }         -- a user
--     Polis    { repo_url: text,        -- a community
--                membership_threshold: int }
--
--   Edge labels:
--     TRUSTS   { level: text }          -- (Polites)-[:TRUSTS]->(Polites)
--     SIGNED                            -- (Polites)-[:SIGNED]->(Polis)
--
-- The graph mirrors the relational data but enables efficient traversal
-- queries like "find all signers with N mutual trust edges."
