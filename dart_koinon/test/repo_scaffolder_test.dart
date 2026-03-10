import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:test/test.dart';

/// Simple mock of IGitClient that records calls.
class MockGitClient implements IGitClient {
  final List<_CommitCall> commits = [];
  bool repoCreated = false;

  @override
  Future<GitRepo> createRepo({
    required String name,
    String? description,
    bool private = false,
  }) async {
    repoCreated = true;
    return GitRepo(
      id: 1,
      name: name,
      owner: 'testuser',
      cloneUrl: 'https://forgejo.example.com/testuser/$name.git',
      htmlUrl: 'https://forgejo.example.com/testuser/$name',
      description: description,
    );
  }

  @override
  Future<GitCommit> commitFile({
    required String owner,
    required String repo,
    required String path,
    required String content,
    required String message,
    String? sha,
    String? branch,
  }) async {
    commits.add(_CommitCall(owner, repo, path, content, message));
    return GitCommit(
      sha: 'sha-${commits.length}',
      message: message,
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<void> deleteRepo(
      {required String owner, required String repo}) async {}

  @override
  Future<GitFile> readFile(
      {required String owner,
      required String repo,
      required String path,
      String? ref}) async {
    throw GitNotFoundException('not found');
  }

  @override
  Future<List<GitDirectoryEntry>> listFiles(
      {required String owner,
      required String repo,
      required String path,
      String? ref}) async {
    return [];
  }

  @override
  Future<void> deleteFile(
      {required String owner,
      required String repo,
      required String path,
      required String sha,
      required String message,
      String? branch}) async {}

  @override
  Future<bool> exists(
      {required String owner,
      required String repo,
      required String path,
      String? ref}) async {
    return false;
  }

  @override
  Future<GitRepo> forkRepo({
    required String owner,
    required String repo,
  }) async {
    throw UnimplementedError();
  }
}

class _CommitCall {
  final String owner;
  final String repo;
  final String path;
  final String content;
  final String message;

  _CommitCall(this.owner, this.repo, this.path, this.content, this.message);
}

void main() {
  test('scaffolds repo with correct structure', () async {
    final mock = MockGitClient();
    final scaffolder = RepoScaffolder(mock);

    final repo = await scaffolder.scaffold(
      repoName: 'my-repo',
      pubkey: 'my-pubkey-hex',
      repoHttps: 'https://forgejo.example.com/testuser/my-repo',
    );

    expect(repo.name, 'my-repo');
    expect(mock.repoCreated, isTrue);
    expect(mock.commits, hasLength(5));

    // Check koinon.json
    final manifestCall =
        mock.commits.firstWhere((c) => c.path == '.well-known/koinon.json');
    final manifest =
        jsonDecode(manifestCall.content) as Map<String, dynamic>;
    expect(manifest['protocol'], 'koinon');
    expect(manifest['pubkey'], 'my-pubkey-hex');
    expect(manifest['repo_https'],
        'https://forgejo.example.com/testuser/my-repo');

    // Check pubkey.json
    final pubkeyCall =
        mock.commits.firstWhere((c) => c.path == 'identity/pubkey.json');
    final pubkey = jsonDecode(pubkeyCall.content) as Map<String, dynamic>;
    expect(pubkey['pubkey'], 'my-pubkey-hex');

    // Check directory scaffolding
    final paths = mock.commits.map((c) => c.path).toList();
    expect(paths, contains('trust/.gitkeep'));
    expect(paths, contains('poleis/.gitkeep'));
    expect(paths, contains('posts/.gitkeep'));
  });
}
