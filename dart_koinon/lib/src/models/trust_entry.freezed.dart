// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrustEntry _$TrustEntryFromJson(Map<String, dynamic> json) {
  return _TrustEntry.fromJson(json);
}

/// @nodoc
mixin _$TrustEntry {
  /// Subject's public key.
  String get subject => throw _privateConstructorUsedError;

  /// Subject's repo URL.
  String get repo => throw _privateConstructorUsedError;

  /// Trust level.
  TrustLevel get level => throw _privateConstructorUsedError;

  /// Serializes this TrustEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrustEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrustEntryCopyWith<TrustEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustEntryCopyWith<$Res> {
  factory $TrustEntryCopyWith(
    TrustEntry value,
    $Res Function(TrustEntry) then,
  ) = _$TrustEntryCopyWithImpl<$Res, TrustEntry>;
  @useResult
  $Res call({String subject, String repo, TrustLevel level});
}

/// @nodoc
class _$TrustEntryCopyWithImpl<$Res, $Val extends TrustEntry>
    implements $TrustEntryCopyWith<$Res> {
  _$TrustEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrustEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = null,
    Object? repo = null,
    Object? level = null,
  }) {
    return _then(
      _value.copyWith(
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            repo: null == repo
                ? _value.repo
                : repo // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as TrustLevel,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrustEntryImplCopyWith<$Res>
    implements $TrustEntryCopyWith<$Res> {
  factory _$$TrustEntryImplCopyWith(
    _$TrustEntryImpl value,
    $Res Function(_$TrustEntryImpl) then,
  ) = __$$TrustEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String subject, String repo, TrustLevel level});
}

/// @nodoc
class __$$TrustEntryImplCopyWithImpl<$Res>
    extends _$TrustEntryCopyWithImpl<$Res, _$TrustEntryImpl>
    implements _$$TrustEntryImplCopyWith<$Res> {
  __$$TrustEntryImplCopyWithImpl(
    _$TrustEntryImpl _value,
    $Res Function(_$TrustEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrustEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = null,
    Object? repo = null,
    Object? level = null,
  }) {
    return _then(
      _$TrustEntryImpl(
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        repo: null == repo
            ? _value.repo
            : repo // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as TrustLevel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrustEntryImpl implements _TrustEntry {
  const _$TrustEntryImpl({
    required this.subject,
    required this.repo,
    required this.level,
  });

  factory _$TrustEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrustEntryImplFromJson(json);

  /// Subject's public key.
  @override
  final String subject;

  /// Subject's repo URL.
  @override
  final String repo;

  /// Trust level.
  @override
  final TrustLevel level;

  @override
  String toString() {
    return 'TrustEntry(subject: $subject, repo: $repo, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrustEntryImpl &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.repo, repo) || other.repo == repo) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subject, repo, level);

  /// Create a copy of TrustEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustEntryImplCopyWith<_$TrustEntryImpl> get copyWith =>
      __$$TrustEntryImplCopyWithImpl<_$TrustEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrustEntryImplToJson(this);
  }
}

abstract class _TrustEntry implements TrustEntry {
  const factory _TrustEntry({
    required final String subject,
    required final String repo,
    required final TrustLevel level,
  }) = _$TrustEntryImpl;

  factory _TrustEntry.fromJson(Map<String, dynamic> json) =
      _$TrustEntryImpl.fromJson;

  /// Subject's public key.
  @override
  String get subject;

  /// Subject's repo URL.
  @override
  String get repo;

  /// Trust level.
  @override
  TrustLevel get level;

  /// Create a copy of TrustEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrustEntryImplCopyWith<_$TrustEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
