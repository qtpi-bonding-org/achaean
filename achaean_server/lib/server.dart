import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:koinon_index_core_server/koinon_index_core_server.dart'
    hide Protocol, Endpoints;
import 'package:koinon_index_content_server/koinon_index_content_server.dart'
    hide Protocol, Endpoints;

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/poleis_route.dart';
import 'src/web/routes/recent_posts_route.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: KoinonAuthHandler.handleAuthentication,
  );

  // Koinon webhook route
  KoinonCore.registerRoutes(pod);

  // Public pages — SEO-friendly, no auth
  pod.webServer.addRoute(PoleisRoute(), '/');
  pod.webServer.addRoute(PoleisRoute(), '/index.html');
  pod.webServer.addRoute(RecentPostsRoute(), '/recent');

  // App config + Flutter app routes
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(Directory(Uri(path: 'web/app').toFilePath())),
      '/app',
    );
  } else {
    pod.webServer.addRoute(
      StaticRoute.file(
        File(Uri(path: 'web/pages/build_flutter_app.html').toFilePath()),
      ),
      '/app/**',
    );
  }

  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  await pod.start();

  // Initialize Koinon trust graph
  await KoinonCore.initialize(
    pod,
    config: KoinonCoreConfig(
      forgeInternalHost: Platform.environment['FORGEJO_INTERNAL_HOST'],
      webhookSecret: Platform.environment['KOINON_WEBHOOK_SECRET'] ?? '',
      graphName: 'koinon',
      onPostsChanged: (session, event, paths) async {
        final now = DateTime.now().toUtc();
        await ContentIndexer.indexPosts(session, event, paths, now);
      },
    ),
  );
}
