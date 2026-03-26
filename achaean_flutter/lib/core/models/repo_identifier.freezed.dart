// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_identifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RepoIdentifier {

 String get baseUrl; String get owner; String get repo;
/// Create a copy of RepoIdentifier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepoIdentifierCopyWith<RepoIdentifier> get copyWith => _$RepoIdentifierCopyWithImpl<RepoIdentifier>(this as RepoIdentifier, _$identity);

  /// Serializes this RepoIdentifier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepoIdentifier&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.repo, repo) || other.repo == repo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,owner,repo);

@override
String toString() {
  return 'RepoIdentifier(baseUrl: $baseUrl, owner: $owner, repo: $repo)';
}


}

/// @nodoc
abstract mixin class $RepoIdentifierCopyWith<$Res>  {
  factory $RepoIdentifierCopyWith(RepoIdentifier value, $Res Function(RepoIdentifier) _then) = _$RepoIdentifierCopyWithImpl;
@useResult
$Res call({
 String baseUrl, String owner, String repo
});




}
/// @nodoc
class _$RepoIdentifierCopyWithImpl<$Res>
    implements $RepoIdentifierCopyWith<$Res> {
  _$RepoIdentifierCopyWithImpl(this._self, this._then);

  final RepoIdentifier _self;
  final $Res Function(RepoIdentifier) _then;

/// Create a copy of RepoIdentifier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? owner = null,Object? repo = null,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RepoIdentifier].
extension RepoIdentifierPatterns on RepoIdentifier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepoIdentifier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepoIdentifier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepoIdentifier value)  $default,){
final _that = this;
switch (_that) {
case _RepoIdentifier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepoIdentifier value)?  $default,){
final _that = this;
switch (_that) {
case _RepoIdentifier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String baseUrl,  String owner,  String repo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepoIdentifier() when $default != null:
return $default(_that.baseUrl,_that.owner,_that.repo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String baseUrl,  String owner,  String repo)  $default,) {final _that = this;
switch (_that) {
case _RepoIdentifier():
return $default(_that.baseUrl,_that.owner,_that.repo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String baseUrl,  String owner,  String repo)?  $default,) {final _that = this;
switch (_that) {
case _RepoIdentifier() when $default != null:
return $default(_that.baseUrl,_that.owner,_that.repo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RepoIdentifier implements RepoIdentifier {
  const _RepoIdentifier({required this.baseUrl, required this.owner, required this.repo});
  factory _RepoIdentifier.fromJson(Map<String, dynamic> json) => _$RepoIdentifierFromJson(json);

@override final  String baseUrl;
@override final  String owner;
@override final  String repo;

/// Create a copy of RepoIdentifier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepoIdentifierCopyWith<_RepoIdentifier> get copyWith => __$RepoIdentifierCopyWithImpl<_RepoIdentifier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepoIdentifierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepoIdentifier&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.repo, repo) || other.repo == repo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,owner,repo);

@override
String toString() {
  return 'RepoIdentifier(baseUrl: $baseUrl, owner: $owner, repo: $repo)';
}


}

/// @nodoc
abstract mixin class _$RepoIdentifierCopyWith<$Res> implements $RepoIdentifierCopyWith<$Res> {
  factory _$RepoIdentifierCopyWith(_RepoIdentifier value, $Res Function(_RepoIdentifier) _then) = __$RepoIdentifierCopyWithImpl;
@override @useResult
$Res call({
 String baseUrl, String owner, String repo
});




}
/// @nodoc
class __$RepoIdentifierCopyWithImpl<$Res>
    implements _$RepoIdentifierCopyWith<$Res> {
  __$RepoIdentifierCopyWithImpl(this._self, this._then);

  final _RepoIdentifier _self;
  final $Res Function(_RepoIdentifier) _then;

/// Create a copy of RepoIdentifier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? owner = null,Object? repo = null,}) {
  return _then(_RepoIdentifier(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
