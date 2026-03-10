// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agora_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AgoraState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<PostReference> get posts => throw _privateConstructorUsedError;
  Map<String, int> get flagCounts => throw _privateConstructorUsedError;
  int get flagThreshold => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  /// Create a copy of AgoraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgoraStateCopyWith<AgoraState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgoraStateCopyWith<$Res> {
  factory $AgoraStateCopyWith(
    AgoraState value,
    $Res Function(AgoraState) then,
  ) = _$AgoraStateCopyWithImpl<$Res, AgoraState>;
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<PostReference> posts,
    Map<String, int> flagCounts,
    int flagThreshold,
    bool hasMore,
    int offset,
  });
}

/// @nodoc
class _$AgoraStateCopyWithImpl<$Res, $Val extends AgoraState>
    implements $AgoraStateCopyWith<$Res> {
  _$AgoraStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgoraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? posts = null,
    Object? flagCounts = null,
    Object? flagThreshold = null,
    Object? hasMore = null,
    Object? offset = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UiFlowStatus,
            error: freezed == error ? _value.error : error,
            posts: null == posts
                ? _value.posts
                : posts // ignore: cast_nullable_to_non_nullable
                      as List<PostReference>,
            flagCounts: null == flagCounts
                ? _value.flagCounts
                : flagCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            flagThreshold: null == flagThreshold
                ? _value.flagThreshold
                : flagThreshold // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgoraStateImplCopyWith<$Res>
    implements $AgoraStateCopyWith<$Res> {
  factory _$$AgoraStateImplCopyWith(
    _$AgoraStateImpl value,
    $Res Function(_$AgoraStateImpl) then,
  ) = __$$AgoraStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<PostReference> posts,
    Map<String, int> flagCounts,
    int flagThreshold,
    bool hasMore,
    int offset,
  });
}

/// @nodoc
class __$$AgoraStateImplCopyWithImpl<$Res>
    extends _$AgoraStateCopyWithImpl<$Res, _$AgoraStateImpl>
    implements _$$AgoraStateImplCopyWith<$Res> {
  __$$AgoraStateImplCopyWithImpl(
    _$AgoraStateImpl _value,
    $Res Function(_$AgoraStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgoraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? posts = null,
    Object? flagCounts = null,
    Object? flagThreshold = null,
    Object? hasMore = null,
    Object? offset = null,
  }) {
    return _then(
      _$AgoraStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        posts: null == posts
            ? _value._posts
            : posts // ignore: cast_nullable_to_non_nullable
                  as List<PostReference>,
        flagCounts: null == flagCounts
            ? _value._flagCounts
            : flagCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        flagThreshold: null == flagThreshold
            ? _value.flagThreshold
            : flagThreshold // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$AgoraStateImpl extends _AgoraState {
  const _$AgoraStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    final List<PostReference> posts = const [],
    final Map<String, int> flagCounts = const {},
    this.flagThreshold = 1,
    this.hasMore = false,
    this.offset = 0,
  }) : _posts = posts,
       _flagCounts = flagCounts,
       super._();

  @override
  @JsonKey()
  final UiFlowStatus status;
  @override
  final Object? error;
  final List<PostReference> _posts;
  @override
  @JsonKey()
  List<PostReference> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  final Map<String, int> _flagCounts;
  @override
  @JsonKey()
  Map<String, int> get flagCounts {
    if (_flagCounts is EqualUnmodifiableMapView) return _flagCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_flagCounts);
  }

  @override
  @JsonKey()
  final int flagThreshold;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'AgoraState(status: $status, error: $error, posts: $posts, flagCounts: $flagCounts, flagThreshold: $flagThreshold, hasMore: $hasMore, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgoraStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality().equals(
              other._flagCounts,
              _flagCounts,
            ) &&
            (identical(other.flagThreshold, flagThreshold) ||
                other.flagThreshold == flagThreshold) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    const DeepCollectionEquality().hash(_posts),
    const DeepCollectionEquality().hash(_flagCounts),
    flagThreshold,
    hasMore,
    offset,
  );

  /// Create a copy of AgoraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgoraStateImplCopyWith<_$AgoraStateImpl> get copyWith =>
      __$$AgoraStateImplCopyWithImpl<_$AgoraStateImpl>(this, _$identity);
}

abstract class _AgoraState extends AgoraState {
  const factory _AgoraState({
    final UiFlowStatus status,
    final Object? error,
    final List<PostReference> posts,
    final Map<String, int> flagCounts,
    final int flagThreshold,
    final bool hasMore,
    final int offset,
  }) = _$AgoraStateImpl;
  const _AgoraState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  List<PostReference> get posts;
  @override
  Map<String, int> get flagCounts;
  @override
  int get flagThreshold;
  @override
  bool get hasMore;
  @override
  int get offset;

  /// Create a copy of AgoraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgoraStateImplCopyWith<_$AgoraStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
