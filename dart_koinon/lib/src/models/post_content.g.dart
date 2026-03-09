// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostContentImpl _$$PostContentImplFromJson(Map<String, dynamic> json) =>
    _$PostContentImpl(
      text: json['text'] as String,
      title: json['title'] as String?,
      url: json['url'] as String?,
      media:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$PostContentImplToJson(_$PostContentImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'title': instance.title,
      'url': instance.url,
      'media': instance.media,
    };
