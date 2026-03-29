import 'dart:io' as io;

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../widgets/recent_posts_page.dart';

/// Serves the public recent posts page.
class RecentPostsRoute extends WidgetRoute {
  static final _forgeUrl =
      io.Platform.environment['FORGEJO_PUBLIC_URL'] ?? 'http://localhost:3000';

  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    final posts = await PostReference.db.find(
      session,
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: 50,
    );

    return RecentPostsPageWidget(
      forgeUrl: _forgeUrl,
      posts: posts
          .map((p) => {
                'title': p.title ?? 'Untitled',
                'author_repo_url': p.authorRepoUrl,
                'author': _extractUsername(p.authorRepoUrl),
                'post_url': p.postUrl,
                'forge_post_url': _buildForgePostUrl(p),
                'forge_raw_url': _buildForgeRawUrl(p),
                'timestamp': p.timestamp.toIso8601String().substring(0, 10),
                'polis_tags': p.poleisTags,
                'has_polis_tags': p.poleisTags != null && p.poleisTags!.isNotEmpty,
              })
          .toList(),
    );
  }

  static String _extractUsername(String repoUrl) {
    final segments = Uri.parse(repoUrl).pathSegments;
    return segments.isNotEmpty ? segments.first : 'unknown';
  }

  /// Build a link to the post's index.md on the forge.
  static String _buildForgePostUrl(PostReference p) {
    // postUrl is like "http://localhost:3000/alice/koinon/posts/2026-03-29-hello/post.json"
    // We want the directory: "http://localhost:3000/alice/koinon/src/branch/main/posts/2026-03-29-hello"
    final postDir = p.postUrl.replaceAll('/post.json', '');
    final uri = Uri.parse(postDir);
    final segments = uri.pathSegments; // [alice, koinon, posts, 2026-03-29-hello]
    if (segments.length < 4) return postDir;
    final owner = segments[0];
    final repo = segments[1];
    final postPath = segments.sublist(2).join('/');
    return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}/$owner/$repo/src/branch/main/$postPath';
  }

  /// Build the Forgejo API URL to fetch post.json content.
  /// e.g. "http://localhost:3000/api/v1/repos/alice/koinon/contents/posts/2026-03-29-hello/post.json"
  static String _buildForgeRawUrl(PostReference p) {
    final uri = Uri.parse(p.postUrl);
    final segments = uri.pathSegments; // [alice, koinon, posts, 2026-03-29-hello, post.json]
    if (segments.length < 3) return p.postUrl;
    final owner = segments[0];
    final repo = segments[1];
    final filePath = segments.sublist(2).join('/');
    return '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}/api/v1/repos/$owner/$repo/contents/$filePath';
  }
}
