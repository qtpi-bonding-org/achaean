import 'package:freezed_annotation/freezed_annotation.dart';

import 'flag_entry.dart';
import 'observe_entry.dart';
import 'polis_membership.dart';
import 'trust_entry.dart';

part 'koinon_manifest.freezed.dart';
part 'koinon_manifest.g.dart';

/// The .well-known/koinon.json discovery manifest.
@freezed
abstract class KoinonManifest with _$KoinonManifest {
  const factory KoinonManifest({
    /// Always "koinon".
    @Default('koinon') String protocol,

    /// Protocol version.
    @Default('1.0') String version,

    /// The polites's public key.
    required String pubkey,

    /// Radicle repo identifier (optional).
    @JsonKey(name: 'repo_radicle') String? repoRadicle,

    /// HTTPS repo URL.
    @JsonKey(name: 'repo_https') required String repoHttps,

    /// Poleis the user belongs to.
    @Default([]) List<PolisMembership> poleis,

    /// Inline trust declarations.
    @Default([]) List<TrustEntry> trust,

    /// Inline observe declarations (non-structural, personal feed only).
    @Default([]) List<ObserveEntry> observe,

    /// Post flags.
    @Default([]) List<FlagEntry> flags,
  }) = _KoinonManifest;

  factory KoinonManifest.fromJson(Map<String, dynamic> json) =>
      _$KoinonManifestFromJson(json);
}
