// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'own_posts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OwnPostsState {

 UiFlowStatus get status; Object? get error; List<Post> get posts;
/// Create a copy of OwnPostsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnPostsStateCopyWith<OwnPostsState> get copyWith => _$OwnPostsStateCopyWithImpl<OwnPostsState>(this as OwnPostsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnPostsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.posts, posts));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(posts));

@override
String toString() {
  return 'OwnPostsState(status: $status, error: $error, posts: $posts)';
}


}

/// @nodoc
abstract mixin class $OwnPostsStateCopyWith<$Res>  {
  factory $OwnPostsStateCopyWith(OwnPostsState value, $Res Function(OwnPostsState) _then) = _$OwnPostsStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<Post> posts
});




}
/// @nodoc
class _$OwnPostsStateCopyWithImpl<$Res>
    implements $OwnPostsStateCopyWith<$Res> {
  _$OwnPostsStateCopyWithImpl(this._self, this._then);

  final OwnPostsState _self;
  final $Res Function(OwnPostsState) _then;

/// Create a copy of OwnPostsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? posts = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnPostsState].
extension OwnPostsStatePatterns on OwnPostsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnPostsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnPostsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnPostsState value)  $default,){
final _that = this;
switch (_that) {
case _OwnPostsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnPostsState value)?  $default,){
final _that = this;
switch (_that) {
case _OwnPostsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<Post> posts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnPostsState() when $default != null:
return $default(_that.status,_that.error,_that.posts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<Post> posts)  $default,) {final _that = this;
switch (_that) {
case _OwnPostsState():
return $default(_that.status,_that.error,_that.posts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<Post> posts)?  $default,) {final _that = this;
switch (_that) {
case _OwnPostsState() when $default != null:
return $default(_that.status,_that.error,_that.posts);case _:
  return null;

}
}

}

/// @nodoc


class _OwnPostsState extends OwnPostsState {
  const _OwnPostsState({this.status = UiFlowStatus.idle, this.error, final  List<Post> posts = const []}): _posts = posts,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of OwnPostsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnPostsStateCopyWith<_OwnPostsState> get copyWith => __$OwnPostsStateCopyWithImpl<_OwnPostsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnPostsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._posts, _posts));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'OwnPostsState(status: $status, error: $error, posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$OwnPostsStateCopyWith<$Res> implements $OwnPostsStateCopyWith<$Res> {
  factory _$OwnPostsStateCopyWith(_OwnPostsState value, $Res Function(_OwnPostsState) _then) = __$OwnPostsStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<Post> posts
});




}
/// @nodoc
class __$OwnPostsStateCopyWithImpl<$Res>
    implements _$OwnPostsStateCopyWith<$Res> {
  __$OwnPostsStateCopyWithImpl(this._self, this._then);

  final _OwnPostsState _self;
  final $Res Function(_OwnPostsState) _then;

/// Create a copy of OwnPostsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? posts = null,}) {
  return _then(_OwnPostsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}

// dart format on
