// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_routing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostRouting _$PostRoutingFromJson(Map<String, dynamic> json) => _PostRouting(
  poleis:
      (json['poleis'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  mentions:
      (json['mentions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$PostRoutingToJson(_PostRouting instance) =>
    <String, dynamic>{
      'poleis': instance.poleis,
      'tags': instance.tags,
      'mentions': instance.mentions,
    };
