// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FlagState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<FlagEntry> get flags => throw _privateConstructorUsedError;

  /// Create a copy of FlagState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlagStateCopyWith<FlagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlagStateCopyWith<$Res> {
  factory $FlagStateCopyWith(FlagState value, $Res Function(FlagState) then) =
      _$FlagStateCopyWithImpl<$Res, FlagState>;
  @useResult
  $Res call({UiFlowStatus status, Object? error, List<FlagEntry> flags});
}

/// @nodoc
class _$FlagStateCopyWithImpl<$Res, $Val extends FlagState>
    implements $FlagStateCopyWith<$Res> {
  _$FlagStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlagState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? flags = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UiFlowStatus,
            error: freezed == error ? _value.error : error,
            flags: null == flags
                ? _value.flags
                : flags // ignore: cast_nullable_to_non_nullable
                      as List<FlagEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlagStateImplCopyWith<$Res>
    implements $FlagStateCopyWith<$Res> {
  factory _$$FlagStateImplCopyWith(
    _$FlagStateImpl value,
    $Res Function(_$FlagStateImpl) then,
  ) = __$$FlagStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UiFlowStatus status, Object? error, List<FlagEntry> flags});
}

/// @nodoc
class __$$FlagStateImplCopyWithImpl<$Res>
    extends _$FlagStateCopyWithImpl<$Res, _$FlagStateImpl>
    implements _$$FlagStateImplCopyWith<$Res> {
  __$$FlagStateImplCopyWithImpl(
    _$FlagStateImpl _value,
    $Res Function(_$FlagStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlagState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? flags = null,
  }) {
    return _then(
      _$FlagStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        flags: null == flags
            ? _value._flags
            : flags // ignore: cast_nullable_to_non_nullable
                  as List<FlagEntry>,
      ),
    );
  }
}

/// @nodoc

class _$FlagStateImpl extends _FlagState {
  const _$FlagStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    final List<FlagEntry> flags = const [],
  }) : _flags = flags,
       super._();

  @override
  @JsonKey()
  final UiFlowStatus status;
  @override
  final Object? error;
  final List<FlagEntry> _flags;
  @override
  @JsonKey()
  List<FlagEntry> get flags {
    if (_flags is EqualUnmodifiableListView) return _flags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flags);
  }

  @override
  String toString() {
    return 'FlagState(status: $status, error: $error, flags: $flags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlagStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other._flags, _flags));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    const DeepCollectionEquality().hash(_flags),
  );

  /// Create a copy of FlagState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlagStateImplCopyWith<_$FlagStateImpl> get copyWith =>
      __$$FlagStateImplCopyWithImpl<_$FlagStateImpl>(this, _$identity);
}

abstract class _FlagState extends FlagState {
  const factory _FlagState({
    final UiFlowStatus status,
    final Object? error,
    final List<FlagEntry> flags,
  }) = _$FlagStateImpl;
  const _FlagState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  List<FlagEntry> get flags;

  /// Create a copy of FlagState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlagStateImplCopyWith<_$FlagStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
