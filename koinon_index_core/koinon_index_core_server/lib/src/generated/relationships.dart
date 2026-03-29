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
import 'trust_declaration_record.dart' as _i2;
import 'observe_declaration_record.dart' as _i3;
import 'package:koinon_index_core_server/src/generated/protocol.dart' as _i4;

/// All trust and observe relationships for a polites, in both directions.
abstract class Relationships
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Relationships._({
    required this.outgoingTrust,
    required this.incomingTrust,
    required this.outgoingObserve,
    required this.incomingObserve,
  });

  factory Relationships({
    required List<_i2.TrustDeclarationRecord> outgoingTrust,
    required List<_i2.TrustDeclarationRecord> incomingTrust,
    required List<_i3.ObserveDeclarationRecord> outgoingObserve,
    required List<_i3.ObserveDeclarationRecord> incomingObserve,
  }) = _RelationshipsImpl;

  factory Relationships.fromJson(Map<String, dynamic> jsonSerialization) {
    return Relationships(
      outgoingTrust: _i4.Protocol()
          .deserialize<List<_i2.TrustDeclarationRecord>>(
            jsonSerialization['outgoingTrust'],
          ),
      incomingTrust: _i4.Protocol()
          .deserialize<List<_i2.TrustDeclarationRecord>>(
            jsonSerialization['incomingTrust'],
          ),
      outgoingObserve: _i4.Protocol()
          .deserialize<List<_i3.ObserveDeclarationRecord>>(
            jsonSerialization['outgoingObserve'],
          ),
      incomingObserve: _i4.Protocol()
          .deserialize<List<_i3.ObserveDeclarationRecord>>(
            jsonSerialization['incomingObserve'],
          ),
    );
  }

  List<_i2.TrustDeclarationRecord> outgoingTrust;

  List<_i2.TrustDeclarationRecord> incomingTrust;

  List<_i3.ObserveDeclarationRecord> outgoingObserve;

  List<_i3.ObserveDeclarationRecord> incomingObserve;

  /// Returns a shallow copy of this [Relationships]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Relationships copyWith({
    List<_i2.TrustDeclarationRecord>? outgoingTrust,
    List<_i2.TrustDeclarationRecord>? incomingTrust,
    List<_i3.ObserveDeclarationRecord>? outgoingObserve,
    List<_i3.ObserveDeclarationRecord>? incomingObserve,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'koinon_index_core.Relationships',
      'outgoingTrust': outgoingTrust.toJson(valueToJson: (v) => v.toJson()),
      'incomingTrust': incomingTrust.toJson(valueToJson: (v) => v.toJson()),
      'outgoingObserve': outgoingObserve.toJson(valueToJson: (v) => v.toJson()),
      'incomingObserve': incomingObserve.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'koinon_index_core.Relationships',
      'outgoingTrust': outgoingTrust.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'incomingTrust': incomingTrust.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'outgoingObserve': outgoingObserve.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'incomingObserve': incomingObserve.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _RelationshipsImpl extends Relationships {
  _RelationshipsImpl({
    required List<_i2.TrustDeclarationRecord> outgoingTrust,
    required List<_i2.TrustDeclarationRecord> incomingTrust,
    required List<_i3.ObserveDeclarationRecord> outgoingObserve,
    required List<_i3.ObserveDeclarationRecord> incomingObserve,
  }) : super._(
         outgoingTrust: outgoingTrust,
         incomingTrust: incomingTrust,
         outgoingObserve: outgoingObserve,
         incomingObserve: incomingObserve,
       );

  /// Returns a shallow copy of this [Relationships]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Relationships copyWith({
    List<_i2.TrustDeclarationRecord>? outgoingTrust,
    List<_i2.TrustDeclarationRecord>? incomingTrust,
    List<_i3.ObserveDeclarationRecord>? outgoingObserve,
    List<_i3.ObserveDeclarationRecord>? incomingObserve,
  }) {
    return Relationships(
      outgoingTrust:
          outgoingTrust ??
          this.outgoingTrust.map((e0) => e0.copyWith()).toList(),
      incomingTrust:
          incomingTrust ??
          this.incomingTrust.map((e0) => e0.copyWith()).toList(),
      outgoingObserve:
          outgoingObserve ??
          this.outgoingObserve.map((e0) => e0.copyWith()).toList(),
      incomingObserve:
          incomingObserve ??
          this.incomingObserve.map((e0) => e0.copyWith()).toList(),
    );
  }
}
