import 'package:serverpod/serverpod.dart';

/// Public poleis listing page.
class PoleisPageWidget extends TemplateWidget {
  PoleisPageWidget({
    required List<Map<String, dynamic>> poleis,
    required String forgeUrl,
  }) : super(name: 'poleis_page') {
    values = {
      'title': 'Poleis',
      'description': 'Communities on Achaean',
      'forge_url': forgeUrl,
      'poleis': poleis,
      'has_poleis': poleis.isNotEmpty,
    };
  }
}
