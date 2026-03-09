// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrustDeclaration _$TrustDeclarationFromJson(Map<String, dynamic> json) {
  return _TrustDeclaration.fromJson(json);
}

/// @nodoc
mixin _$TrustDeclaration {
  /// Always "trust-declaration".
  String get type => throw _privateConstructorUsedError;

  /// Subject's public key.
  String get subject => throw _privateConstructorUsedError;

  /// Subject's repo URL (enables trust graph traversal).
  String get repo => throw _privateConstructorUsedError;

  /// Trust level: TRUST or PROVISIONAL.
  TrustLevel get level => throw _privateConstructorUsedError;

  /// When the declaration was made.
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Author's Web Crypto signature.
  String get signature => throw _privateConstructorUsedError;

  /// Serializes this TrustDeclaration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrustDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrustDeclarationCopyWith<TrustDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustDeclarationCopyWith<$Res> {
  factory $TrustDeclarationCopyWith(
    TrustDeclaration value,
    $Res Function(TrustDeclaration) then,
  ) = _$TrustDeclarationCopyWithImpl<$Res, TrustDeclaration>;
  @useResult
  $Res call({
    String type,
    String subject,
    String repo,
    TrustLevel level,
    DateTime timestamp,
    String signature,
  });
}

/// @nodoc
class _$TrustDeclarationCopyWithImpl<$Res, $Val extends TrustDeclaration>
    implements $TrustDeclarationCopyWith<$Res> {
  _$TrustDeclarationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrustDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? subject = null,
    Object? repo = null,
    Object? level = null,
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            repo: null == repo
                ? _value.repo
                : repo // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as TrustLevel,
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
abstract class _$$TrustDeclarationImplCopyWith<$Res>
    implements $TrustDeclarationCopyWith<$Res> {
  factory _$$TrustDeclarationImplCopyWith(
    _$TrustDeclarationImpl value,
    $Res Function(_$TrustDeclarationImpl) then,
  ) = __$$TrustDeclarationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String subject,
    String repo,
    TrustLevel level,
    DateTime timestamp,
    String signature,
  });
}

/// @nodoc
class __$$TrustDeclarationImplCopyWithImpl<$Res>
    extends _$TrustDeclarationCopyWithImpl<$Res, _$TrustDeclarationImpl>
    implements _$$TrustDeclarationImplCopyWith<$Res> {
  __$$TrustDeclarationImplCopyWithImpl(
    _$TrustDeclarationImpl _value,
    $Res Function(_$TrustDeclarationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrustDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? subject = null,
    Object? repo = null,
    Object? level = null,
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(
      _$TrustDeclarationImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        repo: null == repo
            ? _value.repo
            : repo // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as TrustLevel,
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
class _$TrustDeclarationImpl implements _TrustDeclaration {
  const _$TrustDeclarationImpl({
    this.type = 'trust-declaration',
    required this.subject,
    required this.repo,
    required this.level,
    required this.timestamp,
    required this.signature,
  });

  factory _$TrustDeclarationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrustDeclarationImplFromJson(json);

  /// Always "trust-declaration".
  @override
  @JsonKey()
  final String type;

  /// Subject's public key.
  @override
  final String subject;

  /// Subject's repo URL (enables trust graph traversal).
  @override
  final String repo;

  /// Trust level: TRUST or PROVISIONAL.
  @override
  final TrustLevel level;

  /// When the declaration was made.
  @override
  final DateTime timestamp;

  /// Author's Web Crypto signature.
  @override
  final String signature;

  @override
  String toString() {
    return 'TrustDeclaration(type: $type, subject: $subject, repo: $repo, level: $level, timestamp: $timestamp, signature: $signature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrustDeclarationImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.repo, repo) || other.repo == repo) &&
            (identical(other.level, level) || other.level == level) &&
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
    subject,
    repo,
    level,
    timestamp,
    signature,
  );

  /// Create a copy of TrustDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustDeclarationImplCopyWith<_$TrustDeclarationImpl> get copyWith =>
      __$$TrustDeclarationImplCopyWithImpl<_$TrustDeclarationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrustDeclarationImplToJson(this);
  }
}

abstract class _TrustDeclaration implements TrustDeclaration {
  const factory _TrustDeclaration({
    final String type,
    required final String subject,
    required final String repo,
    required final TrustLevel level,
    required final DateTime timestamp,
    required final String signature,
  }) = _$TrustDeclarationImpl;

  factory _TrustDeclaration.fromJson(Map<String, dynamic> json) =
      _$TrustDeclarationImpl.fromJson;

  /// Always "trust-declaration".
  @override
  String get type;

  /// Subject's public key.
  @override
  String get subject;

  /// Subject's repo URL (enables trust graph traversal).
  @override
  String get repo;

  /// Trust level: TRUST or PROVISIONAL.
  @override
  TrustLevel get level;

  /// When the declaration was made.
  @override
  DateTime get timestamp;

  /// Author's Web Crypto signature.
  @override
  String get signature;

  /// Create a copy of TrustDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrustDeclarationImplCopyWith<_$TrustDeclarationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
