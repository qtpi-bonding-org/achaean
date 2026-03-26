// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_routing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostRouting {

/// Which poleis this post is tagged for.
 List<String> get poleis;/// Hashtags / topic tags.
 List<String> get tags;/// Public keys of mentioned politai.
 List<String> get mentions;
/// Create a copy of PostRouting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostRoutingCopyWith<PostRouting> get copyWith => _$PostRoutingCopyWithImpl<PostRouting>(this as PostRouting, _$identity);

  /// Serializes this PostRouting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostRouting&&const DeepCollectionEquality().equals(other.poleis, poleis)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.mentions, mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(poleis),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(mentions));

@override
String toString() {
  return 'PostRouting(poleis: $poleis, tags: $tags, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class $PostRoutingCopyWith<$Res>  {
  factory $PostRoutingCopyWith(PostRouting value, $Res Function(PostRouting) _then) = _$PostRoutingCopyWithImpl;
@useResult
$Res call({
 List<String> poleis, List<String> tags, List<String> mentions
});




}
/// @nodoc
class _$PostRoutingCopyWithImpl<$Res>
    implements $PostRoutingCopyWith<$Res> {
  _$PostRoutingCopyWithImpl(this._self, this._then);

  final PostRouting _self;
  final $Res Function(PostRouting) _then;

/// Create a copy of PostRouting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? poleis = null,Object? tags = null,Object? mentions = null,}) {
  return _then(_self.copyWith(
poleis: null == poleis ? _self.poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,mentions: null == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PostRouting].
extension PostRoutingPatterns on PostRouting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostRouting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostRouting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostRouting value)  $default,){
final _that = this;
switch (_that) {
case _PostRouting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostRouting value)?  $default,){
final _that = this;
switch (_that) {
case _PostRouting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> poleis,  List<String> tags,  List<String> mentions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostRouting() when $default != null:
return $default(_that.poleis,_that.tags,_that.mentions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> poleis,  List<String> tags,  List<String> mentions)  $default,) {final _that = this;
switch (_that) {
case _PostRouting():
return $default(_that.poleis,_that.tags,_that.mentions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> poleis,  List<String> tags,  List<String> mentions)?  $default,) {final _that = this;
switch (_that) {
case _PostRouting() when $default != null:
return $default(_that.poleis,_that.tags,_that.mentions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostRouting implements PostRouting {
  const _PostRouting({final  List<String> poleis = const [], final  List<String> tags = const [], final  List<String> mentions = const []}): _poleis = poleis,_tags = tags,_mentions = mentions;
  factory _PostRouting.fromJson(Map<String, dynamic> json) => _$PostRoutingFromJson(json);

/// Which poleis this post is tagged for.
 final  List<String> _poleis;
/// Which poleis this post is tagged for.
@override@JsonKey() List<String> get poleis {
  if (_poleis is EqualUnmodifiableListView) return _poleis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_poleis);
}

/// Hashtags / topic tags.
 final  List<String> _tags;
/// Hashtags / topic tags.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// Public keys of mentioned politai.
 final  List<String> _mentions;
/// Public keys of mentioned politai.
@override@JsonKey() List<String> get mentions {
  if (_mentions is EqualUnmodifiableListView) return _mentions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentions);
}


/// Create a copy of PostRouting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostRoutingCopyWith<_PostRouting> get copyWith => __$PostRoutingCopyWithImpl<_PostRouting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostRoutingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostRouting&&const DeepCollectionEquality().equals(other._poleis, _poleis)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._mentions, _mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_poleis),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_mentions));

@override
String toString() {
  return 'PostRouting(poleis: $poleis, tags: $tags, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class _$PostRoutingCopyWith<$Res> implements $PostRoutingCopyWith<$Res> {
  factory _$PostRoutingCopyWith(_PostRouting value, $Res Function(_PostRouting) _then) = __$PostRoutingCopyWithImpl;
@override @useResult
$Res call({
 List<String> poleis, List<String> tags, List<String> mentions
});




}
/// @nodoc
class __$PostRoutingCopyWithImpl<$Res>
    implements _$PostRoutingCopyWith<$Res> {
  __$PostRoutingCopyWithImpl(this._self, this._then);

  final _PostRouting _self;
  final $Res Function(_PostRouting) _then;

/// Create a copy of PostRouting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? poleis = null,Object? tags = null,Object? mentions = null,}) {
  return _then(_PostRouting(
poleis: null == poleis ? _self._poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,mentions: null == mentions ? _self._mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
