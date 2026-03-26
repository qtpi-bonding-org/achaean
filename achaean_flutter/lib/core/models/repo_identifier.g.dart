// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_identifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RepoIdentifier _$RepoIdentifierFromJson(Map<String, dynamic> json) =>
    _RepoIdentifier(
      baseUrl: json['baseUrl'] as String,
      owner: json['owner'] as String,
      repo: json['repo'] as String,
    );

Map<String, dynamic> _$RepoIdentifierToJson(_RepoIdentifier instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'owner': instance.owner,
      'repo': instance.repo,
    };
