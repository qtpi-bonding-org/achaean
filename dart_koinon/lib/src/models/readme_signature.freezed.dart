// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'readme_signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReadmeSignature _$ReadmeSignatureFromJson(Map<String, dynamic> json) {
  return _ReadmeSignature.fromJson(json);
}

/// @nodoc
mixin _$ReadmeSignature {
  /// Always "readme-signature".
  String get type => throw _privateConstructorUsedError;

  /// The polis repo identifier.
  String get polis => throw _privateConstructorUsedError;

  /// Commit hash of the README version that was signed.
  @JsonKey(name: 'readme_commit')
  String get readmeCommit => throw _privateConstructorUsedError;

  /// Content hash of the README.
  @JsonKey(name: 'readme_hash')
  String get readmeHash => throw _privateConstructorUsedError;

  /// When the signature was made.
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Signer's Web Crypto signature.
  String get signature => throw _privateConstructorUsedError;

  /// Serializes this ReadmeSignature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReadmeSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReadmeSignatureCopyWith<ReadmeSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadmeSignatureCopyWith<$Res> {
  factory $ReadmeSignatureCopyWith(
    ReadmeSignature value,
    $Res Function(ReadmeSignature) then,
  ) = _$ReadmeSignatureCopyWithImpl<$Res, ReadmeSignature>;
  @useResult
  $Res call({
    String type,
    String polis,
    @JsonKey(name: 'readme_commit') String readmeCommit,
    @JsonKey(name: 'readme_hash') String readmeHash,
    DateTime timestamp,
    String signature,
  });
}

/// @nodoc
class _$ReadmeSignatureCopyWithImpl<$Res, $Val extends ReadmeSignature>
    implements $ReadmeSignatureCopyWith<$Res> {
  _$ReadmeSignatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReadmeSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? polis = null,
    Object? readmeCommit = null,
    Object? readmeHash = null,
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            polis: null == polis
                ? _value.polis
                : polis // ignore: cast_nullable_to_non_nullable
                      as String,
            readmeCommit: null == readmeCommit
                ? _value.readmeCommit
                : readmeCommit // ignore: cast_nullable_to_non_nullable
                      as String,
            readmeHash: null == readmeHash
                ? _value.readmeHash
                : readmeHash // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            signature: null == signature
                ? _value.signature
                : signature // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReadmeSignatureImplCopyWith<$Res>
    implements $ReadmeSignatureCopyWith<$Res> {
  factory _$$ReadmeSignatureImplCopyWith(
    _$ReadmeSignatureImpl value,
    $Res Function(_$ReadmeSignatureImpl) then,
  ) = __$$ReadmeSignatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String polis,
    @JsonKey(name: 'readme_commit') String readmeCommit,
    @JsonKey(name: 'readme_hash') String readmeHash,
    DateTime timestamp,
    String signature,
  });
}

/// @nodoc
class __$$ReadmeSignatureImplCopyWithImpl<$Res>
    extends _$ReadmeSignatureCopyWithImpl<$Res, _$ReadmeSignatureImpl>
    implements _$$ReadmeSignatureImplCopyWith<$Res> {
  __$$ReadmeSignatureImplCopyWithImpl(
    _$ReadmeSignatureImpl _value,
    $Res Function(_$ReadmeSignatureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReadmeSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? polis = null,
    Object? readmeCommit = null,
    Object? readmeHash = null,
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(
      _$ReadmeSignatureImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        polis: null == polis
            ? _value.polis
            : polis // ignore: cast_nullable_to_non_nullable
                  as String,
        readmeCommit: null == readmeCommit
            ? _value.readmeCommit
            : readmeCommit // ignore: cast_nullable_to_non_nullable
                  as String,
        readmeHash: null == readmeHash
            ? _value.readmeHash
            : readmeHash // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        signature: null == signature
            ? _value.signature
            : signature // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadmeSignatureImpl implements _ReadmeSignature {
  const _$ReadmeSignatureImpl({
    this.type = 'readme-signature',
    required this.polis,
    @JsonKey(name: 'readme_commit') required this.readmeCommit,
    @JsonKey(name: 'readme_hash') required this.readmeHash,
    required this.timestamp,
    required this.signature,
  });

  factory _$ReadmeSignatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadmeSignatureImplFromJson(json);

  /// Always "readme-signature".
  @override
  @JsonKey()
  final String type;

  /// The polis repo identifier.
  @override
  final String polis;

  /// Commit hash of the README version that was signed.
  @override
  @JsonKey(name: 'readme_commit')
  final String readmeCommit;

  /// Content hash of the README.
  @override
  @JsonKey(name: 'readme_hash')
  final String readmeHash;

  /// When the signature was made.
  @override
  final DateTime timestamp;

  /// Signer's Web Crypto signature.
  @override
  final String signature;

  @override
  String toString() {
    return 'ReadmeSignature(type: $type, polis: $polis, readmeCommit: $readmeCommit, readmeHash: $readmeHash, timestamp: $timestamp, signature: $signature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadmeSignatureImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.polis, polis) || other.polis == polis) &&
            (identical(other.readmeCommit, readmeCommit) ||
                other.readmeCommit == readmeCommit) &&
            (identical(other.readmeHash, readmeHash) ||
                other.readmeHash == readmeHash) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    polis,
    readmeCommit,
    readmeHash,
    timestamp,
    signature,
  );

  /// Create a copy of ReadmeSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadmeSignatureImplCopyWith<_$ReadmeSignatureImpl> get copyWith =>
      __$$ReadmeSignatureImplCopyWithImpl<_$ReadmeSignatureImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadmeSignatureImplToJson(this);
  }
}

abstract class _ReadmeSignature implements ReadmeSignature {
  const factory _ReadmeSignature({
    final String type,
    required final String polis,
    @JsonKey(name: 'readme_commit') required final String readmeCommit,
    @JsonKey(name: 'readme_hash') required final String readmeHash,
    required final DateTime timestamp,
    required final String signature,
  }) = _$ReadmeSignatureImpl;

  factory _ReadmeSignature.fromJson(Map<String, dynamic> json) =
      _$ReadmeSignatureImpl.fromJson;

  /// Always "readme-signature".
  @override
  String get type;

  /// The polis repo identifier.
  @override
  String get polis;

  /// Commit hash of the README version that was signed.
  @override
  @JsonKey(name: 'readme_commit')
  String get readmeCommit;

  /// Content hash of the README.
  @override
  @JsonKey(name: 'readme_hash')
  String get readmeHash;

  /// When the signature was made.
  @override
  DateTime get timestamp;

  /// Signer's Web Crypto signature.
  @override
  String get signature;

  /// Create a copy of ReadmeSignature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadmeSignatureImplCopyWith<_$ReadmeSignatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
