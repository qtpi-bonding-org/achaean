// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_parent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostParent {

/// Parent author's public key.
 String get author;/// Parent author's repo ID.
 String get repo;/// Path to parent's post.json.
 String get path;/// Git commit hash of the parent post.
 String get commit;
/// Create a copy of PostParent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostParentCopyWith<PostParent> get copyWith => _$PostParentCopyWithImpl<PostParent>(this as PostParent, _$identity);

  /// Serializes this PostParent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostParent&&(identical(other.author, author) || other.author == author)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.path, path) || other.path == path)&&(identical(other.commit, commit) || other.commit == commit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,repo,path,commit);

@override
String toString() {
  return 'PostParent(author: $author, repo: $repo, path: $path, commit: $commit)';
}


}

/// @nodoc
abstract mixin class $PostParentCopyWith<$Res>  {
  factory $PostParentCopyWith(PostParent value, $Res Function(PostParent) _then) = _$PostParentCopyWithImpl;
@useResult
$Res call({
 String author, String repo, String path, String commit
});




}
/// @nodoc
class _$PostParentCopyWithImpl<$Res>
    implements $PostParentCopyWith<$Res> {
  _$PostParentCopyWithImpl(this._self, this._then);

  final PostParent _self;
  final $Res Function(PostParent) _then;

/// Create a copy of PostParent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? author = null,Object? repo = null,Object? path = null,Object? commit = null,}) {
  return _then(_self.copyWith(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,commit: null == commit ? _self.commit : commit // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PostParent].
extension PostParentPatterns on PostParent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostParent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostParent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostParent value)  $default,){
final _that = this;
switch (_that) {
case _PostParent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostParent value)?  $default,){
final _that = this;
switch (_that) {
case _PostParent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String author,  String repo,  String path,  String commit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostParent() when $default != null:
return $default(_that.author,_that.repo,_that.path,_that.commit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String author,  String repo,  String path,  String commit)  $default,) {final _that = this;
switch (_that) {
case _PostParent():
return $default(_that.author,_that.repo,_that.path,_that.commit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String author,  String repo,  String path,  String commit)?  $default,) {final _that = this;
switch (_that) {
case _PostParent() when $default != null:
return $default(_that.author,_that.repo,_that.path,_that.commit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostParent implements PostParent {
  const _PostParent({required this.author, required this.repo, required this.path, required this.commit});
  factory _PostParent.fromJson(Map<String, dynamic> json) => _$PostParentFromJson(json);

/// Parent author's public key.
@override final  String author;
/// Parent author's repo ID.
@override final  String repo;
/// Path to parent's post.json.
@override final  String path;
/// Git commit hash of the parent post.
@override final  String commit;

/// Create a copy of PostParent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostParentCopyWith<_PostParent> get copyWith => __$PostParentCopyWithImpl<_PostParent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostParentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostParent&&(identical(other.author, author) || other.author == author)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.path, path) || other.path == path)&&(identical(other.commit, commit) || other.commit == commit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,repo,path,commit);

@override
String toString() {
  return 'PostParent(author: $author, repo: $repo, path: $path, commit: $commit)';
}


}

/// @nodoc
abstract mixin class _$PostParentCopyWith<$Res> implements $PostParentCopyWith<$Res> {
  factory _$PostParentCopyWith(_PostParent value, $Res Function(_PostParent) _then) = __$PostParentCopyWithImpl;
@override @useResult
$Res call({
 String author, String repo, String path, String commit
});




}
/// @nodoc
class __$PostParentCopyWithImpl<$Res>
    implements _$PostParentCopyWith<$Res> {
  __$PostParentCopyWithImpl(this._self, this._then);

  final _PostParent _self;
  final $Res Function(_PostParent) _then;

/// Create a copy of PostParent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? author = null,Object? repo = null,Object? path = null,Object? commit = null,}) {
  return _then(_PostParent(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,commit: null == commit ? _self.commit : commit // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
