import 'package:dart_git/dart_git.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Receives Forgejo system webhook push events and indexes Koinon data.
class WebhookEndpoint extends Endpoint {
  static const _parser = ForgejoWebhookParser();

  /// Processes a Forgejo push webhook payload.
  ///
  /// Parses the push event, checks for Koinon-relevant file changes,
  /// and indexes them into the database.
  Future<void> handlePush(
    Session session,
    Map<String, dynamic> payload,
  ) async {
    final event = _parser.parsePush(payload);
    if (event == null) return;

    final now = DateTime.now();

    for (final change in event.changes) {
      if (change.action == WebhookFileAction.removed) continue;

      if (change.path == '.well-known/koinon.json') {
        await _indexUser(session, event, now);
      } else if (change.path.startsWith('trust/') &&
          change.path.endsWith('.json')) {
        await _indexTrustDeclaration(session, event, change.path, now);
      } else if (change.path.startsWith('poleis/') &&
          change.path.endsWith('signature.json')) {
        await _indexReadmeSignature(session, event, change.path, now);
      } else if (change.path.startsWith('posts/') &&
          change.path.endsWith('post.json')) {
        await _indexPost(session, event, change.path, now);
      }
    }
  }

  Future<void> _indexUser(
    Session session,
    NormalizedPushEvent event,
    DateTime now,
  ) async {
    // Upsert user by repo URL
    final existing = await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(event.repoUrl),
    );

    if (existing != null) {
      existing.lastIndexedAt = now;
      await PolitaiUser.db.updateRow(session, existing);
    } else {
      await PolitaiUser.db.insertRow(
        session,
        PolitaiUser(
          pubkey: '', // Will be filled when we read the manifest
          repoUrl: event.repoUrl,
          discoveredAt: now,
          lastIndexedAt: now,
        ),
      );
    }
  }

  Future<void> _indexTrustDeclaration(
    Session session,
    NormalizedPushEvent event,
    String path,
    DateTime now,
  ) async {
    // We record that a trust file changed. The full indexing
    // (reading the file content from the repo) happens asynchronously.
    // For now, store what we know from the webhook event.
    session.log('Trust declaration changed: $path in ${event.repoUrl}',
        level: LogLevel.info);
  }

  Future<void> _indexReadmeSignature(
    Session session,
    NormalizedPushEvent event,
    String path,
    DateTime now,
  ) async {
    session.log('README signature changed: $path in ${event.repoUrl}',
        level: LogLevel.info);
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
      await PostReference.db.insertRow(
        session,
        PostReference(
          authorPubkey: '', // Resolved during full indexing
          authorRepoUrl: event.repoUrl,
          path: path,
          commitHash: event.afterCommit,
          timestamp: now,
          isReply: false, // Resolved during full indexing
          indexedAt: now,
        ),
      );
    }
  }
}
