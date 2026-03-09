// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostParentImpl _$$PostParentImplFromJson(Map<String, dynamic> json) =>
    _$PostParentImpl(
      author: json['author'] as String,
      repo: json['repo'] as String,
      path: json['path'] as String,
      commit: json['commit'] as String,
    );

Map<String, dynamic> _$$PostParentImplToJson(_$PostParentImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'repo': instance.repo,
      'path': instance.path,
      'commit': instance.commit,
    };
