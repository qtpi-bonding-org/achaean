// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_routing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostRouting _$PostRoutingFromJson(Map<String, dynamic> json) {
  return _PostRouting.fromJson(json);
}

/// @nodoc
mixin _$PostRouting {
  /// Which poleis this post is tagged for.
  List<String> get poleis => throw _privateConstructorUsedError;

  /// Hashtags / topic tags.
  List<String> get tags => throw _privateConstructorUsedError;

  /// Public keys of mentioned politai.
  List<String> get mentions => throw _privateConstructorUsedError;

  /// Serializes this PostRouting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostRouting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostRoutingCopyWith<PostRouting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostRoutingCopyWith<$Res> {
  factory $PostRoutingCopyWith(
    PostRouting value,
    $Res Function(PostRouting) then,
  ) = _$PostRoutingCopyWithImpl<$Res, PostRouting>;
  @useResult
  $Res call({List<String> poleis, List<String> tags, List<String> mentions});
}

/// @nodoc
class _$PostRoutingCopyWithImpl<$Res, $Val extends PostRouting>
    implements $PostRoutingCopyWith<$Res> {
  _$PostRoutingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostRouting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poleis = null,
    Object? tags = null,
    Object? mentions = null,
  }) {
    return _then(
      _value.copyWith(
            poleis: null == poleis
                ? _value.poleis
                : poleis // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mentions: null == mentions
                ? _value.mentions
                : mentions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostRoutingImplCopyWith<$Res>
    implements $PostRoutingCopyWith<$Res> {
  factory _$$PostRoutingImplCopyWith(
    _$PostRoutingImpl value,
    $Res Function(_$PostRoutingImpl) then,
  ) = __$$PostRoutingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> poleis, List<String> tags, List<String> mentions});
}

/// @nodoc
class __$$PostRoutingImplCopyWithImpl<$Res>
    extends _$PostRoutingCopyWithImpl<$Res, _$PostRoutingImpl>
    implements _$$PostRoutingImplCopyWith<$Res> {
  __$$PostRoutingImplCopyWithImpl(
    _$PostRoutingImpl _value,
    $Res Function(_$PostRoutingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostRouting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poleis = null,
    Object? tags = null,
    Object? mentions = null,
  }) {
    return _then(
      _$PostRoutingImpl(
        poleis: null == poleis
            ? _value._poleis
            : poleis // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mentions: null == mentions
            ? _value._mentions
            : mentions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostRoutingImpl implements _PostRouting {
  const _$PostRoutingImpl({
    final List<String> poleis = const [],
    final List<String> tags = const [],
    final List<String> mentions = const [],
  }) : _poleis = poleis,
       _tags = tags,
       _mentions = mentions;

  factory _$PostRoutingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostRoutingImplFromJson(json);

  /// Which poleis this post is tagged for.
  final List<String> _poleis;

  /// Which poleis this post is tagged for.
  @override
  @JsonKey()
  List<String> get poleis {
    if (_poleis is EqualUnmodifiableListView) return _poleis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_poleis);
  }

  /// Hashtags / topic tags.
  final List<String> _tags;

  /// Hashtags / topic tags.
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Public keys of mentioned politai.
  final List<String> _mentions;

  /// Public keys of mentioned politai.
  @override
  @JsonKey()
  List<String> get mentions {
    if (_mentions is EqualUnmodifiableListView) return _mentions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mentions);
  }

  @override
  String toString() {
    return 'PostRouting(poleis: $poleis, tags: $tags, mentions: $mentions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostRoutingImpl &&
            const DeepCollectionEquality().equals(other._poleis, _poleis) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._mentions, _mentions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_poleis),
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_mentions),
  );

  /// Create a copy of PostRouting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostRoutingImplCopyWith<_$PostRoutingImpl> get copyWith =>
      __$$PostRoutingImplCopyWithImpl<_$PostRoutingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostRoutingImplToJson(this);
  }
}

abstract class _PostRouting implements PostRouting {
  const factory _PostRouting({
    final List<String> poleis,
    final List<String> tags,
    final List<String> mentions,
  }) = _$PostRoutingImpl;

  factory _PostRouting.fromJson(Map<String, dynamic> json) =
      _$PostRoutingImpl.fromJson;

  /// Which poleis this post is tagged for.
  @override
  List<String> get poleis;

  /// Hashtags / topic tags.
  @override
  List<String> get tags;

  /// Public keys of mentioned politai.
  @override
  List<String> get mentions;

  /// Create a copy of PostRouting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostRoutingImplCopyWith<_$PostRoutingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
