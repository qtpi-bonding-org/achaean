# Nav Restructure + Agora + Polis UI Design

## Summary

Restructure the bottom nav to Feed/Profile/Connections/Settings. Add sub-tabs to Feed (Personal/Agora) and Connections (People/Polis). Add polis browsing, detail, and creation screens.

## Bottom Navigation

| Tab | Label | Icon | Sub-tabs |
|-----|-------|------|----------|
| 1 | Feed | article | Personal / Agora |
| 2 | Profile | person | (none) |
| 3 | Connections | group | People / Polis |
| 4 | Settings | settings | (none) |

Rename "Home" to "Feed". Rename "People" to "Connections".

## Feed Tab

Tabbed container with two sub-tabs.

### Personal sub-tab

Existing `PersonalFeedScreen` content, unchanged. Posts from trusted + observed users.

### Agora sub-tab

- Dropdown at top showing the user's joined poleis (from `PolisCubit.loadOwnPoleis()`)
- When a polis is selected, show its agora feed below (from `AgoraCubit`)
- Empty state (no joined poleis): message "Join a polis to see community feeds" with a text button linking to Connections > Polis tab

Uses existing `AgoraCubit` which calls `koinon.getAgora(polisRepoUrl)`.

## Profile Tab

Unchanged. Shows profile details, own posts, edit profile action, create post action.

## Connections Tab

Tabbed container with two sub-tabs.

### People sub-tab

Existing `PeopleScreen` content, unchanged. Trust/Observe segments with Outgoing/Incoming toggle.

### Polis sub-tab

Layout (top to bottom):
- App bar action button: "Create Polis" (icon button, consistent with existing pattern)
- "Your Poleis" section header
- List of joined poleis (from `PolisCubit.loadOwnPoleis()`)
- `StoneDivider`
- "Browse Poleis" section header
- List of all known poleis from server (from `PolisDiscoveryCubit` / `IPolisQueryService.listPoleis()`)
- Tap any polis → pushed Polis Detail screen

Each polis tile shows: polis name, member count (if available).

## Polis Detail Screen (pushed route)

Entry points: tap polis in Connections > Polis lists.

Layout:
- `AchaeanScaffold` with back button, title = polis name
- Polis name (headline)
- Description/README content
- Member count
- Join/Leave toggle button (`TerracottaButton`)
  - Join: instant (no confirmation needed — joining is low-stakes, leaving is also easy)
  - Leave: instant
- "View Agora" button — navigates to Feed tab > Agora with that polis pre-selected. Implementation: call `AppNavigation.toFeed(context)` and pass the polis repo URL, or simply navigate to Feed and let the user select from the dropdown. For MVP, just navigate to the Feed tab (no pre-selection needed).

## Create Polis Screen (pushed route)

Entry point: action button on Connections > Polis sub-tab.

Layout:
- `AchaeanScaffold` with back button, title "Create Polis"
- `ChiseledTextField` for polis name
- `ChiseledTextField` for description/README (multiline)
- `TerracottaButton` to create
- `UiFlowListener` for success/error feedback
- On success: navigate back to Connections > Polis

Uses existing `PolisCubit.createPolis()`.

## Structural Changes

### Feed screen restructure

The current `PersonalFeedScreen` becomes the content of the Personal sub-tab. A new `FeedScreen` wraps it with a `TabBar`:

```
FeedScreen (StatefulWidget with TabController)
├── TabBar: [Personal, Agora]
├── TabBarView:
│   ├── PersonalFeedContent (extracted from PersonalFeedScreen)
│   └── AgoraContent (new)
```

### Connections screen restructure

The current `PeopleScreen` content becomes the People sub-tab. A new `ConnectionsScreen` wraps it with a `TabBar`:

```
ConnectionsScreen (StatefulWidget with TabController)
├── TabBar: [People, Polis]
├── TabBarView:
│   ├── PeopleContent (extracted from PeopleScreen)
│   └── PolisContent (new)
```

## Router Changes

### Nav items update
- Home (article icon) → Feed (article icon)
- Profile (person icon) — unchanged
- People (group icon) → Connections (group icon)
- Settings — unchanged

### Routes update
- `/` stays as Feed (was Home)
- `/profile` — unchanged
- `/connections` replaces `/people`
- `/settings` — unchanged
- Add `/polis-detail` — pushed route
- Add `/create-polis` — pushed route

### AppRoutes / RouteNames
- Remove `people`, add `connections`
- Add `polisDetail`, `createPolis`
- Update `AppNavigation` helpers

## Dependency Injection

No new service registrations needed — `PolisCubit`, `PolisDiscoveryCubit`, `AgoraCubit` are already registered or can use existing registrations. The `PolisDiscoveryCubit` and `AgoraCubit` may need registration if not already present (check bootstrap.dart).

Provide `PolisCubit` and `PolisDiscoveryCubit` on the Connections route. Provide `AgoraCubit` and `PolisCubit` on the Feed route (Agora needs polis list for dropdown + agora feed).

## Localization

Add to `app_en.arb`:
- Feed: `feedTitle`, `personalTab`, `agoraTab`, `agoraEmpty`, `agoraEmptyAction`, `selectPolis`
- Connections: `connectionsTitle`, `peopleTab`, `polisTab`
- Polis: `yourPoleis`, `browsePoleis`, `noJoinedPoleis`, `polisDetailTitle`, `joinPolis`, `leavePolis`, `viewAgora`, `memberCount`, `createPolisTitle`, `polisNameLabel`, `polisNameHint`, `polisDescriptionLabel`, `polisDescriptionHint`, `createPolisButton`, `polisCreationSuccess`, `polisCreationError`, `polisJoinSuccess`, `polisLeaveSuccess`

## What This Does NOT Include

- Polis member list UI (deferred)
- Polis settings/editing (deferred)
- Search/filter for polis browsing (browse-all is enough for MVP)
- Polis moderation features (flags, voucher review)
- Settings screen implementation (stays as placeholder)
