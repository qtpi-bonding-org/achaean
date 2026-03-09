# Post Flagging & Threshold Rename — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add post flagging as the 5th Koinon primitive (FlagEntry in koinon.json, FlagRecord in Serverpod, FlagService in Flutter) and rename `threshold` → `membership_threshold` / `membershipThreshold` everywhere.

**Architecture:** Flags follow the same pattern as trust declarations — stored in koinon.json, indexed by webhook into relational tables, queried via authenticated endpoints. The rename touches the PolisDefinition model, AGE graph, endpoints, and Flutter PolisInfo/PolisService.

**Tech Stack:** dart_koinon (freezed models), Serverpod 3.4.1 (spy.yaml models, endpoints), Flutter (cubit_ui_flow pattern), Apache AGE (Cypher queries)

---

### Task 1: Rename `threshold` → `membershipThreshold` in PolisDefinition model

**Files:**
- Modify: `achaean_server/lib/src/koinon/polis_definition.spy.yaml`

**Step 1: Rename field in spy.yaml**

Replace:
```yaml
  ### Membership threshold — mutual trust links required.
  threshold: int
```

With:
```yaml
  ### Membership threshold — mutual trust links required.
  membershipThreshold: int
  ### Flag threshold — number of flags before NSFW blur.
  flagThreshold: int
```

**Step 2: Run serverpod generate**

```bash
cd achaean_server && serverpod generate
```

**Step 3: Update all references to `threshold` → `membershipThreshold`**

In `achaean_server/lib/src/koinon/koinon_endpoint.dart`, replace all occurrences of `polis?.threshold ?? 1` with `polis?.membershipThreshold ?? 1` (two places: `getPolisMembers` and `getAgora`).

**Step 4: Update AgeGraph.upsertPolis**

In `achaean_server/lib/src/koinon/age_graph.dart`, rename the `threshold` parameter to `membershipThreshold` and update the Cypher property name:

Replace:
```dart
  static Future<void> upsertPolis(
    Session session,
    String repoUrl,
    int threshold,
  ) async {
    await _loadAge(session);
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MERGE (p:Polis {repo_url: '${_s(repoUrl)}'})"
      " SET p.threshold = $threshold"
      "\$\$) AS (v agtype)",
    );
  }
```

With:
```dart
  static Future<void> upsertPolis(
    Session session,
    String repoUrl,
    int membershipThreshold,
  ) async {
    await _loadAge(session);
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MERGE (p:Polis {repo_url: '${_s(repoUrl)}'})"
      " SET p.membership_threshold = $membershipThreshold"
      "\$\$) AS (v agtype)",
    );
  }
```

**Step 5: Verify compilation**

```bash
cd achaean_server && dart analyze
```

**Step 6: Commit**

```bash
git add achaean_server/ achaean_client/
git commit -m "refactor: rename threshold to membershipThreshold, add flagThreshold to PolisDefinition"
```

---

### Task 2: Rename `threshold` → `membershipThreshold` in Flutter

**Files:**
- Modify: `achaean_flutter/lib/core/models/polis_info.dart`
- Modify: `achaean_flutter/lib/features/polis/services/polis_service.dart`

**Step 1: Update PolisInfo model**

In `polis_info.dart`, replace:
```dart
    int? threshold,
```

With:
```dart
    int? membershipThreshold,
    int? flagThreshold,
```

**Step 2: Run build_runner**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

**Step 3: Update PolisService._parseYamlFrontmatter**

In `polis_service.dart`, in the `_parseYamlFrontmatter` method, replace:
```dart
      threshold: yaml['threshold'] as int?,
```

With:
```dart
      membershipThreshold: yaml['membership_threshold'] as int?,
      flagThreshold: yaml['flag_threshold'] as int?,
```

**Step 4: Update PolisService.createPolis**

In `polis_service.dart`, in `createPolis`, replace:
```dart
        if (threshold != null) frontmatter.writeln('threshold: $threshold');
```

With:
```dart
        if (threshold != null) frontmatter.writeln('membership_threshold: $threshold');
```

Note: The `createPolis` method parameter stays as `threshold` (it's the membership threshold at creation time). Only the YAML key changes.

**Step 5: Verify compilation**

```bash
cd achaean_flutter && flutter analyze
```

**Step 6: Commit**

```bash
git add achaean_flutter/
git commit -m "refactor: rename threshold to membershipThreshold in Flutter PolisInfo and PolisService"
```

---

### Task 3: Add `FlagEntry` model to `dart_koinon`

**Files:**
- Create: `dart_koinon/lib/src/models/flag_entry.dart`
- Modify: `dart_koinon/lib/src/models/koinon_manifest.dart`
- Modify: `dart_koinon/lib/dart_koinon.dart`

**Step 1: Create FlagEntry freezed model**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flag_entry.freezed.dart';
part 'flag_entry.g.dart';

/// An entry in the koinon.json flags array.
@freezed
class FlagEntry with _$FlagEntry {
  const factory FlagEntry({
    /// Path to the flagged post (e.g. "alice/koinon/posts/2026-03-09-take/post.json").
    required String post,

    /// Polis repo URL where this flag applies.
    required String polis,

    /// Free-form reason for flagging.
    required String reason,
  }) = _FlagEntry;

  factory FlagEntry.fromJson(Map<String, dynamic> json) =>
      _$FlagEntryFromJson(json);
}
```

**Step 2: Add flags field to KoinonManifest**

In `koinon_manifest.dart`, add import:
```dart
import 'flag_entry.dart';
```

Add field after `trust`:
```dart
    /// Post flags.
    @Default([]) List<FlagEntry> flags,
```

**Step 3: Export from barrel file**

Add to `dart_koinon/lib/dart_koinon.dart`:
```dart
export 'src/models/flag_entry.dart';
```

**Step 4: Run build_runner**

```bash
cd dart_koinon && dart run build_runner build --delete-conflicting-outputs
```

**Step 5: Verify**

```bash
cd dart_koinon && dart analyze
```

**Step 6: Commit**

```bash
git add dart_koinon/
git commit -m "feat(dart_koinon): add FlagEntry model, add flags array to KoinonManifest"
```

---

### Task 4: Add `FlagRecord` Serverpod model

**Files:**
- Create: `achaean_server/lib/src/koinon/flag_record.spy.yaml`

**Step 1: Create spy.yaml**

```yaml
### An indexed post flag — a moderation signal from a polis member.
class: FlagRecord
table: flag_records
fields:
  ### Public key of the flagger.
  flaggedByPubkey: String
  ### Public key of the post author.
  postAuthorPubkey: String
  ### Path to the flagged post file.
  postPath: String
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
    fields: flaggedByPubkey, postPath, polisRepoUrl
    unique: true
  flag_records_post_polis_idx:
    fields: postPath, polisRepoUrl
  flag_records_author_idx:
    fields: postAuthorPubkey
```

**Step 2: Run serverpod generate**

```bash
cd achaean_server && serverpod generate
```

**Step 3: Create migration**

```bash
cd achaean_server && serverpod create-migration
```

**Step 4: Verify**

```bash
cd achaean_server && dart analyze
```

**Step 5: Commit**

```bash
git add achaean_server/ achaean_client/
git commit -m "feat(server): add FlagRecord model with migration"
```

---

### Task 5: Update webhook to index flags from koinon.json

**Files:**
- Modify: `achaean_server/lib/src/koinon/webhook_endpoint.dart`

**Step 1: Add flag indexing to _indexManifest**

Inside the `session.db.transaction` block in `_indexManifest`, after the readme signatures section (after step 3), add:

```dart
      // 4. Replace flags
      await FlagRecord.db.deleteWhere(
        session,
        where: (t) => t.flaggedByPubkey.equals(pubkey),
        transaction: transaction,
      );

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

**Step 2: Update log message**

Update the log line at the end of `_indexManifest` to include flags count:

Replace:
```dart
      '${manifest.trust.length} trust, ${manifest.poleis.length} poleis',
```

With:
```dart
      '${manifest.trust.length} trust, ${manifest.poleis.length} poleis, '
      '${manifest.flags.length} flags',
```

**Step 3: Verify**

```bash
cd achaean_server && dart analyze
```

**Step 4: Commit**

```bash
git add achaean_server/
git commit -m "feat(server): index flags from koinon.json in webhook handler"
```

---

### Task 6: Add flag query endpoints

**Files:**
- Modify: `achaean_server/lib/src/koinon/koinon_endpoint.dart`

**Step 1: Add getFlagsForPolis endpoint**

After `getTrustDeclarations`, add:

```dart
  /// Get all flags for posts in a polis.
  Future<List<FlagRecord>> getFlagsForPolis(
    Session session,
    String polisRepoUrl,
  ) async {
    await KoinonAuth.verify(session);
    return await FlagRecord.db.find(
      session,
      where: (t) => t.polisRepoUrl.equals(polisRepoUrl),
    );
  }
```

**Step 2: Add getFlaggedPostsForVouchers endpoint**

After `getFlagsForPolis`, add:

```dart
  /// Get flags on posts by people the caller trusts.
  ///
  /// Uses the caller's pubkey (from auth) to find who they trust,
  /// then returns flags on posts authored by those trusted people.
  Future<List<FlagRecord>> getFlaggedPostsForVouchers(
    Session session,
  ) async {
    final callerPubkey = await KoinonAuth.verify(session);

    // Find who the caller trusts
    final trustDeclarations = await TrustDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(callerPubkey),
    );

    if (trustDeclarations.isEmpty) return [];

    final trustedPubkeys = trustDeclarations.map((t) => t.toPubkey).toSet();

    // Find flags on posts by people the caller trusts
    return await FlagRecord.db.find(
      session,
      where: (t) => t.postAuthorPubkey.inSet(trustedPubkeys),
    );
  }
```

**Step 3: Run serverpod generate**

```bash
cd achaean_server && serverpod generate
```

**Step 4: Verify**

```bash
cd achaean_server && dart analyze
```

**Step 5: Commit**

```bash
git add achaean_server/ achaean_client/
git commit -m "feat(server): add getFlagsForPolis and getFlaggedPostsForVouchers endpoints"
```

---

### Task 7: Add Flutter FlagService

**Files:**
- Create: `achaean_flutter/lib/core/exceptions/flag_exception.dart`
- Create: `achaean_flutter/lib/features/flag/services/i_flag_service.dart`
- Create: `achaean_flutter/lib/features/flag/services/flag_service.dart`

**Step 1: Create FlagException**

```dart
class FlagException implements Exception {
  final String message;
  final Object? cause;
  const FlagException(this.message, [this.cause]);
}
```

**Step 2: Create IFlagService interface**

```dart
import 'package:dart_koinon/dart_koinon.dart';

abstract class IFlagService {
  /// Flag a post in a polis. Adds FlagEntry to koinon.json.
  Future<void> flagPost({
    required String postPath,
    required String polisRepoUrl,
    required String reason,
  });

  /// Retract a flag. Removes matching FlagEntry from koinon.json.
  Future<void> retractFlag({
    required String postPath,
    required String polisRepoUrl,
  });

  /// Get own flags from koinon.json.
  Future<List<FlagEntry>> getOwnFlags();
}
```

**Step 3: Create FlagService implementation**

```dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/flag_exception.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/try_operation.dart';
import 'i_flag_service.dart';

class FlagService implements IFlagService {
  final IGitService _gitService;

  FlagService(this._gitService);

  @override
  Future<void> flagPost({
    required String postPath,
    required String polisRepoUrl,
    required String reason,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          FlagException.new,
        );
        const repo = 'koinon';

        // Read manifest
        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        // Check if already flagged
        if (manifest.flags.any(
            (f) => f.post == postPath && f.polis == polisRepoUrl)) {
          return; // Already flagged
        }

        final updated = manifest.copyWith(
          flags: [
            ...manifest.flags,
            FlagEntry(
              post: postPath,
              polis: polisRepoUrl,
              reason: reason,
            ),
          ],
        );

        final updatedJson =
            const JsonEncoder.withIndent('  ').convert(updated.toJson());
        await client.commitFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
          content: updatedJson,
          message: 'Flag post: $postPath in $polisRepoUrl',
          sha: manifestFile.sha,
        );
      },
      FlagException.new,
      'flagPost',
    );
  }

  @override
  Future<void> retractFlag({
    required String postPath,
    required String polisRepoUrl,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          FlagException.new,
        );
        const repo = 'koinon';

        // Read manifest
        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        final updated = manifest.copyWith(
          flags: manifest.flags
              .where((f) =>
                  !(f.post == postPath && f.polis == polisRepoUrl))
              .toList(),
        );

        final updatedJson =
            const JsonEncoder.withIndent('  ').convert(updated.toJson());
        await client.commitFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
          content: updatedJson,
          message: 'Retract flag: $postPath in $polisRepoUrl',
          sha: manifestFile.sha,
        );
      },
      FlagException.new,
      'retractFlag',
    );
  }

  @override
  Future<List<FlagEntry>> getOwnFlags() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          FlagException.new,
        );
        const repo = 'koinon';

        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        return manifest.flags;
      },
      FlagException.new,
      'getOwnFlags',
    );
  }
}
```

**Step 4: Verify**

```bash
cd achaean_flutter && flutter analyze lib/features/flag/ lib/core/exceptions/flag_exception.dart
```

**Step 5: Commit**

```bash
git add achaean_flutter/lib/features/flag/ achaean_flutter/lib/core/exceptions/flag_exception.dart
git commit -m "feat: add FlagService for flagging/retracting posts in koinon.json"
```

---

### Task 8: Add Flutter FlagCubit and state

**Files:**
- Create: `achaean_flutter/lib/features/flag/cubit/flag_state.dart`
- Create: `achaean_flutter/lib/features/flag/cubit/flag_cubit.dart`
- Create: `achaean_flutter/lib/features/flag/services/flag_message_mapper.dart`

**Step 1: Create FlagState**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flag_state.freezed.dart';

@freezed
abstract class FlagState with _$FlagState implements IUiFlowState {
  const FlagState._();
  const factory FlagState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<FlagEntry> flags,
  }) = _FlagState;

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

**Step 2: Create FlagCubit**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_flag_service.dart';
import 'flag_state.dart';

class FlagCubit extends AppCubit<FlagState> {
  final IFlagService _service;

  FlagCubit(this._service) : super(const FlagState());

  Future<void> flagPost({
    required String postPath,
    required String polisRepoUrl,
    required String reason,
  }) async {
    await tryOperation(
      () async {
        await _service.flagPost(
          postPath: postPath,
          polisRepoUrl: polisRepoUrl,
          reason: reason,
        );
        final flags = await _service.getOwnFlags();
        return state.copyWith(
          status: UiFlowStatus.success,
          flags: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> retractFlag({
    required String postPath,
    required String polisRepoUrl,
  }) async {
    await tryOperation(
      () async {
        await _service.retractFlag(
          postPath: postPath,
          polisRepoUrl: polisRepoUrl,
        );
        final flags = await _service.getOwnFlags();
        return state.copyWith(
          status: UiFlowStatus.success,
          flags: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadOwnFlags() async {
    await tryOperation(
      () async {
        final flags = await _service.getOwnFlags();
        return state.copyWith(
          status: UiFlowStatus.success,
          flags: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
```

**Step 3: Create FlagMessageMapper**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

@injectable
class FlagMessageMapper implements ISuccessMessageMapper {
  @override
  MessageKey? map(String operationName) {
    return switch (operationName) {
      'flagPost' => const MessageKey.success('flag.post.success'),
      'retractFlag' => const MessageKey.success('flag.retract.success'),
      _ => null,
    };
  }
}
```

**Step 4: Run build_runner**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

**Step 5: Verify**

```bash
cd achaean_flutter && flutter analyze
```

**Step 6: Commit**

```bash
git add achaean_flutter/lib/features/flag/
git commit -m "feat: add FlagCubit, FlagState, and FlagMessageMapper"
```

---

### Task 9: Wire up DI, exception mapper, and l10n

**Files:**
- Modify: `achaean_flutter/lib/app/bootstrap.dart`
- Modify: `achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart`
- Modify: `achaean_flutter/lib/l10n/app_en.arb`

**Step 1: Add DI registration in bootstrap.dart**

Add imports:
```dart
import '../core/exceptions/flag_exception.dart';
import '../features/flag/services/i_flag_service.dart';
import '../features/flag/services/flag_service.dart';
import '../features/flag/cubit/flag_cubit.dart';
```

Add in `_registerCoreServices()`, after the trust service:
```dart
  // Flag service
  getIt.registerLazySingleton<IFlagService>(
    () => FlagService(getIt<IGitService>()),
  );

  // Flag cubit
  getIt.registerFactory<FlagCubit>(
    () => FlagCubit(getIt<IFlagService>()),
  );
```

**Step 2: Add FlagException to exception mapper**

In `exception_mapper.dart`, add import:
```dart
import '../../core/exceptions/flag_exception.dart';
```

Add case after `PolisException`:
```dart
      FlagException() => const MessageKey.error('flag.error'),
```

**Step 3: Add l10n keys to app_en.arb**

Add these entries:
```json
  "flagPostSuccess": "Post flagged",
  "flagRetractSuccess": "Flag retracted",
  "flagError": "Failed to flag post"
```

**Step 4: Regenerate l10n**

```bash
cd achaean_flutter && flutter gen-l10n
```

**Step 5: Update l10n_key_resolver.g.dart**

Add the new keys to the resolver following existing pattern (add to resolve switch, knownKeys, arbToDotKey, dotToArbKey, L10nKeys).

**Step 6: Verify**

```bash
cd achaean_flutter && flutter analyze
```

**Step 7: Commit**

```bash
git add achaean_flutter/
git commit -m "feat: wire FlagService DI, exception mapper, and l10n keys"
```

---

### Task 10: Verify everything compiles

**Step 1: dart_koinon**

```bash
cd dart_koinon && dart run build_runner build --delete-conflicting-outputs && dart analyze
```

**Step 2: achaean_server**

```bash
cd achaean_server && dart analyze
```

**Step 3: achaean_flutter**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs && flutter analyze
```

**Step 4: Fix any issues and commit**

```bash
git add -A
git commit -m "chore: fix compilation across all packages"
```

---

## Implementation Order

```
Task 1   (rename threshold → membershipThreshold in server)    — no deps
Task 2   (rename threshold in Flutter)                          — no deps
Task 3   (FlagEntry model in dart_koinon)                       — no deps
Task 4   (FlagRecord spy.yaml + migration)                      — no deps
Task 5   (webhook flag indexing)                                — needs Task 3, 4
Task 6   (flag query endpoints)                                 — needs Task 4
Task 7   (Flutter FlagService)                                  — needs Task 3
Task 8   (Flutter FlagCubit + state)                           — needs Task 7
Task 9   (DI + exception mapper + l10n)                         — needs Task 7, 8
Task 10  (verify compilation)                                   — last
```

Tasks 1, 2, 3, 4 can proceed in parallel. Tasks 5, 6, 7 can proceed in parallel after deps. Tasks 8, 9 are sequential after 7.

---

## Critical Files to Reference

| File | What to reuse |
|------|---------------|
| `dart_koinon/lib/src/models/trust_entry.dart` | Pattern for FlagEntry freezed model |
| `dart_koinon/lib/src/models/koinon_manifest.dart` | Add flags field alongside trust |
| `achaean_server/lib/src/koinon/trust_declaration_record.spy.yaml` | Pattern for FlagRecord spy.yaml |
| `achaean_server/lib/src/koinon/webhook_endpoint.dart` | Add flag indexing to _indexManifest |
| `achaean_server/lib/src/koinon/koinon_endpoint.dart` | Add flag endpoints |
| `achaean_server/lib/src/koinon/polis_definition.spy.yaml` | Rename threshold + add flagThreshold |
| `achaean_flutter/lib/features/trust/services/trust_service.dart` | Pattern for FlagService (manifest updates) |
| `achaean_flutter/lib/features/trust/cubit/trust_cubit.dart` | Pattern for FlagCubit |
| `achaean_flutter/lib/features/trust/cubit/trust_state.dart` | Pattern for FlagState |
| `achaean_flutter/lib/core/models/polis_info.dart` | Rename threshold fields |
| `achaean_flutter/lib/app/bootstrap.dart` | DI registration pattern |
| `achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart` | Add FlagException mapping |
