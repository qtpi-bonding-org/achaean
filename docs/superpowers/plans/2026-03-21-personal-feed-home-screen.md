# Personal Feed Home Screen Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the home screen as a personal feed showing metadata-only post tiles, with eager background content fetching and a detail screen for reading.

**Architecture:** `PersonalFeedCubit` calls Serverpod's `getPersonalFeed()` RPC, renders `PostReferenceTile` widgets from metadata. `PostContentCache` eagerly fetches post content in the background. Tapping a tile pushes `PostDetailScreen` which reads from the cache or fetches on demand.

**Tech Stack:** Flutter, Cubit (cubit_ui_flow), GoRouter, Serverpod client, dart_koinon models

---

### Task 1: Remove `isReply` from PostReference

**Files:**
- Modify: `achaean_server/lib/src/koinon/post_reference.spy.yaml`
- Modify: `achaean_server/lib/src/koinon/webhook_endpoint.dart`
- Modify: `achaean_server/lib/src/koinon/koinon_endpoint.dart`

- [ ] **Step 1: Remove `isReply` from the model YAML**

In `achaean_server/lib/src/koinon/post_reference.spy.yaml`, delete these two lines:

```yaml
  ### Whether this is a reply (has parent reference).
  isReply: bool
```

- [ ] **Step 2: Run Serverpod code generation**

Run: `cd achaean_server && dart run serverpod generate`

Expected: Compile errors in `webhook_endpoint.dart` and `koinon_endpoint.dart` referencing `isReply`.

- [ ] **Step 3: Fix `webhook_endpoint.dart`**

In `achaean_server/lib/src/koinon/webhook_endpoint.dart`, in the `_indexPost` method:
- Remove `final isReply = post.parent != null;`
- Remove `..isReply = isReply` from the update block
- Remove `isReply: isReply,` from the insert block

- [ ] **Step 4: Fix any remaining compile errors**

Run: `cd achaean_server && dart analyze`

Fix any other references to `isReply` in the server or client code.

- [ ] **Step 5: Create database migration**

Run: `cd achaean_server && dart run serverpod create-migration`

- [ ] **Step 6: Fix Flutter references to `isReply`**

Search `achaean_flutter/` for any references to `isReply` on PostReference and remove them. Check `agora_cubit.dart`, `agora_state.dart`, and any widgets.

- [ ] **Step 7: Regenerate golden fixtures**

Run: `cd flutter_goldgen && dart run bin/flutter_goldgen.dart -p ../achaean_flutter/lib -o ../achaean_flutter/test/goldens/generated -c ../achaean_flutter/goldgen.yaml`

- [ ] **Step 8: Verify everything compiles**

Run: `cd achaean_server && dart analyze`
Run: `cd achaean_flutter && flutter analyze`

Expected: No errors (golden test fixture errors in generated files are acceptable if pre-existing).

- [ ] **Step 9: Commit**

```bash
git add achaean_server/ achaean_client/ achaean_flutter/
git commit -m "refactor: remove isReply from PostReference, use parentPostUrl != null"
```

---

### Task 2: Add `getPersonalFeed` to Flutter service layer

**Files:**
- Modify: `achaean_flutter/lib/features/agora/services/i_agora_service.dart`
- Modify: `achaean_flutter/lib/features/agora/services/agora_service.dart`

- [ ] **Step 1: Add method to `IAgoraService` interface**

In `achaean_flutter/lib/features/agora/services/i_agora_service.dart`, add:

```dart
/// Get post references from trusted authors (personal feed).
Future<List<PostReference>> getPersonalFeed({
  int limit = 50,
  int offset = 0,
});
```

- [ ] **Step 2: Implement in `AgoraService`**

In `achaean_flutter/lib/features/agora/services/agora_service.dart`, add:

```dart
@override
Future<List<PostReference>> getPersonalFeed({
  int limit = 50,
  int offset = 0,
}) {
  return tryMethod(
    () => _client.koinon.getPersonalFeed(limit: limit, offset: offset),
    QueryException.new,
    'getPersonalFeed',
  );
}
```

- [ ] **Step 3: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze`

Expected: No new errors.

- [ ] **Step 4: Commit**

```bash
git add achaean_flutter/lib/features/agora/services/
git commit -m "feat: add getPersonalFeed to IAgoraService"
```

---

### Task 3: Create `PostContentCache`

**Files:**
- Create: `achaean_flutter/lib/features/personal_feed/services/post_content_cache.dart`

- [ ] **Step 1: Create the cache class**

Create `achaean_flutter/lib/features/personal_feed/services/post_content_cache.dart`:

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../agora/services/i_post_reading_service.dart';

/// In-memory cache for eagerly-fetched post content.
///
/// Fetches post content from forge URLs in the background and caches
/// results keyed by postUrl. Used by the personal feed to pre-load
/// content before the user taps a post.
class PostContentCache {
  final IPostReadingService _postReadingService;
  final Map<String, ReadablePostContent> _cache = {};
  final Set<String> _inFlight = {};

  PostContentCache(this._postReadingService);

  /// Get cached content for a post URL, or null if not yet fetched.
  ReadablePostContent? get(String postUrl) => _cache[postUrl];

  /// Whether content is cached for this URL.
  bool has(String postUrl) => _cache.containsKey(postUrl);

  /// Eagerly fetch and cache content for a list of post references.
  ///
  /// Fire-and-forget — failures are silently ignored (content will be
  /// fetched on demand when the detail screen opens).
  void prefetch(List<PostReference> refs) {
    for (final ref in refs) {
      if (_cache.containsKey(ref.postUrl) ||
          _inFlight.contains(ref.postUrl)) {
        continue;
      }
      _inFlight.add(ref.postUrl);
      _postReadingService.getPost(ref).then((content) {
        _cache[ref.postUrl] = content;
      }).catchError((_) {
        // Silently ignore — will fetch on demand
      }).whenComplete(() {
        _inFlight.remove(ref.postUrl);
      });
    }
  }

  /// Fetch content for a single post reference, using cache if available.
  Future<ReadablePostContent> getOrFetch(PostReference ref) async {
    final cached = _cache[ref.postUrl];
    if (cached != null) return cached;

    final content = await _postReadingService.getPost(ref);
    _cache[ref.postUrl] = content;
    return content;
  }
}
```

- [ ] **Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze`

- [ ] **Step 3: Commit**

```bash
git add achaean_flutter/lib/features/personal_feed/
git commit -m "feat: add PostContentCache for eager background content fetching"
```

---

### Task 4: Create `PersonalFeedCubit` and state

**Files:**
- Create: `achaean_flutter/lib/features/personal_feed/cubit/personal_feed_state.dart`
- Create: `achaean_flutter/lib/features/personal_feed/cubit/personal_feed_cubit.dart`

- [ ] **Step 1: Create the state class**

Create `achaean_flutter/lib/features/personal_feed/cubit/personal_feed_state.dart`:

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_feed_state.freezed.dart';

@freezed
abstract class PersonalFeedState
    with _$PersonalFeedState
    implements IUiFlowState {
  const PersonalFeedState._();
  const factory PersonalFeedState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<PostReference> posts,
    @Default(false) bool hasMore,
    @Default(0) int offset,
  }) = _PersonalFeedState;

  @override
  bool get isIdle => status == UiFlowStatus.idle;
  @override
  bool get isLoading => status == UiFlowStatus.loading;
  @override
  bool get isSuccess => status == UiFlowStatus.success;
  @override
  bool get isFailure => status == UiFlowStatus.failure;
  @override
  bool get hasError => error != null;
}
```

- [ ] **Step 2: Create the cubit class**

Create `achaean_flutter/lib/features/personal_feed/cubit/personal_feed_cubit.dart`:

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../../agora/services/i_agora_service.dart';
import '../services/post_content_cache.dart';
import 'personal_feed_state.dart';

class PersonalFeedCubit extends AppCubit<PersonalFeedState> {
  final IAgoraService _agoraService;
  final PostContentCache _contentCache;

  static const _pageSize = 50;

  PersonalFeedCubit(this._agoraService, this._contentCache)
      : super(const PersonalFeedState());

  /// Load the personal feed (initial load).
  Future<void> loadFeed() async {
    await tryOperation(
      () async {
        final posts = await _agoraService.getPersonalFeed(
          limit: _pageSize,
          offset: 0,
        );

        // Eagerly prefetch content in background
        _contentCache.prefetch(posts);

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: posts,
          hasMore: posts.length >= _pageSize,
          offset: posts.length,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  /// Load more posts (pagination).
  Future<void> loadMore() async {
    if (!state.hasMore) return;

    await tryOperation(
      () async {
        final morePosts = await _agoraService.getPersonalFeed(
          limit: _pageSize,
          offset: state.offset,
        );

        // Eagerly prefetch content for new posts
        _contentCache.prefetch(morePosts);

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: [...state.posts, ...morePosts],
          hasMore: morePosts.length >= _pageSize,
          offset: state.offset + morePosts.length,
          error: null,
        );
      },
      emitLoading: false,
    );
  }

  /// Refresh the feed (pull-to-refresh).
  Future<void> refresh() async {
    await tryOperation(
      () async {
        final posts = await _agoraService.getPersonalFeed(
          limit: _pageSize,
          offset: 0,
        );

        _contentCache.prefetch(posts);

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: posts,
          hasMore: posts.length >= _pageSize,
          offset: posts.length,
          error: null,
        );
      },
      emitLoading: false,
    );
  }
}
```

- [ ] **Step 3: Run build_runner for freezed**

Run: `cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs`

Expected: `personal_feed_state.freezed.dart` generated.

- [ ] **Step 4: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze`

- [ ] **Step 5: Commit**

```bash
git add achaean_flutter/lib/features/personal_feed/cubit/
git commit -m "feat: add PersonalFeedCubit with pagination and eager prefetch"
```

---

### Task 5: Create URL parsing utility

**Files:**
- Create: `achaean_flutter/lib/core/utils/url_utils.dart`

- [ ] **Step 1: Create the utility**

Create `achaean_flutter/lib/core/utils/url_utils.dart`:

```dart
/// Extracts the username (repo owner) from a repo URL.
///
/// e.g. `https://forge.example/alice/koinon` → `alice`
String usernameFromRepoUrl(String repoUrl) {
  final uri = Uri.parse(repoUrl);
  final segments = uri.pathSegments;
  return segments.isNotEmpty ? segments.first : repoUrl;
}

/// Extracts the username from a full post URL.
///
/// e.g. `https://forge.example/bob/koinon/posts/hello/post.json` → `bob`
String usernameFromPostUrl(String postUrl) {
  final uri = Uri.parse(postUrl);
  final segments = uri.pathSegments;
  return segments.isNotEmpty ? segments.first : postUrl;
}

/// Formats a timestamp as relative time (e.g. "2h ago", "3d ago").
String relativeTime(DateTime timestamp) {
  final now = DateTime.now();
  final diff = now.difference(timestamp);

  if (diff.inSeconds < 60) return 'now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 30) return '${diff.inDays}d ago';
  if (diff.inDays < 365) return '${diff.inDays ~/ 30}mo ago';
  return '${diff.inDays ~/ 365}y ago';
}

/// Extracts the first polis tag from a comma-separated poleisTags string.
///
/// Returns the polis name (last path segment of the URL), or null if empty.
/// e.g. `https://forge.example/alice/polis-democracy,https://...` → `polis-democracy`
String? firstPolisTag(String? poleisTags) {
  if (poleisTags == null || poleisTags.isEmpty) return null;
  final first = poleisTags.split(',').first.trim();
  if (first.isEmpty) return null;
  final uri = Uri.tryParse(first);
  if (uri != null && uri.pathSegments.length >= 2) {
    return uri.pathSegments.last;
  }
  return first;
}
```

- [ ] **Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze`

- [ ] **Step 3: Commit**

```bash
git add achaean_flutter/lib/core/utils/url_utils.dart
git commit -m "feat: add URL parsing utilities for feed display"
```

---

### Task 6: Create `PostReferenceTile` widget

**Files:**
- Create: `achaean_flutter/lib/features/personal_feed/widgets/post_reference_tile.dart`

- [ ] **Step 1: Create the widget**

Create `achaean_flutter/lib/features/personal_feed/widgets/post_reference_tile.dart`:

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/url_utils.dart';
import '../../../design_system/widgets/inscription_tile.dart';

/// A feed tile showing post metadata from a [PostReference].
///
/// Line 1: author · relative time · polis tag
/// Line 2: title, "Replying to {user}", or blank
class PostReferenceTile extends StatelessWidget {
  final PostReference postRef;
  final VoidCallback? onTap;

  const PostReferenceTile({
    super.key,
    required this.postRef,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final author = usernameFromRepoUrl(postRef.authorRepoUrl);
    final time = relativeTime(postRef.timestamp);
    final polis = firstPolisTag(postRef.poleisTags);

    final metadataLine = [
      author,
      time,
      if (polis != null) polis,
    ].join(' · ');

    final contextLine = _buildContextLine();

    return InscriptionTile(
      title: metadataLine,
      subtitle: contextLine,
      onTap: onTap,
    );
  }

  String? _buildContextLine() {
    if (postRef.parentPostUrl != null) {
      final parentAuthor = usernameFromPostUrl(postRef.parentPostUrl!);
      return 'Replying to $parentAuthor';
    }
    return postRef.title;
  }
}
```

- [ ] **Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze`

- [ ] **Step 3: Commit**

```bash
git add achaean_flutter/lib/features/personal_feed/widgets/
git commit -m "feat: add PostReferenceTile for feed metadata display"
```

---

### Task 7: Create `PersonalFeedScreen`

**Files:**
- Create: `achaean_flutter/lib/features/personal_feed/screens/personal_feed_screen.dart`

- [ ] **Step 1: Create the screen**

Create `achaean_flutter/lib/features/personal_feed/screens/personal_feed_screen.dart`:

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../cubit/personal_feed_cubit.dart';
import '../cubit/personal_feed_state.dart';
import '../widgets/post_reference_tile.dart';

class PersonalFeedScreen extends StatefulWidget {
  const PersonalFeedScreen({super.key});

  @override
  State<PersonalFeedScreen> createState() => _PersonalFeedScreenState();
}

class _PersonalFeedScreenState extends State<PersonalFeedScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PersonalFeedCubit>().loadFeed();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PersonalFeedCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AchaeanScaffold(
      title: 'Feed',
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => AppNavigation.toCreatePost(context),
          tooltip: 'New post',
        ),
      ],
      body: BlocBuilder<PersonalFeedCubit, PersonalFeedState>(
        builder: (context, state) {
          if (state.isLoading && state.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isFailure && state.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Failed to load feed',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: AppSizes.space),
                  TextButton(
                    onPressed: () =>
                        context.read<PersonalFeedCubit>().loadFeed(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.posts.isEmpty && state.isSuccess) {
            return Center(
              child: Text(
                'No posts yet. Trust someone to see their posts here.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<PersonalFeedCubit>().refresh(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final ref = state.posts[index];
                return PostReferenceTile(
                  postRef: ref,
                  onTap: () => AppNavigation.toPostDetail(context, ref),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Do not commit yet** — this file references `AppNavigation.toPostDetail` which doesn't exist until Task 9. Both screens will be committed together with routing in Task 9.

---

### Task 8: Create `PostDetailScreen`

**Files:**
- Create: `achaean_flutter/lib/features/personal_feed/screens/post_detail_screen.dart`

- [ ] **Step 1: Create the screen**

Create `achaean_flutter/lib/features/personal_feed/screens/post_detail_screen.dart`:

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/url_utils.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/museum_frame.dart';
import '../services/post_content_cache.dart';

class PostDetailScreen extends StatefulWidget {
  final PostReference postRef;
  final PostContentCache contentCache;

  const PostDetailScreen({
    super.key,
    required this.postRef,
    required this.contentCache,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  ReadablePostContent? _content;
  bool _loading = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    // Check cache first
    final cached = widget.contentCache.get(widget.postRef.postUrl);
    if (cached != null) {
      setState(() => _content = cached);
      return;
    }

    // Fetch on demand
    setState(() => _loading = true);
    try {
      final content =
          await widget.contentCache.getOrFetch(widget.postRef);
      if (mounted) setState(() => _content = content);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ref = widget.postRef;
    final author = usernameFromRepoUrl(ref.authorRepoUrl);
    final polis = firstPolisTag(ref.poleisTags);

    return AchaeanScaffold(
      title: ref.title ?? 'Post',
      showBackButton: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.space * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author + timestamp
            Text(
              '$author · ${ref.timestamp.toLocal().toString().split('.').first}',
              style: theme.textTheme.bodySmall,
            ),

            // Polis tag
            if (polis != null) ...[
              SizedBox(height: AppSizes.space * 0.5),
              Text(
                polis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ],

            // Reply indicator
            if (ref.parentPostUrl != null) ...[
              SizedBox(height: AppSizes.space * 0.5),
              Text(
                'Replying to ${usernameFromPostUrl(ref.parentPostUrl!)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            SizedBox(height: AppSizes.space * 2),

            // Content
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Text(
                'Failed to load post content',
                style: theme.textTheme.bodyMedium,
              )
            else if (_content != null)
              _buildContent(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    final content = _content!;

    return switch (content) {
      RichReadablePost(:final post, :final html, :final css) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.content.title != null) ...[
              Text(post.content.title!, style: theme.textTheme.headlineSmall),
              SizedBox(height: AppSizes.space),
            ],
            MuseumFrame(child: _buildWebView(html, css)),
          ],
        ),
      JsonReadablePost(:final post) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.content.title != null) ...[
              Text(post.content.title!, style: theme.textTheme.headlineSmall),
              SizedBox(height: AppSizes.space),
            ],
            Text(post.content.text, style: theme.textTheme.bodyMedium),
          ],
        ),
    };
  }

  /// Placeholder for HTML+CSS rendering.
  /// TODO: Replace with sandboxed webview when rich presentation is implemented.
  Widget _buildWebView(String html, String? css) {
    return Text(html);
  }
}
```

- [ ] **Step 2: Do not commit yet** — will be committed together with routing in Task 9.

---

### Task 9: Wire up routing, DI, and commit screens

**Files:**
- Modify: `achaean_flutter/lib/app_router.dart`
- Modify: `achaean_flutter/lib/app/bootstrap.dart`

- [ ] **Step 1: Register `PostContentCache` and `PersonalFeedCubit` in bootstrap**

In `achaean_flutter/lib/app/bootstrap.dart`, in `_registerQueryServices()`, add after the existing registrations:

```dart
// Post content cache (singleton — shared between feed and detail)
getIt.registerLazySingleton<PostContentCache>(
  () => PostContentCache(getIt<IPostReadingService>()),
);

// Personal feed cubit
getIt.registerFactory<PersonalFeedCubit>(
  () => PersonalFeedCubit(
    getIt<IAgoraService>(),
    getIt<PostContentCache>(),
  ),
);
```

Add the necessary imports at the top of `bootstrap.dart`:

```dart
import '../features/personal_feed/cubit/personal_feed_cubit.dart';
import '../features/personal_feed/services/post_content_cache.dart';
```

- [ ] **Step 2: Update router with feed screen and detail route**

In `achaean_flutter/lib/app_router.dart`:

Add imports:

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'features/personal_feed/cubit/personal_feed_cubit.dart';
import 'features/personal_feed/screens/personal_feed_screen.dart';
import 'features/personal_feed/screens/post_detail_screen.dart';
import 'features/personal_feed/services/post_content_cache.dart';
```

Replace the home route placeholder:

```dart
GoRoute(
  path: AppRoutes.home,
  name: RouteNames.home,
  builder: (context, state) => BlocProvider(
    create: (_) => GetIt.instance<PersonalFeedCubit>(),
    child: const PersonalFeedScreen(),
  ),
),
```

Add post detail route inside the `ShellRoute.routes` list:

```dart
GoRoute(
  path: AppRoutes.postDetail,
  name: RouteNames.postDetail,
  builder: (context, state) {
    final ref = state.extra! as PostReference;
    return PostDetailScreen(
      postRef: ref,
      contentCache: GetIt.instance<PostContentCache>(),
    );
  },
),
```

Add to `AppRoutes`:

```dart
static const String postDetail = '/post-detail';
```

Add to `RouteNames`:

```dart
static const String postDetail = 'postDetail';
```

Add to `AppNavigation`:

```dart
static void toPostDetail(BuildContext context, PostReference ref) =>
    context.pushNamed(RouteNames.postDetail, extra: ref);
```

- [ ] **Step 3: Update PersonalFeedScreen to use AppNavigation**

In `PersonalFeedScreen`, replace `context.push(AppRoutes.postDetail, extra: ref)` with:

```dart
AppNavigation.toPostDetail(context, ref);
```

And add the import for GoRouter if needed (for the `context.push` extension).

- [ ] **Step 4: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze`

Expected: No errors.

- [ ] **Step 5: Regenerate golden fixtures**

Run: `cd flutter_goldgen && dart run bin/flutter_goldgen.dart -p ../achaean_flutter/lib -o ../achaean_flutter/test/goldens/generated -c ../achaean_flutter/goldgen.yaml`

- [ ] **Step 6: Commit**

```bash
git add achaean_flutter/lib/app_router.dart \
       achaean_flutter/lib/app/bootstrap.dart \
       achaean_flutter/lib/features/personal_feed/ \
       achaean_flutter/test/goldens/generated/
git commit -m "feat: wire up personal feed home screen, detail screen, routing, and DI"
```
