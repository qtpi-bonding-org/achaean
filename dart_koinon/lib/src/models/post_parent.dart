import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_parent.freezed.dart';
part 'post_parent.g.dart';

/// Reply parent reference — pins a reply to an exact version of the parent post.
@freezed
class PostParent with _$PostParent {
  const factory PostParent({
    /// Parent author's public key.
    required String author,

    /// Parent author's repo ID.
    required String repo,

    /// Path to parent's post.json.
    required String path,

    /// Git commit hash of the parent post.
    required String commit,
  }) = _PostParent;

  factory PostParent.fromJson(Map<String, dynamic> json) =>
      _$PostParentFromJson(json);
}
