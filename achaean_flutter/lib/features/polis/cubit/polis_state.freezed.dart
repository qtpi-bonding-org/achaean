// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polis_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PolisState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<PolisMembership> get poleis => throw _privateConstructorUsedError;
  RepoIdentifier? get createdPolis => throw _privateConstructorUsedError;

  /// Create a copy of PolisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PolisStateCopyWith<PolisState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolisStateCopyWith<$Res> {
  factory $PolisStateCopyWith(
    PolisState value,
    $Res Function(PolisState) then,
  ) = _$PolisStateCopyWithImpl<$Res, PolisState>;
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<PolisMembership> poleis,
    RepoIdentifier? createdPolis,
  });

  $RepoIdentifierCopyWith<$Res>? get createdPolis;
}

/// @nodoc
class _$PolisStateCopyWithImpl<$Res, $Val extends PolisState>
    implements $PolisStateCopyWith<$Res> {
  _$PolisStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PolisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? poleis = null,
    Object? createdPolis = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UiFlowStatus,
            error: freezed == error ? _value.error : error,
            poleis: null == poleis
                ? _value.poleis
                : poleis // ignore: cast_nullable_to_non_nullable
                      as List<PolisMembership>,
            createdPolis: freezed == createdPolis
                ? _value.createdPolis
                : createdPolis // ignore: cast_nullable_to_non_nullable
                      as RepoIdentifier?,
          )
          as $Val,
    );
  }

  /// Create a copy of PolisState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RepoIdentifierCopyWith<$Res>? get createdPolis {
    if (_value.createdPolis == null) {
      return null;
    }

    return $RepoIdentifierCopyWith<$Res>(_value.createdPolis!, (value) {
      return _then(_value.copyWith(createdPolis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PolisStateImplCopyWith<$Res>
    implements $PolisStateCopyWith<$Res> {
  factory _$$PolisStateImplCopyWith(
    _$PolisStateImpl value,
    $Res Function(_$PolisStateImpl) then,
  ) = __$$PolisStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<PolisMembership> poleis,
    RepoIdentifier? createdPolis,
  });

  @override
  $RepoIdentifierCopyWith<$Res>? get createdPolis;
}

/// @nodoc
class __$$PolisStateImplCopyWithImpl<$Res>
    extends _$PolisStateCopyWithImpl<$Res, _$PolisStateImpl>
    implements _$$PolisStateImplCopyWith<$Res> {
  __$$PolisStateImplCopyWithImpl(
    _$PolisStateImpl _value,
    $Res Function(_$PolisStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PolisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? poleis = null,
    Object? createdPolis = freezed,
  }) {
    return _then(
      _$PolisStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        poleis: null == poleis
            ? _value._poleis
            : poleis // ignore: cast_nullable_to_non_nullable
                  as List<PolisMembership>,
        createdPolis: freezed == createdPolis
            ? _value.createdPolis
            : createdPolis // ignore: cast_nullable_to_non_nullable
                  as RepoIdentifier?,
      ),
    );
  }
}

/// @nodoc

class _$PolisStateImpl extends _PolisState {
  const _$PolisStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    final List<PolisMembership> poleis = const [],
    this.createdPolis,
  }) : _poleis = poleis,
       super._();

  @override
  @JsonKey()
  final UiFlowStatus status;
  @override
  final Object? error;
  final List<PolisMembership> _poleis;
  @override
  @JsonKey()
  List<PolisMembership> get poleis {
    if (_poleis is EqualUnmodifiableListView) return _poleis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_poleis);
  }

  @override
  final RepoIdentifier? createdPolis;

  @override
  String toString() {
    return 'PolisState(status: $status, error: $error, poleis: $poleis, createdPolis: $createdPolis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolisStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other._poleis, _poleis) &&
            (identical(other.createdPolis, createdPolis) ||
                other.createdPolis == createdPolis));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    const DeepCollectionEquality().hash(_poleis),
    createdPolis,
  );

  /// Create a copy of PolisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PolisStateImplCopyWith<_$PolisStateImpl> get copyWith =>
      __$$PolisStateImplCopyWithImpl<_$PolisStateImpl>(this, _$identity);
}

abstract class _PolisState extends PolisState {
  const factory _PolisState({
    final UiFlowStatus status,
    final Object? error,
    final List<PolisMembership> poleis,
    final RepoIdentifier? createdPolis,
  }) = _$PolisStateImpl;
  const _PolisState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  List<PolisMembership> get poleis;
  @override
  RepoIdentifier? get createdPolis;

  /// Create a copy of PolisState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PolisStateImplCopyWith<_$PolisStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
