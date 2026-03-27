/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// A polis member with signer status and trust connection count.
abstract class PolisMember
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PolisMember._({
    required this.pubkey,
    required this.repoUrl,
    required this.isSigner,
    required this.trustConnections,
  });

  factory PolisMember({
    required String pubkey,
    required String repoUrl,
    required bool isSigner,
    required int trustConnections,
  }) = _PolisMemberImpl;

  factory PolisMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return PolisMember(
      pubkey: jsonSerialization['pubkey'] as String,
      repoUrl: jsonSerialization['repoUrl'] as String,
      isSigner: _i1.BoolJsonExtension.fromJson(jsonSerialization['isSigner']),
      trustConnections: jsonSerialization['trustConnections'] as int,
    );
  }

  /// Public key of the polites.
  String pubkey;

  /// Repo URL of the polites.
  String repoUrl;

  /// Whether the polites has signed the polis README.
  bool isSigner;

  /// Number of mutual trust connections from other signers in this polis.
  int trustConnections;

  /// Returns a shallow copy of this [PolisMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PolisMember copyWith({
    String? pubkey,
    String? repoUrl,
    bool? isSigner,
    int? trustConnections,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PolisMember',
      'pubkey': pubkey,
      'repoUrl': repoUrl,
      'isSigner': isSigner,
      'trustConnections': trustConnections,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PolisMember',
      'pubkey': pubkey,
      'repoUrl': repoUrl,
      'isSigner': isSigner,
      'trustConnections': trustConnections,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PolisMemberImpl extends PolisMember {
  _PolisMemberImpl({
    required String pubkey,
    required String repoUrl,
    required bool isSigner,
    required int trustConnections,
  }) : super._(
         pubkey: pubkey,
         repoUrl: repoUrl,
         isSigner: isSigner,
         trustConnections: trustConnections,
       );

  /// Returns a shallow copy of this [PolisMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PolisMember copyWith({
    String? pubkey,
    String? repoUrl,
    bool? isSigner,
    int? trustConnections,
  }) {
    return PolisMember(
      pubkey: pubkey ?? this.pubkey,
      repoUrl: repoUrl ?? this.repoUrl,
      isSigner: isSigner ?? this.isSigner,
      trustConnections: trustConnections ?? this.trustConnections,
    );
  }
}
