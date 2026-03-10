# Rich Presentation + Polis Forking Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add HTML+CSS rich post support (sealed PostContent type, updated read/create services) and polis forking (IGitClient.forkRepo + fork flow in PolisService).

**Architecture:** Two independent features sharing no code. Rich presentation adds a sealed type in `dart_koinon`, updates `PostReadingService` to detect HTML files, and `PostCreationService` to commit them. Polis forking adds `forkRepo()` to `IGitClient`/`ForgejoClient`, and a `forkPolis()` method to `PolisService` that forks, adds a parent pointer to README YAML, and signs.

**Tech Stack:** Dart, Flutter, Freezed, Serverpod (model already has `parentRepoUrl`), Forgejo REST API, `dart_git`, `dart_koinon`

---

## Task 1: Add `forkRepo()` to IGitClient and ForgejoEndpoints

**Files:**
- Modify: `dart_git/lib/src/client/i_git_client.dart`
- Modify: `dart_git/lib/src/forgejo/forgejo_endpoints.dart`
- Modify: `dart_git/lib/src/forgejo/forgejo_client.dart`
- Test: `dart_git/test/forgejo_client_test.dart`

**Step 1: Write the failing test**

Add to `dart_git/test/forgejo_client_test.dart`:

```dart
group('forkRepo', () {
  test('returns GitRepo on 202', () async {
    final client = createClient((req) {
      expect(req.method, 'POST');
      expect(req.url.path, '/api/v1/repos/origOwner/origRepo/forks');
      return http.Response(
        jsonEncode({
          'id': 99,
          'name': 'origRepo',
          'owner': {'login': 'myuser'},
          'clone_url': 'https://forgejo.example.com/myuser/origRepo.git',
          'html_url': 'https://forgejo.example.com/myuser/origRepo',
          'description': 'Forked repo',
          'private': false,
        }),
        202,
      );
    });

    final repo = await client.forkRepo(owner: 'origOwner', repo: 'origRepo');
    expect(repo.id, 99);
    expect(repo.name, 'origRepo');
    expect(repo.owner, 'myuser');
  });

  test('throws GitNotFoundException on 404', () async {
    final client = createClient((_) => http.Response('', 404));
    expect(
      () => client.forkRepo(owner: 'x', repo: 'y'),
      throwsA(isA<GitNotFoundException>()),
    );
  });
});
```

**Step 2: Run test to verify it fails**

Run: `cd dart_git && dart test test/forgejo_client_test.dart`
Expected: Compilation error — `forkRepo` not defined on `ForgejoClient`.

**Step 3: Add `forkRepo` to IGitClient interface**

In `dart_git/lib/src/client/i_git_client.dart`, add after the `exists` method:

```dart
Future<GitRepo> forkRepo({
  required String owner,
  required String repo,
});
```

**Step 4: Add fork endpoint to ForgejoEndpoints**

In `dart_git/lib/src/forgejo/forgejo_endpoints.dart`, add:

```dart
/// POST /api/v1/repos/{owner}/{repo}/forks
Uri forkRepo(String owner, String repo) =>
    Uri.parse(_api('/repos/$owner/$repo/forks'));
```

**Step 5: Implement `forkRepo` in ForgejoClient**

In `dart_git/lib/src/forgejo/forgejo_client.dart`, add after the `exists` method:

```dart
@override
Future<GitRepo> forkRepo({
  required String owner,
  required String repo,
}) async {
  final response = await httpClient.post(
    endpoints.forkRepo(owner, repo),
    headers: _headers,
    body: jsonEncode({}),
  );
  if (response.statusCode != 202) _throw(response);
  final json = _decodeJson(response);
  return GitRepo(
    id: json['id'] as int,
    name: json['name'] as String,
    owner: (json['owner'] as Map<String, dynamic>)['login'] as String,
    cloneUrl: json['clone_url'] as String,
    htmlUrl: json['html_url'] as String,
    description: json['description'] as String?,
    private: json['private'] as bool? ?? false,
  );
}
```

**Step 6: Run tests to verify they pass**

Run: `cd dart_git && dart test test/forgejo_client_test.dart`
Expected: All tests pass including new `forkRepo` tests.

**Step 7: Commit**

```bash
git add dart_git/lib/src/client/i_git_client.dart dart_git/lib/src/forgejo/forgejo_endpoints.dart dart_git/lib/src/forgejo/forgejo_client.dart dart_git/test/forgejo_client_test.dart
git commit -m "feat(dart_git): add forkRepo to IGitClient and ForgejoClient"
```

---

## Task 2: Add `forkPolis()` to PolisService

**Files:**
- Modify: `achaean_flutter/lib/features/polis/services/i_polis_service.dart`
- Modify: `achaean_flutter/lib/features/polis/services/polis_service.dart`

**Context:** `PolisService` already has `createPolis`, `joinPolis`, `leavePolis`, `getPolisInfo`, `getOwnPoleis`. The fork flow is: call `forkRepo()` on the authenticated git client → read the forked README → add `parent: "<originalRepoUrl>"` to YAML frontmatter → commit → sign README → add to koinon.json manifest. Reuses existing `_parseYamlFrontmatter`, `_computeContentHash`, `_addPolisToManifest` private helpers.

**Step 1: Add `forkPolis` to the interface**

In `achaean_flutter/lib/features/polis/services/i_polis_service.dart`, add:

```dart
/// Fork an existing polis. Forks the repo, adds parent pointer to README
/// YAML frontmatter, signs README, and registers in koinon.json.
Future<RepoIdentifier> forkPolis(RepoIdentifier sourceRepoId);
```

**Step 2: Implement `forkPolis` in PolisService**

In `achaean_flutter/lib/features/polis/services/polis_service.dart`, add the method:

```dart
@override
Future<RepoIdentifier> forkPolis(RepoIdentifier sourceRepoId) {
  return tryMethod(
    () async {
      final client = await _gitService.getClient();
      final owner = requireNonNull(
        await _gitService.getUsername(),
        'username',
        PolisException.new,
      );
      final baseUrl = requireNonNull(
        await _gitService.getBaseUrl(),
        'baseUrl',
        PolisException.new,
      );

      // 1. Fork the repo
      final forkedRepo = await client.forkRepo(
        owner: sourceRepoId.owner,
        repo: sourceRepoId.repo,
      );

      // 2. Read forked README
      final readmeFile = await client.readFile(
        owner: owner,
        repo: forkedRepo.name,
        path: 'README.md',
      );

      // 3. Add parent pointer to YAML frontmatter
      final sourceUrl =
          '${sourceRepoId.baseUrl}/${sourceRepoId.owner}/${sourceRepoId.repo}';
      final updatedReadme =
          _addParentToFrontmatter(readmeFile.content, sourceUrl);

      // 4. Commit updated README
      final readmeCommit = await client.commitFile(
        owner: owner,
        repo: forkedRepo.name,
        path: 'README.md',
        content: updatedReadme,
        message:
            'Initialize Koinon fork from ${sourceRepoId.owner}/${sourceRepoId.repo}',
        sha: readmeFile.sha,
      );

      // 5. Sign README → commit signature to own koinon repo
      final readmeHash = _computeContentHash(updatedReadme);
      final repoIdString = '$owner/${forkedRepo.name}';

      final readmeSig = ReadmeSignature(
        polis: repoIdString,
        readmeCommit: readmeCommit.sha,
        readmeHash: readmeHash,
        timestamp: DateTime.now().toUtc(),
        signature: '',
      );
      final signature = await _signingService.sign(readmeSig.toJson());
      final signedSig = readmeSig.copyWith(signature: signature);

      final sigPath = 'poleis/$repoIdString/signature.json';
      final sigJson =
          const JsonEncoder.withIndent('  ').convert(signedSig.toJson());

      await client.commitFile(
        owner: owner,
        repo: 'koinon',
        path: sigPath,
        content: sigJson,
        message: 'Sign forked polis README: ${forkedRepo.name}',
      );

      // 6. Parse name from README for manifest
      final info = _parseYamlFrontmatter(updatedReadme);

      // 7. Update koinon.json
      await _addPolisToManifest(client, owner, repoIdString, info.name);

      return RepoIdentifier(
        baseUrl: baseUrl,
        owner: owner,
        repo: forkedRepo.name,
      );
    },
    PolisException.new,
    'forkPolis',
  );
}
```

**Step 3: Add the `_addParentToFrontmatter` private helper**

In `polis_service.dart`, add in the private helpers section:

```dart
String _addParentToFrontmatter(String readmeContent, String parentUrl) {
  final lines = readmeContent.split('\n');
  if (lines.isEmpty || lines.first.trim() != '---') {
    throw const PolisException('README has no YAML frontmatter');
  }

  final endIndex = lines.indexWhere(
    (l) => l.trim() == '---',
    1,
  );
  if (endIndex == -1) {
    throw const PolisException('README frontmatter not closed');
  }

  // Insert parent line before closing ---
  final updatedLines = [
    ...lines.sublist(0, endIndex),
    'parent: "$parentUrl"',
    ...lines.sublist(endIndex),
  ];
  return updatedLines.join('\n');
}
```

**Step 4: Verify compilation**

Run: `cd achaean_flutter && flutter analyze lib/features/polis/`
Expected: No errors (warnings OK).

**Step 5: Commit**

```bash
git add achaean_flutter/lib/features/polis/services/i_polis_service.dart achaean_flutter/lib/features/polis/services/polis_service.dart
git commit -m "feat: add forkPolis to PolisService with parent pointer"
```

---

## Task 3: Create sealed `ReadablePostContent` type in dart_koinon

**Files:**
- Create: `dart_koinon/lib/src/models/readable_post_content.dart`
- Modify: `dart_koinon/lib/dart_koinon.dart`

**Context:** The existing `PostContent` freezed class represents the JSON data inside `post.json` (text, title, url, media). The new `ReadablePostContent` is a sealed type that wraps a fully parsed `Post` with its rendering mode — either JSON-only or HTML+CSS. This is a **read-side** concept: when reading a post directory, you get back either a `JsonReadablePost` (just the parsed `Post`) or a `RichReadablePost` (parsed `Post` + HTML string + optional CSS string).

**Important:** Don't confuse this with the existing `PostContent` — that stays as-is. This is a separate sealed class for the read path.

**Step 1: Create the sealed type**

Create `dart_koinon/lib/src/models/readable_post_content.dart`:

```dart
import 'post.dart';

/// The result of reading a post directory.
///
/// A post directory always contains `post.json`. It may also contain
/// `index.html` (and optionally `style.css`) for rich presentation.
sealed class ReadablePostContent {
  /// The parsed post.json data.
  Post get post;

  const ReadablePostContent();
}

/// A plain post — only post.json, no presentation files.
class JsonReadablePost extends ReadablePostContent {
  @override
  final Post post;

  const JsonReadablePost(this.post);
}

/// A rich post — post.json plus HTML (and optional CSS) presentation.
class RichReadablePost extends ReadablePostContent {
  @override
  final Post post;

  /// The HTML content from index.html.
  final String html;

  /// Optional CSS from style.css.
  final String? css;

  const RichReadablePost(this.post, this.html, [this.css]);
}
```

**Step 2: Export from barrel file**

In `dart_koinon/lib/dart_koinon.dart`, add:

```dart
export 'src/models/readable_post_content.dart';
```

**Step 3: Run tests to verify nothing broke**

Run: `cd dart_koinon && dart test`
Expected: All existing tests pass.

**Step 4: Commit**

```bash
git add dart_koinon/lib/src/models/readable_post_content.dart dart_koinon/lib/dart_koinon.dart
git commit -m "feat(dart_koinon): add ReadablePostContent sealed type"
```

---

## Task 4: Update PostReadingService to return ReadablePostContent

**Files:**
- Modify: `achaean_flutter/lib/features/agora/services/i_post_reading_service.dart`
- Modify: `achaean_flutter/lib/features/agora/services/post_reading_service.dart`

**Context:** Currently `PostReadingService.getPost()` reads `post.json` from the author's repo and returns a `Post`. We change it to return `ReadablePostContent` — after reading `post.json`, it checks if `index.html` exists in the same directory. If so, reads it (and optional `style.css`) and returns `RichReadablePost`. Otherwise returns `JsonReadablePost`.

The `ref.path` field contains the path to `post.json` (e.g., `posts/2026-03-09-my-post/post.json`). The directory is the parent: `posts/2026-03-09-my-post/`.

**Step 1: Update the interface**

Replace the contents of `achaean_flutter/lib/features/agora/services/i_post_reading_service.dart`:

```dart
import 'package:dart_koinon/dart_koinon.dart';

import 'package:achaean_client/achaean_client.dart';

/// Reads post content from author repos via public git API.
abstract class IPostReadingService {
  /// Read a post's content from the author's repo.
  ///
  /// Returns [JsonReadablePost] if only post.json exists,
  /// or [RichReadablePost] if index.html is also present.
  Future<ReadablePostContent> getPost(PostReference ref);
}
```

**Step 2: Update the implementation**

Replace `PostReadingService.getPost()` in `achaean_flutter/lib/features/agora/services/post_reading_service.dart`:

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

      // 1. Read post.json (always present)
      final file = await client.readFile(
        owner: repoId.owner,
        repo: repoId.repo,
        path: ref.path,
      );
      final json = jsonDecode(file.content) as Map<String, dynamic>;
      final post = Post.fromJson(json);

      // 2. Derive directory path from post.json path
      final lastSlash = ref.path.lastIndexOf('/');
      final dirPath = lastSlash > 0 ? ref.path.substring(0, lastSlash) : '';

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

**Step 3: Verify compilation**

Run: `cd achaean_flutter && flutter analyze lib/features/agora/services/`
Expected: No errors. There may be warnings in cubits/UI that still expect `Post` — those will be updated if needed, but cubits currently don't call `getPost()` directly (it's for lazy loading in UI).

**Step 4: Commit**

```bash
git add achaean_flutter/lib/features/agora/services/i_post_reading_service.dart achaean_flutter/lib/features/agora/services/post_reading_service.dart
git commit -m "feat: update PostReadingService to return ReadablePostContent"
```

---

## Task 5: Update PostCreationService to accept optional HTML/CSS

**Files:**
- Modify: `achaean_flutter/lib/features/post_creation/services/i_post_creation_service.dart`
- Modify: `achaean_flutter/lib/features/post_creation/services/post_creation_service.dart`

**Context:** `PostCreationService.createPost()` currently commits only `post.json`. We add optional `html` and `css` parameters. If provided, they're committed as `index.html` and `style.css` in the same slug directory alongside `post.json`.

**Step 1: Update the interface**

In `achaean_flutter/lib/features/post_creation/services/i_post_creation_service.dart`, update `createPost`:

```dart
Future<PostCreationResult> createPost({
  required String text,
  String? title,
  String? url,
  List<String> poleis = const [],
  List<String> tags = const [],
  String? html,
  String? css,
});
```

**Step 2: Update the implementation**

In `achaean_flutter/lib/features/post_creation/services/post_creation_service.dart`:

Add `html` and `css` parameters to `createPost()`:

```dart
@override
Future<PostCreationResult> createPost({
  required String text,
  String? title,
  String? url,
  List<String> poleis = const [],
  List<String> tags = const [],
  String? html,
  String? css,
}) {
```

After the line that commits `post.json` (step 4 in the existing code), and before regenerating `feed.xml` (step 5), add:

```dart
// 4.5 Commit optional presentation files
if (html != null) {
  await client.commitFile(
    owner: owner,
    repo: repo,
    path: 'posts/$slug/index.html',
    content: html,
    message: 'Add post presentation: $slug',
  );
}
if (css != null) {
  await client.commitFile(
    owner: owner,
    repo: repo,
    path: 'posts/$slug/style.css',
    content: css,
    message: 'Add post styles: $slug',
  );
}
```

**Step 3: Verify compilation**

Run: `cd achaean_flutter && flutter analyze lib/features/post_creation/`
Expected: No errors. Existing callers don't pass `html`/`css` so they still work (optional params with no default).

**Step 4: Commit**

```bash
git add achaean_flutter/lib/features/post_creation/services/i_post_creation_service.dart achaean_flutter/lib/features/post_creation/services/post_creation_service.dart
git commit -m "feat: support optional HTML/CSS in PostCreationService"
```

---

## Task 6: Full project compilation check

**Step 1: Analyze dart_git**

Run: `cd dart_git && dart analyze`
Expected: No errors.

**Step 2: Analyze dart_koinon**

Run: `cd dart_koinon && dart analyze`
Expected: No errors.

**Step 3: Analyze achaean_flutter**

Run: `cd achaean_flutter && flutter analyze`
Expected: No errors (warnings OK).

**Step 4: Run all tests**

Run: `cd dart_git && dart test && cd ../dart_koinon && dart test`
Expected: All tests pass.

**Step 5: Commit if any fixes were needed**

If any fixes were required, commit them:
```bash
git add -A
git commit -m "fix: resolve compilation issues from rich presentation + polis forking"
```

---

## Implementation Order

```
Task 1 (forkRepo in dart_git)       — no deps
Task 3 (ReadablePostContent)         — no deps
Task 2 (forkPolis in PolisService)   — depends on Task 1
Task 4 (PostReadingService update)   — depends on Task 3
Task 5 (PostCreationService update)  — no deps (only adds optional params)
Task 6 (full compilation check)      — depends on all above
```

Tasks 1 + 3 + 5 can proceed in parallel. Task 2 after Task 1. Task 4 after Task 3. Task 6 last.

---

## Critical Files to Reference

| File | What to reuse |
|------|---------------|
| `dart_git/lib/src/client/i_git_client.dart` | Interface to extend with `forkRepo` |
| `dart_git/lib/src/forgejo/forgejo_client.dart` | Implementation pattern for new methods |
| `dart_git/lib/src/forgejo/forgejo_endpoints.dart` | URL builder pattern |
| `dart_git/test/forgejo_client_test.dart` | Test pattern with `MockClient` |
| `dart_koinon/lib/src/models/post.dart` | `Post` model used by `ReadablePostContent` |
| `dart_koinon/lib/src/models/post_content.dart` | Existing `PostContent` — don't confuse with `ReadablePostContent` |
| `achaean_flutter/lib/features/agora/services/post_reading_service.dart` | Service to update for HTML detection |
| `achaean_flutter/lib/features/post_creation/services/post_creation_service.dart` | Service to update for HTML/CSS commits |
| `achaean_flutter/lib/features/polis/services/polis_service.dart` | Service to extend with `forkPolis` |
| `achaean_flutter/lib/core/try_operation.dart` | `tryMethod()` and `requireNonNull()` patterns |
| `achaean_flutter/lib/core/models/polis_info.dart` | Already has `parentRepo` field |
| `achaean_server/lib/src/koinon/polis_definition.spy.yaml` | Already has `parentRepoUrl` field |
