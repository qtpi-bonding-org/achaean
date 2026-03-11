# Full Content Cache Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace pointer-only `PostReference` with full-content `CachedPost` model, add trust-scoped personal feed and polis feed endpoints, update RSS generation to embed full post.json, and update webhook ingestion to store full content.

**Architecture:** Serverpod becomes a full content cache. The `.spy.yaml` model defines denormalized query columns plus a `contentJson` blob. Two feed paths: personal (trust-set filter) and polis (AGE membership filter). RSS feed embeds complete post.json in `koinon:post` CDATA. Webhook ingestion reads full content from forge and also parses feed.xml changes.

**Tech Stack:** Serverpod 3.4.1, Dart 3.8, dart_koinon (Post/PostContent/PostRouting/PostParent models), dart_git (ForgejoClient), Apache AGE (trust graph).

**Spec:** `docs/specs/2026-03-10-serverpod-full-content-cache-design.md`

**Known limitations:**
- Polis tag filtering uses `LIKE '%url%'` which can false-match similar URLs (e.g. `democracy` matches `democracy-v2`). Inherited from existing code — acceptable for MVP.
- RSS parser uses regex on controlled format. Should upgrade to proper XML parsing if format evolves.
- No integration tests for webhook endpoint changes (unit test for RSS parser only).

---

## Chunk 1: Data Model + Code Generation

### Task 1: Create `CachedPost` model definition

**Files:**
- Create: `achaean_server/lib/src/koinon/cached_post.spy.yaml`
- Delete: `achaean_server/lib/src/koinon/post_reference.spy.yaml`

- [ ] **Step 1: Write the `cached_post.spy.yaml` model**

```yaml
### A cached post — full content from a polites's RSS feed.
class: CachedPost
table: cached_posts
fields:
  ### Public key of the post author.
  authorPubkey: String
  ### Repo URL of the author.
  authorRepoUrl: String
  ### Path to post.json in the repo (e.g. posts/2026-03-08-hello/post.json).
  path: String
  ### Git commit hash of this version of the post.
  commitHash: String
  ### Full URL to post.json in the forge (link element in RSS).
  link: String
  ### Post title (if present, for search/display).
  title: String?
  ### Post text body.
  text: String
  ### Polis repo URLs this post is tagged for (comma-separated).
  poleisTags: String?
  ### Hashtags / topic tags (comma-separated).
  tags: String?
  ### Whether this is a reply (has parent reference).
  isReply: bool
  ### Parent post author pubkey (for thread assembly).
  parentAuthorPubkey: String?
  ### Parent post path (for thread assembly).
  parentPath: String?
  ### Complete post.json as JSON string (returned to clients).
  contentJson: String
  ### When the post was created.
  timestamp: DateTime
  ### When the aggregator indexed this post.
  indexedAt: DateTime
  ### Author's signature for verification.
  signature: String
indexes:
  cached_posts_author_path_idx:
    fields: authorPubkey, path
    unique: true
  cached_posts_timestamp_idx:
    fields: timestamp
  cached_posts_parent_idx:
    fields: parentAuthorPubkey, parentPath
  cached_posts_author_timestamp_idx:
    fields: authorPubkey, timestamp
  cached_posts_poleis_idx:
    fields: poleisTags
```

- [ ] **Step 2: Delete the old `post_reference.spy.yaml`**

```bash
rm achaean_server/lib/src/koinon/post_reference.spy.yaml
```

- [ ] **Step 3: Run Serverpod code generation**

```bash
cd achaean_server && dart run serverpod generate
```

Expected: generates `achaean_server/lib/src/generated/koinon/cached_post.dart`, removes `post_reference.dart`, updates `protocol.dart` and `endpoints.dart`. Also regenerates `achaean_client/lib/src/protocol/koinon/cached_post.dart`.

- [ ] **Step 4: Verify the project compiles (expect compile errors in webhook/koinon endpoints)**

```bash
cd achaean_server && dart analyze 2>&1 | head -30
```

Expected: errors in `webhook_endpoint.dart` and `koinon_endpoint.dart` referencing `PostReference` (which no longer exists). This is expected — we fix those in Chunks 4-5.

- [ ] **Step 5: Create the database migration**

```bash
cd achaean_server && dart run serverpod create-migration
```

Expected: creates a new migration directory under `migrations/` that drops `post_references` table and creates `cached_posts` table with new columns and indexes.

- [ ] **Step 6: Commit**

```bash
git add achaean_server/lib/src/koinon/cached_post.spy.yaml achaean_server/lib/src/generated/ achaean_server/migrations/ achaean_client/lib/src/protocol/
git rm achaean_server/lib/src/koinon/post_reference.spy.yaml
git commit -m "feat: replace PostReference with CachedPost full-content model"
```

---

## Chunk 2: RSS Feed Generation (Flutter-side)

### Task 2: Update FeedGenerationService to embed full post.json

**Files:**
- Modify: `achaean_flutter/lib/features/post_creation/services/i_feed_generation_service.dart`
- Modify: `achaean_flutter/lib/features/post_creation/services/feed_generation_service.dart`
- Modify: `achaean_flutter/lib/features/post_creation/services/post_creation_service.dart`

The `generateFeed` method already reads all posts and builds RSS. We update `_buildRss` to:
1. Add `xmlns:koinon` namespace to `<rss>` element
2. Add `<link>` element per item pointing to forge URL
3. Add `<koinon:post><![CDATA[...]]></koinon:post>` per item with full post.json

The forge base URL is currently hardcoded in `achaean_flutter/lib/app/injection_module.dart` as `http://localhost:3000`. We pass it through to `generateFeed`.

- [ ] **Step 1: Update `IFeedGenerationService` to accept `forgeBaseUrl`**

In `achaean_flutter/lib/features/post_creation/services/i_feed_generation_service.dart`, add `forgeBaseUrl` parameter:

```dart
/// Generates RSS 2.0 feed XML from a user's posts.
abstract class IFeedGenerationService {
  /// Reads all posts from the repo and returns RSS 2.0 XML with full post.json
  /// embedded in koinon:post CDATA elements.
  Future<String> generateFeed({
    required String owner,
    required String repo,
    required String forgeBaseUrl,
  });
}
```

- [ ] **Step 2: Rewrite `FeedGenerationService` to embed full content**

Replace the entire `feed_generation_service.dart`. Key changes: store raw JSON alongside parsed Post, pass `forgeBaseUrl` through, add `<link>` and `<koinon:post>` CDATA elements.

```dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import '../../../core/services/i_git_service.dart';
import 'i_feed_generation_service.dart';

class FeedGenerationService implements IFeedGenerationService {
  final IGitService _gitService;

  FeedGenerationService(this._gitService);

  @override
  Future<String> generateFeed({
    required String owner,
    required String repo,
    required String forgeBaseUrl,
  }) async {
    final client = await _gitService.getClient();
    final entries = await client.listFiles(
      owner: owner,
      repo: repo,
      path: 'posts',
    );

    final posts = <_PostWithPath>[];
    for (final entry in entries) {
      if (entry.type != GitEntryType.dir || entry.name == '.gitkeep') continue;

      try {
        final file = await client.readFile(
          owner: owner,
          repo: repo,
          path: '${entry.path}/post.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        posts.add(_PostWithPath(
          post: Post.fromJson(json),
          path: '${entry.path}/post.json',
          rawJson: file.content,
        ));
      } catch (_) {
        continue;
      }
    }

    posts.sort((a, b) => b.post.timestamp.compareTo(a.post.timestamp));

    return _buildRss(owner, repo, forgeBaseUrl, posts);
  }

  String _buildRss(
      String owner, String repo, String forgeBaseUrl, List<_PostWithPath> posts) {
    final buffer = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="UTF-8"?>')
      ..writeln('<rss version="2.0" xmlns:koinon="https://koinon.org/rss">')
      ..writeln('  <channel>')
      ..writeln('    <title>$owner</title>')
      ..writeln('    <description>Koinon feed for $owner</description>')
      ..writeln(
          '    <lastBuildDate>${DateTime.now().toUtc().toIso8601String()}</lastBuildDate>');

    for (final entry in posts) {
      final post = entry.post;
      final link = '$forgeBaseUrl/$owner/$repo/raw/branch/main/${entry.path}';
      buffer
        ..writeln('    <item>')
        ..writeln(
            '      <title>${_escapeXml(post.content.title ?? _truncate(post.content.text, 80))}</title>')
        ..writeln(
            '      <description>${_escapeXml(post.content.text)}</description>')
        ..writeln(
            '      <pubDate>${post.timestamp.toUtc().toIso8601String()}</pubDate>')
        ..writeln('      <link>$link</link>')
        ..writeln(
            '      <koinon:post><![CDATA[${entry.rawJson}]]></koinon:post>')
        ..writeln('    </item>');
    }

    buffer
      ..writeln('  </channel>')
      ..writeln('</rss>');

    return buffer.toString();
  }

  String _escapeXml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }

  String _truncate(String text, int maxLen) {
    if (text.length <= maxLen) return text;
    return '${text.substring(0, maxLen)}...';
  }
}

class _PostWithPath {
  final Post post;
  final String path;
  final String rawJson;

  _PostWithPath({required this.post, required this.path, required this.rawJson});
}
```

- [ ] **Step 3: Update call site in `PostCreationService`**

In `achaean_flutter/lib/features/post_creation/services/post_creation_service.dart:106-109`, the `generateFeed` call needs `forgeBaseUrl`. The `PostCreationService` already has `IGitService` — get the base URL from the git client's registration.

The simplest approach: `PostCreationService` accepts a `forgeBaseUrl` constructor parameter (injected from `injection_module.dart` where it's already defined as `http://localhost:3000`).

Add `forgeBaseUrl` field to `PostCreationService`:

```dart
class PostCreationService implements IPostCreationService {
  final IGitService _gitService;
  final IPostSigningService _signingService;
  final IFeedGenerationService _feedService;
  final String _forgeBaseUrl;

  PostCreationService(
    this._gitService,
    this._signingService,
    this._feedService,
    this._forgeBaseUrl,
  );
```

Update the call at line 106-109:

```dart
final feedXml = await _feedService.generateFeed(
  owner: owner,
  repo: repo,
  forgeBaseUrl: _forgeBaseUrl,
);
```

Then update the DI registration in `achaean_flutter/lib/app/bootstrap.dart` to pass the forge base URL when constructing `PostCreationService`.

- [ ] **Step 4: Verify flutter project compiles**

```bash
cd achaean_flutter && dart analyze
```

Expected: no errors.

- [ ] **Step 5: Commit**

```bash
git add achaean_flutter/lib/features/post_creation/services/ achaean_flutter/lib/app/
git commit -m "feat: embed full post.json in RSS feed koinon:post CDATA"
```

---

## Chunk 3: RSS Feed Parser (Server-side)

### Task 3: Create RSS feed parser utility

**Files:**
- Create: `achaean_server/lib/src/koinon/rss_feed_parser.dart`
- Create: `achaean_server/test/unit/rss_feed_parser_test.dart`

This utility extracts `koinon:post` CDATA content from RSS XML. It returns parsed items with the raw JSON and link. The webhook endpoint will use this when `feed.xml` changes.

Uses regex/string extraction on the well-known RSS format — we control both producer and consumer. If the format evolves, upgrade to the `xml` package.

- [ ] **Step 1: Write the failing test for RSS parsing**

Create test file `achaean_server/test/unit/rss_feed_parser_test.dart`:

```dart
import 'package:test/test.dart';
import 'package:achaean_server/src/koinon/rss_feed_parser.dart';

void main() {
  group('RssFeedParser', () {
    test('parses items with koinon:post CDATA', () {
      final xml = '''<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:koinon="https://koinon.org/rss">
  <channel>
    <title>alice</title>
    <description>Koinon feed for alice</description>
    <lastBuildDate>2026-03-10T12:00:00.000Z</lastBuildDate>
    <item>
      <title>My First Post</title>
      <description>Hello world</description>
      <pubDate>2026-03-10T12:00:00.000Z</pubDate>
      <link>https://forge.example/alice/koinon/raw/branch/main/posts/my-first-post/post.json</link>
      <koinon:post><![CDATA[{"content":{"text":"Hello world","title":"My First Post"},"routing":{"poleis":["alice/polis-democracy"],"tags":["intro"],"mentions":[]},"timestamp":"2026-03-10T12:00:00.000Z","signature":"abc123"}]]></koinon:post>
    </item>
    <item>
      <title>Re: Bob</title>
      <description>I agree!</description>
      <pubDate>2026-03-10T13:00:00.000Z</pubDate>
      <link>https://forge.example/alice/koinon/raw/branch/main/posts/re-bob/post.json</link>
      <koinon:post><![CDATA[{"content":{"text":"I agree!"},"parent":{"author":"def789","repo":"bob/koinon","path":"posts/some-post/post.json","commit":"abc123"},"timestamp":"2026-03-10T13:00:00.000Z","signature":"def456"}]]></koinon:post>
    </item>
  </channel>
</rss>''';

      final items = RssFeedParser.parse(xml);

      expect(items, hasLength(2));

      expect(items[0].link,
          'https://forge.example/alice/koinon/raw/branch/main/posts/my-first-post/post.json');
      expect(items[0].postJson, contains('"Hello world"'));
      expect(items[0].postJson, contains('"My First Post"'));

      expect(items[1].link,
          'https://forge.example/alice/koinon/raw/branch/main/posts/re-bob/post.json');
      expect(items[1].postJson, contains('"I agree!"'));
      expect(items[1].postJson, contains('"parent"'));
    });

    test('returns empty list for RSS without koinon:post elements', () {
      final xml = '''<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>alice</title>
    <item>
      <title>Plain post</title>
      <description>No koinon data</description>
    </item>
  </channel>
</rss>''';

      final items = RssFeedParser.parse(xml);
      expect(items, isEmpty);
    });

    test('handles empty feed', () {
      final xml = '''<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:koinon="https://koinon.org/rss">
  <channel>
    <title>alice</title>
  </channel>
</rss>''';

      final items = RssFeedParser.parse(xml);
      expect(items, isEmpty);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

```bash
cd achaean_server && dart test test/unit/rss_feed_parser_test.dart
```

Expected: FAIL — `rss_feed_parser.dart` doesn't exist yet.

- [ ] **Step 3: Implement `RssFeedParser`**

Create `achaean_server/lib/src/koinon/rss_feed_parser.dart`:

```dart
/// Parsed RSS item containing koinon:post data.
class RssFeedItem {
  /// Full URL to post.json in the forge.
  final String link;

  /// Raw JSON string from koinon:post CDATA.
  final String postJson;

  const RssFeedItem({required this.link, required this.postJson});
}

/// Parses Koinon RSS feeds and extracts koinon:post CDATA content.
///
/// Uses string parsing on the well-known RSS format. We control both
/// producer (FeedGenerationService) and consumer (this parser).
/// If the RSS format evolves beyond this structure, upgrade to the xml package.
class RssFeedParser {
  static final _itemPattern =
      RegExp(r'<item>(.*?)</item>', dotAll: true);
  static final _linkPattern =
      RegExp(r'<link>(.*?)</link>');
  static final _cdataPattern =
      RegExp(r'<koinon:post><!\[CDATA\[(.*?)\]\]></koinon:post>', dotAll: true);

  /// Parse RSS XML and return items that contain koinon:post CDATA.
  ///
  /// Items without a koinon:post element are skipped.
  static List<RssFeedItem> parse(String xml) {
    final items = <RssFeedItem>[];

    for (final itemMatch in _itemPattern.allMatches(xml)) {
      final itemXml = itemMatch.group(1)!;

      final cdataMatch = _cdataPattern.firstMatch(itemXml);
      if (cdataMatch == null) continue;

      final linkMatch = _linkPattern.firstMatch(itemXml);
      if (linkMatch == null) continue;

      items.add(RssFeedItem(
        link: linkMatch.group(1)!.trim(),
        postJson: cdataMatch.group(1)!,
      ));
    }

    return items;
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

```bash
cd achaean_server && dart test test/unit/rss_feed_parser_test.dart
```

Expected: all 3 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add achaean_server/lib/src/koinon/rss_feed_parser.dart achaean_server/test/unit/rss_feed_parser_test.dart
git commit -m "feat: add RssFeedParser for extracting koinon:post CDATA from RSS"
```

---

## Chunk 4: Webhook Ingestion Update

### Task 4: Update WebhookEndpoint to store full content as CachedPost

**Files:**
- Modify: `achaean_server/lib/src/koinon/webhook_endpoint.dart`

The webhook endpoint needs three updates:
1. `_indexManifest` flag lookup: `PostReference` → `CachedPost`
2. `_indexPost` → reads full post.json from forge, stores as `CachedPost`
3. New `_indexFeed` → when `feed.xml` changes, fetch + parse with `RssFeedParser`

Both `_indexPost` and `_indexFeed` share the same upsert logic — extract to `_upsertCachedPost` helper.

- [ ] **Step 1: Update imports and fix `_indexManifest` flag lookup**

At the top of `webhook_endpoint.dart`, add import:
```dart
import 'rss_feed_parser.dart';
```

In `_indexManifest`, replace the `PostReference` lookup (line 171-175):
```dart
final postRef = await PostReference.db.findFirstRow(
  session,
  where: (t) => t.path.equals(flag.post),
  transaction: transaction,
);
```
with:
```dart
final postRef = await CachedPost.db.findFirstRow(
  session,
  where: (t) => t.path.equals(flag.post),
  transaction: transaction,
);
```

- [ ] **Step 2: Update `handlePush` to detect feed.xml changes**

Add `feedChanged` detection and handling:

```dart
bool feedChanged = false;

for (final change in event.changes) {
  if (change.action == WebhookFileAction.removed) continue;

  if (change.path == '.well-known/koinon.json') {
    manifestChanged = true;
  } else if (change.path == 'feed.xml') {
    feedChanged = true;
  } else if (change.path.startsWith('posts/') &&
      change.path.endsWith('post.json')) {
    postChanges.add(change.path);
  }
}
```

At the end of `handlePush`, after existing post indexing:
```dart
if (feedChanged) {
  await _indexFeed(session, event, now);
}
```

- [ ] **Step 3: Add `_upsertCachedPost` helper**

Extract the shared upsert logic used by both `_indexPost` and `_indexFeed`:

```dart
/// Upsert a CachedPost from a parsed Post and raw JSON.
///
/// Deduplicates by (authorRepoUrl, path) to handle the race condition
/// where authorPubkey may not yet be resolved from the manifest.
Future<void> _upsertCachedPost(
  Session session, {
  required String authorPubkey,
  required String authorRepoUrl,
  required String path,
  required String commitHash,
  required String link,
  required Post post,
  required String rawJson,
  required DateTime now,
}) async {
  final existing = await CachedPost.db.findFirstRow(
    session,
    where: (t) =>
        t.authorRepoUrl.equals(authorRepoUrl) & t.path.equals(path),
  );

  if (existing != null) {
    existing
      ..authorPubkey = authorPubkey.isNotEmpty ? authorPubkey : existing.authorPubkey
      ..commitHash = commitHash
      ..link = link
      ..title = post.content.title
      ..text = post.content.text
      ..poleisTags = post.routing?.poleis.join(',')
      ..tags = post.routing?.tags.join(',')
      ..isReply = post.parent != null
      ..parentAuthorPubkey = post.parent?.author
      ..parentPath = post.parent?.path
      ..contentJson = rawJson
      ..timestamp = post.timestamp
      ..indexedAt = now
      ..signature = post.signature;
    await CachedPost.db.updateRow(session, existing);
  } else {
    await CachedPost.db.insertRow(
      session,
      CachedPost(
        authorPubkey: authorPubkey,
        authorRepoUrl: authorRepoUrl,
        path: path,
        commitHash: commitHash,
        link: link,
        title: post.content.title,
        text: post.content.text,
        poleisTags: post.routing?.poleis.join(','),
        tags: post.routing?.tags.join(','),
        isReply: post.parent != null,
        parentAuthorPubkey: post.parent?.author,
        parentPath: post.parent?.path,
        contentJson: rawJson,
        timestamp: post.timestamp,
        indexedAt: now,
        signature: post.signature,
      ),
    );
  }
}
```

**Note:** The lookup uses `authorRepoUrl` + `path` (not `authorPubkey` + `path`) because the webhook may fire before the manifest has been indexed, leaving `authorPubkey` empty. `authorRepoUrl` is always available from the webhook payload. If pubkey was previously empty and is now resolved, it gets updated.

- [ ] **Step 4: Rewrite `_indexPost` to store full content**

Replace the existing `_indexPost` method to read full post.json and delegate to `_upsertCachedPost`:

```dart
Future<void> _indexPost(
  Session session,
  NormalizedPushEvent event,
  String path,
  DateTime now,
) async {
  final client = ForgejoClient(
    baseUrl: _extractBaseUrl(event.repoUrl),
    auth: const GitPublicAuth(),
  );

  Post post;
  String rawJson;
  try {
    final file = await client.readFile(
      owner: event.repoOwner,
      repo: event.repoName,
      path: path,
    );
    rawJson = file.content;
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    post = Post.fromJson(json);
  } catch (e) {
    session.log('Failed to read $path from ${event.repoUrl}: $e',
        level: LogLevel.warning);
    return;
  }

  final user = await PolitaiUser.db.findFirstRow(
    session,
    where: (t) => t.repoUrl.equals(event.repoUrl),
  );

  await _upsertCachedPost(
    session,
    authorPubkey: user?.pubkey ?? '',
    authorRepoUrl: event.repoUrl,
    path: path,
    commitHash: event.afterCommit,
    link: '${event.repoUrl}/raw/branch/main/$path',
    post: post,
    rawJson: rawJson,
    now: now,
  );
}
```

- [ ] **Step 5: Add `_indexFeed` method**

New method that fetches `feed.xml`, parses with `RssFeedParser`, and upserts each item:

```dart
/// Fetch feed.xml from repo, parse RSS, upsert all posts.
Future<void> _indexFeed(
  Session session,
  NormalizedPushEvent event,
  DateTime now,
) async {
  final client = ForgejoClient(
    baseUrl: _extractBaseUrl(event.repoUrl),
    auth: const GitPublicAuth(),
  );

  String feedXml;
  try {
    final file = await client.readFile(
      owner: event.repoOwner,
      repo: event.repoName,
      path: 'feed.xml',
    );
    feedXml = file.content;
  } catch (e) {
    session.log('Failed to read feed.xml from ${event.repoUrl}: $e',
        level: LogLevel.warning);
    return;
  }

  final user = await PolitaiUser.db.findFirstRow(
    session,
    where: (t) => t.repoUrl.equals(event.repoUrl),
  );
  final authorPubkey = user?.pubkey ?? '';

  final items = RssFeedParser.parse(feedXml);

  for (final item in items) {
    Post post;
    try {
      final json = jsonDecode(item.postJson) as Map<String, dynamic>;
      post = Post.fromJson(json);
    } catch (e) {
      session.log('Failed to parse post from feed item: $e',
          level: LogLevel.warning);
      continue;
    }

    // Extract path from link URL (after /raw/branch/main/)
    final pathMatch = RegExp(r'/raw/branch/main/(.+)$').firstMatch(item.link);
    final path = pathMatch?.group(1) ?? '';
    if (path.isEmpty) continue;

    await _upsertCachedPost(
      session,
      authorPubkey: authorPubkey,
      authorRepoUrl: event.repoUrl,
      path: path,
      commitHash: event.afterCommit,
      link: item.link,
      post: post,
      rawJson: item.postJson,
      now: now,
    );
  }

  session.log(
    'Indexed feed for ${event.repoUrl}: ${items.length} items',
    level: LogLevel.info,
  );
}
```

- [ ] **Step 6: Verify the webhook endpoint compiles (koinon_endpoint.dart will still have errors)**

```bash
cd achaean_server && dart analyze 2>&1 | grep -v koinon_endpoint
```

Expected: no errors in `webhook_endpoint.dart`. Errors in `koinon_endpoint.dart` are expected — fixed in Chunk 5.

- [ ] **Step 7: Commit**

```bash
git add achaean_server/lib/src/koinon/webhook_endpoint.dart
git commit -m "feat: webhook stores full post content as CachedPost"
```

---

## Chunk 5: Endpoint Updates

### Task 5: Update KoinonEndpoint — personal feed, polis feed, thread assembly

**Files:**
- Modify: `achaean_server/lib/src/koinon/koinon_endpoint.dart`

Three changes:
1. `getAgora` returns `List<CachedPost>` instead of `List<PostReference>`
2. New `getPersonalFeed` — trust-scoped, all poleis
3. New `getThread` — root post + replies

- [ ] **Step 1: Update `getAgora` to return `CachedPost`**

Replace the existing `getAgora` method:

```dart
/// Get posts for a polis (the agora).
///
/// Computes polis members via AGE, then returns full post content
/// from those members tagged for this polis.
Future<List<CachedPost>> getAgora(
  Session session,
  String polisRepoUrl, {
  int limit = 50,
  int offset = 0,
}) async {
  await KoinonAuthHandler.verifyFromSession(session);

  final polis = await PolisDefinition.db.findFirstRow(
    session,
    where: (t) => t.repoUrl.equals(polisRepoUrl),
  );
  final threshold = polis?.membershipThreshold ?? 1;

  final memberPubkeys = await AgeGraph.computeMembers(
    session,
    polisRepoUrl,
    threshold,
  );

  if (memberPubkeys.isEmpty) return [];

  return await CachedPost.db.find(
    session,
    where: (t) =>
        t.authorPubkey.inSet(memberPubkeys.toSet()) &
        t.poleisTags.like('%$polisRepoUrl%'),
    orderBy: (t) => t.timestamp,
    orderDescending: true,
    limit: limit,
    offset: offset,
  );
}
```

- [ ] **Step 2: Add `getPersonalFeed` endpoint**

New method — looks up caller's trust set from `trust_declarations`, includes caller's own posts, queries all posts by trusted authors + self:

```dart
/// Get personalized feed — posts from everyone the caller trusts,
/// plus the caller's own posts.
///
/// Spans all poleis. The caller's trust graph (from their koinon.json
/// trust declarations) determines which authors appear.
Future<List<CachedPost>> getPersonalFeed(
  Session session, {
  int limit = 50,
  int offset = 0,
}) async {
  final callerPubkey = await KoinonAuthHandler.verifyFromSession(session);

  // Look up who the caller trusts
  final trustDeclarations = await TrustDeclarationRecord.db.find(
    session,
    where: (t) => t.fromPubkey.equals(callerPubkey),
  );

  final feedPubkeys = trustDeclarations.map((t) => t.toPubkey).toSet();
  feedPubkeys.add(callerPubkey); // Include caller's own posts

  return await CachedPost.db.find(
    session,
    where: (t) => t.authorPubkey.inSet(feedPubkeys),
    orderBy: (t) => t.timestamp,
    orderDescending: true,
    limit: limit,
    offset: offset,
  );
}
```

- [ ] **Step 3: Add `getThread` endpoint**

New method — returns a root post and all its replies:

```dart
/// Get a thread — root post and all replies.
///
/// Returns the post at the given path, plus all posts whose parent
/// references point to it.
Future<List<CachedPost>> getThread(
  Session session,
  String authorPubkey,
  String path,
) async {
  await KoinonAuthHandler.verifyFromSession(session);

  final results = <CachedPost>[];

  // Get root post
  final root = await CachedPost.db.findFirstRow(
    session,
    where: (t) =>
        t.authorPubkey.equals(authorPubkey) & t.path.equals(path),
  );
  if (root != null) results.add(root);

  // Get replies
  final replies = await CachedPost.db.find(
    session,
    where: (t) =>
        t.parentAuthorPubkey.equals(authorPubkey) &
        t.parentPath.equals(path),
    orderBy: (t) => t.timestamp,
  );
  results.addAll(replies);

  return results;
}
```

- [ ] **Step 4: Verify the full project compiles**

```bash
cd achaean_server && dart analyze
```

Expected: no errors.

- [ ] **Step 5: Run `serverpod generate` to update endpoint connectors**

```bash
cd achaean_server && dart run serverpod generate
```

Expected: `endpoints.dart` updated with new `getPersonalFeed` and `getThread` method connectors, `getAgora` return type updated.

- [ ] **Step 6: Commit**

```bash
git add achaean_server/lib/src/koinon/koinon_endpoint.dart achaean_server/lib/src/generated/ achaean_client/lib/src/protocol/
git commit -m "feat: add personal feed, polis feed, and thread assembly endpoints"
```

---

## Chunk 6: Final Verification

### Task 6: Full build verification and cleanup

**Files:**
- All modified files from previous tasks

- [ ] **Step 1: Run full server analysis**

```bash
cd achaean_server && dart analyze
```

Expected: no errors, no warnings.

- [ ] **Step 2: Run all server tests**

```bash
cd achaean_server && dart test
```

Expected: all tests pass (existing greeting tests + new RSS parser tests).

- [ ] **Step 3: Run flutter analysis**

```bash
cd achaean_flutter && dart analyze
```

Expected: no errors. There may be warnings about unused `PostReadingService` imports — these are expected and will be cleaned up when the Flutter read path is updated (deferred).

- [ ] **Step 4: Verify migration is correct**

```bash
cat achaean_server/migrations/*/migration.sql | tail -30
```

Verify the latest migration drops `post_references` and creates `cached_posts` with all expected columns and indexes.

- [ ] **Step 5: Final commit if any cleanup needed**

```bash
git status
# If there are uncommitted changes:
git add -A && git commit -m "chore: cleanup after full content cache implementation"
```
