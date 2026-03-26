// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_inspection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RepoInspectionResult _$RepoInspectionResultFromJson(
  Map<String, dynamic> json,
) => _RepoInspectionResult(
  manifest: json['manifest'] == null
      ? null
      : KoinonManifest.fromJson(json['manifest'] as Map<String, dynamic>),
  trustDeclarations:
      (json['trustDeclarations'] as List<dynamic>?)
          ?.map((e) => TrustDeclaration.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  readmeSignatures:
      (json['readmeSignatures'] as List<dynamic>?)
          ?.map((e) => ReadmeSignature.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  posts:
      (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RepoInspectionResultToJson(
  _RepoInspectionResult instance,
) => <String, dynamic>{
  'manifest': instance.manifest,
  'trustDeclarations': instance.trustDeclarations,
  'readmeSignatures': instance.readmeSignatures,
  'posts': instance.posts,
};
