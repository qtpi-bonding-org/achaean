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
  Future<ReadablePostContent> getPost(PostReference ref) {
    return tryMethod(
      () async {
        final repoId = _parseRepoUrl(ref.authorRepoUrl);
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: _defaultHostType,
        );

        // 1. Read post.json (always present)
        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: ref.path,
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        final post = Post.fromJson(json);

        // 2. Derive directory path from post.json path
        final lastSlash = ref.path.lastIndexOf('/');
        final dirPath = lastSlash > 0 ? ref.path.substring(0, lastSlash) : '';

        // 3. Check for index.html
        final htmlPath = '$dirPath/index.html';
        final hasHtml = await client.exists(
          owner: repoId.owner,
          repo: repoId.repo,
          path: htmlPath,
        );

        if (!hasHtml) {
          return JsonReadablePost(post);
        }

        // 4. Read index.html
        final htmlFile = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: htmlPath,
        );

        // 5. Optionally read style.css
        final cssPath = '$dirPath/style.css';
        String? css;
        final hasCss = await client.exists(
          owner: repoId.owner,
          repo: repoId.repo,
          path: cssPath,
        );
        if (hasCss) {
          final cssFile = await client.readFile(
            owner: repoId.owner,
            repo: repoId.repo,
            path: cssPath,
          );
          css = cssFile.content;
        }

        return RichReadablePost(post, htmlFile.content, css);
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
