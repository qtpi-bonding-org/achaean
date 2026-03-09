// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_creation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AccountCreationState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  AccountCreationResult? get result => throw _privateConstructorUsedError;

  /// Create a copy of AccountCreationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCreationStateCopyWith<AccountCreationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCreationStateCopyWith<$Res> {
  factory $AccountCreationStateCopyWith(
    AccountCreationState value,
    $Res Function(AccountCreationState) then,
  ) = _$AccountCreationStateCopyWithImpl<$Res, AccountCreationState>;
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    AccountCreationResult? result,
  });

  $AccountCreationResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$AccountCreationStateCopyWithImpl<
  $Res,
  $Val extends AccountCreationState
>
    implements $AccountCreationStateCopyWith<$Res> {
  _$AccountCreationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountCreationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? result = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UiFlowStatus,
            error: freezed == error ? _value.error : error,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as AccountCreationResult?,
          )
          as $Val,
    );
  }

  /// Create a copy of AccountCreationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountCreationResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $AccountCreationResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountCreationStateImplCopyWith<$Res>
    implements $AccountCreationStateCopyWith<$Res> {
  factory _$$AccountCreationStateImplCopyWith(
    _$AccountCreationStateImpl value,
    $Res Function(_$AccountCreationStateImpl) then,
  ) = __$$AccountCreationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    AccountCreationResult? result,
  });

  @override
  $AccountCreationResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$AccountCreationStateImplCopyWithImpl<$Res>
    extends _$AccountCreationStateCopyWithImpl<$Res, _$AccountCreationStateImpl>
    implements _$$AccountCreationStateImplCopyWith<$Res> {
  __$$AccountCreationStateImplCopyWithImpl(
    _$AccountCreationStateImpl _value,
    $Res Function(_$AccountCreationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountCreationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? result = freezed,
  }) {
    return _then(
      _$AccountCreationStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as AccountCreationResult?,
      ),
    );
  }
}

/// @nodoc

class _$AccountCreationStateImpl extends _AccountCreationState {
  const _$AccountCreationStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    this.result,
  }) : super._();

  @override
  @JsonKey()
  final UiFlowStatus status;
  @override
  final Object? error;
  @override
  final AccountCreationResult? result;

  @override
  String toString() {
    return 'AccountCreationState(status: $status, error: $error, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountCreationStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    result,
  );

  /// Create a copy of AccountCreationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountCreationStateImplCopyWith<_$AccountCreationStateImpl>
  get copyWith =>
      __$$AccountCreationStateImplCopyWithImpl<_$AccountCreationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AccountCreationState extends AccountCreationState {
  const factory _AccountCreationState({
    final UiFlowStatus status,
    final Object? error,
    final AccountCreationResult? result,
  }) = _$AccountCreationStateImpl;
  const _AccountCreationState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  AccountCreationResult? get result;

  /// Create a copy of AccountCreationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountCreationStateImplCopyWith<_$AccountCreationStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
