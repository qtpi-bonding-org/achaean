// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrustDeclaration {

/// Always "trust-declaration".
 String get type;/// Subject's public key.
 String get subject;/// Subject's repo URL (enables trust graph traversal).
 String get repo;/// Trust level: TRUST or PROVISIONAL.
 TrustLevel get level;/// When the declaration was made.
 DateTime get timestamp;/// Author's Web Crypto signature.
 String get signature;
/// Create a copy of TrustDeclaration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrustDeclarationCopyWith<TrustDeclaration> get copyWith => _$TrustDeclarationCopyWithImpl<TrustDeclaration>(this as TrustDeclaration, _$identity);

  /// Serializes this TrustDeclaration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrustDeclaration&&(identical(other.type, type) || other.type == type)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.level, level) || other.level == level)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,subject,repo,level,timestamp,signature);

@override
String toString() {
  return 'TrustDeclaration(type: $type, subject: $subject, repo: $repo, level: $level, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class $TrustDeclarationCopyWith<$Res>  {
  factory $TrustDeclarationCopyWith(TrustDeclaration value, $Res Function(TrustDeclaration) _then) = _$TrustDeclarationCopyWithImpl;
@useResult
$Res call({
 String type, String subject, String repo, TrustLevel level, DateTime timestamp, String signature
});




}
/// @nodoc
class _$TrustDeclarationCopyWithImpl<$Res>
    implements $TrustDeclarationCopyWith<$Res> {
  _$TrustDeclarationCopyWithImpl(this._self, this._then);

  final TrustDeclaration _self;
  final $Res Function(TrustDeclaration) _then;

/// Create a copy of TrustDeclaration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? subject = null,Object? repo = null,Object? level = null,Object? timestamp = null,Object? signature = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as TrustLevel,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TrustDeclaration].
extension TrustDeclarationPatterns on TrustDeclaration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrustDeclaration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrustDeclaration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrustDeclaration value)  $default,){
final _that = this;
switch (_that) {
case _TrustDeclaration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrustDeclaration value)?  $default,){
final _that = this;
switch (_that) {
case _TrustDeclaration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String subject,  String repo,  TrustLevel level,  DateTime timestamp,  String signature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrustDeclaration() when $default != null:
return $default(_that.type,_that.subject,_that.repo,_that.level,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String subject,  String repo,  TrustLevel level,  DateTime timestamp,  String signature)  $default,) {final _that = this;
switch (_that) {
case _TrustDeclaration():
return $default(_that.type,_that.subject,_that.repo,_that.level,_that.timestamp,_that.signature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String subject,  String repo,  TrustLevel level,  DateTime timestamp,  String signature)?  $default,) {final _that = this;
switch (_that) {
case _TrustDeclaration() when $default != null:
return $default(_that.type,_that.subject,_that.repo,_that.level,_that.timestamp,_that.signature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrustDeclaration implements TrustDeclaration {
  const _TrustDeclaration({this.type = 'trust-declaration', required this.subject, required this.repo, required this.level, required this.timestamp, required this.signature});
  factory _TrustDeclaration.fromJson(Map<String, dynamic> json) => _$TrustDeclarationFromJson(json);

/// Always "trust-declaration".
@override@JsonKey() final  String type;
/// Subject's public key.
@override final  String subject;
/// Subject's repo URL (enables trust graph traversal).
@override final  String repo;
/// Trust level: TRUST or PROVISIONAL.
@override final  TrustLevel level;
/// When the declaration was made.
@override final  DateTime timestamp;
/// Author's Web Crypto signature.
@override final  String signature;

/// Create a copy of TrustDeclaration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrustDeclarationCopyWith<_TrustDeclaration> get copyWith => __$TrustDeclarationCopyWithImpl<_TrustDeclaration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrustDeclarationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrustDeclaration&&(identical(other.type, type) || other.type == type)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.level, level) || other.level == level)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,subject,repo,level,timestamp,signature);

@override
String toString() {
  return 'TrustDeclaration(type: $type, subject: $subject, repo: $repo, level: $level, timestamp: $timestamp, signature: $signature)';
}


}

/// @nodoc
abstract mixin class _$TrustDeclarationCopyWith<$Res> implements $TrustDeclarationCopyWith<$Res> {
  factory _$TrustDeclarationCopyWith(_TrustDeclaration value, $Res Function(_TrustDeclaration) _then) = __$TrustDeclarationCopyWithImpl;
@override @useResult
$Res call({
 String type, String subject, String repo, TrustLevel level, DateTime timestamp, String signature
});




}
/// @nodoc
class __$TrustDeclarationCopyWithImpl<$Res>
    implements _$TrustDeclarationCopyWith<$Res> {
  __$TrustDeclarationCopyWithImpl(this._self, this._then);

  final _TrustDeclaration _self;
  final $Res Function(_TrustDeclaration) _then;

/// Create a copy of TrustDeclaration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? subject = null,Object? repo = null,Object? level = null,Object? timestamp = null,Object? signature = null,}) {
  return _then(_TrustDeclaration(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as TrustLevel,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
