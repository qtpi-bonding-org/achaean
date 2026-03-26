// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agora_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AgoraState {

 UiFlowStatus get status; Object? get error; List<PostReference> get posts; Map<String, int> get flagCounts; int get flagThreshold; bool get hasMore; int get offset;
/// Create a copy of AgoraState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgoraStateCopyWith<AgoraState> get copyWith => _$AgoraStateCopyWithImpl<AgoraState>(this as AgoraState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgoraState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other.posts, posts)&&const DeepCollectionEquality().equals(other.flagCounts, flagCounts)&&(identical(other.flagThreshold, flagThreshold) || other.flagThreshold == flagThreshold)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(posts),const DeepCollectionEquality().hash(flagCounts),flagThreshold,hasMore,offset);

@override
String toString() {
  return 'AgoraState(status: $status, error: $error, posts: $posts, flagCounts: $flagCounts, flagThreshold: $flagThreshold, hasMore: $hasMore, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $AgoraStateCopyWith<$Res>  {
  factory $AgoraStateCopyWith(AgoraState value, $Res Function(AgoraState) _then) = _$AgoraStateCopyWithImpl;
@useResult
$Res call({
 UiFlowStatus status, Object? error, List<PostReference> posts, Map<String, int> flagCounts, int flagThreshold, bool hasMore, int offset
});




}
/// @nodoc
class _$AgoraStateCopyWithImpl<$Res>
    implements $AgoraStateCopyWith<$Res> {
  _$AgoraStateCopyWithImpl(this._self, this._then);

  final AgoraState _self;
  final $Res Function(AgoraState) _then;

/// Create a copy of AgoraState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? posts = null,Object? flagCounts = null,Object? flagThreshold = null,Object? hasMore = null,Object? offset = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostReference>,flagCounts: null == flagCounts ? _self.flagCounts : flagCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,flagThreshold: null == flagThreshold ? _self.flagThreshold : flagThreshold // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AgoraState].
extension AgoraStatePatterns on AgoraState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgoraState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgoraState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgoraState value)  $default,){
final _that = this;
switch (_that) {
case _AgoraState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgoraState value)?  $default,){
final _that = this;
switch (_that) {
case _AgoraState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PostReference> posts,  Map<String, int> flagCounts,  int flagThreshold,  bool hasMore,  int offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgoraState() when $default != null:
return $default(_that.status,_that.error,_that.posts,_that.flagCounts,_that.flagThreshold,_that.hasMore,_that.offset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UiFlowStatus status,  Object? error,  List<PostReference> posts,  Map<String, int> flagCounts,  int flagThreshold,  bool hasMore,  int offset)  $default,) {final _that = this;
switch (_that) {
case _AgoraState():
return $default(_that.status,_that.error,_that.posts,_that.flagCounts,_that.flagThreshold,_that.hasMore,_that.offset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UiFlowStatus status,  Object? error,  List<PostReference> posts,  Map<String, int> flagCounts,  int flagThreshold,  bool hasMore,  int offset)?  $default,) {final _that = this;
switch (_that) {
case _AgoraState() when $default != null:
return $default(_that.status,_that.error,_that.posts,_that.flagCounts,_that.flagThreshold,_that.hasMore,_that.offset);case _:
  return null;

}
}

}

/// @nodoc


class _AgoraState extends AgoraState {
  const _AgoraState({this.status = UiFlowStatus.idle, this.error, final  List<PostReference> posts = const [], final  Map<String, int> flagCounts = const {}, this.flagThreshold = 1, this.hasMore = false, this.offset = 0}): _posts = posts,_flagCounts = flagCounts,super._();
  

@override@JsonKey() final  UiFlowStatus status;
@override final  Object? error;
 final  List<PostReference> _posts;
@override@JsonKey() List<PostReference> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  Map<String, int> _flagCounts;
@override@JsonKey() Map<String, int> get flagCounts {
  if (_flagCounts is EqualUnmodifiableMapView) return _flagCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_flagCounts);
}

@override@JsonKey() final  int flagThreshold;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int offset;

/// Create a copy of AgoraState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgoraStateCopyWith<_AgoraState> get copyWith => __$AgoraStateCopyWithImpl<_AgoraState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgoraState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error)&&const DeepCollectionEquality().equals(other._posts, _posts)&&const DeepCollectionEquality().equals(other._flagCounts, _flagCounts)&&(identical(other.flagThreshold, flagThreshold) || other.flagThreshold == flagThreshold)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error),const DeepCollectionEquality().hash(_posts),const DeepCollectionEquality().hash(_flagCounts),flagThreshold,hasMore,offset);

@override
String toString() {
  return 'AgoraState(status: $status, error: $error, posts: $posts, flagCounts: $flagCounts, flagThreshold: $flagThreshold, hasMore: $hasMore, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$AgoraStateCopyWith<$Res> implements $AgoraStateCopyWith<$Res> {
  factory _$AgoraStateCopyWith(_AgoraState value, $Res Function(_AgoraState) _then) = __$AgoraStateCopyWithImpl;
@override @useResult
$Res call({
 UiFlowStatus status, Object? error, List<PostReference> posts, Map<String, int> flagCounts, int flagThreshold, bool hasMore, int offset
});




}
/// @nodoc
class __$AgoraStateCopyWithImpl<$Res>
    implements _$AgoraStateCopyWith<$Res> {
  __$AgoraStateCopyWithImpl(this._self, this._then);

  final _AgoraState _self;
  final $Res Function(_AgoraState) _then;

/// Create a copy of AgoraState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? posts = null,Object? flagCounts = null,Object? flagThreshold = null,Object? hasMore = null,Object? offset = null,}) {
  return _then(_AgoraState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UiFlowStatus,error: freezed == error ? _self.error : error ,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostReference>,flagCounts: null == flagCounts ? _self._flagCounts : flagCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,flagThreshold: null == flagThreshold ? _self.flagThreshold : flagThreshold // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
