# Serverpod RSS Aggregation Architecture

## Summary

Serverpod shifts from a pointer-only index to a full content cache. It polls user RSS feeds and reads `.well-known/koinon.json` manifests to aggregate all data. Flutter writes to the git forge, reads from Serverpod. The forge is the write layer; Serverpod is the read layer.

This supersedes the "lazy content loading" approach in the query layer design where Flutter fetched `post.json` directly from the forge.

## Why

- **Performance:** One Serverpod query vs N forge API calls per feed load
- **Simplicity:** Flutter client has one read source, one write target
- **Thread assembly:** Serverpod can build reply trees from `parent` references across users' repos
- **Trust-scoped feeds:** Serverpod resolves the user's trust graph (AGE) and filters posts server-side
- **Forge independence:** Read path doesn't depend on forge uptime or rate limits

## What Serverpod Stores

1. **Full post content** — the complete `post.json` for every post/reply, sourced from RSS feeds. Text only, tiny. A million posts is a few GB.
2. **Trust graphs** — one per user. A resolved set of pubkeys each user trusts. Sourced from `.well-known/koinon.json` manifests. Invalidated when trust declarations change.
3. **Polis membership** — existing AGE graph computation (unchanged).
4. **User metadata** — pubkey, repo URL, poleis. From manifests.

## What Serverpod Does NOT Store

- Images/media (those stay in git repos, referenced by URL)
- User credentials or passwords (no accounts)
- Sessions (stateless keypair auth, unchanged)

## Data Sources

Serverpod needs exactly two things from each user's repo:

1. **RSS feed** (`feed.xml`) — contains full post content for all posts and replies
2. **Manifest** (`.well-known/koinon.json`) — contains pubkey, trust declarations, polis memberships, flags

Everything Serverpod needs comes from these two files.

## RSS Feed Format

The RSS feed must carry the full `post.json` content so Serverpod can index without additional forge requests. Each `<item>` embeds the complete post as a JSON blob:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:koinon="https://koinon.org/rss">
  <channel>
    <title>alice</title>
    <description>Koinon feed for alice</description>
    <lastBuildDate>2026-03-10T12:00:00.000Z</lastBuildDate>
    <item>
      <title>My First Post</title>
      <description>The post text for display in standard RSS readers</description>
      <pubDate>2026-03-10T12:00:00.000Z</pubDate>
      <link>https://forge.example/alice/koinon/posts/my-first-post/post.json</link>
      <koinon:post><![CDATA[{"content":{"text":"...","title":"..."},"routing":{"poleis":["alice/polis-democracy"],"tags":["intro"],"mentions":[]},"timestamp":"2026-03-10T12:00:00.000Z","signature":"base64url..."}]]></koinon:post>
    </item>
    <item>
      <title>Re: Bob's post</title>
      <description>A reply to Bob</description>
      <pubDate>2026-03-10T13:00:00.000Z</pubDate>
      <link>https://forge.example/alice/koinon/posts/re-bobs-post/post.json</link>
      <koinon:post><![CDATA[{"content":{"text":"I agree!"},"parent":{"author":"def789...","repo":"bob/koinon","path":"posts/some-post/post.json","commit":"abc123"},"timestamp":"2026-03-10T13:00:00.000Z","signature":"base64url..."}]]></koinon:post>
    </item>
  </channel>
</rss>
```

Key points:
- Standard RSS fields (`title`, `description`, `pubDate`, `link`) for compatibility with any RSS reader
- Custom `koinon:post` element carries the full `post.json` as CDATA JSON
- `link` points to the source of truth in the git repo
- Signature included — Serverpod (or any consumer) can verify authenticity

## Ingestion Flow

```
Two triggers for Serverpod to update:

1. Webhook (fast path — immediate):
   Forgejo push webhook fires
     → Serverpod checks changed files
     → If koinon.json changed: fetch manifest, update trust graph + polis membership
     → If feed.xml changed: fetch RSS, upsert new/updated posts

2. Polling (fallback — periodic):
   Serverpod periodically polls known users' feed.xml
     → Detects new items by pubDate / link
     → Upserts posts
   (Covers cases where webhook is missed or forge doesn't support webhooks)
```

## Query Flow (Updated)

```
Flutter query (read):
  → sends pubkey + signed timestamp to Serverpod
  → Serverpod verifies signature (stateless keypair auth)
  → resolves user's trust graph (cached set of trusted pubkeys)
  → queries posts: WHERE author IN [trusted pubkeys] AND polis = X
  → returns full post content (not just references)
  → Flutter renders directly, no forge round-trip

Flutter write:
  → commits post.json to git repo via IGitClient
  → regenerates feed.xml with full content
  → commits feed.xml
  → Forgejo webhook notifies Serverpod (or Serverpod polls)
```

## Trust Graph Caching

- One cached trust graph per user (a resolved set of pubkeys)
- Invalidated when that user's `koinon.json` trust array changes (detected via webhook or poll)
- Feed query = `SELECT * FROM posts WHERE author_pubkey IN ($trusted_set) AND polis = $polis ORDER BY timestamp DESC`
- No per-user feed precomputation needed — the trust set IS the cache, the feed is a filtered query

## Growth

Text posts are tiny. At community scale (tens of thousands of users), storage is negligible. If growth becomes a concern:
- Evict posts older than N months from the content cache (keep index pointers)
- Shard by polis
- Spin up additional Serverpod instances

The git repos always have the full history. Serverpod is a disposable cache — nuke it, re-poll feeds, back in business.

## What This Changes

| Component | Old | New |
|-----------|-----|-----|
| Serverpod post storage | `PostReference` (pointers only) | Full `post.json` content |
| Flutter read path | Serverpod refs → forge content | Serverpod content directly |
| RSS feed content | Title + description text | Full `post.json` in `koinon:post` CDATA |
| `PostReadingService` | Reads from forge via `PublicGitClientFactory` | Reads from Serverpod response |
| Thread assembly | Client-side (would have been painful) | Server-side (Serverpod joins on `parent`) |
| Feed generation | `FeedGenerationService` builds basic RSS | Updated to embed full `post.json` |

## Unchanged

- Stateless keypair auth (pubkey + signed timestamp)
- AGE trust graph + membership computation
- Webhook indexing for manifest changes
- Flutter writes to forge via `IGitClient`
- `.well-known/koinon.json` manifest format
- All Koinon protocol models (`Post`, `PostParent`, `PostRouting`, etc.)
