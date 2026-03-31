// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encrypted_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EncryptedPost _$EncryptedPostFromJson(Map<String, dynamic> json) =>
    _EncryptedPost(
      encryptedContent: json['encryptedContent'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$EncryptedPostToJson(_EncryptedPost instance) =>
    <String, dynamic>{
      'encryptedContent': instance.encryptedContent,
      'timestamp': instance.timestamp.toIso8601String(),
      'signature': instance.signature,
    };
