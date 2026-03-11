import 'dart:convert';
import 'dart:io' as io;

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'age_graph.dart';
import 'rss_feed_parser.dart';

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

    bool feedChanged = false;

    for (final change in event.changes) {
      if (change.action == WebhookFileAction.removed) continue;

      if (change.path == '.well-known/koinon.json') {
        manifestChanged = true;
      } else if (change.path == 'feed.xml') {
        feedChanged = true;
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

    if (feedChanged) {
      await _indexFeed(session, event, now);
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
        final postRef = await CachedPost.db.findFirstRow(
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
    final client = ForgejoClient(
      baseUrl: _extractBaseUrl(event.repoUrl),
      auth: const GitPublicAuth(),
    );

    Post post;
    String rawJson;
    try {
      final file = await client.readFile(
        owner: event.repoOwner,
        repo: event.repoName,
        path: path,
      );
      rawJson = file.content;
      final json = jsonDecode(rawJson) as Map<String, dynamic>;
      post = Post.fromJson(json);
    } catch (e) {
      session.log('Failed to read $path from ${event.repoUrl}: $e',
          level: LogLevel.warning);
      return;
    }

    final user = await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(event.repoUrl),
    );

    await _upsertCachedPost(
      session,
      authorPubkey: user?.pubkey ?? '',
      authorRepoUrl: event.repoUrl,
      path: path,
      commitHash: event.afterCommit,
      link: '${event.repoUrl}/raw/branch/main/$path',
      post: post,
      rawJson: rawJson,
      now: now,
    );
  }

  /// Upsert a CachedPost from a parsed Post and raw JSON.
  Future<void> _upsertCachedPost(
    Session session, {
    required String authorPubkey,
    required String authorRepoUrl,
    required String path,
    required String commitHash,
    required String link,
    required Post post,
    required String rawJson,
    required DateTime now,
  }) async {
    final existing = await CachedPost.db.findFirstRow(
      session,
      where: (t) =>
          t.authorRepoUrl.equals(authorRepoUrl) & t.path.equals(path),
    );

    if (existing != null) {
      existing
        ..authorPubkey = authorPubkey.isNotEmpty ? authorPubkey : existing.authorPubkey
        ..commitHash = commitHash
        ..link = link
        ..title = post.content.title
        ..text = post.content.text
        ..poleisTags = post.routing?.poleis.join(',')
        ..tags = post.routing?.tags.join(',')
        ..isReply = post.parent != null
        ..parentAuthorPubkey = post.parent?.author
        ..parentPath = post.parent?.path
        ..contentJson = rawJson
        ..timestamp = post.timestamp
        ..indexedAt = now
        ..signature = post.signature;
      await CachedPost.db.updateRow(session, existing);
    } else {
      await CachedPost.db.insertRow(
        session,
        CachedPost(
          authorPubkey: authorPubkey,
          authorRepoUrl: authorRepoUrl,
          path: path,
          commitHash: commitHash,
          link: link,
          title: post.content.title,
          text: post.content.text,
          poleisTags: post.routing?.poleis.join(','),
          tags: post.routing?.tags.join(','),
          isReply: post.parent != null,
          parentAuthorPubkey: post.parent?.author,
          parentPath: post.parent?.path,
          contentJson: rawJson,
          timestamp: post.timestamp,
          indexedAt: now,
          signature: post.signature,
        ),
      );
    }
  }

  /// Fetch feed.xml from repo, parse RSS, upsert all posts.
  Future<void> _indexFeed(
    Session session,
    NormalizedPushEvent event,
    DateTime now,
  ) async {
    final client = ForgejoClient(
      baseUrl: _extractBaseUrl(event.repoUrl),
      auth: const GitPublicAuth(),
    );

    String feedXml;
    try {
      final file = await client.readFile(
        owner: event.repoOwner,
        repo: event.repoName,
        path: 'feed.xml',
      );
      feedXml = file.content;
    } catch (e) {
      session.log('Failed to read feed.xml from ${event.repoUrl}: $e',
          level: LogLevel.warning);
      return;
    }

    final user = await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(event.repoUrl),
    );
    final authorPubkey = user?.pubkey ?? '';

    final items = RssFeedParser.parse(feedXml);

    for (final item in items) {
      Post post;
      try {
        final json = jsonDecode(item.postJson) as Map<String, dynamic>;
        post = Post.fromJson(json);
      } catch (e) {
        session.log('Failed to parse post from feed item: $e',
            level: LogLevel.warning);
        continue;
      }

      // Extract path from link URL (after /raw/branch/main/)
      final pathMatch = RegExp(r'/raw/branch/main/(.+)$').firstMatch(item.link);
      final path = pathMatch?.group(1) ?? '';
      if (path.isEmpty) continue;

      await _upsertCachedPost(
        session,
        authorPubkey: authorPubkey,
        authorRepoUrl: event.repoUrl,
        path: path,
        commitHash: event.afterCommit,
        link: item.link,
        post: post,
        rawJson: item.postJson,
        now: now,
      );
    }

    session.log(
      'Indexed feed for ${event.repoUrl}: ${items.length} items',
      level: LogLevel.info,
    );
  }

  /// Extract base URL from a full repo URL.
  /// e.g. "http://localhost:3000/alice/koinon" → "http://localhost:3000"
  String _extractBaseUrl(String repoUrl) {
    final uri = Uri.parse(repoUrl);
    return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
  }
}
