// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileDetails _$ProfileDetailsFromJson(Map<String, dynamic> json) =>
    _ProfileDetails(
      displayName: json['displayName'] as String?,
      bio: json['bio'] as String?,
      links:
          (json['links'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$ProfileDetailsToJson(_ProfileDetails instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'bio': instance.bio,
      'links': instance.links,
    };
