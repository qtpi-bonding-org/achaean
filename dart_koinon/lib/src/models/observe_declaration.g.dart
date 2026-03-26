// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observe_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ObserveDeclaration _$ObserveDeclarationFromJson(Map<String, dynamic> json) =>
    _ObserveDeclaration(
      type: json['type'] as String? ?? 'observe-declaration',
      subject: json['subject'] as String,
      repo: json['repo'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$ObserveDeclarationToJson(_ObserveDeclaration instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subject': instance.subject,
      'repo': instance.repo,
      'timestamp': instance.timestamp.toIso8601String(),
      'signature': instance.signature,
    };
