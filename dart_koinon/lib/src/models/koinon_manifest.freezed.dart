// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'koinon_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KoinonManifest _$KoinonManifestFromJson(Map<String, dynamic> json) {
  return _KoinonManifest.fromJson(json);
}

/// @nodoc
mixin _$KoinonManifest {
  /// Always "koinon".
  String get protocol => throw _privateConstructorUsedError;

  /// Protocol version.
  String get version => throw _privateConstructorUsedError;

  /// The polites's public key.
  String get pubkey => throw _privateConstructorUsedError;

  /// Radicle repo identifier (optional).
  @JsonKey(name: 'repo_radicle')
  String? get repoRadicle => throw _privateConstructorUsedError;

  /// HTTPS repo URL.
  @JsonKey(name: 'repo_https')
  String get repoHttps => throw _privateConstructorUsedError;

  /// Poleis the user belongs to.
  List<PolisMembership> get poleis => throw _privateConstructorUsedError;

  /// Inline trust declarations.
  List<TrustEntry> get trust => throw _privateConstructorUsedError;

  /// Serializes this KoinonManifest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KoinonManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KoinonManifestCopyWith<KoinonManifest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KoinonManifestCopyWith<$Res> {
  factory $KoinonManifestCopyWith(
    KoinonManifest value,
    $Res Function(KoinonManifest) then,
  ) = _$KoinonManifestCopyWithImpl<$Res, KoinonManifest>;
  @useResult
  $Res call({
    String protocol,
    String version,
    String pubkey,
    @JsonKey(name: 'repo_radicle') String? repoRadicle,
    @JsonKey(name: 'repo_https') String repoHttps,
    List<PolisMembership> poleis,
    List<TrustEntry> trust,
  });
}

/// @nodoc
class _$KoinonManifestCopyWithImpl<$Res, $Val extends KoinonManifest>
    implements $KoinonManifestCopyWith<$Res> {
  _$KoinonManifestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KoinonManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protocol = null,
    Object? version = null,
    Object? pubkey = null,
    Object? repoRadicle = freezed,
    Object? repoHttps = null,
    Object? poleis = null,
    Object? trust = null,
  }) {
    return _then(
      _value.copyWith(
            protocol: null == protocol
                ? _value.protocol
                : protocol // ignore: cast_nullable_to_non_nullable
                      as String,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String,
            pubkey: null == pubkey
                ? _value.pubkey
                : pubkey // ignore: cast_nullable_to_non_nullable
                      as String,
            repoRadicle: freezed == repoRadicle
                ? _value.repoRadicle
                : repoRadicle // ignore: cast_nullable_to_non_nullable
                      as String?,
            repoHttps: null == repoHttps
                ? _value.repoHttps
                : repoHttps // ignore: cast_nullable_to_non_nullable
                      as String,
            poleis: null == poleis
                ? _value.poleis
                : poleis // ignore: cast_nullable_to_non_nullable
                      as List<PolisMembership>,
            trust: null == trust
                ? _value.trust
                : trust // ignore: cast_nullable_to_non_nullable
                      as List<TrustEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KoinonManifestImplCopyWith<$Res>
    implements $KoinonManifestCopyWith<$Res> {
  factory _$$KoinonManifestImplCopyWith(
    _$KoinonManifestImpl value,
    $Res Function(_$KoinonManifestImpl) then,
  ) = __$$KoinonManifestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String protocol,
    String version,
    String pubkey,
    @JsonKey(name: 'repo_radicle') String? repoRadicle,
    @JsonKey(name: 'repo_https') String repoHttps,
    List<PolisMembership> poleis,
    List<TrustEntry> trust,
  });
}

/// @nodoc
class __$$KoinonManifestImplCopyWithImpl<$Res>
    extends _$KoinonManifestCopyWithImpl<$Res, _$KoinonManifestImpl>
    implements _$$KoinonManifestImplCopyWith<$Res> {
  __$$KoinonManifestImplCopyWithImpl(
    _$KoinonManifestImpl _value,
    $Res Function(_$KoinonManifestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KoinonManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protocol = null,
    Object? version = null,
    Object? pubkey = null,
    Object? repoRadicle = freezed,
    Object? repoHttps = null,
    Object? poleis = null,
    Object? trust = null,
  }) {
    return _then(
      _$KoinonManifestImpl(
        protocol: null == protocol
            ? _value.protocol
            : protocol // ignore: cast_nullable_to_non_nullable
                  as String,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String,
        pubkey: null == pubkey
            ? _value.pubkey
            : pubkey // ignore: cast_nullable_to_non_nullable
                  as String,
        repoRadicle: freezed == repoRadicle
            ? _value.repoRadicle
            : repoRadicle // ignore: cast_nullable_to_non_nullable
                  as String?,
        repoHttps: null == repoHttps
            ? _value.repoHttps
            : repoHttps // ignore: cast_nullable_to_non_nullable
                  as String,
        poleis: null == poleis
            ? _value._poleis
            : poleis // ignore: cast_nullable_to_non_nullable
                  as List<PolisMembership>,
        trust: null == trust
            ? _value._trust
            : trust // ignore: cast_nullable_to_non_nullable
                  as List<TrustEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KoinonManifestImpl implements _KoinonManifest {
  const _$KoinonManifestImpl({
    this.protocol = 'koinon',
    this.version = '1.0',
    required this.pubkey,
    @JsonKey(name: 'repo_radicle') this.repoRadicle,
    @JsonKey(name: 'repo_https') required this.repoHttps,
    final List<PolisMembership> poleis = const [],
    final List<TrustEntry> trust = const [],
  }) : _poleis = poleis,
       _trust = trust;

  factory _$KoinonManifestImpl.fromJson(Map<String, dynamic> json) =>
      _$$KoinonManifestImplFromJson(json);

  /// Always "koinon".
  @override
  @JsonKey()
  final String protocol;

  /// Protocol version.
  @override
  @JsonKey()
  final String version;

  /// The polites's public key.
  @override
  final String pubkey;

  /// Radicle repo identifier (optional).
  @override
  @JsonKey(name: 'repo_radicle')
  final String? repoRadicle;

  /// HTTPS repo URL.
  @override
  @JsonKey(name: 'repo_https')
  final String repoHttps;

  /// Poleis the user belongs to.
  final List<PolisMembership> _poleis;

  /// Poleis the user belongs to.
  @override
  @JsonKey()
  List<PolisMembership> get poleis {
    if (_poleis is EqualUnmodifiableListView) return _poleis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_poleis);
  }

  /// Inline trust declarations.
  final List<TrustEntry> _trust;

  /// Inline trust declarations.
  @override
  @JsonKey()
  List<TrustEntry> get trust {
    if (_trust is EqualUnmodifiableListView) return _trust;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trust);
  }

  @override
  String toString() {
    return 'KoinonManifest(protocol: $protocol, version: $version, pubkey: $pubkey, repoRadicle: $repoRadicle, repoHttps: $repoHttps, poleis: $poleis, trust: $trust)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KoinonManifestImpl &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.pubkey, pubkey) || other.pubkey == pubkey) &&
            (identical(other.repoRadicle, repoRadicle) ||
                other.repoRadicle == repoRadicle) &&
            (identical(other.repoHttps, repoHttps) ||
                other.repoHttps == repoHttps) &&
            const DeepCollectionEquality().equals(other._poleis, _poleis) &&
            const DeepCollectionEquality().equals(other._trust, _trust));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    protocol,
    version,
    pubkey,
    repoRadicle,
    repoHttps,
    const DeepCollectionEquality().hash(_poleis),
    const DeepCollectionEquality().hash(_trust),
  );

  /// Create a copy of KoinonManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KoinonManifestImplCopyWith<_$KoinonManifestImpl> get copyWith =>
      __$$KoinonManifestImplCopyWithImpl<_$KoinonManifestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$KoinonManifestImplToJson(this);
  }
}

abstract class _KoinonManifest implements KoinonManifest {
  const factory _KoinonManifest({
    final String protocol,
    final String version,
    required final String pubkey,
    @JsonKey(name: 'repo_radicle') final String? repoRadicle,
    @JsonKey(name: 'repo_https') required final String repoHttps,
    final List<PolisMembership> poleis,
    final List<TrustEntry> trust,
  }) = _$KoinonManifestImpl;

  factory _KoinonManifest.fromJson(Map<String, dynamic> json) =
      _$KoinonManifestImpl.fromJson;

  /// Always "koinon".
  @override
  String get protocol;

  /// Protocol version.
  @override
  String get version;

  /// The polites's public key.
  @override
  String get pubkey;

  /// Radicle repo identifier (optional).
  @override
  @JsonKey(name: 'repo_radicle')
  String? get repoRadicle;

  /// HTTPS repo URL.
  @override
  @JsonKey(name: 'repo_https')
  String get repoHttps;

  /// Poleis the user belongs to.
  @override
  List<PolisMembership> get poleis;

  /// Inline trust declarations.
  @override
  List<TrustEntry> get trust;

  /// Create a copy of KoinonManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KoinonManifestImplCopyWith<_$KoinonManifestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
