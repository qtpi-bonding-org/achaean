import 'package:dart_koinon/dart_koinon.dart';

import 'package:achaean_client/achaean_client.dart';

/// Reads post content from author repos via public git API.
abstract class IPostReadingService {
  /// Read a post's content from the author's repo.
  Future<Post> getPost(PostReference ref);
}
