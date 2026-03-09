// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrustState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<TrustDeclaration> get declarations => throw _privateConstructorUsedError;

  /// Create a copy of TrustState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrustStateCopyWith<TrustState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustStateCopyWith<$Res> {
  factory $TrustStateCopyWith(
    TrustState value,
    $Res Function(TrustState) then,
  ) = _$TrustStateCopyWithImpl<$Res, TrustState>;
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<TrustDeclaration> declarations,
  });
}

/// @nodoc
class _$TrustStateCopyWithImpl<$Res, $Val extends TrustState>
    implements $TrustStateCopyWith<$Res> {
  _$TrustStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrustState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? declarations = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UiFlowStatus,
            error: freezed == error ? _value.error : error,
            declarations: null == declarations
                ? _value.declarations
                : declarations // ignore: cast_nullable_to_non_nullable
                      as List<TrustDeclaration>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrustStateImplCopyWith<$Res>
    implements $TrustStateCopyWith<$Res> {
  factory _$$TrustStateImplCopyWith(
    _$TrustStateImpl value,
    $Res Function(_$TrustStateImpl) then,
  ) = __$$TrustStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<TrustDeclaration> declarations,
  });
}

/// @nodoc
class __$$TrustStateImplCopyWithImpl<$Res>
    extends _$TrustStateCopyWithImpl<$Res, _$TrustStateImpl>
    implements _$$TrustStateImplCopyWith<$Res> {
  __$$TrustStateImplCopyWithImpl(
    _$TrustStateImpl _value,
    $Res Function(_$TrustStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrustState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? declarations = null,
  }) {
    return _then(
      _$TrustStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        declarations: null == declarations
            ? _value._declarations
            : declarations // ignore: cast_nullable_to_non_nullable
                  as List<TrustDeclaration>,
      ),
    );
  }
}

/// @nodoc

class _$TrustStateImpl extends _TrustState {
  const _$TrustStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    final List<TrustDeclaration> declarations = const [],
  }) : _declarations = declarations,
       super._();

  @override
  @JsonKey()
  final UiFlowStatus status;
  @override
  final Object? error;
  final List<TrustDeclaration> _declarations;
  @override
  @JsonKey()
  List<TrustDeclaration> get declarations {
    if (_declarations is EqualUnmodifiableListView) return _declarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_declarations);
  }

  @override
  String toString() {
    return 'TrustState(status: $status, error: $error, declarations: $declarations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrustStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(
              other._declarations,
              _declarations,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    const DeepCollectionEquality().hash(_declarations),
  );

  /// Create a copy of TrustState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustStateImplCopyWith<_$TrustStateImpl> get copyWith =>
      __$$TrustStateImplCopyWithImpl<_$TrustStateImpl>(this, _$identity);
}

abstract class _TrustState extends TrustState {
  const factory _TrustState({
    final UiFlowStatus status,
    final Object? error,
    final List<TrustDeclaration> declarations,
  }) = _$TrustStateImpl;
  const _TrustState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  List<TrustDeclaration> get declarations;

  /// Create a copy of TrustState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrustStateImplCopyWith<_$TrustStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
