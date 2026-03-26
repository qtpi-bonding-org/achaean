// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'koinon_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KoinonManifest _$KoinonManifestFromJson(Map<String, dynamic> json) =>
    _KoinonManifest(
      protocol: json['protocol'] as String? ?? 'koinon',
      version: json['version'] as String? ?? '1.0',
      pubkey: json['pubkey'] as String,
      repoRadicle: json['repo_radicle'] as String?,
      repoHttps: json['repo_https'] as String,
      poleis:
          (json['poleis'] as List<dynamic>?)
              ?.map((e) => PolisMembership.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      trust:
          (json['trust'] as List<dynamic>?)
              ?.map((e) => TrustEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      observe:
          (json['observe'] as List<dynamic>?)
              ?.map((e) => ObserveEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      flags:
          (json['flags'] as List<dynamic>?)
              ?.map((e) => FlagEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$KoinonManifestToJson(_KoinonManifest instance) =>
    <String, dynamic>{
      'protocol': instance.protocol,
      'version': instance.version,
      'pubkey': instance.pubkey,
      'repo_radicle': instance.repoRadicle,
      'repo_https': instance.repoHttps,
      'poleis': instance.poleis.map((e) => e.toJson()).toList(),
      'trust': instance.trust.map((e) => e.toJson()).toList(),
      'observe': instance.observe.map((e) => e.toJson()).toList(),
      'flags': instance.flags.map((e) => e.toJson()).toList(),
    };
