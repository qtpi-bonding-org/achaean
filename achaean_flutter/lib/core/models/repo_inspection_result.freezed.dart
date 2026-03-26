// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_inspection_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RepoInspectionResult {

 KoinonManifest? get manifest; List<TrustDeclaration> get trustDeclarations; List<ReadmeSignature> get readmeSignatures; List<Post> get posts;
/// Create a copy of RepoInspectionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepoInspectionResultCopyWith<RepoInspectionResult> get copyWith => _$RepoInspectionResultCopyWithImpl<RepoInspectionResult>(this as RepoInspectionResult, _$identity);

  /// Serializes this RepoInspectionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepoInspectionResult&&(identical(other.manifest, manifest) || other.manifest == manifest)&&const DeepCollectionEquality().equals(other.trustDeclarations, trustDeclarations)&&const DeepCollectionEquality().equals(other.readmeSignatures, readmeSignatures)&&const DeepCollectionEquality().equals(other.posts, posts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,manifest,const DeepCollectionEquality().hash(trustDeclarations),const DeepCollectionEquality().hash(readmeSignatures),const DeepCollectionEquality().hash(posts));

@override
String toString() {
  return 'RepoInspectionResult(manifest: $manifest, trustDeclarations: $trustDeclarations, readmeSignatures: $readmeSignatures, posts: $posts)';
}


}

/// @nodoc
abstract mixin class $RepoInspectionResultCopyWith<$Res>  {
  factory $RepoInspectionResultCopyWith(RepoInspectionResult value, $Res Function(RepoInspectionResult) _then) = _$RepoInspectionResultCopyWithImpl;
@useResult
$Res call({
 KoinonManifest? manifest, List<TrustDeclaration> trustDeclarations, List<ReadmeSignature> readmeSignatures, List<Post> posts
});


$KoinonManifestCopyWith<$Res>? get manifest;

}
/// @nodoc
class _$RepoInspectionResultCopyWithImpl<$Res>
    implements $RepoInspectionResultCopyWith<$Res> {
  _$RepoInspectionResultCopyWithImpl(this._self, this._then);

  final RepoInspectionResult _self;
  final $Res Function(RepoInspectionResult) _then;

/// Create a copy of RepoInspectionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? manifest = freezed,Object? trustDeclarations = null,Object? readmeSignatures = null,Object? posts = null,}) {
  return _then(_self.copyWith(
manifest: freezed == manifest ? _self.manifest : manifest // ignore: cast_nullable_to_non_nullable
as KoinonManifest?,trustDeclarations: null == trustDeclarations ? _self.trustDeclarations : trustDeclarations // ignore: cast_nullable_to_non_nullable
as List<TrustDeclaration>,readmeSignatures: null == readmeSignatures ? _self.readmeSignatures : readmeSignatures // ignore: cast_nullable_to_non_nullable
as List<ReadmeSignature>,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}
/// Create a copy of RepoInspectionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KoinonManifestCopyWith<$Res>? get manifest {
    if (_self.manifest == null) {
    return null;
  }

  return $KoinonManifestCopyWith<$Res>(_self.manifest!, (value) {
    return _then(_self.copyWith(manifest: value));
  });
}
}


/// Adds pattern-matching-related methods to [RepoInspectionResult].
extension RepoInspectionResultPatterns on RepoInspectionResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepoInspectionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepoInspectionResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepoInspectionResult value)  $default,){
final _that = this;
switch (_that) {
case _RepoInspectionResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepoInspectionResult value)?  $default,){
final _that = this;
switch (_that) {
case _RepoInspectionResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KoinonManifest? manifest,  List<TrustDeclaration> trustDeclarations,  List<ReadmeSignature> readmeSignatures,  List<Post> posts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepoInspectionResult() when $default != null:
return $default(_that.manifest,_that.trustDeclarations,_that.readmeSignatures,_that.posts);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KoinonManifest? manifest,  List<TrustDeclaration> trustDeclarations,  List<ReadmeSignature> readmeSignatures,  List<Post> posts)  $default,) {final _that = this;
switch (_that) {
case _RepoInspectionResult():
return $default(_that.manifest,_that.trustDeclarations,_that.readmeSignatures,_that.posts);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KoinonManifest? manifest,  List<TrustDeclaration> trustDeclarations,  List<ReadmeSignature> readmeSignatures,  List<Post> posts)?  $default,) {final _that = this;
switch (_that) {
case _RepoInspectionResult() when $default != null:
return $default(_that.manifest,_that.trustDeclarations,_that.readmeSignatures,_that.posts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RepoInspectionResult implements RepoInspectionResult {
  const _RepoInspectionResult({this.manifest, final  List<TrustDeclaration> trustDeclarations = const [], final  List<ReadmeSignature> readmeSignatures = const [], final  List<Post> posts = const []}): _trustDeclarations = trustDeclarations,_readmeSignatures = readmeSignatures,_posts = posts;
  factory _RepoInspectionResult.fromJson(Map<String, dynamic> json) => _$RepoInspectionResultFromJson(json);

@override final  KoinonManifest? manifest;
 final  List<TrustDeclaration> _trustDeclarations;
@override@JsonKey() List<TrustDeclaration> get trustDeclarations {
  if (_trustDeclarations is EqualUnmodifiableListView) return _trustDeclarations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trustDeclarations);
}

 final  List<ReadmeSignature> _readmeSignatures;
@override@JsonKey() List<ReadmeSignature> get readmeSignatures {
  if (_readmeSignatures is EqualUnmodifiableListView) return _readmeSignatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readmeSignatures);
}

 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of RepoInspectionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepoInspectionResultCopyWith<_RepoInspectionResult> get copyWith => __$RepoInspectionResultCopyWithImpl<_RepoInspectionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepoInspectionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepoInspectionResult&&(identical(other.manifest, manifest) || other.manifest == manifest)&&const DeepCollectionEquality().equals(other._trustDeclarations, _trustDeclarations)&&const DeepCollectionEquality().equals(other._readmeSignatures, _readmeSignatures)&&const DeepCollectionEquality().equals(other._posts, _posts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,manifest,const DeepCollectionEquality().hash(_trustDeclarations),const DeepCollectionEquality().hash(_readmeSignatures),const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'RepoInspectionResult(manifest: $manifest, trustDeclarations: $trustDeclarations, readmeSignatures: $readmeSignatures, posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$RepoInspectionResultCopyWith<$Res> implements $RepoInspectionResultCopyWith<$Res> {
  factory _$RepoInspectionResultCopyWith(_RepoInspectionResult value, $Res Function(_RepoInspectionResult) _then) = __$RepoInspectionResultCopyWithImpl;
@override @useResult
$Res call({
 KoinonManifest? manifest, List<TrustDeclaration> trustDeclarations, List<ReadmeSignature> readmeSignatures, List<Post> posts
});


@override $KoinonManifestCopyWith<$Res>? get manifest;

}
/// @nodoc
class __$RepoInspectionResultCopyWithImpl<$Res>
    implements _$RepoInspectionResultCopyWith<$Res> {
  __$RepoInspectionResultCopyWithImpl(this._self, this._then);

  final _RepoInspectionResult _self;
  final $Res Function(_RepoInspectionResult) _then;

/// Create a copy of RepoInspectionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? manifest = freezed,Object? trustDeclarations = null,Object? readmeSignatures = null,Object? posts = null,}) {
  return _then(_RepoInspectionResult(
manifest: freezed == manifest ? _self.manifest : manifest // ignore: cast_nullable_to_non_nullable
as KoinonManifest?,trustDeclarations: null == trustDeclarations ? _self._trustDeclarations : trustDeclarations // ignore: cast_nullable_to_non_nullable
as List<TrustDeclaration>,readmeSignatures: null == readmeSignatures ? _self._readmeSignatures : readmeSignatures // ignore: cast_nullable_to_non_nullable
as List<ReadmeSignature>,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}

/// Create a copy of RepoInspectionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KoinonManifestCopyWith<$Res>? get manifest {
    if (_self.manifest == null) {
    return null;
  }

  return $KoinonManifestCopyWith<$Res>(_self.manifest!, (value) {
    return _then(_self.copyWith(manifest: value));
  });
}
}

// dart format on
