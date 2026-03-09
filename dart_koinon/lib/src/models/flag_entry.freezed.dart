// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flag_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FlagEntry _$FlagEntryFromJson(Map<String, dynamic> json) {
  return _FlagEntry.fromJson(json);
}

/// @nodoc
mixin _$FlagEntry {
  /// Path to the flagged post.
  String get post => throw _privateConstructorUsedError;

  /// Polis repo URL where this flag applies.
  String get polis => throw _privateConstructorUsedError;

  /// Free-form reason for flagging.
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this FlagEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlagEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlagEntryCopyWith<FlagEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlagEntryCopyWith<$Res> {
  factory $FlagEntryCopyWith(FlagEntry value, $Res Function(FlagEntry) then) =
      _$FlagEntryCopyWithImpl<$Res, FlagEntry>;
  @useResult
  $Res call({String post, String polis, String reason});
}

/// @nodoc
class _$FlagEntryCopyWithImpl<$Res, $Val extends FlagEntry>
    implements $FlagEntryCopyWith<$Res> {
  _$FlagEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlagEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
    Object? polis = null,
    Object? reason = null,
  }) {
    return _then(
      _value.copyWith(
            post: null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                      as String,
            polis: null == polis
                ? _value.polis
                : polis // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlagEntryImplCopyWith<$Res>
    implements $FlagEntryCopyWith<$Res> {
  factory _$$FlagEntryImplCopyWith(
    _$FlagEntryImpl value,
    $Res Function(_$FlagEntryImpl) then,
  ) = __$$FlagEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String post, String polis, String reason});
}

/// @nodoc
class __$$FlagEntryImplCopyWithImpl<$Res>
    extends _$FlagEntryCopyWithImpl<$Res, _$FlagEntryImpl>
    implements _$$FlagEntryImplCopyWith<$Res> {
  __$$FlagEntryImplCopyWithImpl(
    _$FlagEntryImpl _value,
    $Res Function(_$FlagEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlagEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
    Object? polis = null,
    Object? reason = null,
  }) {
    return _then(
      _$FlagEntryImpl(
        post: null == post
            ? _value.post
            : post // ignore: cast_nullable_to_non_nullable
                  as String,
        polis: null == polis
            ? _value.polis
            : polis // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlagEntryImpl implements _FlagEntry {
  const _$FlagEntryImpl({
    required this.post,
    required this.polis,
    required this.reason,
  });

  factory _$FlagEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlagEntryImplFromJson(json);

  /// Path to the flagged post.
  @override
  final String post;

  /// Polis repo URL where this flag applies.
  @override
  final String polis;

  /// Free-form reason for flagging.
  @override
  final String reason;

  @override
  String toString() {
    return 'FlagEntry(post: $post, polis: $polis, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlagEntryImpl &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.polis, polis) || other.polis == polis) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, post, polis, reason);

  /// Create a copy of FlagEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlagEntryImplCopyWith<_$FlagEntryImpl> get copyWith =>
      __$$FlagEntryImplCopyWithImpl<_$FlagEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlagEntryImplToJson(this);
  }
}

abstract class _FlagEntry implements FlagEntry {
  const factory _FlagEntry({
    required final String post,
    required final String polis,
    required final String reason,
  }) = _$FlagEntryImpl;

  factory _FlagEntry.fromJson(Map<String, dynamic> json) =
      _$FlagEntryImpl.fromJson;

  /// Path to the flagged post.
  @override
  String get post;

  /// Polis repo URL where this flag applies.
  @override
  String get polis;

  /// Free-form reason for flagging.
  @override
  String get reason;

  /// Create a copy of FlagEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlagEntryImplCopyWith<_$FlagEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
