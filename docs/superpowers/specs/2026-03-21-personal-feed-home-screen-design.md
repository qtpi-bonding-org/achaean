# Personal Feed Home Screen

## Summary

The home screen shows a chronological feed of posts from people the user trusts. The feed displays metadata only (author, timestamp, polis, title). Post content is eagerly fetched in the background and displayed on a detail screen when tapped.

## Data Model Change

Remove `isReply` from `PostReference`. It's redundant — `parentPostUrl != null` conveys the same information. Update the model YAML, run serverpod generate, create migration.

## Feed Screen

### Data Flow

1. Screen mounts → `PersonalFeedCubit` calls `getPersonalFeed(limit: 50, offset: 0)` via Serverpod RPC
2. Returns `List<PostReference>` — rendered immediately from metadata
3. Background: for each PostReference, `PostContentCache` fetches `post.json` from `postUrl` via `PostReadingService` and caches the result keyed by `postUrl`
4. Pagination: on scroll near bottom, load next page via `getPersonalFeed(limit: 50, offset: currentLength)`

### Feed Item Display (`PostReferenceTile`)

Each item in the feed shows two lines:

**Line 1 (metadata):** `{username} · {relative time} · {polis tag}`
- Username parsed from `authorRepoUrl` (e.g. `https://forge.example/alice/koinon` → `alice`)
- Relative time from `timestamp` (e.g. `2h ago`, `3d ago`)
- First polis tag from `poleisTags` (comma-separated, show first)

**Line 2 (context):**
- If `parentPostUrl != null`: "Replying to {parent username}" (parsed from `parentPostUrl`)
- Else if `title != null`: the title text
- Else: blank line

Uses `InscriptionTile` pattern — no cards, `StoneDivider` between items.

### Empty State

"No posts yet. Trust someone to see their posts here."

### Compose Action

App bar action icon (top-right) pushes `/create-post`. No FAB (disabled by theme).

## Detail Screen (`PostDetailScreen`)

Pushed via GoRouter when a feed item is tapped. Receives `PostReference` as parameter.

### Content Loading

1. Check `PostContentCache` for cached content
2. If cached → display immediately
3. If not cached → show metadata (same as feed tile) + fetch content on demand

### Display

- `AchaeanScaffold` with back button
- Author username + full timestamp
- Polis tags
- If reply: "Replying to {parent username}" with link/tap to parent
- Post body text (from `Post.content.text`)
- If rich content (HTML+CSS): render in `MuseumFrame`

## New Components

### `PersonalFeedCubit`

Extends `AppCubit<PersonalFeedState>`. Injected with `IAgoraService` (for Serverpod RPC) and `PostContentCache`.

Methods:
- `loadFeed()` — initial load, limit 50
- `loadMore()` — paginate, append results
- `refresh()` — reset and reload

State (freezed):
```
PersonalFeedState:
  status: UiFlowStatus
  error: Object?
  posts: List<PostReference>
  hasMore: bool
  offset: int
```

### `PostContentCache`

Simple in-memory cache. `@singleton`.

```
Map<String, ReadablePostContent> _cache

Future<ReadablePostContent?> get(String postUrl)
void put(String postUrl, ReadablePostContent content)
bool has(String postUrl)
```

On feed load, iterates visible PostReferences and calls `PostReadingService.getPost()` for each, storing results. Fire-and-forget — no UI state change on completion.

### `PostReferenceTile`

Stateless widget. Takes `PostReference` and `VoidCallback onTap`.

Renders the two-line layout described above using `InscriptionTile` internally. Extracts username from URL via a shared utility function.

### `PostDetailScreen`

Takes `PostReference` via GoRouter extra. Uses `PostContentCache` to get content. If not cached, fetches via `PostReadingService` with a `FutureBuilder` or local state.

## Routing

- `/` → `PersonalFeedScreen` (replaces placeholder)
- `/post-detail` → `PostDetailScreen` (new route, receives PostReference via extra)

## Existing Patterns Followed

- `AchaeanScaffold` for consistent chrome
- `UiFlowListener` for loading/error states
- `BlocProvider` → `BlocBuilder` for state rendering
- `InscriptionTile` + `StoneDivider` for list items
- Feature module structure: `features/personal_feed/`
- `@injectable` for DI registration
- Freezed for state classes
