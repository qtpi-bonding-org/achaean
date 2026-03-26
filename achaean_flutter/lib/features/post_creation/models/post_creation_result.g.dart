// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_creation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostCreationResult _$PostCreationResultFromJson(Map<String, dynamic> json) =>
    _PostCreationResult(
      path: json['path'] as String,
      slug: json['slug'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$PostCreationResultToJson(_PostCreationResult instance) =>
    <String, dynamic>{
      'path': instance.path,
      'slug': instance.slug,
      'timestamp': instance.timestamp.toIso8601String(),
    };
