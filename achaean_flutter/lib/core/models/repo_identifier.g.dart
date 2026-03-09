// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_identifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepoIdentifierImpl _$$RepoIdentifierImplFromJson(Map<String, dynamic> json) =>
    _$RepoIdentifierImpl(
      baseUrl: json['baseUrl'] as String,
      owner: json['owner'] as String,
      repo: json['repo'] as String,
    );

Map<String, dynamic> _$$RepoIdentifierImplToJson(
  _$RepoIdentifierImpl instance,
) => <String, dynamic>{
  'baseUrl': instance.baseUrl,
  'owner': instance.owner,
  'repo': instance.repo,
};
