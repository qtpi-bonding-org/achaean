// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_creation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountCreationResult {

 String get pubkeyHex; String get repoOwner; String get repoName; String get repoUrl;
/// Create a copy of AccountCreationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCreationResultCopyWith<AccountCreationResult> get copyWith => _$AccountCreationResultCopyWithImpl<AccountCreationResult>(this as AccountCreationResult, _$identity);

  /// Serializes this AccountCreationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountCreationResult&&(identical(other.pubkeyHex, pubkeyHex) || other.pubkeyHex == pubkeyHex)&&(identical(other.repoOwner, repoOwner) || other.repoOwner == repoOwner)&&(identical(other.repoName, repoName) || other.repoName == repoName)&&(identical(other.repoUrl, repoUrl) || other.repoUrl == repoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pubkeyHex,repoOwner,repoName,repoUrl);

@override
String toString() {
  return 'AccountCreationResult(pubkeyHex: $pubkeyHex, repoOwner: $repoOwner, repoName: $repoName, repoUrl: $repoUrl)';
}


}

/// @nodoc
abstract mixin class $AccountCreationResultCopyWith<$Res>  {
  factory $AccountCreationResultCopyWith(AccountCreationResult value, $Res Function(AccountCreationResult) _then) = _$AccountCreationResultCopyWithImpl;
@useResult
$Res call({
 String pubkeyHex, String repoOwner, String repoName, String repoUrl
});




}
/// @nodoc
class _$AccountCreationResultCopyWithImpl<$Res>
    implements $AccountCreationResultCopyWith<$Res> {
  _$AccountCreationResultCopyWithImpl(this._self, this._then);

  final AccountCreationResult _self;
  final $Res Function(AccountCreationResult) _then;

/// Create a copy of AccountCreationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pubkeyHex = null,Object? repoOwner = null,Object? repoName = null,Object? repoUrl = null,}) {
  return _then(_self.copyWith(
pubkeyHex: null == pubkeyHex ? _self.pubkeyHex : pubkeyHex // ignore: cast_nullable_to_non_nullable
as String,repoOwner: null == repoOwner ? _self.repoOwner : repoOwner // ignore: cast_nullable_to_non_nullable
as String,repoName: null == repoName ? _self.repoName : repoName // ignore: cast_nullable_to_non_nullable
as String,repoUrl: null == repoUrl ? _self.repoUrl : repoUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountCreationResult].
extension AccountCreationResultPatterns on AccountCreationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountCreationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountCreationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountCreationResult value)  $default,){
final _that = this;
switch (_that) {
case _AccountCreationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountCreationResult value)?  $default,){
final _that = this;
switch (_that) {
case _AccountCreationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pubkeyHex,  String repoOwner,  String repoName,  String repoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountCreationResult() when $default != null:
return $default(_that.pubkeyHex,_that.repoOwner,_that.repoName,_that.repoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pubkeyHex,  String repoOwner,  String repoName,  String repoUrl)  $default,) {final _that = this;
switch (_that) {
case _AccountCreationResult():
return $default(_that.pubkeyHex,_that.repoOwner,_that.repoName,_that.repoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pubkeyHex,  String repoOwner,  String repoName,  String repoUrl)?  $default,) {final _that = this;
switch (_that) {
case _AccountCreationResult() when $default != null:
return $default(_that.pubkeyHex,_that.repoOwner,_that.repoName,_that.repoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountCreationResult implements AccountCreationResult {
  const _AccountCreationResult({required this.pubkeyHex, required this.repoOwner, required this.repoName, required this.repoUrl});
  factory _AccountCreationResult.fromJson(Map<String, dynamic> json) => _$AccountCreationResultFromJson(json);

@override final  String pubkeyHex;
@override final  String repoOwner;
@override final  String repoName;
@override final  String repoUrl;

/// Create a copy of AccountCreationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountCreationResultCopyWith<_AccountCreationResult> get copyWith => __$AccountCreationResultCopyWithImpl<_AccountCreationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountCreationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountCreationResult&&(identical(other.pubkeyHex, pubkeyHex) || other.pubkeyHex == pubkeyHex)&&(identical(other.repoOwner, repoOwner) || other.repoOwner == repoOwner)&&(identical(other.repoName, repoName) || other.repoName == repoName)&&(identical(other.repoUrl, repoUrl) || other.repoUrl == repoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pubkeyHex,repoOwner,repoName,repoUrl);

@override
String toString() {
  return 'AccountCreationResult(pubkeyHex: $pubkeyHex, repoOwner: $repoOwner, repoName: $repoName, repoUrl: $repoUrl)';
}


}

/// @nodoc
abstract mixin class _$AccountCreationResultCopyWith<$Res> implements $AccountCreationResultCopyWith<$Res> {
  factory _$AccountCreationResultCopyWith(_AccountCreationResult value, $Res Function(_AccountCreationResult) _then) = __$AccountCreationResultCopyWithImpl;
@override @useResult
$Res call({
 String pubkeyHex, String repoOwner, String repoName, String repoUrl
});




}
/// @nodoc
class __$AccountCreationResultCopyWithImpl<$Res>
    implements _$AccountCreationResultCopyWith<$Res> {
  __$AccountCreationResultCopyWithImpl(this._self, this._then);

  final _AccountCreationResult _self;
  final $Res Function(_AccountCreationResult) _then;

/// Create a copy of AccountCreationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pubkeyHex = null,Object? repoOwner = null,Object? repoName = null,Object? repoUrl = null,}) {
  return _then(_AccountCreationResult(
pubkeyHex: null == pubkeyHex ? _self.pubkeyHex : pubkeyHex // ignore: cast_nullable_to_non_nullable
as String,repoOwner: null == repoOwner ? _self.repoOwner : repoOwner // ignore: cast_nullable_to_non_nullable
as String,repoName: null == repoName ? _self.repoName : repoName // ignore: cast_nullable_to_non_nullable
as String,repoUrl: null == repoUrl ? _self.repoUrl : repoUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
