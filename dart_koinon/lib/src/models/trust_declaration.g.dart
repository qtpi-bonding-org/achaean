// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrustDeclaration _$TrustDeclarationFromJson(Map<String, dynamic> json) =>
    _TrustDeclaration(
      type: json['type'] as String? ?? 'trust-declaration',
      subject: json['subject'] as String,
      repo: json['repo'] as String,
      level: $enumDecode(_$TrustLevelEnumMap, json['level']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$TrustDeclarationToJson(_TrustDeclaration instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subject': instance.subject,
      'repo': instance.repo,
      'level': _$TrustLevelEnumMap[instance.level]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'signature': instance.signature,
    };

const _$TrustLevelEnumMap = {
  TrustLevel.trust: 'trust',
  TrustLevel.provisional: 'provisional',
};
