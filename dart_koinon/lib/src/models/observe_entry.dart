import 'package:freezed_annotation/freezed_annotation.dart';

part 'observe_entry.freezed.dart';
part 'observe_entry.g.dart';

/// An entry in the koinon.json observe array.
@freezed
abstract class ObserveEntry with _$ObserveEntry {
  const factory ObserveEntry({
    /// Subject's public key.
    required String subject,

    /// Subject's repo URL.
    required String repo,
  }) = _ObserveEntry;

  factory ObserveEntry.fromJson(Map<String, dynamic> json) =>
      _$ObserveEntryFromJson(json);
}
