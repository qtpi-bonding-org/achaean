// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_inspection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RepoInspectionState {

 UiFlowStatus get status; Object? get error; RepoInspectionResult? get result;
/// Create a copy of RepoInspectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepoInspectionStateCopyWith<RepoInspectionState> get copyWith => _$RepoInspectionStateCopyWithImpl<RepoInspectionState>(this as RepoInspectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepoInspectionState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),result);

@override
String toString() {
  return 'RepoInspectionState(status: $status, error: $error, result: $result)';
}


}

/// @nodoc
abstract mixin class $RepoInspectionStateCopyWith<$Res>  {
  factory $RepoInspectionStateCopyWith(RepoInspectionState value, $Res Function(RepoInspectionState) _then) = _$RepoInspectionStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, RepoInspectionResult? result
});


$RepoInspectionResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$RepoInspectionStateCopyWithImpl<$Res>
    implements $RepoInspectionStateCopyWith<$Res> {
  _$RepoInspectionStateCopyWithImpl(this._self, this._then);

  final RepoInspectionState _self;
  final $Res Function(RepoInspectionState) _then;

/// Create a copy of RepoInspectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? result = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as RepoInspectionResult?,
  ));
}
/// Create a copy of RepoInspectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RepoInspectionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $RepoInspectionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [RepoInspectionState].
extension RepoInspectionStatePatterns on RepoInspectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepoInspectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepoInspectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepoInspectionState value)  $default,){
final _that = this;
switch (_that) {
case _RepoInspectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepoInspectionState value)?  $default,){
final _that = this;
switch (_that) {
case _RepoInspectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  RepoInspectionResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepoInspectionState() when $default != null:
return $default(_that.status,_that.error,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  RepoInspectionResult? result)  $default,) {final _that = this;
switch (_that) {
case _RepoInspectionState():
return $default(_that.status,_that.error,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  RepoInspectionResult? result)?  $default,) {final _that = this;
switch (_that) {
case _RepoInspectionState() when $default != null:
return $default(_that.status,_that.error,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _RepoInspectionState extends RepoInspectionState {
  const _RepoInspectionState({this.status = UiFlowStatus.idle, this.error, this.result}): super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
@override final  RepoInspectionResult? result;

/// Create a copy of RepoInspectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepoInspectionStateCopyWith<_RepoInspectionState> get copyWith => __$RepoInspectionStateCopyWithImpl<_RepoInspectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepoInspectionState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),result);

@override
String toString() {
  return 'RepoInspectionState(status: $status, error: $error, result: $result)';
}


}

/// @nodoc
abstract mixin class _$RepoInspectionStateCopyWith<$Res> implements $RepoInspectionStateCopyWith<$Res> {
  factory _$RepoInspectionStateCopyWith(_RepoInspectionState value, $Res Function(_RepoInspectionState) _then) = __$RepoInspectionStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, RepoInspectionResult? result
});


@override $RepoInspectionResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$RepoInspectionStateCopyWithImpl<$Res>
    implements _$RepoInspectionStateCopyWith<$Res> {
  __$RepoInspectionStateCopyWithImpl(this._self, this._then);

  final _RepoInspectionState _self;
  final $Res Function(_RepoInspectionState) _then;

/// Create a copy of RepoInspectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? result = freezed,}) {
  return _then(_RepoInspectionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as RepoInspectionResult?,
  ));
}

/// Create a copy of RepoInspectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RepoInspectionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $RepoInspectionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
