import 'package:freezed_annotation/freezed_annotation.dart';

part 'encrypted_post.freezed.dart';
part 'encrypted_post.g.dart';

/// An encrypted Koinon post. The content is an opaque blob —
/// encryption scheme is an implementation detail, not a protocol concern.
@freezed
abstract class EncryptedPost with _$EncryptedPost {
  const factory EncryptedPost({
    /// The encrypted payload (base64-encoded). Contains the serialized
    /// PostContent, routing, details, crosspost, and parent (if a reply).
    required String encryptedContent,

    /// When the post was created.
    required DateTime timestamp,

    /// Author's signature over the encrypted payload.
    required String signature,
  }) = _EncryptedPost;

  factory EncryptedPost.fromJson(Map<String, dynamic> json) =>
      _$EncryptedPostFromJson(json);
}
