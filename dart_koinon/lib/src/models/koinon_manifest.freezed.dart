// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'koinon_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KoinonManifest {

/// Always "koinon".
 String get protocol;/// Protocol version.
 String get version;/// The polites's public key.
 String get pubkey;/// Radicle repo identifier (optional).
@JsonKey(name: 'repo_radicle') String? get repoRadicle;/// HTTPS repo URL.
@JsonKey(name: 'repo_https') String get repoHttps;/// Poleis the user belongs to.
 List<PolisMembership> get poleis;/// Inline trust declarations.
 List<TrustEntry> get trust;/// Inline observe declarations (non-structural, personal feed only).
 List<ObserveEntry> get observe;/// Post flags.
 List<FlagEntry> get flags;
/// Create a copy of KoinonManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KoinonManifestCopyWith<KoinonManifest> get copyWith => _$KoinonManifestCopyWithImpl<KoinonManifest>(this as KoinonManifest, _$identity);

  /// Serializes this KoinonManifest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KoinonManifest&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.version, version) || other.version == version)&&(identical(other.pubkey, pubkey) || other.pubkey == pubkey)&&(identical(other.repoRadicle, repoRadicle) || other.repoRadicle == repoRadicle)&&(identical(other.repoHttps, repoHttps) || other.repoHttps == repoHttps)&&const DeepCollectionEquality().equals(other.poleis, poleis)&&const DeepCollectionEquality().equals(other.trust, trust)&&const DeepCollectionEquality().equals(other.observe, observe)&&const DeepCollectionEquality().equals(other.flags, flags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,protocol,version,pubkey,repoRadicle,repoHttps,const DeepCollectionEquality().hash(poleis),const DeepCollectionEquality().hash(trust),const DeepCollectionEquality().hash(observe),const DeepCollectionEquality().hash(flags));

@override
String toString() {
  return 'KoinonManifest(protocol: $protocol, version: $version, pubkey: $pubkey, repoRadicle: $repoRadicle, repoHttps: $repoHttps, poleis: $poleis, trust: $trust, observe: $observe, flags: $flags)';
}


}

/// @nodoc
abstract mixin class $KoinonManifestCopyWith<$Res>  {
  factory $KoinonManifestCopyWith(KoinonManifest value, $Res Function(KoinonManifest) _then) = _$KoinonManifestCopyWithImpl;
@useResult
$Res call({
 String protocol, String version, String pubkey,@JsonKey(name: 'repo_radicle') String? repoRadicle,@JsonKey(name: 'repo_https') String repoHttps, List<PolisMembership> poleis, List<TrustEntry> trust, List<ObserveEntry> observe, List<FlagEntry> flags
});




}
/// @nodoc
class _$KoinonManifestCopyWithImpl<$Res>
    implements $KoinonManifestCopyWith<$Res> {
  _$KoinonManifestCopyWithImpl(this._self, this._then);

  final KoinonManifest _self;
  final $Res Function(KoinonManifest) _then;

/// Create a copy of KoinonManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? protocol = null,Object? version = null,Object? pubkey = null,Object? repoRadicle = freezed,Object? repoHttps = null,Object? poleis = null,Object? trust = null,Object? observe = null,Object? flags = null,}) {
  return _then(_self.copyWith(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,pubkey: null == pubkey ? _self.pubkey : pubkey // ignore: cast_nullable_to_non_nullable
as String,repoRadicle: freezed == repoRadicle ? _self.repoRadicle : repoRadicle // ignore: cast_nullable_to_non_nullable
as String?,repoHttps: null == repoHttps ? _self.repoHttps : repoHttps // ignore: cast_nullable_to_non_nullable
as String,poleis: null == poleis ? _self.poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<PolisMembership>,trust: null == trust ? _self.trust : trust // ignore: cast_nullable_to_non_nullable
as List<TrustEntry>,observe: null == observe ? _self.observe : observe // ignore: cast_nullable_to_non_nullable
as List<ObserveEntry>,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<FlagEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [KoinonManifest].
extension KoinonManifestPatterns on KoinonManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KoinonManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KoinonManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KoinonManifest value)  $default,){
final _that = this;
switch (_that) {
case _KoinonManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KoinonManifest value)?  $default,){
final _that = this;
switch (_that) {
case _KoinonManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String protocol,  String version,  String pubkey, @JsonKey(name: 'repo_radicle')  String? repoRadicle, @JsonKey(name: 'repo_https')  String repoHttps,  List<PolisMembership> poleis,  List<TrustEntry> trust,  List<ObserveEntry> observe,  List<FlagEntry> flags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KoinonManifest() when $default != null:
return $default(_that.protocol,_that.version,_that.pubkey,_that.repoRadicle,_that.repoHttps,_that.poleis,_that.trust,_that.observe,_that.flags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String protocol,  String version,  String pubkey, @JsonKey(name: 'repo_radicle')  String? repoRadicle, @JsonKey(name: 'repo_https')  String repoHttps,  List<PolisMembership> poleis,  List<TrustEntry> trust,  List<ObserveEntry> observe,  List<FlagEntry> flags)  $default,) {final _that = this;
switch (_that) {
case _KoinonManifest():
return $default(_that.protocol,_that.version,_that.pubkey,_that.repoRadicle,_that.repoHttps,_that.poleis,_that.trust,_that.observe,_that.flags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String protocol,  String version,  String pubkey, @JsonKey(name: 'repo_radicle')  String? repoRadicle, @JsonKey(name: 'repo_https')  String repoHttps,  List<PolisMembership> poleis,  List<TrustEntry> trust,  List<ObserveEntry> observe,  List<FlagEntry> flags)?  $default,) {final _that = this;
switch (_that) {
case _KoinonManifest() when $default != null:
return $default(_that.protocol,_that.version,_that.pubkey,_that.repoRadicle,_that.repoHttps,_that.poleis,_that.trust,_that.observe,_that.flags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KoinonManifest implements KoinonManifest {
  const _KoinonManifest({this.protocol = 'koinon', this.version = '1.0', required this.pubkey, @JsonKey(name: 'repo_radicle') this.repoRadicle, @JsonKey(name: 'repo_https') required this.repoHttps, final  List<PolisMembership> poleis = const [], final  List<TrustEntry> trust = const [], final  List<ObserveEntry> observe = const [], final  List<FlagEntry> flags = const []}): _poleis = poleis,_trust = trust,_observe = observe,_flags = flags;
  factory _KoinonManifest.fromJson(Map<String, dynamic> json) => _$KoinonManifestFromJson(json);

/// Always "koinon".
@override@JsonKey() final  String protocol;
/// Protocol version.
@override@JsonKey() final  String version;
/// The polites's public key.
@override final  String pubkey;
/// Radicle repo identifier (optional).
@override@JsonKey(name: 'repo_radicle') final  String? repoRadicle;
/// HTTPS repo URL.
@override@JsonKey(name: 'repo_https') final  String repoHttps;
/// Poleis the user belongs to.
 final  List<PolisMembership> _poleis;
/// Poleis the user belongs to.
@override@JsonKey() List<PolisMembership> get poleis {
  if (_poleis is EqualUnmodifiableListView) return _poleis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_poleis);
}

/// Inline trust declarations.
 final  List<TrustEntry> _trust;
/// Inline trust declarations.
@override@JsonKey() List<TrustEntry> get trust {
  if (_trust is EqualUnmodifiableListView) return _trust;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trust);
}

/// Inline observe declarations (non-structural, personal feed only).
 final  List<ObserveEntry> _observe;
/// Inline observe declarations (non-structural, personal feed only).
@override@JsonKey() List<ObserveEntry> get observe {
  if (_observe is EqualUnmodifiableListView) return _observe;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observe);
}

/// Post flags.
 final  List<FlagEntry> _flags;
/// Post flags.
@override@JsonKey() List<FlagEntry> get flags {
  if (_flags is EqualUnmodifiableListView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flags);
}


/// Create a copy of KoinonManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KoinonManifestCopyWith<_KoinonManifest> get copyWith => __$KoinonManifestCopyWithImpl<_KoinonManifest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KoinonManifestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KoinonManifest&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.version, version) || other.version == version)&&(identical(other.pubkey, pubkey) || other.pubkey == pubkey)&&(identical(other.repoRadicle, repoRadicle) || other.repoRadicle == repoRadicle)&&(identical(other.repoHttps, repoHttps) || other.repoHttps == repoHttps)&&const DeepCollectionEquality().equals(other._poleis, _poleis)&&const DeepCollectionEquality().equals(other._trust, _trust)&&const DeepCollectionEquality().equals(other._observe, _observe)&&const DeepCollectionEquality().equals(other._flags, _flags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,protocol,version,pubkey,repoRadicle,repoHttps,const DeepCollectionEquality().hash(_poleis),const DeepCollectionEquality().hash(_trust),const DeepCollectionEquality().hash(_observe),const DeepCollectionEquality().hash(_flags));

@override
String toString() {
  return 'KoinonManifest(protocol: $protocol, version: $version, pubkey: $pubkey, repoRadicle: $repoRadicle, repoHttps: $repoHttps, poleis: $poleis, trust: $trust, observe: $observe, flags: $flags)';
}


}

/// @nodoc
abstract mixin class _$KoinonManifestCopyWith<$Res> implements $KoinonManifestCopyWith<$Res> {
  factory _$KoinonManifestCopyWith(_KoinonManifest value, $Res Function(_KoinonManifest) _then) = __$KoinonManifestCopyWithImpl;
@override @useResult
$Res call({
 String protocol, String version, String pubkey,@JsonKey(name: 'repo_radicle') String? repoRadicle,@JsonKey(name: 'repo_https') String repoHttps, List<PolisMembership> poleis, List<TrustEntry> trust, List<ObserveEntry> observe, List<FlagEntry> flags
});




}
/// @nodoc
class __$KoinonManifestCopyWithImpl<$Res>
    implements _$KoinonManifestCopyWith<$Res> {
  __$KoinonManifestCopyWithImpl(this._self, this._then);

  final _KoinonManifest _self;
  final $Res Function(_KoinonManifest) _then;

/// Create a copy of KoinonManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? protocol = null,Object? version = null,Object? pubkey = null,Object? repoRadicle = freezed,Object? repoHttps = null,Object? poleis = null,Object? trust = null,Object? observe = null,Object? flags = null,}) {
  return _then(_KoinonManifest(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,pubkey: null == pubkey ? _self.pubkey : pubkey // ignore: cast_nullable_to_non_nullable
as String,repoRadicle: freezed == repoRadicle ? _self.repoRadicle : repoRadicle // ignore: cast_nullable_to_non_nullable
as String?,repoHttps: null == repoHttps ? _self.repoHttps : repoHttps // ignore: cast_nullable_to_non_nullable
as String,poleis: null == poleis ? _self._poleis : poleis // ignore: cast_nullable_to_non_nullable
as List<PolisMembership>,trust: null == trust ? _self._trust : trust // ignore: cast_nullable_to_non_nullable
as List<TrustEntry>,observe: null == observe ? _self._observe : observe // ignore: cast_nullable_to_non_nullable
as List<ObserveEntry>,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<FlagEntry>,
  ));
}


}

// dart format on
