import 'dart:convert';

import 'package:achaean_client/achaean_client.dart';
import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/try_operation.dart';
import '../../../features/trust/services/trust_service.dart';
import 'i_post_reading_service.dart';

class PostReadingService implements IPostReadingService {
  final PublicGitClientFactory _publicClientFactory;
  final GitHostType _defaultHostType;

  PostReadingService(this._publicClientFactory, this._defaultHostType);

  @override
  Future<Post> getPost(PostReference ref) {
    return tryMethod(
      () async {
        final repoId = _parseRepoUrl(ref.authorRepoUrl);
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: _defaultHostType,
        );

        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: ref.path,
        );

        final json = jsonDecode(file.content) as Map<String, dynamic>;
        return Post.fromJson(json);
      },
      QueryException.new,
      'getPost',
    );
  }

  RepoIdentifier _parseRepoUrl(String repoUrl) {
    final uri = Uri.parse(repoUrl);
    final segments = uri.pathSegments;
    if (segments.length < 2) {
      throw QueryException('Invalid repo URL: $repoUrl');
    }
    final baseUrl =
        '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
    return RepoIdentifier(
      baseUrl: baseUrl,
      owner: segments[0],
      repo: segments[1],
    );
  }
}
