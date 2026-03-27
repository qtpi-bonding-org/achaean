# Nav Restructure + Agora + Polis Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure bottom nav to Feed/Profile/Connections/Settings, add agora community feed sub-tab, and add polis browsing/creation/joining UI.

**Architecture:** The Feed tab wraps PersonalFeedScreen and a new AgoraContent in a TabBarView. The Connections tab wraps PeopleScreen content and a new PolisContent in a TabBarView. New pushed routes for polis detail and create polis. All backend cubits/services already exist.

**Tech Stack:** Flutter, GoRouter, flutter_bloc, cubit_ui_flow, freezed, GetIt, dart_koinon

---

## File Map

### New files

| File | Purpose |
|------|---------|
| `achaean_flutter/lib/features/feed/screens/feed_screen.dart` | Feed tab with Personal/Agora tabs |
| `achaean_flutter/lib/features/feed/widgets/agora_content.dart` | Agora sub-tab: polis dropdown + community feed |
| `achaean_flutter/lib/features/connections/screens/connections_screen.dart` | Connections tab with People/Polis tabs |
| `achaean_flutter/lib/features/connections/widgets/polis_content.dart` | Polis sub-tab: joined + browse lists |
| `achaean_flutter/lib/features/connections/screens/polis_detail_screen.dart` | Polis detail pushed screen |
| `achaean_flutter/lib/features/connections/screens/create_polis_screen.dart` | Create polis pushed screen |

### Modified files

| File | Change |
|------|--------|
| `achaean_flutter/lib/app_router.dart` | Rename tabs, update routes, add polis routes |
| `achaean_flutter/lib/app/bootstrap.dart` | Ensure AgoraCubit, PolisCubit, PolisDiscoveryCubit registrations |
| `achaean_flutter/lib/l10n/app_en.arb` | Add localization keys |

---

### Task 1: Add localization keys

**Files:**
- Modify: `achaean_flutter/lib/l10n/app_en.arb`

- [ ] **Step 1: Add new localization entries**

Add these entries to the JSON object in `achaean_flutter/lib/l10n/app_en.arb` before the closing `}`:

```json
  "feedTitle": "Feed",
  "personalTab": "Personal",
  "agoraTab": "Agora",
  "agoraEmpty": "Join a polis to see community feeds",
  "agoraEmptyAction": "Find a polis",
  "selectPolis": "Select a polis",
  "connectionsTitle": "Connections",
  "peopleTab": "People",
  "polisTab": "Polis",
  "yourPoleis": "Your Poleis",
  "browsePoleis": "Browse Poleis",
  "noJoinedPoleis": "You haven't joined any poleis yet",
  "noBrowsePoleis": "No poleis found",
  "joinPolis": "Join",
  "leavePolis": "Leave",
  "joinedPolis": "Joined",
  "viewAgora": "View Agora",
  "createPolisTitle": "Create Polis",
  "polisNameLabel": "Polis Name",
  "polisNameHint": "Name your community",
  "polisDescriptionLabel": "Description",
  "polisDescriptionHint": "What is this community about?",
  "polisNormsLabel": "Norms",
  "polisNormsHint": "Community norms and expectations (optional)",
  "createPolisButton": "Create",
  "polisCreationSuccess": "Polis created",
  "polisCreationError": "Failed to create polis",
  "polisJoinSuccess": "Joined polis",
  "polisLeaveSuccess": "Left polis"
```

- [ ] **Step 2: Regenerate l10n and build_runner**

```bash
cd achaean_flutter && flutter gen-l10n && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 3: Commit**

```bash
git add achaean_flutter/lib/l10n/
git commit -m "feat(flutter): add localization keys for feed, connections, agora, and polis"
```

---

### Task 2: Create FeedScreen with Personal/Agora tabs

**Files:**
- Create: `achaean_flutter/lib/features/feed/screens/feed_screen.dart`
- Create: `achaean_flutter/lib/features/feed/widgets/agora_content.dart`

- [ ] **Step 1: Create AgoraContent widget**

This widget shows a polis dropdown and the agora feed below. It reads joined poleis from `PolisCubit` and loads the agora via `AgoraCubit`.

```dart
// achaean_flutter/lib/features/feed/widgets/agora_content.dart
import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../l10n/app_localizations.dart';
import '../../agora/cubit/agora_cubit.dart';
import '../../agora/cubit/agora_state.dart';
import '../../personal_feed/widgets/post_reference_tile.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';

class AgoraContent extends StatefulWidget {
  const AgoraContent({super.key});

  @override
  State<AgoraContent> createState() => _AgoraContentState();
}

class _AgoraContentState extends State<AgoraContent> {
  PolisMembership? _selectedPolis;

  @override
  void initState() {
    super.initState();
    context.read<PolisCubit>().loadOwnPoleis();
  }

  void _onPolisSelected(PolisMembership? polis) {
    if (polis == null) return;
    setState(() => _selectedPolis = polis);
    context.read<AgoraCubit>().loadAgora(polis.repo);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<PolisCubit, PolisState>(
      builder: (context, polisState) {
        if (polisState.poleis.isEmpty && polisState.isSuccess) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.agoraEmpty),
                SizedBox(height: AppSizes.space),
                TextButton(
                  onPressed: () => AppNavigation.toConnections(context),
                  child: Text(l10n.agoraEmptyAction),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Polis dropdown
            Padding(
              padding: EdgeInsets.all(AppSizes.space * 2),
              child: DropdownButtonFormField<PolisMembership>(
                value: _selectedPolis,
                hint: Text(l10n.selectPolis),
                isExpanded: true,
                items: polisState.poleis.map((p) {
                  return DropdownMenuItem(
                    value: p,
                    child: Text(p.name),
                  );
                }).toList(),
                onChanged: _onPolisSelected,
              ),
            ),
            // Agora feed
            Expanded(
              child: _selectedPolis == null
                  ? Center(child: Text(l10n.selectPolis))
                  : BlocBuilder<AgoraCubit, AgoraState>(
                      builder: (context, agoraState) {
                        if (agoraState.isLoading && agoraState.posts.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (agoraState.posts.isEmpty && agoraState.isSuccess) {
                          return const Center(
                              child: Text('No posts in this agora yet'));
                        }
                        return ListView.builder(
                          itemCount: agoraState.posts.length,
                          itemBuilder: (context, index) {
                            final ref = agoraState.posts[index];
                            return PostReferenceTile(
                              postRef: ref,
                              onTap: () =>
                                  AppNavigation.toPostDetail(context, ref),
                              onAuthorTap: () =>
                                  AppNavigation.toUserDetail(
                                    context,
                                    pubkey: ref.authorPubkey,
                                    repoUrl: ref.authorRepoUrl,
                                  ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
```

- [ ] **Step 2: Create FeedScreen**

The FeedScreen wraps the existing PersonalFeedScreen content and the new AgoraContent in a TabBar.

```dart
// achaean_flutter/lib/features/feed/screens/feed_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../../personal_feed/cubit/personal_feed_cubit.dart';
import '../../personal_feed/cubit/personal_feed_state.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../personal_feed/widgets/post_reference_tile.dart';
import '../widgets/agora_content.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<PersonalFeedCubit>().loadFeed();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.feedTitle,
      showBackButton: false,
      actions: [
        if (!AppRouter.isGuest)
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => AppNavigation.toCreatePost(context),
            tooltip: 'New post',
          ),
      ],
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.personalTab),
              Tab(text: l10n.agoraTab),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Personal feed
                _buildPersonalFeed(context),
                // Agora
                const AgoraContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalFeed(BuildContext context) {
    return BlocBuilder<PersonalFeedCubit, PersonalFeedState>(
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
                onAuthorTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: ref.authorPubkey,
                  repoUrl: ref.authorRepoUrl,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add achaean_flutter/lib/features/feed/
git commit -m "feat(flutter): add FeedScreen with Personal/Agora tabs"
```

---

### Task 3: Create ConnectionsScreen with People/Polis tabs

**Files:**
- Create: `achaean_flutter/lib/features/connections/screens/connections_screen.dart`
- Create: `achaean_flutter/lib/features/connections/widgets/polis_content.dart`

- [ ] **Step 1: Create PolisContent widget**

Shows joined poleis at top, browse all poleis below. Each polis tile taps to detail screen.

```dart
// achaean_flutter/lib/features/connections/widgets/polis_content.dart
import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/inscription_tile.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../../l10n/app_localizations.dart';
import '../../agora/cubit/polis_discovery_cubit.dart';
import '../../agora/cubit/polis_discovery_state.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';

class PolisContent extends StatefulWidget {
  const PolisContent({super.key});

  @override
  State<PolisContent> createState() => _PolisContentState();
}

class _PolisContentState extends State<PolisContent> {
  @override
  void initState() {
    super.initState();
    context.read<PolisCubit>().loadOwnPoleis();
    context.read<PolisDiscoveryCubit>().loadPoleis();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        // Your Poleis header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.space * 2),
            child: Text(l10n.yourPoleis, style: theme.textTheme.titleMedium),
          ),
        ),
        // Joined poleis list
        BlocBuilder<PolisCubit, PolisState>(
          builder: (context, state) {
            if (state.poleis.isEmpty && state.isSuccess) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.space * 2),
                  child: Text(l10n.noJoinedPoleis),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final polis = state.poleis[index];
                  return InscriptionTile(
                    title: polis.name,
                    subtitle: '${polis.stars} members · ${polis.role}',
                    onTap: () => AppNavigation.toPolisDetail(
                      context,
                      repoUrl: polis.repo,
                      name: polis.name,
                    ),
                  );
                },
                childCount: state.poleis.length,
              ),
            );
          },
        ),
        // Divider
        const SliverToBoxAdapter(child: StoneDivider()),
        // Browse Poleis header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.space * 2),
            child: Text(l10n.browsePoleis, style: theme.textTheme.titleMedium),
          ),
        ),
        // Browse list from server
        BlocBuilder<PolisDiscoveryCubit, PolisDiscoveryState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state.poleis.isEmpty && state.isSuccess) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.space * 2),
                  child: Text(l10n.noBrowsePoleis),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final polis = state.poleis[index];
                  return InscriptionTile(
                    title: polis.name,
                    subtitle: polis.description,
                    onTap: () => AppNavigation.toPolisDetail(
                      context,
                      repoUrl: polis.repoUrl,
                      name: polis.name,
                    ),
                  );
                },
                childCount: state.poleis.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: Create ConnectionsScreen**

Wraps existing PeopleScreen content and PolisContent in tabs.

```dart
// achaean_flutter/lib/features/connections/screens/connections_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../../observe/cubit/observe_cubit.dart';
import '../../people/screens/people_screen.dart';
import '../../trust/cubit/trust_cubit.dart';
import '../widgets/polis_content.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.connectionsTitle,
      showBackButton: false,
      actions: [
        // Create polis action (only on Polis tab)
        ListenableBuilder(
          listenable: _tabController,
          builder: (context, _) {
            if (_tabController.index == 1) {
              return IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => AppNavigation.toCreatePolis(context),
                tooltip: l10n.createPolisTitle,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.peopleTab),
              Tab(text: l10n.polisTab),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // People tab — reuse PeopleScreen content
                const PeopleContent(),
                // Polis tab
                const PolisContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

**Important:** The existing `PeopleScreen` is a full screen with its own `AchaeanScaffold`. We need to extract its body into a `PeopleContent` widget. See Task 4.

- [ ] **Step 3: Commit**

```bash
git add achaean_flutter/lib/features/connections/
git commit -m "feat(flutter): add ConnectionsScreen with People/Polis tabs"
```

---

### Task 4: Extract PeopleContent from PeopleScreen

**Files:**
- Modify: `achaean_flutter/lib/features/people/screens/people_screen.dart`

The current `PeopleScreen` has its own `AchaeanScaffold`, title, and body. We need to split it: keep `PeopleScreen` as-is (for backwards compat) but export the body as `PeopleContent` so `ConnectionsScreen` can embed it.

- [ ] **Step 1: Read the current PeopleScreen and extract content**

The current `PeopleScreen` body is everything inside `AchaeanScaffold.body`. Extract that into a new `PeopleContent` widget in the same file.

Add to the bottom of `achaean_flutter/lib/features/people/screens/people_screen.dart`:

```dart
/// The body content of PeopleScreen, extracted for embedding in ConnectionsScreen.
class PeopleContent extends StatefulWidget {
  const PeopleContent({super.key});

  @override
  State<PeopleContent> createState() => _PeopleContentState();
}

class _PeopleContentState extends State<PeopleContent> {
  int _segmentIndex = 0;
  bool _showIncoming = false;

  @override
  void initState() {
    super.initState();
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
  }

  @override
  Widget build(BuildContext context) {
    // Same build code as _PeopleScreenState but without AchaeanScaffold wrapper
    // Copy the Column from AchaeanScaffold.body in _PeopleScreenState
  }
}
```

The exact implementation: read the current `_PeopleScreenState.build()` method, copy the `Column(children: [...])` that is the `body:` of `AchaeanScaffold`, and use it as the `build()` return of `PeopleContent`. Also copy the helper methods `_buildOutgoingList` and `_buildIncomingList`.

The existing `PeopleScreen` can then be simplified to just use `PeopleContent` inside its scaffold, but this is optional for now — the key deliverable is the exported `PeopleContent` class.

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/people/screens/people_screen.dart
git commit -m "refactor(flutter): extract PeopleContent for embedding in ConnectionsScreen"
```

---

### Task 5: Create Polis Detail screen

**Files:**
- Create: `achaean_flutter/lib/features/connections/screens/polis_detail_screen.dart`

- [ ] **Step 1: Create the screen**

```dart
// achaean_flutter/lib/features/connections/screens/polis_detail_screen.dart
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../core/models/polis_info.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../../design_system/widgets/terracotta_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';
import '../../polis/services/i_polis_service.dart';

/// Data passed via GoRouter extra.
class PolisDetailArgs {
  final String repoUrl;
  final String name;

  const PolisDetailArgs({required this.repoUrl, required this.name});
}

class PolisDetailScreen extends StatefulWidget {
  final PolisDetailArgs args;

  const PolisDetailScreen({super.key, required this.args});

  @override
  State<PolisDetailScreen> createState() => _PolisDetailScreenState();
}

class _PolisDetailScreenState extends State<PolisDetailScreen> {
  PolisInfo? _polisInfo;
  bool _loadingInfo = true;

  @override
  void initState() {
    super.initState();
    context.read<PolisCubit>().loadOwnPoleis();
    _loadPolisInfo();
  }

  Future<void> _loadPolisInfo() async {
    try {
      final polisService = GetIt.instance<IPolisService>();
      // Parse repoUrl to extract owner/repo/baseUrl
      final uri = Uri.parse(widget.args.repoUrl);
      final pathSegments = uri.pathSegments;
      if (pathSegments.length >= 2) {
        final repoId = RepoIdentifier(
          baseUrl: '${uri.scheme}://${uri.host}',
          owner: pathSegments[0],
          repo: pathSegments[1],
        );
        final info = await polisService.getPolisInfo(repoId);
        if (mounted) setState(() { _polisInfo = info; _loadingInfo = false; });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingInfo = false);
    }
  }

  bool _isJoined(PolisState state) {
    return state.poleis.any((p) => p.repo == widget.args.repoUrl);
  }

  RepoIdentifier _repoIdFromUrl(String repoUrl) {
    final uri = Uri.parse(repoUrl);
    final pathSegments = uri.pathSegments;
    return RepoIdentifier(
      baseUrl: '${uri.scheme}://${uri.host}',
      owner: pathSegments[0],
      repo: pathSegments[1],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AchaeanScaffold(
      title: widget.args.name,
      onBack: () => AppNavigation.back(context),
      body: BlocBuilder<PolisCubit, PolisState>(
        builder: (context, state) {
          final joined = _isJoined(state);

          return Padding(
            padding: EdgeInsets.all(AppSizes.space * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.args.name,
                  style: theme.textTheme.headlineSmall,
                ),
                if (_polisInfo?.description != null) ...[
                  SizedBox(height: AppSizes.space),
                  Text(
                    _polisInfo!.description!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
                if (_polisInfo?.norms != null) ...[
                  SizedBox(height: AppSizes.space),
                  Text(
                    _polisInfo!.norms!,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                SizedBox(height: AppSizes.space * 2),
                // Join/Leave button
                SizedBox(
                  width: double.infinity,
                  child: joined
                      ? OutlinedButton(
                          onPressed: state.isLoading
                              ? null
                              : () => context.read<PolisCubit>().leavePolis(
                                    _repoIdFromUrl(widget.args.repoUrl),
                                  ),
                          child: Text(l10n.leavePolis),
                        )
                      : TerracottaButton(
                          label: l10n.joinPolis,
                          isLoading: state.isLoading,
                          onPressed: () =>
                              context.read<PolisCubit>().joinPolis(
                                    _repoIdFromUrl(widget.args.repoUrl),
                                  ),
                        ),
                ),
                const StoneDivider(),
                // View Agora button
                if (joined)
                  TextButton.icon(
                    icon: const Icon(Icons.forum_outlined),
                    label: Text(l10n.viewAgora),
                    onPressed: () => AppNavigation.toFeed(context),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/connections/screens/polis_detail_screen.dart
git commit -m "feat(flutter): add Polis Detail screen with join/leave"
```

---

### Task 6: Create Create Polis screen

**Files:**
- Create: `achaean_flutter/lib/features/connections/screens/create_polis_screen.dart`

- [ ] **Step 1: Create the screen**

```dart
// achaean_flutter/lib/features/connections/screens/create_polis_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/chiseled_text_field.dart';
import '../../../design_system/widgets/terracotta_button.dart';
import '../../../design_system/widgets/ui_flow_listener.dart';
import '../../../l10n/app_localizations.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';

class CreatePolisScreen extends StatefulWidget {
  const CreatePolisScreen({super.key});

  @override
  State<CreatePolisScreen> createState() => _CreatePolisScreenState();
}

class _CreatePolisScreenState extends State<CreatePolisScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _normsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _normsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.createPolisTitle,
      onBack: () => AppNavigation.back(context),
      body: SimpleUiFlowListener<PolisCubit, PolisState>(
        showSuccessToasts: true,
        successMessage: l10n.polisCreationSuccess,
        child: BlocListener<PolisCubit, PolisState>(
          listenWhen: (prev, curr) =>
              prev.createdPolis != curr.createdPolis &&
              curr.createdPolis != null,
          listener: (context, state) {
            AppNavigation.back(context);
          },
          child: BlocBuilder<PolisCubit, PolisState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(AppSizes.space * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ChiseledTextField(
                      controller: _nameController,
                      labelText: l10n.polisNameLabel,
                      hintText: l10n.polisNameHint,
                    ),
                    SizedBox(height: AppSizes.space),
                    ChiseledTextField(
                      controller: _descriptionController,
                      labelText: l10n.polisDescriptionLabel,
                      hintText: l10n.polisDescriptionHint,
                      maxLines: 3,
                    ),
                    SizedBox(height: AppSizes.space),
                    ChiseledTextField(
                      controller: _normsController,
                      labelText: l10n.polisNormsLabel,
                      hintText: l10n.polisNormsHint,
                      maxLines: 3,
                    ),
                    SizedBox(height: AppSizes.space * 3),
                    TerracottaButton(
                      label: l10n.createPolisButton,
                      isLoading: state.isLoading,
                      onPressed: () {
                        final name = _nameController.text.trim();
                        if (name.isEmpty) return;
                        context.read<PolisCubit>().createPolis(
                              name: name,
                              description:
                                  _descriptionController.text.trim().isEmpty
                                      ? null
                                      : _descriptionController.text.trim(),
                              norms: _normsController.text.trim().isEmpty
                                  ? null
                                  : _normsController.text.trim(),
                            );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/connections/screens/create_polis_screen.dart
git commit -m "feat(flutter): add Create Polis screen"
```

---

### Task 7: Update router and navigation

**Files:**
- Modify: `achaean_flutter/lib/app_router.dart`

- [ ] **Step 1: Update imports**

Replace/add imports:
```dart
// Remove these:
// import 'features/people/screens/people_screen.dart';

// Add these:
import 'features/agora/cubit/agora_cubit.dart';
import 'features/agora/cubit/polis_discovery_cubit.dart';
import 'features/connections/screens/connections_screen.dart';
import 'features/connections/screens/create_polis_screen.dart';
import 'features/connections/screens/polis_detail_screen.dart';
import 'features/feed/screens/feed_screen.dart';
import 'features/polis/cubit/polis_cubit.dart';
```

Keep the `PeopleScreen` import since `ConnectionsScreen` imports `PeopleContent` from it.

- [ ] **Step 2: Update nav items**

```dart
static const _navItems = [
  NavItem(icon: Icons.article_outlined, selectedIcon: Icons.article, label: 'Feed'),
  NavItem(icon: Icons.person_outlined, selectedIcon: Icons.person, label: 'Profile'),
  NavItem(icon: Icons.group_outlined, selectedIcon: Icons.group, label: 'Connections'),
  NavItem(icon: Icons.settings_outlined, selectedIcon: Icons.settings, label: 'Settings'),
];

static const _navRoutes = [
  AppRoutes.home,
  AppRoutes.profile,
  AppRoutes.connections,
  AppRoutes.settings,
];
```

- [ ] **Step 3: Update shell routes**

Replace the home route to use FeedScreen with all needed cubits:

```dart
GoRoute(
  path: AppRoutes.home,
  name: RouteNames.home,
  builder: (context, state) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => GetIt.instance<PersonalFeedCubit>()),
      BlocProvider(create: (_) => GetIt.instance<PolisCubit>()),
      BlocProvider(create: (_) => GetIt.instance<AgoraCubit>()),
    ],
    child: const FeedScreen(),
  ),
),
```

Replace the people route with connections:

```dart
GoRoute(
  path: AppRoutes.connections,
  name: RouteNames.connections,
  builder: (context, state) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => GetIt.instance<TrustCubit>()),
      BlocProvider(create: (_) => GetIt.instance<ObserveCubit>()),
      BlocProvider(create: (_) => GetIt.instance<PolisCubit>()),
      BlocProvider(create: (_) => GetIt.instance<PolisDiscoveryCubit>()),
    ],
    child: const ConnectionsScreen(),
  ),
),
```

- [ ] **Step 4: Add pushed routes**

After the existing userDetail route:

```dart
GoRoute(
  path: AppRoutes.polisDetail,
  name: RouteNames.polisDetail,
  builder: (context, state) {
    final args = state.extra! as PolisDetailArgs;
    return BlocProvider(
      create: (_) => GetIt.instance<PolisCubit>(),
      child: PolisDetailScreen(args: args),
    );
  },
),
GoRoute(
  path: AppRoutes.createPolis,
  name: RouteNames.createPolis,
  builder: (context, state) => BlocProvider(
    create: (_) => GetIt.instance<PolisCubit>(),
    child: const CreatePolisScreen(),
  ),
),
```

- [ ] **Step 5: Update AppRoutes**

```dart
class AppRoutes {
  AppRoutes._();
  static const String home = '/';
  static const String profile = '/profile';
  static const String connections = '/connections';
  static const String settings = '/settings';
  static const String createAccount = '/create-account';
  static const String createPost = '/create-post';
  static const String postDetail = '/post-detail';
  static const String editProfile = '/edit-profile';
  static const String userDetail = '/user-detail';
  static const String polisDetail = '/polis-detail';
  static const String createPolis = '/create-polis';
}
```

- [ ] **Step 6: Update RouteNames**

```dart
class RouteNames {
  RouteNames._();
  static const String home = 'home';
  static const String profile = 'profile';
  static const String connections = 'connections';
  static const String settings = 'settings';
  static const String createAccount = 'createAccount';
  static const String createPost = 'createPost';
  static const String postDetail = 'postDetail';
  static const String editProfile = 'editProfile';
  static const String userDetail = 'userDetail';
  static const String polisDetail = 'polisDetail';
  static const String createPolis = 'createPolis';
}
```

- [ ] **Step 7: Update AppNavigation**

Replace `toPeople` with `toConnections`, add polis navigation:

```dart
class AppNavigation {
  AppNavigation._();

  static void toFeed(BuildContext context) => context.goNamed(RouteNames.home);
  static void toProfile(BuildContext context) => context.goNamed(RouteNames.profile);
  static void toConnections(BuildContext context) => context.goNamed(RouteNames.connections);
  static void toSettings(BuildContext context) => context.goNamed(RouteNames.settings);
  static void toCreateAccount(BuildContext context) => context.pushNamed(RouteNames.createAccount);
  static void toCreatePost(BuildContext context) => context.pushNamed(RouteNames.createPost);
  static void toPostDetail(BuildContext context, PostReference ref) =>
      context.pushNamed(RouteNames.postDetail, extra: ref);
  static void toEditProfile(BuildContext context) => context.pushNamed(RouteNames.editProfile);
  static void toUserDetail(BuildContext context, {required String pubkey, required String repoUrl}) =>
      context.pushNamed(RouteNames.userDetail, extra: UserDetailArgs(pubkey: pubkey, repoUrl: repoUrl));
  static void toPolisDetail(BuildContext context, {required String repoUrl, required String name}) =>
      context.pushNamed(RouteNames.polisDetail, extra: PolisDetailArgs(repoUrl: repoUrl, name: name));
  static void toCreatePolis(BuildContext context) => context.pushNamed(RouteNames.createPolis);

  static void back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      toFeed(context);
    }
  }
}
```

- [ ] **Step 8: Commit**

```bash
git add achaean_flutter/lib/app_router.dart
git commit -m "feat(flutter): restructure nav to Feed/Profile/Connections/Settings with polis routes"
```

---

### Task 8: Update bootstrap for missing cubit registrations

**Files:**
- Modify: `achaean_flutter/lib/app/bootstrap.dart`

- [ ] **Step 1: Check existing registrations**

Read `bootstrap.dart` and verify that `AgoraCubit`, `PolisCubit`, and `PolisDiscoveryCubit` are registered. From previous context:
- `PolisCubit` is registered as factory in `_registerCoreServices()`
- `AgoraCubit` is registered in `_registerServerpodQueryServices()`
- `PolisDiscoveryCubit` is registered in `_registerServerpodQueryServices()`

These are conditional on `Client` being registered. For demo mode, `AgoraCubit` and `PolisDiscoveryCubit` may NOT be registered. If they're not registered in demo mode, the Agora tab and Polis browse list will crash.

Add fallback/guard: if `PolisDiscoveryCubit` isn't registered, skip the browse poleis section in the UI, or register stub cubits in demo mode.

For MVP, the simplest fix: check `getIt.isRegistered<PolisDiscoveryCubit>()` before using it in the router, or register it conditionally. Read the actual bootstrap code to determine the right approach.

- [ ] **Step 2: Make any necessary changes and commit**

```bash
git add achaean_flutter/lib/app/bootstrap.dart
git commit -m "fix(flutter): ensure polis and agora cubits available in all modes"
```

---

### Task 9: Verify build compiles

- [ ] **Step 1: Regenerate l10n and build_runner**

```bash
cd achaean_flutter && flutter gen-l10n && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 2: Run Flutter analyze**

```bash
cd achaean_flutter && flutter analyze 2>&1 | grep -v 'test/goldens/' | grep -E '(error|warning)'
```

Fix any issues found.

- [ ] **Step 3: Final commit if fixes needed**

```bash
git add achaean_flutter/
git commit -m "fix(flutter): resolve build errors from nav restructure"
```

---

## Summary

| Task | What it does |
|------|-------------|
| 1 | Localization keys for feed, connections, agora, polis |
| 2 | FeedScreen with Personal/Agora tabs |
| 3 | ConnectionsScreen with People/Polis tabs + PolisContent |
| 4 | Extract PeopleContent from PeopleScreen for embedding |
| 5 | Polis Detail screen (name, description, join/leave) |
| 6 | Create Polis screen (name, description, norms form) |
| 7 | Router restructure (Feed/Profile/Connections/Settings + polis routes) |
| 8 | Bootstrap: ensure cubits available in all modes |
| 9 | Verify build compiles |
