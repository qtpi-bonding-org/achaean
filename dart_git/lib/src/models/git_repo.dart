import 'package:json_annotation/json_annotation.dart';

part 'git_repo.g.dart';

@JsonSerializable()
class GitRepo {
  final int id;
  final String name;
  final String owner;
  final String cloneUrl;
  final String htmlUrl;
  final String? description;
  final bool private;

  const GitRepo({
    required this.id,
    required this.name,
    required this.owner,
    required this.cloneUrl,
    required this.htmlUrl,
    this.description,
    this.private = false,
  });

  factory GitRepo.fromJson(Map<String, dynamic> json) =>
      _$GitRepoFromJson(json);

  Map<String, dynamic> toJson() => _$GitRepoToJson(this);
}
