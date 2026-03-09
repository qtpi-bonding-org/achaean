import 'package:freezed_annotation/freezed_annotation.dart';

part 'readme_signature.freezed.dart';
part 'readme_signature.g.dart';

/// A signed README cosignature stored at poleis/<polis-repo-id>/signature.json.
@freezed
class ReadmeSignature with _$ReadmeSignature {
  const factory ReadmeSignature({
    /// Always "readme-signature".
    @Default('readme-signature') String type,

    /// The polis repo identifier.
    required String polis,

    /// Commit hash of the README version that was signed.
    @JsonKey(name: 'readme_commit') required String readmeCommit,

    /// Content hash of the README.
    @JsonKey(name: 'readme_hash') required String readmeHash,

    /// When the signature was made.
    required DateTime timestamp,

    /// Signer's Web Crypto signature.
    required String signature,
  }) = _ReadmeSignature;

  factory ReadmeSignature.fromJson(Map<String, dynamic> json) =>
      _$ReadmeSignatureFromJson(json);
}
