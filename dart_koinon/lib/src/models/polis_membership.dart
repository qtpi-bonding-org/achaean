import 'package:freezed_annotation/freezed_annotation.dart';

part 'polis_membership.freezed.dart';
part 'polis_membership.g.dart';

/// An entry in the koinon.json poleis array.
@freezed
class PolisMembership with _$PolisMembership {
  const factory PolisMembership({
    /// The polis repo identifier.
    required String repo,

    /// Display name of the polis.
    required String name,

    /// Number of keypairs that signed the current README.
    required int stars,

    /// The user's role/trust level in this polis.
    required String role,
  }) = _PolisMembership;

  factory PolisMembership.fromJson(Map<String, dynamic> json) =>
      _$PolisMembershipFromJson(json);
}
