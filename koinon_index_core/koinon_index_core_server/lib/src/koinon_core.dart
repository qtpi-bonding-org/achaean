import 'dart:io';

import 'package:serverpod/serverpod.dart';

import 'koinon/age_graph.dart';
import 'web/webhook_route.dart';

class KoinonCoreConfig {
  final String? forgeInternalHost;
  final String webhookSecret;
  final String graphName;
  final Future<void> Function(Session, String pubkey)? onUserIndexed;
  final Future<void> Function(Session, String pubkey)? onTrustChanged;
  final Future<void> Function(Session, String polisRepoUrl)? onPolisDiscovered;
  final Future<void> Function(Session, dynamic event, List<String> paths)?
      onPostsChanged;

  const KoinonCoreConfig({
    this.forgeInternalHost,
    this.webhookSecret = '',
    this.graphName = 'koinon',
    this.onUserIndexed,
    this.onTrustChanged,
    this.onPolisDiscovered,
    this.onPostsChanged,
  });
}

class KoinonCore {
  static KoinonCoreConfig _config = const KoinonCoreConfig();
  static KoinonCoreConfig get config => _config;

  static void registerRoutes(Serverpod pod, {String webhookPath = '/webhook'}) {
    pod.webServer.addRoute(WebhookRoute(), webhookPath);
  }

  static Future<void> initialize(
    Serverpod pod, {
    KoinonCoreConfig config = const KoinonCoreConfig(),
  }) async {
    _config = config;
    final session = await pod.createSession();
    try {
      await AgeGraph.initialize(session);
      stdout.writeln('KoinonCore: AGE graph initialized');
    } catch (e) {
      stdout.writeln('KoinonCore: AGE initialization failed: $e');
    } finally {
      await session.close();
    }
  }
}
