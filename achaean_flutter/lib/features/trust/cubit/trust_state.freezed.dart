// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrustState {

 UiFlowStatus get status; Object? get error; List<TrustDeclaration> get declarations;
/// Create a copy of TrustState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrustStateCopyWith<TrustState> get copyWith => _$TrustStateCopyWithImpl<TrustState>(this as TrustState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrustState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.declarations, declarations));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(declarations));

@override
String toString() {
  return 'TrustState(status: $status, error: $error, declarations: $declarations)';
}


}

/// @nodoc
abstract mixin class $TrustStateCopyWith<$Res>  {
  factory $TrustStateCopyWith(TrustState value, $Res Function(TrustState) _then) = _$TrustStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<TrustDeclaration> declarations
});




}
/// @nodoc
class _$TrustStateCopyWithImpl<$Res>
    implements $TrustStateCopyWith<$Res> {
  _$TrustStateCopyWithImpl(this._self, this._then);

  final TrustState _self;
  final $Res Function(TrustState) _then;

/// Create a copy of TrustState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? declarations = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,declarations: null == declarations ? _self.declarations : declarations // ignore: cast_nullable_to_non_nullable
as List<TrustDeclaration>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrustState].
extension TrustStatePatterns on TrustState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrustState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrustState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrustState value)  $default,){
final _that = this;
switch (_that) {
case _TrustState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrustState value)?  $default,){
final _that = this;
switch (_that) {
case _TrustState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<TrustDeclaration> declarations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrustState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<TrustDeclaration> declarations)  $default,) {final _that = this;
switch (_that) {
case _TrustState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<TrustDeclaration> declarations)?  $default,) {final _that = this;
switch (_that) {
case _TrustState() when $default != null:
return $default(_that.status,_that.error,_that.declarations);case _:
  return null;

}
}

}

/// @nodoc


class _TrustState extends TrustState {
  const _TrustState({this.status = UiFlowStatus.idle, this.error, final  List<TrustDeclaration> declarations = const []}): _declarations = declarations,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<TrustDeclaration> _declarations;
@override@JsonKey() List<TrustDeclaration> get declarations {
  if (_declarations is EqualUnmodifiableListView) return _declarations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_declarations);
}


/// Create a copy of TrustState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrustStateCopyWith<_TrustState> get copyWith => __$TrustStateCopyWithImpl<_TrustState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrustState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._declarations, _declarations));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_declarations));

@override
String toString() {
  return 'TrustState(status: $status, error: $error, declarations: $declarations)';
}


}

/// @nodoc
abstract mixin class _$TrustStateCopyWith<$Res> implements $TrustStateCopyWith<$Res> {
  factory _$TrustStateCopyWith(_TrustState value, $Res Function(_TrustState) _then) = __$TrustStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<TrustDeclaration> declarations
});




}
/// @nodoc
class __$TrustStateCopyWithImpl<$Res>
    implements _$TrustStateCopyWith<$Res> {
  __$TrustStateCopyWithImpl(this._self, this._then);

  final _TrustState _self;
  final $Res Function(_TrustState) _then;

/// Create a copy of TrustState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? declarations = null,}) {
  return _then(_TrustState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,declarations: null == declarations ? _self._declarations : declarations // ignore: cast_nullable_to_non_nullable
as List<TrustDeclaration>,
  ));
}


}

// dart format on
