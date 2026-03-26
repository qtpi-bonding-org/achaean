import 'package:freezed_annotation/freezed_annotation.dart';

import 'post_content.dart';
import 'post_parent.dart';
import 'post_routing.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// A Koinon post (post.json). Covers both posts and replies.
/// Replies have a [parent] reference; posts have [routing].
@freezed
abstract class Post with _$Post {
  const factory Post({
    /// The content of the post.
    required PostContent content,

    /// Routing info (poleis, tags, mentions). Present on posts, absent on replies.
    PostRouting? routing,

    /// Parent reference. Present on replies, absent on top-level posts.
    PostParent? parent,

    /// Freeform structured metadata (polls, events, listings, etc.).
    Map<String, dynamic>? details,

    /// Crosspost configuration per platform.
    Map<String, dynamic>? crosspost,

    /// When the post was created.
    required DateTime timestamp,

    /// Author's Web Crypto signature.
    required String signature,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);
}
