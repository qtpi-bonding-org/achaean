# Trust, Observe, and Profile UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add profile management, trust/observe relationship UI, and user detail screens to the Flutter client.

**Architecture:** Four layers of work: (1) data model changes in dart_koinon and server, (2) new profile service + cubit in Flutter, (3) new screens wired into the router, (4) navigation updates. Each layer builds on the previous.

**Tech Stack:** Flutter, freezed v3, cubit_ui_flow, GoRouter, GetIt/injectable, Serverpod, dart_koinon, dart_git

---

## File Map

### New files

| File | Purpose |
|------|---------|
| `dart_koinon/lib/src/models/profile_details.dart` | ProfileDetails freezed model |
| `achaean_flutter/lib/core/exceptions/profile_exception.dart` | Typed exception for profile ops |
| `achaean_flutter/lib/features/profile/services/i_profile_service.dart` | Profile service interface |
| `achaean_flutter/lib/features/profile/services/profile_service.dart` | Profile service implementation |
| `achaean_flutter/lib/features/profile/cubit/profile_cubit.dart` | Profile cubit |
| `achaean_flutter/lib/features/profile/cubit/profile_state.dart` | Profile freezed state |
| `achaean_flutter/lib/features/profile/services/profile_message_mapper.dart` | Message mapper for profile ops |
| `achaean_flutter/lib/features/profile/screens/profile_screen.dart` | Profile tab screen |
| `achaean_flutter/lib/features/profile/screens/edit_profile_screen.dart` | Edit profile pushed screen |
| `achaean_flutter/lib/features/people/screens/people_screen.dart` | People tab screen |
| `achaean_flutter/lib/features/people/screens/user_detail_screen.dart` | User detail pushed screen |
| `achaean_flutter/lib/features/people/widgets/user_identity_tile.dart` | Reusable user identity widget |
| `achaean_flutter/lib/features/people/widgets/trust_observe_buttons.dart` | Trust + Observe toggle buttons |
| `achaean_flutter/lib/features/observe/services/observe_message_mapper.dart` | Message mapper for observe ops |

### Modified files

| File | Change |
|------|--------|
| `dart_koinon/lib/dart_koinon.dart` | Add profile_details export |
| `achaean_server/lib/src/koinon/politai_user.spy.yaml` | Remove displayName field |
| `achaean_flutter/lib/app_router.dart` | Add profile, people, user-detail, edit-profile routes; update nav items |
| `achaean_flutter/lib/app/bootstrap.dart` | Register profile service, cubit, mappers |
| `achaean_flutter/lib/l10n/app_en.arb` | Add localization keys |

---

### Task 1: Add ProfileDetails model to dart_koinon

**Files:**
- Create: `dart_koinon/lib/src/models/profile_details.dart`
- Modify: `dart_koinon/lib/dart_koinon.dart`

- [ ] **Step 1: Create ProfileDetails freezed model**

```dart
// dart_koinon/lib/src/models/profile_details.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_details.freezed.dart';
part 'profile_details.g.dart';

@freezed
abstract class ProfileDetails with _$ProfileDetails {
  const factory ProfileDetails({
    String? displayName,
    String? bio,
  }) = _ProfileDetails;

  factory ProfileDetails.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsFromJson(json);
}
```

- [ ] **Step 2: Add export to dart_koinon.dart**

Add this line after the `observe_entry.dart` export in `dart_koinon/lib/dart_koinon.dart`:

```dart
export 'src/models/profile_details.dart';
```

- [ ] **Step 3: Run build_runner**

```bash
cd dart_koinon && dart run build_runner build --delete-conflicting-outputs
```

Expected: Generates `profile_details.freezed.dart` and `profile_details.g.dart`.

- [ ] **Step 4: Commit**

```bash
git add dart_koinon/lib/src/models/profile_details.dart dart_koinon/lib/src/models/profile_details.freezed.dart dart_koinon/lib/src/models/profile_details.g.dart dart_koinon/lib/dart_koinon.dart
git commit -m "feat(dart_koinon): add ProfileDetails model for user profile data"
```

---

### Task 2: Remove displayName from PolitaiUser server model

**Files:**
- Modify: `achaean_server/lib/src/koinon/politai_user.spy.yaml`

- [ ] **Step 1: Remove displayName field from the spy.yaml**

Current content of `achaean_server/lib/src/koinon/politai_user.spy.yaml`:

```yaml
class: PolitaiUser
table: politai_users
fields:
  pubkey: String
  repoUrl: String
  displayName: String?
  discoveredAt: DateTime
  lastIndexedAt: DateTime?
indexes:
  politai_users_pubkey_idx:
    fields: pubkey
    unique: true
```

Change to:

```yaml
class: PolitaiUser
table: politai_users
fields:
  pubkey: String
  repoUrl: String
  discoveredAt: DateTime
  lastIndexedAt: DateTime?
indexes:
  politai_users_pubkey_idx:
    fields: pubkey
    unique: true
```

- [ ] **Step 2: Regenerate Serverpod code**

```bash
cd achaean_server && dart run serverpod generate
```

Expected: Regenerates `politai_user.dart` and related files without `displayName`.

- [ ] **Step 3: Fix any compile errors**

Search the server codebase for references to `displayName` on PolitaiUser and remove them:

```bash
cd achaean_server && grep -rn 'displayName' lib/src/
```

Update any code that sets or reads `displayName` on PolitaiUser records.

- [ ] **Step 4: Commit**

```bash
git add achaean_server/
git commit -m "refactor(server): remove displayName from PolitaiUser — profile data lives in repos"
```

---

### Task 3: Add profile service and cubit to Flutter

**Files:**
- Create: `achaean_flutter/lib/core/exceptions/profile_exception.dart`
- Create: `achaean_flutter/lib/features/profile/services/i_profile_service.dart`
- Create: `achaean_flutter/lib/features/profile/services/profile_service.dart`
- Create: `achaean_flutter/lib/features/profile/cubit/profile_state.dart`
- Create: `achaean_flutter/lib/features/profile/cubit/profile_cubit.dart`
- Create: `achaean_flutter/lib/features/profile/services/profile_message_mapper.dart`
- Create: `achaean_flutter/lib/features/observe/services/observe_message_mapper.dart`

- [ ] **Step 1: Create ProfileException**

```dart
// achaean_flutter/lib/core/exceptions/profile_exception.dart
class ProfileException implements Exception {
  final String message;
  final Object? cause;
  const ProfileException(this.message, [this.cause]);

  @override
  String toString() => 'ProfileException: $message';
}
```

- [ ] **Step 2: Create IProfileService interface**

```dart
// achaean_flutter/lib/features/profile/services/i_profile_service.dart
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';

abstract class IProfileService {
  /// Read own profile from profile/profile.json.
  Future<ProfileDetails> getOwnProfile();

  /// Write own profile to profile/profile.json and commit.
  Future<void> updateProfile(ProfileDetails profile);

  /// Read another user's profile from their repo.
  Future<ProfileDetails> getProfile(RepoIdentifier repoId);
}
```

- [ ] **Step 3: Create ProfileService implementation**

```dart
// achaean_flutter/lib/features/profile/services/profile_service.dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/profile_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/try_operation.dart';
import '../../../features/trust/services/trust_service.dart'
    show PublicGitClientFactory;
import 'i_profile_service.dart';

class ProfileService implements IProfileService {
  final IGitService _gitService;
  final PublicGitClientFactory _publicClientFactory;

  static const _profilePath = 'profile/profile.json';

  ProfileService(this._gitService, this._publicClientFactory);

  @override
  Future<ProfileDetails> getOwnProfile() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          ProfileException.new,
        );
        return _readProfile(client, owner, 'koinon');
      },
      ProfileException.new,
      'getOwnProfile',
    );
  }

  @override
  Future<void> updateProfile(ProfileDetails profile) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          ProfileException.new,
        );
        const repo = 'koinon';

        // Check if file exists (need sha for update)
        String? sha;
        try {
          final existing = await client.readFile(
            owner: owner,
            repo: repo,
            path: _profilePath,
          );
          sha = existing.sha;
        } on GitNotFoundException {
          // New profile file
        }

        final json =
            const JsonEncoder.withIndent('  ').convert(profile.toJson());

        await client.commitFile(
          owner: owner,
          repo: repo,
          path: _profilePath,
          content: json,
          message: 'Update profile',
          sha: sha,
        );
      },
      ProfileException.new,
      'updateProfile',
    );
  }

  @override
  Future<ProfileDetails> getProfile(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          ProfileException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        return _readProfile(client, repoId.owner, repoId.repo);
      },
      ProfileException.new,
      'getProfile',
    );
  }

  Future<ProfileDetails> _readProfile(
    IGitClient client,
    String owner,
    String repo,
  ) async {
    try {
      final file = await client.readFile(
        owner: owner,
        repo: repo,
        path: _profilePath,
      );
      final json = jsonDecode(file.content) as Map<String, dynamic>;
      return ProfileDetails.fromJson(json);
    } on GitNotFoundException {
      return const ProfileDetails();
    }
  }
}
```

- [ ] **Step 4: Create ProfileState**

```dart
// achaean_flutter/lib/features/profile/cubit/profile_state.dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState implements IUiFlowState {
  const ProfileState._();
  const factory ProfileState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default(ProfileDetails()) ProfileDetails profile,
  }) = _ProfileState;

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

- [ ] **Step 5: Create ProfileCubit**

```dart
// achaean_flutter/lib/features/profile/cubit/profile_cubit.dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_profile_service.dart';
import 'profile_state.dart';

class ProfileCubit extends AppCubit<ProfileState> {
  final IProfileService _service;

  ProfileCubit(this._service) : super(const ProfileState());

  Future<void> loadOwnProfile() async {
    await tryOperation(
      () async {
        final profile = await _service.getOwnProfile();
        return state.copyWith(
          status: UiFlowStatus.success,
          profile: profile,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> updateProfile({
    String? displayName,
    String? bio,
  }) async {
    await tryOperation(
      () async {
        final updated = ProfileDetails(
          displayName: displayName,
          bio: bio,
        );
        await _service.updateProfile(updated);
        return state.copyWith(
          status: UiFlowStatus.success,
          profile: updated,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
```

- [ ] **Step 6: Create ProfileMessageMapper**

```dart
// achaean_flutter/lib/features/profile/services/profile_message_mapper.dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/profile_state.dart';

@injectable
class ProfileMessageMapper implements IStateMessageMapper<ProfileState> {
  @override
  MessageKey? map(ProfileState state) {
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('profileUpdateSuccess');
    }
    return null;
  }
}
```

- [ ] **Step 7: Create ObserveMessageMapper (currently missing)**

```dart
// achaean_flutter/lib/features/observe/services/observe_message_mapper.dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/observe_state.dart';

@injectable
class ObserveMessageMapper implements IStateMessageMapper<ObserveState> {
  @override
  MessageKey? map(ObserveState state) {
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('observeDeclarationSuccess');
    }
    return null;
  }
}
```

- [ ] **Step 8: Run build_runner for freezed codegen**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

Expected: Generates `profile_state.freezed.dart`.

- [ ] **Step 9: Commit**

```bash
git add achaean_flutter/lib/core/exceptions/profile_exception.dart achaean_flutter/lib/features/profile/ achaean_flutter/lib/features/observe/services/observe_message_mapper.dart
git commit -m "feat(flutter): add profile service, cubit, and message mappers"
```

---

### Task 4: Add localization keys

**Files:**
- Modify: `achaean_flutter/lib/l10n/app_en.arb`

- [ ] **Step 1: Add new localization entries**

Add these entries to the JSON object in `achaean_flutter/lib/l10n/app_en.arb` (before the closing `}`):

```json
  "profileTitle": "Profile",
  "editProfile": "Edit Profile",
  "displayNameLabel": "Display Name",
  "displayNameHint": "How you want to be known",
  "bioLabel": "Bio",
  "bioHint": "A few words about yourself",
  "anonymous": "Anonymous",
  "saveProfile": "Save",
  "profileUpdateSuccess": "Profile updated",
  "profileUpdateError": "Failed to update profile",
  "peopleTitle": "People",
  "trustSegment": "Trust",
  "observeSegment": "Observe",
  "outgoingToggle": "Outgoing",
  "incomingToggle": "Incoming",
  "noTrustRelationships": "No trust relationships yet",
  "noObserveRelationships": "Not observing anyone yet",
  "noIncomingTrust": "Nobody trusts you yet",
  "noIncomingObserve": "Nobody observes you yet",
  "trustButton": "Trust",
  "observeButton": "Observe",
  "trustedLabel": "Trusted",
  "observingLabel": "Observing",
  "trustConfirmTitle": "Vouch for this person?",
  "trustConfirmBody": "Trusting someone affects community membership. This is a structural vouch, not just a follow.",
  "trustConfirmCancel": "Cancel",
  "trustConfirmAction": "Confirm",
  "nowObserving": "Now observing",
  "stoppedObserving": "Stopped observing",
  "trustDeclared": "Trust declared",
  "trustRevoked": "Trust revoked",
  "copyPubkey": "Copy pubkey",
  "pubkeyCopied": "Pubkey copied"
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/l10n/app_en.arb
git commit -m "feat(flutter): add localization keys for profile, people, and trust/observe UI"
```

---

### Task 5: Create UserIdentityTile widget

**Files:**
- Create: `achaean_flutter/lib/features/people/widgets/user_identity_tile.dart`

- [ ] **Step 1: Create the widget**

```dart
// achaean_flutter/lib/features/people/widgets/user_identity_tile.dart
import 'package:flutter/material.dart';

import '../../../design_system/widgets/inscription_tile.dart';

/// Displays a user's identity: display name (if available) + truncated pubkey.
///
/// Used in People lists, user detail headers, and anywhere a user needs
/// to be identified. Tapping navigates to the user detail screen.
class UserIdentityTile extends StatelessWidget {
  final String pubkey;
  final String? displayName;
  final VoidCallback? onTap;
  final Widget? trailing;

  const UserIdentityTile({
    super.key,
    required this.pubkey,
    this.displayName,
    this.onTap,
    this.trailing,
  });

  String get _truncatedPubkey {
    if (pubkey.length <= 12) return pubkey;
    return '${pubkey.substring(0, 6)}...${pubkey.substring(pubkey.length - 6)}';
  }

  @override
  Widget build(BuildContext context) {
    return InscriptionTile(
      title: displayName ?? _truncatedPubkey,
      subtitle: displayName != null ? _truncatedPubkey : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/people/widgets/user_identity_tile.dart
git commit -m "feat(flutter): add UserIdentityTile widget"
```

---

### Task 6: Create TrustObserveButtons widget

**Files:**
- Create: `achaean_flutter/lib/features/people/widgets/trust_observe_buttons.dart`

- [ ] **Step 1: Create the widget**

```dart
// achaean_flutter/lib/features/people/widgets/trust_observe_buttons.dart
import 'package:flutter/material.dart';

import '../../../design_system/primitives/app_sizes.dart';
import '../../../l10n/app_localizations.dart';

/// Row of Trust and Observe toggle buttons for the user detail screen.
///
/// Trust button shows a confirmation dialog before activating.
/// Observe button toggles instantly.
class TrustObserveButtons extends StatelessWidget {
  final bool isTrusted;
  final bool isObserving;
  final bool isLoading;
  final VoidCallback onTrustPressed;
  final VoidCallback onObservePressed;

  const TrustObserveButtons({
    super.key,
    required this.isTrusted,
    required this.isObserving,
    required this.isLoading,
    required this.onTrustPressed,
    required this.onObservePressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: _ToggleButton(
            label: isTrusted ? l10n.trustedLabel : l10n.trustButton,
            isActive: isTrusted,
            isLoading: isLoading,
            onPressed: onTrustPressed,
            theme: theme,
          ),
        ),
        SizedBox(width: AppSizes.space),
        Expanded(
          child: _ToggleButton(
            label: isObserving ? l10n.observingLabel : l10n.observeButton,
            isActive: isObserving,
            isLoading: isLoading,
            onPressed: onObservePressed,
            theme: theme,
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isLoading;
  final VoidCallback onPressed;
  final ThemeData theme;

  const _ToggleButton({
    required this.label,
    required this.isActive,
    required this.isLoading,
    required this.onPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: Text(label),
      );
    }
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: Text(label),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/people/widgets/trust_observe_buttons.dart
git commit -m "feat(flutter): add TrustObserveButtons widget"
```

---

### Task 7: Create Profile tab screen

**Files:**
- Create: `achaean_flutter/lib/features/profile/screens/profile_screen.dart`

- [ ] **Step 1: Create the screen**

```dart
// achaean_flutter/lib/features/profile/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../../l10n/app_localizations.dart';
import '../../post_creation/cubit/own_posts_cubit.dart';
import '../../post_creation/cubit/own_posts_state.dart';
import '../../post_creation/widgets/post_card.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadOwnProfile();
    context.read<OwnPostsCubit>().loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AchaeanScaffold(
      title: l10n.profileTitle,
      showBackButton: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => AppNavigation.toEditProfile(context),
          tooltip: l10n.editProfile,
        ),
      ],
      body: CustomScrollView(
        slivers: [
          // Profile header
          SliverToBoxAdapter(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final profile = state.profile;
                return Padding(
                  padding: EdgeInsets.all(AppSizes.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.displayName ?? l10n.anonymous,
                        style: theme.textTheme.headlineSmall,
                      ),
                      if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                        SizedBox(height: AppSizes.spaceSmall),
                        Text(
                          profile.bio!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: StoneDivider()),
          // Posts header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.screenPadding,
                vertical: AppSizes.spaceSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.ownPostsTitle,
                      style: theme.textTheme.titleMedium),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => AppNavigation.toCreatePost(context),
                    tooltip: 'New post',
                  ),
                ],
              ),
            ),
          ),
          // Posts list
          BlocBuilder<OwnPostsCubit, OwnPostsState>(
            builder: (context, state) {
              if (state.posts.isEmpty && state.isSuccess) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.screenPadding),
                      child: Text(l10n.ownPostsEmpty),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => PostCard(post: state.posts[index]),
                  childCount: state.posts.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/profile/screens/profile_screen.dart
git commit -m "feat(flutter): add Profile tab screen"
```

---

### Task 8: Create Edit Profile screen

**Files:**
- Create: `achaean_flutter/lib/features/profile/screens/edit_profile_screen.dart`

- [ ] **Step 1: Create the screen**

```dart
// achaean_flutter/lib/features/profile/screens/edit_profile_screen.dart
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
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../services/profile_message_mapper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.editProfile,
      onBack: () => AppNavigation.back(context),
      body: UiFlowListener<ProfileCubit, ProfileState>(
        mapper: GetIt.instance<ProfileMessageMapper>(),
        listener: (context, state) {
          if (state.isSuccess && _initialized) {
            AppNavigation.back(context);
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            // Initialize text controllers from loaded profile
            if (!_initialized && !state.isIdle) {
              _displayNameController.text =
                  state.profile.displayName ?? '';
              _bioController.text = state.profile.bio ?? '';
              _initialized = true;
            }

            return Padding(
              padding: EdgeInsets.all(AppSizes.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChiseledTextField(
                    controller: _displayNameController,
                    labelText: l10n.displayNameLabel,
                    hintText: l10n.displayNameHint,
                  ),
                  SizedBox(height: AppSizes.space),
                  ChiseledTextField(
                    controller: _bioController,
                    labelText: l10n.bioLabel,
                    hintText: l10n.bioHint,
                    maxLines: 3,
                  ),
                  SizedBox(height: AppSizes.spaceLarge),
                  TerracottaButton(
                    label: l10n.saveProfile,
                    isLoading: state.isLoading,
                    onPressed: () {
                      context.read<ProfileCubit>().updateProfile(
                            displayName:
                                _displayNameController.text.trim().isEmpty
                                    ? null
                                    : _displayNameController.text.trim(),
                            bio: _bioController.text.trim().isEmpty
                                ? null
                                : _bioController.text.trim(),
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/profile/screens/edit_profile_screen.dart
git commit -m "feat(flutter): add Edit Profile screen"
```

---

### Task 9: Create People tab screen

**Files:**
- Create: `achaean_flutter/lib/features/people/screens/people_screen.dart`

- [ ] **Step 1: Create the screen**

This screen has two top-level segments (Trust/Observe) and within each segment an Outgoing/Incoming toggle. It loads data from TrustCubit and ObserveCubit for outgoing, and from the server (if available) for incoming.

```dart
// achaean_flutter/lib/features/people/screens/people_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../../trust/cubit/trust_cubit.dart';
import '../../trust/cubit/trust_state.dart';
import '../../observe/cubit/observe_cubit.dart';
import '../../observe/cubit/observe_state.dart';
import '../widgets/user_identity_tile.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  int _segmentIndex = 0; // 0 = Trust, 1 = Observe
  bool _showIncoming = false;

  @override
  void initState() {
    super.initState();
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.peopleTitle,
      showBackButton: false,
      body: Column(
        children: [
          // Segment control: Trust | Observe
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.screenPadding,
              vertical: AppSizes.spaceSmall,
            ),
            child: SegmentedButton<int>(
              segments: [
                ButtonSegment(value: 0, label: Text(l10n.trustSegment)),
                ButtonSegment(value: 1, label: Text(l10n.observeSegment)),
              ],
              selected: {_segmentIndex},
              onSelectionChanged: (selected) {
                setState(() {
                  _segmentIndex = selected.first;
                  _showIncoming = false;
                });
              },
            ),
          ),
          // Direction toggle: Outgoing / Incoming
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
            child: Row(
              children: [
                ChoiceChip(
                  label: Text(l10n.outgoingToggle),
                  selected: !_showIncoming,
                  onSelected: (_) => setState(() => _showIncoming = false),
                ),
                SizedBox(width: AppSizes.spaceSmall),
                ChoiceChip(
                  label: Text(l10n.incomingToggle),
                  selected: _showIncoming,
                  onSelected: (_) => setState(() => _showIncoming = true),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.spaceSmall),
          // List
          Expanded(
            child: _showIncoming
                ? _buildIncomingList(context)
                : _buildOutgoingList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOutgoingList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_segmentIndex == 0) {
      // Trust outgoing
      return BlocBuilder<TrustCubit, TrustState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.declarations.isEmpty) {
            return Center(child: Text(l10n.noTrustRelationships));
          }
          return ListView.builder(
            itemCount: state.declarations.length,
            itemBuilder: (context, index) {
              final decl = state.declarations[index];
              return UserIdentityTile(
                pubkey: decl.subject,
                onTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: decl.subject,
                  repoUrl: decl.repo,
                ),
              );
            },
          );
        },
      );
    } else {
      // Observe outgoing
      return BlocBuilder<ObserveCubit, ObserveState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.declarations.isEmpty) {
            return Center(child: Text(l10n.noObserveRelationships));
          }
          return ListView.builder(
            itemCount: state.declarations.length,
            itemBuilder: (context, index) {
              final decl = state.declarations[index];
              return UserIdentityTile(
                pubkey: decl.subject,
                onTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: decl.subject,
                  repoUrl: decl.repo,
                ),
              );
            },
          );
        },
      );
    }
  }

  Widget _buildIncomingList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Incoming requires server queries — for MVP, show a placeholder
    // until server endpoints are wired
    final emptyMessage = _segmentIndex == 0
        ? l10n.noIncomingTrust
        : l10n.noIncomingObserve;

    return Center(child: Text(emptyMessage));
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/people/screens/people_screen.dart
git commit -m "feat(flutter): add People tab screen with trust/observe segments"
```

---

### Task 10: Create User Detail screen

**Files:**
- Create: `achaean_flutter/lib/features/people/screens/user_detail_screen.dart`

- [ ] **Step 1: Create the screen**

```dart
// achaean_flutter/lib/features/people/screens/user_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../../l10n/app_localizations.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../profile/cubit/profile_state.dart';
import '../../trust/cubit/trust_cubit.dart';
import '../../trust/cubit/trust_state.dart';
import '../../observe/cubit/observe_cubit.dart';
import '../../observe/cubit/observe_state.dart';
import '../widgets/trust_observe_buttons.dart';

/// Data passed via GoRouter extra to identify the user.
class UserDetailArgs {
  final String pubkey;
  final String repoUrl;

  const UserDetailArgs({required this.pubkey, required this.repoUrl});
}

class UserDetailScreen extends StatefulWidget {
  final UserDetailArgs args;

  const UserDetailScreen({super.key, required this.args});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load this user's profile, and own trust/observe to check relationship state
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
  }

  bool _isTrusted(TrustState state) {
    return state.declarations
        .any((d) => d.subject == widget.args.pubkey);
  }

  bool _isObserving(ObserveState state) {
    return state.declarations
        .any((d) => d.subject == widget.args.pubkey);
  }

  String get _subjectName {
    final pk = widget.args.pubkey;
    return pk.length >= 16 ? pk.substring(0, 16) : pk;
  }

  void _onTrustPressed(BuildContext context, bool currentlyTrusted) {
    final l10n = AppLocalizations.of(context)!;

    if (currentlyTrusted) {
      // Revoke — no confirmation needed
      context.read<TrustCubit>().revokeTrust(subjectName: _subjectName);
      return;
    }

    // Confirm before declaring trust
    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.trustConfirmTitle),
        content: Text(l10n.trustConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.trustConfirmCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.trustConfirmAction),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<TrustCubit>().declareTrust(
              subjectPubkey: widget.args.pubkey,
              subjectRepo: widget.args.repoUrl,
              level: TrustLevel.full,
            );
      }
    });
  }

  void _onObservePressed(BuildContext context, bool currentlyObserving) {
    if (currentlyObserving) {
      context.read<ObserveCubit>().revokeObserve(subjectName: _subjectName);
    } else {
      context.read<ObserveCubit>().declareObserve(
            subjectPubkey: widget.args.pubkey,
            subjectRepo: widget.args.repoUrl,
          );
    }
  }

  String get _truncatedPubkey {
    final pk = widget.args.pubkey;
    if (pk.length <= 12) return pk;
    return '${pk.substring(0, 6)}...${pk.substring(pk.length - 6)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AchaeanScaffold(
      title: _truncatedPubkey,
      onBack: () => AppNavigation.back(context),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final profile = state.profile;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.displayName ?? l10n.anonymous,
                      style: theme.textTheme.headlineSmall,
                    ),
                    SizedBox(height: AppSizes.spaceSmall),
                    // Full pubkey (tappable to copy)
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.args.pubkey));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.pubkeyCopied)),
                        );
                      },
                      child: Text(
                        widget.args.pubkey,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (profile.bio != null &&
                        profile.bio!.isNotEmpty) ...[
                      SizedBox(height: AppSizes.spaceSmall),
                      Text(profile.bio!, style: theme.textTheme.bodyMedium),
                    ],
                  ],
                );
              },
            ),
            SizedBox(height: AppSizes.space),
            // Trust / Observe buttons
            BlocBuilder<TrustCubit, TrustState>(
              builder: (context, trustState) {
                return BlocBuilder<ObserveCubit, ObserveState>(
                  builder: (context, observeState) {
                    return TrustObserveButtons(
                      isTrusted: _isTrusted(trustState),
                      isObserving: _isObserving(observeState),
                      isLoading:
                          trustState.isLoading || observeState.isLoading,
                      onTrustPressed: () => _onTrustPressed(
                          context, _isTrusted(trustState)),
                      onObservePressed: () => _onObservePressed(
                          context, _isObserving(observeState)),
                    );
                  },
                );
              },
            ),
            const StoneDivider(),
            // Future: user's posts would go here
            Expanded(
              child: Center(
                child: Text(
                  'Posts coming soon',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add achaean_flutter/lib/features/people/screens/user_detail_screen.dart
git commit -m "feat(flutter): add User Detail screen with trust/observe actions"
```

---

### Task 11: Update router and navigation

**Files:**
- Modify: `achaean_flutter/lib/app_router.dart`

- [ ] **Step 1: Update AppRoutes**

Add new route constants and remove `myPosts`:

```dart
class AppRoutes {
  AppRoutes._();
  static const String home = '/';
  static const String profile = '/profile';
  static const String people = '/people';
  static const String settings = '/settings';
  static const String createAccount = '/create-account';
  static const String createPost = '/create-post';
  static const String postDetail = '/post-detail';
  static const String editProfile = '/edit-profile';
  static const String userDetail = '/user-detail';
}
```

- [ ] **Step 2: Update RouteNames**

```dart
class RouteNames {
  RouteNames._();
  static const String home = 'home';
  static const String profile = 'profile';
  static const String people = 'people';
  static const String settings = 'settings';
  static const String createAccount = 'createAccount';
  static const String createPost = 'createPost';
  static const String postDetail = 'postDetail';
  static const String editProfile = 'editProfile';
  static const String userDetail = 'userDetail';
}
```

- [ ] **Step 3: Update nav items and nav routes**

```dart
static const _navItems = [
  NavItem(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    label: 'Home',
  ),
  NavItem(
    icon: Icons.person_outlined,
    selectedIcon: Icons.person,
    label: 'Profile',
  ),
  NavItem(
    icon: Icons.group_outlined,
    selectedIcon: Icons.group,
    label: 'People',
  ),
  NavItem(
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    label: 'Settings',
  ),
];

static const _navRoutes = [
  AppRoutes.home,
  AppRoutes.profile,
  AppRoutes.people,
  AppRoutes.settings,
];
```

- [ ] **Step 4: Update shell routes**

Replace the `myPosts` route with `profile` and add `people`. Add new imports at the top of the file:

```dart
import 'features/profile/cubit/profile_cubit.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/profile/screens/edit_profile_screen.dart';
import 'features/people/screens/people_screen.dart';
import 'features/people/screens/user_detail_screen.dart';
import 'features/trust/cubit/trust_cubit.dart';
import 'features/observe/cubit/observe_cubit.dart';
import 'features/post_creation/cubit/own_posts_cubit.dart';
```

Shell routes become:

```dart
routes: [
  GoRoute(
    path: AppRoutes.home,
    name: RouteNames.home,
    builder: (context, state) => BlocProvider(
      create: (_) => GetIt.instance<PersonalFeedCubit>(),
      child: const PersonalFeedScreen(),
    ),
  ),
  GoRoute(
    path: AppRoutes.profile,
    name: RouteNames.profile,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => GetIt.instance<ProfileCubit>()),
        BlocProvider(
            create: (_) => GetIt.instance<OwnPostsCubit>()),
      ],
      child: const ProfileScreen(),
    ),
  ),
  GoRoute(
    path: AppRoutes.people,
    name: RouteNames.people,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => GetIt.instance<TrustCubit>()),
        BlocProvider(
            create: (_) => GetIt.instance<ObserveCubit>()),
      ],
      child: const PeopleScreen(),
    ),
  ),
  GoRoute(
    path: AppRoutes.settings,
    name: RouteNames.settings,
    builder: (context, state) =>
        const Center(child: Text('Settings Page')),
  ),
],
```

- [ ] **Step 5: Add pushed routes for editProfile and userDetail**

Add after the existing pushed routes:

```dart
GoRoute(
  path: AppRoutes.editProfile,
  name: RouteNames.editProfile,
  builder: (context, state) => BlocProvider(
    create: (_) => GetIt.instance<ProfileCubit>()..loadOwnProfile(),
    child: const EditProfileScreen(),
  ),
),
GoRoute(
  path: AppRoutes.userDetail,
  name: RouteNames.userDetail,
  builder: (context, state) {
    final args = state.extra! as UserDetailArgs;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<ProfileCubit>()),
        BlocProvider(create: (_) => GetIt.instance<TrustCubit>()),
        BlocProvider(create: (_) => GetIt.instance<ObserveCubit>()),
      ],
      child: UserDetailScreen(args: args),
    );
  },
),
```

- [ ] **Step 6: Update AppNavigation**

Replace `toMyPosts` and add new navigation methods:

```dart
class AppNavigation {
  AppNavigation._();

  static void toHome(BuildContext context) => context.goNamed(RouteNames.home);
  static void toProfile(BuildContext context) =>
      context.goNamed(RouteNames.profile);
  static void toPeople(BuildContext context) =>
      context.goNamed(RouteNames.people);
  static void toSettings(BuildContext context) =>
      context.goNamed(RouteNames.settings);
  static void toCreateAccount(BuildContext context) =>
      context.pushNamed(RouteNames.createAccount);
  static void toCreatePost(BuildContext context) =>
      context.pushNamed(RouteNames.createPost);
  static void toPostDetail(BuildContext context, PostReference ref) =>
      context.pushNamed(RouteNames.postDetail, extra: ref);
  static void toEditProfile(BuildContext context) =>
      context.pushNamed(RouteNames.editProfile);
  static void toUserDetail(
    BuildContext context, {
    required String pubkey,
    required String repoUrl,
  }) =>
      context.pushNamed(
        RouteNames.userDetail,
        extra: UserDetailArgs(pubkey: pubkey, repoUrl: repoUrl),
      );

  static void back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      toHome(context);
    }
  }
}
```

- [ ] **Step 7: Commit**

```bash
git add achaean_flutter/lib/app_router.dart
git commit -m "feat(flutter): update router with profile, people, user-detail, edit-profile routes"
```

---

### Task 12: Register new dependencies in bootstrap

**Files:**
- Modify: `achaean_flutter/lib/app/bootstrap.dart`

- [ ] **Step 1: Add imports**

Add these imports to the top of `bootstrap.dart`:

```dart
import '../features/profile/services/i_profile_service.dart';
import '../features/profile/services/profile_service.dart';
import '../features/profile/cubit/profile_cubit.dart';
```

- [ ] **Step 2: Register ProfileService and ProfileCubit**

Add to `_registerCoreServices()`, after the Observe service registration:

```dart
// Profile service
getIt.registerLazySingleton<IProfileService>(
  () => ProfileService(
    getIt<IGitService>(),
    getIt<PublicGitClientFactory>(),
  ),
);
```

Add to the cubits section, after `ObserveCubit`:

```dart
getIt.registerFactory<ProfileCubit>(
  () => ProfileCubit(getIt<IProfileService>()),
);
```

- [ ] **Step 3: Commit**

```bash
git add achaean_flutter/lib/app/bootstrap.dart
git commit -m "feat(flutter): register profile service and cubit in bootstrap"
```

---

### Task 13: Wire up feed post author taps to user detail

**Files:**
- Modify: `achaean_flutter/lib/features/personal_feed/widgets/post_reference_tile.dart`

- [ ] **Step 1: Read the current PostReferenceTile to understand the author data available**

The `PostReferenceTile` already displays author info extracted from `PostReference.authorRepoUrl`. The `PostReference` (from `achaean_client`) should contain the author's pubkey and repo URL.

Check what fields `PostReference` has. If it includes `authorPubkey` and `authorRepoUrl`, add a tap handler on the author portion that navigates to user detail.

If PostReference doesn't have `authorPubkey`, the author tap on posts is deferred — just link from People tab for now. Add a TODO comment in the tile.

- [ ] **Step 2: Commit any changes**

```bash
git add achaean_flutter/lib/features/personal_feed/widgets/post_reference_tile.dart
git commit -m "feat(flutter): wire post author tap to user detail screen"
```

---

### Task 14: Verify the build compiles

- [ ] **Step 1: Run Flutter analyze**

```bash
cd achaean_flutter && flutter analyze
```

Fix any import errors, missing references, or type mismatches.

- [ ] **Step 2: Run Flutter build (debug check)**

```bash
cd achaean_flutter && flutter build apk --debug 2>&1 | tail -20
```

Or if on macOS:

```bash
cd achaean_flutter && flutter build macos --debug 2>&1 | tail -20
```

Expected: Build succeeds.

- [ ] **Step 3: Final commit if any fixes were needed**

```bash
git add -A achaean_flutter/
git commit -m "fix(flutter): resolve build errors from trust/observe/profile UI"
```

---

## Summary

| Task | What it does |
|------|-------------|
| 1 | ProfileDetails model in dart_koinon |
| 2 | Remove displayName from server PolitaiUser |
| 3 | Profile service, cubit, message mappers in Flutter |
| 4 | Localization keys |
| 5 | UserIdentityTile widget |
| 6 | TrustObserveButtons widget |
| 7 | Profile tab screen |
| 8 | Edit Profile screen |
| 9 | People tab screen |
| 10 | User Detail screen |
| 11 | Router + navigation updates |
| 12 | Bootstrap DI registration |
| 13 | Wire feed author taps |
| 14 | Verify build compiles |
