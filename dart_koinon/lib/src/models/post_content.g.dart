// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostContent _$PostContentFromJson(Map<String, dynamic> json) => _PostContent(
  text: json['text'] as String,
  title: json['title'] as String?,
  url: json['url'] as String?,
  media:
      (json['media'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$PostContentToJson(_PostContent instance) =>
    <String, dynamic>{
      'text': instance.text,
      'title': instance.title,
      'url': instance.url,
      'media': instance.media,
    };
