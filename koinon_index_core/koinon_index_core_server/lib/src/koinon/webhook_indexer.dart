import 'dart:convert';
import 'dart:io' as io;

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:serverpod/serverpod.dart';
import 'package:yaml/yaml.dart';

import '../generated/protocol.dart';
import 'age_graph.dart';

/// Indexes Koinon repo data from Forgejo push webhook payloads.
///
/// Not a Serverpod Endpoint — called directly from [WebhookRoute].
/// Secret verification is handled by the route, not here.
///
/// Post indexing is NOT handled here. When post file changes are detected,
/// the optional [onPostsChanged] callback is invoked instead, allowing the
/// consuming server to handle post content indexing in its own module.
class WebhookIndexer {
  static const _parser = ForgejoWebhookParser();

  /// Optional callback invoked when post files change in a push.
  ///
  /// Arguments: (session, event, changedPaths)
  /// [changedPaths] is the list of post.json paths that changed.
  final Future<void> Function(
    Session session,
    NormalizedPushEvent event,
    List<String> changedPaths,
  )? onPostsChanged;

  const WebhookIndexer({this.onPostsChanged});

  /// Processes a Forgejo push webhook payload.
  Future<void> handlePush(
    Session session,
    Map<String, dynamic> payload,
  ) async {
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

    // Delegate post indexing to callback if provided
    if (postChanges.isNotEmpty && onPostsChanged != null) {
      await onPostsChanged!(session, event, postChanges);
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

      // 3. Replace observe declarations
      await ObserveDeclarationRecord.db.deleteWhere(
        session,
        where: (t) => t.fromPubkey.equals(pubkey),
        transaction: transaction,
      );

      for (final entry in manifest.observe) {
        await ObserveDeclarationRecord.db.insertRow(
          session,
          ObserveDeclarationRecord(
            fromPubkey: pubkey,
            toPubkey: entry.subject,
            subjectRepoUrl: entry.repo,
            timestamp: now,
            indexedAt: now,
          ),
          transaction: transaction,
        );
      }

      // 4. Replace readme signatures
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

    // 5. Update AGE graph (outside transaction — AGE uses its own tx)
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

    // 6. Discover any new poleis (fetch README frontmatter, not content)
    for (final polis in manifest.poleis) {
      await _discoverPolis(session, pubkey, polis.repo, now);
    }

    session.log(
      'Indexed manifest for $pubkey: '
      '${manifest.trust.length} trust, ${manifest.observe.length} observe, '
      '${manifest.poleis.length} poleis',
      level: LogLevel.info,
    );
  }

  /// Discover a polis by fetching its README and parsing YAML frontmatter.
  /// Only stores structural metadata (name, description, threshold) — never content.
  Future<void> _discoverPolis(
    Session session,
    String discovererPubkey,
    String polisRepoUrl,
    DateTime now,
  ) async {
    // Skip if already known
    final existing = await PolisDefinition.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(polisRepoUrl),
    );
    if (existing != null) return;

    // Parse owner/repo from the URL
    final uri = Uri.parse(polisRepoUrl);
    final segments = uri.pathSegments;
    if (segments.length < 2) return;
    final owner = segments[segments.length - 2];
    final repo = segments[segments.length - 1];
    final baseUrl = _extractBaseUrl(polisRepoUrl);

    final client = ForgejoClient(
      baseUrl: baseUrl,
      auth: const GitPublicAuth(),
    );

    try {
      final file = await client.readFile(
        owner: owner,
        repo: repo,
        path: 'README.md',
      );

      final frontmatter = _parseYamlFrontmatter(file.content);
      if (frontmatter == null) {
        session.log(
          'Polis $polisRepoUrl has no YAML frontmatter in README',
          level: LogLevel.warning,
        );
        return;
      }

      // Look up the owner's pubkey (they created the polis repo)
      final ownerUser = await PolitaiUser.db.findFirstRow(
        session,
        where: (t) => t.repoUrl.like('%/$owner/%'),
      );

      await PolisDefinition.db.insertRow(
        session,
        PolisDefinition(
          repoUrl: polisRepoUrl,
          name: frontmatter['name'] as String? ?? repo,
          description: frontmatter['description'] as String?,
          membershipThreshold:
              frontmatter['membership_threshold'] as int? ?? 1,
          flagThreshold: frontmatter['flag_threshold'] as int? ?? 3,
          parentRepoUrl: frontmatter['parent_repo'] as String?,
          ownerPubkey: ownerUser?.pubkey ?? discovererPubkey,
          readmeCommit: null,
          discoveredAt: now,
          lastIndexedAt: now,
        ),
      );

      session.log(
        'Discovered polis: ${frontmatter['name'] ?? repo} at $polisRepoUrl',
        level: LogLevel.info,
      );
    } catch (e) {
      session.log(
        'Failed to discover polis $polisRepoUrl: $e',
        level: LogLevel.warning,
      );
    }
  }

  /// Parse YAML frontmatter from a README string.
  /// Returns the parsed YAML map, or null if no frontmatter found.
  /// Only reads the frontmatter block — ignores all content after closing ---.
  Map<String, dynamic>? _parseYamlFrontmatter(String content) {
    final lines = content.split('\n');
    if (lines.isEmpty || lines.first.trim() != '---') return null;

    final endIndex = lines.indexWhere(
      (line) => line.trim() == '---',
      1, // skip the opening ---
    );
    if (endIndex < 0) return null;

    final yamlStr = lines.sublist(1, endIndex).join('\n');
    try {
      final yaml = loadYaml(yamlStr);
      if (yaml is YamlMap) {
        return Map<String, dynamic>.from(yaml);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Internal forge hostname override (e.g. "forgejo" inside Docker).
  /// When set, replaces "localhost" in webhook URLs so the indexer
  /// can reach Forgejo via the Docker network.
  static final _forgeHost =
      io.Platform.environment['FORGEJO_INTERNAL_HOST'] ?? '';

  /// Extract base URL from a full repo URL, rewriting localhost if needed.
  String _extractBaseUrl(String repoUrl) {
    var uri = Uri.parse(repoUrl);
    if (_forgeHost.isNotEmpty && uri.host == 'localhost') {
      uri = uri.replace(host: _forgeHost);
    }
    return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
  }
}
