// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_creation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountCreationResult _$AccountCreationResultFromJson(
  Map<String, dynamic> json,
) => _AccountCreationResult(
  pubkeyHex: json['pubkeyHex'] as String,
  repoOwner: json['repoOwner'] as String,
  repoName: json['repoName'] as String,
  repoUrl: json['repoUrl'] as String,
);

Map<String, dynamic> _$AccountCreationResultToJson(
  _AccountCreationResult instance,
) => <String, dynamic>{
  'pubkeyHex': instance.pubkeyHex,
  'repoOwner': instance.repoOwner,
  'repoName': instance.repoName,
  'repoUrl': instance.repoUrl,
};
