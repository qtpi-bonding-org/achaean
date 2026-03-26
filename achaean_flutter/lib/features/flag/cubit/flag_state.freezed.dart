// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlagState {

 UiFlowStatus get status; Object? get error; List<FlagEntry> get flags;
/// Create a copy of FlagState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagStateCopyWith<FlagState> get copyWith => _$FlagStateCopyWithImpl<FlagState>(this as FlagState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.flags, flags));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(flags));

@override
String toString() {
  return 'FlagState(status: $status, error: $error, flags: $flags)';
}


}

/// @nodoc
abstract mixin class $FlagStateCopyWith<$Res>  {
  factory $FlagStateCopyWith(FlagState value, $Res Function(FlagState) _then) = _$FlagStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<FlagEntry> flags
});




}
/// @nodoc
class _$FlagStateCopyWithImpl<$Res>
    implements $FlagStateCopyWith<$Res> {
  _$FlagStateCopyWithImpl(this._self, this._then);

  final FlagState _self;
  final $Res Function(FlagState) _then;

/// Create a copy of FlagState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? flags = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<FlagEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [FlagState].
extension FlagStatePatterns on FlagState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlagState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlagState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlagState value)  $default,){
final _that = this;
switch (_that) {
case _FlagState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlagState value)?  $default,){
final _that = this;
switch (_that) {
case _FlagState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<FlagEntry> flags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlagState() when $default != null:
return $default(_that.status,_that.error,_that.flags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<FlagEntry> flags)  $default,) {final _that = this;
switch (_that) {
case _FlagState():
return $default(_that.status,_that.error,_that.flags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<FlagEntry> flags)?  $default,) {final _that = this;
switch (_that) {
case _FlagState() when $default != null:
return $default(_that.status,_that.error,_that.flags);case _:
  return null;

}
}

}

/// @nodoc


class _FlagState extends FlagState {
  const _FlagState({this.status = UiFlowStatus.idle, this.error, final  List<FlagEntry> flags = const []}): _flags = flags,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<FlagEntry> _flags;
@override@JsonKey() List<FlagEntry> get flags {
  if (_flags is EqualUnmodifiableListView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flags);
}


/// Create a copy of FlagState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagStateCopyWith<_FlagState> get copyWith => __$FlagStateCopyWithImpl<_FlagState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._flags, _flags));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_flags));

@override
String toString() {
  return 'FlagState(status: $status, error: $error, flags: $flags)';
}


}

/// @nodoc
abstract mixin class _$FlagStateCopyWith<$Res> implements $FlagStateCopyWith<$Res> {
  factory _$FlagStateCopyWith(_FlagState value, $Res Function(_FlagState) _then) = __$FlagStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<FlagEntry> flags
});




}
/// @nodoc
class __$FlagStateCopyWithImpl<$Res>
    implements _$FlagStateCopyWith<$Res> {
  __$FlagStateCopyWithImpl(this._self, this._then);

  final _FlagState _self;
  final $Res Function(_FlagState) _then;

/// Create a copy of FlagState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? flags = null,}) {
  return _then(_FlagState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<FlagEntry>,
  ));
}


}

// dart format on
