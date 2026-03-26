// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {

/// The content of the post.
 PostContent get content;/// Routing info (poleis, tags, mentions). Present on posts, absent on replies.
 PostRouting? get routing;/// Parent reference. Present on replies, absent on top-level posts.
 PostParent? get parent;/// Freeform structured metadata (polls, events, listings, etc.).
 Map<String, dynamic>? get details;/// Crosspost configuration per platform.
 Map<String, dynamic>? get crosspost;/// When the post was created.
 DateTime get timestamp;/// Author's Web Crypto signature.
 String get signature;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.content, content) || other.content == content)&&(identical(other.routing, routing) || other.routing == routing)&&(identical(other.parent, parent) || other.parent == parent)&&const DeepCollectionEquality().equals(other.details, details)&&const DeepCollectionEquality().equals(other.crosspost, crosspost)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,routing,parent,const DeepCollectionEquality().hash(details),const DeepCollectionEquality().hash(crosspost),timestamp,signature);

@override
String toString() {
  return 'Post(content: $content, routing: $routing, parent: $parent, details: $details, crosspost: $crosspost, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 PostContent content, PostRouting? routing, PostParent? parent, Map<String, dynamic>? details, Map<String, dynamic>? crosspost, DateTime timestamp, String signature
});


$PostContentCopyWith<$Res> get content;$PostRoutingCopyWith<$Res>? get routing;$PostParentCopyWith<$Res>? get parent;

}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? routing = freezed,Object? parent = freezed,Object? details = freezed,Object? crosspost = freezed,Object? timestamp = null,Object? signature = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PostContent,routing: freezed == routing ? _self.routing : routing // ignore: cast_nullable_to_non_nullable
as PostRouting?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as PostParent?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,crosspost: freezed == crosspost ? _self.crosspost : crosspost // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostContentCopyWith<$Res> get content {
  
  return $PostContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostRoutingCopyWith<$Res>? get routing {
    if (_self.routing == null) {
    return null;
  }

  return $PostRoutingCopyWith<$Res>(_self.routing!, (value) {
    return _then(_self.copyWith(routing: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostParentCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $PostParentCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PostContent content,  PostRouting? routing,  PostParent? parent,  Map<String, dynamic>? details,  Map<String, dynamic>? crosspost,  DateTime timestamp,  String signature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.content,_that.routing,_that.parent,_that.details,_that.crosspost,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PostContent content,  PostRouting? routing,  PostParent? parent,  Map<String, dynamic>? details,  Map<String, dynamic>? crosspost,  DateTime timestamp,  String signature)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.content,_that.routing,_that.parent,_that.details,_that.crosspost,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PostContent content,  PostRouting? routing,  PostParent? parent,  Map<String, dynamic>? details,  Map<String, dynamic>? crosspost,  DateTime timestamp,  String signature)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.content,_that.routing,_that.parent,_that.details,_that.crosspost,_that.timestamp,_that.signature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post implements Post {
  const _Post({required this.content, this.routing, this.parent, final  Map<String, dynamic>? details, final  Map<String, dynamic>? crosspost, required this.timestamp, required this.signature}): _details = details,_crosspost = crosspost;
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

/// The content of the post.
@override final  PostContent content;
/// Routing info (poleis, tags, mentions). Present on posts, absent on replies.
@override final  PostRouting? routing;
/// Parent reference. Present on replies, absent on top-level posts.
@override final  PostParent? parent;
/// Freeform structured metadata (polls, events, listings, etc.).
 final  Map<String, dynamic>? _details;
/// Freeform structured metadata (polls, events, listings, etc.).
@override Map<String, dynamic>? get details {
  final value = _details;
  if (value == null) return null;
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Crosspost configuration per platform.
 final  Map<String, dynamic>? _crosspost;
/// Crosspost configuration per platform.
@override Map<String, dynamic>? get crosspost {
  final value = _crosspost;
  if (value == null) return null;
  if (_crosspost is EqualUnmodifiableMapView) return _crosspost;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// When the post was created.
@override final  DateTime timestamp;
/// Author's Web Crypto signature.
@override final  String signature;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.content, content) || other.content == content)&&(identical(other.routing, routing) || other.routing == routing)&&(identical(other.parent, parent) || other.parent == parent)&&const DeepCollectionEquality().equals(other._details, _details)&&const DeepCollectionEquality().equals(other._crosspost, _crosspost)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,routing,parent,const DeepCollectionEquality().hash(_details),const DeepCollectionEquality().hash(_crosspost),timestamp,signature);

@override
String toString() {
  return 'Post(content: $content, routing: $routing, parent: $parent, details: $details, crosspost: $crosspost, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 PostContent content, PostRouting? routing, PostParent? parent, Map<String, dynamic>? details, Map<String, dynamic>? crosspost, DateTime timestamp, String signature
});


@override $PostContentCopyWith<$Res> get content;@override $PostRoutingCopyWith<$Res>? get routing;@override $PostParentCopyWith<$Res>? get parent;

}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? routing = freezed,Object? parent = freezed,Object? details = freezed,Object? crosspost = freezed,Object? timestamp = null,Object? signature = null,}) {
  return _then(_Post(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as PostContent,routing: freezed == routing ? _self.routing : routing // ignore: cast_nullable_to_non_nullable
as PostRouting?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as PostParent?,details: freezed == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,crosspost: freezed == crosspost ? _self._crosspost : crosspost // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostContentCopyWith<$Res> get content {
  
  return $PostContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostRoutingCopyWith<$Res>? get routing {
    if (_self.routing == null) {
    return null;
  }

  return $PostRoutingCopyWith<$Res>(_self.routing!, (value) {
    return _then(_self.copyWith(routing: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostParentCopyWith<$Res>? get parent {
    if (_self.parent == null) {
    return null;
  }

  return $PostParentCopyWith<$Res>(_self.parent!, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}

// dart format on
