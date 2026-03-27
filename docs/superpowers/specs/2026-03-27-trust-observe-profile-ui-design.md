# Trust, Observe, and Profile UI Design

## Summary

Add trust/observe relationship management UI, user detail screens, and a profile system to the Flutter client. This turns the existing backend (cubits, services, protocol models) into usable features.

## Data Layer Changes

### Remove `displayName` from PolitaiUser (server)

The server is an index, not a source of truth for user data. Remove the `displayName` field from the `PolitaiUser` table. Identity on the server is strictly `pubkey` + `repoUrl`.

### Add `ProfileDetails` model (dart_koinon)

New model in `dart_koinon/lib/src/models/profile_details.dart`:

```dart
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

### Add `profile/profile.json` to repo structure

New file in each user's repo:

```
profile/
  profile.json    # { "displayName": "alice", "bio": "I like woodworking" }
```

This is NOT in `.well-known/` — the indexer doesn't need it. Clients read it directly from the user's repo when displaying their identity.

Export from `dart_koinon.dart`.

### Add profile service (Flutter)

`IProfileService` / `ProfileService` in a new `features/profile/` feature directory:

- `getOwnProfile()` — reads `profile/profile.json` from own repo
- `updateProfile(ProfileDetails)` — writes `profile/profile.json` to own repo, commits
- `getProfile(RepoIdentifier)` — reads `profile/profile.json` from any user's repo (for display)

Uses existing `IGitService` for own repo, `PublicGitClientFactory` for foreign repos. Returns `ProfileDetails` (with null fields if file doesn't exist yet).

### Add ProfileCubit (Flutter)

`ProfileCubit` in `features/profile/cubit/`:

- `loadOwnProfile()` — loads own profile for display/editing
- `updateProfile(displayName, bio)` — saves changes
- `loadProfileFor(RepoIdentifier)` — loads another user's profile

State: `ProfileState` with `UiFlowStatus`, `ProfileDetails?`, `error`.

## Navigation Changes

### Update bottom nav from 3 tabs to 4 tabs

| Tab | Label | Route | Icon |
|-----|-------|-------|------|
| 1 | Home | `/` | home |
| 2 | Profile | `/profile` | person |
| 3 | People | `/people` | group |
| 4 | Settings | `/settings` | settings |

Current "Posts" tab (`/my-posts`) becomes the "Profile" tab (`/profile`). The existing `OwnPostsScreen` content moves into the new profile screen below the profile header.

Update `AppRoutes`, `AdaptiveNavShell` items, and `AppNavigation` in `app_router.dart`.

## Screens

### Profile Tab Screen (`/profile`)

**File:** `features/profile/screens/profile_screen.dart`

Layout (top to bottom):
- `AchaeanScaffold` with title "Profile", edit action button
- Profile header: display name (or "Anonymous" fallback), truncated pubkey, bio
- `StoneDivider`
- "Your Posts" section header
- Existing posts list (reuse `OwnPostsScreen` content/widgets)

Edit mode (pushed screen or inline toggle):
- `ChiseledTextField` for display name
- `ChiseledTextField` for bio (multiline)
- `TerracottaButton` to save

### People Tab Screen (`/people`)

**File:** `features/people/screens/people_screen.dart`

Layout:
- `AchaeanScaffold` with title "People"
- Segmented control at top: **Trust** | **Observe**
- Below segment: **Outgoing** / **Incoming** toggle
- List of user identity tiles

Each tile (use `InscriptionTile` or similar):
- Display name (if available) + truncated pubkey
- Tap → navigates to User Detail screen

**States (4 list views):**

| Segment | Direction | Data source |
|---------|-----------|-------------|
| Trust + Outgoing | People I trust | Own trust declarations |
| Trust + Incoming | People who trust me | Server: trust declarations where `toPubkey` = me |
| Observe + Outgoing | People I observe | Own observe declarations |
| Observe + Incoming | People who observe me | Server: observe declarations where `toPubkey` = me |

### User Detail Screen (`/user-detail`)

**File:** `features/people/screens/user_detail_screen.dart`

Pushed route (not in nav shell). Entry points:
- Tap post author in agora feed
- Tap person in People tab lists

Layout:
- `AchaeanScaffold` with back button, title = display name or truncated pubkey
- Profile section: display name, full pubkey (copyable), bio, repo URL
- Two action buttons in a row:
  - **Trust** toggle (`TerracottaButton`) — with confirmation dialog
  - **Observe** toggle (`TerracottaButton`) — instant, snackbar feedback
- `StoneDivider`
- Their recent posts below

**Trust confirmation dialog:**
- Title: "Vouch for this person?"
- Body: "Trusting someone affects community membership. This is a structural vouch, not just a follow."
- Actions: Cancel | Confirm

**Observe behavior:**
- Instant toggle on tap
- Snackbar: "Now observing [name/pubkey]" or "Stopped observing [name/pubkey]"

### Profile Edit Screen (`/edit-profile`)

**File:** `features/profile/screens/edit_profile_screen.dart`

Pushed route from Profile tab.

Layout:
- `AchaeanScaffold` with back button, title "Edit Profile"
- `ChiseledTextField` for display name
- `ChiseledTextField` for bio (multiline)
- `TerracottaButton` to save
- `UiFlowListener` for success/error snackbars

## Widgets

### UserIdentityTile

**File:** `features/people/widgets/user_identity_tile.dart`

Reusable widget for displaying a user's identity anywhere (People lists, post author lines, user detail header).

- Display name (if available, bold) + truncated pubkey (muted)
- Tap callback
- Uses existing design system components (InscriptionTile pattern)

### TrustObserveButtons

**File:** `features/people/widgets/trust_observe_buttons.dart`

Reusable row of Trust + Observe toggle buttons for the User Detail screen.

- Two `TerracottaButton`s
- Trust button: filled when active, shows confirmation dialog on activate
- Observe button: filled when active, instant toggle
- Takes callbacks for onTrustChanged, onObserveChanged
- Takes current trust/observe state as booleans

## Routing

New routes in `app_router.dart`:

```
/profile          — Profile tab (nav shell)
/people           — People tab (nav shell)
/user-detail      — User detail (pushed, outside shell)
/edit-profile     — Edit profile (pushed, outside shell)
```

Remove `/my-posts` route (absorbed into `/profile`).

## Dependency Injection

Register in `bootstrap.dart`:

- `IProfileService` → `ProfileService` (lazy singleton)
- `ProfileCubit` (factory)
- `ProfileMessageMapper` (injectable)
- `ObserveMessageMapper` (injectable, currently missing)

## Localization

Add to `app_en.arb`:

- Profile: `profileTitle`, `editProfile`, `displayName`, `bio`, `anonymous`, `saveProfile`, `profileUpdateSuccess`, `profileUpdateError`
- People: `peopleTitle`, `trustSegment`, `observeSegment`, `outgoing`, `incoming`, `noTrustRelationships`, `noObserveRelationships`
- User detail: `userDetailTitle`, `trustButton`, `observeButton`, `trustConfirmTitle`, `trustConfirmBody`, `trustConfirmCancel`, `trustConfirmAction`, `nowObserving`, `stoppedObserving`, `fullPubkey`, `copyPubkey`

## What This Does NOT Include

- User search or directory (discovery is from feed only for MVP)
- Avatars (can be added to profile.json later)
- Server-side indexing of profile data (client reads directly from repos)
- Trust level selection (current service supports levels but UI defers this)
- Mutual trust indicators (can layer on later)
