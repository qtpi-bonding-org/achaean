import 'package:json_annotation/json_annotation.dart';

part 'git_commit.g.dart';

@JsonSerializable()
class GitCommit {
  final String sha;
  final String message;
  final DateTime timestamp;

  const GitCommit({
    required this.sha,
    required this.message,
    required this.timestamp,
  });

  factory GitCommit.fromJson(Map<String, dynamic> json) =>
      _$GitCommitFromJson(json);

  Map<String, dynamic> toJson() => _$GitCommitToJson(this);
}
