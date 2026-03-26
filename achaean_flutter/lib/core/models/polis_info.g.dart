// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polis_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PolisInfo _$PolisInfoFromJson(Map<String, dynamic> json) => _PolisInfo(
  name: json['name'] as String,
  description: json['description'] as String?,
  norms: json['norms'] as String?,
  membershipThreshold: (json['membershipThreshold'] as num?)?.toInt(),
  flagThreshold: (json['flagThreshold'] as num?)?.toInt(),
  parentRepo: json['parentRepo'] as String?,
);

Map<String, dynamic> _$PolisInfoToJson(_PolisInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'norms': instance.norms,
      'membershipThreshold': instance.membershipThreshold,
      'flagThreshold': instance.flagThreshold,
      'parentRepo': instance.parentRepo,
    };
