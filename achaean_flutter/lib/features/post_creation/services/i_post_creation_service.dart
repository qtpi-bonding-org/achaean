import 'package:dart_koinon/dart_koinon.dart';

import '../models/post_creation_result.dart';

/// Orchestrates creating and publishing a post.
abstract class IPostCreationService {
  Future<PostCreationResult> createPost({
    required String text,
    String? title,
    String? url,
    List<String> poleis = const [],
    List<String> tags = const [],
    String? html,
    String? css,
  });

  Future<List<Post>> getOwnPosts();
}
