// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitRepo _$GitRepoFromJson(Map<String, dynamic> json) => GitRepo(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  owner: json['owner'] as String,
  cloneUrl: json['cloneUrl'] as String,
  htmlUrl: json['htmlUrl'] as String,
  description: json['description'] as String?,
  private: json['private'] as bool? ?? false,
);

Map<String, dynamic> _$GitRepoToJson(GitRepo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'owner': instance.owner,
  'cloneUrl': instance.cloneUrl,
  'htmlUrl': instance.htmlUrl,
  'description': instance.description,
  'private': instance.private,
};
