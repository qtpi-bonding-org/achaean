// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoucherReviewState {

 UiFlowStatus get status; Object? get error; List<FlagRecord> get flaggedPosts;
/// Create a copy of VoucherReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoucherReviewStateCopyWith<VoucherReviewState> get copyWith => _$VoucherReviewStateCopyWithImpl<VoucherReviewState>(this as VoucherReviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoucherReviewState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.flaggedPosts, flaggedPosts));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(flaggedPosts));

@override
String toString() {
  return 'VoucherReviewState(status: $status, error: $error, flaggedPosts: $flaggedPosts)';
}


}

/// @nodoc
abstract mixin class $VoucherReviewStateCopyWith<$Res>  {
  factory $VoucherReviewStateCopyWith(VoucherReviewState value, $Res Function(VoucherReviewState) _then) = _$VoucherReviewStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<FlagRecord> flaggedPosts
});




}
/// @nodoc
class _$VoucherReviewStateCopyWithImpl<$Res>
    implements $VoucherReviewStateCopyWith<$Res> {
  _$VoucherReviewStateCopyWithImpl(this._self, this._then);

  final VoucherReviewState _self;
  final $Res Function(VoucherReviewState) _then;

/// Create a copy of VoucherReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? flaggedPosts = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,flaggedPosts: null == flaggedPosts ? _self.flaggedPosts : flaggedPosts // ignore: cast_nullable_to_non_nullable
as List<FlagRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [VoucherReviewState].
extension VoucherReviewStatePatterns on VoucherReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoucherReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoucherReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoucherReviewState value)  $default,){
final _that = this;
switch (_that) {
case _VoucherReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoucherReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _VoucherReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<FlagRecord> flaggedPosts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoucherReviewState() when $default != null:
return $default(_that.status,_that.error,_that.flaggedPosts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<FlagRecord> flaggedPosts)  $default,) {final _that = this;
switch (_that) {
case _VoucherReviewState():
return $default(_that.status,_that.error,_that.flaggedPosts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<FlagRecord> flaggedPosts)?  $default,) {final _that = this;
switch (_that) {
case _VoucherReviewState() when $default != null:
return $default(_that.status,_that.error,_that.flaggedPosts);case _:
  return null;

}
}

}

/// @nodoc


class _VoucherReviewState extends VoucherReviewState {
  const _VoucherReviewState({this.status = UiFlowStatus.idle, this.error, final  List<FlagRecord> flaggedPosts = const []}): _flaggedPosts = flaggedPosts,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<FlagRecord> _flaggedPosts;
@override@JsonKey() List<FlagRecord> get flaggedPosts {
  if (_flaggedPosts is EqualUnmodifiableListView) return _flaggedPosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flaggedPosts);
}


/// Create a copy of VoucherReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoucherReviewStateCopyWith<_VoucherReviewState> get copyWith => __$VoucherReviewStateCopyWithImpl<_VoucherReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoucherReviewState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._flaggedPosts, _flaggedPosts));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_flaggedPosts));

@override
String toString() {
  return 'VoucherReviewState(status: $status, error: $error, flaggedPosts: $flaggedPosts)';
}


}

/// @nodoc
abstract mixin class _$VoucherReviewStateCopyWith<$Res> implements $VoucherReviewStateCopyWith<$Res> {
  factory _$VoucherReviewStateCopyWith(_VoucherReviewState value, $Res Function(_VoucherReviewState) _then) = __$VoucherReviewStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<FlagRecord> flaggedPosts
});




}
/// @nodoc
class __$VoucherReviewStateCopyWithImpl<$Res>
    implements _$VoucherReviewStateCopyWith<$Res> {
  __$VoucherReviewStateCopyWithImpl(this._self, this._then);

  final _VoucherReviewState _self;
  final $Res Function(_VoucherReviewState) _then;

/// Create a copy of VoucherReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? flaggedPosts = null,}) {
  return _then(_VoucherReviewState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,flaggedPosts: null == flaggedPosts ? _self._flaggedPosts : flaggedPosts // ignore: cast_nullable_to_non_nullable
as List<FlagRecord>,
  ));
}


}

// dart format on
