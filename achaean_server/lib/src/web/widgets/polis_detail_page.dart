import 'package:serverpod/serverpod.dart';

/// Public polis detail page with member list and recent posts.
class PolisDetailPageWidget extends TemplateWidget {
  PolisDetailPageWidget({
    required String name,
    required String? description,
    required String repoUrl,
    required String forgeUrl,
    required int memberCount,
    required List<Map<String, dynamic>> posts,
    required List<Map<String, dynamic>> members,
  }) : super(name: 'polis_detail_page') {
    values = {
      'title': name,
      'description': description ?? 'A community on Achaean',
      'polis_name': name,
      'polis_description': description,
      'polis_repo_url': repoUrl,
      'forge_url': forgeUrl,
      'member_count': memberCount,
      'posts': posts,
      'has_posts': posts.isNotEmpty,
      'members': members,
      'has_members': members.isNotEmpty,
    };
  }
}
