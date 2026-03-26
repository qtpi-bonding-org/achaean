// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'readme_signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadmeSignature {

/// Always "readme-signature".
 String get type;/// The polis repo identifier.
 String get polis;/// Commit hash of the README version that was signed.
@JsonKey(name: 'readme_commit') String get readmeCommit;/// Content hash of the README.
@JsonKey(name: 'readme_hash') String get readmeHash;/// When the signature was made.
 DateTime get timestamp;/// Signer's Web Crypto signature.
 String get signature;
/// Create a copy of ReadmeSignature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadmeSignatureCopyWith<ReadmeSignature> get copyWith => _$ReadmeSignatureCopyWithImpl<ReadmeSignature>(this as ReadmeSignature, _$identity);

  /// Serializes this ReadmeSignature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadmeSignature&&(identical(other.type, type) || other.type == type)&&(identical(other.polis, polis) || other.polis == polis)&&(identical(other.readmeCommit, readmeCommit) || other.readmeCommit == readmeCommit)&&(identical(other.readmeHash, readmeHash) || other.readmeHash == readmeHash)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,polis,readmeCommit,readmeHash,timestamp,signature);

@override
String toString() {
  return 'ReadmeSignature(type: $type, polis: $polis, readmeCommit: $readmeCommit, readmeHash: $readmeHash, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class $ReadmeSignatureCopyWith<$Res>  {
  factory $ReadmeSignatureCopyWith(ReadmeSignature value, $Res Function(ReadmeSignature) _then) = _$ReadmeSignatureCopyWithImpl;
@useResult
$Res call({
 String type, String polis,@JsonKey(name: 'readme_commit') String readmeCommit,@JsonKey(name: 'readme_hash') String readmeHash, DateTime timestamp, String signature
});




}
/// @nodoc
class _$ReadmeSignatureCopyWithImpl<$Res>
    implements $ReadmeSignatureCopyWith<$Res> {
  _$ReadmeSignatureCopyWithImpl(this._self, this._then);

  final ReadmeSignature _self;
  final $Res Function(ReadmeSignature) _then;

/// Create a copy of ReadmeSignature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? polis = null,Object? readmeCommit = null,Object? readmeHash = null,Object? timestamp = null,Object? signature = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,polis: null == polis ? _self.polis : polis // ignore: cast_nullable_to_non_nullable
as String,readmeCommit: null == readmeCommit ? _self.readmeCommit : readmeCommit // ignore: cast_nullable_to_non_nullable
as String,readmeHash: null == readmeHash ? _self.readmeHash : readmeHash // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadmeSignature].
extension ReadmeSignaturePatterns on ReadmeSignature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadmeSignature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadmeSignature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadmeSignature value)  $default,){
final _that = this;
switch (_that) {
case _ReadmeSignature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadmeSignature value)?  $default,){
final _that = this;
switch (_that) {
case _ReadmeSignature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String polis, @JsonKey(name: 'readme_commit')  String readmeCommit, @JsonKey(name: 'readme_hash')  String readmeHash,  DateTime timestamp,  String signature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadmeSignature() when $default != null:
return $default(_that.type,_that.polis,_that.readmeCommit,_that.readmeHash,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String polis, @JsonKey(name: 'readme_commit')  String readmeCommit, @JsonKey(name: 'readme_hash')  String readmeHash,  DateTime timestamp,  String signature)  $default,) {final _that = this;
switch (_that) {
case _ReadmeSignature():
return $default(_that.type,_that.polis,_that.readmeCommit,_that.readmeHash,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String polis, @JsonKey(name: 'readme_commit')  String readmeCommit, @JsonKey(name: 'readme_hash')  String readmeHash,  DateTime timestamp,  String signature)?  $default,) {final _that = this;
switch (_that) {
case _ReadmeSignature() when $default != null:
return $default(_that.type,_that.polis,_that.readmeCommit,_that.readmeHash,_that.timestamp,_that.signature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadmeSignature implements ReadmeSignature {
  const _ReadmeSignature({this.type = 'readme-signature', required this.polis, @JsonKey(name: 'readme_commit') required this.readmeCommit, @JsonKey(name: 'readme_hash') required this.readmeHash, required this.timestamp, required this.signature});
  factory _ReadmeSignature.fromJson(Map<String, dynamic> json) => _$ReadmeSignatureFromJson(json);

/// Always "readme-signature".
@override@JsonKey() final  String type;
/// The polis repo identifier.
@override final  String polis;
/// Commit hash of the README version that was signed.
@override@JsonKey(name: 'readme_commit') final  String readmeCommit;
/// Content hash of the README.
@override@JsonKey(name: 'readme_hash') final  String readmeHash;
/// When the signature was made.
@override final  DateTime timestamp;
/// Signer's Web Crypto signature.
@override final  String signature;

/// Create a copy of ReadmeSignature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadmeSignatureCopyWith<_ReadmeSignature> get copyWith => __$ReadmeSignatureCopyWithImpl<_ReadmeSignature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadmeSignatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadmeSignature&&(identical(other.type, type) || other.type == type)&&(identical(other.polis, polis) || other.polis == polis)&&(identical(other.readmeCommit, readmeCommit) || other.readmeCommit == readmeCommit)&&(identical(other.readmeHash, readmeHash) || other.readmeHash == readmeHash)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,polis,readmeCommit,readmeHash,timestamp,signature);

@override
String toString() {
  return 'ReadmeSignature(type: $type, polis: $polis, readmeCommit: $readmeCommit, readmeHash: $readmeHash, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class _$ReadmeSignatureCopyWith<$Res> implements $ReadmeSignatureCopyWith<$Res> {
  factory _$ReadmeSignatureCopyWith(_ReadmeSignature value, $Res Function(_ReadmeSignature) _then) = __$ReadmeSignatureCopyWithImpl;
@override @useResult
$Res call({
 String type, String polis,@JsonKey(name: 'readme_commit') String readmeCommit,@JsonKey(name: 'readme_hash') String readmeHash, DateTime timestamp, String signature
});




}
/// @nodoc
class __$ReadmeSignatureCopyWithImpl<$Res>
    implements _$ReadmeSignatureCopyWith<$Res> {
  __$ReadmeSignatureCopyWithImpl(this._self, this._then);

  final _ReadmeSignature _self;
  final $Res Function(_ReadmeSignature) _then;

/// Create a copy of ReadmeSignature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? polis = null,Object? readmeCommit = null,Object? readmeHash = null,Object? timestamp = null,Object? signature = null,}) {
  return _then(_ReadmeSignature(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,polis: null == polis ? _self.polis : polis // ignore: cast_nullable_to_non_nullable
as String,readmeCommit: null == readmeCommit ? _self.readmeCommit : readmeCommit // ignore: cast_nullable_to_non_nullable
as String,readmeHash: null == readmeHash ? _self.readmeHash : readmeHash // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
