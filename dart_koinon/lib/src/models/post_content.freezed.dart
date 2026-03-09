// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostContent _$PostContentFromJson(Map<String, dynamic> json) {
  return _PostContent.fromJson(json);
}

/// @nodoc
mixin _$PostContent {
  /// The post text (always present).
  String get text => throw _privateConstructorUsedError;

  /// Optional headline.
  String? get title => throw _privateConstructorUsedError;

  /// Optional link.
  String? get url => throw _privateConstructorUsedError;

  /// Filenames of images/assets in the post directory.
  List<String> get media => throw _privateConstructorUsedError;

  /// Serializes this PostContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostContentCopyWith<PostContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostContentCopyWith<$Res> {
  factory $PostContentCopyWith(
    PostContent value,
    $Res Function(PostContent) then,
  ) = _$PostContentCopyWithImpl<$Res, PostContent>;
  @useResult
  $Res call({String text, String? title, String? url, List<String> media});
}

/// @nodoc
class _$PostContentCopyWithImpl<$Res, $Val extends PostContent>
    implements $PostContentCopyWith<$Res> {
  _$PostContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? title = freezed,
    Object? url = freezed,
    Object? media = null,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            media: null == media
                ? _value.media
                : media // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostContentImplCopyWith<$Res>
    implements $PostContentCopyWith<$Res> {
  factory _$$PostContentImplCopyWith(
    _$PostContentImpl value,
    $Res Function(_$PostContentImpl) then,
  ) = __$$PostContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? title, String? url, List<String> media});
}

/// @nodoc
class __$$PostContentImplCopyWithImpl<$Res>
    extends _$PostContentCopyWithImpl<$Res, _$PostContentImpl>
    implements _$$PostContentImplCopyWith<$Res> {
  __$$PostContentImplCopyWithImpl(
    _$PostContentImpl _value,
    $Res Function(_$PostContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? title = freezed,
    Object? url = freezed,
    Object? media = null,
  }) {
    return _then(
      _$PostContentImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        media: null == media
            ? _value._media
            : media // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostContentImpl implements _PostContent {
  const _$PostContentImpl({
    required this.text,
    this.title,
    this.url,
    final List<String> media = const [],
  }) : _media = media;

  factory _$PostContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostContentImplFromJson(json);

  /// The post text (always present).
  @override
  final String text;

  /// Optional headline.
  @override
  final String? title;

  /// Optional link.
  @override
  final String? url;

  /// Filenames of images/assets in the post directory.
  final List<String> _media;

  /// Filenames of images/assets in the post directory.
  @override
  @JsonKey()
  List<String> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  @override
  String toString() {
    return 'PostContent(text: $text, title: $title, url: $url, media: $media)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostContentImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._media, _media));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    text,
    title,
    url,
    const DeepCollectionEquality().hash(_media),
  );

  /// Create a copy of PostContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostContentImplCopyWith<_$PostContentImpl> get copyWith =>
      __$$PostContentImplCopyWithImpl<_$PostContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostContentImplToJson(this);
  }
}

abstract class _PostContent implements PostContent {
  const factory _PostContent({
    required final String text,
    final String? title,
    final String? url,
    final List<String> media,
  }) = _$PostContentImpl;

  factory _PostContent.fromJson(Map<String, dynamic> json) =
      _$PostContentImpl.fromJson;

  /// The post text (always present).
  @override
  String get text;

  /// Optional headline.
  @override
  String? get title;

  /// Optional link.
  @override
  String? get url;

  /// Filenames of images/assets in the post directory.
  @override
  List<String> get media;

  /// Create a copy of PostContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostContentImplCopyWith<_$PostContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
