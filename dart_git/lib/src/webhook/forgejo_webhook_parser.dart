import 'i_webhook_parser.dart';
import 'normalized_push_event.dart';

/// Parses Forgejo push webhook payloads into [NormalizedPushEvent].
class ForgejoWebhookParser implements IWebhookParser {
  const ForgejoWebhookParser();

  @override
  NormalizedPushEvent? parsePush(Map<String, dynamic> json) {
    final repo = json['repository'] as Map<String, dynamic>?;
    if (repo == null) return null;

    final owner = repo['owner'] as Map<String, dynamic>?;
    if (owner == null) return null;

    final commits = json['commits'] as List<dynamic>? ?? [];
    final changes = <WebhookFileChange>[];

    for (final commit in commits) {
      final c = commit as Map<String, dynamic>;
      for (final path in (c['added'] as List<dynamic>? ?? [])) {
        changes.add(WebhookFileChange(
          path: path as String,
          action: WebhookFileAction.added,
        ));
      }
      for (final path in (c['modified'] as List<dynamic>? ?? [])) {
        changes.add(WebhookFileChange(
          path: path as String,
          action: WebhookFileAction.modified,
        ));
      }
      for (final path in (c['removed'] as List<dynamic>? ?? [])) {
        changes.add(WebhookFileChange(
          path: path as String,
          action: WebhookFileAction.removed,
        ));
      }
    }

    return NormalizedPushEvent(
      repoOwner: owner['login'] as String? ?? owner['username'] as String,
      repoName: repo['name'] as String,
      repoUrl: repo['html_url'] as String,
      ref: json['ref'] as String,
      beforeCommit: json['before'] as String,
      afterCommit: json['after'] as String,
      changes: changes,
      timestamp: DateTime.now(),
    );
  }
}
