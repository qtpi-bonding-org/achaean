// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encrypted_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EncryptedPost {

/// The encrypted payload (base64-encoded). Contains the serialized
/// PostContent, routing, details, crosspost, and parent (if a reply).
 String get encryptedContent;/// When the post was created.
 DateTime get timestamp;/// Author's signature over the encrypted payload.
 String get signature;
/// Create a copy of EncryptedPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncryptedPostCopyWith<EncryptedPost> get copyWith => _$EncryptedPostCopyWithImpl<EncryptedPost>(this as EncryptedPost, _$identity);

  /// Serializes this EncryptedPost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncryptedPost&&(identical(other.encryptedContent, encryptedContent) || other.encryptedContent == encryptedContent)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,encryptedContent,timestamp,signature);

@override
String toString() {
  return 'EncryptedPost(encryptedContent: $encryptedContent, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class $EncryptedPostCopyWith<$Res>  {
  factory $EncryptedPostCopyWith(EncryptedPost value, $Res Function(EncryptedPost) _then) = _$EncryptedPostCopyWithImpl;
@useResult
$Res call({
 String encryptedContent, DateTime timestamp, String signature
});




}
/// @nodoc
class _$EncryptedPostCopyWithImpl<$Res>
    implements $EncryptedPostCopyWith<$Res> {
  _$EncryptedPostCopyWithImpl(this._self, this._then);

  final EncryptedPost _self;
  final $Res Function(EncryptedPost) _then;

/// Create a copy of EncryptedPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? encryptedContent = null,Object? timestamp = null,Object? signature = null,}) {
  return _then(_self.copyWith(
encryptedContent: null == encryptedContent ? _self.encryptedContent : encryptedContent // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EncryptedPost].
extension EncryptedPostPatterns on EncryptedPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EncryptedPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EncryptedPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EncryptedPost value)  $default,){
final _that = this;
switch (_that) {
case _EncryptedPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EncryptedPost value)?  $default,){
final _that = this;
switch (_that) {
case _EncryptedPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String encryptedContent,  DateTime timestamp,  String signature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EncryptedPost() when $default != null:
return $default(_that.encryptedContent,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String encryptedContent,  DateTime timestamp,  String signature)  $default,) {final _that = this;
switch (_that) {
case _EncryptedPost():
return $default(_that.encryptedContent,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String encryptedContent,  DateTime timestamp,  String signature)?  $default,) {final _that = this;
switch (_that) {
case _EncryptedPost() when $default != null:
return $default(_that.encryptedContent,_that.timestamp,_that.signature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EncryptedPost implements EncryptedPost {
  const _EncryptedPost({required this.encryptedContent, required this.timestamp, required this.signature});
  factory _EncryptedPost.fromJson(Map<String, dynamic> json) => _$EncryptedPostFromJson(json);

/// The encrypted payload (base64-encoded). Contains the serialized
/// PostContent, routing, details, crosspost, and parent (if a reply).
@override final  String encryptedContent;
/// When the post was created.
@override final  DateTime timestamp;
/// Author's signature over the encrypted payload.
@override final  String signature;

/// Create a copy of EncryptedPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EncryptedPostCopyWith<_EncryptedPost> get copyWith => __$EncryptedPostCopyWithImpl<_EncryptedPost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EncryptedPostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EncryptedPost&&(identical(other.encryptedContent, encryptedContent) || other.encryptedContent == encryptedContent)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,encryptedContent,timestamp,signature);

@override
String toString() {
  return 'EncryptedPost(encryptedContent: $encryptedContent, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class _$EncryptedPostCopyWith<$Res> implements $EncryptedPostCopyWith<$Res> {
  factory _$EncryptedPostCopyWith(_EncryptedPost value, $Res Function(_EncryptedPost) _then) = __$EncryptedPostCopyWithImpl;
@override @useResult
$Res call({
 String encryptedContent, DateTime timestamp, String signature
});




}
/// @nodoc
class __$EncryptedPostCopyWithImpl<$Res>
    implements _$EncryptedPostCopyWith<$Res> {
  __$EncryptedPostCopyWithImpl(this._self, this._then);

  final _EncryptedPost _self;
  final $Res Function(_EncryptedPost) _then;

/// Create a copy of EncryptedPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? encryptedContent = null,Object? timestamp = null,Object? signature = null,}) {
  return _then(_EncryptedPost(
encryptedContent: null == encryptedContent ? _self.encryptedContent : encryptedContent // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
