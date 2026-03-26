// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polis_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PolisInfo {

 String get name; String? get description; String? get norms; int? get membershipThreshold; int? get flagThreshold; String? get parentRepo;
/// Create a copy of PolisInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolisInfoCopyWith<PolisInfo> get copyWith => _$PolisInfoCopyWithImpl<PolisInfo>(this as PolisInfo, _$identity);

  /// Serializes this PolisInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolisInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.norms, norms) || other.norms == norms)&&(identical(other.membershipThreshold, membershipThreshold) || other.membershipThreshold == membershipThreshold)&&(identical(other.flagThreshold, flagThreshold) || other.flagThreshold == flagThreshold)&&(identical(other.parentRepo, parentRepo) || other.parentRepo == parentRepo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,norms,membershipThreshold,flagThreshold,parentRepo);

@override
String toString() {
  return 'PolisInfo(name: $name, description: $description, norms: $norms, membershipThreshold: $membershipThreshold, flagThreshold: $flagThreshold, parentRepo: $parentRepo)';
}


}

/// @nodoc
abstract mixin class $PolisInfoCopyWith<$Res>  {
  factory $PolisInfoCopyWith(PolisInfo value, $Res Function(PolisInfo) _then) = _$PolisInfoCopyWithImpl;
@useResult
$Res call({
 String name, String? description, String? norms, int? membershipThreshold, int? flagThreshold, String? parentRepo
});




}
/// @nodoc
class _$PolisInfoCopyWithImpl<$Res>
    implements $PolisInfoCopyWith<$Res> {
  _$PolisInfoCopyWithImpl(this._self, this._then);

  final PolisInfo _self;
  final $Res Function(PolisInfo) _then;

/// Create a copy of PolisInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? norms = freezed,Object? membershipThreshold = freezed,Object? flagThreshold = freezed,Object? parentRepo = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,norms: freezed == norms ? _self.norms : norms // ignore: cast_nullable_to_non_nullable
as String?,membershipThreshold: freezed == membershipThreshold ? _self.membershipThreshold : membershipThreshold // ignore: cast_nullable_to_non_nullable
as int?,flagThreshold: freezed == flagThreshold ? _self.flagThreshold : flagThreshold // ignore: cast_nullable_to_non_nullable
as int?,parentRepo: freezed == parentRepo ? _self.parentRepo : parentRepo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PolisInfo].
extension PolisInfoPatterns on PolisInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PolisInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PolisInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PolisInfo value)  $default,){
final _that = this;
switch (_that) {
case _PolisInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PolisInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PolisInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description,  String? norms,  int? membershipThreshold,  int? flagThreshold,  String? parentRepo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PolisInfo() when $default != null:
return $default(_that.name,_that.description,_that.norms,_that.membershipThreshold,_that.flagThreshold,_that.parentRepo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description,  String? norms,  int? membershipThreshold,  int? flagThreshold,  String? parentRepo)  $default,) {final _that = this;
switch (_that) {
case _PolisInfo():
return $default(_that.name,_that.description,_that.norms,_that.membershipThreshold,_that.flagThreshold,_that.parentRepo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description,  String? norms,  int? membershipThreshold,  int? flagThreshold,  String? parentRepo)?  $default,) {final _that = this;
switch (_that) {
case _PolisInfo() when $default != null:
return $default(_that.name,_that.description,_that.norms,_that.membershipThreshold,_that.flagThreshold,_that.parentRepo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PolisInfo implements PolisInfo {
  const _PolisInfo({required this.name, this.description, this.norms, this.membershipThreshold, this.flagThreshold, this.parentRepo});
  factory _PolisInfo.fromJson(Map<String, dynamic> json) => _$PolisInfoFromJson(json);

@override final  String name;
@override final  String? description;
@override final  String? norms;
@override final  int? membershipThreshold;
@override final  int? flagThreshold;
@override final  String? parentRepo;

/// Create a copy of PolisInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolisInfoCopyWith<_PolisInfo> get copyWith => __$PolisInfoCopyWithImpl<_PolisInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PolisInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolisInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.norms, norms) || other.norms == norms)&&(identical(other.membershipThreshold, membershipThreshold) || other.membershipThreshold == membershipThreshold)&&(identical(other.flagThreshold, flagThreshold) || other.flagThreshold == flagThreshold)&&(identical(other.parentRepo, parentRepo) || other.parentRepo == parentRepo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,norms,membershipThreshold,flagThreshold,parentRepo);

@override
String toString() {
  return 'PolisInfo(name: $name, description: $description, norms: $norms, membershipThreshold: $membershipThreshold, flagThreshold: $flagThreshold, parentRepo: $parentRepo)';
}


}

/// @nodoc
abstract mixin class _$PolisInfoCopyWith<$Res> implements $PolisInfoCopyWith<$Res> {
  factory _$PolisInfoCopyWith(_PolisInfo value, $Res Function(_PolisInfo) _then) = __$PolisInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description, String? norms, int? membershipThreshold, int? flagThreshold, String? parentRepo
});




}
/// @nodoc
class __$PolisInfoCopyWithImpl<$Res>
    implements _$PolisInfoCopyWith<$Res> {
  __$PolisInfoCopyWithImpl(this._self, this._then);

  final _PolisInfo _self;
  final $Res Function(_PolisInfo) _then;

/// Create a copy of PolisInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? norms = freezed,Object? membershipThreshold = freezed,Object? flagThreshold = freezed,Object? parentRepo = freezed,}) {
  return _then(_PolisInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,norms: freezed == norms ? _self.norms : norms // ignore: cast_nullable_to_non_nullable
as String?,membershipThreshold: freezed == membershipThreshold ? _self.membershipThreshold : membershipThreshold // ignore: cast_nullable_to_non_nullable
as int?,flagThreshold: freezed == flagThreshold ? _self.flagThreshold : flagThreshold // ignore: cast_nullable_to_non_nullable
as int?,parentRepo: freezed == parentRepo ? _self.parentRepo : parentRepo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
