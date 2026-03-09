import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_creation_result.freezed.dart';
part 'account_creation_result.g.dart';

@freezed
class AccountCreationResult with _$AccountCreationResult {
  const factory AccountCreationResult({
    required String pubkeyHex,
    required String repoOwner,
    required String repoName,
    required String repoUrl,
  }) = _AccountCreationResult;

  factory AccountCreationResult.fromJson(Map<String, dynamic> json) =>
      _$AccountCreationResultFromJson(json);
}
