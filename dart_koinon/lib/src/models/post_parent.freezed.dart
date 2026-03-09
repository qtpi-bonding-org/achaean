// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_parent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostParent _$PostParentFromJson(Map<String, dynamic> json) {
  return _PostParent.fromJson(json);
}

/// @nodoc
mixin _$PostParent {
  /// Parent author's public key.
  String get author => throw _privateConstructorUsedError;

  /// Parent author's repo ID.
  String get repo => throw _privateConstructorUsedError;

  /// Path to parent's post.json.
  String get path => throw _privateConstructorUsedError;

  /// Git commit hash of the parent post.
  String get commit => throw _privateConstructorUsedError;

  /// Serializes this PostParent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostParent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostParentCopyWith<PostParent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostParentCopyWith<$Res> {
  factory $PostParentCopyWith(
    PostParent value,
    $Res Function(PostParent) then,
  ) = _$PostParentCopyWithImpl<$Res, PostParent>;
  @useResult
  $Res call({String author, String repo, String path, String commit});
}

/// @nodoc
class _$PostParentCopyWithImpl<$Res, $Val extends PostParent>
    implements $PostParentCopyWith<$Res> {
  _$PostParentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostParent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? repo = null,
    Object? path = null,
    Object? commit = null,
  }) {
    return _then(
      _value.copyWith(
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String,
            repo: null == repo
                ? _value.repo
                : repo // ignore: cast_nullable_to_non_nullable
                      as String,
            path: null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String,
            commit: null == commit
                ? _value.commit
                : commit // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostParentImplCopyWith<$Res>
    implements $PostParentCopyWith<$Res> {
  factory _$$PostParentImplCopyWith(
    _$PostParentImpl value,
    $Res Function(_$PostParentImpl) then,
  ) = __$$PostParentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String author, String repo, String path, String commit});
}

/// @nodoc
class __$$PostParentImplCopyWithImpl<$Res>
    extends _$PostParentCopyWithImpl<$Res, _$PostParentImpl>
    implements _$$PostParentImplCopyWith<$Res> {
  __$$PostParentImplCopyWithImpl(
    _$PostParentImpl _value,
    $Res Function(_$PostParentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostParent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? repo = null,
    Object? path = null,
    Object? commit = null,
  }) {
    return _then(
      _$PostParentImpl(
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String,
        repo: null == repo
            ? _value.repo
            : repo // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        commit: null == commit
            ? _value.commit
            : commit // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostParentImpl implements _PostParent {
  const _$PostParentImpl({
    required this.author,
    required this.repo,
    required this.path,
    required this.commit,
  });

  factory _$PostParentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostParentImplFromJson(json);

  /// Parent author's public key.
  @override
  final String author;

  /// Parent author's repo ID.
  @override
  final String repo;

  /// Path to parent's post.json.
  @override
  final String path;

  /// Git commit hash of the parent post.
  @override
  final String commit;

  @override
  String toString() {
    return 'PostParent(author: $author, repo: $repo, path: $path, commit: $commit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostParentImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.repo, repo) || other.repo == repo) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.commit, commit) || other.commit == commit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, author, repo, path, commit);

  /// Create a copy of PostParent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostParentImplCopyWith<_$PostParentImpl> get copyWith =>
      __$$PostParentImplCopyWithImpl<_$PostParentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostParentImplToJson(this);
  }
}

abstract class _PostParent implements PostParent {
  const factory _PostParent({
    required final String author,
    required final String repo,
    required final String path,
    required final String commit,
  }) = _$PostParentImpl;

  factory _PostParent.fromJson(Map<String, dynamic> json) =
      _$PostParentImpl.fromJson;

  /// Parent author's public key.
  @override
  String get author;

  /// Parent author's repo ID.
  @override
  String get repo;

  /// Path to parent's post.json.
  @override
  String get path;

  /// Git commit hash of the parent post.
  @override
  String get commit;

  /// Create a copy of PostParent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostParentImplCopyWith<_$PostParentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
