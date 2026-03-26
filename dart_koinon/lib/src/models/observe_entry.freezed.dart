// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observe_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ObserveEntry {

/// Subject's public key.
 String get subject;/// Subject's repo URL.
 String get repo;
/// Create a copy of ObserveEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObserveEntryCopyWith<ObserveEntry> get copyWith => _$ObserveEntryCopyWithImpl<ObserveEntry>(this as ObserveEntry, _$identity);

  /// Serializes this ObserveEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObserveEntry&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.repo, repo) || other.repo == repo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subject,repo);

@override
String toString() {
  return 'ObserveEntry(subject: $subject, repo: $repo)';
}


}

/// @nodoc
abstract mixin class $ObserveEntryCopyWith<$Res>  {
  factory $ObserveEntryCopyWith(ObserveEntry value, $Res Function(ObserveEntry) _then) = _$ObserveEntryCopyWithImpl;
@useResult
$Res call({
 String subject, String repo
});




}
/// @nodoc
class _$ObserveEntryCopyWithImpl<$Res>
    implements $ObserveEntryCopyWith<$Res> {
  _$ObserveEntryCopyWithImpl(this._self, this._then);

  final ObserveEntry _self;
  final $Res Function(ObserveEntry) _then;

/// Create a copy of ObserveEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subject = null,Object? repo = null,}) {
  return _then(_self.copyWith(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ObserveEntry].
extension ObserveEntryPatterns on ObserveEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObserveEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObserveEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObserveEntry value)  $default,){
final _that = this;
switch (_that) {
case _ObserveEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObserveEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ObserveEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subject,  String repo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObserveEntry() when $default != null:
return $default(_that.subject,_that.repo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subject,  String repo)  $default,) {final _that = this;
switch (_that) {
case _ObserveEntry():
return $default(_that.subject,_that.repo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subject,  String repo)?  $default,) {final _that = this;
switch (_that) {
case _ObserveEntry() when $default != null:
return $default(_that.subject,_that.repo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ObserveEntry implements ObserveEntry {
  const _ObserveEntry({required this.subject, required this.repo});
  factory _ObserveEntry.fromJson(Map<String, dynamic> json) => _$ObserveEntryFromJson(json);

/// Subject's public key.
@override final  String subject;
/// Subject's repo URL.
@override final  String repo;

/// Create a copy of ObserveEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObserveEntryCopyWith<_ObserveEntry> get copyWith => __$ObserveEntryCopyWithImpl<_ObserveEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObserveEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObserveEntry&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.repo, repo) || other.repo == repo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subject,repo);

@override
String toString() {
  return 'ObserveEntry(subject: $subject, repo: $repo)';
}


}

/// @nodoc
abstract mixin class _$ObserveEntryCopyWith<$Res> implements $ObserveEntryCopyWith<$Res> {
  factory _$ObserveEntryCopyWith(_ObserveEntry value, $Res Function(_ObserveEntry) _then) = __$ObserveEntryCopyWithImpl;
@override @useResult
$Res call({
 String subject, String repo
});




}
/// @nodoc
class __$ObserveEntryCopyWithImpl<$Res>
    implements _$ObserveEntryCopyWith<$Res> {
  __$ObserveEntryCopyWithImpl(this._self, this._then);

  final _ObserveEntry _self;
  final $Res Function(_ObserveEntry) _then;

/// Create a copy of ObserveEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subject = null,Object? repo = null,}) {
  return _then(_ObserveEntry(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
