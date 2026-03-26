// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observe_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ObserveState {

 UiFlowStatus get status; Object? get error; List<ObserveDeclaration> get declarations;
/// Create a copy of ObserveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObserveStateCopyWith<ObserveState> get copyWith => _$ObserveStateCopyWithImpl<ObserveState>(this as ObserveState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObserveState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.declarations, declarations));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(declarations));

@override
String toString() {
  return 'ObserveState(status: $status, error: $error, declarations: $declarations)';
}


}

/// @nodoc
abstract mixin class $ObserveStateCopyWith<$Res>  {
  factory $ObserveStateCopyWith(ObserveState value, $Res Function(ObserveState) _then) = _$ObserveStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<ObserveDeclaration> declarations
});




}
/// @nodoc
class _$ObserveStateCopyWithImpl<$Res>
    implements $ObserveStateCopyWith<$Res> {
  _$ObserveStateCopyWithImpl(this._self, this._then);

  final ObserveState _self;
  final $Res Function(ObserveState) _then;

/// Create a copy of ObserveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? declarations = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,declarations: null == declarations ? _self.declarations : declarations // ignore: cast_nullable_to_non_nullable
as List<ObserveDeclaration>,
  ));
}

}


/// Adds pattern-matching-related methods to [ObserveState].
extension ObserveStatePatterns on ObserveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObserveState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObserveState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObserveState value)  $default,){
final _that = this;
switch (_that) {
case _ObserveState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObserveState value)?  $default,){
final _that = this;
switch (_that) {
case _ObserveState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<ObserveDeclaration> declarations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObserveState() when $default != null:
return $default(_that.status,_that.error,_that.declarations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<ObserveDeclaration> declarations)  $default,) {final _that = this;
switch (_that) {
case _ObserveState():
return $default(_that.status,_that.error,_that.declarations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<ObserveDeclaration> declarations)?  $default,) {final _that = this;
switch (_that) {
case _ObserveState() when $default != null:
return $default(_that.status,_that.error,_that.declarations);case _:
  return null;

}
}

}

/// @nodoc


class _ObserveState extends ObserveState {
  const _ObserveState({this.status = UiFlowStatus.idle, this.error, final  List<ObserveDeclaration> declarations = const []}): _declarations = declarations,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<ObserveDeclaration> _declarations;
@override@JsonKey() List<ObserveDeclaration> get declarations {
  if (_declarations is EqualUnmodifiableListView) return _declarations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_declarations);
}


/// Create a copy of ObserveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObserveStateCopyWith<_ObserveState> get copyWith => __$ObserveStateCopyWithImpl<_ObserveState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObserveState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._declarations, _declarations));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_declarations));

@override
String toString() {
  return 'ObserveState(status: $status, error: $error, declarations: $declarations)';
}


}

/// @nodoc
abstract mixin class _$ObserveStateCopyWith<$Res> implements $ObserveStateCopyWith<$Res> {
  factory _$ObserveStateCopyWith(_ObserveState value, $Res Function(_ObserveState) _then) = __$ObserveStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<ObserveDeclaration> declarations
});




}
/// @nodoc
class __$ObserveStateCopyWithImpl<$Res>
    implements _$ObserveStateCopyWith<$Res> {
  __$ObserveStateCopyWithImpl(this._self, this._then);

  final _ObserveState _self;
  final $Res Function(_ObserveState) _then;

/// Create a copy of ObserveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? declarations = null,}) {
  return _then(_ObserveState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,declarations: null == declarations ? _self._declarations : declarations // ignore: cast_nullable_to_non_nullable
as List<ObserveDeclaration>,
  ));
}


}

// dart format on
