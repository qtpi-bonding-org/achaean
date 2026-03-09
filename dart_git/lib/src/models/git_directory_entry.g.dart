// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_directory_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitDirectoryEntry _$GitDirectoryEntryFromJson(Map<String, dynamic> json) =>
    GitDirectoryEntry(
      name: json['name'] as String,
      path: json['path'] as String,
      type: $enumDecode(_$GitEntryTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$GitDirectoryEntryToJson(GitDirectoryEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'type': _$GitEntryTypeEnumMap[instance.type]!,
    };

const _$GitEntryTypeEnumMap = {
  GitEntryType.file: 'file',
  GitEntryType.dir: 'dir',
};
