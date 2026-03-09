// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_creation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AccountCreationResult _$AccountCreationResultFromJson(
  Map<String, dynamic> json,
) {
  return _AccountCreationResult.fromJson(json);
}

/// @nodoc
mixin _$AccountCreationResult {
  String get pubkeyHex => throw _privateConstructorUsedError;
  String get repoOwner => throw _privateConstructorUsedError;
  String get repoName => throw _privateConstructorUsedError;
  String get repoUrl => throw _privateConstructorUsedError;

  /// Serializes this AccountCreationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCreationResultCopyWith<AccountCreationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCreationResultCopyWith<$Res> {
  factory $AccountCreationResultCopyWith(
    AccountCreationResult value,
    $Res Function(AccountCreationResult) then,
  ) = _$AccountCreationResultCopyWithImpl<$Res, AccountCreationResult>;
  @useResult
  $Res call({
    String pubkeyHex,
    String repoOwner,
    String repoName,
    String repoUrl,
  });
}

/// @nodoc
class _$AccountCreationResultCopyWithImpl<
  $Res,
  $Val extends AccountCreationResult
>
    implements $AccountCreationResultCopyWith<$Res> {
  _$AccountCreationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pubkeyHex = null,
    Object? repoOwner = null,
    Object? repoName = null,
    Object? repoUrl = null,
  }) {
    return _then(
      _value.copyWith(
            pubkeyHex: null == pubkeyHex
                ? _value.pubkeyHex
                : pubkeyHex // ignore: cast_nullable_to_non_nullable
                      as String,
            repoOwner: null == repoOwner
                ? _value.repoOwner
                : repoOwner // ignore: cast_nullable_to_non_nullable
                      as String,
            repoName: null == repoName
                ? _value.repoName
                : repoName // ignore: cast_nullable_to_non_nullable
                      as String,
            repoUrl: null == repoUrl
                ? _value.repoUrl
                : repoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountCreationResultImplCopyWith<$Res>
    implements $AccountCreationResultCopyWith<$Res> {
  factory _$$AccountCreationResultImplCopyWith(
    _$AccountCreationResultImpl value,
    $Res Function(_$AccountCreationResultImpl) then,
  ) = __$$AccountCreationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String pubkeyHex,
    String repoOwner,
    String repoName,
    String repoUrl,
  });
}

/// @nodoc
class __$$AccountCreationResultImplCopyWithImpl<$Res>
    extends
        _$AccountCreationResultCopyWithImpl<$Res, _$AccountCreationResultImpl>
    implements _$$AccountCreationResultImplCopyWith<$Res> {
  __$$AccountCreationResultImplCopyWithImpl(
    _$AccountCreationResultImpl _value,
    $Res Function(_$AccountCreationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pubkeyHex = null,
    Object? repoOwner = null,
    Object? repoName = null,
    Object? repoUrl = null,
  }) {
    return _then(
      _$AccountCreationResultImpl(
        pubkeyHex: null == pubkeyHex
            ? _value.pubkeyHex
            : pubkeyHex // ignore: cast_nullable_to_non_nullable
                  as String,
        repoOwner: null == repoOwner
            ? _value.repoOwner
            : repoOwner // ignore: cast_nullable_to_non_nullable
                  as String,
        repoName: null == repoName
            ? _value.repoName
            : repoName // ignore: cast_nullable_to_non_nullable
                  as String,
        repoUrl: null == repoUrl
            ? _value.repoUrl
            : repoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountCreationResultImpl implements _AccountCreationResult {
  const _$AccountCreationResultImpl({
    required this.pubkeyHex,
    required this.repoOwner,
    required this.repoName,
    required this.repoUrl,
  });

  factory _$AccountCreationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountCreationResultImplFromJson(json);

  @override
  final String pubkeyHex;
  @override
  final String repoOwner;
  @override
  final String repoName;
  @override
  final String repoUrl;

  @override
  String toString() {
    return 'AccountCreationResult(pubkeyHex: $pubkeyHex, repoOwner: $repoOwner, repoName: $repoName, repoUrl: $repoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountCreationResultImpl &&
            (identical(other.pubkeyHex, pubkeyHex) ||
                other.pubkeyHex == pubkeyHex) &&
            (identical(other.repoOwner, repoOwner) ||
                other.repoOwner == repoOwner) &&
            (identical(other.repoName, repoName) ||
                other.repoName == repoName) &&
            (identical(other.repoUrl, repoUrl) || other.repoUrl == repoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, pubkeyHex, repoOwner, repoName, repoUrl);

  /// Create a copy of AccountCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountCreationResultImplCopyWith<_$AccountCreationResultImpl>
  get copyWith =>
      __$$AccountCreationResultImplCopyWithImpl<_$AccountCreationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountCreationResultImplToJson(this);
  }
}

abstract class _AccountCreationResult implements AccountCreationResult {
  const factory _AccountCreationResult({
    required final String pubkeyHex,
    required final String repoOwner,
    required final String repoName,
    required final String repoUrl,
  }) = _$AccountCreationResultImpl;

  factory _AccountCreationResult.fromJson(Map<String, dynamic> json) =
      _$AccountCreationResultImpl.fromJson;

  @override
  String get pubkeyHex;
  @override
  String get repoOwner;
  @override
  String get repoName;
  @override
  String get repoUrl;

  /// Create a copy of AccountCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountCreationResultImplCopyWith<_$AccountCreationResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}
