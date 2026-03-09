import 'package:json_annotation/json_annotation.dart';

part 'normalized_push_event.g.dart';

enum WebhookFileAction {
  added,
  modified,
  removed,
}

@JsonSerializable()
class WebhookFileChange {
  final String path;
  final WebhookFileAction action;

  const WebhookFileChange({required this.path, required this.action});

  factory WebhookFileChange.fromJson(Map<String, dynamic> json) =>
      _$WebhookFileChangeFromJson(json);

  Map<String, dynamic> toJson() => _$WebhookFileChangeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NormalizedPushEvent {
  final String repoOwner;
  final String repoName;
  final String repoUrl;
  final String ref;
  final String beforeCommit;
  final String afterCommit;
  final List<WebhookFileChange> changes;
  final DateTime timestamp;

  const NormalizedPushEvent({
    required this.repoOwner,
    required this.repoName,
    required this.repoUrl,
    required this.ref,
    required this.beforeCommit,
    required this.afterCommit,
    required this.changes,
    required this.timestamp,
  });

  factory NormalizedPushEvent.fromJson(Map<String, dynamic> json) =>
      _$NormalizedPushEventFromJson(json);

  Map<String, dynamic> toJson() => _$NormalizedPushEventToJson(this);
}
