import 'package:test/test.dart';
import 'package:achaean_server/src/koinon/rss_feed_parser.dart';

void main() {
  group('RssFeedParser', () {
    test('parses items with koinon:post CDATA', () {
      final xml = '''<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:koinon="https://koinon.org/rss">
  <channel>
    <title>alice</title>
    <description>Koinon feed for alice</description>
    <lastBuildDate>2026-03-10T12:00:00.000Z</lastBuildDate>
    <item>
      <title>My First Post</title>
      <description>Hello world</description>
      <pubDate>2026-03-10T12:00:00.000Z</pubDate>
      <link>https://forge.example/alice/koinon/raw/branch/main/posts/my-first-post/post.json</link>
      <koinon:post><![CDATA[{"content":{"text":"Hello world","title":"My First Post"},"routing":{"poleis":["alice/polis-democracy"],"tags":["intro"],"mentions":[]},"timestamp":"2026-03-10T12:00:00.000Z","signature":"abc123"}]]></koinon:post>
    </item>
    <item>
      <title>Re: Bob</title>
      <description>I agree!</description>
      <pubDate>2026-03-10T13:00:00.000Z</pubDate>
      <link>https://forge.example/alice/koinon/raw/branch/main/posts/re-bob/post.json</link>
      <koinon:post><![CDATA[{"content":{"text":"I agree!"},"parent":{"author":"def789","repo":"bob/koinon","path":"posts/some-post/post.json","commit":"abc123"},"timestamp":"2026-03-10T13:00:00.000Z","signature":"def456"}]]></koinon:post>
    </item>
  </channel>
</rss>''';

      final items = RssFeedParser.parse(xml);

      expect(items, hasLength(2));

      expect(items[0].link,
          'https://forge.example/alice/koinon/raw/branch/main/posts/my-first-post/post.json');
      expect(items[0].postJson, contains('"Hello world"'));
      expect(items[0].postJson, contains('"My First Post"'));

      expect(items[1].link,
          'https://forge.example/alice/koinon/raw/branch/main/posts/re-bob/post.json');
      expect(items[1].postJson, contains('"I agree!"'));
      expect(items[1].postJson, contains('"parent"'));
    });

    test('returns empty list for RSS without koinon:post elements', () {
      final xml = '''<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>alice</title>
    <item>
      <title>Plain post</title>
      <description>No koinon data</description>
    </item>
  </channel>
</rss>''';

      final items = RssFeedParser.parse(xml);
      expect(items, isEmpty);
    });

    test('handles empty feed', () {
      final xml = '''<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:koinon="https://koinon.org/rss">
  <channel>
    <title>alice</title>
  </channel>
</rss>''';

      final items = RssFeedParser.parse(xml);
      expect(items, isEmpty);
    });
  });
}
