// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PersonalFeedState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<PostReference> get posts => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  /// Create a copy of PersonalFeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalFeedStateCopyWith<PersonalFeedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalFeedStateCopyWith<$Res> {
  factory $PersonalFeedStateCopyWith(
    PersonalFeedState value,
    $Res Function(PersonalFeedState) then,
  ) = _$PersonalFeedStateCopyWithImpl<$Res, PersonalFeedState>;
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<PostReference> posts,
    bool hasMore,
    int offset,
  });
}

/// @nodoc
class _$PersonalFeedStateCopyWithImpl<$Res, $Val extends PersonalFeedState>
    implements $PersonalFeedStateCopyWith<$Res> {
  _$PersonalFeedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalFeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? posts = null,
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
abstract class _$$PersonalFeedStateImplCopyWith<$Res>
    implements $PersonalFeedStateCopyWith<$Res> {
  factory _$$PersonalFeedStateImplCopyWith(
    _$PersonalFeedStateImpl value,
    $Res Function(_$PersonalFeedStateImpl) then,
  ) = __$$PersonalFeedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UiFlowStatus status,
    Object? error,
    List<PostReference> posts,
    bool hasMore,
    int offset,
  });
}

/// @nodoc
class __$$PersonalFeedStateImplCopyWithImpl<$Res>
    extends _$PersonalFeedStateCopyWithImpl<$Res, _$PersonalFeedStateImpl>
    implements _$$PersonalFeedStateImplCopyWith<$Res> {
  __$$PersonalFeedStateImplCopyWithImpl(
    _$PersonalFeedStateImpl _value,
    $Res Function(_$PersonalFeedStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PersonalFeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? posts = null,
    Object? hasMore = null,
    Object? offset = null,
  }) {
    return _then(
      _$PersonalFeedStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        posts: null == posts
            ? _value._posts
            : posts // ignore: cast_nullable_to_non_nullable
                  as List<PostReference>,
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

class _$PersonalFeedStateImpl extends _PersonalFeedState {
  const _$PersonalFeedStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    final List<PostReference> posts = const [],
    this.hasMore = false,
    this.offset = 0,
  }) : _posts = posts,
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

  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'PersonalFeedState(status: $status, error: $error, posts: $posts, hasMore: $hasMore, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalFeedStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    const DeepCollectionEquality().hash(_posts),
    hasMore,
    offset,
  );

  /// Create a copy of PersonalFeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalFeedStateImplCopyWith<_$PersonalFeedStateImpl> get copyWith =>
      __$$PersonalFeedStateImplCopyWithImpl<_$PersonalFeedStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PersonalFeedState extends PersonalFeedState {
  const factory _PersonalFeedState({
    final UiFlowStatus status,
    final Object? error,
    final List<PostReference> posts,
    final bool hasMore,
    final int offset,
  }) = _$PersonalFeedStateImpl;
  const _PersonalFeedState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  List<PostReference> get posts;
  @override
  bool get hasMore;
  @override
  int get offset;

  /// Create a copy of PersonalFeedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalFeedStateImplCopyWith<_$PersonalFeedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
