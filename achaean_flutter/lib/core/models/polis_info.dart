import 'package:freezed_annotation/freezed_annotation.dart';

part 'polis_info.freezed.dart';
part 'polis_info.g.dart';

/// Parsed polis README YAML frontmatter.
@freezed
class PolisInfo with _$PolisInfo {
  const factory PolisInfo({
    required String name,
    String? description,
    String? norms,
    int? threshold,
    String? parentRepo,
  }) = _PolisInfo;

  factory PolisInfo.fromJson(Map<String, dynamic> json) =>
      _$PolisInfoFromJson(json);
}
