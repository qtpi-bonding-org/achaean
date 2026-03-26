// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_creation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountCreationState {

 UiFlowStatus get status; Object? get error; AccountCreationResult? get result;
/// Create a copy of AccountCreationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCreationStateCopyWith<AccountCreationState> get copyWith => _$AccountCreationStateCopyWithImpl<AccountCreationState>(this as AccountCreationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountCreationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),result);

@override
String toString() {
  return 'AccountCreationState(status: $status, error: $error, result: $result)';
}


}

/// @nodoc
abstract mixin class $AccountCreationStateCopyWith<$Res>  {
  factory $AccountCreationStateCopyWith(AccountCreationState value, $Res Function(AccountCreationState) _then) = _$AccountCreationStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, AccountCreationResult? result
});


$AccountCreationResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$AccountCreationStateCopyWithImpl<$Res>
    implements $AccountCreationStateCopyWith<$Res> {
  _$AccountCreationStateCopyWithImpl(this._self, this._then);

  final AccountCreationState _self;
  final $Res Function(AccountCreationState) _then;

/// Create a copy of AccountCreationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? result = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AccountCreationResult?,
  ));
}
/// Create a copy of AccountCreationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCreationResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $AccountCreationResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountCreationState].
extension AccountCreationStatePatterns on AccountCreationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountCreationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountCreationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountCreationState value)  $default,){
final _that = this;
switch (_that) {
case _AccountCreationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountCreationState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountCreationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  AccountCreationResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountCreationState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  AccountCreationResult? result)  $default,) {final _that = this;
switch (_that) {
case _AccountCreationState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  AccountCreationResult? result)?  $default,) {final _that = this;
switch (_that) {
case _AccountCreationState() when $default != null:
return $default(_that.status,_that.error,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _AccountCreationState extends AccountCreationState {
  const _AccountCreationState({this.status = UiFlowStatus.idle, this.error, this.result}): super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
@override final  AccountCreationResult? result;

/// Create a copy of AccountCreationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountCreationStateCopyWith<_AccountCreationState> get copyWith => __$AccountCreationStateCopyWithImpl<_AccountCreationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountCreationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),result);

@override
String toString() {
  return 'AccountCreationState(status: $status, error: $error, result: $result)';
}


}

/// @nodoc
abstract mixin class _$AccountCreationStateCopyWith<$Res> implements $AccountCreationStateCopyWith<$Res> {
  factory _$AccountCreationStateCopyWith(_AccountCreationState value, $Res Function(_AccountCreationState) _then) = __$AccountCreationStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, AccountCreationResult? result
});


@override $AccountCreationResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$AccountCreationStateCopyWithImpl<$Res>
    implements _$AccountCreationStateCopyWith<$Res> {
  __$AccountCreationStateCopyWithImpl(this._self, this._then);

  final _AccountCreationState _self;
  final $Res Function(_AccountCreationState) _then;

/// Create a copy of AccountCreationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? result = freezed,}) {
  return _then(_AccountCreationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AccountCreationResult?,
  ));
}

/// Create a copy of AccountCreationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCreationResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $AccountCreationResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
