import 'post.dart';

/// The result of reading a post directory.
///
/// A post directory always contains `post.json`. It may also contain
/// `index.html` (and optionally `style.css`) for rich presentation.
sealed class ReadablePostContent {
  /// The parsed post.json data.
  Post get post;

  const ReadablePostContent();
}

/// A plain post — only post.json, no presentation files.
class JsonReadablePost extends ReadablePostContent {
  @override
  final Post post;

  const JsonReadablePost(this.post);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonReadablePost && post == other.post;

  @override
  int get hashCode => post.hashCode;
}

/// A rich post — post.json plus HTML (and optional CSS) presentation.
class RichReadablePost extends ReadablePostContent {
  @override
  final Post post;

  /// The HTML content from index.html.
  final String html;

  /// Optional CSS from style.css.
  final String? css;

  const RichReadablePost(this.post, this.html, [this.css]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RichReadablePost &&
          post == other.post &&
          html == other.html &&
          css == other.css;

  @override
  int get hashCode => Object.hash(post, html, css);
}
