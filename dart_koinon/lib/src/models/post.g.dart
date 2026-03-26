// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  content: PostContent.fromJson(json['content'] as Map<String, dynamic>),
  routing: json['routing'] == null
      ? null
      : PostRouting.fromJson(json['routing'] as Map<String, dynamic>),
  parent: json['parent'] == null
      ? null
      : PostParent.fromJson(json['parent'] as Map<String, dynamic>),
  details: json['details'] as Map<String, dynamic>?,
  crosspost: json['crosspost'] as Map<String, dynamic>?,
  timestamp: DateTime.parse(json['timestamp'] as String),
  signature: json['signature'] as String,
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'content': instance.content.toJson(),
  'routing': instance.routing?.toJson(),
  'parent': instance.parent?.toJson(),
  'details': instance.details,
  'crosspost': instance.crosspost,
  'timestamp': instance.timestamp.toIso8601String(),
  'signature': instance.signature,
};
