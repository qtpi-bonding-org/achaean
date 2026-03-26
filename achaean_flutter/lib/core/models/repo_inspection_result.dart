import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_inspection_result.freezed.dart';
part 'repo_inspection_result.g.dart';

/// Everything readable from a repo via public inspection.
@freezed
abstract class RepoInspectionResult with _$RepoInspectionResult {
  const factory RepoInspectionResult({
    KoinonManifest? manifest,
    @Default([]) List<TrustDeclaration> trustDeclarations,
    @Default([]) List<ReadmeSignature> readmeSignatures,
    @Default([]) List<Post> posts,
  }) = _RepoInspectionResult;

  factory RepoInspectionResult.fromJson(Map<String, dynamic> json) =>
      _$RepoInspectionResultFromJson(json);
}
