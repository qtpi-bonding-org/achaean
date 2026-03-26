import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_creation_result.freezed.dart';
part 'post_creation_result.g.dart';

@freezed
abstract class PostCreationResult with _$PostCreationResult {
  const factory PostCreationResult({
    required String path,
    required String slug,
    required DateTime timestamp,
  }) = _PostCreationResult;

  factory PostCreationResult.fromJson(Map<String, dynamic> json) =>
      _$PostCreationResultFromJson(json);
}
