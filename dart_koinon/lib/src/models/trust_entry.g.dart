// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrustEntryImpl _$$TrustEntryImplFromJson(Map<String, dynamic> json) =>
    _$TrustEntryImpl(
      subject: json['subject'] as String,
      repo: json['repo'] as String,
      level: $enumDecode(_$TrustLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$$TrustEntryImplToJson(_$TrustEntryImpl instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'repo': instance.repo,
      'level': _$TrustLevelEnumMap[instance.level]!,
    };

const _$TrustLevelEnumMap = {
  TrustLevel.trust: 'trust',
  TrustLevel.provisional: 'provisional',
};
