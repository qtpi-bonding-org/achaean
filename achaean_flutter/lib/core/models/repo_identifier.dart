import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_identifier.freezed.dart';
part 'repo_identifier.g.dart';

/// Value type for referring to any git repo.
@freezed
class RepoIdentifier with _$RepoIdentifier {
  const factory RepoIdentifier({
    required String baseUrl,
    required String owner,
    required String repo,
  }) = _RepoIdentifier;

  factory RepoIdentifier.fromJson(Map<String, dynamic> json) =>
      _$RepoIdentifierFromJson(json);
}
