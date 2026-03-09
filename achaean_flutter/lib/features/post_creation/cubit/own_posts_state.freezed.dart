// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'own_posts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OwnPostsState {
  UiFlowStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  List<Post> get posts => throw _privateConstructorUsedError;

  /// Create a copy of OwnPostsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OwnPostsStateCopyWith<OwnPostsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnPostsStateCopyWith<$Res> {
  factory $OwnPostsStateCopyWith(
    OwnPostsState value,
    $Res Function(OwnPostsState) then,
  ) = _$OwnPostsStateCopyWithImpl<$Res, OwnPostsState>;
  @useResult
  $Res call({UiFlowStatus status, Object? error, List<Post> posts});
}

/// @nodoc
class _$OwnPostsStateCopyWithImpl<$Res, $Val extends OwnPostsState>
    implements $OwnPostsStateCopyWith<$Res> {
  _$OwnPostsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OwnPostsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? posts = null,
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
                      as List<Post>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OwnPostsStateImplCopyWith<$Res>
    implements $OwnPostsStateCopyWith<$Res> {
  factory _$$OwnPostsStateImplCopyWith(
    _$OwnPostsStateImpl value,
    $Res Function(_$OwnPostsStateImpl) then,
  ) = __$$OwnPostsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UiFlowStatus status, Object? error, List<Post> posts});
}

/// @nodoc
class __$$OwnPostsStateImplCopyWithImpl<$Res>
    extends _$OwnPostsStateCopyWithImpl<$Res, _$OwnPostsStateImpl>
    implements _$$OwnPostsStateImplCopyWith<$Res> {
  __$$OwnPostsStateImplCopyWithImpl(
    _$OwnPostsStateImpl _value,
    $Res Function(_$OwnPostsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnPostsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? posts = null,
  }) {
    return _then(
      _$OwnPostsStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UiFlowStatus,
        error: freezed == error ? _value.error : error,
        posts: null == posts
            ? _value._posts
            : posts // ignore: cast_nullable_to_non_nullable
                  as List<Post>,
      ),
    );
  }
}

/// @nodoc

class _$OwnPostsStateImpl extends _OwnPostsState {
  const _$OwnPostsStateImpl({
    this.status = UiFlowStatus.idle,
    this.error,
    final List<Post> posts = const [],
  }) : _posts = posts,
       super._();

  @override
  @JsonKey()
  final UiFlowStatus status;
  @override
  final Object? error;
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
    return 'OwnPostsState(status: $status, error: $error, posts: $posts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnPostsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(error),
    const DeepCollectionEquality().hash(_posts),
  );

  /// Create a copy of OwnPostsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnPostsStateImplCopyWith<_$OwnPostsStateImpl> get copyWith =>
      __$$OwnPostsStateImplCopyWithImpl<_$OwnPostsStateImpl>(this, _$identity);
}

abstract class _OwnPostsState extends OwnPostsState {
  const factory _OwnPostsState({
    final UiFlowStatus status,
    final Object? error,
    final List<Post> posts,
  }) = _$OwnPostsStateImpl;
  const _OwnPostsState._() : super._();

  @override
  UiFlowStatus get status;
  @override
  Object? get error;
  @override
  List<Post> get posts;

  /// Create a copy of OwnPostsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OwnPostsStateImplCopyWith<_$OwnPostsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
