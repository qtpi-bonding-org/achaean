import 'package:dart_git/dart_git.dart';
import 'package:test/test.dart';

void main() {
  const parser = ForgejoWebhookParser();

  test('parses push event with file changes', () {
    final event = parser.parsePush({
      'ref': 'refs/heads/main',
      'before': 'aaa',
      'after': 'bbb',
      'repository': {
        'name': 'my-repo',
        'html_url': 'https://forgejo.example.com/user/my-repo',
        'owner': {'login': 'user'},
      },
      'commits': [
        {
          'added': ['new.txt'],
          'modified': ['existing.txt'],
          'removed': ['old.txt'],
        },
        {
          'added': ['another.txt'],
          'modified': [],
          'removed': [],
        },
      ],
    });

    expect(event, isNotNull);
    expect(event!.repoOwner, 'user');
    expect(event.repoName, 'my-repo');
    expect(event.ref, 'refs/heads/main');
    expect(event.beforeCommit, 'aaa');
    expect(event.afterCommit, 'bbb');
    expect(event.changes, hasLength(4));
    expect(event.changes[0].path, 'new.txt');
    expect(event.changes[0].action, WebhookFileAction.added);
    expect(event.changes[2].action, WebhookFileAction.removed);
  });

  test('returns null when repository is missing', () {
    expect(parser.parsePush({}), isNull);
  });

  test('returns null when owner is missing', () {
    expect(
      parser.parsePush({
        'repository': {'name': 'x', 'html_url': 'x'},
      }),
      isNull,
    );
  });

  test('handles username field as fallback for owner', () {
    final event = parser.parsePush({
      'ref': 'refs/heads/main',
      'before': 'a',
      'after': 'b',
      'repository': {
        'name': 'repo',
        'html_url': 'https://example.com/repo',
        'owner': {'username': 'fallback-user'},
      },
      'commits': [],
    });

    expect(event!.repoOwner, 'fallback-user');
  });
}
