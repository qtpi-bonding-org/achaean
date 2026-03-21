# Metadata-Only Post Indexer Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update PostReference to carry `postUrl` and `parentPostUrl` fields, and update `_indexPost` to read `post.json` from the forge to populate all metadata fields — without storing post content.

**Architecture:** PostReference becomes a fully-populated metadata pointer. The webhook reads `post.json` from the forge to extract title, polis tags, reply info, and timestamps, but never stores the text body or signature. Serverpod assembles feeds and threads from metadata; the client fetches actual content from forge URLs.

**Tech Stack:** Serverpod (Dart), PostgreSQL, dart_git (ForgejoClient), dart_koinon (Post model)

---

### Task 1: Update PostReference model

**Files:**
- Modify: `achaean_server/lib/src/koinon/post_reference.spy.yaml`

- [ ] **Step 1: Update the model YAML**

Replace the full file with:

```yaml
### An indexed post reference — a metadata pointer to a post in a polites's repo.
class: PostReference
table: post_references
fields:
  ### Public key of the post author.
  authorPubkey: String
  ### Repo URL of the author (e.g. https://forge.example/alice/koinon).
  authorRepoUrl: String
  ### Full URL to the post.json file on the forge.
  postUrl: String
  ### Git commit hash of this version of the post.
  commitHash: String
  ### Post title (if present, for search/display).
  title: String?
  ### Polis repo URLs this post is tagged for (comma-separated).
  poleisTags: String?
  ### When the post was created.
  timestamp: DateTime
  ### Whether this is a reply (has parent reference).
  isReply: bool
  ### Full URL to the parent post.json (if this is a reply).
  parentPostUrl: String?
  ### When the aggregator indexed this post.
  indexedAt: DateTime
indexes:
  post_references_post_url_idx:
    fields: postUrl
    unique: true
  post_references_timestamp_idx:
    fields: timestamp
  post_references_parent_idx:
    fields: parentPostUrl
```

- [ ] **Step 2: Run Serverpod code generation**

Run: `cd achaean_server && dart run serverpod generate`

Expected: Generated protocol files updated for PostReference with new fields.

- [ ] **Step 3: Create database migration**

Run: `cd achaean_server && dart run serverpod create-migration`

Expected: New migration directory created under `achaean_server/migrations/` that drops old `path` column, adds `postUrl` and `parentPostUrl` columns, and updates indexes.

- [ ] **Step 4: Commit**

```bash
git add achaean_server/lib/src/koinon/post_reference.spy.yaml \
       achaean_server/lib/src/generated/ \
       achaean_client/lib/src/protocol/ \
       achaean_server/migrations/
git commit -m "feat: add postUrl and parentPostUrl to PostReference, drop path"
```

---

### Task 2: Update FlagRecord to use postUrl instead of postPath

**Files:**
- Modify: `achaean_server/lib/src/koinon/flag_record.spy.yaml`

The `FlagRecord` model currently uses `postPath` to identify flagged posts. Since `PostReference` no longer has a `path` field, `FlagRecord` must also switch to full URLs for consistency and joinability.

- [ ] **Step 1: Update FlagRecord model YAML**

Replace `postPath` with `postUrl` in `flag_record.spy.yaml`:

```yaml
### An indexed post flag — a moderation signal from a polis member.
class: FlagRecord
table: flag_records
fields:
  ### Public key of the flagger.
  flaggedByPubkey: String
  ### Public key of the post author.
  postAuthorPubkey: String
  ### Full URL to the flagged post.json.
  postUrl: String
  ### Polis repo URL where this flag applies.
  polisRepoUrl: String
  ### Free-form reason for flagging.
  reason: String
  ### When the flag was made.
  timestamp: DateTime
  ### When the aggregator indexed this flag.
  indexedAt: DateTime
indexes:
  flag_records_flagger_post_polis_idx:
    fields: flaggedByPubkey, postUrl, polisRepoUrl
    unique: true
  flag_records_post_polis_idx:
    fields: postUrl, polisRepoUrl
  flag_records_author_idx:
    fields: postAuthorPubkey
```

- [ ] **Step 2: Run Serverpod code generation**

Run: `cd achaean_server && dart run serverpod generate`

- [ ] **Step 3: Create database migration**

Run: `cd achaean_server && dart run serverpod create-migration`

- [ ] **Step 4: Commit**

```bash
git add achaean_server/lib/src/koinon/flag_record.spy.yaml \
       achaean_server/lib/src/generated/ \
       achaean_client/lib/src/protocol/ \
       achaean_server/migrations/
git commit -m "feat: FlagRecord uses postUrl instead of postPath"
```

---

### Task 3: Update `_indexPost` and `_indexManifest` in webhook

**Files:**
- Modify: `achaean_server/lib/src/koinon/webhook_endpoint.dart`

- [ ] **Step 1: Write the updated `_indexPost` method**

Replace the existing `_indexPost` method (lines 216-253). The new version:
1. Reads `post.json` from the forge via `ForgejoClient.readFile`
2. Parses it as a `Post` object
3. Extracts metadata only: `title`, `poleisTags`, `isReply`, `parentPostUrl`, `timestamp`
4. Constructs `postUrl` from `event.repoUrl + '/' + path`
5. For replies, looks up the parent author's `PolitaiUser` by pubkey to construct `parentPostUrl`
6. Upserts the PostReference with all metadata populated

```dart
Future<void> _indexPost(
  Session session,
  NormalizedPushEvent event,
  String path,
  DateTime now,
) async {
  final baseUrl = _extractBaseUrl(event.repoUrl);
  final client = ForgejoClient(
    baseUrl: baseUrl,
    auth: const GitPublicAuth(),
  );

  // Read post.json to extract metadata (content is not stored)
  Post post;
  try {
    final file = await client.readFile(
      owner: event.repoOwner,
      repo: event.repoName,
      path: path,
    );
    final json = jsonDecode(file.content) as Map<String, dynamic>;
    post = Post.fromJson(json);
  } catch (e) {
    session.log('Failed to read $path from ${event.repoUrl}: $e',
        level: LogLevel.warning);
    return;
  }

  // Look up author pubkey from known users
  final user = await PolitaiUser.db.findFirstRow(
    session,
    where: (t) => t.repoUrl.equals(event.repoUrl),
  );

  final postUrl = '${event.repoUrl}/$path';
  final isReply = post.parent != null;

  // For replies, look up parent author's repo URL by their pubkey
  String? parentPostUrl;
  if (post.parent != null) {
    final parentUser = await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.pubkey.equals(post.parent!.author),
    );
    if (parentUser != null) {
      parentPostUrl = '${parentUser.repoUrl}/${post.parent!.path}';
    }
  }

  final poleisTags = post.routing?.poleis.join(',');

  // Upsert by postUrl
  final existing = await PostReference.db.findFirstRow(
    session,
    where: (t) => t.postUrl.equals(postUrl),
  );

  if (existing != null) {
    existing
      ..commitHash = event.afterCommit
      ..title = post.content.title
      ..poleisTags = poleisTags
      ..isReply = isReply
      ..parentPostUrl = parentPostUrl
      ..timestamp = post.timestamp
      ..indexedAt = now;
    await PostReference.db.updateRow(session, existing);
  } else {
    await PostReference.db.insertRow(
      session,
      PostReference(
        authorPubkey: user?.pubkey ?? '',
        authorRepoUrl: event.repoUrl,
        postUrl: postUrl,
        commitHash: event.afterCommit,
        title: post.content.title,
        poleisTags: poleisTags,
        timestamp: post.timestamp,
        isReply: isReply,
        parentPostUrl: parentPostUrl,
        indexedAt: now,
      ),
    );
  }
}
```

- [ ] **Step 2: Update flag indexing in `_indexManifest`**

In `_indexManifest`, the flag lookup currently queries `PostReference` by `path`. Update to look up the post by constructing the full URL. Also update `FlagRecord` construction to use `postUrl` instead of `postPath`.

Find this block (around line 169-189):
```dart
for (final flag in manifest.flags) {
  // Look up post author from post_references
  final postRef = await PostReference.db.findFirstRow(
    session,
    where: (t) => t.path.equals(flag.post),
    transaction: transaction,
  );

  await FlagRecord.db.insertRow(
    session,
    FlagRecord(
      flaggedByPubkey: pubkey,
      postAuthorPubkey: postRef?.authorPubkey ?? '',
      postPath: flag.post,
      polisRepoUrl: flag.polis,
      reason: flag.reason,
      timestamp: now,
      indexedAt: now,
    ),
    transaction: transaction,
  );
}
```

Replace with:
```dart
for (final flag in manifest.flags) {
  // flag.post is a path like "posts/2026-03-08-hello/post.json"
  // Construct full URL using the flagger's repo URL
  // (flags reference posts in other repos, but we need the post author's URL)
  final postRef = await PostReference.db.findFirstRow(
    session,
    where: (t) => t.postUrl.endsWith(flag.post),
    transaction: transaction,
  );

  await FlagRecord.db.insertRow(
    session,
    FlagRecord(
      flaggedByPubkey: pubkey,
      postAuthorPubkey: postRef?.authorPubkey ?? '',
      postUrl: postRef?.postUrl ?? flag.post,
      polisRepoUrl: flag.polis,
      reason: flag.reason,
      timestamp: now,
      indexedAt: now,
    ),
    transaction: transaction,
  );
}
```

- [ ] **Step 3: Verify it compiles**

Run: `cd achaean_server && dart analyze`

Expected: No errors.

- [ ] **Step 4: Commit**

```bash
git add achaean_server/lib/src/koinon/webhook_endpoint.dart
git commit -m "feat: _indexPost reads post.json metadata from forge, populates all fields"
```

---

### Task 4: Update endpoints (getAgora, getPersonalFeed, getThread)

**Files:**
- Modify: `achaean_server/lib/src/koinon/koinon_endpoint.dart`

- [ ] **Step 1: Verify getAgora compiles**

The existing `getAgora` method filters by `poleisTags.like('%$polisRepoUrl%')`. This still works — `poleisTags` is now populated from `post.routing.poleis.join(',')`. Verify no references to the removed `path` field remain.

- [ ] **Step 2: Update getFlaggedPostsForVouchers**

The existing `getFlaggedPostsForVouchers` method (line 128-148) returns `List<FlagRecord>`. This still works since `FlagRecord` is queried by `postAuthorPubkey`. No changes needed.

- [ ] **Step 3: Add `getPersonalFeed` endpoint**

Add to `KoinonEndpoint`:

```dart
/// Get post references from trusted authors (personal feed).
Future<List<PostReference>> getPersonalFeed(
  Session session, {
  int limit = 50,
  int offset = 0,
}) async {
  final callerPubkey = await KoinonAuthHandler.verifyFromSession(session);

  final trustDeclarations = await TrustDeclarationRecord.db.find(
    session,
    where: (t) => t.fromPubkey.equals(callerPubkey),
  );

  final trustedPubkeys = trustDeclarations.map((t) => t.toPubkey).toSet();
  trustedPubkeys.add(callerPubkey); // Include own posts

  return await PostReference.db.find(
    session,
    where: (t) => t.authorPubkey.inSet(trustedPubkeys),
    orderBy: (t) => t.timestamp,
    orderDescending: true,
    limit: limit,
    offset: offset,
  );
}
```

- [ ] **Step 4: Add `getThread` endpoint**

Add to `KoinonEndpoint`:

```dart
/// Get all posts in a thread (root + direct replies).
///
/// Returns the root post and all posts whose parentPostUrl matches
/// the root. Single-level only — nested replies require the client
/// to call getThread again with a reply's postUrl.
Future<List<PostReference>> getThread(
  Session session,
  String rootPostUrl,
) async {
  await KoinonAuthHandler.verifyFromSession(session);

  final root = await PostReference.db.findFirstRow(
    session,
    where: (t) => t.postUrl.equals(rootPostUrl),
  );

  if (root == null) return [];

  final replies = await PostReference.db.find(
    session,
    where: (t) => t.parentPostUrl.equals(rootPostUrl),
    orderBy: (t) => t.timestamp,
  );

  return [root, ...replies];
}
```

- [ ] **Step 5: Run Serverpod generate for new endpoints**

Run: `cd achaean_server && dart run serverpod generate`

Expected: Generated endpoint bindings updated.

- [ ] **Step 6: Verify it compiles**

Run: `cd achaean_server && dart analyze`

Expected: No errors.

- [ ] **Step 7: Commit**

```bash
git add achaean_server/lib/src/koinon/koinon_endpoint.dart \
       achaean_server/lib/src/generated/ \
       achaean_client/lib/src/protocol/
git commit -m "feat: add getPersonalFeed and getThread endpoints"
```

---

### Task 5: Update Flutter client to use postUrl

**Files:**
- Modify: `achaean_flutter/lib/features/agora/services/post_reading_service.dart`
- Modify: `achaean_flutter/lib/features/agora/cubit/agora_cubit.dart`

- [ ] **Step 1: Update PostReadingService to derive path from postUrl**

The existing `PostReadingService.getPost()` uses `ref.path` to fetch from the forge. Update it to derive the path from `ref.postUrl` instead. Keep all existing functionality (rich content HTML/CSS detection) intact.

In `post_reading_service.dart`, change the `getPost` method. Replace `ref.path` references with a path derived from `ref.postUrl`:

```dart
@override
Future<ReadablePostContent> getPost(PostReference ref) {
  return tryMethod(
    () async {
      final repoId = _parseRepoUrl(ref.authorRepoUrl);
      final client = _publicClientFactory(
        baseUrl: repoId.baseUrl,
        hostType: _defaultHostType,
      );

      // Derive file path from postUrl by stripping the repo URL prefix
      final path = ref.postUrl.substring(ref.authorRepoUrl.length + 1);

      // 1. Read post.json (always present)
      final file = await client.readFile(
        owner: repoId.owner,
        repo: repoId.repo,
        path: path,
      );
      final json = jsonDecode(file.content) as Map<String, dynamic>;
      final post = Post.fromJson(json);

      // 2. Derive directory path from post.json path
      final lastSlash = path.lastIndexOf('/');
      final dirPath = lastSlash > 0 ? path.substring(0, lastSlash) : '';

      // 3. Check for index.html
      final htmlPath = '$dirPath/index.html';
      final hasHtml = await client.exists(
        owner: repoId.owner,
        repo: repoId.repo,
        path: htmlPath,
      );

      if (!hasHtml) {
        return JsonReadablePost(post);
      }

      // 4. Read index.html
      final htmlFile = await client.readFile(
        owner: repoId.owner,
        repo: repoId.repo,
        path: htmlPath,
      );

      // 5. Optionally read style.css
      final cssPath = '$dirPath/style.css';
      String? css;
      final hasCss = await client.exists(
        owner: repoId.owner,
        repo: repoId.repo,
        path: cssPath,
      );
      if (hasCss) {
        final cssFile = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: cssPath,
        );
        css = cssFile.content;
      }

      return RichReadablePost(post, htmlFile.content, css);
    },
    QueryException.new,
    'getPost',
  );
}
```

- [ ] **Step 2: Update AgoraCubit flag counting to use postUrl**

In `agora_cubit.dart`, update `_computeFlagCounts` to key by `postUrl` instead of `postPath`:

```dart
Map<String, int> _computeFlagCounts(List<FlagRecord> flags) {
  final counts = <String, int>{};
  for (final flag in flags) {
    counts[flag.postUrl] = (counts[flag.postUrl] ?? 0) + 1;
  }
  return counts;
}
```

Also update any UI code that looks up flag counts by `ref.path` to use `ref.postUrl` instead.

- [ ] **Step 3: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze`

Expected: No errors.

- [ ] **Step 4: Commit**

```bash
git add achaean_flutter/lib/features/agora/
git commit -m "feat: Flutter derives path from postUrl, flag counts keyed by postUrl"
```
