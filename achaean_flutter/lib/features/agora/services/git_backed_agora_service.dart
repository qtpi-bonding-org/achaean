import 'dart:convert';

import 'package:achaean_client/achaean_client.dart';
import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_key_service.dart';
import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_agora_service.dart';

/// Git-backed implementation of [IAgoraService] for single-user demo mode.
///
/// Reads posts directly from the user's koinon repo instead of querying
/// a Serverpod index server. Used when no index server URL is configured.
class GitBackedAgoraService implements IAgoraService {
  final IGitService _gitService;
  final IKeyService _keyService;

  GitBackedAgoraService(this._gitService, this._keyService);

  @override
  Future<List<PostReference>> getPersonalFeed({
    int limit = 50,
    int offset = 0,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final username = await _gitService.getUsername();
        final baseUrl = await _gitService.getBaseUrl();
        final pubkeyHex = await _keyService.getPublicKeyHex();

        if (username == null || baseUrl == null || pubkeyHex == null) {
          return <PostReference>[];
        }

        final repoOwner = username;
        const repoName = 'koinon';
        final authorRepoUrl = '$baseUrl/$repoOwner/$repoName';

        // List post directories under posts/
        List<GitDirectoryEntry> postDirs;
        try {
          postDirs = await client.listFiles(
            owner: repoOwner,
            repo: repoName,
            path: 'posts',
          );
        } catch (_) {
          return <PostReference>[]; // No posts directory yet
        }

        final refs = <PostReference>[];

        for (final entry in postDirs) {
          if (entry.type != GitEntryType.dir) continue;

          // Read post.json from each post directory
          try {
            final file = await client.readFile(
              owner: repoOwner,
              repo: repoName,
              path: '${entry.path}/post.json',
            );

            final json = jsonDecode(file.content) as Map<String, dynamic>;
            final post = Post.fromJson(json);

            final postUrl = '$authorRepoUrl/${entry.path}/post.json';

            // Build parent URL if this is a reply
            String? parentPostUrl;
            if (post.parent != null) {
              parentPostUrl =
                  '$baseUrl/${post.parent!.repo}/${post.parent!.path}';
            }

            // Extract polis tags
            String? poleisTags;
            if (post.routing != null && post.routing!.poleis.isNotEmpty) {
              poleisTags = post.routing!.poleis.join(',');
            }

            refs.add(PostReference(
              authorPubkey: pubkeyHex,
              authorRepoUrl: authorRepoUrl,
              postUrl: postUrl,
              commitHash: file.sha,
              title: post.content.title,
              poleisTags: poleisTags,
              timestamp: post.timestamp,
              parentPostUrl: parentPostUrl,
              indexedAt: DateTime.now(),
            ));
          } catch (_) {
            // Skip posts that can't be read
            continue;
          }
        }

        // Sort by timestamp descending (newest first)
        refs.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        // Apply pagination
        if (offset >= refs.length) return <PostReference>[];
        final end = (offset + limit).clamp(0, refs.length);
        return refs.sublist(offset, end);
      },
      QueryException.new,
      'getPersonalFeed',
    );
  }

  @override
  Future<List<PostReference>> getAgoraRefs(
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  }) {
    // In single-user demo mode, agora is the same as personal feed
    return getPersonalFeed(limit: limit, offset: offset);
  }

  @override
  Future<List<FlagRecord>> getFlagsForPolis(String polisRepoUrl) async {
    // No flags in demo mode
    return <FlagRecord>[];
  }
}
