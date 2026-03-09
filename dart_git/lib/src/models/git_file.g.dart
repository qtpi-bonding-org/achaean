// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitFile _$GitFileFromJson(Map<String, dynamic> json) => GitFile(
  path: json['path'] as String,
  content: json['content'] as String,
  sha: json['sha'] as String,
);

Map<String, dynamic> _$GitFileToJson(GitFile instance) => <String, dynamic>{
  'path': instance.path,
  'content': instance.content,
  'sha': instance.sha,
};
