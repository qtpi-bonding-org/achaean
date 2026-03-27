-- Synedrion Queries: Reference operations for a Koinon indexer
--
-- These are the key queries a synedrion needs to implement.
-- They correspond to the API endpoints any synedrion should expose.
--
-- AGE Cypher queries require per-session setup:
--   LOAD 'age';
--   SET search_path = ag_catalog, "$user", public;

-- ============================================================================
-- USER LOOKUP
-- ============================================================================

-- getUser: Look up a user by public key.
SELECT * FROM politai_users WHERE pubkey = :pubkey LIMIT 1;

-- ============================================================================
-- POLIS (COMMUNITIES)
-- ============================================================================

-- listPoleis: List all known poleis, newest first.
SELECT * FROM polis_definitions ORDER BY discovered_at DESC;

-- getPolis: Get a single polis by repo URL.
SELECT * FROM polis_definitions WHERE repo_url = :repo_url LIMIT 1;

-- getPolisMembers: Get all signers of a polis with their mutual trust count.
-- Returns each signer's pubkey, repo URL, and the number of mutual trust
-- connections they have with other signers of the same polis.
-- The client compares trust_connections against membership_threshold to
-- determine full member vs provisional.
--
-- Step 1: Get all signers for the polis.
SELECT s.signer_pubkey, u.repo_url
FROM readme_signatures s
LEFT JOIN politai_users u ON u.pubkey = s.signer_pubkey
WHERE s.polis_repo_url = :polis_repo_url;

-- Step 2: For each signer, count mutual trust connections from other signers.
-- "Mutual" means: signer A trusts signer B AND signer B trusts signer A,
-- where both have level = 'trust' (not 'provisional').
SELECT
  t_in.to_pubkey AS signer_pubkey,
  COUNT(*) AS trust_connections
FROM trust_declarations t_in
JOIN trust_declarations t_out
  ON t_in.from_pubkey = t_out.to_pubkey
  AND t_in.to_pubkey = t_out.from_pubkey
JOIN readme_signatures rs_from
  ON rs_from.signer_pubkey = t_in.from_pubkey
  AND rs_from.polis_repo_url = :polis_repo_url
JOIN readme_signatures rs_to
  ON rs_to.signer_pubkey = t_in.to_pubkey
  AND rs_to.polis_repo_url = :polis_repo_url
WHERE t_in.level = 'trust'
  AND t_out.level = 'trust'
GROUP BY t_in.to_pubkey;

-- Alternative: Use AGE Cypher for the same computation.
-- This is more natural for graph traversal but requires the AGE extension.
--
-- All signers for a polis (threshold = 0):
-- SELECT * FROM cypher('koinon', $$
--   MATCH (s:Polites)-[:SIGNED]->(p:Polis {repo_url: '<polis_repo_url>'})
--   RETURN s.pubkey
-- $$) AS (pubkey agtype);
--
-- Signers with >= N mutual trust edges from other signers:
-- SELECT * FROM cypher('koinon', $$
--   MATCH (signer:Polites)-[:SIGNED]->(p:Polis {repo_url: '<polis_repo_url>'})
--   WITH signer, p
--   OPTIONAL MATCH (signer)-[:TRUSTS {level: 'trust'}]->(other:Polites)-[:TRUSTS {level: 'trust'}]->(signer)
--   WHERE (other)-[:SIGNED]->(p)
--   WITH signer, count(other) AS mutual_count
--   RETURN signer.pubkey, mutual_count
-- $$) AS (pubkey agtype, mutual_count agtype);

-- ============================================================================
-- RELATIONSHIPS
-- ============================================================================

-- getRelationships: Get all trust and observe relationships for a user,
-- in both directions. Returns four lists.

-- Outgoing trust (people I trust):
SELECT * FROM trust_declarations WHERE from_pubkey = :pubkey;

-- Incoming trust (people who trust me):
SELECT * FROM trust_declarations WHERE to_pubkey = :pubkey;

-- Outgoing observe (people I observe):
SELECT * FROM observe_declarations WHERE from_pubkey = :pubkey;

-- Incoming observe (people who observe me):
SELECT * FROM observe_declarations WHERE to_pubkey = :pubkey;

-- ============================================================================
-- FLAGS (MODERATION)
-- ============================================================================

-- getFlagsForPolis: All flags within a specific polis.
SELECT * FROM flag_records WHERE polis_repo_url = :polis_repo_url;

-- getFlaggedPostsForVouchers: Flags on posts by people the caller trusts.
-- Used for moderation review — "show me flags on content from my trusted circle."
SELECT f.*
FROM flag_records f
JOIN trust_declarations t
  ON t.from_pubkey = :caller_pubkey
  AND t.to_pubkey = f.post_author_pubkey
WHERE t.level = 'trust';

-- ============================================================================
-- FEEDS
-- ============================================================================

-- getPersonalFeed: Posts from people the caller trusts, observes, or is.
-- This is the union of trust + observe + self.
SELECT p.*
FROM post_references p
WHERE p.author_pubkey IN (
  -- People I trust
  SELECT to_pubkey FROM trust_declarations WHERE from_pubkey = :caller_pubkey
  UNION
  -- People I observe
  SELECT to_pubkey FROM observe_declarations WHERE from_pubkey = :caller_pubkey
  UNION
  -- Myself
  SELECT :caller_pubkey
)
ORDER BY p.timestamp DESC
LIMIT :limit OFFSET :offset;

-- getAgora: Community feed — posts from computed polis members, tagged for this polis.
-- Step 1: Compute member pubkeys (see getPolisMembers above or use AGE).
-- Step 2: Filter posts by those members + polis tag.
SELECT p.*
FROM post_references p
WHERE p.author_pubkey IN (:member_pubkeys)
  AND p.poleis_tags LIKE '%' || :polis_repo_url || '%'
ORDER BY p.timestamp DESC
LIMIT :limit OFFSET :offset;

-- getThread: Root post + direct replies.
SELECT * FROM post_references
WHERE post_url = :root_post_url
   OR parent_post_url = :root_post_url
ORDER BY timestamp ASC;

-- ============================================================================
-- INDEXING (WEBHOOK / CRAWLER)
-- ============================================================================

-- When a user's koinon.json manifest changes, the indexer should:
--
-- 1. Read .well-known/koinon.json from the user's git repo
-- 2. Upsert the user in politai_users
-- 3. Replace trust_declarations WHERE from_pubkey = user
-- 4. Replace observe_declarations WHERE from_pubkey = user
-- 5. Replace readme_signatures WHERE signer_pubkey = user
-- 6. Replace flag_records WHERE flagged_by_pubkey = user
-- 7. Update the AGE graph:
--    a. MERGE the Polites node
--    b. Delete + re-create TRUSTS edges from this user
--    c. Delete + re-create SIGNED edges from this user
--
-- "Replace" = DELETE WHERE from_pubkey = X, then INSERT new rows.
-- This ensures the relational data always mirrors the repo state.

-- AGE graph updates (per-user, after relational update):

-- Upsert polites node:
-- SELECT * FROM cypher('koinon', $$
--   MERGE (p:Polites {pubkey: '<pubkey>'})
-- $$) AS (v agtype);

-- Replace trust edges:
-- SELECT * FROM cypher('koinon', $$
--   MATCH (from:Polites {pubkey: '<from_pubkey>'})-[r:TRUSTS]->()
--   DELETE r
-- $$) AS (v agtype);
--
-- SELECT * FROM cypher('koinon', $$
--   MERGE (from:Polites {pubkey: '<from_pubkey>'})
--   MERGE (to:Polites {pubkey: '<to_pubkey>'})
--   MERGE (from)-[:TRUSTS {level: '<level>'}]->(to)
-- $$) AS (v agtype);

-- Replace signed edges:
-- SELECT * FROM cypher('koinon', $$
--   MATCH (s:Polites {pubkey: '<signer_pubkey>'})-[r:SIGNED]->()
--   DELETE r
-- $$) AS (v agtype);
--
-- SELECT * FROM cypher('koinon', $$
--   MERGE (s:Polites {pubkey: '<signer_pubkey>'})
--   MERGE (p:Polis {repo_url: '<polis_repo_url>'})
--   MERGE (s)-[:SIGNED]->(p)
-- $$) AS (v agtype);

-- When a post changes (posts/*/post.json), the indexer should:
-- 1. Read the post.json from the git repo
-- 2. Upsert into post_references by post_url
-- 3. Content is NOT stored — only the reference metadata
