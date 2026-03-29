import 'package:serverpod/serverpod.dart';

/// Public recent posts page — latest posts across all poleis.
class RecentPostsPageWidget extends TemplateWidget {
  RecentPostsPageWidget({
    required List<Map<String, dynamic>> posts,
    required String forgeUrl,
  }) : super(name: 'recent_posts_page') {
    values = {
      'title': 'Recent Posts',
      'description': 'Latest posts on Achaean',
      'forge_url': forgeUrl,
      'posts': posts,
      'has_posts': posts.isNotEmpty,
    };
  }
}
