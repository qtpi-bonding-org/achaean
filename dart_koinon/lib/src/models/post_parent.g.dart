// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostParent _$PostParentFromJson(Map<String, dynamic> json) => _PostParent(
  author: json['author'] as String,
  repo: json['repo'] as String,
  path: json['path'] as String,
  commit: json['commit'] as String,
);

Map<String, dynamic> _$PostParentToJson(_PostParent instance) =>
    <String, dynamic>{
      'author': instance.author,
      'repo': instance.repo,
      'path': instance.path,
      'commit': instance.commit,
    };
