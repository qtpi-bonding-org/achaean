// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polis_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PolisMembershipImpl _$$PolisMembershipImplFromJson(
  Map<String, dynamic> json,
) => _$PolisMembershipImpl(
  repo: json['repo'] as String,
  name: json['name'] as String,
  stars: (json['stars'] as num).toInt(),
  role: json['role'] as String,
);

Map<String, dynamic> _$$PolisMembershipImplToJson(
  _$PolisMembershipImpl instance,
) => <String, dynamic>{
  'repo': instance.repo,
  'name': instance.name,
  'stars': instance.stars,
  'role': instance.role,
};
