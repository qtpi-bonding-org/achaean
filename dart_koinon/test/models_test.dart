import 'package:dart_koinon/dart_koinon.dart';
import 'package:test/test.dart';

void main() {
  group('TrustDeclaration', () {
    test('roundtrips through JSON', () {
      final decl = TrustDeclaration(
        subject: 'pubkey-abc',
        repo: 'https://forgejo.example.com/alice/repo',
        level: TrustLevel.trust,
        timestamp: DateTime.utc(2026, 1, 1),
        signature: 'sig123',
      );
      final json = decl.toJson();
      expect(json['type'], 'trust-declaration');
      final restored = TrustDeclaration.fromJson(json);
      expect(restored.subject, 'pubkey-abc');
      expect(restored.level, TrustLevel.trust);
      expect(restored, decl);
    });

    test('copyWith works', () {
      final decl = TrustDeclaration(
        subject: 'a',
        repo: 'r',
        level: TrustLevel.provisional,
        timestamp: DateTime.utc(2026),
        signature: 's',
      );
      final upgraded = decl.copyWith(level: TrustLevel.trust);
      expect(upgraded.level, TrustLevel.trust);
      expect(upgraded.subject, 'a');
    });
  });

  group('ReadmeSignature', () {
    test('roundtrips with snake_case JSON keys', () {
      final sig = ReadmeSignature(
        polis: 'polis-repo-id',
        readmeCommit: 'abc123',
        readmeHash: 'hash456',
        timestamp: DateTime.utc(2026, 3, 8),
        signature: 'sig789',
      );
      final json = sig.toJson();
      expect(json['readme_commit'], 'abc123');
      expect(json['readme_hash'], 'hash456');
      expect(json['type'], 'readme-signature');
      final restored = ReadmeSignature.fromJson(json);
      expect(restored.readmeCommit, 'abc123');
      expect(restored, sig);
    });
  });

  group('KoinonManifest', () {
    test('roundtrips with defaults', () {
      final manifest = KoinonManifest(
        pubkey: 'my-pubkey',
        repoHttps: 'https://forgejo.example.com/user/repo',
      );
      final json = manifest.toJson();
      expect(json['protocol'], 'koinon');
      expect(json['version'], '1.0');
      expect(json['trust_index'], '/trust/index.json');
      expect(json['poleis'], isEmpty);

      final restored = KoinonManifest.fromJson(json);
      expect(restored.pubkey, 'my-pubkey');
      expect(restored, manifest);
    });

    test('includes poleis memberships', () {
      final manifest = KoinonManifest(
        pubkey: 'pk',
        repoHttps: 'https://example.com/repo',
        poleis: [
          const PolisMembership(
            repo: 'polis-1',
            name: 'Linux Shitposters',
            stars: 47,
            role: 'TRUST',
          ),
        ],
      );
      final json = manifest.toJson();
      final poleis = json['poleis'] as List;
      expect(poleis, hasLength(1));
      expect((poleis[0] as Map)['name'], 'Linux Shitposters');

      final restored = KoinonManifest.fromJson(json);
      expect(restored.poleis.first.stars, 47);
    });
  });

  group('Post', () {
    test('post roundtrip', () {
      final post = Post(
        content: const PostContent(text: 'Hello world'),
        routing: const PostRouting(
          poleis: ['polis-1'],
          tags: ['test'],
        ),
        timestamp: DateTime.utc(2026, 3, 8),
        signature: 'sig',
      );
      final json = post.toJson();
      final restored = Post.fromJson(json);
      expect(restored.content.text, 'Hello world');
      expect(restored.routing!.poleis, ['polis-1']);
      expect(restored.parent, isNull);
    });

    test('reply roundtrip', () {
      final reply = Post(
        content: const PostContent(
          text: 'Great post!',
          media: ['reaction.jpg'],
        ),
        parent: const PostParent(
          author: 'their-pubkey',
          repo: 'their-repo',
          path: 'posts/2026-03-08-hello/post.json',
          commit: 'a1b2c3d4',
        ),
        timestamp: DateTime.utc(2026, 3, 8, 13),
        signature: 'reply-sig',
      );
      final json = reply.toJson();
      final restored = Post.fromJson(json);
      expect(restored.parent!.commit, 'a1b2c3d4');
      expect(restored.routing, isNull);
      expect(restored.content.media, ['reaction.jpg']);
    });

    test('post with details', () {
      final poll = Post(
        content: const PostContent(text: 'Best language?'),
        routing: const PostRouting(poleis: ['p1']),
        details: {
          'options': ['Rust', 'Go', 'Zig']
        },
        timestamp: DateTime.utc(2026),
        signature: 's',
      );
      final restored = Post.fromJson(poll.toJson());
      expect(restored.details!['options'], ['Rust', 'Go', 'Zig']);
    });
  });

  group('PolisMembership', () {
    test('roundtrip', () {
      const m = PolisMembership(
        repo: 'polis-id',
        name: 'Test Polis',
        stars: 10,
        role: 'TRUST',
      );
      final restored = PolisMembership.fromJson(m.toJson());
      expect(restored, m);
    });
  });
}
