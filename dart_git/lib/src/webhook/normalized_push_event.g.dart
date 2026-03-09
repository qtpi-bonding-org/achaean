// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normalized_push_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookFileChange _$WebhookFileChangeFromJson(Map<String, dynamic> json) =>
    WebhookFileChange(
      path: json['path'] as String,
      action: $enumDecode(_$WebhookFileActionEnumMap, json['action']),
    );

Map<String, dynamic> _$WebhookFileChangeToJson(WebhookFileChange instance) =>
    <String, dynamic>{
      'path': instance.path,
      'action': _$WebhookFileActionEnumMap[instance.action]!,
    };

const _$WebhookFileActionEnumMap = {
  WebhookFileAction.added: 'added',
  WebhookFileAction.modified: 'modified',
  WebhookFileAction.removed: 'removed',
};

NormalizedPushEvent _$NormalizedPushEventFromJson(Map<String, dynamic> json) =>
    NormalizedPushEvent(
      repoOwner: json['repoOwner'] as String,
      repoName: json['repoName'] as String,
      repoUrl: json['repoUrl'] as String,
      ref: json['ref'] as String,
      beforeCommit: json['beforeCommit'] as String,
      afterCommit: json['afterCommit'] as String,
      changes: (json['changes'] as List<dynamic>)
          .map((e) => WebhookFileChange.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$NormalizedPushEventToJson(
  NormalizedPushEvent instance,
) => <String, dynamic>{
  'repoOwner': instance.repoOwner,
  'repoName': instance.repoName,
  'repoUrl': instance.repoUrl,
  'ref': instance.ref,
  'beforeCommit': instance.beforeCommit,
  'afterCommit': instance.afterCommit,
  'changes': instance.changes.map((e) => e.toJson()).toList(),
  'timestamp': instance.timestamp.toIso8601String(),
};
