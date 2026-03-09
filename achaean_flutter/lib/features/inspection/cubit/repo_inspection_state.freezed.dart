// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_inspection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RepoInspectionState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  RepoInspectionResult? get result => throw _privateConstructorUsedError;

  /// Create a copy of RepoInspectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepoInspectionStateCopyWith<RepoInspectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoInspectionStateCopyWith<$Res> {
  factory $RepoInspectionStateCopyWith(
    RepoInspectionState value,
    $Res Function(RepoInspectionState) then,
  ) = _$RepoInspectionStateCopyWithImpl<$Res, RepoInspectionState>;
  @useResult
  $Res call({UiFlowStatus status, Object? error, RepoInspectionResult? result});

  $RepoInspectionResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$RepoInspectionStateCopyWithImpl<$Res, $Val extends RepoInspectionState>
    implements $RepoInspectionStateCopyWith<$Res> {
  _$RepoInspectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepoInspectionState
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
                      as RepoInspectionResult?,
          )
          as $Val,
    );
  }

  /// Create a copy of RepoInspectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RepoInspectionResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $RepoInspectionResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RepoInspectionStateImplCopyWith<$Res>
    implements $RepoInspectionStateCopyWith<$Res> {
  factory _$$RepoInspectionStateImplCopyWith(
    _$RepoInspectionStateImpl value,
    $Res Function(_$RepoInspectionStateImpl) then,
  ) = __$$RepoInspectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UiFlowStatus status, Object? error, RepoInspectionResult? result});

  @override
  $RepoInspectionResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$RepoInspectionStateImplCopyWithImpl<$Res>
    extends _$RepoInspectionStateCopyWithImpl<$Res, _$RepoInspectionStateImpl>
    implements _$$RepoInspectionStateImplCopyWith<$Res> {
  __$$RepoInspectionStateImplCopyWithImpl(
    _$RepoInspectionStateImpl _value,
    $Res Function(_$RepoInspectionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepoInspectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? result = freezed,
  }) {
    return _then(
      _$RepoInspectionStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as RepoInspectionResult?,
      ),
    );
  }
}

/// @nodoc

class _$RepoInspectionStateImpl extends _RepoInspectionState {
  const _$RepoInspectionStateImpl({
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
  final RepoInspectionResult? result;

  @override
  String toString() {
    return 'RepoInspectionState(status: $status, error: $error, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoInspectionStateImpl &&
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

  /// Create a copy of RepoInspectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoInspectionStateImplCopyWith<_$RepoInspectionStateImpl> get copyWith =>
      __$$RepoInspectionStateImplCopyWithImpl<_$RepoInspectionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RepoInspectionState extends RepoInspectionState {
  const factory _RepoInspectionState({
    final UiFlowStatus status,
    final Object? error,
    final RepoInspectionResult? result,
  }) = _$RepoInspectionStateImpl;
  const _RepoInspectionState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  RepoInspectionResult? get result;

  /// Create a copy of RepoInspectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepoInspectionStateImplCopyWith<_$RepoInspectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
