# Serverpod Indexing & Membership Computation — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Complete Serverpod as a functional aggregator — webhook indexing from `koinon.json`, Apache AGE trust graph, membership computation, and stateless keypair-signed request auth.

**Architecture:** Webhook reads `koinon.json` (single file = full state) and atomically replaces relational rows + AGE graph edges. Query endpoints are authenticated via ECDSA-signed timestamps (stateless, no accounts). AGE Cypher queries compute polis membership from trust graph traversal.

**Tech Stack:** Serverpod 3.4.1, PostgreSQL, Apache AGE, dart_git, dart_koinon, anonaccount_server (CryptoUtils for ECDSA verification)

---

### Task 1: Add `TrustEntry` model and `trust` field to `KoinonManifest` in `dart_koinon`

**Files:**
- Create: `dart_koinon/lib/src/models/trust_entry.dart`
- Modify: `dart_koinon/lib/src/models/koinon_manifest.dart`
- Modify: `dart_koinon/lib/dart_koinon.dart`

**Step 1: Create `TrustEntry` model**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

import 'trust_level.dart';

part 'trust_entry.freezed.dart';
part 'trust_entry.g.dart';

/// An entry in the koinon.json trust array.
@freezed
class TrustEntry with _$TrustEntry {
  const factory TrustEntry({
    /// Subject's public key.
    required String subject,

    /// Subject's repo URL.
    required String repo,

    /// Trust level.
    required TrustLevel level,
  }) = _TrustEntry;

  factory TrustEntry.fromJson(Map<String, dynamic> json) =>
      _$TrustEntryFromJson(json);
}
```

**Step 2: Add `trust` field to `KoinonManifest`, remove `trustIndex`**

In `koinon_manifest.dart`, add import for `trust_entry.dart`, then:

Replace:
```dart
    @JsonKey(name: 'trust_index') @Default('/trust/index.json') String trustIndex,
```

With:
```dart
    @Default([]) List<TrustEntry> trust,
```

**Step 3: Export `TrustEntry` from barrel file**

Add to `dart_koinon/lib/dart_koinon.dart`:
```dart
export 'src/models/trust_entry.dart';
```

**Step 4: Run build_runner in dart_koinon**

```bash
cd dart_koinon && dart run build_runner build --delete-conflicting-outputs
```

**Step 5: Fix any downstream compilation issues**

The `trustIndex` field was referenced in `RepoScaffolder`. Check and update:
- `dart_koinon/lib/src/scaffolder/repo_scaffolder.dart` — remove `trustIndex` from manifest construction if present

**Step 6: Commit**

```bash
git add dart_koinon/
git commit -m "feat(dart_koinon): add TrustEntry model, add trust array to KoinonManifest, remove trustIndex"
```

---

### Task 2: Update Flutter `TrustService` to maintain `trust` array in `koinon.json`

**Files:**
- Modify: `achaean_flutter/lib/features/trust/services/trust_service.dart`

**Step 1: Add manifest update to `declareTrust()`**

After committing the trust file, add a call to update `koinon.json` — same pattern as `PolisService._addPolisToManifest()`:

```dart
// After committing trust/<fileName>.json...

// Update koinon.json trust array
final manifestFile = await client.readFile(
  owner: owner,
  repo: repo,
  path: '.well-known/koinon.json',
);
final manifestJson =
    jsonDecode(manifestFile.content) as Map<String, dynamic>;
final manifest = KoinonManifest.fromJson(manifestJson);

// Add trust entry if not already present
if (!manifest.trust.any((t) => t.subject == subjectPubkey)) {
  final updated = manifest.copyWith(
    trust: [
      ...manifest.trust,
      TrustEntry(
        subject: subjectPubkey,
        repo: subjectRepo,
        level: level,
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
    message: 'Update trust index: add ${level.name} $fileName',
    sha: manifestFile.sha,
  );
}
```

**Step 2: Add manifest update to `revokeTrust()`**

After deleting the trust file, remove the entry from `koinon.json`:

```dart
// After deleting trust/<subjectName>.json...

// Update koinon.json trust array
final manifestFile = await client.readFile(
  owner: owner,
  repo: repo,
  path: '.well-known/koinon.json',
);
final manifestJson =
    jsonDecode(manifestFile.content) as Map<String, dynamic>;
final manifest = KoinonManifest.fromJson(manifestJson);

final updated = manifest.copyWith(
  trust: manifest.trust
      .where((t) => !t.subject.startsWith(subjectName))
      .toList(),
);

final updatedJson =
    const JsonEncoder.withIndent('  ').convert(updated.toJson());
await client.commitFile(
  owner: owner,
  repo: repo,
  path: '.well-known/koinon.json',
  content: updatedJson,
  message: 'Update trust index: revoke $subjectName',
  sha: manifestFile.sha,
);
```

**Step 3: Add `TrustEntry` import**

```dart
import 'package:dart_koinon/dart_koinon.dart';
```

Already imported. `TrustEntry` is now exported from the barrel.

**Step 4: Run flutter analyze**

```bash
cd achaean_flutter && flutter analyze
```

**Step 5: Commit**

```bash
git add achaean_flutter/lib/features/trust/
git commit -m "feat: TrustService maintains trust array in koinon.json"
```

---

### Task 3: AGE graph setup — migration

**Files:**
- Create: `achaean_server/lib/src/koinon/age_graph.dart`

This is a utility class that provides raw SQL statements for AGE operations. AGE requires loading the extension and creating the graph. We can't use Serverpod's migration system for this (it doesn't know about AGE), so the graph setup runs on server startup.

**Step 1: Create `AgeGraph` utility class**

```dart
import 'package:serverpod/serverpod.dart';

/// Apache AGE graph operations for the Koinon trust graph.
///
/// All methods use raw SQL via session.db.unsafeExecute/unsafeQuery.
/// AGE Cypher queries are wrapped in SELECT * FROM cypher('koinon', $$ ... $$).
class AgeGraph {
  /// Ensure the AGE extension and koinon graph exist.
  /// Call once on server startup.
  static Future<void> initialize(Session session) async {
    await session.db.unsafeExecute('CREATE EXTENSION IF NOT EXISTS age');
    await session.db.unsafeExecute(
      "LOAD 'age'",
    );
    await session.db.unsafeExecute(
      'SET search_path = ag_catalog, "\$user", public',
    );

    // Create graph if it doesn't exist
    final result = await session.db.unsafeQuery(
      "SELECT * FROM ag_catalog.ag_graph WHERE name = 'koinon'",
    );
    if (result.isEmpty) {
      await session.db.unsafeExecute(
        "SELECT * FROM ag_catalog.create_graph('koinon')",
      );
    }
  }

  /// Ensure AGE is loaded for this session (must be called before any Cypher query).
  static Future<void> _loadAge(Session session) async {
    await session.db.unsafeExecute("LOAD 'age'");
    await session.db.unsafeExecute(
      'SET search_path = ag_catalog, "\$user", public',
    );
  }

  /// Upsert a Polites node.
  static Future<void> upsertPolites(
    Session session,
    String pubkey,
  ) async {
    await _loadAge(session);
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MERGE (p:Polites {pubkey: '$pubkey'})"
      "\$\$) AS (v agtype)",
    );
  }

  /// Upsert a Polis node.
  static Future<void> upsertPolis(
    Session session,
    String repoUrl,
    int threshold,
  ) async {
    await _loadAge(session);
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MERGE (p:Polis {repo_url: '$repoUrl'})"
      "SET p.threshold = $threshold"
      "\$\$) AS (v agtype)",
    );
  }

  /// Delete all TRUSTS edges from a polites and re-create from current state.
  static Future<void> replaceTrustEdges(
    Session session,
    String fromPubkey,
    List<({String toPubkey, String level})> edges,
  ) async {
    await _loadAge(session);

    // Delete existing trust edges from this polites
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MATCH (from:Polites {pubkey: '$fromPubkey'})-[r:TRUSTS]->()"
      " DELETE r"
      "\$\$) AS (v agtype)",
    );

    // Create new edges
    for (final edge in edges) {
      await session.db.unsafeExecute(
        "SELECT * FROM cypher('koinon', \$\$"
        "MATCH (from:Polites {pubkey: '${edge.toPubkey}'})"
        " MERGE (to:Polites {pubkey: '${edge.toPubkey}'})"
        " MERGE (from2:Polites {pubkey: '$fromPubkey'})"
        " MERGE (from2)-[:TRUSTS {level: '${edge.level}'}]->(to)"
        "\$\$) AS (v agtype)",
      );
    }
  }

  /// Delete all SIGNED edges from a polites and re-create from current state.
  static Future<void> replaceSignedEdges(
    Session session,
    String signerPubkey,
    List<String> polisRepoUrls,
  ) async {
    await _loadAge(session);

    // Delete existing signed edges from this polites
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MATCH (s:Polites {pubkey: '$signerPubkey'})-[r:SIGNED]->()"
      " DELETE r"
      "\$\$) AS (v agtype)",
    );

    // Create new edges
    for (final repoUrl in polisRepoUrls) {
      await session.db.unsafeExecute(
        "SELECT * FROM cypher('koinon', \$\$"
        "MATCH (s:Polites {pubkey: '$signerPubkey'})"
        " MERGE (p:Polis {repo_url: '$repoUrl'})"
        " MERGE (s)-[:SIGNED]->(p)"
        "\$\$) AS (v agtype)",
      );
    }
  }

  /// Compute polis members: signers with >= threshold mutual TRUST edges.
  ///
  /// Returns list of pubkeys that are members.
  static Future<List<String>> computeMembers(
    Session session,
    String polisRepoUrl,
    int threshold,
  ) async {
    await _loadAge(session);

    if (threshold <= 0) {
      // Threshold 0: all signers are members
      final result = await session.db.unsafeQuery(
        "SELECT * FROM cypher('koinon', \$\$"
        "MATCH (s:Polites)-[:SIGNED]->(p:Polis {repo_url: '$polisRepoUrl'})"
        " RETURN s.pubkey"
        "\$\$) AS (pubkey agtype)",
      );
      return result
          .map((row) => (row[0] as String).replaceAll('"', ''))
          .toList();
    }

    // Find signers who have >= threshold mutual trust edges with other signers
    final result = await session.db.unsafeQuery(
      "SELECT * FROM cypher('koinon', \$\$"
      "MATCH (signer:Polites)-[:SIGNED]->(p:Polis {repo_url: '$polisRepoUrl'})"
      " WITH signer, p"
      " OPTIONAL MATCH (signer)-[:TRUSTS {level: 'trust'}]->(other:Polites)-[:TRUSTS {level: 'trust'}]->(signer)"
      " WHERE (other)-[:SIGNED]->(p)"
      " WITH signer, count(other) AS mutual_count"
      " WHERE mutual_count >= $threshold"
      " RETURN signer.pubkey"
      "\$\$) AS (pubkey agtype)",
    );

    return result
        .map((row) => (row[0] as String).replaceAll('"', ''))
        .toList();
  }
}
```

**Step 2: Commit**

```bash
git add achaean_server/lib/src/koinon/age_graph.dart
git commit -m "feat(server): add AgeGraph utility for Apache AGE Cypher operations"
```

---

### Task 4: Keypair auth middleware

**Files:**
- Create: `achaean_server/lib/src/koinon/koinon_auth.dart`

**Step 1: Create auth verification utility**

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:anonaccount_server/anonaccount_server.dart';
import 'package:serverpod/serverpod.dart';

/// Stateless keypair authentication for Koinon endpoints.
///
/// Client sends three headers:
/// - X-Koinon-Pubkey: hex-encoded ECDSA P-256 public key
/// - X-Koinon-Timestamp: ISO 8601 UTC timestamp
/// - X-Koinon-Signature: hex-encoded signature of the timestamp bytes
///
/// Verification:
/// 1. Check timestamp is within 5 minutes
/// 2. Verify ECDSA signature of timestamp bytes against provided pubkey
class KoinonAuth {
  static const _maxAgeMinutes = 5;

  /// Verify the request headers and return the caller's pubkey.
  ///
  /// Throws if verification fails.
  static Future<String> verify(Session session) async {
    final httpRequest = session.httpRequest;
    if (httpRequest == null) {
      throw Exception('No HTTP request available');
    }

    final pubkey = httpRequest.headers.value('X-Koinon-Pubkey');
    final timestamp = httpRequest.headers.value('X-Koinon-Timestamp');
    final signature = httpRequest.headers.value('X-Koinon-Signature');

    if (pubkey == null || timestamp == null || signature == null) {
      throw Exception('Missing auth headers');
    }

    // Check timestamp freshness
    final ts = DateTime.tryParse(timestamp);
    if (ts == null) {
      throw Exception('Invalid timestamp format');
    }

    final age = DateTime.now().toUtc().difference(ts);
    if (age.inMinutes.abs() > _maxAgeMinutes) {
      throw Exception('Timestamp too old');
    }

    // Verify signature of timestamp bytes
    final timestampBytes = utf8.encode(timestamp);
    final valid = await CryptoAuth.verifySignature(
      pubkey,
      Uint8List.fromList(timestampBytes),
      signature,
    );

    if (!valid) {
      throw Exception('Invalid signature');
    }

    return pubkey;
  }
}
```

**Note:** The exact `CryptoAuth.verifySignature` API takes `(String pubkeyHex, Uint8List data, String signatureHex)`. The signature format from Flutter (`base64url`) needs to be converted to hex on the client side before sending. This will be handled in a Flutter update task.

**Step 2: Commit**

```bash
git add achaean_server/lib/src/koinon/koinon_auth.dart
git commit -m "feat(server): add KoinonAuth stateless keypair verification"
```

---

### Task 5: Rewrite webhook handler — read `koinon.json`, atomic replace

**Files:**
- Modify: `achaean_server/lib/src/koinon/webhook_endpoint.dart`

**Step 1: Rewrite `WebhookEndpoint`**

```dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'age_graph.dart';

/// Receives Forgejo system webhook push events and indexes Koinon data.
class WebhookEndpoint extends Endpoint {
  static const _parser = ForgejoWebhookParser();

  /// Expected shared secret for webhook authentication.
  /// Set via KOINON_WEBHOOK_SECRET environment variable.
  static final _webhookSecret =
      Platform.environment['KOINON_WEBHOOK_SECRET'] ?? '';

  /// Processes a Forgejo push webhook payload.
  Future<void> handlePush(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    // Verify webhook secret
    final secret = session.httpRequest?.headers.value('X-Webhook-Secret');
    if (_webhookSecret.isNotEmpty && secret != _webhookSecret) {
      session.log('Webhook: invalid secret', level: LogLevel.warning);
      return;
    }

    final event = _parser.parsePush(payload);
    if (event == null) return;

    final now = DateTime.now().toUtc();
    bool manifestChanged = false;
    final postChanges = <String>[];

    for (final change in event.changes) {
      if (change.action == WebhookFileAction.removed) continue;

      if (change.path == '.well-known/koinon.json') {
        manifestChanged = true;
      } else if (change.path.startsWith('posts/') &&
          change.path.endsWith('post.json')) {
        postChanges.add(change.path);
      }
    }

    // Index manifest changes (trust + polis state)
    if (manifestChanged) {
      await _indexManifest(session, event, now);
    }

    // Index post references
    for (final path in postChanges) {
      await _indexPost(session, event, path, now);
    }
  }

  /// Read koinon.json from repo, atomically replace all relational + graph data.
  Future<void> _indexManifest(
    Session session,
    NormalizedPushEvent event,
    DateTime now,
  ) async {
    // Read koinon.json from the repo via public API
    final client = ForgejoClient(
      baseUrl: _extractBaseUrl(event.repoUrl),
      auth: const GitPublicAuth(),
    );

    KoinonManifest manifest;
    try {
      final file = await client.readFile(
        owner: event.repoOwner,
        repo: event.repoName,
        path: '.well-known/koinon.json',
      );
      final json = jsonDecode(file.content) as Map<String, dynamic>;
      manifest = KoinonManifest.fromJson(json);
    } catch (e) {
      session.log('Failed to read koinon.json from ${event.repoUrl}: $e',
          level: LogLevel.warning);
      return;
    }

    final pubkey = manifest.pubkey;
    if (pubkey.isEmpty) return;

    // Atomic transaction: replace all data for this pubkey
    await session.db.transaction((transaction) async {
      // 1. Upsert user
      final existingUser = await PolitaiUser.db.findFirstRow(
        session,
        where: (t) => t.pubkey.equals(pubkey),
        transaction: transaction,
      );

      if (existingUser != null) {
        existingUser.repoUrl = event.repoUrl;
        existingUser.lastIndexedAt = now;
        await PolitaiUser.db.updateRow(session, existingUser,
            transaction: transaction);
      } else {
        await PolitaiUser.db.insertRow(
          session,
          PolitaiUser(
            pubkey: pubkey,
            repoUrl: event.repoUrl,
            discoveredAt: now,
            lastIndexedAt: now,
          ),
          transaction: transaction,
        );
      }

      // 2. Replace trust declarations
      await TrustDeclarationRecord.db.deleteWhere(
        session,
        where: (t) => t.fromPubkey.equals(pubkey),
        transaction: transaction,
      );

      for (final entry in manifest.trust) {
        await TrustDeclarationRecord.db.insertRow(
          session,
          TrustDeclarationRecord(
            fromPubkey: pubkey,
            toPubkey: entry.subject,
            subjectRepoUrl: entry.repo,
            level: entry.level.name,
            timestamp: now,
            indexedAt: now,
          ),
          transaction: transaction,
        );
      }

      // 3. Replace readme signatures
      await ReadmeSignatureRecord.db.deleteWhere(
        session,
        where: (t) => t.signerPubkey.equals(pubkey),
        transaction: transaction,
      );

      for (final polis in manifest.poleis) {
        await ReadmeSignatureRecord.db.insertRow(
          session,
          ReadmeSignatureRecord(
            signerPubkey: pubkey,
            polisRepoUrl: polis.repo,
            readmeCommit: '', // Not available from manifest summary
            readmeHash: '',
            timestamp: now,
            indexedAt: now,
          ),
          transaction: transaction,
        );
      }
    });

    // 4. Update AGE graph (outside transaction — AGE uses its own tx)
    await AgeGraph.upsertPolites(session, pubkey);
    await AgeGraph.replaceTrustEdges(
      session,
      pubkey,
      manifest.trust
          .map((e) => (toPubkey: e.subject, level: e.level.name))
          .toList(),
    );
    await AgeGraph.replaceSignedEdges(
      session,
      pubkey,
      manifest.poleis.map((p) => p.repo).toList(),
    );

    session.log(
      'Indexed manifest for $pubkey: '
      '${manifest.trust.length} trust, ${manifest.poleis.length} poleis',
      level: LogLevel.info,
    );
  }

  Future<void> _indexPost(
    Session session,
    NormalizedPushEvent event,
    String path,
    DateTime now,
  ) async {
    // Upsert post reference
    final existing = await PostReference.db.findFirstRow(
      session,
      where: (t) =>
          t.authorRepoUrl.equals(event.repoUrl) & t.path.equals(path),
    );

    if (existing != null) {
      existing.commitHash = event.afterCommit;
      existing.indexedAt = now;
      await PostReference.db.updateRow(session, existing);
    } else {
      // Look up author pubkey from known users
      final user = await PolitaiUser.db.findFirstRow(
        session,
        where: (t) => t.repoUrl.equals(event.repoUrl),
      );

      await PostReference.db.insertRow(
        session,
        PostReference(
          authorPubkey: user?.pubkey ?? '',
          authorRepoUrl: event.repoUrl,
          path: path,
          commitHash: event.afterCommit,
          timestamp: now,
          isReply: false,
          indexedAt: now,
        ),
      );
    }
  }

  /// Extract base URL from a full repo URL.
  /// e.g. "http://localhost:3000/alice/koinon" → "http://localhost:3000"
  String _extractBaseUrl(String repoUrl) {
    final uri = Uri.parse(repoUrl);
    return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
  }
}
```

**Step 2: Commit**

```bash
git add achaean_server/lib/src/koinon/webhook_endpoint.dart
git commit -m "feat(server): rewrite webhook to read koinon.json and atomic-replace indexed data"
```

---

### Task 6: Update endpoints — add auth + `getPolisMembers` + fix `getAgora`

**Files:**
- Modify: `achaean_server/lib/src/koinon/koinon_endpoint.dart`

**Step 1: Rewrite `KoinonEndpoint` with auth and AGE queries**

```dart
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'age_graph.dart';
import 'koinon_auth.dart';

/// Koinon query endpoints — discovery, agora, trust graph lookups.
///
/// All endpoints (except register) require stateless keypair auth:
/// X-Koinon-Pubkey, X-Koinon-Timestamp, X-Koinon-Signature headers.
class KoinonEndpoint extends Endpoint {
  /// Register a repo URL for indexing (no auth — bootstrap endpoint).
  Future<void> register(Session session, String repoUrl) async {
    final existing = await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(repoUrl),
    );

    if (existing != null) return;

    await PolitaiUser.db.insertRow(
      session,
      PolitaiUser(
        pubkey: '',
        repoUrl: repoUrl,
        discoveredAt: DateTime.now(),
      ),
    );
  }

  /// Look up a polites by public key.
  Future<PolitaiUser?> getUser(Session session, String pubkey) async {
    await KoinonAuth.verify(session);
    return await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.pubkey.equals(pubkey),
    );
  }

  /// List all known poleis.
  Future<List<PolisDefinition>> listPoleis(Session session) async {
    await KoinonAuth.verify(session);
    return await PolisDefinition.db.find(
      session,
      orderBy: (t) => t.discoveredAt,
      orderDescending: true,
    );
  }

  /// Get a polis by repo URL.
  Future<PolisDefinition?> getPolis(Session session, String repoUrl) async {
    await KoinonAuth.verify(session);
    return await PolisDefinition.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(repoUrl),
    );
  }

  /// Get all README signers for a polis.
  Future<List<ReadmeSignatureRecord>> getPolisSigners(
    Session session,
    String polisRepoUrl,
  ) async {
    await KoinonAuth.verify(session);
    return await ReadmeSignatureRecord.db.find(
      session,
      where: (t) => t.polisRepoUrl.equals(polisRepoUrl),
    );
  }

  /// Get computed members of a polis (signers who meet trust threshold).
  Future<List<PolitaiUser>> getPolisMembers(
    Session session,
    String polisRepoUrl,
  ) async {
    await KoinonAuth.verify(session);

    // Get polis threshold (default 1)
    final polis = await PolisDefinition.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(polisRepoUrl),
    );
    final threshold = polis?.threshold ?? 1;

    // Compute members via AGE
    final memberPubkeys = await AgeGraph.computeMembers(
      session,
      polisRepoUrl,
      threshold,
    );

    if (memberPubkeys.isEmpty) return [];

    // Look up full user records
    final members = <PolitaiUser>[];
    for (final pubkey in memberPubkeys) {
      final user = await PolitaiUser.db.findFirstRow(
        session,
        where: (t) => t.pubkey.equals(pubkey),
      );
      if (user != null) members.add(user);
    }
    return members;
  }

  /// Get trust declarations issued by a polites.
  Future<List<TrustDeclarationRecord>> getTrustDeclarations(
    Session session,
    String pubkey,
  ) async {
    await KoinonAuth.verify(session);
    return await TrustDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(pubkey),
    );
  }

  /// Get post references for a polis (the agora).
  ///
  /// Computes polis members via AGE, then returns posts from those members
  /// that are tagged for this polis.
  Future<List<PostReference>> getAgora(
    Session session,
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  }) async {
    final callerPubkey = await KoinonAuth.verify(session);

    // Get polis threshold
    final polis = await PolisDefinition.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(polisRepoUrl),
    );
    final threshold = polis?.threshold ?? 1;

    // Compute members via AGE
    final memberPubkeys = await AgeGraph.computeMembers(
      session,
      polisRepoUrl,
      threshold,
    );

    if (memberPubkeys.isEmpty) return [];

    // Query posts from members tagged for this polis
    return await PostReference.db.find(
      session,
      where: (t) =>
          t.authorPubkey.inSet(memberPubkeys.toSet()) &
          t.poleisTags.like('%$polisRepoUrl%'),
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }
}
```

**Step 2: Commit**

```bash
git add achaean_server/lib/src/koinon/koinon_endpoint.dart
git commit -m "feat(server): add keypair auth, getPolisMembers endpoint, AGE-based agora"
```

---

### Task 7: Initialize AGE on server startup

**Files:**
- Modify: `achaean_server/lib/server.dart`

**Step 1: Add AGE initialization after Serverpod starts**

Add import:
```dart
import 'src/koinon/age_graph.dart';
```

After `await pod.start();`, add:

```dart
// Initialize Apache AGE graph
final ageSession = await pod.createSession();
try {
  await AgeGraph.initialize(ageSession);
  print('AGE graph initialized');
} catch (e) {
  print('AGE graph initialization failed (is AGE extension installed?): $e');
} finally {
  await ageSession.close();
}
```

**Step 2: Commit**

```bash
git add achaean_server/lib/server.dart
git commit -m "feat(server): initialize AGE graph on startup"
```

---

### Task 8: Run `serverpod generate` and fix compilation

**Step 1: Generate Serverpod protocol**

```bash
cd achaean_server && serverpod generate
```

This regenerates client stubs for any endpoint signature changes (new `getPolisMembers` endpoint, updated `handlePush` signature).

**Step 2: Fix any compilation errors**

```bash
cd achaean_server && dart analyze
```

Common issues to fix:
- `Platform.environment` needs `import 'dart:io';` in webhook_endpoint.dart
- `session.httpRequest` may need null-checking adjustments
- `t.authorPubkey.inSet()` — verify Serverpod supports `inSet` on column expressions; if not, use raw SQL or multiple queries
- AGE `agtype` return values may need different parsing than simple string cast

**Step 3: Commit**

```bash
git add achaean_server/ achaean_client/
git commit -m "chore: regenerate serverpod protocol, fix compilation"
```

---

### Task 9: Update Flutter to send auth headers on Serverpod calls

**Files:**
- Create: `achaean_flutter/lib/core/services/i_serverpod_auth_service.dart`
- Create: `achaean_flutter/lib/core/services/serverpod_auth_service.dart`

**Step 1: Create interface**

```dart
/// Provides Koinon auth headers for Serverpod requests.
abstract class IServerpodAuthService {
  /// Generate auth headers (pubkey, timestamp, signature) for a Serverpod request.
  Future<Map<String, String>> getAuthHeaders();
}
```

**Step 2: Create implementation**

```dart
import 'dart:convert';
import 'dart:typed_data';

import '../services/i_key_service.dart';
import 'i_serverpod_auth_service.dart';

class ServerpodAuthService implements IServerpodAuthService {
  final IKeyService _keyService;

  ServerpodAuthService(this._keyService);

  @override
  Future<Map<String, String>> getAuthHeaders() async {
    final pubkey = await _keyService.getPublicKeyHex();
    if (pubkey == null) throw Exception('No keypair available');

    final timestamp = DateTime.now().toUtc().toIso8601String();
    final timestampBytes = Uint8List.fromList(utf8.encode(timestamp));
    final signatureBytes = await _keyService.signBytes(timestampBytes);

    // Convert signature to hex (CryptoAuth expects hex, not base64url)
    final signatureHex = signatureBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    return {
      'X-Koinon-Pubkey': pubkey,
      'X-Koinon-Timestamp': timestamp,
      'X-Koinon-Signature': signatureHex,
    };
  }
}
```

**Step 3: Register in DI**

In `achaean_flutter/lib/app/bootstrap.dart`, add:

```dart
import '../core/services/i_serverpod_auth_service.dart';
import '../core/services/serverpod_auth_service.dart';

// In _registerCoreServices():
getIt.registerLazySingleton<IServerpodAuthService>(
  () => ServerpodAuthService(getIt<IKeyService>()),
);
```

**Step 4: Commit**

```bash
git add achaean_flutter/lib/core/services/i_serverpod_auth_service.dart achaean_flutter/lib/core/services/serverpod_auth_service.dart achaean_flutter/lib/app/bootstrap.dart
git commit -m "feat: add ServerpodAuthService for keypair-signed request headers"
```

---

### Task 10: Verify everything compiles

**Step 1: dart_koinon**

```bash
cd dart_koinon && dart run build_runner build --delete-conflicting-outputs && dart analyze
```

**Step 2: achaean_flutter**

```bash
cd achaean_flutter && dart run build_runner build --delete-conflicting-outputs && flutter analyze
```

**Step 3: achaean_server**

```bash
cd achaean_server && dart analyze
```

**Step 4: Fix any issues and commit**

```bash
git add -A
git commit -m "chore: fix compilation across all packages"
```

---

## Implementation Order

```
Task 1   (TrustEntry + KoinonManifest)     — dart_koinon, no deps
Task 2   (Flutter TrustService update)      — needs Task 1
Task 3   (AgeGraph utility)                 — server, no deps
Task 4   (KoinonAuth middleware)            — server, no deps
Task 5   (Webhook rewrite)                  — needs Task 1, 3
Task 6   (Endpoint updates)                 — needs Task 3, 4
Task 7   (AGE init on startup)             — needs Task 3
Task 8   (serverpod generate + fix)         — needs Task 5, 6
Task 9   (Flutter auth headers)             — needs Task 4 pattern
Task 10  (verify compilation)               — last
```

Tasks 1, 3, 4 can proceed in parallel. Tasks 5, 6, 7 can proceed in parallel after deps. Tasks 2 and 9 are Flutter-side and can proceed after their deps.

---

## Critical Files to Reference

| File | What to reuse |
|------|---------------|
| `achaean_server/lib/src/koinon/webhook_endpoint.dart` | Existing webhook handler to rewrite |
| `achaean_server/lib/src/koinon/koinon_endpoint.dart` | Existing endpoints to update |
| `achaean_server/lib/server.dart` | Server startup for AGE init |
| `achaean_server/lib/src/generated/protocol.dart` | Generated models |
| `dart_git/lib/src/webhook/forgejo_webhook_parser.dart` | Webhook parsing |
| `dart_git/lib/src/client/i_git_auth.dart` | `GitPublicAuth` for unauthenticated reads |
| `dart_koinon/lib/src/models/koinon_manifest.dart` | Manifest model to update |
| `anonaccount_server/.../crypto_auth.dart` | `CryptoAuth.verifySignature()` API |
| `achaean_flutter/lib/features/trust/services/trust_service.dart` | Trust service to update |
| `achaean_flutter/lib/core/services/i_key_service.dart` | Key service for signing |
