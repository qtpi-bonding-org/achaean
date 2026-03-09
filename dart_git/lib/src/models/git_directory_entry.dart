import 'package:json_annotation/json_annotation.dart';

part 'git_directory_entry.g.dart';

enum GitEntryType {
  file,
  dir,
}

@JsonSerializable()
class GitDirectoryEntry {
  final String name;
  final String path;
  final GitEntryType type;

  const GitDirectoryEntry({
    required this.name,
    required this.path,
    required this.type,
  });

  factory GitDirectoryEntry.fromJson(Map<String, dynamic> json) =>
      _$GitDirectoryEntryFromJson(json);

  Map<String, dynamic> toJson() => _$GitDirectoryEntryToJson(this);
}
