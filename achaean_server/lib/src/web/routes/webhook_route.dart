import 'dart:convert';
import 'dart:io' as io;

import 'package:serverpod/serverpod.dart';

import '../../koinon/webhook_indexer.dart';

/// Raw HTTP route that receives Forgejo push webhooks and delegates
/// to [WebhookIndexer.handlePush] for indexing.
class WebhookRoute extends Route {
  static final _webhookSecret =
      io.Platform.environment['KOINON_WEBHOOK_SECRET'] ?? '';

  final WebhookIndexer _webhook = WebhookIndexer();

  WebhookRoute() : super(methods: {Method.post});

  @override
  Future<Result> handleCall(Session session, Request request) async {
    // Verify webhook secret if configured
    if (_webhookSecret.isNotEmpty) {
      final secret = request.headers['x-webhook-secret']?.first;
      if (secret != _webhookSecret) {
        return Response.forbidden(
          body: Body.fromString(
            jsonEncode({'error': 'invalid secret'}),
            mimeType: MimeType.json,
          ),
        );
      }
    }

    try {
      final bodyText = await request.readAsString();
      final payload = jsonDecode(bodyText) as Map<String, dynamic>;

      await _webhook.handlePush(session, payload);

      return Response.ok(
        body: Body.fromString(
          jsonEncode({'status': 'indexed'}),
          mimeType: MimeType.json,
        ),
      );
    } catch (e, stack) {
      session.log('Webhook error: $e\n$stack', level: LogLevel.error);
      return Response.internalServerError(
        body: Body.fromString(
          jsonEncode({'error': e.toString()}),
          mimeType: MimeType.json,
        ),
      );
    }
  }
}
