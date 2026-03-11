# Serverpod Full Content Cache — Design Spec

## Overview

Replace the pointer-only `PostReference` model with a full-content `CachedPost` model. Update ingestion (webhook + RSS parsing) to store complete post.json content. Add two feed query paths: personal feed (trust-scoped) and polis feed (membership-scoped). Update `FeedGenerationService` to embed full post.json in RSS CDATA.

## Data Model: `CachedPost`

Replaces `PostReference`. Denormalized columns for query performance plus full JSON blob for client responses.

```yaml
class: CachedPost
table: cached_posts
fields:
  # Identity
  authorPubkey: String          # post author's public key
  authorRepoUrl: String         # author's repo URL
  path: String                  # e.g. posts/2026-03-08-hello/post.json
  commitHash: String            # git commit of this version
  link: String                  # full URL to post.json in forge

  # Denormalized content (for queries)
  title: String?                # post title if present
  text: String                  # post text body
  poleisTags: String?           # comma-separated polis repo URLs
  tags: String?                 # comma-separated hashtags
  isReply: bool                 # has parent reference

  # Denormalized parent (for thread assembly)
  parentAuthorPubkey: String?   # parent post author
  parentPath: String?           # parent post path

  # Full content (for client response)
  contentJson: String           # complete post.json as JSON string

  # Timestamps
  timestamp: DateTime           # when the post was created
  indexedAt: DateTime           # when aggregator indexed this
  signature: String             # author's signature for verification

indexes:
  cached_posts_author_path_idx:
    fields: authorPubkey, path
    unique: true
  cached_posts_timestamp_idx:
    fields: timestamp
  cached_posts_parent_idx:
    fields: parentAuthorPubkey, parentPath
  cached_posts_poleis_idx:
    fields: poleisTags
```

## Feed Queries

### Personal Feed

The requesting user's trust set is looked up from `trust_declarations` (already indexed from `.well-known/koinon.json`). No AGE graph traversal needed.

```sql
SELECT * FROM cached_posts
WHERE author_pubkey IN (
  SELECT to_pubkey FROM trust_declarations WHERE from_pubkey = $callerPubkey
)
ORDER BY timestamp DESC
LIMIT $limit OFFSET $offset
```

### Polis Feed

Polis members computed via AGE (existing `AgeGraph.computeMembers`). Then:

```sql
SELECT * FROM cached_posts
WHERE author_pubkey IN ($memberPubkeys)
  AND poleis_tags LIKE '%$polisRepoUrl%'
ORDER BY timestamp DESC
LIMIT $limit OFFSET $offset
```

### Thread Assembly

Given a post, find all replies:

```sql
SELECT * FROM cached_posts
WHERE parent_author_pubkey = $authorPubkey
  AND parent_path = $path
ORDER BY timestamp ASC
```

## RSS Feed Format (Flutter-side generation)

`FeedGenerationService` updated to produce:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:koinon="https://koinon.org/rss">
  <channel>
    <title>{owner}</title>
    <description>Koinon feed for {owner}</description>
    <lastBuildDate>{now}</lastBuildDate>
    <item>
      <title>{post title or truncated text}</title>
      <description>{post text}</description>
      <pubDate>{timestamp}</pubDate>
      <link>{forge URL to post.json}</link>
      <koinon:post><![CDATA[{full post.json}]]></koinon:post>
    </item>
  </channel>
</rss>
```

## Ingestion Paths

### Webhook (existing, updated)

`WebhookEndpoint.handlePush` already detects `post.json` changes. Updated to:

1. Read full `post.json` from forge (already does this for manifest)
2. Parse into `Post` model
3. Upsert `CachedPost` with denormalized fields + full JSON blob

Also: when `feed.xml` changes, parse it and extract `koinon:post` CDATA for any new/updated posts.

### RSS Parsing (new server-side capability)

New utility to parse RSS feed XML:
- Extract `<koinon:post>` CDATA from each `<item>`
- Parse JSON into `Post` model
- Upsert into `cached_posts`
- Deduplication via `(authorPubkey, path)` unique index

Used by webhook handler when feed.xml changes. Polling deferred to later.

## Endpoint Changes

### `KoinonEndpoint`

- `getPersonalFeed(session, {limit, offset})` — NEW. Auth required. Returns `List<CachedPost>` for caller's trust set.
- `getAgora(session, polisRepoUrl, {limit, offset})` — UPDATED. Returns `List<CachedPost>` instead of `List<PostReference>`.
- `getThread(session, authorPubkey, path)` — NEW. Returns root post + all replies as `List<CachedPost>`.

### `WebhookEndpoint`

- `_indexPost` — UPDATED. Reads full content, stores as `CachedPost`.
- `_indexFeed` — NEW. Parses `feed.xml`, extracts `koinon:post` items, upserts `CachedPost` rows.

## What Changes

| Component | Before | After |
|-----------|--------|-------|
| `post_reference.spy.yaml` | Pointer-only model | Replaced by `cached_post.spy.yaml` with full content |
| `WebhookEndpoint._indexPost` | Stores path/commit only | Reads + stores full post.json |
| `WebhookEndpoint` | No RSS awareness | Parses feed.xml on change |
| `KoinonEndpoint.getAgora` | Returns `PostReference` list | Returns `CachedPost` list (full content) |
| `KoinonEndpoint` | No personal feed | New `getPersonalFeed` endpoint |
| `KoinonEndpoint` | No thread assembly | New `getThread` endpoint |
| `FeedGenerationService` | Basic RSS (title/desc) | Full post.json in `koinon:post` CDATA |

## What Does NOT Change

- Stateless keypair auth (`KoinonAuthHandler`)
- AGE trust graph + membership computation
- Manifest indexing (`_indexManifest`)
- All Koinon protocol models (`Post`, `PostParent`, `PostRouting`, etc.)
- Flutter write path (commits to forge, regenerates feed.xml)
- `.well-known/koinon.json` format
- Trust declaration / readme signature / flag record tables

## Deferred

- RSS polling (periodic fallback for missed webhooks)
- Flutter read path changes (PostReadingService → Serverpod)
- Flutter UI updates
