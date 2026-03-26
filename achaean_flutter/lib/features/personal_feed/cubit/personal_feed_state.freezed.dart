// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonalFeedState {

 UiFlowStatus get status; Object? get error; List<PostReference> get posts; bool get hasMore; int get offset;
/// Create a copy of PersonalFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalFeedStateCopyWith<PersonalFeedState> get copyWith => _$PersonalFeedStateCopyWithImpl<PersonalFeedState>(this as PersonalFeedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalFeedState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(posts),hasMore,offset);

@override
String toString() {
  return 'PersonalFeedState(status: $status, error: $error, posts: $posts, hasMore: $hasMore, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $PersonalFeedStateCopyWith<$Res>  {
  factory $PersonalFeedStateCopyWith(PersonalFeedState value, $Res Function(PersonalFeedState) _then) = _$PersonalFeedStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<PostReference> posts, bool hasMore, int offset
});




}
/// @nodoc
class _$PersonalFeedStateCopyWithImpl<$Res>
    implements $PersonalFeedStateCopyWith<$Res> {
  _$PersonalFeedStateCopyWithImpl(this._self, this._then);

  final PersonalFeedState _self;
  final $Res Function(PersonalFeedState) _then;

/// Create a copy of PersonalFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? posts = null,Object? hasMore = null,Object? offset = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostReference>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalFeedState].
extension PersonalFeedStatePatterns on PersonalFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalFeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalFeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalFeedState value)  $default,){
final _that = this;
switch (_that) {
case _PersonalFeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalFeedState value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalFeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PostReference> posts,  bool hasMore,  int offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalFeedState() when $default != null:
return $default(_that.status,_that.error,_that.posts,_that.hasMore,_that.offset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PostReference> posts,  bool hasMore,  int offset)  $default,) {final _that = this;
switch (_that) {
case _PersonalFeedState():
return $default(_that.status,_that.error,_that.posts,_that.hasMore,_that.offset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<PostReference> posts,  bool hasMore,  int offset)?  $default,) {final _that = this;
switch (_that) {
case _PersonalFeedState() when $default != null:
return $default(_that.status,_that.error,_that.posts,_that.hasMore,_that.offset);case _:
  return null;

}
}

}

/// @nodoc


class _PersonalFeedState extends PersonalFeedState {
  const _PersonalFeedState({this.status = UiFlowStatus.idle, this.error, final  List<PostReference> posts = const [], this.hasMore = false, this.offset = 0}): _posts = posts,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<PostReference> _posts;
@override@JsonKey() List<PostReference> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int offset;

/// Create a copy of PersonalFeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalFeedStateCopyWith<_PersonalFeedState> get copyWith => __$PersonalFeedStateCopyWithImpl<_PersonalFeedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalFeedState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_posts),hasMore,offset);

@override
String toString() {
  return 'PersonalFeedState(status: $status, error: $error, posts: $posts, hasMore: $hasMore, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$PersonalFeedStateCopyWith<$Res> implements $PersonalFeedStateCopyWith<$Res> {
  factory _$PersonalFeedStateCopyWith(_PersonalFeedState value, $Res Function(_PersonalFeedState) _then) = __$PersonalFeedStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<PostReference> posts, bool hasMore, int offset
});




}
/// @nodoc
class __$PersonalFeedStateCopyWithImpl<$Res>
    implements _$PersonalFeedStateCopyWith<$Res> {
  __$PersonalFeedStateCopyWithImpl(this._self, this._then);

  final _PersonalFeedState _self;
  final $Res Function(_PersonalFeedState) _then;

/// Create a copy of PersonalFeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? posts = null,Object? hasMore = null,Object? offset = null,}) {
  return _then(_PersonalFeedState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostReference>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
