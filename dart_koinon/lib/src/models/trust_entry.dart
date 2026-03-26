import 'package:freezed_annotation/freezed_annotation.dart';

import 'trust_level.dart';

part 'trust_entry.freezed.dart';
part 'trust_entry.g.dart';

/// An entry in the koinon.json trust array.
@freezed
abstract class TrustEntry with _$TrustEntry {
  const factory TrustEntry({
    /// Subject's public key.
    required String subject,

    /// Subject's repo URL.
    required String repo,

    /// Trust level.
    required TrustLevel level,
  }) = _TrustEntry;

  factory TrustEntry.fromJson(Map<String, dynamic> json) =>
      _$TrustEntryFromJson(json);
}
