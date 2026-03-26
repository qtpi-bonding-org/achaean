// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polis_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PolisMembership _$PolisMembershipFromJson(Map<String, dynamic> json) =>
    _PolisMembership(
      repo: json['repo'] as String,
      name: json['name'] as String,
      stars: (json['stars'] as num).toInt(),
      role: json['role'] as String,
    );

Map<String, dynamic> _$PolisMembershipToJson(_PolisMembership instance) =>
    <String, dynamic>{
      'repo': instance.repo,
      'name': instance.name,
      'stars': instance.stars,
      'role': instance.role,
    };
