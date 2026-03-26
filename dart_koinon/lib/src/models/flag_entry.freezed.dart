// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flag_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlagEntry {

/// Path to the flagged post.
 String get post;/// Polis repo URL where this flag applies.
 String get polis;/// Free-form reason for flagging.
 String get reason;
/// Create a copy of FlagEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagEntryCopyWith<FlagEntry> get copyWith => _$FlagEntryCopyWithImpl<FlagEntry>(this as FlagEntry, _$identity);

  /// Serializes this FlagEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagEntry&&(identical(other.post, post) || other.post == post)&&(identical(other.polis, polis) || other.polis == polis)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,post,polis,reason);

@override
String toString() {
  return 'FlagEntry(post: $post, polis: $polis, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $FlagEntryCopyWith<$Res>  {
  factory $FlagEntryCopyWith(FlagEntry value, $Res Function(FlagEntry) _then) = _$FlagEntryCopyWithImpl;
@useResult
$Res call({
 String post, String polis, String reason
});




}
/// @nodoc
class _$FlagEntryCopyWithImpl<$Res>
    implements $FlagEntryCopyWith<$Res> {
  _$FlagEntryCopyWithImpl(this._self, this._then);

  final FlagEntry _self;
  final $Res Function(FlagEntry) _then;

/// Create a copy of FlagEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? post = null,Object? polis = null,Object? reason = null,}) {
  return _then(_self.copyWith(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as String,polis: null == polis ? _self.polis : polis // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlagEntry].
extension FlagEntryPatterns on FlagEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlagEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlagEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlagEntry value)  $default,){
final _that = this;
switch (_that) {
case _FlagEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlagEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FlagEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String post,  String polis,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlagEntry() when $default != null:
return $default(_that.post,_that.polis,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String post,  String polis,  String reason)  $default,) {final _that = this;
switch (_that) {
case _FlagEntry():
return $default(_that.post,_that.polis,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String post,  String polis,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _FlagEntry() when $default != null:
return $default(_that.post,_that.polis,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlagEntry implements FlagEntry {
  const _FlagEntry({required this.post, required this.polis, required this.reason});
  factory _FlagEntry.fromJson(Map<String, dynamic> json) => _$FlagEntryFromJson(json);

/// Path to the flagged post.
@override final  String post;
/// Polis repo URL where this flag applies.
@override final  String polis;
/// Free-form reason for flagging.
@override final  String reason;

/// Create a copy of FlagEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagEntryCopyWith<_FlagEntry> get copyWith => __$FlagEntryCopyWithImpl<_FlagEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlagEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagEntry&&(identical(other.post, post) || other.post == post)&&(identical(other.polis, polis) || other.polis == polis)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,post,polis,reason);

@override
String toString() {
  return 'FlagEntry(post: $post, polis: $polis, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$FlagEntryCopyWith<$Res> implements $FlagEntryCopyWith<$Res> {
  factory _$FlagEntryCopyWith(_FlagEntry value, $Res Function(_FlagEntry) _then) = __$FlagEntryCopyWithImpl;
@override @useResult
$Res call({
 String post, String polis, String reason
});




}
/// @nodoc
class __$FlagEntryCopyWithImpl<$Res>
    implements _$FlagEntryCopyWith<$Res> {
  __$FlagEntryCopyWithImpl(this._self, this._then);

  final _FlagEntry _self;
  final $Res Function(_FlagEntry) _then;

/// Create a copy of FlagEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? post = null,Object? polis = null,Object? reason = null,}) {
  return _then(_FlagEntry(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as String,polis: null == polis ? _self.polis : polis // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
