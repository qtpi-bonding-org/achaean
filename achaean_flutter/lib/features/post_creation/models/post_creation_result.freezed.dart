// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_creation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostCreationResult _$PostCreationResultFromJson(Map<String, dynamic> json) {
  return _PostCreationResult.fromJson(json);
}

/// @nodoc
mixin _$PostCreationResult {
  String get path => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this PostCreationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCreationResultCopyWith<PostCreationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCreationResultCopyWith<$Res> {
  factory $PostCreationResultCopyWith(
    PostCreationResult value,
    $Res Function(PostCreationResult) then,
  ) = _$PostCreationResultCopyWithImpl<$Res, PostCreationResult>;
  @useResult
  $Res call({String path, String slug, DateTime timestamp});
}

/// @nodoc
class _$PostCreationResultCopyWithImpl<$Res, $Val extends PostCreationResult>
    implements $PostCreationResultCopyWith<$Res> {
  _$PostCreationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? slug = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            path: null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostCreationResultImplCopyWith<$Res>
    implements $PostCreationResultCopyWith<$Res> {
  factory _$$PostCreationResultImplCopyWith(
    _$PostCreationResultImpl value,
    $Res Function(_$PostCreationResultImpl) then,
  ) = __$$PostCreationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, String slug, DateTime timestamp});
}

/// @nodoc
class __$$PostCreationResultImplCopyWithImpl<$Res>
    extends _$PostCreationResultCopyWithImpl<$Res, _$PostCreationResultImpl>
    implements _$$PostCreationResultImplCopyWith<$Res> {
  __$$PostCreationResultImplCopyWithImpl(
    _$PostCreationResultImpl _value,
    $Res Function(_$PostCreationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? slug = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$PostCreationResultImpl(
        path: null == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostCreationResultImpl implements _PostCreationResult {
  const _$PostCreationResultImpl({
    required this.path,
    required this.slug,
    required this.timestamp,
  });

  factory _$PostCreationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCreationResultImplFromJson(json);

  @override
  final String path;
  @override
  final String slug;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'PostCreationResult(path: $path, slug: $slug, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCreationResultImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, path, slug, timestamp);

  /// Create a copy of PostCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCreationResultImplCopyWith<_$PostCreationResultImpl> get copyWith =>
      __$$PostCreationResultImplCopyWithImpl<_$PostCreationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCreationResultImplToJson(this);
  }
}

abstract class _PostCreationResult implements PostCreationResult {
  const factory _PostCreationResult({
    required final String path,
    required final String slug,
    required final DateTime timestamp,
  }) = _$PostCreationResultImpl;

  factory _PostCreationResult.fromJson(Map<String, dynamic> json) =
      _$PostCreationResultImpl.fromJson;

  @override
  String get path;
  @override
  String get slug;
  @override
  DateTime get timestamp;

  /// Create a copy of PostCreationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostCreationResultImplCopyWith<_$PostCreationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
