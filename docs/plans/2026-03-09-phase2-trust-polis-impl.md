# Phase 2: Trust & Polis — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add trust declarations, polis management, and repo inspection services/cubits to the Flutter client (plumbing only, no screens).

**Architecture:** Extract a generic `ISigningService` from `PostSigningService`. Add `GitPublicAuth` to `dart_git` for unauthenticated public reads. Build three feature services (`ITrustService`, `IPolisService`, `IRepoInspectionService`) and their corresponding cubits, all using the established cubit UI flow pattern with `AppCubit`, `tryOperation`, freezed states, message mappers, and dot-notation l10n keys.

**Tech Stack:** Flutter, Dart, freezed, cubit_ui_flow, dart_git, dart_koinon, yaml (new dep), get_it/injectable

---

### Task 1: Add `GitPublicAuth` to `dart_git`

**Files:**
- Modify: `dart_git/lib/src/client/i_git_auth.dart`

**Step 1: Add `GitPublicAuth` class**

Append after `GitTokenAuth`:

```dart
/// No-auth strategy for reading public repos.
class GitPublicAuth implements IGitAuth {
  const GitPublicAuth();

  @override
  Map<String, String> get headers => {};
}
```

**Step 2: Verify export**

`i_git_auth.dart` is already exported via `dart_git/lib/dart_git.dart`. No barrel update needed.

**Step 3: Commit**

```bash
git add dart_git/lib/src/client/i_git_auth.dart
git commit -m "feat(dart_git): add GitPublicAuth for unauthenticated reads"
```

---

### Task 2: Add `yaml` dependency

**Files:**
- Modify: `achaean_flutter/pubspec.yaml`

**Step 1: Add dependency**

Under `dependencies:`, add `yaml: ^3.1.0`.

**Step 2: Run pub get**

```bash
cd achaean_flutter && flutter pub get
```

**Step 3: Commit**

```bash
git add achaean_flutter/pubspec.yaml achaean_flutter/pubspec.lock
git commit -m "chore: add yaml dependency for polis README parsing"
```

---

### Task 3: Add `TrustException` and `PolisException`

**Files:**
- Create: `achaean_flutter/lib/core/exceptions/trust_exception.dart`
- Create: `achaean_flutter/lib/core/exceptions/polis_exception.dart`

**Step 1: Create TrustException**

```dart
class TrustException implements Exception {
  final String message;
  final Object? cause;
  const TrustException(this.message, [this.cause]);

  @override
  String toString() => 'TrustException: $message';
}
```

**Step 2: Create PolisException**

```dart
class PolisException implements Exception {
  final String message;
  final Object? cause;
  const PolisException(this.message, [this.cause]);

  @override
  String toString() => 'PolisException: $message';
}
```

**Step 3: Commit**

```bash
git add achaean_flutter/lib/core/exceptions/trust_exception.dart achaean_flutter/lib/core/exceptions/polis_exception.dart
git commit -m "feat: add TrustException and PolisException"
```

---

### Task 4: New freezed models — `RepoIdentifier`, `PolisInfo`, `RepoInspectionResult`

**Files:**
- Create: `achaean_flutter/lib/core/models/repo_identifier.dart`
- Create: `achaean_flutter/lib/core/models/polis_info.dart`
- Create: `achaean_flutter/lib/core/models/repo_inspection_result.dart`

**Step 1: Create `RepoIdentifier`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_identifier.freezed.dart';
part 'repo_identifier.g.dart';

/// Value type for referring to any git repo.
@freezed
class RepoIdentifier with _$RepoIdentifier {
  const factory RepoIdentifier({
    required String baseUrl,
    required String owner,
    required String repo,
  }) = _RepoIdentifier;

  factory RepoIdentifier.fromJson(Map<String, dynamic> json) =>
      _$RepoIdentifierFromJson(json);
}
```

**Step 2: Create `PolisInfo`**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'polis_info.freezed.dart';
part 'polis_info.g.dart';

/// Parsed polis README YAML frontmatter.
@freezed
class PolisInfo with _$PolisInfo {
  const factory PolisInfo({
    required String name,
    String? description,
    String? norms,
    int? threshold,
    String? parentRepo,
  }) = _PolisInfo;

  factory PolisInfo.fromJson(Map<String, dynamic> json) =>
      _$PolisInfoFromJson(json);
}
```

**Step 3: Create `RepoInspectionResult`**

```dart
import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_inspection_result.freezed.dart';
part 'repo_inspection_result.g.dart';

/// Everything readable from a repo via public inspection.
@freezed
class RepoInspectionResult with _$RepoInspectionResult {
  const factory RepoInspectionResult({
    KoinonManifest? manifest,
    @Default([]) List<TrustDeclaration> trustDeclarations,
    @Default([]) List<ReadmeSignature> readmeSignatures,
    @Default([]) List<Post> posts,
  }) = _RepoInspectionResult;

  factory RepoInspectionResult.fromJson(Map<String, dynamic> json) =>
      _$RepoInspectionResultFromJson(json);
}
```

**Step 4: Run build_runner**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

**Step 5: Commit**

```bash
git add achaean_flutter/lib/core/models/
git commit -m "feat: add RepoIdentifier, PolisInfo, RepoInspectionResult models"
```

---

### Task 5: Extract `ISigningService` from `PostSigningService`

The design calls for a shared signing service that takes any JSON-serializable map, removes the `signature` key, signs canonical JSON bytes, and returns a base64url string. `PostSigningService` becomes a thin wrapper.

**Files:**
- Create: `achaean_flutter/lib/core/services/i_signing_service.dart`
- Create: `achaean_flutter/lib/core/services/signing_service.dart`
- Modify: `achaean_flutter/lib/features/post_creation/services/post_signing_service.dart`
- Modify: `achaean_flutter/lib/features/post_creation/services/i_post_signing_service.dart`

**Step 1: Create `ISigningService` interface**

```dart
/// Generic canonical-JSON signing service.
///
/// Takes any JSON map, removes the `signature` key, encodes to canonical JSON,
/// signs via IKeyService, and returns a base64url-encoded signature string.
abstract class ISigningService {
  /// Signs the given JSON map and returns the base64url-encoded signature.
  Future<String> sign(Map<String, dynamic> json);
}
```

**Step 2: Create `SigningService` implementation**

```dart
import 'dart:convert';
import 'dart:typed_data';

import '../exceptions/key_exception.dart';
import '../try_operation.dart';
import 'i_key_service.dart';
import 'i_signing_service.dart';

class SigningService implements ISigningService {
  final IKeyService _keyService;

  SigningService(this._keyService);

  @override
  Future<String> sign(Map<String, dynamic> json) {
    return tryMethod(
      () async {
        final map = Map<String, dynamic>.from(json)..remove('signature');
        final canonicalBytes =
            Uint8List.fromList(utf8.encode(jsonEncode(map)));
        final signatureBytes = await _keyService.signBytes(canonicalBytes);
        return base64Url.encode(signatureBytes).replaceAll('=', '');
      },
      KeyException.new,
      'sign',
    );
  }
}
```

**Step 3: Refactor `PostSigningService` to delegate to `ISigningService`**

Replace `achaean_flutter/lib/features/post_creation/services/post_signing_service.dart`:

```dart
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/services/i_signing_service.dart';
import 'i_post_signing_service.dart';

class PostSigningService implements IPostSigningService {
  final ISigningService _signingService;

  PostSigningService(this._signingService);

  @override
  Future<String> signPost(Post unsignedPost) {
    return _signingService.sign(unsignedPost.toJson());
  }
}
```

**Step 4: Update DI wiring in `bootstrap.dart`**

Add `ISigningService` registration before `IPostSigningService`:

```dart
// Signing service (shared canonical-JSON signer)
getIt.registerLazySingleton<ISigningService>(
  () => SigningService(getIt<IKeyService>()),
);

// Post signing service (delegates to ISigningService)
getIt.registerLazySingleton<IPostSigningService>(
  () => PostSigningService(getIt<ISigningService>()),
);
```

Remove old `PostSigningService(getIt<IKeyService>())` registration.

Add imports:
```dart
import '../core/services/i_signing_service.dart';
import '../core/services/signing_service.dart';
```

**Step 5: Verify build**

```bash
cd achaean_flutter && flutter analyze
```

**Step 6: Commit**

```bash
git add achaean_flutter/lib/core/services/i_signing_service.dart achaean_flutter/lib/core/services/signing_service.dart achaean_flutter/lib/features/post_creation/services/post_signing_service.dart achaean_flutter/lib/app/bootstrap.dart
git commit -m "refactor: extract ISigningService from PostSigningService"
```

---

### Task 6: `ITrustService` + `TrustService`

**Files:**
- Create: `achaean_flutter/lib/features/trust/services/i_trust_service.dart`
- Create: `achaean_flutter/lib/features/trust/services/trust_service.dart`

**Step 1: Create `ITrustService` interface**

```dart
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';

abstract class ITrustService {
  /// Declare trust for a subject. Commits trust/<subject-pubkey-prefix>.json.
  Future<void> declareTrust({
    required String subjectPubkey,
    required String subjectRepo,
    required TrustLevel level,
  });

  /// Revoke trust for a subject. Deletes the trust file.
  Future<void> revokeTrust({required String subjectName});

  /// List trust declarations from own repo.
  Future<List<TrustDeclaration>> getOwnTrustDeclarations();

  /// List trust declarations from any repo via public read.
  Future<List<TrustDeclaration>> getTrustDeclarations(RepoIdentifier repoId);
}
```

**Step 2: Create `TrustService` implementation**

```dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/trust_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_signing_service.dart';
import '../../../core/try_operation.dart';
import 'i_trust_service.dart';

/// Factory for creating read-only IGitClient instances for foreign repos.
typedef PublicGitClientFactory = IGitClient Function({
  required String baseUrl,
  required GitHostType hostType,
});

class TrustService implements ITrustService {
  final IGitService _gitService;
  final ISigningService _signingService;
  final PublicGitClientFactory _publicClientFactory;

  TrustService(this._gitService, this._signingService, this._publicClientFactory);

  @override
  Future<void> declareTrust({
    required String subjectPubkey,
    required String subjectRepo,
    required TrustLevel level,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          TrustException.new,
        );
        const repo = 'koinon';
        final now = DateTime.now().toUtc();

        // Build unsigned trust declaration
        final unsigned = TrustDeclaration(
          subject: subjectPubkey,
          repo: subjectRepo,
          level: level,
          timestamp: now,
          signature: '',
        );

        // Sign
        final signature = await _signingService.sign(unsigned.toJson());
        final signed = unsigned.copyWith(signature: signature);

        // Use first 16 chars of pubkey as filename
        final fileName = subjectPubkey.length >= 16
            ? subjectPubkey.substring(0, 16)
            : subjectPubkey;
        final path = 'trust/$fileName.json';

        // Check if file exists (need sha for update)
        String? sha;
        try {
          final existing = await client.readFile(
            owner: owner,
            repo: repo,
            path: path,
          );
          sha = existing.sha;
        } on GitNotFoundException {
          // New trust declaration
        }

        final json =
            const JsonEncoder.withIndent('  ').convert(signed.toJson());

        await client.commitFile(
          owner: owner,
          repo: repo,
          path: path,
          content: json,
          message: 'Trust: ${level.name} $fileName',
          sha: sha,
        );
      },
      TrustException.new,
      'declareTrust',
    );
  }

  @override
  Future<void> revokeTrust({required String subjectName}) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          TrustException.new,
        );
        const repo = 'koinon';
        final path = 'trust/$subjectName.json';

        final file = await client.readFile(
          owner: owner,
          repo: repo,
          path: path,
        );

        await client.deleteFile(
          owner: owner,
          repo: repo,
          path: path,
          sha: file.sha,
          message: 'Revoke trust: $subjectName',
        );
      },
      TrustException.new,
      'revokeTrust',
    );
  }

  @override
  Future<List<TrustDeclaration>> getOwnTrustDeclarations() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          TrustException.new,
        );
        return _readTrustDir(client, owner, 'koinon');
      },
      TrustException.new,
      'getOwnTrustDeclarations',
    );
  }

  @override
  Future<List<TrustDeclaration>> getTrustDeclarations(
      RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          TrustException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        return _readTrustDir(client, repoId.owner, repoId.repo);
      },
      TrustException.new,
      'getTrustDeclarations',
    );
  }

  Future<List<TrustDeclaration>> _readTrustDir(
    IGitClient client,
    String owner,
    String repo,
  ) async {
    List<GitDirectoryEntry> entries;
    try {
      entries = await client.listFiles(
        owner: owner,
        repo: repo,
        path: 'trust',
      );
    } on GitNotFoundException {
      return [];
    }

    final declarations = <TrustDeclaration>[];
    for (final entry in entries) {
      if (entry.name == '.gitkeep' || !entry.name.endsWith('.json')) continue;
      try {
        final file = await client.readFile(
          owner: owner,
          repo: repo,
          path: entry.path,
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        declarations.add(TrustDeclaration.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    return declarations;
  }
}
```

**Step 3: Commit**

```bash
git add achaean_flutter/lib/features/trust/
git commit -m "feat: add ITrustService and TrustService"
```

---

### Task 7: `IPolisService` + `PolisService`

**Files:**
- Create: `achaean_flutter/lib/features/polis/services/i_polis_service.dart`
- Create: `achaean_flutter/lib/features/polis/services/polis_service.dart`

**Step 1: Create `IPolisService` interface**

```dart
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/polis_info.dart';
import '../../../core/models/repo_identifier.dart';

abstract class IPolisService {
  /// Create a new polis. Creates the repo, commits README with YAML frontmatter,
  /// signs README, commits signature to own repo, updates koinon.json.
  Future<RepoIdentifier> createPolis({
    required String name,
    String? description,
    String? norms,
    int? threshold,
  });

  /// Join a polis. Reads polis README, signs it, commits signature to own repo,
  /// updates koinon.json.
  Future<void> joinPolis(RepoIdentifier repoId);

  /// Leave a polis. Deletes signature file, updates koinon.json.
  Future<void> leavePolis(RepoIdentifier repoId);

  /// Read and parse polis README frontmatter.
  Future<PolisInfo> getPolisInfo(RepoIdentifier repoId);

  /// List own poleis from koinon.json.
  Future<List<PolisMembership>> getOwnPoleis();
}
```

**Step 2: Create `PolisService` implementation**

```dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:yaml/yaml.dart';

import '../../../core/exceptions/polis_exception.dart';
import '../../../core/models/polis_info.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_key_service.dart';
import '../../../core/services/i_signing_service.dart';
import '../../../core/try_operation.dart';
import '../../trust/services/trust_service.dart';
import 'i_polis_service.dart';

class PolisService implements IPolisService {
  final IGitService _gitService;
  final ISigningService _signingService;
  final IKeyService _keyService;
  final PublicGitClientFactory _publicClientFactory;

  PolisService(
    this._gitService,
    this._signingService,
    this._keyService,
    this._publicClientFactory,
  );

  @override
  Future<RepoIdentifier> createPolis({
    required String name,
    String? description,
    String? norms,
    int? threshold,
  }) {
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

        // Slugify polis name for repo
        final repoName = 'polis-${name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), '')}';

        // 1. Create polis repo
        await client.createRepo(name: repoName);

        // 2. Build README with YAML frontmatter
        final frontmatter = StringBuffer('---\n');
        frontmatter.writeln('name: "$name"');
        if (description != null) frontmatter.writeln('description: "$description"');
        if (norms != null) frontmatter.writeln('norms: "$norms"');
        if (threshold != null) frontmatter.writeln('threshold: $threshold');
        frontmatter.writeln('---\n');
        frontmatter.writeln('# $name');
        if (description != null) frontmatter.writeln('\n$description');

        final readmeContent = frontmatter.toString();

        // 3. Commit README
        final readmeCommit = await client.commitFile(
          owner: owner,
          repo: repoName,
          path: 'README.md',
          content: readmeContent,
          message: 'Initialize polis: $name',
        );

        // 4. Sign README → commit signature to own koinon repo
        final readmeHash = _computeContentHash(readmeContent);
        final repoId = RepoIdentifier(
          baseUrl: baseUrl,
          owner: owner,
          repo: repoName,
        );
        final repoIdString = '${repoId.owner}/${repoId.repo}';

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
          message: 'Sign polis README: $name',
        );

        // 5. Update koinon.json poleis list
        await _addPolisToManifest(client, owner, repoIdString, name);

        return repoId;
      },
      PolisException.new,
      'createPolis',
    );
  }

  @override
  Future<void> joinPolis(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PolisException.new,
        );
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          PolisException.new,
        );

        // 1. Read polis README via public client
        final publicClient = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        final readmeFile = await publicClient.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: 'README.md',
        );

        // 2. Get the commit sha for the README
        // Use the file sha as a proxy for content version
        final readmeHash = _computeContentHash(readmeFile.content);
        final repoIdString = '${repoId.owner}/${repoId.repo}';

        // 3. Sign README
        final readmeSig = ReadmeSignature(
          polis: repoIdString,
          readmeCommit: readmeFile.sha,
          readmeHash: readmeHash,
          timestamp: DateTime.now().toUtc(),
          signature: '',
        );
        final signature = await _signingService.sign(readmeSig.toJson());
        final signedSig = readmeSig.copyWith(signature: signature);

        // 4. Commit signature to own repo
        final sigPath = 'poleis/$repoIdString/signature.json';
        final sigJson =
            const JsonEncoder.withIndent('  ').convert(signedSig.toJson());

        // Check if already exists (re-joining)
        String? existingSha;
        try {
          final existing = await client.readFile(
            owner: owner,
            repo: 'koinon',
            path: sigPath,
          );
          existingSha = existing.sha;
        } on GitNotFoundException {
          // New join
        }

        await client.commitFile(
          owner: owner,
          repo: 'koinon',
          path: sigPath,
          content: sigJson,
          message: 'Join polis: $repoIdString',
          sha: existingSha,
        );

        // 5. Parse polis name from README frontmatter
        final info = _parseYamlFrontmatter(readmeFile.content);

        // 6. Update koinon.json
        await _addPolisToManifest(client, owner, repoIdString, info.name);
      },
      PolisException.new,
      'joinPolis',
    );
  }

  @override
  Future<void> leavePolis(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PolisException.new,
        );
        final repoIdString = '${repoId.owner}/${repoId.repo}';

        // 1. Delete signature file
        final sigPath = 'poleis/$repoIdString/signature.json';
        final file = await client.readFile(
          owner: owner,
          repo: 'koinon',
          path: sigPath,
        );
        await client.deleteFile(
          owner: owner,
          repo: 'koinon',
          path: sigPath,
          sha: file.sha,
          message: 'Leave polis: $repoIdString',
        );

        // 2. Update koinon.json — remove polis entry
        await _removePolisFromManifest(client, owner, repoIdString);
      },
      PolisException.new,
      'leavePolis',
    );
  }

  @override
  Future<PolisInfo> getPolisInfo(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          PolisException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );

        final readmeFile = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: 'README.md',
        );

        return _parseYamlFrontmatter(readmeFile.content);
      },
      PolisException.new,
      'getPolisInfo',
    );
  }

  @override
  Future<List<PolisMembership>> getOwnPoleis() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PolisException.new,
        );

        final file = await client.readFile(
          owner: owner,
          repo: 'koinon',
          path: '.well-known/koinon.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(json);
        return manifest.poleis;
      },
      PolisException.new,
      'getOwnPoleis',
    );
  }

  // --- Private helpers ---

  PolisInfo _parseYamlFrontmatter(String readmeContent) {
    final lines = readmeContent.split('\n');
    if (lines.isEmpty || lines.first.trim() != '---') {
      throw const PolisException('README has no YAML frontmatter');
    }

    final endIndex = lines.indexWhere(
      (l) => l.trim() == '---',
      1, // skip opening ---
    );
    if (endIndex == -1) {
      throw const PolisException('README frontmatter not closed');
    }

    final yamlStr = lines.sublist(1, endIndex).join('\n');
    final yaml = loadYaml(yamlStr) as YamlMap;

    return PolisInfo(
      name: yaml['name'] as String? ?? 'Unknown',
      description: yaml['description'] as String?,
      norms: yaml['norms'] as String?,
      threshold: yaml['threshold'] as int?,
      parentRepo: yaml['parent_repo'] as String?,
    );
  }

  String _computeContentHash(String content) {
    // Simple content hash using dart:convert — SHA not needed for content versioning,
    // just a deterministic fingerprint. Use base64 of UTF-8 bytes.
    return base64Url.encode(utf8.encode(content)).replaceAll('=', '');
  }

  Future<void> _addPolisToManifest(
    IGitClient client,
    String owner,
    String repoIdString,
    String polisName,
  ) async {
    final manifestFile = await client.readFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
    );
    final manifestJson =
        jsonDecode(manifestFile.content) as Map<String, dynamic>;
    final manifest = KoinonManifest.fromJson(manifestJson);

    // Check if already a member
    if (manifest.poleis.any((p) => p.repo == repoIdString)) return;

    final updated = manifest.copyWith(
      poleis: [
        ...manifest.poleis,
        PolisMembership(
          repo: repoIdString,
          name: polisName,
          stars: 1,
          role: 'member',
        ),
      ],
    );

    final updatedJson =
        const JsonEncoder.withIndent('  ').convert(updated.toJson());
    await client.commitFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
      content: updatedJson,
      message: 'Add polis membership: $polisName',
      sha: manifestFile.sha,
    );
  }

  Future<void> _removePolisFromManifest(
    IGitClient client,
    String owner,
    String repoIdString,
  ) async {
    final manifestFile = await client.readFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
    );
    final manifestJson =
        jsonDecode(manifestFile.content) as Map<String, dynamic>;
    final manifest = KoinonManifest.fromJson(manifestJson);

    final updated = manifest.copyWith(
      poleis: manifest.poleis.where((p) => p.repo != repoIdString).toList(),
    );

    final updatedJson =
        const JsonEncoder.withIndent('  ').convert(updated.toJson());
    await client.commitFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
      content: updatedJson,
      message: 'Remove polis membership: $repoIdString',
      sha: manifestFile.sha,
    );
  }
}
```

**Step 3: Commit**

```bash
git add achaean_flutter/lib/features/polis/
git commit -m "feat: add IPolisService and PolisService"
```

---

### Task 8: `IRepoInspectionService` + `RepoInspectionService`

**Files:**
- Create: `achaean_flutter/lib/features/inspection/services/i_repo_inspection_service.dart`
- Create: `achaean_flutter/lib/features/inspection/services/repo_inspection_service.dart`

**Step 1: Create `IRepoInspectionService` interface**

```dart
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../core/models/repo_inspection_result.dart';

abstract class IRepoInspectionService {
  /// Inspect a repo: read manifest, trust declarations, polis signatures, posts.
  Future<RepoInspectionResult> inspect(RepoIdentifier repoId);

  /// Read and parse the koinon manifest from any repo.
  Future<KoinonManifest> getManifest(RepoIdentifier repoId);
}
```

**Step 2: Create `RepoInspectionService` implementation**

```dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/trust_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/models/repo_inspection_result.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/try_operation.dart';
import '../../trust/services/trust_service.dart';
import 'i_repo_inspection_service.dart';

class RepoInspectionService implements IRepoInspectionService {
  final IGitService _gitService;
  final PublicGitClientFactory _publicClientFactory;

  RepoInspectionService(this._gitService, this._publicClientFactory);

  @override
  Future<RepoInspectionResult> inspect(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          TrustException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );

        // Read manifest
        KoinonManifest? manifest;
        try {
          final manifestFile = await client.readFile(
            owner: repoId.owner,
            repo: repoId.repo,
            path: '.well-known/koinon.json',
          );
          final json =
              jsonDecode(manifestFile.content) as Map<String, dynamic>;
          manifest = KoinonManifest.fromJson(json);
        } on GitNotFoundException {
          // No manifest
        }

        // Read trust declarations
        final trustDeclarations = await _readTrustDir(client, repoId);

        // Read polis signatures
        final readmeSignatures =
            await _readPolisSignatures(client, repoId);

        // Read posts
        final posts = await _readPosts(client, repoId);

        return RepoInspectionResult(
          manifest: manifest,
          trustDeclarations: trustDeclarations,
          readmeSignatures: readmeSignatures,
          posts: posts,
        );
      },
      TrustException.new,
      'inspect',
    );
  }

  @override
  Future<KoinonManifest> getManifest(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          TrustException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: '.well-known/koinon.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        return KoinonManifest.fromJson(json);
      },
      TrustException.new,
      'getManifest',
    );
  }

  Future<List<TrustDeclaration>> _readTrustDir(
    IGitClient client,
    RepoIdentifier repoId,
  ) async {
    List<GitDirectoryEntry> entries;
    try {
      entries = await client.listFiles(
        owner: repoId.owner,
        repo: repoId.repo,
        path: 'trust',
      );
    } on GitNotFoundException {
      return [];
    }

    final declarations = <TrustDeclaration>[];
    for (final entry in entries) {
      if (entry.name == '.gitkeep' || !entry.name.endsWith('.json')) continue;
      try {
        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: entry.path,
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        declarations.add(TrustDeclaration.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    return declarations;
  }

  Future<List<ReadmeSignature>> _readPolisSignatures(
    IGitClient client,
    RepoIdentifier repoId,
  ) async {
    List<GitDirectoryEntry> poleisDirs;
    try {
      poleisDirs = await client.listFiles(
        owner: repoId.owner,
        repo: repoId.repo,
        path: 'poleis',
      );
    } on GitNotFoundException {
      return [];
    }

    final signatures = <ReadmeSignature>[];
    for (final dir in poleisDirs) {
      if (dir.type != GitEntryType.dir) continue;
      try {
        // poleis/<owner>/<repo>/signature.json — need to traverse two levels
        final subDirs = await client.listFiles(
          owner: repoId.owner,
          repo: repoId.repo,
          path: dir.path,
        );
        for (final subDir in subDirs) {
          if (subDir.type == GitEntryType.dir) {
            // This is poleis/<owner>/<repo>/ — read signature.json
            try {
              final file = await client.readFile(
                owner: repoId.owner,
                repo: repoId.repo,
                path: '${subDir.path}/signature.json',
              );
              final json =
                  jsonDecode(file.content) as Map<String, dynamic>;
              signatures.add(ReadmeSignature.fromJson(json));
            } catch (_) {
              continue;
            }
          } else if (subDir.name == 'signature.json') {
            // poleis/<repo-id>/signature.json (flat structure)
            try {
              final file = await client.readFile(
                owner: repoId.owner,
                repo: repoId.repo,
                path: subDir.path,
              );
              final json =
                  jsonDecode(file.content) as Map<String, dynamic>;
              signatures.add(ReadmeSignature.fromJson(json));
            } catch (_) {
              continue;
            }
          }
        }
      } catch (_) {
        continue;
      }
    }
    return signatures;
  }

  Future<List<Post>> _readPosts(
    IGitClient client,
    RepoIdentifier repoId,
  ) async {
    List<GitDirectoryEntry> entries;
    try {
      entries = await client.listFiles(
        owner: repoId.owner,
        repo: repoId.repo,
        path: 'posts',
      );
    } on GitNotFoundException {
      return [];
    }

    final posts = <Post>[];
    for (final entry in entries) {
      if (entry.type != GitEntryType.dir || entry.name == '.gitkeep') continue;
      try {
        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: '${entry.path}/post.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        posts.add(Post.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return posts;
  }
}
```

**Step 3: Commit**

```bash
git add achaean_flutter/lib/features/inspection/
git commit -m "feat: add IRepoInspectionService and RepoInspectionService"
```

---

### Task 9: Trust Cubit (with cubit UI flow)

**Files:**
- Create: `achaean_flutter/lib/features/trust/cubit/trust_state.dart`
- Create: `achaean_flutter/lib/features/trust/cubit/trust_cubit.dart`
- Create: `achaean_flutter/lib/features/trust/services/trust_message_mapper.dart`

**Step 1: Create `TrustState`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trust_state.freezed.dart';

@freezed
abstract class TrustState with _$TrustState implements IUiFlowState {
  const TrustState._();
  const factory TrustState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<TrustDeclaration> declarations,
  }) = _TrustState;

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

**Step 2: Create `TrustCubit`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_trust_service.dart';
import 'trust_state.dart';

class TrustCubit extends AppCubit<TrustState> {
  final ITrustService _service;

  TrustCubit(this._service) : super(const TrustState());

  Future<void> declareTrust({
    required String subjectPubkey,
    required String subjectRepo,
    required TrustLevel level,
  }) async {
    await tryOperation(
      () async {
        await _service.declareTrust(
          subjectPubkey: subjectPubkey,
          subjectRepo: subjectRepo,
          level: level,
        );
        // Reload own trust after declaring
        final declarations = await _service.getOwnTrustDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> revokeTrust({required String subjectName}) async {
    await tryOperation(
      () async {
        await _service.revokeTrust(subjectName: subjectName);
        final declarations = await _service.getOwnTrustDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadOwnTrust() async {
    await tryOperation(
      () async {
        final declarations = await _service.getOwnTrustDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadTrustFor(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        final declarations = await _service.getTrustDeclarations(repoId);
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
```

**Step 3: Create `TrustMessageMapper`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/trust_state.dart';

@injectable
class TrustMessageMapper implements IStateMessageMapper<TrustState> {
  @override
  MessageKey? map(TrustState state) {
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('trust.declaration.success');
    }
    return null;
  }
}
```

**Step 4: Run build_runner**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

**Step 5: Commit**

```bash
git add achaean_flutter/lib/features/trust/
git commit -m "feat: add TrustCubit, TrustState, and TrustMessageMapper"
```

---

### Task 10: Polis Cubit (with cubit UI flow)

**Files:**
- Create: `achaean_flutter/lib/features/polis/cubit/polis_state.dart`
- Create: `achaean_flutter/lib/features/polis/cubit/polis_cubit.dart`
- Create: `achaean_flutter/lib/features/polis/services/polis_message_mapper.dart`

**Step 1: Create `PolisState`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/repo_identifier.dart';

part 'polis_state.freezed.dart';

@freezed
abstract class PolisState with _$PolisState implements IUiFlowState {
  const PolisState._();
  const factory PolisState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<PolisMembership> poleis,
    RepoIdentifier? createdPolis,
  }) = _PolisState;

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

**Step 2: Create `PolisCubit`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_polis_service.dart';
import 'polis_state.dart';

class PolisCubit extends AppCubit<PolisState> {
  final IPolisService _service;

  PolisCubit(this._service) : super(const PolisState());

  Future<void> createPolis({
    required String name,
    String? description,
    String? norms,
    int? threshold,
  }) async {
    await tryOperation(
      () async {
        final repoId = await _service.createPolis(
          name: name,
          description: description,
          norms: norms,
          threshold: threshold,
        );
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          createdPolis: repoId,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> joinPolis(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        await _service.joinPolis(repoId);
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> leavePolis(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        await _service.leavePolis(repoId);
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadOwnPoleis() async {
    await tryOperation(
      () async {
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
```

**Step 3: Create `PolisMessageMapper`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/polis_state.dart';

@injectable
class PolisMessageMapper implements IStateMessageMapper<PolisState> {
  @override
  MessageKey? map(PolisState state) {
    if (state.status == UiFlowStatus.success && state.createdPolis != null) {
      return const MessageKey.success('polis.creation.success');
    }
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('polis.operation.success');
    }
    return null;
  }
}
```

**Step 4: Run build_runner**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

**Step 5: Commit**

```bash
git add achaean_flutter/lib/features/polis/
git commit -m "feat: add PolisCubit, PolisState, and PolisMessageMapper"
```

---

### Task 11: Repo Inspection Cubit (with cubit UI flow)

**Files:**
- Create: `achaean_flutter/lib/features/inspection/cubit/repo_inspection_state.dart`
- Create: `achaean_flutter/lib/features/inspection/cubit/repo_inspection_cubit.dart`
- Create: `achaean_flutter/lib/features/inspection/services/inspection_message_mapper.dart`

**Step 1: Create `RepoInspectionState`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/repo_inspection_result.dart';

part 'repo_inspection_state.freezed.dart';

@freezed
abstract class RepoInspectionState with _$RepoInspectionState implements IUiFlowState {
  const RepoInspectionState._();
  const factory RepoInspectionState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    RepoInspectionResult? result,
  }) = _RepoInspectionState;

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

**Step 2: Create `RepoInspectionCubit`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_repo_inspection_service.dart';
import 'repo_inspection_state.dart';

class RepoInspectionCubit extends AppCubit<RepoInspectionState> {
  final IRepoInspectionService _service;

  RepoInspectionCubit(this._service) : super(const RepoInspectionState());

  Future<void> inspect(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        final result = await _service.inspect(repoId);
        return state.copyWith(
          status: UiFlowStatus.success,
          result: result,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
```

**Step 3: Create `InspectionMessageMapper`**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/repo_inspection_state.dart';

@injectable
class InspectionMessageMapper
    implements IStateMessageMapper<RepoInspectionState> {
  @override
  MessageKey? map(RepoInspectionState state) {
    if (state.status == UiFlowStatus.success && state.result != null) {
      return const MessageKey.success('inspection.complete');
    }
    return null;
  }
}
```

**Step 4: Run build_runner**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

**Step 5: Commit**

```bash
git add achaean_flutter/lib/features/inspection/
git commit -m "feat: add RepoInspectionCubit, RepoInspectionState, and InspectionMessageMapper"
```

---

### Task 12: Localization — add l10n keys

**Files:**
- Modify: `achaean_flutter/lib/l10n/app_en.arb`

**Step 1: Add Phase 2 l10n keys**

Add these entries before the closing `}`:

```json
  "trustDeclarationSuccess": "Trust declared successfully",
  "trustDeclarationError": "Failed to declare trust",
  "trustRevocationSuccess": "Trust revoked",
  "polisCreationSuccess": "Polis created successfully",
  "polisCreationError": "Failed to create polis",
  "polisOperationSuccess": "Polis operation completed",
  "polisOperationError": "Failed to complete polis operation",
  "inspectionComplete": "Repo inspection complete",
  "inspectionError": "Failed to inspect repo"
```

**Step 2: Regenerate l10n**

```bash
cd achaean_flutter && flutter gen-l10n
```

**Step 3: Commit**

```bash
git add achaean_flutter/lib/l10n/
git commit -m "feat: add Phase 2 l10n keys for trust, polis, inspection"
```

---

### Task 13: Exception mapper — add Phase 2 cases

**Files:**
- Modify: `achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart`

**Step 1: Add imports and switch cases**

Add imports:
```dart
import '../../core/exceptions/trust_exception.dart';
import '../../core/exceptions/polis_exception.dart';
```

Add cases before `GitUnauthorizedException()`:
```dart
TrustException() => const MessageKey.error('trust.declaration.error'),
PolisException() => const MessageKey.error('polis.operation.error'),
```

**Step 2: Commit**

```bash
git add achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart
git commit -m "feat: add TrustException and PolisException to exception mapper"
```

---

### Task 14: DI Wiring — register Phase 2 services and cubits

**Files:**
- Modify: `achaean_flutter/lib/app/bootstrap.dart`

**Step 1: Add imports**

```dart
import '../core/services/i_signing_service.dart';
import '../core/services/signing_service.dart';
import '../features/trust/services/i_trust_service.dart';
import '../features/trust/services/trust_service.dart';
import '../features/trust/cubit/trust_cubit.dart';
import '../features/polis/services/i_polis_service.dart';
import '../features/polis/services/polis_service.dart';
import '../features/polis/cubit/polis_cubit.dart';
import '../features/inspection/services/i_repo_inspection_service.dart';
import '../features/inspection/services/repo_inspection_service.dart';
import '../features/inspection/cubit/repo_inspection_cubit.dart';
```

**Step 2: Register `PublicGitClientFactory`**

In `_registerCoreServices()`, after the existing `GitClientFactory` registration, add:

```dart
// Public (unauthenticated) git client factory for reading foreign repos
getIt.registerSingleton<PublicGitClientFactory>(({
  required String baseUrl,
  required GitHostType hostType,
}) {
  return getIt<GitClientFactory>()(
    baseUrl: baseUrl,
    auth: const GitPublicAuth(),
    hostType: hostType,
  );
});
```

**Step 3: Register Phase 2 services**

After existing service registrations, add:

```dart
// Signing service (shared canonical-JSON signer) — if not already added in Task 5
getIt.registerLazySingleton<ISigningService>(
  () => SigningService(getIt<IKeyService>()),
);

// Trust service
getIt.registerLazySingleton<ITrustService>(
  () => TrustService(
    getIt<IGitService>(),
    getIt<ISigningService>(),
    getIt<PublicGitClientFactory>(),
  ),
);

// Polis service
getIt.registerLazySingleton<IPolisService>(
  () => PolisService(
    getIt<IGitService>(),
    getIt<ISigningService>(),
    getIt<IKeyService>(),
    getIt<PublicGitClientFactory>(),
  ),
);

// Repo inspection service
getIt.registerLazySingleton<IRepoInspectionService>(
  () => RepoInspectionService(
    getIt<IGitService>(),
    getIt<PublicGitClientFactory>(),
  ),
);
```

**Step 4: Register Phase 2 cubits**

```dart
// Phase 2 cubits (factory — new instance per use)
getIt.registerFactory<TrustCubit>(
  () => TrustCubit(getIt<ITrustService>()),
);
getIt.registerFactory<PolisCubit>(
  () => PolisCubit(getIt<IPolisService>()),
);
getIt.registerFactory<RepoInspectionCubit>(
  () => RepoInspectionCubit(getIt<IRepoInspectionService>()),
);
```

**Step 5: Commit**

```bash
git add achaean_flutter/lib/app/bootstrap.dart
git commit -m "feat: wire Phase 2 services and cubits in DI"
```

---

### Task 15: Run build_runner + flutter analyze

**Step 1: Run code generation**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs
```

Expected: All `.freezed.dart` and `.g.dart` files generate successfully.

**Step 2: Run analyzer**

```bash
cd achaean_flutter && flutter analyze
```

Expected: No analysis errors. Fix any issues found.

**Step 3: Regenerate l10n if needed**

```bash
cd achaean_flutter && flutter gen-l10n
```

**Step 4: Commit generated files**

```bash
git add -A achaean_flutter/
git commit -m "chore: regenerate freezed/injectable/l10n for Phase 2"
```

---

## Implementation Order

```
Task 1   (GitPublicAuth)           — no deps
Task 2   (yaml dep)                — no deps
Task 3   (exceptions)              — no deps
Task 4   (models)                  — no deps, needs build_runner
Task 5   (ISigningService)         — needs IKeyService (exists)
Task 6   (TrustService)            — needs Task 3, 4, 5
Task 7   (PolisService)            — needs Task 2, 3, 4, 5, 6 (PublicGitClientFactory typedef)
Task 8   (RepoInspectionService)   — needs Task 4, 6 (PublicGitClientFactory typedef)
Task 9   (TrustCubit)              — needs Task 6
Task 10  (PolisCubit)              — needs Task 7
Task 11  (RepoInspectionCubit)     — needs Task 8
Task 12  (l10n)                    — no deps
Task 13  (exception mapper)        — needs Task 3
Task 14  (DI wiring)               — needs all services/cubits
Task 15  (build + analyze)         — last
```

Tasks 1-4, 12 can proceed in parallel. Tasks 6-8 can proceed in parallel after Task 5. Tasks 9-11 can proceed in parallel after their service deps.

---

## Critical Files to Reference

| File | What to reuse |
|------|---------------|
| `achaean_flutter/lib/core/try_operation.dart` | `tryMethod()`, `requireNonNull()` |
| `achaean_flutter/lib/support/extensions/cubit_ui_flow_extension.dart` | `AppCubit<S>` base class |
| `achaean_flutter/lib/features/post_creation/services/post_creation_service.dart` | Service pattern with tryMethod |
| `achaean_flutter/lib/features/post_creation/cubit/post_creation_cubit.dart` | Cubit pattern with tryOperation |
| `achaean_flutter/lib/features/post_creation/cubit/post_creation_state.dart` | Freezed state with IUiFlowState |
| `achaean_flutter/lib/features/post_creation/services/post_creation_message_mapper.dart` | Message mapper pattern |
| `achaean_flutter/lib/app/bootstrap.dart` | DI registration pattern |
| `achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart` | Exception → MessageKey mapping |
| `dart_git/lib/src/client/i_git_client.dart` | IGitClient interface |
| `dart_git/lib/src/client/i_git_auth.dart` | IGitAuth + GitTokenAuth |
| `dart_koinon/lib/src/models/trust_declaration.dart` | TrustDeclaration model |
| `dart_koinon/lib/src/models/readme_signature.dart` | ReadmeSignature model |
| `dart_koinon/lib/src/models/koinon_manifest.dart` | KoinonManifest model |
