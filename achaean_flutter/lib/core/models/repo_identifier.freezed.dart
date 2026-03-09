// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_identifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RepoIdentifier _$RepoIdentifierFromJson(Map<String, dynamic> json) {
  return _RepoIdentifier.fromJson(json);
}

/// @nodoc
mixin _$RepoIdentifier {
  String get baseUrl => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  String get repo => throw _privateConstructorUsedError;

  /// Serializes this RepoIdentifier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepoIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepoIdentifierCopyWith<RepoIdentifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoIdentifierCopyWith<$Res> {
  factory $RepoIdentifierCopyWith(
    RepoIdentifier value,
    $Res Function(RepoIdentifier) then,
  ) = _$RepoIdentifierCopyWithImpl<$Res, RepoIdentifier>;
  @useResult
  $Res call({String baseUrl, String owner, String repo});
}

/// @nodoc
class _$RepoIdentifierCopyWithImpl<$Res, $Val extends RepoIdentifier>
    implements $RepoIdentifierCopyWith<$Res> {
  _$RepoIdentifierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepoIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = null,
    Object? owner = null,
    Object? repo = null,
  }) {
    return _then(
      _value.copyWith(
            baseUrl: null == baseUrl
                ? _value.baseUrl
                : baseUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            owner: null == owner
                ? _value.owner
                : owner // ignore: cast_nullable_to_non_nullable
                      as String,
            repo: null == repo
                ? _value.repo
                : repo // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RepoIdentifierImplCopyWith<$Res>
    implements $RepoIdentifierCopyWith<$Res> {
  factory _$$RepoIdentifierImplCopyWith(
    _$RepoIdentifierImpl value,
    $Res Function(_$RepoIdentifierImpl) then,
  ) = __$$RepoIdentifierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String baseUrl, String owner, String repo});
}

/// @nodoc
class __$$RepoIdentifierImplCopyWithImpl<$Res>
    extends _$RepoIdentifierCopyWithImpl<$Res, _$RepoIdentifierImpl>
    implements _$$RepoIdentifierImplCopyWith<$Res> {
  __$$RepoIdentifierImplCopyWithImpl(
    _$RepoIdentifierImpl _value,
    $Res Function(_$RepoIdentifierImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepoIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = null,
    Object? owner = null,
    Object? repo = null,
  }) {
    return _then(
      _$RepoIdentifierImpl(
        baseUrl: null == baseUrl
            ? _value.baseUrl
            : baseUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        owner: null == owner
            ? _value.owner
            : owner // ignore: cast_nullable_to_non_nullable
                  as String,
        repo: null == repo
            ? _value.repo
            : repo // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RepoIdentifierImpl implements _RepoIdentifier {
  const _$RepoIdentifierImpl({
    required this.baseUrl,
    required this.owner,
    required this.repo,
  });

  factory _$RepoIdentifierImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepoIdentifierImplFromJson(json);

  @override
  final String baseUrl;
  @override
  final String owner;
  @override
  final String repo;

  @override
  String toString() {
    return 'RepoIdentifier(baseUrl: $baseUrl, owner: $owner, repo: $repo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoIdentifierImpl &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.repo, repo) || other.repo == repo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, baseUrl, owner, repo);

  /// Create a copy of RepoIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoIdentifierImplCopyWith<_$RepoIdentifierImpl> get copyWith =>
      __$$RepoIdentifierImplCopyWithImpl<_$RepoIdentifierImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RepoIdentifierImplToJson(this);
  }
}

abstract class _RepoIdentifier implements RepoIdentifier {
  const factory _RepoIdentifier({
    required final String baseUrl,
    required final String owner,
    required final String repo,
  }) = _$RepoIdentifierImpl;

  factory _RepoIdentifier.fromJson(Map<String, dynamic> json) =
      _$RepoIdentifierImpl.fromJson;

  @override
  String get baseUrl;
  @override
  String get owner;
  @override
  String get repo;

  /// Create a copy of RepoIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepoIdentifierImplCopyWith<_$RepoIdentifierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
