import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../agora/services/i_post_reading_service.dart';

/// In-memory cache for eagerly-fetched post content.
///
/// Fetches post content from forge URLs in the background and caches
/// results keyed by postUrl. Used by the personal feed to pre-load
/// content before the user taps a post.
class PostContentCache {
  final IPostReadingService _postReadingService;
  final Map<String, ReadablePostContent> _cache = {};
  final Set<String> _inFlight = {};

  PostContentCache(this._postReadingService);

  /// Get cached content for a post URL, or null if not yet fetched.
  ReadablePostContent? get(String postUrl) => _cache[postUrl];

  /// Whether content is cached for this URL.
  bool has(String postUrl) => _cache.containsKey(postUrl);

  /// Eagerly fetch and cache content for a list of post references.
  ///
  /// Fire-and-forget — failures are silently ignored (content will be
  /// fetched on demand when the detail screen opens).
  void prefetch(List<PostReference> refs) {
    for (final ref in refs) {
      if (_cache.containsKey(ref.postUrl) ||
          _inFlight.contains(ref.postUrl)) {
        continue;
      }
      _inFlight.add(ref.postUrl);
      _postReadingService.getPost(ref).then((content) {
        _cache[ref.postUrl] = content;
      }).catchError((_) {
        // Silently ignore — will fetch on demand
      }).whenComplete(() {
        _inFlight.remove(ref.postUrl);
      });
    }
  }

  /// Fetch content for a single post reference, using cache if available.
  Future<ReadablePostContent> getOrFetch(PostReference ref) async {
    final cached = _cache[ref.postUrl];
    if (cached != null) return cached;

    final content = await _postReadingService.getPost(ref);
    _cache[ref.postUrl] = content;
    return content;
  }
}
