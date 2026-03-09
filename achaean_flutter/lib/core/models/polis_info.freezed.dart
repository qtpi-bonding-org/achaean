// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polis_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PolisInfo _$PolisInfoFromJson(Map<String, dynamic> json) {
  return _PolisInfo.fromJson(json);
}

/// @nodoc
mixin _$PolisInfo {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get norms => throw _privateConstructorUsedError;
  int? get threshold => throw _privateConstructorUsedError;
  String? get parentRepo => throw _privateConstructorUsedError;

  /// Serializes this PolisInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PolisInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PolisInfoCopyWith<PolisInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolisInfoCopyWith<$Res> {
  factory $PolisInfoCopyWith(PolisInfo value, $Res Function(PolisInfo) then) =
      _$PolisInfoCopyWithImpl<$Res, PolisInfo>;
  @useResult
  $Res call({
    String name,
    String? description,
    String? norms,
    int? threshold,
    String? parentRepo,
  });
}

/// @nodoc
class _$PolisInfoCopyWithImpl<$Res, $Val extends PolisInfo>
    implements $PolisInfoCopyWith<$Res> {
  _$PolisInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PolisInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? norms = freezed,
    Object? threshold = freezed,
    Object? parentRepo = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            norms: freezed == norms
                ? _value.norms
                : norms // ignore: cast_nullable_to_non_nullable
                      as String?,
            threshold: freezed == threshold
                ? _value.threshold
                : threshold // ignore: cast_nullable_to_non_nullable
                      as int?,
            parentRepo: freezed == parentRepo
                ? _value.parentRepo
                : parentRepo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PolisInfoImplCopyWith<$Res>
    implements $PolisInfoCopyWith<$Res> {
  factory _$$PolisInfoImplCopyWith(
    _$PolisInfoImpl value,
    $Res Function(_$PolisInfoImpl) then,
  ) = __$$PolisInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String? description,
    String? norms,
    int? threshold,
    String? parentRepo,
  });
}

/// @nodoc
class __$$PolisInfoImplCopyWithImpl<$Res>
    extends _$PolisInfoCopyWithImpl<$Res, _$PolisInfoImpl>
    implements _$$PolisInfoImplCopyWith<$Res> {
  __$$PolisInfoImplCopyWithImpl(
    _$PolisInfoImpl _value,
    $Res Function(_$PolisInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PolisInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? norms = freezed,
    Object? threshold = freezed,
    Object? parentRepo = freezed,
  }) {
    return _then(
      _$PolisInfoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        norms: freezed == norms
            ? _value.norms
            : norms // ignore: cast_nullable_to_non_nullable
                  as String?,
        threshold: freezed == threshold
            ? _value.threshold
            : threshold // ignore: cast_nullable_to_non_nullable
                  as int?,
        parentRepo: freezed == parentRepo
            ? _value.parentRepo
            : parentRepo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PolisInfoImpl implements _PolisInfo {
  const _$PolisInfoImpl({
    required this.name,
    this.description,
    this.norms,
    this.threshold,
    this.parentRepo,
  });

  factory _$PolisInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolisInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final String? norms;
  @override
  final int? threshold;
  @override
  final String? parentRepo;

  @override
  String toString() {
    return 'PolisInfo(name: $name, description: $description, norms: $norms, threshold: $threshold, parentRepo: $parentRepo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolisInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.norms, norms) || other.norms == norms) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold) &&
            (identical(other.parentRepo, parentRepo) ||
                other.parentRepo == parentRepo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, norms, threshold, parentRepo);

  /// Create a copy of PolisInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PolisInfoImplCopyWith<_$PolisInfoImpl> get copyWith =>
      __$$PolisInfoImplCopyWithImpl<_$PolisInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolisInfoImplToJson(this);
  }
}

abstract class _PolisInfo implements PolisInfo {
  const factory _PolisInfo({
    required final String name,
    final String? description,
    final String? norms,
    final int? threshold,
    final String? parentRepo,
  }) = _$PolisInfoImpl;

  factory _PolisInfo.fromJson(Map<String, dynamic> json) =
      _$PolisInfoImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  String? get norms;
  @override
  int? get threshold;
  @override
  String? get parentRepo;

  /// Create a copy of PolisInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PolisInfoImplCopyWith<_$PolisInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
