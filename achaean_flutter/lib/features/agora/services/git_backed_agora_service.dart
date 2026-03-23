import 'dart:convert';

import 'package:achaean_client/achaean_client.dart';
import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_key_service.dart';
import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import '../../trust/services/trust_service.dart';
import 'i_agora_service.dart';

/// Git-backed implementation of [IAgoraService] for single-user or guest mode.
class GitBackedAgoraService implements IAgoraService {
  final Future<IGitClient> Function() _getClient;
  final Future<String?> Function() _getUsername;
  final Future<String?> Function() _getBaseUrl;
  final Future<String?> Function() _getPubkey;

  /// Authenticated mode — reads from the logged-in user's repo.
  GitBackedAgoraService(IGitService gitService, IKeyService keyService)
      : _getClient = gitService.getClient,
        _getUsername = gitService.getUsername,
        _getBaseUrl = gitService.getBaseUrl,
        _getPubkey = keyService.getPublicKeyHex;

  /// Guest mode — reads from a public repo using unauthenticated access.
  GitBackedAgoraService.guest({
    required String repoUrl,
    required PublicGitClientFactory publicClientFactory,
  })  : _getClient = (() async {
          final uri = Uri.parse(repoUrl);
          final baseUrl =
              '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
          return publicClientFactory(
            baseUrl: baseUrl,
            hostType: GitHostType.forgejo,
          );
        }),
        _getUsername = (() async {
          // Extract username from URL: https://host/username/koinon
          final uri = Uri.parse(repoUrl);
          final segments = uri.pathSegments;
          return segments.isNotEmpty ? segments[0] : null;
        }),
        _getBaseUrl = (() async {
          final uri = Uri.parse(repoUrl);
          return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
        }),
        _getPubkey = (() async => 'guest');

  @override
  Future<List<PostReference>> getPersonalFeed({
    int limit = 50,
    int offset = 0,
  }) {
    return tryMethod(
      () async {
        final client = await _getClient();
        final username = await _getUsername();
        final baseUrl = await _getBaseUrl();
        final pubkeyHex = await _getPubkey();

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
    // No flags in demo/guest mode
    return <FlagRecord>[];
  }
}
