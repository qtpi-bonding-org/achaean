import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  const baseUrl = 'https://forgejo.example.com';
  final auth = GitTokenAuth('test-token');

  ForgejoClient createClient(
      http.Response Function(http.Request) handler) {
    return ForgejoClient(
      baseUrl: baseUrl,
      auth: auth,
      httpClient: MockClient((req) async => handler(req)),
    );
  }

  group('createRepo', () {
    test('returns GitRepo on 201', () async {
      final client = createClient((req) {
        expect(req.method, 'POST');
        expect(req.url.path, '/api/v1/user/repos');
        expect(req.headers['Authorization'], 'token test-token');
        return http.Response(
          jsonEncode({
            'id': 42,
            'name': 'my-repo',
            'owner': {'login': 'testuser'},
            'clone_url': 'https://forgejo.example.com/testuser/my-repo.git',
            'html_url': 'https://forgejo.example.com/testuser/my-repo',
            'description': 'A test repo',
            'private': false,
          }),
          201,
        );
      });

      final repo = await client.createRepo(name: 'my-repo', description: 'A test repo');
      expect(repo.id, 42);
      expect(repo.name, 'my-repo');
      expect(repo.owner, 'testuser');
    });

    test('throws GitUnauthorizedException on 401', () async {
      final client = createClient((_) => http.Response('', 401));
      expect(
        () => client.createRepo(name: 'x'),
        throwsA(isA<GitUnauthorizedException>()),
      );
    });
  });

  group('commitFile', () {
    test('creates new file on POST (no sha)', () async {
      final client = createClient((req) {
        expect(req.method, 'POST');
        expect(req.url.path, '/api/v1/repos/owner/repo/contents/test.txt');
        final body = jsonDecode(req.body) as Map<String, dynamic>;
        expect(body['content'], base64Encode(utf8.encode('hello')));
        expect(body.containsKey('sha'), false);
        return http.Response(
          jsonEncode({
            'commit': {
              'sha': 'abc123',
              'message': 'add file',
              'author': {'date': '2025-01-01T00:00:00Z'},
            },
          }),
          201,
        );
      });

      final commit = await client.commitFile(
        owner: 'owner',
        repo: 'repo',
        path: 'test.txt',
        content: 'hello',
        message: 'add file',
      );
      expect(commit.sha, 'abc123');
      expect(commit.message, 'add file');
    });

    test('updates existing file on PUT (with sha)', () async {
      final client = createClient((req) {
        expect(req.method, 'PUT');
        final body = jsonDecode(req.body) as Map<String, dynamic>;
        expect(body['sha'], 'oldsha');
        return http.Response(
          jsonEncode({
            'commit': {
              'sha': 'newsha',
              'message': 'update',
              'author': {'date': '2025-01-01T00:00:00Z'},
            },
          }),
          200,
        );
      });

      final commit = await client.commitFile(
        owner: 'owner',
        repo: 'repo',
        path: 'test.txt',
        content: 'updated',
        message: 'update',
        sha: 'oldsha',
      );
      expect(commit.sha, 'newsha');
    });
  });

  group('readFile', () {
    test('decodes base64 content', () async {
      final client = createClient((req) {
        expect(req.method, 'GET');
        return http.Response(
          jsonEncode({
            'path': 'README.md',
            'content': base64Encode(utf8.encode('# Hello')),
            'sha': 'filesha',
          }),
          200,
        );
      });

      final file = await client.readFile(
        owner: 'owner', repo: 'repo', path: 'README.md');
      expect(file.content, '# Hello');
      expect(file.sha, 'filesha');
    });

    test('throws GitNotFoundException on 404', () async {
      final client = createClient((_) => http.Response('', 404));
      expect(
        () => client.readFile(owner: 'o', repo: 'r', path: 'x'),
        throwsA(isA<GitNotFoundException>()),
      );
    });
  });

  group('listFiles', () {
    test('returns directory entries', () async {
      final client = createClient((req) {
        return http.Response(
          jsonEncode([
            {'name': 'README.md', 'path': 'README.md', 'type': 'file'},
            {'name': 'src', 'path': 'src', 'type': 'dir'},
          ]),
          200,
        );
      });

      final entries = await client.listFiles(
        owner: 'owner', repo: 'repo', path: '');
      expect(entries, hasLength(2));
      expect(entries[0].type, GitEntryType.file);
      expect(entries[1].type, GitEntryType.dir);
    });
  });

  group('deleteFile', () {
    test('succeeds on 200', () async {
      final client = createClient((req) {
        expect(req.method, 'DELETE');
        final body = jsonDecode(req.body) as Map<String, dynamic>;
        expect(body['sha'], 'filesha');
        return http.Response('', 200);
      });

      await client.deleteFile(
        owner: 'owner',
        repo: 'repo',
        path: 'old.txt',
        sha: 'filesha',
        message: 'remove old file',
      );
    });
  });

  group('exists', () {
    test('returns true on 200', () async {
      final client = createClient((_) => http.Response('{}', 200));
      expect(
        await client.exists(owner: 'o', repo: 'r', path: 'f'),
        isTrue,
      );
    });

    test('returns false on 404', () async {
      final client = createClient((_) => http.Response('', 404));
      expect(
        await client.exists(owner: 'o', repo: 'r', path: 'f'),
        isFalse,
      );
    });
  });

  group('forkRepo', () {
    test('returns GitRepo on 202', () async {
      final client = createClient((req) {
        expect(req.method, 'POST');
        expect(req.url.path, '/api/v1/repos/origOwner/origRepo/forks');
        return http.Response(
          jsonEncode({
            'id': 99,
            'name': 'origRepo',
            'owner': {'login': 'myuser'},
            'clone_url': 'https://forgejo.example.com/myuser/origRepo.git',
            'html_url': 'https://forgejo.example.com/myuser/origRepo',
            'description': 'Forked repo',
            'private': false,
          }),
          202,
        );
      });

      final repo = await client.forkRepo(owner: 'origOwner', repo: 'origRepo');
      expect(repo.id, 99);
      expect(repo.name, 'origRepo');
      expect(repo.owner, 'myuser');
    });

    test('throws GitNotFoundException on 404', () async {
      final client = createClient((_) => http.Response('', 404));
      expect(
        () => client.forkRepo(owner: 'x', repo: 'y'),
        throwsA(isA<GitNotFoundException>()),
      );
    });
  });

  group('deleteRepo', () {
    test('succeeds on 204', () async {
      final client = createClient((req) {
        expect(req.method, 'DELETE');
        expect(req.url.path, '/api/v1/repos/owner/repo');
        return http.Response('', 204);
      });

      await client.deleteRepo(owner: 'owner', repo: 'repo');
    });
  });
}
