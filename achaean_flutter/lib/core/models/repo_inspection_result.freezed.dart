// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_inspection_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RepoInspectionResult _$RepoInspectionResultFromJson(Map<String, dynamic> json) {
  return _RepoInspectionResult.fromJson(json);
}

/// @nodoc
mixin _$RepoInspectionResult {
  KoinonManifest? get manifest => throw _privateConstructorUsedError;
  List<TrustDeclaration> get trustDeclarations =>
      throw _privateConstructorUsedError;
  List<ReadmeSignature> get readmeSignatures =>
      throw _privateConstructorUsedError;
  List<Post> get posts => throw _privateConstructorUsedError;

  /// Serializes this RepoInspectionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepoInspectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepoInspectionResultCopyWith<RepoInspectionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoInspectionResultCopyWith<$Res> {
  factory $RepoInspectionResultCopyWith(
    RepoInspectionResult value,
    $Res Function(RepoInspectionResult) then,
  ) = _$RepoInspectionResultCopyWithImpl<$Res, RepoInspectionResult>;
  @useResult
  $Res call({
    KoinonManifest? manifest,
    List<TrustDeclaration> trustDeclarations,
    List<ReadmeSignature> readmeSignatures,
    List<Post> posts,
  });

  $KoinonManifestCopyWith<$Res>? get manifest;
}

/// @nodoc
class _$RepoInspectionResultCopyWithImpl<
  $Res,
  $Val extends RepoInspectionResult
>
    implements $RepoInspectionResultCopyWith<$Res> {
  _$RepoInspectionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepoInspectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manifest = freezed,
    Object? trustDeclarations = null,
    Object? readmeSignatures = null,
    Object? posts = null,
  }) {
    return _then(
      _value.copyWith(
            manifest: freezed == manifest
                ? _value.manifest
                : manifest // ignore: cast_nullable_to_non_nullable
                      as KoinonManifest?,
            trustDeclarations: null == trustDeclarations
                ? _value.trustDeclarations
                : trustDeclarations // ignore: cast_nullable_to_non_nullable
                      as List<TrustDeclaration>,
            readmeSignatures: null == readmeSignatures
                ? _value.readmeSignatures
                : readmeSignatures // ignore: cast_nullable_to_non_nullable
                      as List<ReadmeSignature>,
            posts: null == posts
                ? _value.posts
                : posts // ignore: cast_nullable_to_non_nullable
                      as List<Post>,
          )
          as $Val,
    );
  }

  /// Create a copy of RepoInspectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KoinonManifestCopyWith<$Res>? get manifest {
    if (_value.manifest == null) {
      return null;
    }

    return $KoinonManifestCopyWith<$Res>(_value.manifest!, (value) {
      return _then(_value.copyWith(manifest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RepoInspectionResultImplCopyWith<$Res>
    implements $RepoInspectionResultCopyWith<$Res> {
  factory _$$RepoInspectionResultImplCopyWith(
    _$RepoInspectionResultImpl value,
    $Res Function(_$RepoInspectionResultImpl) then,
  ) = __$$RepoInspectionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    KoinonManifest? manifest,
    List<TrustDeclaration> trustDeclarations,
    List<ReadmeSignature> readmeSignatures,
    List<Post> posts,
  });

  @override
  $KoinonManifestCopyWith<$Res>? get manifest;
}

/// @nodoc
class __$$RepoInspectionResultImplCopyWithImpl<$Res>
    extends _$RepoInspectionResultCopyWithImpl<$Res, _$RepoInspectionResultImpl>
    implements _$$RepoInspectionResultImplCopyWith<$Res> {
  __$$RepoInspectionResultImplCopyWithImpl(
    _$RepoInspectionResultImpl _value,
    $Res Function(_$RepoInspectionResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepoInspectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manifest = freezed,
    Object? trustDeclarations = null,
    Object? readmeSignatures = null,
    Object? posts = null,
  }) {
    return _then(
      _$RepoInspectionResultImpl(
        manifest: freezed == manifest
            ? _value.manifest
            : manifest // ignore: cast_nullable_to_non_nullable
                  as KoinonManifest?,
        trustDeclarations: null == trustDeclarations
            ? _value._trustDeclarations
            : trustDeclarations // ignore: cast_nullable_to_non_nullable
                  as List<TrustDeclaration>,
        readmeSignatures: null == readmeSignatures
            ? _value._readmeSignatures
            : readmeSignatures // ignore: cast_nullable_to_non_nullable
                  as List<ReadmeSignature>,
        posts: null == posts
            ? _value._posts
            : posts // ignore: cast_nullable_to_non_nullable
                  as List<Post>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RepoInspectionResultImpl implements _RepoInspectionResult {
  const _$RepoInspectionResultImpl({
    this.manifest,
    final List<TrustDeclaration> trustDeclarations = const [],
    final List<ReadmeSignature> readmeSignatures = const [],
    final List<Post> posts = const [],
  }) : _trustDeclarations = trustDeclarations,
       _readmeSignatures = readmeSignatures,
       _posts = posts;

  factory _$RepoInspectionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepoInspectionResultImplFromJson(json);

  @override
  final KoinonManifest? manifest;
  final List<TrustDeclaration> _trustDeclarations;
  @override
  @JsonKey()
  List<TrustDeclaration> get trustDeclarations {
    if (_trustDeclarations is EqualUnmodifiableListView)
      return _trustDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trustDeclarations);
  }

  final List<ReadmeSignature> _readmeSignatures;
  @override
  @JsonKey()
  List<ReadmeSignature> get readmeSignatures {
    if (_readmeSignatures is EqualUnmodifiableListView)
      return _readmeSignatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readmeSignatures);
  }

  final List<Post> _posts;
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  String toString() {
    return 'RepoInspectionResult(manifest: $manifest, trustDeclarations: $trustDeclarations, readmeSignatures: $readmeSignatures, posts: $posts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoInspectionResultImpl &&
            (identical(other.manifest, manifest) ||
                other.manifest == manifest) &&
            const DeepCollectionEquality().equals(
              other._trustDeclarations,
              _trustDeclarations,
            ) &&
            const DeepCollectionEquality().equals(
              other._readmeSignatures,
              _readmeSignatures,
            ) &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    manifest,
    const DeepCollectionEquality().hash(_trustDeclarations),
    const DeepCollectionEquality().hash(_readmeSignatures),
    const DeepCollectionEquality().hash(_posts),
  );

  /// Create a copy of RepoInspectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoInspectionResultImplCopyWith<_$RepoInspectionResultImpl>
  get copyWith =>
      __$$RepoInspectionResultImplCopyWithImpl<_$RepoInspectionResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RepoInspectionResultImplToJson(this);
  }
}

abstract class _RepoInspectionResult implements RepoInspectionResult {
  const factory _RepoInspectionResult({
    final KoinonManifest? manifest,
    final List<TrustDeclaration> trustDeclarations,
    final List<ReadmeSignature> readmeSignatures,
    final List<Post> posts,
  }) = _$RepoInspectionResultImpl;

  factory _RepoInspectionResult.fromJson(Map<String, dynamic> json) =
      _$RepoInspectionResultImpl.fromJson;

  @override
  KoinonManifest? get manifest;
  @override
  List<TrustDeclaration> get trustDeclarations;
  @override
  List<ReadmeSignature> get readmeSignatures;
  @override
  List<Post> get posts;

  /// Create a copy of RepoInspectionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepoInspectionResultImplCopyWith<_$RepoInspectionResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}
