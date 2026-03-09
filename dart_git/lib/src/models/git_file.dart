import 'package:json_annotation/json_annotation.dart';

part 'git_file.g.dart';

@JsonSerializable()
class GitFile {
  final String path;
  final String content;
  final String sha;

  const GitFile({
    required this.path,
    required this.content,
    required this.sha,
  });

  factory GitFile.fromJson(Map<String, dynamic> json) =>
      _$GitFileFromJson(json);

  Map<String, dynamic> toJson() => _$GitFileToJson(this);
}
