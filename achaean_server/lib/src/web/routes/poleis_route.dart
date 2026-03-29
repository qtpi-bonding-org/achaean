import 'dart:io' as io;

import 'package:serverpod/serverpod.dart';
import 'package:koinon_index_core_server/koinon_index_core_server.dart';

import '../widgets/poleis_page.dart';

/// Serves the public poleis listing page.
class PoleisRoute extends WidgetRoute {
  static final _forgeUrl =
      io.Platform.environment['FORGEJO_PUBLIC_URL'] ?? 'http://localhost:3000';

  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    final poleis = await PolisDefinition.db.find(
      session,
      orderBy: (t) => t.discoveredAt,
      orderDescending: true,
    );

    return PoleisPageWidget(
      forgeUrl: _forgeUrl,
      poleis: poleis
          .map((p) => {
                'name': p.name,
                'description': p.description,
                'repoUrl': p.repoUrl,
                'repoUrl_encoded': Uri.encodeComponent(p.repoUrl),
                'member_count': 0, // TODO: query AGE graph
                'has_description': p.description != null,
              })
          .toList(),
    );
  }
}
