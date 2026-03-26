import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_content.freezed.dart';
part 'post_content.g.dart';

/// The content layer of a post.json.
@freezed
abstract class PostContent with _$PostContent {
  const factory PostContent({
    /// The post text (always present).
    required String text,

    /// Optional headline.
    String? title,

    /// Optional link.
    String? url,

    /// Filenames of images/assets in the post directory.
    @Default([]) List<String> media,
  }) = _PostContent;

  factory PostContent.fromJson(Map<String, dynamic> json) =>
      _$PostContentFromJson(json);
}
