// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_creation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostCreationResult {

 String get path; String get slug; DateTime get timestamp;
/// Create a copy of PostCreationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCreationResultCopyWith<PostCreationResult> get copyWith => _$PostCreationResultCopyWithImpl<PostCreationResult>(this as PostCreationResult, _$identity);

  /// Serializes this PostCreationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostCreationResult&&(identical(other.path, path) || other.path == path)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,slug,timestamp);

@override
String toString() {
  return 'PostCreationResult(path: $path, slug: $slug, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $PostCreationResultCopyWith<$Res>  {
  factory $PostCreationResultCopyWith(PostCreationResult value, $Res Function(PostCreationResult) _then) = _$PostCreationResultCopyWithImpl;
@useResult
$Res call({
 String path, String slug, DateTime timestamp
});




}
/// @nodoc
class _$PostCreationResultCopyWithImpl<$Res>
    implements $PostCreationResultCopyWith<$Res> {
  _$PostCreationResultCopyWithImpl(this._self, this._then);

  final PostCreationResult _self;
  final $Res Function(PostCreationResult) _then;

/// Create a copy of PostCreationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? slug = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PostCreationResult].
extension PostCreationResultPatterns on PostCreationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostCreationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostCreationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostCreationResult value)  $default,){
final _that = this;
switch (_that) {
case _PostCreationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostCreationResult value)?  $default,){
final _that = this;
switch (_that) {
case _PostCreationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String slug,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostCreationResult() when $default != null:
return $default(_that.path,_that.slug,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String slug,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _PostCreationResult():
return $default(_that.path,_that.slug,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String slug,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _PostCreationResult() when $default != null:
return $default(_that.path,_that.slug,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostCreationResult implements PostCreationResult {
  const _PostCreationResult({required this.path, required this.slug, required this.timestamp});
  factory _PostCreationResult.fromJson(Map<String, dynamic> json) => _$PostCreationResultFromJson(json);

@override final  String path;
@override final  String slug;
@override final  DateTime timestamp;

/// Create a copy of PostCreationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCreationResultCopyWith<_PostCreationResult> get copyWith => __$PostCreationResultCopyWithImpl<_PostCreationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostCreationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostCreationResult&&(identical(other.path, path) || other.path == path)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,slug,timestamp);

@override
String toString() {
  return 'PostCreationResult(path: $path, slug: $slug, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PostCreationResultCopyWith<$Res> implements $PostCreationResultCopyWith<$Res> {
  factory _$PostCreationResultCopyWith(_PostCreationResult value, $Res Function(_PostCreationResult) _then) = __$PostCreationResultCopyWithImpl;
@override @useResult
$Res call({
 String path, String slug, DateTime timestamp
});




}
/// @nodoc
class __$PostCreationResultCopyWithImpl<$Res>
    implements _$PostCreationResultCopyWith<$Res> {
  __$PostCreationResultCopyWithImpl(this._self, this._then);

  final _PostCreationResult _self;
  final $Res Function(_PostCreationResult) _then;

/// Create a copy of PostCreationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? slug = null,Object? timestamp = null,}) {
  return _then(_PostCreationResult(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
