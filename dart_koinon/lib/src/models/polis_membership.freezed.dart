// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polis_membership.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PolisMembership _$PolisMembershipFromJson(Map<String, dynamic> json) {
  return _PolisMembership.fromJson(json);
}

/// @nodoc
mixin _$PolisMembership {
  /// The polis repo identifier.
  String get repo => throw _privateConstructorUsedError;

  /// Display name of the polis.
  String get name => throw _privateConstructorUsedError;

  /// Number of keypairs that signed the current README.
  int get stars => throw _privateConstructorUsedError;

  /// The user's role/trust level in this polis.
  String get role => throw _privateConstructorUsedError;

  /// Serializes this PolisMembership to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PolisMembership
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PolisMembershipCopyWith<PolisMembership> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolisMembershipCopyWith<$Res> {
  factory $PolisMembershipCopyWith(
    PolisMembership value,
    $Res Function(PolisMembership) then,
  ) = _$PolisMembershipCopyWithImpl<$Res, PolisMembership>;
  @useResult
  $Res call({String repo, String name, int stars, String role});
}

/// @nodoc
class _$PolisMembershipCopyWithImpl<$Res, $Val extends PolisMembership>
    implements $PolisMembershipCopyWith<$Res> {
  _$PolisMembershipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PolisMembership
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repo = null,
    Object? name = null,
    Object? stars = null,
    Object? role = null,
  }) {
    return _then(
      _value.copyWith(
            repo: null == repo
                ? _value.repo
                : repo // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            stars: null == stars
                ? _value.stars
                : stars // ignore: cast_nullable_to_non_nullable
                      as int,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PolisMembershipImplCopyWith<$Res>
    implements $PolisMembershipCopyWith<$Res> {
  factory _$$PolisMembershipImplCopyWith(
    _$PolisMembershipImpl value,
    $Res Function(_$PolisMembershipImpl) then,
  ) = __$$PolisMembershipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String repo, String name, int stars, String role});
}

/// @nodoc
class __$$PolisMembershipImplCopyWithImpl<$Res>
    extends _$PolisMembershipCopyWithImpl<$Res, _$PolisMembershipImpl>
    implements _$$PolisMembershipImplCopyWith<$Res> {
  __$$PolisMembershipImplCopyWithImpl(
    _$PolisMembershipImpl _value,
    $Res Function(_$PolisMembershipImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PolisMembership
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repo = null,
    Object? name = null,
    Object? stars = null,
    Object? role = null,
  }) {
    return _then(
      _$PolisMembershipImpl(
        repo: null == repo
            ? _value.repo
            : repo // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        stars: null == stars
            ? _value.stars
            : stars // ignore: cast_nullable_to_non_nullable
                  as int,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PolisMembershipImpl implements _PolisMembership {
  const _$PolisMembershipImpl({
    required this.repo,
    required this.name,
    required this.stars,
    required this.role,
  });

  factory _$PolisMembershipImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolisMembershipImplFromJson(json);

  /// The polis repo identifier.
  @override
  final String repo;

  /// Display name of the polis.
  @override
  final String name;

  /// Number of keypairs that signed the current README.
  @override
  final int stars;

  /// The user's role/trust level in this polis.
  @override
  final String role;

  @override
  String toString() {
    return 'PolisMembership(repo: $repo, name: $name, stars: $stars, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolisMembershipImpl &&
            (identical(other.repo, repo) || other.repo == repo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, repo, name, stars, role);

  /// Create a copy of PolisMembership
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PolisMembershipImplCopyWith<_$PolisMembershipImpl> get copyWith =>
      __$$PolisMembershipImplCopyWithImpl<_$PolisMembershipImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PolisMembershipImplToJson(this);
  }
}

abstract class _PolisMembership implements PolisMembership {
  const factory _PolisMembership({
    required final String repo,
    required final String name,
    required final int stars,
    required final String role,
  }) = _$PolisMembershipImpl;

  factory _PolisMembership.fromJson(Map<String, dynamic> json) =
      _$PolisMembershipImpl.fromJson;

  /// The polis repo identifier.
  @override
  String get repo;

  /// Display name of the polis.
  @override
  String get name;

  /// Number of keypairs that signed the current README.
  @override
  int get stars;

  /// The user's role/trust level in this polis.
  @override
  String get role;

  /// Create a copy of PolisMembership
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PolisMembershipImplCopyWith<_$PolisMembershipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
