import 'normalized_push_event.dart';

/// Abstract webhook parser for normalizing push events from different providers.
abstract class IWebhookParser {
  NormalizedPushEvent? parsePush(Map<String, dynamic> json);
}
