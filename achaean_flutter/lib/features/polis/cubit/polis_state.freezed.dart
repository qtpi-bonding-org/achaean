// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polis_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PolisState {

 UiFlowStatus get status; Object? get error; List<PolisMembership> get poleis; RepoIdentifier? get createdPolis;
/// Create a copy of PolisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolisStateCopyWith<PolisState> get copyWith => _$PolisStateCopyWithImpl<PolisState>(this as PolisState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolisState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.poleis, poleis)&&(identical(other.createdPolis, createdPolis) || other.createdPolis == createdPolis));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(poleis),createdPolis);

@override
String toString() {
  return 'PolisState(status: $status, error: $error, poleis: $poleis, createdPolis: $createdPolis)';
}


}

/// @nodoc
abstract mixin class $PolisStateCopyWith<$Res>  {
  factory $PolisStateCopyWith(PolisState value, $Res Function(PolisState) _then) = _$PolisStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<PolisMembership> poleis, RepoIdentifier? createdPolis
});


$RepoIdentifierCopyWith<$Res>? get createdPolis;

}
/// @nodoc
class _$PolisStateCopyWithImpl<$Res>
    implements $PolisStateCopyWith<$Res> {
  _$PolisStateCopyWithImpl(this._self, this._then);

  final PolisState _self;
  final $Res Function(PolisState) _then;

/// Create a copy of PolisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? poleis = null,Object? createdPolis = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,poleis: null == poleis ? _self.poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<PolisMembership>,createdPolis: freezed == createdPolis ? _self.createdPolis : createdPolis // ignore: cast_nullable_to_non_nullable
as RepoIdentifier?,
  ));
}
/// Create a copy of PolisState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RepoIdentifierCopyWith<$Res>? get createdPolis {
    if (_self.createdPolis == null) {
    return null;
  }

  return $RepoIdentifierCopyWith<$Res>(_self.createdPolis!, (value) {
    return _then(_self.copyWith(createdPolis: value));
  });
}
}


/// Adds pattern-matching-related methods to [PolisState].
extension PolisStatePatterns on PolisState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PolisState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PolisState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PolisState value)  $default,){
final _that = this;
switch (_that) {
case _PolisState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PolisState value)?  $default,){
final _that = this;
switch (_that) {
case _PolisState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PolisMembership> poleis,  RepoIdentifier? createdPolis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PolisState() when $default != null:
return $default(_that.status,_that.error,_that.poleis,_that.createdPolis);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PolisMembership> poleis,  RepoIdentifier? createdPolis)  $default,) {final _that = this;
switch (_that) {
case _PolisState():
return $default(_that.status,_that.error,_that.poleis,_that.createdPolis);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<PolisMembership> poleis,  RepoIdentifier? createdPolis)?  $default,) {final _that = this;
switch (_that) {
case _PolisState() when $default != null:
return $default(_that.status,_that.error,_that.poleis,_that.createdPolis);case _:
  return null;

}
}

}

/// @nodoc


class _PolisState extends PolisState {
  const _PolisState({this.status = UiFlowStatus.idle, this.error, final  List<PolisMembership> poleis = const [], this.createdPolis}): _poleis = poleis,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<PolisMembership> _poleis;
@override@JsonKey() List<PolisMembership> get poleis {
  if (_poleis is EqualUnmodifiableListView) return _poleis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_poleis);
}

@override final  RepoIdentifier? createdPolis;

/// Create a copy of PolisState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolisStateCopyWith<_PolisState> get copyWith => __$PolisStateCopyWithImpl<_PolisState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolisState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._poleis, _poleis)&&(identical(other.createdPolis, createdPolis) || other.createdPolis == createdPolis));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_poleis),createdPolis);

@override
String toString() {
  return 'PolisState(status: $status, error: $error, poleis: $poleis, createdPolis: $createdPolis)';
}


}

/// @nodoc
abstract mixin class _$PolisStateCopyWith<$Res> implements $PolisStateCopyWith<$Res> {
  factory _$PolisStateCopyWith(_PolisState value, $Res Function(_PolisState) _then) = __$PolisStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<PolisMembership> poleis, RepoIdentifier? createdPolis
});


@override $RepoIdentifierCopyWith<$Res>? get createdPolis;

}
/// @nodoc
class __$PolisStateCopyWithImpl<$Res>
    implements _$PolisStateCopyWith<$Res> {
  __$PolisStateCopyWithImpl(this._self, this._then);

  final _PolisState _self;
  final $Res Function(_PolisState) _then;

/// Create a copy of PolisState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? poleis = null,Object? createdPolis = freezed,}) {
  return _then(_PolisState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,poleis: null == poleis ? _self._poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<PolisMembership>,createdPolis: freezed == createdPolis ? _self.createdPolis : createdPolis // ignore: cast_nullable_to_non_nullable
as RepoIdentifier?,
  ));
}

/// Create a copy of PolisState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RepoIdentifierCopyWith<$Res>? get createdPolis {
    if (_self.createdPolis == null) {
    return null;
  }

  return $RepoIdentifierCopyWith<$Res>(_self.createdPolis!, (value) {
    return _then(_self.copyWith(createdPolis: value));
  });
}
}

// dart format on
