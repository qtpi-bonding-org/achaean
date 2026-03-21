import 'dart:convert';
import 'dart:io' as io;

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
      io.Platform.environment['KOINON_WEBHOOK_SECRET'] ?? '';

  /// Processes a Forgejo push webhook payload.
  Future<void> handlePush(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    // Verify webhook secret
    final secret = session.request?.headers['X-Webhook-Secret']?.first;
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
          where: (t) => t.postUrl.equals(flag.post),
          transaction: transaction,
        );

        await FlagRecord.db.insertRow(
          session,
          FlagRecord(
            flaggedByPubkey: pubkey,
            postAuthorPubkey: postRef?.authorPubkey ?? '',
            postUrl: flag.post,
            polisRepoUrl: flag.polis,
            reason: flag.reason,
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
      '${manifest.trust.length} trust, ${manifest.poleis.length} poleis, '
      '${manifest.flags.length} flags',
      level: LogLevel.info,
    );
  }

  Future<void> _indexPost(
    Session session,
    NormalizedPushEvent event,
    String path,
    DateTime now,
  ) async {
    final postUrl = '${event.repoUrl}/$path';

    // Upsert post reference
    final existing = await PostReference.db.findFirstRow(
      session,
      where: (t) => t.postUrl.equals(postUrl),
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
          postUrl: postUrl,
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
