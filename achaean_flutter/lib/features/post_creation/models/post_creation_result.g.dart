// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_creation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostCreationResultImpl _$$PostCreationResultImplFromJson(
  Map<String, dynamic> json,
) => _$PostCreationResultImpl(
  path: json['path'] as String,
  slug: json['slug'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$PostCreationResultImplToJson(
  _$PostCreationResultImpl instance,
) => <String, dynamic>{
  'path': instance.path,
  'slug': instance.slug,
  'timestamp': instance.timestamp.toIso8601String(),
};
