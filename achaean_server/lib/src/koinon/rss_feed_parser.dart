/// Parsed RSS item containing koinon:post data.
class RssFeedItem {
  /// Full URL to post.json in the forge.
  final String link;

  /// Raw JSON string from koinon:post CDATA.
  final String postJson;

  const RssFeedItem({required this.link, required this.postJson});
}

/// Parses Koinon RSS feeds and extracts koinon:post CDATA content.
///
/// Uses string parsing on the well-known RSS format. We control both
/// producer (FeedGenerationService) and consumer (this parser).
/// If the RSS format evolves beyond this structure, upgrade to the xml package.
class RssFeedParser {
  static final _itemPattern =
      RegExp(r'<item>(.*?)</item>', dotAll: true);
  static final _linkPattern = RegExp(r'<link>(.*?)</link>');
  static final _cdataPattern =
      RegExp(r'<koinon:post><!\[CDATA\[(.*?)\]\]></koinon:post>', dotAll: true);

  /// Parse RSS XML and return items that contain koinon:post CDATA.
  ///
  /// Items without a koinon:post element are skipped.
  static List<RssFeedItem> parse(String xml) {
    final items = <RssFeedItem>[];

    for (final itemMatch in _itemPattern.allMatches(xml)) {
      final itemXml = itemMatch.group(1)!;

      final cdataMatch = _cdataPattern.firstMatch(itemXml);
      if (cdataMatch == null) continue;

      final linkMatch = _linkPattern.firstMatch(itemXml);
      if (linkMatch == null) continue;

      items.add(RssFeedItem(
        link: linkMatch.group(1)!.trim(),
        postJson: cdataMatch.group(1)!,
      ));
    }

    return items;
  }
}
