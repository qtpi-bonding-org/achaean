// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostContent {

/// The post text (always present).
 String get text;/// Optional headline.
 String? get title;/// Optional link.
 String? get url;/// Filenames of images/assets in the post directory.
 List<String> get media;
/// Create a copy of PostContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostContentCopyWith<PostContent> get copyWith => _$PostContentCopyWithImpl<PostContent>(this as PostContent, _$identity);

  /// Serializes this PostContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostContent&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.media, media));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,title,url,const DeepCollectionEquality().hash(media));

@override
String toString() {
  return 'PostContent(text: $text, title: $title, url: $url, media: $media)';
}


}

/// @nodoc
abstract mixin class $PostContentCopyWith<$Res>  {
  factory $PostContentCopyWith(PostContent value, $Res Function(PostContent) _then) = _$PostContentCopyWithImpl;
@useResult
$Res call({
 String text, String? title, String? url, List<String> media
});




}
/// @nodoc
class _$PostContentCopyWithImpl<$Res>
    implements $PostContentCopyWith<$Res> {
  _$PostContentCopyWithImpl(this._self, this._then);

  final PostContent _self;
  final $Res Function(PostContent) _then;

/// Create a copy of PostContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? title = freezed,Object? url = freezed,Object? media = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PostContent].
extension PostContentPatterns on PostContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostContent value)  $default,){
final _that = this;
switch (_that) {
case _PostContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostContent value)?  $default,){
final _that = this;
switch (_that) {
case _PostContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String? title,  String? url,  List<String> media)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostContent() when $default != null:
return $default(_that.text,_that.title,_that.url,_that.media);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String? title,  String? url,  List<String> media)  $default,) {final _that = this;
switch (_that) {
case _PostContent():
return $default(_that.text,_that.title,_that.url,_that.media);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String? title,  String? url,  List<String> media)?  $default,) {final _that = this;
switch (_that) {
case _PostContent() when $default != null:
return $default(_that.text,_that.title,_that.url,_that.media);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostContent implements PostContent {
  const _PostContent({required this.text, this.title, this.url, final  List<String> media = const []}): _media = media;
  factory _PostContent.fromJson(Map<String, dynamic> json) => _$PostContentFromJson(json);

/// The post text (always present).
@override final  String text;
/// Optional headline.
@override final  String? title;
/// Optional link.
@override final  String? url;
/// Filenames of images/assets in the post directory.
 final  List<String> _media;
/// Filenames of images/assets in the post directory.
@override@JsonKey() List<String> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}


/// Create a copy of PostContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostContentCopyWith<_PostContent> get copyWith => __$PostContentCopyWithImpl<_PostContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostContent&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._media, _media));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,title,url,const DeepCollectionEquality().hash(_media));

@override
String toString() {
  return 'PostContent(text: $text, title: $title, url: $url, media: $media)';
}


}

/// @nodoc
abstract mixin class _$PostContentCopyWith<$Res> implements $PostContentCopyWith<$Res> {
  factory _$PostContentCopyWith(_PostContent value, $Res Function(_PostContent) _then) = __$PostContentCopyWithImpl;
@override @useResult
$Res call({
 String text, String? title, String? url, List<String> media
});




}
/// @nodoc
class __$PostContentCopyWithImpl<$Res>
    implements _$PostContentCopyWith<$Res> {
  __$PostContentCopyWithImpl(this._self, this._then);

  final _PostContent _self;
  final $Res Function(_PostContent) _then;

/// Create a copy of PostContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? title = freezed,Object? url = freezed,Object? media = null,}) {
  return _then(_PostContent(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
