import 'package:dart_git/dart_git.dart';
import 'package:test/test.dart';

void main() {
  group('GitRepo serialization', () {
    test('roundtrips through JSON', () {
      const repo = GitRepo(
        id: 1,
        name: 'test',
        owner: 'user',
        cloneUrl: 'https://example.com/user/test.git',
        htmlUrl: 'https://example.com/user/test',
        description: 'desc',
        private: true,
      );
      final json = repo.toJson();
      final restored = GitRepo.fromJson(json);
      expect(restored.id, 1);
      expect(restored.name, 'test');
      expect(restored.owner, 'user');
      expect(restored.private, true);
    });
  });

  group('GitFile serialization', () {
    test('roundtrips through JSON', () {
      const file = GitFile(path: 'a.txt', content: 'hello', sha: 'abc');
      final restored = GitFile.fromJson(file.toJson());
      expect(restored.path, 'a.txt');
      expect(restored.content, 'hello');
      expect(restored.sha, 'abc');
    });
  });

  group('GitCommit serialization', () {
    test('roundtrips through JSON', () {
      final commit = GitCommit(
        sha: 'abc',
        message: 'msg',
        timestamp: DateTime.utc(2025, 1, 1),
      );
      final restored = GitCommit.fromJson(commit.toJson());
      expect(restored.sha, 'abc');
      expect(restored.timestamp, DateTime.utc(2025, 1, 1));
    });
  });

  group('GitDirectoryEntry serialization', () {
    test('roundtrips through JSON', () {
      const entry = GitDirectoryEntry(
        name: 'src',
        path: 'lib/src',
        type: GitEntryType.dir,
      );
      final restored = GitDirectoryEntry.fromJson(entry.toJson());
      expect(restored.name, 'src');
      expect(restored.type, GitEntryType.dir);
    });
  });

  group('NormalizedPushEvent serialization', () {
    test('roundtrips through JSON', () {
      final event = NormalizedPushEvent(
        repoOwner: 'user',
        repoName: 'repo',
        repoUrl: 'https://example.com',
        ref: 'refs/heads/main',
        beforeCommit: 'aaa',
        afterCommit: 'bbb',
        changes: [
          const WebhookFileChange(
              path: 'file.txt', action: WebhookFileAction.added),
        ],
        timestamp: DateTime.utc(2025, 6, 1),
      );
      final restored = NormalizedPushEvent.fromJson(event.toJson());
      expect(restored.repoOwner, 'user');
      expect(restored.changes, hasLength(1));
      expect(restored.changes[0].action, WebhookFileAction.added);
    });
  });
}
