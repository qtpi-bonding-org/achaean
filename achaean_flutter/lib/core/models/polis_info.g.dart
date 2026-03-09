// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polis_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PolisInfoImpl _$$PolisInfoImplFromJson(Map<String, dynamic> json) =>
    _$PolisInfoImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      norms: json['norms'] as String?,
      threshold: (json['threshold'] as num?)?.toInt(),
      parentRepo: json['parentRepo'] as String?,
    );

Map<String, dynamic> _$$PolisInfoImplToJson(_$PolisInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'norms': instance.norms,
      'threshold': instance.threshold,
      'parentRepo': instance.parentRepo,
    };
