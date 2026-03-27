// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polis_discovery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PolisDiscoveryState {

 UiFlowStatus get status; Object? get error; List<PolisDefinition> get poleis; List<PolisMember> get members;
/// Create a copy of PolisDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolisDiscoveryStateCopyWith<PolisDiscoveryState> get copyWith => _$PolisDiscoveryStateCopyWithImpl<PolisDiscoveryState>(this as PolisDiscoveryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolisDiscoveryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.poleis, poleis)&&const DeepCollectionEquality().equals(other.members, members));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(poleis),const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'PolisDiscoveryState(status: $status, error: $error, poleis: $poleis, members: $members)';
}


}

/// @nodoc
abstract mixin class $PolisDiscoveryStateCopyWith<$Res>  {
  factory $PolisDiscoveryStateCopyWith(PolisDiscoveryState value, $Res Function(PolisDiscoveryState) _then) = _$PolisDiscoveryStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<PolisDefinition> poleis, List<PolisMember> members
});




}
/// @nodoc
class _$PolisDiscoveryStateCopyWithImpl<$Res>
    implements $PolisDiscoveryStateCopyWith<$Res> {
  _$PolisDiscoveryStateCopyWithImpl(this._self, this._then);

  final PolisDiscoveryState _self;
  final $Res Function(PolisDiscoveryState) _then;

/// Create a copy of PolisDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? poleis = null,Object? members = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,poleis: null == poleis ? _self.poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<PolisDefinition>,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<PolisMember>,
  ));
}

}


/// Adds pattern-matching-related methods to [PolisDiscoveryState].
extension PolisDiscoveryStatePatterns on PolisDiscoveryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PolisDiscoveryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PolisDiscoveryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PolisDiscoveryState value)  $default,){
final _that = this;
switch (_that) {
case _PolisDiscoveryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PolisDiscoveryState value)?  $default,){
final _that = this;
switch (_that) {
case _PolisDiscoveryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PolisDefinition> poleis,  List<PolisMember> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PolisDiscoveryState() when $default != null:
return $default(_that.status,_that.error,_that.poleis,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PolisDefinition> poleis,  List<PolisMember> members)  $default,) {final _that = this;
switch (_that) {
case _PolisDiscoveryState():
return $default(_that.status,_that.error,_that.poleis,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<PolisDefinition> poleis,  List<PolisMember> members)?  $default,) {final _that = this;
switch (_that) {
case _PolisDiscoveryState() when $default != null:
return $default(_that.status,_that.error,_that.poleis,_that.members);case _:
  return null;

}
}

}

/// @nodoc


class _PolisDiscoveryState extends PolisDiscoveryState {
  const _PolisDiscoveryState({this.status = UiFlowStatus.idle, this.error, final  List<PolisDefinition> poleis = const [], final  List<PolisMember> members = const []}): _poleis = poleis,_members = members,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<PolisDefinition> _poleis;
@override@JsonKey() List<PolisDefinition> get poleis {
  if (_poleis is EqualUnmodifiableListView) return _poleis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_poleis);
}

 final  List<PolisMember> _members;
@override@JsonKey() List<PolisMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of PolisDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolisDiscoveryStateCopyWith<_PolisDiscoveryState> get copyWith => __$PolisDiscoveryStateCopyWithImpl<_PolisDiscoveryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolisDiscoveryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._poleis, _poleis)&&const DeepCollectionEquality().equals(other._members, _members));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_poleis),const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'PolisDiscoveryState(status: $status, error: $error, poleis: $poleis, members: $members)';
}


}

/// @nodoc
abstract mixin class _$PolisDiscoveryStateCopyWith<$Res> implements $PolisDiscoveryStateCopyWith<$Res> {
  factory _$PolisDiscoveryStateCopyWith(_PolisDiscoveryState value, $Res Function(_PolisDiscoveryState) _then) = __$PolisDiscoveryStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<PolisDefinition> poleis, List<PolisMember> members
});




}
/// @nodoc
class __$PolisDiscoveryStateCopyWithImpl<$Res>
    implements _$PolisDiscoveryStateCopyWith<$Res> {
  __$PolisDiscoveryStateCopyWithImpl(this._self, this._then);

  final _PolisDiscoveryState _self;
  final $Res Function(_PolisDiscoveryState) _then;

/// Create a copy of PolisDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? poleis = null,Object? members = null,}) {
  return _then(_PolisDiscoveryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,poleis: null == poleis ? _self._poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<PolisDefinition>,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<PolisMember>,
  ));
}


}

// dart format on
