import 'package:freezed_annotation/freezed_annotation.dart';

part 'flag_entry.freezed.dart';
part 'flag_entry.g.dart';

/// An entry in the koinon.json flags array.
@freezed
abstract class FlagEntry with _$FlagEntry {
  const factory FlagEntry({
    /// Path to the flagged post.
    required String post,

    /// Polis repo URL where this flag applies.
    required String polis,

    /// Free-form reason for flagging.
    required String reason,
  }) = _FlagEntry;

  factory FlagEntry.fromJson(Map<String, dynamic> json) =>
      _$FlagEntryFromJson(json);
}
