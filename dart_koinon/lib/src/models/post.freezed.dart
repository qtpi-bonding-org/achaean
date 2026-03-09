// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  /// The content of the post.
  PostContent get content => throw _privateConstructorUsedError;

  /// Routing info (poleis, tags, mentions). Present on posts, absent on replies.
  PostRouting? get routing => throw _privateConstructorUsedError;

  /// Parent reference. Present on replies, absent on top-level posts.
  PostParent? get parent => throw _privateConstructorUsedError;

  /// Freeform structured metadata (polls, events, listings, etc.).
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;

  /// Crosspost configuration per platform.
  Map<String, dynamic>? get crosspost => throw _privateConstructorUsedError;

  /// When the post was created.
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Author's Web Crypto signature.
  String get signature => throw _privateConstructorUsedError;

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call({
    PostContent content,
    PostRouting? routing,
    PostParent? parent,
    Map<String, dynamic>? details,
    Map<String, dynamic>? crosspost,
    DateTime timestamp,
    String signature,
  });

  $PostContentCopyWith<$Res> get content;
  $PostRoutingCopyWith<$Res>? get routing;
  $PostParentCopyWith<$Res>? get parent;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? routing = freezed,
    Object? parent = freezed,
    Object? details = freezed,
    Object? crosspost = freezed,
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(
      _value.copyWith(
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as PostContent,
            routing: freezed == routing
                ? _value.routing
                : routing // ignore: cast_nullable_to_non_nullable
                      as PostRouting?,
            parent: freezed == parent
                ? _value.parent
                : parent // ignore: cast_nullable_to_non_nullable
                      as PostParent?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            crosspost: freezed == crosspost
                ? _value.crosspost
                : crosspost // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            signature: null == signature
                ? _value.signature
                : signature // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostContentCopyWith<$Res> get content {
    return $PostContentCopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostRoutingCopyWith<$Res>? get routing {
    if (_value.routing == null) {
      return null;
    }

    return $PostRoutingCopyWith<$Res>(_value.routing!, (value) {
      return _then(_value.copyWith(routing: value) as $Val);
    });
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostParentCopyWith<$Res>? get parent {
    if (_value.parent == null) {
      return null;
    }

    return $PostParentCopyWith<$Res>(_value.parent!, (value) {
      return _then(_value.copyWith(parent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
    _$PostImpl value,
    $Res Function(_$PostImpl) then,
  ) = __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PostContent content,
    PostRouting? routing,
    PostParent? parent,
    Map<String, dynamic>? details,
    Map<String, dynamic>? crosspost,
    DateTime timestamp,
    String signature,
  });

  @override
  $PostContentCopyWith<$Res> get content;
  @override
  $PostRoutingCopyWith<$Res>? get routing;
  @override
  $PostParentCopyWith<$Res>? get parent;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
    : super(_value, _then);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? routing = freezed,
    Object? parent = freezed,
    Object? details = freezed,
    Object? crosspost = freezed,
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(
      _$PostImpl(
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as PostContent,
        routing: freezed == routing
            ? _value.routing
            : routing // ignore: cast_nullable_to_non_nullable
                  as PostRouting?,
        parent: freezed == parent
            ? _value.parent
            : parent // ignore: cast_nullable_to_non_nullable
                  as PostParent?,
        details: freezed == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        crosspost: freezed == crosspost
            ? _value._crosspost
            : crosspost // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        signature: null == signature
            ? _value.signature
            : signature // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  const _$PostImpl({
    required this.content,
    this.routing,
    this.parent,
    final Map<String, dynamic>? details,
    final Map<String, dynamic>? crosspost,
    required this.timestamp,
    required this.signature,
  }) : _details = details,
       _crosspost = crosspost;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  /// The content of the post.
  @override
  final PostContent content;

  /// Routing info (poleis, tags, mentions). Present on posts, absent on replies.
  @override
  final PostRouting? routing;

  /// Parent reference. Present on replies, absent on top-level posts.
  @override
  final PostParent? parent;

  /// Freeform structured metadata (polls, events, listings, etc.).
  final Map<String, dynamic>? _details;

  /// Freeform structured metadata (polls, events, listings, etc.).
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Crosspost configuration per platform.
  final Map<String, dynamic>? _crosspost;

  /// Crosspost configuration per platform.
  @override
  Map<String, dynamic>? get crosspost {
    final value = _crosspost;
    if (value == null) return null;
    if (_crosspost is EqualUnmodifiableMapView) return _crosspost;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// When the post was created.
  @override
  final DateTime timestamp;

  /// Author's Web Crypto signature.
  @override
  final String signature;

  @override
  String toString() {
    return 'Post(content: $content, routing: $routing, parent: $parent, details: $details, crosspost: $crosspost, timestamp: $timestamp, signature: $signature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.routing, routing) || other.routing == routing) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            const DeepCollectionEquality().equals(
              other._crosspost,
              _crosspost,
            ) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    content,
    routing,
    parent,
    const DeepCollectionEquality().hash(_details),
    const DeepCollectionEquality().hash(_crosspost),
    timestamp,
    signature,
  );

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(this);
  }
}

abstract class _Post implements Post {
  const factory _Post({
    required final PostContent content,
    final PostRouting? routing,
    final PostParent? parent,
    final Map<String, dynamic>? details,
    final Map<String, dynamic>? crosspost,
    required final DateTime timestamp,
    required final String signature,
  }) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  /// The content of the post.
  @override
  PostContent get content;

  /// Routing info (poleis, tags, mentions). Present on posts, absent on replies.
  @override
  PostRouting? get routing;

  /// Parent reference. Present on replies, absent on top-level posts.
  @override
  PostParent? get parent;

  /// Freeform structured metadata (polls, events, listings, etc.).
  @override
  Map<String, dynamic>? get details;

  /// Crosspost configuration per platform.
  @override
  Map<String, dynamic>? get crosspost;

  /// When the post was created.
  @override
  DateTime get timestamp;

  /// Author's Web Crypto signature.
  @override
  String get signature;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
