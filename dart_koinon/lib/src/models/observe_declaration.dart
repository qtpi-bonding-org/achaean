import 'package:freezed_annotation/freezed_annotation.dart';

part 'observe_declaration.freezed.dart';
part 'observe_declaration.g.dart';

/// A signed observe declaration stored in a polites's repo at observe/<name>.json.
/// Non-structural — only affects personal feed, not trust graph or membership.
@freezed
abstract class ObserveDeclaration with _$ObserveDeclaration {
  const factory ObserveDeclaration({
    /// Always "observe-declaration".
    @Default('observe-declaration') String type,

    /// Subject's public key.
    required String subject,

    /// Subject's repo URL (enables discovery).
    required String repo,

    /// When the declaration was made.
    required DateTime timestamp,

    /// Author's Web Crypto signature.
    required String signature,
  }) = _ObserveDeclaration;

  factory ObserveDeclaration.fromJson(Map<String, dynamic> json) =>
      _$ObserveDeclarationFromJson(json);
}
