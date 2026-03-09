import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import '../../../core/services/i_git_service.dart';
import 'i_feed_generation_service.dart';

class FeedGenerationService implements IFeedGenerationService {
  final IGitService _gitService;

  FeedGenerationService(this._gitService);

  @override
  Future<String> generateFeed({
    required String owner,
    required String repo,
  }) async {
    final client = await _gitService.getClient();
    final entries = await client.listFiles(
      owner: owner,
      repo: repo,
      path: 'posts',
    );

    final posts = <Post>[];
    for (final entry in entries) {
      if (entry.type != GitEntryType.dir || entry.name == '.gitkeep') continue;

      try {
        final file = await client.readFile(
          owner: owner,
          repo: repo,
          path: '${entry.path}/post.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        posts.add(Post.fromJson(json));
      } catch (_) {
        // Skip entries that don't contain valid post.json
        continue;
      }
    }

    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return _buildRss(owner, repo, posts);
  }

  String _buildRss(String owner, String repo, List<Post> posts) {
    final buffer = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="UTF-8"?>')
      ..writeln('<rss version="2.0">')
      ..writeln('  <channel>')
      ..writeln('    <title>$owner</title>')
      ..writeln('    <description>Koinon feed for $owner</description>')
      ..writeln(
          '    <lastBuildDate>${DateTime.now().toUtc().toIso8601String()}</lastBuildDate>');

    for (final post in posts) {
      buffer
        ..writeln('    <item>')
        ..writeln(
            '      <title>${_escapeXml(post.content.title ?? _truncate(post.content.text, 80))}</title>')
        ..writeln(
            '      <description>${_escapeXml(post.content.text)}</description>')
        ..writeln(
            '      <pubDate>${post.timestamp.toUtc().toIso8601String()}</pubDate>')
        ..writeln('    </item>');
    }

    buffer
      ..writeln('  </channel>')
      ..writeln('</rss>');

    return buffer.toString();
  }

  String _escapeXml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }

  String _truncate(String text, int maxLen) {
    if (text.length <= maxLen) return text;
    return '${text.substring(0, maxLen)}...';
  }
}
