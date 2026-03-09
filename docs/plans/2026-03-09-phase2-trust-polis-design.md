# Phase 2: Trust & Polis — Flutter Client Design

## Scope

Flutter client plumbing only (services, cubits, models). No screens — UI deferred. Serverpod computation (Phase 2.4) deferred. The client can write to its own repo and read/inspect any repo it knows about via `IGitClient`.

## User Discovery

Manual entry (paste baseUrl/owner/repo) and tappable share links. No QR codes.

## Key Decisions

- **Trust levels:** Both `trust` and `provisional` per the existing `TrustLevel` enum in `dart_koinon`.
- **Revocation:** Delete the trust file. No tombstone — absence = no trust.
- **Polis README:** YAML frontmatter with placeholder fields (name, description, norms, threshold). No schema enforcement yet.
- **Polis repo:** Separate repo from the user's koinon repo. Creator's signature goes in their own koinon repo.
- **Public reads:** New `GitPublicAuth` in `dart_git` for unauthenticated reads of public repos.
- **Signing:** Extract a shared `ISigningService` from `PostSigningService` — same canonical-JSON-then-sign pattern for posts, trust declarations, and README signatures.

---

## New in `dart_git`

**`GitPublicAuth`** — implements `IGitAuth` with empty headers for unauthenticated public repo reads.

---

## New Models (freezed, in `achaean_flutter`)

**`RepoIdentifier`** — value type for referring to any repo:
- `baseUrl`, `owner`, `repo`

**`PolisInfo`** — parsed polis README frontmatter:
- `name`, `description`, `norms` (String), `threshold` (int?), `parentRepo` (String?)

**`RepoInspectionResult`** — everything readable from a repo:
- `KoinonManifest`, `List<TrustDeclaration>`, `List<ReadmeSignature>`, `List<Post>`

---

## Services

### `ISigningService` (extracted from `PostSigningService`)

Generic canonical-JSON signing. Takes any JSON-serializable object, removes `signature` key, canonical JSON bytes, signs via `IKeyService.signBytes()`, returns base64url string.

`PostSigningService` becomes a thin wrapper or is removed.

### `ITrustService`

- `declareTrust(subjectPubkey, subjectRepo, level)` → build `TrustDeclaration` → sign → commit `trust/<subject-name>.json`
- `revokeTrust(subjectName)` → read file to get sha → delete via `IGitClient.deleteFile()`
- `getOwnTrustDeclarations()` → list own trust dir, parse each
- `getTrustDeclarations(repoId)` → list trust dir of any repo via public read

### `IPolisService`

- `createPolis(name, description, norms, threshold)` → create repo → commit README with YAML frontmatter → sign README → commit `ReadmeSignature` to own repo at `poleis/<polis-repo-id>/signature.json` → update own `koinon.json` poleis list
- `joinPolis(repoId)` → read polis README → sign → commit signature to own repo → update `koinon.json`
- `leavePolis(repoId)` → delete signature file → update `koinon.json`
- `getPolisInfo(repoId)` → read README, parse YAML frontmatter
- `getOwnPoleis()` → read own `koinon.json` poleis list

### `IRepoInspectionService`

- `inspect(repoId)` → read manifest, trust declarations, polis signatures, posts → return `RepoInspectionResult`
- `getManifest(repoId)` → parse `.well-known/koinon.json`

All services use `tryMethod` with typed exceptions (`TrustException`, `PolisException`). All git operations go through `IGitClient`.

---

## Cubits

- **`TrustCubit`** — `declareTrust()`, `revokeTrust()`, `loadOwnTrust()`, `loadTrustFor(repoId)`
- **`PolisCubit`** — `createPolis()`, `joinPolis()`, `leavePolis()`, `loadOwnPoleis()`
- **`RepoInspectionCubit`** — `inspect(repoId)` → loads full `RepoInspectionResult`

All extend `AppCubit`, use `tryOperation`, freezed states with `IUiFlowState`.

---

## Exceptions

- `TrustException` — trust declaration operations
- `PolisException` — polis creation/joining operations

Added to `AppExceptionKeyMapper` with dot-notation l10n keys.

---

## DI Wiring

New services depend only on `IGitService`, `IKeyService`, `ISigningService`, and `IGitClient` — all already registered. Phase 2 services and cubits can use `@injectable`/`@lazySingleton` annotations. `RepoInspectionService` needs `GitClientFactory` + `GitPublicAuth` to construct read-only clients for foreign repos.

---

## Reused from `dart_koinon`

`TrustDeclaration`, `TrustLevel`, `ReadmeSignature`, `PolisMembership`, `KoinonManifest`, `Post`
