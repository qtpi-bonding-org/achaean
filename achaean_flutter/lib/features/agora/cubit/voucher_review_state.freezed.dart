// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$VoucherReviewState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<FlagRecord> get flaggedPosts => throw _privateConstructorUsedError;

  /// Create a copy of VoucherReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherReviewStateCopyWith<VoucherReviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherReviewStateCopyWith<$Res> {
  factory $VoucherReviewStateCopyWith(
    VoucherReviewState value,
    $Res Function(VoucherReviewState) then,
  ) = _$VoucherReviewStateCopyWithImpl<$Res, VoucherReviewState>;
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<FlagRecord> flaggedPosts,
  });
}

/// @nodoc
class _$VoucherReviewStateCopyWithImpl<$Res, $Val extends VoucherReviewState>
    implements $VoucherReviewStateCopyWith<$Res> {
  _$VoucherReviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoucherReviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? flaggedPosts = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UiFlowStatus,
            error: freezed == error ? _value.error : error,
            flaggedPosts: null == flaggedPosts
                ? _value.flaggedPosts
                : flaggedPosts // ignore: cast_nullable_to_non_nullable
                      as List<FlagRecord>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VoucherReviewStateImplCopyWith<$Res>
    implements $VoucherReviewStateCopyWith<$Res> {
  factory _$$VoucherReviewStateImplCopyWith(
    _$VoucherReviewStateImpl value,
    $Res Function(_$VoucherReviewStateImpl) then,
  ) = __$$VoucherReviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<FlagRecord> flaggedPosts,
  });
}

/// @nodoc
class __$$VoucherReviewStateImplCopyWithImpl<$Res>
    extends _$VoucherReviewStateCopyWithImpl<$Res, _$VoucherReviewStateImpl>
    implements _$$VoucherReviewStateImplCopyWith<$Res> {
  __$$VoucherReviewStateImplCopyWithImpl(
    _$VoucherReviewStateImpl _value,
    $Res Function(_$VoucherReviewStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VoucherReviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? flaggedPosts = null,
  }) {
    return _then(
      _$VoucherReviewStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        flaggedPosts: null == flaggedPosts
            ? _value._flaggedPosts
            : flaggedPosts // ignore: cast_nullable_to_non_nullable
                  as List<FlagRecord>,
      ),
    );
  }
}

/// @nodoc

class _$VoucherReviewStateImpl extends _VoucherReviewState {
  const _$VoucherReviewStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    final List<FlagRecord> flaggedPosts = const [],
  }) : _flaggedPosts = flaggedPosts,
       super._();

  @override
  @JsonKey()
  final UiFlowStatus status;
  @override
  final Object? error;
  final List<FlagRecord> _flaggedPosts;
  @override
  @JsonKey()
  List<FlagRecord> get flaggedPosts {
    if (_flaggedPosts is EqualUnmodifiableListView) return _flaggedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flaggedPosts);
  }

  @override
  String toString() {
    return 'VoucherReviewState(status: $status, error: $error, flaggedPosts: $flaggedPosts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherReviewStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(
              other._flaggedPosts,
              _flaggedPosts,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    const DeepCollectionEquality().hash(_flaggedPosts),
  );

  /// Create a copy of VoucherReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherReviewStateImplCopyWith<_$VoucherReviewStateImpl> get copyWith =>
      __$$VoucherReviewStateImplCopyWithImpl<_$VoucherReviewStateImpl>(
        this,
        _$identity,
      );
}

abstract class _VoucherReviewState extends VoucherReviewState {
  const factory _VoucherReviewState({
    final UiFlowStatus status,
    final Object? error,
    final List<FlagRecord> flaggedPosts,
  }) = _$VoucherReviewStateImpl;
  const _VoucherReviewState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  List<FlagRecord> get flaggedPosts;

  /// Create a copy of VoucherReviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherReviewStateImplCopyWith<_$VoucherReviewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
