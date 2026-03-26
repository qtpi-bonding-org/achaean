// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polis_membership.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PolisMembership {

/// The polis repo identifier.
 String get repo;/// Display name of the polis.
 String get name;/// Number of keypairs that signed the current README.
 int get stars;/// The user's role/trust level in this polis.
 String get role;
/// Create a copy of PolisMembership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolisMembershipCopyWith<PolisMembership> get copyWith => _$PolisMembershipCopyWithImpl<PolisMembership>(this as PolisMembership, _$identity);

  /// Serializes this PolisMembership to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolisMembership&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.name, name) || other.name == name)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,repo,name,stars,role);

@override
String toString() {
  return 'PolisMembership(repo: $repo, name: $name, stars: $stars, role: $role)';
}


}

/// @nodoc
abstract mixin class $PolisMembershipCopyWith<$Res>  {
  factory $PolisMembershipCopyWith(PolisMembership value, $Res Function(PolisMembership) _then) = _$PolisMembershipCopyWithImpl;
@useResult
$Res call({
 String repo, String name, int stars, String role
});




}
/// @nodoc
class _$PolisMembershipCopyWithImpl<$Res>
    implements $PolisMembershipCopyWith<$Res> {
  _$PolisMembershipCopyWithImpl(this._self, this._then);

  final PolisMembership _self;
  final $Res Function(PolisMembership) _then;

/// Create a copy of PolisMembership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? repo = null,Object? name = null,Object? stars = null,Object? role = null,}) {
  return _then(_self.copyWith(
repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PolisMembership].
extension PolisMembershipPatterns on PolisMembership {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PolisMembership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PolisMembership() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PolisMembership value)  $default,){
final _that = this;
switch (_that) {
case _PolisMembership():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PolisMembership value)?  $default,){
final _that = this;
switch (_that) {
case _PolisMembership() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String repo,  String name,  int stars,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PolisMembership() when $default != null:
return $default(_that.repo,_that.name,_that.stars,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String repo,  String name,  int stars,  String role)  $default,) {final _that = this;
switch (_that) {
case _PolisMembership():
return $default(_that.repo,_that.name,_that.stars,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String repo,  String name,  int stars,  String role)?  $default,) {final _that = this;
switch (_that) {
case _PolisMembership() when $default != null:
return $default(_that.repo,_that.name,_that.stars,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PolisMembership implements PolisMembership {
  const _PolisMembership({required this.repo, required this.name, required this.stars, required this.role});
  factory _PolisMembership.fromJson(Map<String, dynamic> json) => _$PolisMembershipFromJson(json);

/// The polis repo identifier.
@override final  String repo;
/// Display name of the polis.
@override final  String name;
/// Number of keypairs that signed the current README.
@override final  int stars;
/// The user's role/trust level in this polis.
@override final  String role;

/// Create a copy of PolisMembership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolisMembershipCopyWith<_PolisMembership> get copyWith => __$PolisMembershipCopyWithImpl<_PolisMembership>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PolisMembershipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolisMembership&&(identical(other.repo, repo) || other.repo == repo)&&(identical(other.name, name) || other.name == name)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,repo,name,stars,role);

@override
String toString() {
  return 'PolisMembership(repo: $repo, name: $name, stars: $stars, role: $role)';
}


}

/// @nodoc
abstract mixin class _$PolisMembershipCopyWith<$Res> implements $PolisMembershipCopyWith<$Res> {
  factory _$PolisMembershipCopyWith(_PolisMembership value, $Res Function(_PolisMembership) _then) = __$PolisMembershipCopyWithImpl;
@override @useResult
$Res call({
 String repo, String name, int stars, String role
});




}
/// @nodoc
class __$PolisMembershipCopyWithImpl<$Res>
    implements _$PolisMembershipCopyWith<$Res> {
  __$PolisMembershipCopyWithImpl(this._self, this._then);

  final _PolisMembership _self;
  final $Res Function(_PolisMembership) _then;

/// Create a copy of PolisMembership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? repo = null,Object? name = null,Object? stars = null,Object? role = null,}) {
  return _then(_PolisMembership(
repo: null == repo ? _self.repo : repo // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
