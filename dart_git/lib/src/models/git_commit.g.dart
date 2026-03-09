// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitCommit _$GitCommitFromJson(Map<String, dynamic> json) => GitCommit(
  sha: json['sha'] as String,
  message: json['message'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$GitCommitToJson(GitCommit instance) => <String, dynamic>{
  'sha': instance.sha,
  'message': instance.message,
  'timestamp': instance.timestamp.toIso8601String(),
};
