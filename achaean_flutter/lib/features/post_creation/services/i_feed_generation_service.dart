/// Generates RSS 2.0 feed XML from a user's posts.
abstract class IFeedGenerationService {
  /// Reads all posts from the repo and returns RSS 2.0 XML with full post.json
  /// embedded in koinon:post CDATA elements.
  Future<String> generateFeed({
    required String owner,
    required String repo,
    required String forgeBaseUrl,
  });
}
