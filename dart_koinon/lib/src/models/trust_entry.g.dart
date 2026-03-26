// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrustEntry _$TrustEntryFromJson(Map<String, dynamic> json) => _TrustEntry(
  subject: json['subject'] as String,
  repo: json['repo'] as String,
  level: $enumDecode(_$TrustLevelEnumMap, json['level']),
);

Map<String, dynamic> _$TrustEntryToJson(_TrustEntry instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'repo': instance.repo,
      'level': _$TrustLevelEnumMap[instance.level]!,
    };

const _$TrustLevelEnumMap = {
  TrustLevel.trust: 'trust',
  TrustLevel.provisional: 'provisional',
};
