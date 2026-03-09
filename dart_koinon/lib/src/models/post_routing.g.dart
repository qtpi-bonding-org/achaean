// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_routing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostRoutingImpl _$$PostRoutingImplFromJson(
  Map<String, dynamic> json,
) => _$PostRoutingImpl(
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

Map<String, dynamic> _$$PostRoutingImplToJson(_$PostRoutingImpl instance) =>
    <String, dynamic>{
      'poleis': instance.poleis,
      'tags': instance.tags,
      'mentions': instance.mentions,
    };
