import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import '../../../core/exceptions/post_exception.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/try_operation.dart';
import '../models/post_creation_result.dart';
import 'i_feed_generation_service.dart';
import 'i_post_creation_service.dart';
import 'i_post_signing_service.dart';
import 'slug_generator.dart';

class PostCreationService implements IPostCreationService {
  final IGitService _gitService;
  final IPostSigningService _signingService;
  final IFeedGenerationService _feedService;

  PostCreationService(
    this._gitService,
    this._signingService,
    this._feedService,
  );

  @override
  Future<PostCreationResult> createPost({
    required String text,
    String? title,
    String? url,
    List<String> poleis = const [],
    List<String> tags = const [],
    String? html,
    String? css,
  }) {
    return tryMethod(
      () async {
        final now = DateTime.now().toUtc();
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PostException.new,
        );
        const repo = 'koinon';

        // 1. Build unsigned post
        final unsignedPost = Post(
          content: PostContent(
            text: text,
            title: title,
            url: url,
          ),
          routing: PostRouting(
            poleis: poleis,
            tags: tags,
          ),
          timestamp: now,
          signature: '',
        );

        // 2. Sign
        final signature = await _signingService.signPost(unsignedPost);
        final signedPost = unsignedPost.copyWith(signature: signature);

        // 3. Generate slug
        final slug = SlugGenerator.generate(
          title: title,
          text: text,
          date: now,
        );

        // 4. Commit post.json
        final postPath = 'posts/$slug/post.json';
        final postJson = const JsonEncoder.withIndent('  ')
            .convert(signedPost.toJson());

        await client.commitFile(
          owner: owner,
          repo: repo,
          path: postPath,
          content: postJson,
          message: 'Add post: $slug',
        );

        // 4.5 Commit optional presentation files
        if (html != null) {
          await client.commitFile(
            owner: owner,
            repo: repo,
            path: 'posts/$slug/index.html',
            content: html,
            message: 'Add post presentation: $slug',
          );
        }
        if (css != null) {
          await client.commitFile(
            owner: owner,
            repo: repo,
            path: 'posts/$slug/style.css',
            content: css,
            message: 'Add post styles: $slug',
          );
        }

        // 5. Regenerate + commit feed.xml
        final feedXml = await _feedService.generateFeed(
          owner: owner,
          repo: repo,
        );

        // Check if feed.xml already exists (need sha for update)
        String? feedSha;
        try {
          final existingFeed = await client.readFile(
            owner: owner,
            repo: repo,
            path: 'feed.xml',
          );
          feedSha = existingFeed.sha;
        } on GitNotFoundException {
          // First post — feed.xml doesn't exist yet
        }

        await client.commitFile(
          owner: owner,
          repo: repo,
          path: 'feed.xml',
          content: feedXml,
          message: 'Update feed',
          sha: feedSha,
        );

        return PostCreationResult(
          path: postPath,
          slug: slug,
          timestamp: now,
        );
      },
      PostException.new,
      'createPost',
    );
  }

  @override
  Future<List<Post>> getOwnPosts() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PostException.new,
        );
        const repo = 'koinon';

        final entries = await client.listFiles(
          owner: owner,
          repo: repo,
          path: 'posts',
        );

        final posts = <Post>[];
        for (final entry in entries) {
          if (entry.type != GitEntryType.dir || entry.name == '.gitkeep') {
            continue;
          }

          try {
            final file = await client.readFile(
              owner: owner,
              repo: repo,
              path: '${entry.path}/post.json',
            );
            final json = jsonDecode(file.content) as Map<String, dynamic>;
            posts.add(Post.fromJson(json));
          } catch (_) {
            continue;
          }
        }

        posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return posts;
      },
      PostException.new,
      'getOwnPosts',
    );
  }
}
