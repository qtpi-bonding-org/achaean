// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_creation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountCreationResultImpl _$$AccountCreationResultImplFromJson(
  Map<String, dynamic> json,
) => _$AccountCreationResultImpl(
  pubkeyHex: json['pubkeyHex'] as String,
  repoOwner: json['repoOwner'] as String,
  repoName: json['repoName'] as String,
  repoUrl: json['repoUrl'] as String,
);

Map<String, dynamic> _$$AccountCreationResultImplToJson(
  _$AccountCreationResultImpl instance,
) => <String, dynamic>{
  'pubkeyHex': instance.pubkeyHex,
  'repoOwner': instance.repoOwner,
  'repoName': instance.repoName,
  'repoUrl': instance.repoUrl,
};
