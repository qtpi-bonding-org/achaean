import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_routing.freezed.dart';
part 'post_routing.g.dart';

/// The routing layer of a post.json — where it goes, who it references.
@freezed
class PostRouting with _$PostRouting {
  const factory PostRouting({
    /// Which poleis this post is tagged for.
    @Default([]) List<String> poleis,

    /// Hashtags / topic tags.
    @Default([]) List<String> tags,

    /// Public keys of mentioned politai.
    @Default([]) List<String> mentions,
  }) = _PostRouting;

  factory PostRouting.fromJson(Map<String, dynamic> json) =>
      _$PostRoutingFromJson(json);
}
