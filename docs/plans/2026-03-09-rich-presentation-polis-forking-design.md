# Rich Presentation + Polis Forking Design

## Scope

Two independent features: (1) support HTML+CSS posts alongside plain JSON posts, (2) fork an existing polis to create a variant with linked lineage. Both are Flutter client + dart_git changes. Serverpod gets a new indexed field for polis forking.

## Key Decisions

- **Sealed PostContent type.** `JsonPost(Post)` vs `RichPost(Post, String html, String? css)`. The rendering decision happens at display time, not at feed/index time. Feed references are format-agnostic.
- **Optional presentation files.** `PostCreationService` accepts optional HTML/CSS. They're committed alongside `post.json` in the same slug directory. `PostReadingService` checks for `index.html` to determine format.
- **Real git fork + parent pointer.** `IGitClient.forkRepo()` uses the host's fork API. Parent link stored in README YAML frontmatter (`parent: "<url>"`). Indexed in `PolisDefinition.parentRepoUrl`.
- **Two-commit fork flow.** Commit 1 (automatic): fork + add parent field + sign. Commit 2 (user-driven, later): customize rules + re-sign. Each README change gets a fresh signature.

---

## Rich Presentation

### PostContent Sealed Type

```dart
sealed class PostContent {
  Post get post;
}

class JsonPost extends PostContent {
  @override
  final Post post;
  JsonPost(this.post);
}

class RichPost extends PostContent {
  @override
  final Post post;
  final String html;
  final String? css;
  RichPost(this.post, this.html, [this.css]);
}
```

UI does an exhaustive switch — must handle both cases.

### PostReadingService Changes

Current flow: read `post.json` → return `Post`.

New flow:
1. Read `post.json` → parse `Post`
2. Check if `index.html` exists in same directory
3. If yes: read `index.html` (and optionally `style.css`) → return `RichPost`
4. If no: return `JsonPost`

### PostCreationService Changes

`createPost()` gains optional `html` and `css` parameters. If provided, they're committed as `index.html` and `style.css` alongside `post.json` in the slug directory.

### Feed / Index

No changes. `PostReference` metadata is format-agnostic. The Serverpod index and RSS feed work identically regardless of post format.

---

## Polis Forking

### IGitClient Extension

```dart
abstract class IGitClient {
  // ... existing methods ...
  Future<GitRepo> forkRepo(String owner, String repo);
}
```

`ForgejoClient` implements via `POST /api/v1/repos/{owner}/{repo}/forks`.

### Fork Flow

In `PolisService` (or a dedicated `PolisForkService`):

1. `gitClient.forkRepo(originalOwner, originalRepo)` → forked `GitRepo`
2. Read forked README, parse YAML frontmatter
3. Add `parent: "https://forge.example.com/originalOwner/originalRepo"` to frontmatter
4. Commit: `"Initialize Koinon fork from originalOwner/originalRepo"`
5. Sign README → commit signature

Later, user customizes rules:
1. Edit README thresholds/rules
2. Commit changes
3. Re-sign → commit new signature

### Indexing

`PolisDefinition` model gets nullable `parentRepoUrl` field. Serverpod indexes it for queries like "all forks of polis X."

---

## What Changes

- **Add (dart_git):** `IGitClient.forkRepo()`, `ForgejoClient` fork implementation
- **Add (dart_koinon):** `PostContent` sealed type (`JsonPost`, `RichPost`)
- **Modify (Flutter):** `PostReadingService` returns `PostContent` instead of `Post`, `PostCreationService` accepts optional HTML/CSS
- **Modify (Flutter):** `PolisService` gains fork flow (or new `PolisForkService`)
- **Modify (Serverpod):** `PolisDefinition` gets `parentRepoUrl` field, migration
- **Modify (README parsing):** Read/write `parent` field in YAML frontmatter
