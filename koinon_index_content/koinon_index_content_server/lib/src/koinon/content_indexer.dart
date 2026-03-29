import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:koinon_index_core_server/koinon_index_core_server.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Indexes post content from Forgejo push webhook payloads.
///
/// Not a Serverpod Endpoint — called via [KoinonCore.config.onPostsChanged]
/// callback from the core module's WebhookIndexer.
class ContentIndexer {
  /// Index all changed post paths from a push event.
  static Future<void> indexPosts(
    Session session,
    NormalizedPushEvent event,
    List<String> paths,
    DateTime now,
  ) async {
    for (final path in paths) {
      await _indexPost(session, event, path, now);
    }
  }

  static Future<void> _indexPost(
    Session session,
    NormalizedPushEvent event,
    String path,
    DateTime now,
  ) async {
    final baseUrl = _extractBaseUrl(event.repoUrl);
    final client = ForgejoClient(
      baseUrl: baseUrl,
      auth: const GitPublicAuth(),
    );

    // Read post.json to extract metadata (content is not stored)
    Post post;
    try {
      final file = await client.readFile(
        owner: event.repoOwner,
        repo: event.repoName,
        path: path,
      );
      final json = jsonDecode(file.content) as Map<String, dynamic>;
      post = Post.fromJson(json);
    } catch (e) {
      session.log('Failed to read $path from ${event.repoUrl}: $e',
          level: LogLevel.warning);
      return;
    }

    // Look up author pubkey from known users
    final user = await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(event.repoUrl),
    );

    final postUrl = '${event.repoUrl}/$path';

    // For replies, look up parent author's repo URL by their pubkey
    String? parentPostUrl;
    if (post.parent != null) {
      final parentUser = await PolitaiUser.db.findFirstRow(
        session,
        where: (t) => t.pubkey.equals(post.parent!.author),
      );
      if (parentUser != null) {
        parentPostUrl = '${parentUser.repoUrl}/${post.parent!.path}';
      }
    }

    final poleisTags = post.routing?.poleis.join(',');

    // Upsert by postUrl
    final existing = await PostReference.db.findFirstRow(
      session,
      where: (t) => t.postUrl.equals(postUrl),
    );

    if (existing != null) {
      existing
        ..commitHash = event.afterCommit
        ..title = post.content.title
        ..poleisTags = poleisTags
        ..parentPostUrl = parentPostUrl
        ..timestamp = post.timestamp
        ..indexedAt = now;
      await PostReference.db.updateRow(session, existing);
    } else {
      await PostReference.db.insertRow(
        session,
        PostReference(
          authorPubkey: user?.pubkey ?? '',
          authorRepoUrl: event.repoUrl,
          postUrl: postUrl,
          commitHash: event.afterCommit,
          title: post.content.title,
          poleisTags: poleisTags,
          timestamp: post.timestamp,
          parentPostUrl: parentPostUrl,
          indexedAt: now,
        ),
      );
    }
  }

  /// Extract base URL from a full repo URL, rewriting localhost if needed.
  ///
  /// Uses [KoinonCore.config.forgeInternalHost] for Docker network URL rewriting.
  static String _extractBaseUrl(String repoUrl) {
    var uri = Uri.parse(repoUrl);
    final forgeHost = KoinonCore.config.forgeInternalHost ?? '';
    if (forgeHost.isNotEmpty && uri.host == 'localhost') {
      uri = uri.replace(host: forgeHost);
    }
    return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
  }
}
