// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readme_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReadmeSignatureImpl _$$ReadmeSignatureImplFromJson(
  Map<String, dynamic> json,
) => _$ReadmeSignatureImpl(
  type: json['type'] as String? ?? 'readme-signature',
  polis: json['polis'] as String,
  readmeCommit: json['readme_commit'] as String,
  readmeHash: json['readme_hash'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  signature: json['signature'] as String,
);

Map<String, dynamic> _$$ReadmeSignatureImplToJson(
  _$ReadmeSignatureImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'polis': instance.polis,
  'readme_commit': instance.readmeCommit,
  'readme_hash': instance.readmeHash,
  'timestamp': instance.timestamp.toIso8601String(),
  'signature': instance.signature,
};
