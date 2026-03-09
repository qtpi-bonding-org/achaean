import 'package:uuid/uuid.dart';

/// Pure static utility for generating URL-safe post slugs.
///
/// Format: `2026-03-09-my-first-post`
/// Rules: lowercase, strip non-alphanumeric, hyphenate spaces,
/// truncate to 50 chars, fall back to short UUID.
class SlugGenerator {
  SlugGenerator._();

  static String generate({String? title, String? text, DateTime? date}) {
    final d = date ?? DateTime.now();
    final datePrefix =
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

    final source = title ?? text;
    if (source == null || source.trim().isEmpty) {
      final shortId = const Uuid().v4().substring(0, 8);
      return '$datePrefix-$shortId';
    }

    final slug = source
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-');

    if (slug.isEmpty) {
      final shortId = const Uuid().v4().substring(0, 8);
      return '$datePrefix-$shortId';
    }

    // Truncate slug portion to keep total under 50 chars
    final maxSlugLen = 50 - datePrefix.length - 1; // -1 for hyphen
    final truncated =
        slug.length > maxSlugLen ? slug.substring(0, maxSlugLen) : slug;

    // Remove trailing hyphen after truncation
    final cleaned =
        truncated.endsWith('-') ? truncated.substring(0, truncated.length - 1) : truncated;

    return '$datePrefix-$cleaned';
  }
}
