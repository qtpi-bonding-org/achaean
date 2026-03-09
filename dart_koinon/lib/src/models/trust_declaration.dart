import 'package:freezed_annotation/freezed_annotation.dart';

import 'trust_level.dart';

part 'trust_declaration.freezed.dart';
part 'trust_declaration.g.dart';

/// A signed trust declaration stored in a polites's repo at trust/<name>.json.
@freezed
class TrustDeclaration with _$TrustDeclaration {
  const factory TrustDeclaration({
    /// Always "trust-declaration".
    @Default('trust-declaration') String type,

    /// Subject's public key.
    required String subject,

    /// Subject's repo URL (enables trust graph traversal).
    required String repo,

    /// Trust level: TRUST or PROVISIONAL.
    required TrustLevel level,

    /// When the declaration was made.
    required DateTime timestamp,

    /// Author's Web Crypto signature.
    required String signature,
  }) = _TrustDeclaration;

  factory TrustDeclaration.fromJson(Map<String, dynamic> json) =>
      _$TrustDeclarationFromJson(json);
}
