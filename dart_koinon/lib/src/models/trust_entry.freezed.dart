// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrustEntry {

/// Subject's public key.
 String get subject;/// Subject's repo URL.
 String get repo;/// Trust level.
 TrustLevel get level;
/// Create a copy of TrustEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrustEntryCopyWith<TrustEntry> get copyWith => _$TrustEntryCopyWithImpl<TrustEntry>(this as TrustEntry, _$identity);

  /// Serializes this TrustEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrustEntry&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subject,repo,level);

@override
String toString() {
  return 'TrustEntry(subject: $subject, repo: $repo, level: $level)';
}


}

/// @nodoc
abstract mixin class $TrustEntryCopyWith<$Res>  {
  factory $TrustEntryCopyWith(TrustEntry value, $Res Function(TrustEntry) _then) = _$TrustEntryCopyWithImpl;
@useResult
$Res call({
 String subject, String repo, TrustLevel level
});




}
/// @nodoc
class _$TrustEntryCopyWithImpl<$Res>
    implements $TrustEntryCopyWith<$Res> {
  _$TrustEntryCopyWithImpl(this._self, this._then);

  final TrustEntry _self;
  final $Res Function(TrustEntry) _then;

/// Create a copy of TrustEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subject = null,Object? repo = null,Object? level = null,}) {
  return _then(_self.copyWith(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as TrustLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [TrustEntry].
extension TrustEntryPatterns on TrustEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrustEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrustEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrustEntry value)  $default,){
final _that = this;
switch (_that) {
case _TrustEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrustEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TrustEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subject,  String repo,  TrustLevel level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrustEntry() when $default != null:
return $default(_that.subject,_that.repo,_that.level);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subject,  String repo,  TrustLevel level)  $default,) {final _that = this;
switch (_that) {
case _TrustEntry():
return $default(_that.subject,_that.repo,_that.level);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subject,  String repo,  TrustLevel level)?  $default,) {final _that = this;
switch (_that) {
case _TrustEntry() when $default != null:
return $default(_that.subject,_that.repo,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrustEntry implements TrustEntry {
  const _TrustEntry({required this.subject, required this.repo, required this.level});
  factory _TrustEntry.fromJson(Map<String, dynamic> json) => _$TrustEntryFromJson(json);

/// Subject's public key.
@override final  String subject;
/// Subject's repo URL.
@override final  String repo;
/// Trust level.
@override final  TrustLevel level;

/// Create a copy of TrustEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrustEntryCopyWith<_TrustEntry> get copyWith => __$TrustEntryCopyWithImpl<_TrustEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrustEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrustEntry&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subject,repo,level);

@override
String toString() {
  return 'TrustEntry(subject: $subject, repo: $repo, level: $level)';
}


}

/// @nodoc
abstract mixin class _$TrustEntryCopyWith<$Res> implements $TrustEntryCopyWith<$Res> {
  factory _$TrustEntryCopyWith(_TrustEntry value, $Res Function(_TrustEntry) _then) = __$TrustEntryCopyWithImpl;
@override @useResult
$Res call({
 String subject, String repo, TrustLevel level
});




}
/// @nodoc
class __$TrustEntryCopyWithImpl<$Res>
    implements _$TrustEntryCopyWith<$Res> {
  __$TrustEntryCopyWithImpl(this._self, this._then);

  final _TrustEntry _self;
  final $Res Function(_TrustEntry) _then;

/// Create a copy of TrustEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subject = null,Object? repo = null,Object? level = null,}) {
  return _then(_TrustEntry(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as TrustLevel,
  ));
}


}

// dart format on
